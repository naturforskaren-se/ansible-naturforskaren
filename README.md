# ansible-naturforskaren
Ansible scripts to deploy the infrastructure for naturforskaren

The playbooks should be run in the following order.
- [creating a ssh-keypair](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

1. setup the user 's-research' with privileges and with a key
2. Before you run the the playbooks as user 's-research' you need to add your ssh key (``` ssh-add ~/.ssh/id_rsa ```)
3. Download the media/maps from owncloud 
4. Clone the proxy-server from github, a docker-project
5. Clone the 'naturforskaren'-service from github , a docker-project
6. Clone the 'populationstrend'-service from github.
7. Fetch the databasedump (users have been erased) from owncloud.nrm.se
8. Copy startup.sh script to remote machine
9. Create a crontab-job for root

## pre-req

## Playbook 'naturforskaren_setup-user.yml'
- ``` ansible-playbook -u ingimar naturforskaren_setup-user.yml ```

## Playbook 'naturforskaren_download_and_extract_tar.yml'
Run as user 's-research':
- ``` ansible-playbook -u s-research naturforskaren_download_and_extract_tar.yml```

- Fetches the media/map tar-file from owncloud
- Extracts the tar-file

## Playbook 'naturforskaren_clone_proxy_github_repo.yml'
Run as user 's-research':  ```ansible-playbook -u s-research naturforskaren_clone_proxy_github_repo.yml```

## Playbook 'naturforskaren_clone_naturforskaren_github_repo.yml'
Run as user 's-research': ```ansible-playbook -u s-research naturforskaren_clone_naturforskaren_github_repo.yml```
- fetches the docker-project

## Playbook 'naturforskaren_clone_populationstrend_github-repo.yml'
Run as user 's-research': ```ansible-playbook -u s-research naturforskaren_clone_populationstrend_github-repo.yml```

## Playbook 'naturforskaren_download_databasedump.yml' 
Run as user 's-research':  ```ansible-playbook -u s-research naturforskaren_download_databasedump.yml```

### info
- the databasedump, the user-table has been emptied


## Playook 'naturforskaren_copy_file.yml'
Run as user 's-research':  ```ansible-playbook -u s-research naturforskaren_copy_file.yml``` 


## Playbook 'naturforskaren_create_crontab_for_root.yml'
Run as user 's-research': ```ansible-playbook -u s-research playbook_setup_cronjob.yml``` 
