# QuickCloud - ISIN 499 #
## Objective ##
To design and implement an easily-reproducible cloud infrastructure suitable
for hosting a small-business's website and database back-end, with few resource
requirements while maintaining strong security principles.

The infrastructure is specified, managed, and provisioned through various
machine-readable definition files, a process commonly referred to as
"Infrastructure as Code" (IaC).

## Tools ##
The following project utilizes both Terraform and Ansible to declaratively
specify our cloud configuration. The infrastructure is then deployed directly
to AWS.

## Installation ##
The following steps assume you have all requirements met (see list below) and
an AWS IAM user account configured with administrative permissions.

Clone the project repository.

```bash
git clone --depth=1 https://github.com/Tdback/QuickCloud-ISIN499
```

Export your `$AWS_ACCESS_KEY_ID` and `$AWS_SECRET_ACCESS_KEY` environment
variables.

```bash
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY_ID="..."
```

Generate an ssh key you would like to use to access the bastion host and
webservers. Name it `aws_ssh_access`.

(If you chose a different name for your key pair, ensure you have changed the
associated variables for both the Terraform and Ansible configurations.)

```bash
ssh-keygen -t rsa -b 4096
```

Change into the project directory and initialize Terraform.

```bash
cd QuickCloud-ISIN499

terraform init
```

Run the following to build the infrastructure:

```bash
terraform apply
```

*OR*

```bash
terraform apply -auto-approve
```

Once Terraform is done building, run the `setup_jumpbox.sh` script from the
plays directory to configure the bastion host. The script will automatically
grab the bastion host's public IP from Terraform's build output.

```bash
cd plays/
./setup_jumpbox.sh
```

You are now able to ssh into the bastion host over port **2222**, under the
user **ubuntu**. If you do not know the bastion host's IP address, simply run
`terraform output` in the project's root directory, or view it through AWS's
management console.

```bash
ssh -i ~/.ssh/aws_ssh_access -p 2222 -l ubuntu $IP
```

Once you have remotely accessed the bastion host, switch into the plays
directory under the ubuntu user's home directory. Running the following command
will configure the web servers:

```bash
ansible-playbook run.yaml
```

If you have encrypted the contents of your `secrets.yaml` under
`plays/group_vars/webservers/secrets.yaml`, pass the appropriate flag to
Ansible to decrypt the file before executing the configuration plays.

```bash
ansible-playbook run.yaml --ask-vault-pass
```

To view the web address of the web servers, run the following command in the
root directory of this project on your system. Copy the contents of
`alb_domain_name` and paste it in your browser to view the site:

```bash
terraform output
```

If you wish to destroy your Terraform infrastructure, run the following
command:

```bash
terraform destroy
```

*OR*

```bash
terraform destroy -auto-approve
```

### Installation Requirements ###
- Terraform
- Ansible
- AWS CLI (aws-shell)

## Author Acknowledgements ##
This is the first time each of us have used Terraform, and only one member of
the team had previous experience using Ansible. The following documentation
and resources were critical to our success in this project:
- [Terraform Registry](https://registry.terraform.io/)
- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)
- [AWS Documentation](https://docs.aws.amazon.com/)
