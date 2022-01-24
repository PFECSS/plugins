Vagrant.configure('2') do |c|
    c.vm.define "webapps" do |m|
      m.vm.box="eseo/webapps"
      m.vm.hostname="webapps"
      m.vm.network :private_network, ip: "192.168.56.122"
    end
end
