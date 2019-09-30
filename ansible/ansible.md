# Ansible Playbooks etc.
Shortly I will publish my playbooks here.

## encrypt and hash a passsword
I used the following to encrypt and hash a password for a user that I need to log in to the Computer. It also gets stored in the vars.yml.
The vault.yml file contains the encryption key for ansible to store in the vars.yml.
```
ansible all -i localhost, -m debug -a "msg={{ 'password-string' | password_hash('sha512', 'password-salt') }}"
ansible-vault encrypt_string --vault-id .vault_pw.yml '$6$password-salt$jpassword-encrypted-string.' --name password >> path/to/vars.yml
```
