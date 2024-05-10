---
title: Upgrade Canonical Ubuntu 18.04 LTS
description: Describes why users need to upgrade Azure Linux virtual machines running Ubuntu 18.04 LTS.
ms.service: virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS)
ms.topic: article
ms.date: 05/09/2024
ms.reviewer: patcatun, clausw, divargas, rondom, azurevmlnxcic, v-weizhu
---
# Canonical Ubuntu 18.04 LTS is out of standard support on May 31, 2023

Even though Canonical Ubuntu 18.04 LTS is out of standard support on May 31, 2023, you can continue to use existing Azure Linux virtual machines (VMs) running it. However, Canonical no longer provides security, feature, and maintenance updates, which may leave your systems vulnerable. We recommend that you either migrate to the next Ubuntu LTS release or upgrade to Ubuntu Pro to gain access to extended security and maintenance from Canonical.

## Upgrade to Ubuntu 20.04 LTS or Ubuntu 22.04

Transitioning to the latest operating system, such as [Ubuntu 20.04 LTS](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-server-focal?tab=Overview) or [Ubuntu Pro 22.04 LTS](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-pro-jammy?tab=Overview), is important for performance, hardware enablement, and new technology benefits, and we recommend doing so for new instances. The transition might be a complex process for existing deployments. Therefore, it should be properly scoped and tested with your workload. Although there's no direct upgrade path from Ubuntu 18.04 LTS to Ubuntu 22.04 LTS, you can directly upgrade to Ubuntu 20.04 LTS and then to Ubuntu 22.04 LTS, or directly install Ubuntu 22.04 LTS. For more information, see the [Ubuntu Server upgrade guide](https://ubuntu.com/server/docs/upgrade-introduction).

> [!NOTE]
> An in-place upgrade to a new major version (for example, upgrading from Ubuntu 18.04 to 20.04) will cause a disconnection between the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes) of the VM. Azure capabilities such as [Auto guest patching](/azure/virtual-machines/automatic-vm-guest-patching), [Auto OS image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [Hotpatching](/windows-server/get-started/hotpatch?toc=%2Fazure%2Fvirtual-machines%2Ftoc.json), and [Azure Update Manager](/azure/update-manager/overview) won't be available. To use these features, we recommend that you create a new VM by using your preferred operating system instead of performing an in-place upgrade.

## Upgrade to Ubuntu Pro – Extended Security Maintenance until 2028

Ubuntu Pro includes security patching for all Ubuntu packages because of Extended Security Maintenance (ESM) for infrastructure and applications and optional full-time (24 hours a day, seven days a week) telephone and ticket support. Ubuntu Pro 18.04 LTS will remain fully supported until April 2028. Ubuntu Pro is free for personal and small-scale commercial users on up to five VMs and has transparent, per-machine pricing for enterprises. New VMs that run Ubuntu Pro can be deployed from the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-pro-bionic?tab=Overview). You can also upgrade existing VMs to [Ubuntu Pro](https://ubuntu.com/pro) by purchasing from Canonical. For more information about the end of standard support for Ubuntu 18.04 LTS, see [Ubuntu 18.04 LTS (Bionic Beaver) on Azure](https://ubuntu.com/18-04/azure). 

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
