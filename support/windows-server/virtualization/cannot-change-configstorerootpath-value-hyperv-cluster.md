---
title: Can't change the ConfigStoreRootPath value of a Hyper-V cluster
description: Provides the information that no value is set for the ConfigStoreRootPath attribute in the default configuration of a cluster resource. If a value is set, it cannot be changed afterwards.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, akshittu, maperric, v-lianna
ms.custom: sap:high-availability-virtual-machines, csstroubleshoot
---
# Can't change the ConfigStoreRootPath value of a Hyper-V cluster in Windows Server

_Original KB number:_ &nbsp; 4488568

When configuring the cluster resources of a Hyper-V cluster in Windows Server 2016 and Windows Server 2019, assume that you have already set a value of the `ConfigStoreRootPath` attribute by using the following cmdlet:

```powershell
Get-ClusterResource -Cluster "Virtual Machine Cluster WMI" | Set-ClusterParameter -Name ConfigStoreRootPath -Value <Value>
```

When trying to change the `ConfigStoreRootPath` value by using the cmdlet, you receive this error message:

> The request is not supported

> [!NOTE]
> The value depends on the location of the shared storage volume or its subfolders. You can verify the location by using the following cmdlet:
>
> ```powershell
> Get-ClusterResource -Cluster "Virtual Machine Cluster WMI" | Get-ClusterParameter ConfigStoreRootPath
> ```

That's by design. No value is set for the `ConfigStoreRootPath` attribute in the default configuration of a cluster resource. If a value is set, this value will be propagated to several components across the platform. It can't be changed afterwards.

> [!NOTE]
> Changing the value of the `ConfigStoreRootPath` attribute in the cluster registry isn't supported either.
