---
title: Disk partition preservation in Azure virtual machines
description: Review which disk partitions are preserved or rebuilt during certain processes (restarts, recoveries, upgrades, reimaging, and so on) on an Azure virtual machine.
ms.date: 09/26/2022
editor: v-jsitser
ms.reviewer: v-maallu, piw, prpillai, v-leedennis
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
#Customer intent: As an Azure virtual machine user, I want to understand which disk partitions are preserved and which disk partitions are rebuilt so that I know what to expect during certain VM processes, such as reboots, recoveries, updates, reimaging, and node migration.
---

# Disk partition preservation

This article outlines the different scenarios that affect your Azure virtual machine (VM) instances, and what happens to the different disks on those VMs.

> [!NOTE]
> This information applies to stateless platform as a service (PaaS) VMs. It doesn't apply to Azure virtual machine persistent VMs.

## Azure disk partitions

The following table describes the contents of the various disk partitions.

| Designation | Use | Description |
|--|--|--|
| C | Local resource disk | This disk contains Azure logs and configuration files, Azure Diagnostics (which includes your Internet Information Services (IIS) logs), and any local storage resources that you define. |
| D | Windows disk | This partition is the operating system (OS) disk. It contains the *Program Files* folder (which includes installations that are done through startup tasks unless you specify another disk), registry changes, the *System32* folder, and .NET Framework. |
| E or F | Application disk | This disk is where your cloud service configuration package (.cspkg) file is extracted to. The disk contains your website, binaries, role host process, startup tasks, *web.config* file, and so on. |

## Disk preservation

The following table shows the different virtual machine processes that might occur, and whether the corresponding disk partitions are preserved or rebuilt for each process.

| Virtual machine process                                                                                                            | C (local resource)  | D (Windows)  | E or F (application)   |
|------------------------------------------------------------------------------------------------------------------------------------|---------------------|--------------|------------------------|
| Virtual machine reboot within the VM*                                                                                              | Preserved           | Preserved    | Preserved              |
| Internal fabric node recovery (power cycle node)                                                                                   | Preserved           | Rebuilt      | Preserved              |
| Portal reboot, host OS update, or stop or start service                                                                            | Preserved           | Preserved    | Rebuilt                |
| Portal reimage or guest OS update                                                                                                  | Preserved           | Rebuilt      | Rebuilt                |
| In-place upgrade (default when deploying from Visual Studio)                                                                       | Preserved           | Preserved    | Rebuilt**              |
| Node migration (server failure)                                                                                                    | Rebuilt             | Rebuilt      | Rebuilt                |
| [Rebuild role instance](/azure/cloud-services-extended-support/sample-reset-cloud-service#rebuild-role-instances-of-cloud-service) | Rebuilt             | Rebuilt      | Rebuilt                |

\* This restart is done from within the virtual machine, such as running the `shutdown /r /t 0` command. The portal restart is done by selecting the **Reboot** button in the Azure portal.

** In this scenario, the application disk will switch from Drive E to F (or F to E). To detect the current application disk, applications should query the `%RoleRoot%` environment variable.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
