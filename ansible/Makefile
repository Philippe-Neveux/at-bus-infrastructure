deploy-airflow:
	uv run ansible-playbook -i inventory/production.yml playbooks/deploy/airflow.yml

deploy-airflow-files:
	uv run ansible-playbook -i inventory/production.yml playbooks/deploy/airflow.yml --tags files

deploy-airflow-v:
	uv run ansible-playbook -i inventory/production.yml playbooks/deploy/airflow.yml -v

check-syntax-playbooks:
	uv run ansible-playbook --syntax-check -i inventory/production.yml playbooks/deploy/airflow.yml
	uv run ansible-playbook --syntax-check -i inventory/production.yml playbooks/operations/stop-airflow.yml
	uv run ansible-playbook --syntax-check -i inventory/production.yml playbooks/operations/restart-airflow.yml
	uv run ansible-playbook --syntax-check -i inventory/production.yml playbooks/operations/status-airflow.yml

stop-airflow:
	uv run ansible-playbook -i inventory/production.yml playbooks/operations/stop-airflow.yml

stop-airflow-v:
	uv run ansible-playbook -i inventory/production.yml playbooks/operations/stop-airflow.yml -v

restart-airflow:
	uv run ansible-playbook -i inventory/production.yml playbooks/operations/restart-airflow.yml

restart-airflow-v:
	uv run ansible-playbook -i inventory/production.yml playbooks/operations/restart-airflow.yml -v

check-airflow-status:
	uv run ansible-playbook -i inventory/production.yml playbooks/operations/status-airflow.yml

check-airflow-status-v:
	uv run ansible-playbook -i inventory/production.yml playbooks/operations/status-airflow.yml -v

# Docker pull with default image
docker-pull:
	uv run ansible-playbook -i inventory/production.yml playbooks/operations/docker-pull-simple.yml -e "docker_image_name=nginx:latest"

# Docker pull with custom image (usage: make docker-pull-custom IMAGE=postgres:13)
docker-pull-custom:
	uv run ansible-playbook -i inventory/production.yml playbooks/operations/docker-pull.yml -e "docker_image_name=$(IMAGE)"
