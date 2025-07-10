
# 2. Create the service accounts
resource "google_service_account" "this" {
  for_each     = var.service_accounts
  account_id   = each.value.account_id
  display_name = each.value.display_name
}

locals {
  # Flatten the service accounts and their project roles into a single list of objects.
  project_role_bindings = flatten([
    for sa_key, sa in var.service_accounts : [
      for role in sa.project_roles : {
        sa_key = sa_key
        role   = role
      }
    ]
  ])
}

# 3. Grant project roles to service accounts
resource "google_project_iam_member" "project_roles" {
  for_each = { for binding in local.project_role_bindings : "${binding.sa_key}-${binding.role}" => binding }

  project = var.project_id
  role    = each.value.role
  member  = google_service_account.this[each.value.sa_key].member
}

# 4. Create a key for each service account
resource "google_service_account_key" "this" {
  for_each           = google_service_account.this
  service_account_id = each.value.name
}

# 5. Add the service account key as a secret to the GitHub repository
resource "github_actions_secret" "this" {
  for_each        = google_service_account_key.this
  repository      = each.value.name
  secret_name     = "GCP_SA_KEY"
  plaintext_value = base64decode(each.value.private_key)
  depends_on = [
    google_service_account_key.this
  ]
}