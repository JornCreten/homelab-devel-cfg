Vagrant.configure("2") do |config|
  config.vm.box = "generic/fedora39"
  config.vm.box_version = "4.3.12"

  config.ssh.username = "vagrant"  # Replace with the correct username, usually "vagrant"
  config.ssh.password = "vagrant"  # Replace with the correct password
  config.ssh.insert_key = true          # Prevents Vagrant from trying to replace the key
  #config.ssh.private_key_path = "~/.ssh/ed25519"
  #config.vm.network "forwarded_port", guest: 22, host: 2222
    # Set up a bridged network
  #config.vm.network "public_network", bridge: "wlp1s0"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end
end