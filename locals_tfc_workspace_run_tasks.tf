locals {

  # The following locals use logic to determine determine the required run tasks.
  tfc_workspace_run_tasks = flatten([for workspace in local.tfc_workspaces :
    flatten([for run_task in workspace.run_tasks :
      run_task.name
    ]) if try(workspace.run_tasks, null) != null
  ])

  # The following locals is used to concat the default run tasks with every run tasks assign to a specefic workspace.
  tfc_run_tasks = concat([for value in local.local.tfc_default_run_tasks : value.name], local.tfc_workspace_run_tasks)

}