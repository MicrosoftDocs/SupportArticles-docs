---
title: Azure cloud-init support for Linux VMs
description: This article explains the support scenario for cloud-init in Azure. 
ms.date: 10/10/2020
ms.service: azure-virtual-machines
ms.custom: sap:VM Extensions not operating correctly, linux-related-content
ms.collection: linux
ms.author: genli
author: genlin
ms.reviewer: 
---
# Azure cloud-init support for Linux VMs

**Applies to:** :heavy_check_mark: Linux VMs

_Original KB number:_ &nbsp; 4538385

## Summary

The service 'cloud-init' is an open-source project provisioning agent that can be baked into Linux images, and is responsible for completing the setup of a newly created Virtual Machine (VM). 'cloud-init' can perform such tasks as setting the hostname, username, password/ssh keys, or mounting the ephemeral disk. The process of completing the setup is known as 'provisioning'.

In addition to setting the minimum required configuration options described above, 'cloud-init' can process VM configurations, in multiple user-data formats, such as cloud-init configurations, scripts etc.

## More information

Azure [cloud-init](/azure/virtual-machines/linux/using-cloud-init) documentation defines which cloud-init versions and OS versions are supported, support defines that the configuration of those versions is supported, note, the OS image can be a custom image or an Azure Marketplace image.
Support for 'cloud-init' is inherited from the article [Support for Linux and open source technology in Azure](https://support.microsoft.com/help/2941892/support-for-linux-and-open-source-technology-in-azure), but with the following clarifications:

Microsoft support will assist you if you have issues provisioning a Virtual Machine (VM) with the minimum required configuration options:

- VM Name
- UserName
- Password
- SSH Keys
- Ensuring user data is passed to the VM
- Mounting and formatting the ephemeral disk

If you pass in user-data, that pass modifies the configuration of the VM. If you find that it is not processed as expected, and need support, Microsoft support will assist on a best effort basis, you may be asked to raise an issue with the 'cloud-init' upstream maintainers [here](https://github.com/canonical/cloud-init#getting-help).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
