lint:
	tflint

tf-init:
	terraform init -upgrade

tf-plan:
	terraform plan -out tfplan

tf-apply:
	terraform apply tfplan