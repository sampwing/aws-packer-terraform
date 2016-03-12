include_recipe 'java'

include_recipe 'chef-sugar'

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch' do
  type node['elasticsearch']['install_type'].to_sym # since TK can't symbol.
end
elasticsearch_configure 'elasticsearch' do
    allocated_memory '512m'
    configuration ({
	  'network.host' => '0.0.0.0',
      'http.port' => 9200
    })
end
elasticsearch_service 'elasticsearch'

service 'elasticsearch' do
	action :start
end
