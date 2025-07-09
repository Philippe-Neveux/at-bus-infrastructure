# Terraform GCP Airflow Server

This Terraform project provisions a Google Cloud Compute Engine VM and a static external IP address, intended for hosting an Airflow server.

## Prerequisites

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed (`brew install terraform` on macOS).
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and authenticated.
- An existing Google Cloud project with the Compute Engine API enabled.

## Setup

1.  **Clone the repository (or download the files).**

2.  **(Optional) Create a `terraform.tfvars` file:**

    The project is configured with sensible defaults, using `at-bus` as the project ID. If you need to override these defaults (e.g., to use a different project ID), create a file named `terraform.tfvars` and add your values there.

    Example `terraform.tfvars`:

    ```hcl
    project_id = "your-other-gcp-project-id"
    region     = "australia-southeast1"
    zone       = "australia-southeast1-a"
    ```

## Usage

1.  **Initialize Terraform:**

    This command downloads the necessary provider plugins.

    ```sh
    make tf-init
    # or
    terraform init
    ```

2.  **Plan the deployment:**

    Review the resources that Terraform will create.

    ```sh
    make tf-plan
    # or
    terraform plan
    ```

3.  **Apply the configuration:**

    This command will create the VM and static IP.

    ```sh
    make tf-apply
    # or
    terraform apply
    ```

    Terraform will ask for confirmation. Type `yes` to proceed.

4.  **Destroy the resources:**

    When you no longer need the resources, you can destroy them to avoid incurring further charges:

    ```sh
    terraform destroy
    ```


