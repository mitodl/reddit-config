# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'base64'
require 'erb'
require 'ostruct'

account_username = 'localdev'
account_password = 'password1'
oauth_client_id = 'od_client_id'
oauth_client_secret = 'od_client_secret'
oauth_client_id_base64 = Base64.encode64(oauth_client_id)

$vars = {
  :account_username => account_username,
  :account_password => account_password,
  :oauth_client_id => oauth_client_id,
  :oauth_client_secret => oauth_client_secret,
  :oauth_client_id_base64 => oauth_client_id_base64,
}

def render_tmpl(source, vars)
  template = File.read(source)
  ERB.new(template).result(OpenStruct.new(vars).instance_eval { binding })
end

# render a template file
def render_to_tmp(source)
  basename = File.basename(source)
  output_path = "tmp/#{basename}"
  FileUtils.mkdir_p("tmp")
  File.open(output_path, 'w') { |file| file.write(render_tmpl(source, **$vars)) }
  output_path
end

Vagrant.configure(2) do |config|
  # any configuration that needs to be done before the reddit setup happens
  config.vm.define "default" do |redditlocal|
    redditlocal.vm.provider "virtualbox" do |v|
      v.cpus = 2
    end

    # wait for cassandra to come up fully, otherwise other scripts will fail
    redditlocal.vm.provision "shell",
      path: "scripts/wait_cassandra_ready.sh"

    # the default provisioning will utilize this
    redditlocal.vm.provision "file",
      source: "r2/pre_setup.update",
      destination: "~/src/reddit/r2/development.update"

    # fake this file so reddit setup script doesn't inject test data
    # this data usually breaks APIs and such
    redditlocal.vm.provision "shell",
      inline: "touch /var/local/test_data_injected"
  end
end

# we take advantage of the fact that the reddit Vagrantfile mounts the parent directory
# and ends up using the relative path "../reddit/" for the source to run the virtualized application on
# under normal circumstances this path ends up being the same as "."
load "../reddit/Vagrantfile"

Vagrant.configure(2) do |config|
  # any configuration that needs to be done after the reddit setup happens
  config.vm.define "default" do |redditlocal|

    # wait for cassandra to come up fully, otherwise other scripts will fail
    redditlocal.vm.provision "shell",
      path: "scripts/wait_cassandra_ready.sh"

    # render and upload post setup config update
    redditlocal.vm.provision "file",
      source: render_to_tmp("r2/post_setup.update"),
      destination: "~/src/reddit/r2/development.update"

    # render and upload create_api_user script
    redditlocal.vm.provision "file",
      source: render_to_tmp("scripts/create_api_user.py"),
      destination: "/tmp/create_api_user.py"

    # create the api user and app
    # the client id is statically base64 encoded in r2/post_setup.update as well
    redditlocal.vm.provision "shell",
      inline: "/usr/local/bin/reddit-run /tmp/create_api_user.py"

    # post-setup script (config update, plugin install, etc)
    redditlocal.vm.provision "shell",
      path: "scripts/setup.sh"
  end
end
