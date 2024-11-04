# -*- mode: ruby -*-
# vi: set ft=ruby :

iso_install = "rhel-9.4-aarch64-dvd.iso"
vm_name_default = "rhel-test"
vm_name_file = ".vagrant_vm_name"

## Use contents of vm_name_file if it exists, otherwise use vm_name_default
vm_name = File.file?(vm_name_file) ? IO.read(vm_name_file).strip : vm_name_default

## Use "oemdrv.iso" as the second ISO file if it exists, otherwise fall back to our
## locally-included "ks.iso".
iso_oemdrv = "oemdrv.iso"
iso_ks = File.exist?(iso_oemdrv) ? iso_oemdrv : "ks.iso"

##
## Regular Vagrant...
##
Vagrant.configure("2") do |config|
  config.vm.define vm_name
  config.vm.box = "slu/empty"
  config.vm.box_check_update = false
  config.vm.hostname = vm_name
  config.vm.boot_timeout = 1800
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.ssh.username = "ansible"
  config.ssh.connect_timeout = 30
  config.ssh.insert_key = "false"

  config.vm.provider "parallels" do |prl|
    prl.name = vm_name
    prl.check_guest_tools = false
    prl.customize "post-import", ["set", :id, "--startup-view", "window"]
    prl.customize "post-import", ["set", :id, "--device-add", "cdrom", "--image", iso_install, "--connect"]
    prl.customize "post-import", ["set", :id, "--device-add", "cdrom", "--image", iso_ks, "--connect"]
  end

  config.trigger.before :up do |trigger|
    trigger.name = "Select Configuration ISO"
    trigger.info = "Using #{iso_ks} as configuration ISO."
  end

  config.trigger.before :up do |trigger|
    trigger.name = "Kickstart ISO"
    trigger.run = {inline: "make ks.iso" }
  end

end
