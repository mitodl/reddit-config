# Reddit Config

Custom extension of reddit Vagrant setup to allow custom configuration


### Setup

NOTE: It may be helpful to create a directory that is separate from your normal dev
    directory for the repositories that you'll need to run reddit. When the Vagrant VM
    is provisioned, all of the repositories at the same directory level as the main
    reddit repository will be available within the Vagrant VM.

1. Clone the necessary repositories and make sure `reddit` has the `stable` branch checked
   out.

    ```bash
    cd <reddit development directory>
    git clone git@github.com:mitodl/reddit.git
    git clone git@github.com:mitodl/reddit-config.git
    git clone git@github.com:mitodl/refresh_token.git
    git clone git@github.com:mitodl/no_op2_resizer.git
    cd reddit
    git checkout stable
    ```
    
1. Create or reload/provision the `reddit-config` Vagrant VM.
   - For first time setup:

        ```bash
        cd <reddit-config directory>
        touch r2/local.update
        vagrant up
        ```
       
   - For subsequent uses:

        ```bash
        cd <reddit-config directory>
        vagrant reload && vagrant provision
        ```
   - _NOTE: The server is configured to run automatically upon VM creation/provisioning._

1. Add the `reddit.local` hostname to your `/etc/hosts` file. The IP of the Vagrant 
   VM is `192.168.56.111` by default, so the line to add will most likely be:
   
   `192.168.56.111  reddit.local`

1. Navigate to the site from the host machine: `http://reddit.local`.
   - It may take some time for the server to be ready to accept requests 
     (~30 seconds in some cases), and the site will likely respond with a 503 
     error before then.

### Troubleshooting

- The main server log file is located in the VM at `/var/log/upstart/reddit-paster.log`. 
  It will often contain useful error messages. 
   - Error messages often come in the form of debug links. These messages look like this:
     `Debug at: http://reddit.local/_debug/view/1234567890`. Those links will show a stack
     trace of the error in question.
   - One-liner to show the debug URL for the last error on the server from the host machine: 
     `vagrant ssh -c "sudo tac /var/log/upstart/reddit-paster.log | grep -m 1 'Debug at:' | grep -Eo 'http[^\s]*'"`
- Restarting the server is often helpful. In the VM, run `sudo reddit-restart`.
