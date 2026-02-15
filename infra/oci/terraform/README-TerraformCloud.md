# Terraform Cloud backend — usage notes

This repository includes an example `backend.tf` to use Terraform Cloud (TFC)
as the remote backend for the `infra/oci/terraform` module. The example is
minimal and uses placeholders — you must update it with your organization
and workspace names before running `terraform init`.

Quick steps
- Create a workspace in Terraform Cloud (or choose an existing one).
- Replace `YOUR_TFC_ORG` and the `workspaces.name` value in `backend.tf`.
- Authenticate the runner or local machine:

  - Interactive: run `terraform login` and follow the prompt.
  - CI: set the environment variable `TF_TOKEN_app_terraform_io` to a
    Terraform Cloud API token (recommended scoped token).

- Initialize the working directory:

```bash
cd infra/oci/terraform
terraform init
terraform plan
terraform apply
```

Notes for GitHub Actions
- In CI, set the secret `TF_TOKEN_app_terraform_io` (in repo settings) to a
  Terraform Cloud API token and ensure the workflow exposes it to the job.
- With the remote backend in place, Terraform state is stored in Terraform
  Cloud — repeated runs will use the same state and will not create duplicate
  resources.

Security
- Keep the TFC API token secret and do not commit it to the repository.
