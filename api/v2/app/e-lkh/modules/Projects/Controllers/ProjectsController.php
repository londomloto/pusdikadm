<?php
namespace App\Projects\Controllers;

use App\Projects\Models\Project,
	App\Projects\Models\ProjectUser,
	App\Users\Models\User,
	Micro\Helpers\Text;

class ProjectsController extends \Micro\Controller {

	public function findAction() {
		$display = $this->request->getQuery('display');

		switch($display) {
			case 'granted':
				$user = $this->auth->user();
				
				return Project::get()
					->alias('a')
					->columns('a.sp_id') 
					->join('App\Projects\Models\ProjectUser', 'a.sp_id = b.spu_sp_id', 'b')
					->filterable()
					->andWhere(
						'( (b.spu_su_id = :user:) OR (a.sp_creator_id = :user:) OR (a.sp_type = :type:) )', 
						array(
							'user' => $user['su_id'],
							'type' => 'public'
						)
					)
					->groupBy('a.sp_id') 
					->sortable()
					->paginate()
					->map(function($rec){
						$project = Project::get($rec->sp_id)->data;
						return $project->toArray();
					});

			default:
				return Project::get()->filterable()->sortable()->paginate();
		}
	}

	public function loadAction($name) {
		$project = Project::findFirst(array(
			'sp_name = :name:',
			'bind' => array('name' => $name)
		));

		if ($project) {
			return array(
				'success' => TRUE,
				'data' => $project
			);
		}

		return Project::none();
	}

	public function createAction() {
		$post = $this->request->getJson();
		$user = $this->auth->user();

		$post['sp_name'] = Text::slug($post['sp_title']);
		$post['sp_created_date'] = date('Y-m-d H:i:s');
		$post['sp_creator_id'] = $user['su_id'];

		if (empty($post['sp_start_date'])) {
			$post['sp_start_date'] = NULL;
		}

		if (empty($post['sp_end_date'])) {
			$post['sp_end_date'] = NULL;
		}

		// check by title
		$found = Project::find(array(
			'sp_title = :title:',
			'bind' => array(
				'title' => $post['sp_title']
			)
		));

		$count = $found->count();

		if ($count > 0) {
			$post['sp_name'] .= '-'.($count + 1);
		}
		
		$project = new Project();

		if ($project->save($post)) {
			if (isset($post['members'])) {
				
				foreach($post['members'] as $m) {
					$pu = new ProjectUser();
					$pu->spu_sp_id = $project->sp_id;
					$pu->spu_su_id = $m;
					$pu->save();
				}
				
			}
			return Project::get($project->sp_id);
		}

		return Project::none();
	}

	public function updateAction($id) {
		$query = Project::get($id);

		if ($query->data) {
			$data = $query->data;
			$post = $this->request->getJson();

			if (empty($post['sp_start_date'])) {
				$post['sp_start_date'] = NULL;
			}

			if (empty($post['sp_end_date'])) {
				$post['sp_end_date'] = NULL;
			}

			// check name
			$name1 = strtolower(trim($post['sp_title']));
			$name2 = strtolower(trim($data->sp_title));

			if ($name1 != $name2) {
				// title has been changed
				
				$slug = Text::slug($post['sp_title']);

				$found = Project::find(array(
					'sp_title = :title: AND sp_id <> :id:',
					'bind' => array(
						'title' => $post['sp_title'],
						'id' => $data->sp_id
					)
				));

				$count = $found->count();

				if ($count > 0) {
					$slug .= '-'.($count + 1);
				}

				$post['sp_name'] = $slug;
			}

			$data->save($post);
		}

		return $query;
	}

	public function deleteAction($id) {
		$project = Project::get($id)->data;

		if ($project) {
			$project->delete();
		}

		return array(
			'success' => TRUE
		);
	}

	public function addMemberAction($id) {

	}

	public function removeMemberAction($id) {

	}
}