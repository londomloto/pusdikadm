<?php
namespace App\Bpmn\Controllers;

use App\Bpmn\Models\Diagram;

class DiagramsController extends \Micro\Controller {
    
    public function findAction() {
        $query = Diagram::get();

        $q = $this->request->getQuery('query');

        if ( ! empty($q)) {
            $query->where('name LIKE :q:', array('q' => '%'.$q.'%'));
        }

        return $query
            ->orderBy('created_date DESC')
            ->paginate();
    }

    public function findByIdAction($id) {
        return Diagram::get($id);
    }

    public function expandAction($id) {
        return Diagram::expand($id);
    }

    public function storeAction() {
        $post = $this->request->getJson();
        return Diagram::store($post);
    }
    
    public function createAction() {
        $post = $this->request->getJson();

        $diagram = new Diagram();
        $post['created_date'] = date('Y-m-d H:i:s');
        $diagram->save($post);

        return array(
            'success' => TRUE,
            'data' => $diagram
        );
    }

    public function updateAction($id) {
        $query = Diagram::get($id);
        $data = $this->request->getJson();

        if ($query->data) {
            $query->data->save($data);
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Diagram::get($id);

        if ($query->data) {
            // delete cover first
            if ( ! empty($query->data->cover) && ($query->data->cover != Diagram::DEFAULT_COVER)) {
                $cover = PUBPATH.'resources/diagrams/'.$query->data->cover;
                if (file_exists($cover)) {
                    @unlink($cover);
                }
            }

            if ($query->data->delete()) {
                return array(
                    'success' => TRUE
                );
            }
        }
        
        return array(
            'success' => FALSE
        );
    }

    public function uploadAction($id) {
        $query = Diagram::get($id);

        if ($query->data) {
            foreach($this->request->getFiles() as $file) {
                $name = md5($query->data->slug.date('YmdHis')).'.jpg';
                $path = PUBPATH.'resources/diagrams/'.$name;
                if (@$file->moveTo($path)) {

                    if ($query->data->cover != Diagram::DEFAULT_COVER) {
                        @unlink(PUBPATH.'resources/diagrams/'.$query->data->cover);
                    }

                    $query->data->save(array(
                        'cover' => $name
                    ));
                }
                break;
            }
        }
        return Diagram::expand($id);
    }

    public function sourceAction() {
        $post = $this->request->getJson();

        if (isset($post['sql']) && ! empty($post['sql'])) {
            $sql = $post['sql'];
            if (preg_match('/SELECT\s(.*)\sFROM/', $post['sql'], $matches)) {
                $columns = trim($matches[1]);
                if ($columns == '*') {
                    
                } else {

                }
            }
        }
    }
}