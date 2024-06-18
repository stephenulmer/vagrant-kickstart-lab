# -*- mode: ruby -*-
# vi: set ft=ruby :

vm_name = "rhel-test"
iso_build_command = "hdiutil makehybrid -iso -joliet -default-volume-name OEMDRV -o ks.iso ks_iso"

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
    prl.customize "post-import", ["set", :id, "--device-add", "cdrom", "--image", "rhel-9.4-aarch64-dvd.iso", "--connect"]
    prl.customize "post-import", ["set", :id, "--device-add", "cdrom", "--image", "ks.iso", "--connect"]
  end

  config.trigger.before :up do |trigger|
    trigger.name = "Kickstart ISO"
    trigger.run = {inline: "make ks.iso" }
  end

end
