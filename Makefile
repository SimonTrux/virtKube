
# now does it all
setup:
	./setup.sh

## Need to split install from the setup
#install: setup
# 	./install_vm.sh

start:
	scripts/manipulate_vm.sh start

shutdown:
	scripts/manipulate_vm.sh shutdown

reboot:
	scripts/manipulate_vm.sh reboot

pause:
	scripts/manipulate_vm.sh suspend

resume:
	scripts/manipulate_vm.sh resume

clean:
	rm -rf butane

