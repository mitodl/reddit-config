# -*- mode: ruby -*-
# vi: set ft=ruby :

# we take advantage of the fact that the reddit Vagrantfile mounts the parent directory
# and ends up using the relative path "../reddit/" for the source to run the virtualized application on
# under normal circumstances this path ends up being the same as "."
load "../reddit/Vagrantfile"

Vagrant.configure(2) do |config|
  # any configuration that needs to be done after the reddit setup happens
  config.vm.define "default" do |redditlocal|
    # post-setup
    redditlocal.vm.provision "file", source: "r2/development.update", destination: "~/src/reddit/r2/development.mito.update"

    redditlocal.vm.provision "shell", inline: <<-SCRIPT
      cd src/reddit/r2
      sudo -u vagrant ./updateini.py development.ini development.mito.update > development.mito.ini
      ln -sf development.mito.ini run.ini
      reddit-stop
      reddit-start
    SCRIPT
  end

end
