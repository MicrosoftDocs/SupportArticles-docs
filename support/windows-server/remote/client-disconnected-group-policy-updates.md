---
title: Client is disconnected during Group Policy update
description: Describes an issue in which clients are disconnected from Remote Desktop sessions.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# Remote Desktop sessions may be disconnected during Group Policy updates in Windows Server

This article provides a solution to an issue where clients are disconnected from Remote Desktop sessions during Group Policy updates.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2083411

## Symptoms

When you use the Remote Desktop Services role to enable clients to connect remotely, those clients may be suddenly disconnected. After this issue occurs, connections can then be reestablished within a brief period.

## Cause

This issue may occur if the following conditions are true:  

- You have configured the Don't allow connections to this computer Remote Desktop setting on the server. Or, you have installed the unattended Remote Desktop role, without configuring the allowed connections.
- You have configured the Allow users to connect remotely using Terminal Services  Group Policy setting to override the setting on the server.  
When the policy is refreshed (by default, every 90 minutes, or manually through GPUPDATE), the policy settings are deleted and then reset. During this period, the configuration on the server is temporarily valid. Therefore, all sessions may be disconnected.

## Resolution

To resolve this issue, set the fDenyTSConnections registry value to 0. (See the "More information" section.)

> [!NOTE]
> When Remote Desktop Services is installed, the default setting is Allow connections only from computers running Remote Desktop with Network Level Authentication (more secure).  

## More information

This setting is controlled by the following registry subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server
fDenyTSConnections`  
When this value is set to 1, no connections are allowed. However, Group Policy can override this setting. During the Group Policy refresh process, this local setting may be temporarily valid.
