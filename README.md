# pre-req 

## Add host file to hosts
- /etc/ansible/hosts
- add your host(s) - the remote machine where you would like to install 'naturforskaren.se'



## creating a ssh-keypair
- [creating a ssh-keypair](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) 
- public key: the public key, a reference is added to the naturforskaren_setup-user.yml
- private key (id_rsa) is stored in the ``` ~/.ssh/ ``` -directory
- before you run the playbooks as 's-research' you need to add your ssh key to the ssh-agent. - command: (``` ssh-add ~/.ssh/id_rsa ```)

# ansible-naturforskaren
Ansible scripts to deploy the infrastructure for naturforskaren

Summary: - The playbooks should be run in the following order.
1. setup the user 's-research' with privileges and with a key
2. Download the media/maps from owncloud (**note** this takes some time)
3. Clone the proxy-server from github, a docker-project ```for production do (a) cp the cert-files to the proxy/cert-dir, (b) use the natuforskaren.se.conf as your nginx-proxy.conf```
4. Clone the 'naturforskaren'-service from github , a docker-project
5. Clone the 'populationstrend'-service from github.
6. Fetch the databasedump (users have been erased) from owncloud.nrm.se
7. Copy startup.sh script to remote machine
8. Create a crontab-job for root



## Playbook 'naturforskaren_setup-user.yml'
for instance as the user 'ingierli'
1. the user should have a passwordless keypair and the user should have a passwordless sudo on the target machine ...  

- ``` ansible-playbook -u ingierli naturforskaren_setup-user.yml ```

## Playbook 'naturforskaren_download_and_extract_tar.yml'
Run as user 's-research':
- ``` ansible-playbook -u s-research naturforskaren_download_and_extract_tar.yml```

- Fetches the media- and the map-file 
- Extracts the media- and the map-tar.gz

**check** the number of files- should be the following 
```
/opt/data/nf$ tree | wc
 150535  592593 685708
``` 

### tar-command used to archive
- media: tar -zcvf -P /tmp/naturforskaren_media_images.tar.gz /opt/data/nf/vffmedia/ ```
- maps : 

## Playbook 'naturforskaren_clone_proxy_github_repo.yml'
Run as user 's-research':  ```ansible-playbook -u s-research naturforskaren_clone_proxy_github_repo.yml```

## Playbook 'naturforskaren_clone_naturforskaren_github_repo.yml'
Run as user 's-research': ```ansible-playbook -u s-research naturforskaren_clone_naturforskaren_github_repo.yml```
- fetches the docker-project

## Playbook 'naturforskaren_clone_populationstrend_github-repo.yml'
Run as user 's-research': ```ansible-playbook -u s-research naturforskaren_clone_populationstrend_github-repo.yml```

## Playbook 'naturforskaren_download_databasedump.yml' 
Run as user 's-research':  ```ansible-playbook -u s-research naturforskaren_download_databasedump.yml```

**check** the md5sum of the sql-file
```
~/repos/naturforskaren/db/mysql_media-autoload$ md5sum taxonpages_v2_no_user.sql 
dbb4fcc1d0f48d9739e0feb047fd95a5  taxonpages_v2_no_user.sql
``` 

### info
- the databasedump, the user-table has been emptied


## Playook 'naturforskaren_copy_file.yml'
Run as user 's-research':  ```ansible-playbook -u s-research naturforskaren_copy_file.yml``` 

- copies the setup.sh file   ,        with +x privileges.
- copies the stopall.sh file ,        with +x privileges.
- copies the setup_docker_network.sh, with +x privileges.

## Playbook 'naturforskaren_create_crontab_for_root.yml'
Run as user 's-research': ```ansible-playbook -u s-research naturforskaren_create_crontab_for_root.yml``` 

- creates a '@reboot' in roots crontab, starting up all the services, using the setup.sh-file

**check** the crontab for root
```
~/repos$ sudo su
root@ubuntu-s-2vcpu-4gb-lon1-01:/home/s-research/repos# crontab -l
#Ansible: a job for reboot
@reboot /home/s-research/repos/startup.sh
root@ubuntu-s-2vcpu-4gb-lon1-01:/home/s-research/repos#
```

-----------------
# Troubleshoot the service.

## settings for naturforskaren and proxy

### simple setup, using dummy url and NO SSL
- naturforskaren and docker-compose.yml: if the url is set to forinstance 'naturforskaren.org'
- then the service is reachable at : ``` http://naturforskaren.org/naturalist/ ``` - mandatory with ```/naturalist/```
