## Instruction 

1. Install VirtualBox

2. Install vagrant

3. Install vagrant plugins:
```
vagrant plugin install vagrant-vbguest
```

3. Create a folder, for example: local-vm and clone chef
```
cd local-vm
git clone https://github.com/techops-storm8/chef.git
```

4. cd chef/vagrant

5. vagrant up

6. vagrant ssh

7. Or run 
```
scripts/local_vm_ssh_portforwarding.sh
ssh root@local-qa
```
