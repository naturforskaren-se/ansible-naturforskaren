# ansible-naturforskaren
Ansible scripts to deploy the infrastructure for naturforskaren

The playbooks should be run in the following order.

1. setup a user
2. Download the media/maps from owncloud 

## pre-req

## Playbook 'naturforskaren_setup-user.yml'
- sets up the user 's-research' on a node

## Playbook 'naturforskaren_download_and_extract_tar.yml'
- Fetches the media/map tar-file from owncloud
- Extracts the tar-file
