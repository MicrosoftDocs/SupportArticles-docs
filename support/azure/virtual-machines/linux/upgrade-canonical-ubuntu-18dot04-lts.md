---
title: Upgrade Canonical Ubuntu 18.04 LTS
description: Describes why users need to upgrade Azure Linux virtual machines running Ubuntu 18.04 LTS.
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
ms.date: 05/09/2024
ms.reviewer: patcatun, clausw, divargas, rondom, azurevmlnxcic, v-weizhu
---
# Canonical Ubuntu 18.04 LTS is out of standard support on May 31, 2023

**Applies to:** :heavy_check_mark: Linux VMs

Canonical Ubuntu 18.04 LTS reached the end of standard support on May 31, 2023. Although you can continue to use existing Azure Linux virtual machines (VMs) that are running Ubuntu 18.04 LTS, these VMs could become vulnerable because Canonical no longer provides security, feature, and maintenance updates for the OS. Therefore, we recommend that you either migrate to the next Ubuntu LTS release or upgrade to Ubuntu Pro.

## Upgrade to Ubuntu 20.04 LTS or Ubuntu 22.04

To take advantage of improved performance, hardware enablement, and new technology, you should transition to the latest operating system, such as [Ubuntu 20.04 LTS](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-server-focal?tab=Overview) or [Ubuntu Pro 22.04 LTS](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-pro-jammy?tab=Overview). The transition might be complex for existing deployments. Therefore, it should be properly scoped and tested with your workload. 

There's no direct upgrade path from Ubuntu 18.04 LTS to Ubuntu 22.04 LTS. However, you can directly upgrade to Ubuntu 20.04 LTS and then to Ubuntu 22.04 LTS, or you can directly install Ubuntu 22.04 LTS. For more information, see the [Ubuntu Server upgrade guide](https://ubuntu.com/server/docs/upgrade-introduction).

> [!NOTE]
> An in-place upgrade to a new major version (for example, upgrading from Ubuntu 18.04 to 20.04) breaks the connection between the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes) of the VMs. Consequently, Azure capabilities such as [Auto guest patching](/azure/virtual-machines/automatic-vm-guest-patching), [Auto OS image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [Hotpatching](/windows-server/get-started/hotpatch?toc=%2Fazure%2Fvirtual-machines%2Ftoc.json), and [Azure Update Manager](/azure/update-manager/overview) won't be available. To access these features, we recommend that you create a VM (by using your preferred OS) instead of performing an in-place upgrade.

## Upgrade to Ubuntu Pro - Extended Security Maintenance until 2028

Ubuntu Pro is an enhanced offering that includes security updates for all Ubuntu packages. It provides Extended Security Maintenance (ESM) for infrastructure and applications and optional full-time (24 hours a day, seven days a week) telephone and ticket support. Ubuntu Pro 18.04 LTS remains fully supported until April 2028. 

You can deploy new VMs that run Ubuntu Pro from the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-pro-bionic?tab=Overview). You can upgrade your Ubuntu Server (version 16.04 or higher) VM to Ubuntu Pro through an [in-place upgrade](/azure/virtual-machines/workloads/canonical/ubuntu-pro-in-place-upgrade). Alternatively, you can directly purchase the system from [Canonical](https://ubuntu.com/pro). 

For more information about the end of standard support for Ubuntu 18.04 LTS, see [Ubuntu 18.04 LTS (Bionic Beaver) on Azure](https://ubuntu.com/18-04/azure). 

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
