# AT Bus Infrastructure

This Terraform project provisions a comprehensive data platform on Google Cloud Platform (GCP). It sets up not just individual components, but a fully integrated environment designed for CI/CD and automated workflows.

At its core, the project automates the creation of GCP resources and seamlessly integrates them with GitHub Actions by provisioning service accounts and injecting their credentials securely into your GitHub repositories.

## Managed Resources

This project manages the following resources:

- **Project APIs:** Enables all necessary GCP APIs.
- **IAM (Identity and Access Management):**
  - Creates dedicated Service Accounts for different parts of the project.
  - Assigns fine-grained IAM roles to each service account.
  - Generates and manages service account keys.
- **GitHub Integration:**
  - Automatically creates GitHub Actions secrets (`GCP_SA_KEY`, `GCP_PROJECT_ID`) for each repository.
  - Automatically creates GitHub Actions variables (`GCP_REGION`, `GCP_REGION_ZONE`) for each repository.
- **Compute Engine:** Provisions a VM and a static external IP address.
- **Cloud Storage:** Creates GCS buckets for various purposes, including a remote backend for Terraform state.
- **BigQuery:** Creates BigQuery datasets.
- **Artifact Registry:** Creates repositories for storing container images and other artifacts.
- **VPC Firewall Rules:** Configures firewall rules for network security.

## Prerequisites

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed (`brew install terraform` on macOS).
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and authenticated.
- A Google Cloud project with billing enabled.
- A [GitHub Personal Access Token (Classic)](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) with the `repo` scope. This is required to allow Terraform to create secrets and variables in your repositories.

## Setup

1.  **Clone the repository.**

2.  **Configure Terraform Variables:**

    Create a file named `terraform.tfvars` to provide the necessary inputs. The most critical variable is `github_token`.

    **`terraform.tfvars` Example:**
    ```hcl
    # Your GitHub Personal Access Token with 'repo' scope.
    # It is strongly recommended to use an environment variable for this sensitive value.
    github_token = "ghp_xxxxxxxxxxxxxxxxxxxx"

    # (Optional) Override the default project ID.
    project_id = "your-gcp-project-id"

    # (Optional) Override other default variables like region, zone, etc.
    region = "australia-southeast1"
    zone   = "australia-southeast1-a"
    ```

    **Security Note:** For sensitive variables like `github_token`, it's best practice to set it as an environment variable instead of saving it to the file:
    ```sh
    export TF_VAR_github_token="ghp_xxxxxxxxxxxxxxxxxxxx"
    ```

## IAM & GitHub Actions Integration

This project's key feature is its ability to automate the setup of CI/CD pipelines. It achieves this by:

1.  **Defining Service Accounts in Code:** The `modules/iam/variables.tf` file contains a `service_accounts` map that defines which service accounts to create, what roles they have, and which GitHub repository they correspond to.
2.  **Generating Keys:** Terraform creates a new service account key for each account.
3.  **Configuring GitHub:** Terraform then uses the provided GitHub token to automatically create the following secrets and variables in the specified repositories:
    - `GCP_SA_KEY`: The JSON key for the service account (base64 encoded).
    - `GCP_PROJECT_ID`: The ID of the GCP project.
    - `GCP_REGION`: The GCP region.
    - `GCP_REGION_ZONE`: The GCP zone.

This allows your GitHub Actions workflows to authenticate with GCP and manage resources without any manual credential configuration.

### Customizing Service Accounts

You can customize the service accounts by modifying the `service_accounts` variable in `modules/iam/variables.tf` or by overriding it in your `terraform.tfvars` file. The structure is as follows:

```hcl
variable "service_accounts" {
  type = map(object({
    account_id    = string       // The ID for the service account
    display_name  = string       // A human-readable name
    project_roles = list(string) // A list of IAM roles to grant
    repository    = string       // The name of the target GitHub repository
  }))
}
```

## Remote State Backend Setup

To enable collaboration and allow GitHub Actions to manage the infrastructure, Terraform's state is stored remotely in a GCS bucket.

1.  **Create the GCS Bucket:**

    Run the following command, ensuring the bucket name is globally unique. If `at-bus-465401-tfstate` is taken, choose a new name and update it in `backend.tf`.

    ```sh
    gcloud storage buckets create gs://at-bus-465401-tfstate --project=$(gcloud config get-value project) --location=australia-southeast1
    ```

2.  **Initialize Terraform:**

    Run `terraform init`. It will detect the backend configuration and prompt you to migrate your state. Type `yes` to approve.

## Usage

Standard Terraform commands are wrapped in a `Makefile` for convenience.

1.  **Initialize Terraform:**
    Downloads provider plugins and configures the remote backend.
    ```sh
    make tf-init
    ```

2.  **Plan the deployment:**
    Review the comprehensive list of resources that Terraform will create or modify.
    ```sh
    make tf-plan
    ```

3.  **Apply the configuration:**
    This will provision all the resources defined in the `.tf` files across GCP and GitHub.
    ```sh
    make tf-apply
    ```

4.  **Destroy the resources:**
    To avoid incurring charges, destroy all managed resources when they are no longer needed.
    ```sh
    make tf-destroy
    ```
