variable "task_family" {

}

variable "task_name" {

}

variable "task_image" {

}

variable "task_cpu" {
  type    = number
  default = 10
}

variable "task_memory" {
  type    = number
  default = 128
}

variable "task_port_mappings" {
  type = list(object({
    containerPort = number
    hostPort      = number
  }))
}

variable "runtime_platform" {
  type = object({
    operating_system_family = string
    cpu_architecture = string
  })
  default = {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
}

variable "network_configuration" {
  type = object({
    subnets = list(string)
    security_groups = list(string)
    assign_public_ip = bool
  })
}

variable "task_healthcheck" {
  type    = object({
    command = list(string)
    interval = number
    retries = number
    startPeriod = number
    timeout = number
  })
  default = {
    command = ["CMD-SHELL", "echo 'healthy' || exit 1"]
    interval = 30
    retries = 3
    startPeriod = 30
    timeout = 5
  }
}

variable "environment_variables" {
  type = list(map(any))
}

variable "service_name" {

}

variable "cluster_arn" {

}

variable "desired_count" {

}

variable "service_capacity_provider" {
  type = string
}

variable "service_capacity_provider_base" {
  type    = number
  default = 0
}

variable "service_capacity_provider_weight" {
  type    = number
  default = 1
}

variable "tags" {
  type = map(any)
}

variable "service_wait_for_steady_state" {
  type = bool
  default = false
}