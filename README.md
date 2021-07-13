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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 4.9.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 4.9.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_stage_files"></a> [stage\_files](#module\_stage\_files) | scaffoldly/stage-config-files/github | 0.15.1 |
| <a name="module_stage_files_default"></a> [stage\_files\_default](#module\_stage\_files\_default) | scaffoldly/stage-config-files/github | 0.15.1 |

## Resources

| Name | Type |
|------|------|
| [github_repository_file.readme](https://registry.terraform.io/providers/integrations/github/4.9.4/docs/resources/repository_file) | resource |
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/4.9.4/docs/data-sources/repository) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization"></a> [organization](#input\_organization) | The organization name | `string` | n/a | yes |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | The repository name | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The service name | `string` | n/a | yes |
| <a name="input_services"></a> [services](#input\_services) | A map of services+config: Service Name -> Stage -> [key: base\_url\|service\_name\|repo\_nane] = value | `map(map(map(string)))` | n/a | yes |
| <a name="input_shared_env_vars"></a> [shared\_env\_vars](#input\_shared\_env\_vars) | A map of all of the org-wide environment variables | `map(string)` | n/a | yes |
| <a name="input_stage_domains"></a> [stage\_domains](#input\_stage\_domains) | Stage Domains config. Using any so as the variable evolves/changes, everything still gets written | `any` | n/a | yes |
| <a name="input_stage_env_vars"></a> [stage\_env\_vars](#input\_stage\_env\_vars) | A map of environment variables for the stage: Stage -> Name -> Value | `map(map(string))` | n/a | yes |
| <a name="input_stages"></a> [stages](#input\_stages) | The list of available stages | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
