# Describe VMs
require 'fileutils'

# relative path
VAGRANT_ROOT = File.dirname(File.expand_path(__FILE__))

# controller definition
VAGRANT_CONTROLLER_NAME = "Virtual I/O Device SCSI controller"
VAGRANT_CONTROLLER_TYPE = "virtio-scsi"

# directory for disks
VAGRANT_DISK_DIRECTORY = "disks"

# disks
local_disks = [
    { :filename => "disks10",:size => 1, :port => 10 },
    { :filename => "disks11",:size => 1, :port => 11 },
    { :filename => "disks12",:size => 1, :port => 12 },
    { :filename => "disks13",:size => 1, :port => 13 },
    { :filename => "disks14",:size => 1, :port => 14 },
    { :filename => "disks15",:size => 1, :port => 15 },
    { :filename => "disks16",:size => 1, :port => 16 },
    { :filename => "disks17",:size => 1, :port => 17 },
    { :filename => "disks18",:size => 1, :port => 18 },
    
]

MACHINES = {
  # VM name "Lesson2-MDADM"
  :"Lesson5-ZFS" => {
              # VM box
              :box_name => "bento/centos-8",
              # OS version
              :box_version => "202112.19.0",
              # VM CPU count
              :cpus => 2,
              # VM RAM size (Mb)
              :memory => 2048,
              # networks
              :net => [],
              # forwarded ports
              :forwarded_port => [],
              # headless mode
              "headless":true
            }
}

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    config.vm.boot_timeout = 1200
    # Disable shared folders
    config.vm.synced_folder ".", "/vagrant", disabled: true
    # VB Guest Additions - disable update
    if Vagrant.has_plugin?("vagrant-vbguest") then
      config.vbguest.auto_update = false
    end
    # disks
    disks_directory = File.join(VAGRANT_ROOT, VAGRANT_DISK_DIRECTORY)
    # create disks before up
    config.trigger.before :up do |trigger|
      trigger.name = "Create disks"
      trigger.ruby do
        unless File.directory?(disks_directory)
          FileUtils.mkdir_p(disks_directory)
        end
        local_disks.each do |local_disk|
          local_disk_filename = File.join(disks_directory, "#{local_disk[:filename]}.vdi")
          unless File.exist?(local_disk_filename)
            puts "Creating \"#{local_disk[:filename]}\" disk"
            system("vboxmanage createmedium --filename #{local_disk_filename} --size #{local_disk[:size] * 1024} --format VDI")
          end
        end
      end
    end
	
    	# create storage controller on first run
    	unless File.directory?(disks_directory)
    	  config.vm.provider "virtualbox" do |storage_provider|
    	    storage_provider.customize ["storagectl", :id, "--name", VAGRANT_CONTROLLER_NAME, "--add", VAGRANT_CONTROLLER_TYPE, '--hostiocache', 'off']
    	  end
    	end
    	                  
    	# attach storage devices
    	config.vm.provider "virtualbox" do |storage_provider|
    	  local_disks.each do |local_disk|
    	    local_disk_filename = File.join(disks_directory, "#{local_disk[:filename]}.vdi")
    	    unless File.exist?(local_disk_filename)
    	      storage_provider.customize ['storageattach', :id, '--storagectl', VAGRANT_CONTROLLER_NAME, '--port', local_disk[:port], '--device', 0, '--type', 'hdd', '--medium', local_disk_filename]
    	    end
    	  end
    	end
    	# cleanup after "destroy" action
    	config.trigger.after :destroy do |trigger|
    	  trigger.name = "Cleanup operation"
    	  trigger.ruby do
    	    # the following loop is now obsolete as these files will be removed automatically as machine dependency
    	    local_disks.each do |local_disk|
    	      local_disk_filename = File.join(disks_directory, "#{local_disk[:filename]}.vdi")
    	      if File.exist?(local_disk_filename)
    	        puts "Deleting \"#{local_disk[:filename]}\" disk"
    	        system("vboxmanage closemedium disk #{local_disk_filename} --delete")
    	      end
    	    end
    	    if File.exist?(disks_directory)
    	      FileUtils.rmdir(disks_directory)
    	    end
    	  end
    	end

    # Apply VM config
    config.vm.define boxname do |box|
      # Set VM base box and hostname
      box.vm.box = boxconfig[:box_name]
      box.vm.box_version = boxconfig[:box_version]
      box.vm.host_name = boxname.to_s
      # Additional network config if present
      if boxconfig.key?(:net)
        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end
      end
      # Port-forward config if present
      if boxconfig.key?(:forwarded_port)
        boxconfig[:forwarded_port].each do |port|
          box.vm.network "forwarded_port", port
        end
      end
      # VM resources config
      box.vm.provider "virtualbox" do |v|
        # Set VM RAM size and CPU count
        v.memory = boxconfig[:memory]
        v.cpus = boxconfig[:cpus]
      end
      # Shell script
#      config.vm.provision "shell", inline: $SHELL
      config.vm.provision "shell", path: "zfs.sh", privileged: true
    end
  end # MACHINES.each do |boxname, boxconfig|
end # Vagrant.configure("2") do |config|
