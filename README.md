# Reddit Config

Custom extension of reddit Vagrant setup to allow custom configuration


### Setup
```bash
cd ..
git clone git@github.com:reddit/reddit.git
git clone git@github.com:mitodl/reddit-config.git
git clone git@github.com:mitodl/refresh_token.git
git clone git@github.com:mitodl/no_op2_resizer.git
cd reddit
git apply ../reddit-config/patches/configure_tracing.patch
cd ../reddit-config
vagrant up
```
