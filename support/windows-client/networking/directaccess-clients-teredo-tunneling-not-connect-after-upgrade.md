---
title: DirectAccess clients that use Teredo tunneling cannot connect after upgrade to Windows 10
description: Address an issue in which DirectAccess clients that use Teredo tunneling cannot connect after you upgrade the system to Windows 10.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, v-jesits, minh
ms.custom: sap:remote-access, csstroubleshoot
ms.subservice: networking
---
# DirectAccess clients that use Teredo tunneling cannot connect after upgrade to Windows 10

This article provides a solution to an issue where DirectAccess clients that use Teredo tunneling cannot connect after upgrade to Windows 10.

_Applies to:_ &nbsp; Windows 10, version 1809, and later versions, Windows 10, version 1803  
_Original KB number:_ &nbsp; 4510763

## Symptoms

On a computer on which you have DirectAccess clients configured to use Teredo tunneling, you upgrade the operating system to Windows 10, version 1803 and later versions of Windows 10. After the upgrade, the DirectAccess clients cannot connect.

At this point, if you run `netsh interface teredo`, the command returns a message that states that Teredo tunneling is disabled.

## Cause

This issue occurs because Teredo tunneling is disabled by default in Windows 10, version 1803 and later versions of Windows 10.

## Resolution

### How to avoid this issue

Before you upgrade the system to Windows 10, make sure that Teredo tunneling is enabled by using Group Policy.

To do this, browse to the following policy in Group Policy:  
**Computer Configuration** > **Policies** > **Administrative Templates** > **Network** > **TCPIP Settings** > **IPV6 Transition Technologies** > **Set Teredo State**

Then, set the states to **Client** or **Enterprise Client**.  

### How to fix this issue

If you already experience this issue, use one of the following methods to fix it.

- Run the following command on each DA client to enable Teredo tunneling:

    ```console
    netsh interface teredo set state Enterprise
    ```

- Configure the **Set Teredo State** Group Policy that is mentioned under "How to avoid this issue" to enable Teredo tunneling.

> [!Note]
> If you have to connect to the internal resource remotely to configure the policy, use IPHTTPS to connect to the DirectAccess Server or use VPN.
