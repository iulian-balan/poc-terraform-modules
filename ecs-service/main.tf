resource "aws_ecs_task_definition" "this" {
  family       = var.task_family
  skip_destroy = true
  network_mode = "bridge"
  requires_compatibilities = ["EC2"]
  tags                              = var.tags

  runtime_platform {
    operating_system_family = var.runtime_platform.operating_system_family
    cpu_architecture = var.runtime_platform.cpu_architecture
  }

  container_definitions = jsonencode([
    {
      name                     = var.task_name
      image                    = var.task_image
      cpu                      = var.task_cpu
      memory                   = var.task_memory
      requires_compatibilities = ["EC2"]
      essential                = true
      environment = var.environment_variables
      mountPoints = []
      portMappings            = var.task_port_mappings
      healthcheck = {
        command = var.task_healthcheck.command
        interval = var.task_healthcheck.interval
        retries  = var.task_healthcheck.retries
        startPeriod = var.task_healthcheck.startPeriod
        timeout = var.task_healthcheck.timeout
      }
    }
  ])
}

resource "aws_ecs_service" "this" {
  name                = var.service_name
  cluster             = var.cluster_arn
  task_definition     = aws_ecs_task_definition.this.arn
  desired_count       = var.desired_count
  scheduling_strategy = "REPLICA"
  deployment_controller {
    type = "ECS"
  }
  tags                              = var.tags
  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 0
  health_check_grace_period_seconds = 0
  propagate_tags                    = "TASK_DEFINITION"
  wait_for_steady_state = var.service_wait_for_steady_state
  capacity_provider_strategy {
    capacity_provider = var.service_capacity_provider
    base              = var.service_capacity_provider_base
    weight            = var.service_capacity_provider_weight
  }
}