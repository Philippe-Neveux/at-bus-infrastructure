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

## Remote State Backend Setup (First-Time Only)

To enable collaboration and allow GitHub Actions to manage the infrastructure, Terraform's state must be stored remotely in a shared location. This project is configured to use a Google Cloud Storage (GCS) bucket as a remote backend.

1.  **Create the GCS Bucket:**

    Run the following command to create the GCS bucket. **Note:** GCS bucket names must be globally unique. If the command fails because the name is already taken, you must choose a new unique name and update it in the `backend.tf` file before running the command again.

    ```sh
    gcloud storage buckets create gs://at-bus-465401-tfstate --project=at-bus-465401 --location=australia-southeast1
    ```

2.  **Initialize Terraform and Migrate State:**

    Once the bucket is created, initialize Terraform. It will detect the new backend configuration and ask you to copy your local state to the GCS bucket.

    ```sh
    terraform init
    ```

    When prompted, type `yes` to approve the state migration.

## Usage

1.  **Initialize Terraform:**

    This command downloads the necessary provider plugins. If you are setting up the project for the first time, follow the "Remote State Backend Setup" instructions first.

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


