# aws-packer-terraform

Build an AMI containing Redis and then launch instance to run on.

To build AMI

```shell
cd packer
packer build \
    -var "aws_access_key=$(python ../scripts/aws_profile.py -a access_key_id)" \
    -var "aws_secret_key=$(python ../scripts/aws_profile.py -a secret_access_key)" \
    redis.json
```

Record the AMI id like ~ ami-3e1d6e5e

To launch the new AMI on a new instance with a ne

```shell
cd terraform
terraform apply \
	-var 'amis.us-west-1=ami-3e1d6e5e' \
	-var-file="awscreds.tfvars"
```
