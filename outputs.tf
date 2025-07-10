output "airflow_instance_ip" {
  description = "The external IP address of the Airflow VM instance."
  value       = module.compute.airflow_instance_ip
}

output "superset_instance_ip" {
  description = "The external IP address of the Superset VM instance."
  value       = module.compute.superset_instance_ip
}

