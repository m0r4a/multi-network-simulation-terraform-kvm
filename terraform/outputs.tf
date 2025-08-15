output "hosts_for_ansible" {
  value = {
    gateway = [module.gateway.address]
    admin = [module.admin.address]
    # user  = [module.user.address]
  }
}
