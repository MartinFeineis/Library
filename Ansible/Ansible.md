# Ansible Playbooks etc.
Shortly I will publish my playbooks here.
Secrets, Keys and other sensitive information is stored in `files/var`. This is for obvious reasons not included in a public git repo. Additionally all Keys and secrets are encrypted using `ansible-vault`.

## encrypt and hash a passsword
I used the following to encrypt and hash a password for a user that I need to log in to the Computer. It also gets stored in the vars.yml.
The vault.yml file contains the encryption key for ansible to store in the vars.yml.
```
ansible all -i localhost, -m debug -a "msg={{ 'password-string' | password_hash('sha512', 'password-salt') }}"
ansible-vault encrypt_string --vault-id .vault_pw.yml '$6$password-salt$jpassword-encrypted-string.' --name password >> path/to/vars.yml
```
Getting the contents of a file into the vars file. This still needs some indentation and variable naming in the vars file.  
```
ansible-vault encrypt --vault-id .vault_pw.yml aws_rsa
cat aws_rsa >> files/vars.yml
```
## Main Playbook
This contains the configuration that I want to have the same overall machines. [playbook](./playbook.yml)  
### configs  
This folder contains playbooks that get included into the main playbook. The playbooks in `config` are host or program specific. Also there might be room for discussion if some aspects are in the right playbook or should even have their own playbook. User generation might be one of thie examples. [configs](https://github.com/MartinFeineis/Library/tree/master/ansible/configs)  
