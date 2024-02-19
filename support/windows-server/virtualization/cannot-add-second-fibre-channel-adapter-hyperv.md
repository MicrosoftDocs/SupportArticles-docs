---
title: VM cannot add Fibre Channel adapter
description: Provides the information that Windows Server 2019 allows only one Fibre Channel adapter per virtual machine.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rblume, v-lianna
ms.custom: sap:storage-configuration, csstroubleshoot
---
# Can't add a second Fibre Channel adapter to a Hyper-V virtual machine

When trying to add a second Fibre Channel adapter to a Hyper-V virtual machine in Windows Server 2019, the **Fibre Channel Adapter** option isn't available and this error message is displayed:

> Cannot add Fibre Channel Adapter  
Maximum of 1 Fibre Channel Adapters per virtual machine

:::image type="content" source="media/cannot-add-second-fibre-channel-adapter-hyperv/cannot-add-fibre-channel-adapter-warning.png" alt-text="The warning that occurs when you try to add Fibre Channel Adapter under Add Hardware.":::

Windows Server 2019 allows only one Fibre Channel adapter per virtual machine.

To add a second virtual Fibre Channel host bus adapter to a virtual machine, use the [Add-VMFibreChannelHba](/powershell/module/hyper-v/add-vmfibrechannelhba) PowerShell cmdlet.
