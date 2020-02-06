### Repository structure
```

├── README.md
├── ec2
│   ├── main.tf
│   ├── outputs.tf
│   ├── test-ssh-key
│   │   ├── id_rsa
│   │   └── id_rsa.pub
│   ├── user-init-data.tpl
│   └── variables.tf
├── main.tf
├── networking
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── outputs.tf
├── terraform.tfvars
└── variables.tf
```
### Clone repo
`git clone https://github.com/n-g-s/terraform-test.git`

### Setup AWS keys
`export AWS_ACCESS_KEY_ID="############"`
`export AWS_SECRET_ACCESS_KEY="############"`

### Configure terraform.tfvars for your needs or use the default values
`vim terraform.tfvars`

### Install and Initialise terraform
`brew install terraform`
`terraform init`

### Validate the code
`terraform validate`

### Prepare plan for terraform
`terraform plan -out=tfplan`

### Apply terraform plan
`terraform apply "tfplan"`

### Check output from module
```
for example
Outputs:

Server_IP = 54.211.121.205
Verify_assesment = Please open Server IP in your browser
```

```
curl 54.211.121.205
Hei der!!
```

### Destroy terraform plan
`terraform destroy -auto-approve`