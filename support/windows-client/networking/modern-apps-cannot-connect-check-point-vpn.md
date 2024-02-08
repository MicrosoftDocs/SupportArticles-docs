---
title: Modern Apps can't connect when you use a Check Point VPN connection
description: Discusses that Modern Apps can't connect to the Internet after you connect to the corporate network by using Check Point VPN software. Provides a workaround.
ms.date: 05/10/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: rnitsch, kaushika
ms.custom: sap:remote-access, csstroubleshoot
ms.subservice: networking
---
# Modern Apps can't connect when you use a Check Point VPN connection

This article provides a solution to an issue where Modern Apps can't connect to the Internet after you connect to the corporate network by using Check Point VPN software.

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2855849

## Symptoms

Consider the following scenario:

- You use a version of Check Point Endpoint Remote Access VPN that is earlier than E80.50.
- You're running Windows 8 Modern Applications (Store Apps) and classic desktop applications successfully.
- You connect to the corporate network by having the Check Point VPN client software in "hub mode" (that is, all traffic is routed through the virtual network adapter).
- After you make the connection, the Network Status indicator shows that Internet connectivity is fully available.

In this scenario, Classic Apps can connect successfully to the Internet. However, Modern Apps can't connect. Also, the desktop version of Windows Internet Explorer 10 can't connect if Enhanced Security Mode is enabled.

## Cause

This issue occurs because the installed firewall can't set rules that allow Modern Apps to communicate through the virtual private network.

## Resolution

To resolve this issue, install Check Point VPN E80.50 (expected to be available Fall 2013) from the following Check Point Support Center website:

[Remote Access (VPN) Clients](https://supportcenter.checkpoint.com/supportcenter/portal?eventsubmit_doshowproductpage&producttab=overview&product=175)

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, run following Windows PowerShell script to change the hidden property for the virtual network interface in the registry:

```powershell
foreach ($subkey in (gci "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318} -erroraction silentlycontinue))
{
    if ((get-itemproperty $subkey.pspath).ComponentID eq cp_apvna)
    {
        set-itemproperty $subkey.pspath name Characteristics value 0x1
    }
}
```

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.
