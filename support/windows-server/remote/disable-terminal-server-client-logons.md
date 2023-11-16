---
title: Disable Terminal Server Client Logons
description: Describes how to temporarily disable Terminal Server Client Logons.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, willgloy
ms.custom: sap:administration, csstroubleshoot
ms.technology: windows-server-rds
---
# How to temporarily disable Terminal Server Client Logons

This article describes how to temporarily disable Terminal Server Client Logons.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 186627

## Summary

If you need to disable connectivity to the Terminal Server, you have several options. Disabling connectivity for Terminal Server Clients is different from disabling normal user connectivity. For non-client connectivity, you can pause or stop the Net Logon or Server services in Control Panel/Services. However, the Terminal Server service can't be paused, stopped, or disabled.

## Disable Client connectivity

To disable Client connectivity, you can:

1. Stop connectivity to the Terminal Server at the command prompt with the Command, "Change Logon /Disable." You can re-enable connectivity with "Change Logon /Enable."

2. Stop connectivity to a specific socket connection in Terminal Server Connection Configuration under **Connection/Disable**. It's the same action as opening the connection and selecting **Logon/Disabled** under the **Advanced Configuration**.

3. Stop connectivity for a user or group to a specific socket connection in Terminal Server Connection Configuration under **Security/Permissions**.

4. Stop connectivity for a specific user in User Manager by opening the user account and selecting **CONFIG**. Here you can uncheck the box, **Allow Logon to Terminal Server**. If you modify the user's domain account, the user can't connect to the domain from ANY Terminal Server. The other options are specific to the Terminal Server on which they're set.
