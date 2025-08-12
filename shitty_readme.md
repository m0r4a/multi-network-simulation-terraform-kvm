- Creating an ssh key is a **MUST**

```bash
ssh-keygen -t rsa -b 4096 -f .ssh/ansible_key -N "" -C "ansible@gateway"
```

Also having your own `.pub` on `~/.ssh/id_rsa.pub`
