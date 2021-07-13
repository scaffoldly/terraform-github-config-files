[![Maintained by Scaffoldly](https://img.shields.io/badge/maintained%20by-scaffoldly-blueviolet)](https://github.com/scaffoldly)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/scaffoldly/terraform-github-config-files)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.15.0-blue.svg)

## Description

Writes config files to `./scaffoldly` for all services in all environments to the repo for the service.

## Usage

```hcl
module "github_config_files_serverless_apis" {
  source = "scaffoldly/config-files/github"

  for_each = local.serverless_apis

  organization    = var.organization
  repository_name = module.serverless_api[each.key].repository_name
  service_name    = module.serverless_api[each.key].service_name
  stages          = keys(var.stages)
  services        = zipmap(values(module.serverless_api)[*].service_name, values(module.serverless_api)[*].stage_config)
  stage_env_vars  = module.serverless_api[each.key].stage_env_vars
  shared_env_vars = var.shared_env_vars

  stage_domains = module.dns.stage_domains

  depends_on = [
    module.public_website,
    module.serverless_api
  ]
}

module "github_config_files_public_websites" {
  source = "scaffoldly/config-files/github"

  for_each = var.public_websites

  organization    = var.organization
  repository_name = module.public_website[each.key].repository_name
  service_name    = module.public_website[each.key].service_name
  stages          = keys(var.stages)
  services        = zipmap(values(module.serverless_api)[*].service_name, values(module.serverless_api)[*].stage_config)
  stage_env_vars  = module.public_website[each.key].stage_env_vars
  shared_env_vars = var.shared_env_vars

  stage_domains = module.dns.stage_domains

  depends_on = [
    module.public_website,
    module.serverless_api
  ]
}
```

<!-- BEGIN_TF_DOCS -->

## Requirements

## Providers

## Modules

## Resources

## Inputs

## Outputs

<!-- END_TF_DOCS -->
