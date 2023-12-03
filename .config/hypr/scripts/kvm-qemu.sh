#!/bin/sh

# Check virtualization environment
case "$(systemd-detect-virt)" in
  kvm | qemu)
    export WLR_RENDERER_ALLOW_SOFTWARE=1
    ;;
esac
