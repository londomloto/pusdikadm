<?php
return array(
	'modules' => array(
		'/activities' => 'App\Activities\Controllers\ActivitiesController',
		'/assets' => 'App\Assets\Controllers\AssetsController',
		'/auth' => 'App\Auth\Controllers\AuthController',
		'/bpmn' => 'App\Bpmn\Controllers\BpmnController',
		'/bpmn/diagrams' => 'App\Bpmn\Controllers\DiagramsController',
		'/bpmn/forms' => 'App\Bpmn\Controllers\FormsController',
		'/bpmn/forms-roles' => 'App\Bpmn\Controllers\FormsRolesController',
		'/bpmn/forms-users' => 'App\Bpmn\Controllers\FormsUsersController',
		'/bpmn/generator' => 'App\Bpmn\Controllers\GeneratorController',
		'/categories' => 'App\Categories\Controllers\CategoriesController',
		'/classifications' => 'App\Classifications\Controllers\ClassificationsController',
		'/company' => 'App\Company\Controllers\CompanyController',
		'/config' => 'App\Config\Controllers\ConfigController',
		'/dashboard/assignment' => 'App\Dashboard\Controllers\AssignmentController',
		'/dashboard/creation' => 'App\Dashboard\Controllers\CreationController',
		'/dashboard' => 'App\Dashboard\Controllers\DashboardController',
		'/dashboard/statuses' => 'App\Dashboard\Controllers\StatusesController',
		'/datagrid' => 'App\Datagrid\Controllers\DatagridController',
		'/departments' => 'App\Departments\Controllers\DepartmentsController',
		'/dispositions' => 'App\Dispositions\Controllers\DispositionsController',
		'/dx' => 'App\Dx\Controllers\DxController',
		'/dx/dx-mapping' => 'App\Dx\Controllers\DxMappingController',
		'/dx/dx-profile' => 'App\Dx\Controllers\DxProfileController',
		'/dx/mapping' => 'App\Dx\Controllers\MappingController',
		'/dx/profiles' => 'App\Dx\Controllers\ProfilesController',
		'/grades' => 'App\Grades\Controllers\GradesController',
		'/home' => 'App\Home\Controllers\HomeController',
		'/instructions' => 'App\Instructions\Controllers\InstructionsController',
		'/jobs' => 'App\Jobs\Controllers\JobsController',
		'/kanban/kanban-forms' => 'App\Kanban\Controllers\KanbanFormsController',
		'/kanban/kanban-panels' => 'App\Kanban\Controllers\KanbanPanelsController',
		'/kanban/kanban-settings' => 'App\Kanban\Controllers\KanbanSettingsController',
		'/kanban/kanban-statuses' => 'App\Kanban\Controllers\KanbanStatusesController',
		'/kanban/kanban-workspaces' => 'App\Kanban\Controllers\KanbanWorkspacesController',
		'/labels' => 'App\Labels\Controllers\LabelsController',
		'/menus' => 'App\Menus\Controllers\MenusController',
		'/messages/inbox' => 'App\Messages\Controllers\InboxController',
		'/messages/outbox' => 'App\Messages\Controllers\OutboxController',
		'/modules/capabilities' => 'App\Modules\Controllers\CapabilitiesController',
		'/modules/modules-capabilities' => 'App\Modules\Controllers\ModulesCapabilitiesController',
		'/modules' => 'App\Modules\Controllers\ModulesController',
		'/notifications' => 'App\Notifications\Controllers\NotificationsController',
		'/priorities' => 'App\Priorities\Controllers\PrioritiesController',
		'/profile' => 'App\Profile\Controllers\ProfileController',
		'/projects' => 'App\Projects\Controllers\ProjectsController',
		'/projects/projects-users' => 'App\Projects\Controllers\ProjectsUsersController',
		'/roles' => 'App\Roles\Controllers\RolesController',
		'/roles/roles-kanban' => 'App\Roles\Controllers\RolesKanbanController',
		'/roles/roles-menus' => 'App\Roles\Controllers\RolesMenusController',
		'/roles/roles-panels' => 'App\Roles\Controllers\RolesPanelsController',
		'/roles/roles-permissions' => 'App\Roles\Controllers\RolesPermissionsController',
		'/secrecy' => 'App\Secrecy\Controllers\SecrecyController',
		'/shipments' => 'App\Shipments\Controllers\ShipmentsController',
		'/surat-keluar/kanban' => 'App\SuratKeluar\Controllers\KanbanController',
		'/surat-keluar/print' => 'App\SuratKeluar\Controllers\PrintController',
		'/surat-keluar' => 'App\SuratKeluar\Controllers\SuratKeluarController',
		'/surat-keluar/surat-keluar-exams' => 'App\SuratKeluar\Controllers\SuratKeluarExamsController',
		'/surat-keluar/surat-keluar-files' => 'App\SuratKeluar\Controllers\SuratKeluarFilesController',
		'/surat-masuk/dashboard' => 'App\SuratMasuk\Controllers\DashboardController',
		'/surat-masuk/dispositions' => 'App\SuratMasuk\Controllers\DispositionsController',
		'/surat-masuk/distributions' => 'App\SuratMasuk\Controllers\DistributionsController',
		'/surat-masuk/grid' => 'App\SuratMasuk\Controllers\GridController',
		'/surat-masuk/kanban' => 'App\SuratMasuk\Controllers\KanbanController',
		'/surat-masuk/live' => 'App\SuratMasuk\Controllers\LiveController',
		'/surat-masuk/print' => 'App\SuratMasuk\Controllers\PrintController',
		'/surat-masuk/statistic' => 'App\SuratMasuk\Controllers\StatisticController',
		'/surat-masuk' => 'App\SuratMasuk\Controllers\SuratMasukController',
		'/surat-masuk/surat-masuk-files' => 'App\SuratMasuk\Controllers\SuratMasukFilesController',
		'/system/autonumber' => 'App\System\Controllers\AutonumberController',
		'/system/constants' => 'App\System\Controllers\ConstantsController',
		'/system' => 'App\System\Controllers\SystemController',
		'/tasks/tasks-activities' => 'App\Tasks\Controllers\TasksActivitiesController',
		'/tasks' => 'App\Tasks\Controllers\TasksController',
		'/users/users-accesses' => 'App\Users\Controllers\UsersAccessesController',
		'/users' => 'App\Users\Controllers\UsersController',
		'/users/users-kanban' => 'App\Users\Controllers\UsersKanbanController',
		'/users/users-menus' => 'App\Users\Controllers\UsersMenusController',
		'/users/users-panels' => 'App\Users\Controllers\UsersPanelsController',
		'/users/users-permissions' => 'App\Users\Controllers\UsersPermissionsController',
		'/worksheet/grid' => 'App\Worksheet\Controllers\GridController',
		'/worksheet/kanban' => 'App\Worksheet\Controllers\KanbanController',
	),
	'namespaces' => array(
		'App\Activities\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Activities/Controllers/',
		'App\Activities\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Activities/Interfaces/',
		'App\Activities\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Activities/Models/',
		'App\Assets\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Assets/Controllers/',
		'App\Assets\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Assets/Interfaces/',
		'App\Assets\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Assets/Models/',
		'App\Auth\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Auth/Controllers/',
		'App\Auth\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Auth/Interfaces/',
		'App\Auth\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Auth/Models/',
		'App\Bpmn\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Bpmn/Controllers/',
		'App\Bpmn\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Bpmn/Interfaces/',
		'App\Bpmn\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Bpmn/Models/',
		'App\Categories\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Categories/Controllers/',
		'App\Categories\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Categories/Interfaces/',
		'App\Categories\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Categories/Models/',
		'App\Classifications\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Classifications/Controllers/',
		'App\Classifications\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Classifications/Interfaces/',
		'App\Classifications\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Classifications/Models/',
		'App\Company\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Company/Controllers/',
		'App\Company\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Company/Interfaces/',
		'App\Company\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Company/Models/',
		'App\Config\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Config/Controllers/',
		'App\Config\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Config/Interfaces/',
		'App\Config\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Config/Models/',
		'App\Dashboard\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Dashboard/Controllers/',
		'App\Dashboard\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Dashboard/Interfaces/',
		'App\Dashboard\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Dashboard/Models/',
		'App\Datagrid\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Datagrid/Controllers/',
		'App\Datagrid\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Datagrid/Interfaces/',
		'App\Datagrid\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Datagrid/Models/',
		'App\Departments\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Departments/Controllers/',
		'App\Departments\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Departments/Interfaces/',
		'App\Departments\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Departments/Models/',
		'App\Dispositions\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Dispositions/Controllers/',
		'App\Dispositions\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Dispositions/Interfaces/',
		'App\Dispositions\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Dispositions/Models/',
		'App\Dx\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Dx/Controllers/',
		'App\Dx\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Dx/Interfaces/',
		'App\Dx\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Dx/Models/',
		'App\Grades\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Grades/Controllers/',
		'App\Grades\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Grades/Interfaces/',
		'App\Grades\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Grades/Models/',
		'App\Home\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Home/Controllers/',
		'App\Home\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Home/Interfaces/',
		'App\Home\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Home/Models/',
		'App\Instructions\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Instructions/Controllers/',
		'App\Instructions\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Instructions/Interfaces/',
		'App\Instructions\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Instructions/Models/',
		'App\Jobs\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Jobs/Controllers/',
		'App\Jobs\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Jobs/Interfaces/',
		'App\Jobs\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Jobs/Models/',
		'App\Kanban\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Kanban/Controllers/',
		'App\Kanban\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Kanban/Interfaces/',
		'App\Kanban\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Kanban/Models/',
		'App\Labels\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Labels/Controllers/',
		'App\Labels\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Labels/Interfaces/',
		'App\Labels\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Labels/Models/',
		'App\Menus\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Menus/Controllers/',
		'App\Menus\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Menus/Interfaces/',
		'App\Menus\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Menus/Models/',
		'App\Messages\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Messages/Controllers/',
		'App\Messages\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Messages/Interfaces/',
		'App\Messages\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Messages/Models/',
		'App\Modules\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Modules/Controllers/',
		'App\Modules\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Modules/Interfaces/',
		'App\Modules\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Modules/Models/',
		'App\Notifications\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Notifications/Controllers/',
		'App\Notifications\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Notifications/Interfaces/',
		'App\Notifications\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Notifications/Models/',
		'App\Priorities\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Priorities/Controllers/',
		'App\Priorities\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Priorities/Interfaces/',
		'App\Priorities\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Priorities/Models/',
		'App\Profile\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Profile/Controllers/',
		'App\Profile\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Profile/Interfaces/',
		'App\Profile\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Profile/Models/',
		'App\Projects\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Projects/Controllers/',
		'App\Projects\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Projects/Interfaces/',
		'App\Projects\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Projects/Models/',
		'App\Roles\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Roles/Controllers/',
		'App\Roles\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Roles/Interfaces/',
		'App\Roles\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Roles/Models/',
		'App\Secrecy\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Secrecy/Controllers/',
		'App\Secrecy\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Secrecy/Interfaces/',
		'App\Secrecy\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Secrecy/Models/',
		'App\Shipments\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Shipments/Controllers/',
		'App\Shipments\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Shipments/Interfaces/',
		'App\Shipments\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Shipments/Models/',
		'App\SuratKeluar\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/SuratKeluar/Controllers/',
		'App\SuratKeluar\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/SuratKeluar/Interfaces/',
		'App\SuratKeluar\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/SuratKeluar/Models/',
		'App\SuratMasuk\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/SuratMasuk/Controllers/',
		'App\SuratMasuk\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/SuratMasuk/Interfaces/',
		'App\SuratMasuk\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/SuratMasuk/Models/',
		'App\System\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/System/Controllers/',
		'App\System\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/System/Interfaces/',
		'App\System\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/System/Models/',
		'App\Tasks\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Tasks/Controllers/',
		'App\Tasks\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Tasks/Interfaces/',
		'App\Tasks\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Tasks/Models/',
		'App\Users\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Users/Controllers/',
		'App\Users\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Users/Interfaces/',
		'App\Users\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Users/Models/',
		'App\Worksheet\Controllers' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Worksheet/Controllers/',
		'App\Worksheet\Interfaces' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Worksheet/Interfaces/',
		'App\Worksheet\Models' => 'D:\devel\xampp\xampp-3.2.2\htdocs\pusdikadm\api\v2/app/e-zip/modules/Worksheet/Models/',
	),
);
?>
