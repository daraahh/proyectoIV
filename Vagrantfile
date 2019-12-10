# -*- mode: ruby -*-
# vi: set ft=ruby :

# Archivo de configuracion (version 2) para Vagrant
Vagrant.configure("2") do |config|

  # Tomo una imagen Ubuntu 16.04 Xenial (64 bits)
  config.vm.box = "ubuntu/xenial64"

  # Indica a Vagrant un nombre para la máquina virtual
  config.vm.define "proyectoIV"

  # Indica a Vagrant que use VirtualBox como provider
  config.vm.provider "virtualbox"

  # Deshabilito la carpeta compartida que monta por defecto tomando el directorio
  # actual
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # Configuración de puertos para permitir el acceso al puerto 80 de la máquina
  # a través del puerto 8080 del host, solo de forma local (127.0.0.1).
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Este bloque indica la configuración específica para el provider. Uso en este caso
  # VirtualBox, que además es el provider por defecto usado por Vagrant.
  config.vm.provider "virtualbox" do |vb|
    # Arrancar la máquina en modo headless, sin GUI
    vb.gui = false
    # Nombro la maquina proyectoIV
    vb.name = "proyectoIV"
    # Asignos dos cores de CPU a la máquina virtual
    vb.cpus = 2
    # Asigno 2GB de memoria RAM a la máquina virtual
    vb.memory = "2048"
  end

  # Este bloque indica que el aprovisionamiento se va a hacer mediante Ansible e
  # indica la localización del playbook a seguir.
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provision/playbook.yml"
  end
end
