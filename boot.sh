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
# https://wiki.gentoo.org/wiki/QEMU/Options
# https://wiki.archlinux.org/title/QEMU
  # -device virtio-net,netdev=net00 \
  # -netdev tap,id=net00,ifname=tap0,script=no,downscript=no,vhost=on \

qemu-system-x86_64 -enable-kvm \
  -machine type=q35,accel=kvm \
  -object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 \
  -drive "file=${disk},if=virtio" \
  -drive "file=${seed},if=virtio,format=raw" \
  -nic user,hostfwd=tcp::2222-:22 \
  -m 512 -nographic
