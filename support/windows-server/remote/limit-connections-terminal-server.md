---
title: Limit connections on a terminal server
description: Describes how to make sure that only one user at a time can connect to a Windows Server 2003 terminal server in Remote Administration Mode remotely or at the console.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:administration, csstroubleshoot
---
# How to limit the number of connections on a terminal server

This article describes how to make sure that only one user at a time can connect to a Windows Server 2003 terminal server in Remote Administration Mode remotely or at the console.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 830581

## Summary

This article describes how to make sure that only one user at a time can connect to a Windows Server 2003 terminal server in Remote Administration Mode remotely or at the console. By default, with a Windows Server 2003 terminal server in Remote Administration mode, you can have two remote sessions and one console session, for a total of three active sessions.

### How to limit the number of remote sessions on a terminal server

1. To open the Terminal Services Configuration Tool, click **Start**, point to **Administrative Tools**, and then click **Terminal Services Configuration**.
2. In the console tree, click **Connections**.
3. In the right-side pane, right-click **RDP-Tcp**, and then click **Properties**.
4. On the **Network Adapter** tab, click to select **1** from the **Maximum connections** list.
5. On the **Permissions** tab, click **Add**, type Everyone in the **Enter the object names to select (examples)** box, click **Check Names**, and then click **OK**.
6. In the **Group or user names** area, click to select the **Everyone** group.
7. In the **Permissions for Everyone** area, click to select the **Deny** check box to deny permission for **Guest Access**, and then click **OK**.

> [!NOTE]  
>
> - This setting allows only one remote connection, known as session 0. This connection can be made only through the console.
> - When you connect to the console session of a terminal server on a Windows XP-based computer or on a Windows Server 2003-based computer, use the following commands as appropriate:  
>
>   - To make a Remote Desktop connection to the server, use the mstsc.exe /console command.
>   - If you use the Remote Desktop Connection 6.1 client or a later version of the client, use the mstsc.exe /admin command.
