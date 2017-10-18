#!/usr/bin/env python
# vi: set ft=python :

from r2.models import Account, register, OAuth2Client, change_password
from r2.lib.db.thing import NotFound

try:
    localdev = Account._by_name('<%= account_username %>')
    change_password(localdev, '<%= account_password %>')
except NotFound:
    localdev = register('<%= account_username %>', '<%= account_password %>', '127.0.0.1')

try:
    client = OAuth2Client._byID('<%= oauth_client_id %>')
except NotFound:
    client = OAuth2Client(_id='<%= oauth_client_id %>',
                          secret='<%= oauth_client_secret %>',
                          redirect_uri='https://localhost:8063/',
                          name='Client app for open discussions',
                          app_type='script')

client.add_developer(localdev)
client._commit()
