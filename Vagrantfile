# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "nulib"
  config.vm.box_url = "http://yumrepo-public.library.northwestern.edu/nulib.box"

  config.vm.network :forwarded_port, guest: 8080, host: 8080

  config.vm.provision :puppet do |puppet|
    puppet.options        = "--fileserverconfig=/vagrant/fileserver.conf"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "fcrepo4.pp"
  end
end
