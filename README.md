# RaviShop AI Infra

Infrastructure as Code for the RaviShop AI 2026 platform. Terraform provisions the AWS network, compute, database and IAM; Ansible configures the server and deploys the app container.

Part of the RaviShop AI 2026 project:

| Repo | Purpose |
|------|---------|
| [ravishop-ai-app](https://github.com/Ravisahu7079/ravishop-ai-app) | Flask API, AI agent, Dockerfile, CI/CD pipeline |
| ravishop-ai-infra (this repo) | Terraform and Ansible |
| [ravishop-ai-k8s](https://github.com/Ravisahu7079/ravishop-ai-k8s) | Kubernetes manifests, Argo CD config, monitoring config |

## What it builds

- **VPC** with public subnets and networking (`modules/vpc`)
- **EC2** instance (`modules/ec2`); user data installs Docker, Node Exporter (as a systemd service) and the CloudWatch agent
- **RDS** database (`modules/rds`)
- **IAM** roles and policies (`modules/iam`)

## Structure

```
.
├── main.tf          # root module, wires the modules together
├── variables.tf     # input variables
├── outputs.tf       # outputs (instance IP, endpoints, etc.)
├── modules/
│   ├── vpc/
│   ├── ec2/
│   ├── rds/
│   └── iam/
└── ansible/         # roles: docker, app
```

## Usage

Create a `terraform.tfvars` file (gitignored, never commit it) with the values required by `variables.tf`, includeing the database password.


Then:

```bash
terraform init
terraform plan
terraform apply
```

Configure the server and deploy the app with Ansible (from the `ansible/` folder). Secrets go in `ansible/vars/secrets.yml`, which is gitignored.

Tear everything down when finished to avoid cost:

```bash
terraform destroy
```

## Security notes

- `terraform.tfvars`, `*.tfstate` and `ansible/vars/secrets.yml` are gitignored.
- Terraform state can contain secrets. For real projects, use a remote encrypted backend (for example S3 with locking) instead of local state.
- Checkov scans this IaC in the CI pipeline of the app repo.

## Project status

All resources from the live deployment have been destroyed to avoid cost. The stack can be recreated with `terraform apply`.

## Author

Ravi Sahu, [@Ravisahu7079](https://github.com/Ravisahu7079)
