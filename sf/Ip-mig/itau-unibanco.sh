13.110.235.68
13.110.236.194



13.110.235.68  iad4s12_multi-tenant_pool_47
13.110.236.194  iad4s12_multi-tenant_pool_53


Destionation Pool: iad4s12_itau_unibanco



knife ssh "pmta_pool:iad4s12_multi-tenant_pool_53" "sudo grep 'default-virtual-mta' /etc/pmta/dynamic_configs/config.sources | sort | uniq"

knife ssh "pmta_pool:iad4s12_itau_unibanco" "sudo ls /etc/pmta_ansible_managed | grep 'config.global_domain_settings.am'"

knife ssh "pmta_pool:iad4s12_itau_unibanco" "sudo ls -l /etc/sysconfig/network-scripts | grep ifcfg-"


Dual NIC

Next NIC is 65



knife ssh "pmta_pool:iad4s12_itau_unibanco" "sudo bash /root/set-up-new-ifcfgs-ens224.sh"

knife ssh "pmta_pool:iad4s12_itau_unibanco" "sudo ls /etc/sysconfig/network-scripts/ | grep 'ens224:'"

knife ssh "pmta_pool:iad4s12_itau_unibanco" "sudo systemctl restart network.service"

bash /home/etapp/svn/scripts/makeCfgVfromIPpool.bash iad4s12_itau_unibanco poolIP IPs

knife ssh "pmta_pool:iad4s12_itau_unibanco" "sudo chef-client -o recipe'[itmta_vmta_update]'"

iad4s12mta61.xt.local