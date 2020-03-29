Vagrant.configure("2") do |config|
  config.vm.provider :hyperv do |v|
    v.memory = 4096
    v.cpus = 4
  end

  config.vm.define "velgard" do |velgard|
    velgard.vm.box = "bento/ubuntu-16.04"
    velgard.vm.network "private_network", ip: "192.168.246.30"
    velgard.vm.hostname = "velgard"
    velgard.vm.provision :shell, privileged: false, path: "scripts/bootstrap.sh"
    velgard.vm.provision :shell, privileged: false, path: "scripts/install-dev-tools.sh"
    velgard.vm.provision :shell, privileged: false, path: "scripts/install-kubernetes-tools.sh"
    velgard.vm.provision :shell, privileged: false, path: "scripts/config-elixir-env.sh"
    velgard.vm.provision :shell, privileged: false, path: "scripts/config-haskell-env.sh"
    velgard.vm.provision :file, source: "overlay/home", destination: "$HOME"
    velgard.vm.provision :file, source: "~/.gitconfig", destination: "$HOME/.gitconfig"
    velgard.vm.provision :file, source: "~/.ssh", destination: "$HOME/.ssh"
    velgard.vm.provision :file, source: "~/.kube", destination: "$HOME/.kube"
    velgard.vm.provision :file, source: "~/.minikube", destination: "$HOME/.minikube"
    velgard.vm.provision :file, source: "~/.config", destination: "$HOME/.config"
  end
end
