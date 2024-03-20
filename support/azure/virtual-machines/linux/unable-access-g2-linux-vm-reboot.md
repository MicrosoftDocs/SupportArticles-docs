---
title: Unable to Access Generation 2 Linux VM after a reboot
description: How to mitigate being locked out of Generation 2 Linux VM after a reboot.
ms.date: 10/10/2020
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.custom: linux-related-content
ms.collection: linux
ms.author: genli
author: genlin
ms.reviewer: 
---
# Can't access Generation 2 Linux VM after a reboot

_Original product version:_ &nbsp; Azure  
_Original KB number:_ &nbsp; 4541599

## Summary

Azure allows you to utilize Generation 2 (Gen2) VM Linux Marketplace images, which have multiple benefits. These Gen2 Marketplace images will contain a provisioning agent (either the Linux Agent or cloud-init) that responsible for completing the setup of the VM, such as setting the hostname, username, or password/ssh keys.

We recently discovered that in limited scenarios, on a reboot of a Gen2 VM that contains the cloud-init provisioning agent, you may not be able to access the VM after a VM reboot, using the user account and password specified when the VM was created.

## More information

This only affects Gen2 images (custom or Azure Marketplace) that were provisioned using cloud-init 19.3 or less, as the issue is resolved in cloud-init 19.4.

The Azure Marketplace already offers Ubuntu Server Gen 2 images with cloud-init, and the image versions below include cloud-init 19.4.

- 16.04 - Canonical:UbuntuServer:16_04-lts-gen2:16.04.202001290
- 18.04 - Canonical:UbuntuServer:18_04-lts-gen2:18.04.202001291
To check the version of cloud-init is in the image, run the following script:

    ```
    cloud-init -v
    ```

## Mitigation

If you cannot connect to the VM with the user it was created with, you will need to reset the password using the Azure VM Access extension or the Azure portal:

1. Go to the VM.
2. In the VM Blade, scroll to **Help**.
3. Select **Password Reset**, then select 'Reset password', with the username that cannot access the VM.

## Prevention

You can take preemptive measure to avoid being locked out. If the distro has already released cloud-init 19.4 in their repo, you can upgrade to that using the following **apt command**.

```bash
sudo apt-get upgrade cloud-init
```

## Frequently asked questions

**Q:** I created a VM with a user and SSH Keys, does this apply to me?  
 **A:** No. This is only known to occur when using password authentication.  

**Q:** Does this just affect Ubuntu Server Marketplace images?  
 **A:** Canonical Ubuntu Server Marketplace images are provisioned by default using cloud-init. However, there could be other Azure Marketplace offerings that provision using cloud-init.

**Q:** I am using Generation 1 images, can this scenario occur there?  
 **A:** No, this only impacts Generation 2 images.

**Q:** Could this happen on every reboot?  
 **A:** No. This will not happen on every reboot, it will occur once.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
