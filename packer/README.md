# packer instructions

validate configuration

`packer validate config.json`

build configuration (aws)

`packer build \
    -var "aws_access_key=$(python ../scripts/aws_profile.py -a access_key_id)" \
    -var "aws_secret_key=$(python ../scripts/aws_profile.py -a secret_access_key)" \
    config.json`


# Use Berkshelf w/ Chef

You will need to vendor the cookbooks locally before running packer build

`berks vendor -b cookbooks/sw-elasticsearch/Berksfile vendor`

Will install the cookbooks and dependencies into a vendor directory which is not checked in