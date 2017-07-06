Notes
---

This doc is mostly notes for Ops

- Reddit app will run if a plugin is missing
- Reddit app will **not** run if a provider is missing
- Reddit/Pylons uses `pkg_resources.WorkingSet` to load plugins/provider (see next note).
- Plugins/providers need to be installed at the global level by invoking this:
    ```
    python setup.py build
    sudo python setup.py develop --no-deps
    ```
- `db_table_*` needs to be configured **before** the Reddit application is started the first time or runtime errors will occur
