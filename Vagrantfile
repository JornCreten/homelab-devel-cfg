require 'yaml'

# Load machine configuration from YAML file
machines = YAML.load_file('machines.yaml')['machines']

Vagrant.configure("2") do |config|
  machines.each do |machine|

    config.vm.define machine['name'] do |node|
      node.vm.box = "generic/fedora39"
      node.vm.hostname = machine['name']

      config.ssh.username = "vagrant"  # Replace with the correct username, usually "vagrant"
      config.ssh.password = "vagrant"  # Replace with the correct password
      config.ssh.insert_key = true          # Prevents Vagrant from trying to replace the key
      
      node.vm.network "private_network", ip: machine['ip']

      # Resource allocation
      node.vm.provider "virtualbox" do |vb|
        vb.memory = machine['memory']
        vb.cpus = machine['cpus']
      end

      # Dynamically load and run role-specific scripts
      role = machine['role']
      Dir.glob("scripts/#{role}/*.sh").each do |script|
        node.vm.provision "shell", path: script
      end
    end
  end
end
