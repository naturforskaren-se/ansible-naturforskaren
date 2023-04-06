# ansible-naturforskaren
Ansible scripts to deploy the infrastructure for naturforskaren

The playbooks should be run in the following order.

1. setup the user 's-research' with privileges and with a key
2. Download the media/maps from owncloud 

## pre-req

## Playbook 'naturforskaren_setup-user.yml'
- sets up the user 's-research' on a node

## Playbook 'naturforskaren_download_and_extract_tar.yml'
Run as user 's-research' -> ansible-playbook -u s-research naturforskaren_download_and_extract_tar.yml`

- Fetches the media/map tar-file from owncloud
- Extracts the tar-file

## Playbook 'naturforskaren_clone_proxy_github_repo.yml'
Run as user 's-research' -> ansible-playbook -u s-research naturforskaren_clone_proxy_github_repo.yml`

## Playbook 'naturforskaren_clone_naturforskaren_github_repo.yml'
Run as user 's-research' -> ansible-playbook -u s-research naturforskaren_clone_naturforskaren_github_repo.yml`

- fetches the docker-project
