require 'yaml'

# Load machine configuration from YAML file
machines = YAML.load_file('machines.yaml')['machines']

Vagrant.configure("2") do |config|
  machines.each do |machine|
    config.vm.synced_folder ".shared", "/vagrant_shared", owner: "vagrant"
    config.vm.define machine['name'] do |node|
      node.vm.box = "generic/fedora39"
      node.vm.hostname = machine['name']
      node.vm.network "private_network", ip: machine['ip']
      


      config.ssh.username = "vagrant"  # Replace with the correct username, usually "vagrant"
      config.ssh.password = "vagrant"  # Replace with the correct password
      config.ssh.insert_key = true          # Prevents Vagrant from trying to replace the key
      


      # Resource allocation
      node.vm.provider "virtualbox" do |vb|
        vb.memory = machine['memory']
        vb.cpus = machine['cpus']
      end
      if machine['role'] == "master"
        # Provision the master node to install Kubernetes and generate the token
        node.vm.provision "shell", inline: <<-SHELL
          curl -sfL https://get.k3s.io | sh -
          sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant_shared/kube_join_token
          hostname -I | awk '{print $2}' > /vagrant_shared/kube_master_ip
        SHELL
      end
      if machine['role'] == "worker"
        # Use a trigger to run after the master node is fully set up
        node.trigger.before :up do |trigger|
          trigger.ruby do
            # Read the join command from the shared folder
            join_token = File.read(".shared/kube_join_command.sh").strip
            
          end
        end
        # Provision the worker node to join the Kubernetes cluster
        node.vm.provision "shell", inline: <<-SHELL
          KUBE_JOIN_TOKEN=$(cat "/vagrant_shared/kube_join_token")
          MASTER_IP=$(cat "/vagrant_shared/kube_master_ip")
          # Execute the join command retrieved from the master node
          echo $KUBE_JOIN_TOKEN
          curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$KUBE_JOIN_TOKEN sh -
        SHELL
      # Dynamically load and run role-specific scripts
      role = machine['role']
      Dir.glob("scripts/#{role}/*.sh").each do |script|
        node.vm.provision "shell", path: script
      end
    end
  end
end
end