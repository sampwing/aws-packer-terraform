name	         'sw-elasticsearch'
maintainer       'Sam Wing'
license          'MIT'
description      'Build elasticsearch into an AWS AMI'
version          '0.0.1'

%w{ java elasticsearch chef-sugar }.each do |cookbook|
  depends cookbook
end

supports 'ubuntu'
