# packer instructions

validate configuration

`packer validate config.json`

build configuration (aws)

`packer build \
    -var "aws_access_key=$(python ../scripts/aws_profile.py -a access_key_id)" \
    -var "aws_secret_key=$(python ../scripts/aws_profile.py -a secret_access_key)" \
    config.json`