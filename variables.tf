variable "organization" {
  type        = string
  description = "The organization name"
}
variable "repository_name" {
  type        = string
  description = "The repository name"
}
variable "service_name" {
  type        = string
  description = "The service name"
}
variable "stages" {
  type        = list(string)
  description = "The list of available stages"
}
variable "services" {
  type        = map(map(map(string)))
  description = "A map of services+config: Service Name -> Stage -> [key: base_url|service_name|repo_nane] = value"
}
variable "stage_env_vars" {
  type        = map(map(string)) # Stage -> Name -> Value
  description = "A map of environment variables for the stage: Stage -> Name -> Value"
}
variable "shared_env_vars" {
  type        = map(string)
  description = "A map of all of the org-wide environment variables"
}
variable "stage_domains" {
  type        = any
  description = "Stage Domains config. Using any so as the variable evolves/changes, everything still gets written"
}
