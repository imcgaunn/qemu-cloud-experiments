#!/bin/zsh

# stolen from https://asciinema.org/a/132009

disk="${1}"
seed="${2}"  # create with cloud-localds -v ./<seed.img> ./user-data /user-meta-data

#    Example:
#    * cat my-user-data
#      #cloud-config
#      password: passw0rd
#      chpasswd: { expire: False }
#      ssh_pwauth: True
#    * echo "instance-id: $(uuidgen || echo i-abcdefg)" > my-meta-data
#    * cloud-localds my-seed.img my-user-data my-meta-data
#    * kvm -net nic -net user,hostfwd=tcp::2222-:22 \
#         -drive file=disk1.img,if=virtio -drive file=my-seed.img,if=virtio
#    * ssh -p 2222 ubuntu@localhost
#

qemu-system-x86_64 -enable-kvm \
  -drive "file=${disk},if=virtio" \
  -drive "file=${seed},if=virtio,format=raw" \
  -drive virtio-net-pci,netdev=net00 \
  -netdev type=user,id=net00 -m 512 -nographic
