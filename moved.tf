moved {
  from = module.repository["TerraformCloud-ModulesRegistry"].github_branch_protection.this["main"]
  to   = module.git_repository["TerraformCloud-ModulesRegistry"].github_branch_protection.this["main"]
}

moved {
  from = module.repository["TerraformCloud-ModulesRegistry"].github_repository.this
  to   = module.git_repository["TerraformCloud-ModulesRegistry"].github_repository.this
}

moved {
  from = module.repository["TerraformCloud-Policies"].github_branch_protection.this["main"]
  to   = module.git_repository["TerraformCloud-Policies"].github_branch_protection.this["main"]
}

moved {
  from = module.repository["TerraformCloud-Policies"].github_repository.this
  to   = module.git_repository["TerraformCloud-Policies"].github_repository.this
}

moved {
  from = module.github_teams["terraformcloud-modulesregistry-contributor"].github_team_repository.this[0]
  to   = module.git_teams["terraformcloud-modulesregistry-contributor"].github_team_repository.this[0]
}

moved {
  from = module.github_teams["terraformcloud-modulesregistry-contributor"].github_team.this
  to   = module.git_teams["terraformcloud-modulesregistry-contributor"].github_team.this
}

moved {
  from = module.github_teams["terraformcloud-policies-contributor"].github_team_repository.this[0]
  to   = module.git_teams["terraformcloud-policies-contributor"].github_team_repository.this[0]
}

moved {
  from = module.github_teams["terraformcloud-policies-contributor"].github_team.this
  to   = module.git_teams["terraformcloud-policies-contributor"].github_team.this
}

moved {
  from = module.notifications["TerraformCloud-ModulesRegistry microsoft teams"].tfe_notification_configuration.this
  to   = module.tfe_notifications["TerraformCloud-ModulesRegistry microsoft teams"].tfe_notification_configuration.this
}

moved {
  from = module.notifications["TerraformCloud-Policies microsoft teams"].tfe_notification_configuration.this
  to   = module.tfe_notifications["TerraformCloud-Policies microsoft teams"].tfe_notification_configuration.this
}

moved {
  from = module.teams["admins"].tfe_team_token.this[0]
  to   = module.tfe_teams["admins"].tfe_team_token.this[0]
}

moved {
  from = module.teams["admins"].tfe_team.this
  to   = module.tfe_teams["admins"].tfe_team.this
}

moved {
  from = module.teams["terraformcloud-modulesregistry-manage-modules"].tfe_team_access.this[0]
  to   = module.tfe_teams["terraformcloud-modulesregistry-manage-modules"].tfe_team_access.this[0]
}

moved {
  from = module.teams["terraformcloud-modulesregistry-manage-modules"].tfe_team_token.this[0]
  to   = module.tfe_teams["terraformcloud-modulesregistry-manage-modules"].tfe_team_token.this[0]
}

moved {
  from = module.teams["terraformcloud-modulesregistry-manage-modules"].tfe_team.this
  to   = module.tfe_teams["terraformcloud-modulesregistry-manage-modules"].tfe_team.this
}

moved {
  from = module.teams["terraformcloud-policies-manage-policies"].tfe_team_access.this[0]
  to   = module.tfe_teams["terraformcloud-policies-manage-policies"].tfe_team_access.this[0]
}

moved {
  from = module.teams["terraformcloud-policies-manage-policies"].tfe_team_token.this[0]
  to   = module.tfe_teams["terraformcloud-policies-manage-policies"].tfe_team_token.this[0]
}

moved {
  from = module.teams["terraformcloud-policies-manage-policies"].tfe_team.this
  to   = module.tfe_teams["terraformcloud-policies-manage-policies"].tfe_team.this
}

moved {
  from = module.workspaces["TerraformCloud-ModulesRegistry"].tfe_workspace.this
  to   = module.tfe_workspaces["TerraformCloud-ModulesRegistry"].tfe_workspace.this
}

moved {
  from = module.workspaces["TerraformCloud-Policies"].tfe_workspace.this
  to   = module.tfe_workspaces["TerraformCloud-Policies"].tfe_workspace.this
}
