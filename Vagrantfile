# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure(2) do |config|
  # any configuration that needs to be done before the reddit setup happens
  config.vm.define "default" do |redditlocal|
    redditlocal.vm.provider "virtualbox" do |v|
      v.cpus = 2
    end
    # pre-setup
    redditlocal.vm.provision "file", source: "r2/development.update", destination: "~/src/reddit/r2/development.update"
  end

end

# we take advantage of the fact that the reddit Vagrantfile mounts the parent directory
# and ends up using the relative path "../reddit/" for the source to run the virtualized application on
# under normal circumstances this path ends up being the same as "."
load "../reddit/Vagrantfile"
