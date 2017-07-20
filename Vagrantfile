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

Vagrant.configure(2) do |config|
  # any configuration that needs to be done after the reddit setup happens
  config.vm.define "default" do |redditlocal|
    # post-setup
    redditlocal.vm.provision "shell", inline: <<-SCRIPT
      function setup_reddit_ext() {
        pushd .
        DIR=$1
        if [[ -d $DIR ]] ;
        then
          cd $DIR
          python setup.py build
          sudo python setup.py develop --no-deps
        else
          echo "$DIR doesn't exist"
        fi
        popd
      }

      setup_reddit_ext src/refresh_token
    SCRIPT

    redditlocal.vm.provision "file", source: "r2/plugins.update", destination: "~/src/reddit/r2/plugins.update"

    redditlocal.vm.provision "shell", inline: <<-SCRIPT
      cd src/reddit/r2
      mv development.ini development.old.ini
      python updateini.py development.old.ini plugins.update > development.ini
      sudo reddit-restart
    SCRIPT

    redditlocal.vm.provision "file", source: "r2/local.update", destination: "~/src/reddit/r2/local.update"

    redditlocal.vm.provision "shell", inline: <<-SCRIPT
      cd src/reddit/r2
      mv development.ini development.old.ini
      python updateini.py development.old.ini local.update > development.ini
      sudo reddit-restart
    SCRIPT
  end
end
