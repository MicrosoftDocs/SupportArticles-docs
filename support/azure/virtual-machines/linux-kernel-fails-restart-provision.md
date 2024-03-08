---
title: An Azure virtual machine running an older Linux kernel fails to restart or be provisioned
description: Discusses that an Azure virtual machine that is running an older Linux kernel version fails to restart or be provisioned. Provides a resolution.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.custom: linux-related-content
ms.collection: linux
---
# An Azure virtual machine running an older Linux kernel fails to restart or be provisioned

This article provides a solution to an issue in which Azure virtual machine that is running an older Linux kernel version fails to restart or be provisioned.

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4041171

## Symptoms

Consider the following scenario:

- You have a Microsoft Azure Linux virtual machine that is running one of the following Linux distributions.

    | **Linux distribution (distro)**| **Distro version**| **Kernel version** |
    |---|---|---|
    | Ubuntu| 12.04| Any version |
    | Ubuntu| 14.04| < 4.4.0-75 |
    |Ubuntu|16.04| < 4.4.0-75 |
    | SLES|11| Any versions |
    | SLES|12| < 4.4.59.92.12 |
    |Red Hat Enterprise<br/>Linux, CentOS,<br/>Oracle Linux|< 7.3| < 3.10.0-514 |
    |Red Hat Enterprise<br/>Linux, CentOS|< 6.9|< 2.6.32-671|
    |Debian|< 7| Any version |
    |Debian|8|< 4.9|
    |CoreOS|Any|< 4.9|

- The virtual machine restarts, or a new virtual machine provisioning request is made.

In this scenario, the virtual machine becomes unresponsive or provisioning times out. When this problem occurs, an entry that resembles the following is logged in the [Linux serial log](/azure/virtual-machines/linux/boot-diagnostics):  

```
[5.464091] hv_vmbus: probe failed for device vmbus_3 (-110) 
 [6.027866] hv_storvsc: probe of vmbus_3 failed with error -110
```

> [!NOTE]
> This entry may contain additional information.

## Cause

This problem occurs because the Linux virtual machine  does not communicate with the Azure host. This communication failure occurs because of incompatible hyper-call timing parameters in the Hyper-V drivers that exist in older Linux kernels.

## Resolution

To resolve this problem, try [manually restarting](/cli/azure/vm#az-vm-restart) the virtual machine  after some time.  If the problem persists, [redeploy the virtual machine to a new Azure node](/azure/virtual-machines/linux/redeploy-to-new-node), start the virtual machine, and then update the Linux kernel by using the following instructions. You must also perform these steps on the custom image you are using to deploy the VM.  

| **Linux distro**| **Distro version**| **Kernel version that has the fix**| **Update instructions** |
|---|---|---|---|
|Ubuntu|12.04|None available|Upgrade to a later LTS|
| Ubuntu| 14.x| 4.4.0-75 +| Run the following command: <br/>`sudo apt-get update && sudo apt-get install linux-virtual-lts-xenial linux-tools-virtual-lts-xenial linux-cloud-tools-virtual-lts-xenial`<br/><br/>|
| Ubuntu| 16.x| 4.4.0-75 +| Run the following command: <br/>`sudo apt-get update && sudo apt-get install linux-image-virtual linux-tools-virtual linux-cloud-tools-virtual`<br/><br/>|
| SLES|11| Not applicable| Upgrade to SLES 12 |
| SLES|12| 4.4.59.92.12 +| Run the following command: <br/>`sudo zypper update kernel-default`<br/><br/>|
| Red Hat Enterprise Linux, CentOS, Oracle<br/>Linux|6.x|2.6.32-671+| Run the following command: <br/>`yum -y update kernel`<br/><br/>|
|Red Hat Enterprise Linux, CentOS, Oracle<br/>Linux|7.x|3.10.0-514.16+| Run the following command: <br/>`yum -y update kernel`<br/><br/>|
|Debian|7|None available|Upgrade to Debian 9|
| Debian|8|4.9 +| Enable Debian backports, and then run the following command: <br/>`sudo apt-get update && sudo apt-get install linux-image-amd64 hyperv-daemons`<br/><br/>|
| CoreOS|Any|4.9 +|Follow the instructions in [Reboot strategies on updates.](https://github.com/coreos/docs/blob/master/os/update-strategies.md) |
  
## More information

For more information about [Endorsed Linux distributions](/azure/virtual-machines/linux/endorsed-distros) and open-source technologies in Azure, see [Support for Linux and open source technology in Azure](../cloud-services/support-linux-open-source-technology.md).  

**Third-party information disclaimer**
  
The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
