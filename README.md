# config

An ansible configuration to quickly setup new machines.
Linux only for now, but will support macOs soon.

## Local, host machine setup (macOs)

```bash
brew install pipx
pipx install --include-deps ansible
pipx install --include-deps ansible-lint

ansible-galaxy install viasite-ansible.zsh
ansible-galaxy install gantsign.golang
```

## Usage: setup a debian machine

```bash
ansible-playbook -i root@IP, debian.yml
```

## @todo

- [ ] Add a playbook to setup a macOs machine
- [ ] Add dotfiles
