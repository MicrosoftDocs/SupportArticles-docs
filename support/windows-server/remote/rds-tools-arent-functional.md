---
title: RDS tools aren't functional
description: Provides a solution to an issue where Remote Desktop Services (RDS) tools aren't functional after you remove a server from Server Manager.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, raackley
ms.custom: sap:administration, csstroubleshoot
---
# Remote Desktop Services tools aren't functional after you remove a server from Server Manager

This article provides a solution to an issue where Remote Desktop Services (RDS) tools aren't functional after you remove a server from Server Manager.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2910155

## Symptoms

In a Windows Server 2012 environment, you remove a server from the Server Manager Servers pool that was part of a Remote Desktop Services collection. However, you don't remove the server from the Remote Desktop Services deployment (the list of servers on the "Collections" page). When you select the Remote Desktop Services section in this situation, you receive an error message that resembles the following example:

> The following servers in this deployment are not part of the server pool:  
1.[server_name]  
The servers must be added to the server pool.

## Cause

Although the server is still part of the Remote Desktop Services deployment, it's no longer registered with Server Manager.

## Resolution

You can add the server back to the Server Manager Servers pool. However, if the server was decommissioned or is otherwise permanently offline, you can use PowerShell to remove it from the Remote Desktop Services deployment.

To obtain a list of servers in the deployment and their roles, use the `Get-RDServer` cmdlet. Match the server name to the server name that's listed in the error message. Also note the roles that are listed in the output of `Get-RDServer`. Then, use the `Remove-RDServer` cmdlet to remove the server from the deployment.

Example:

```powershell
PS C:\> Get-RDServer

Server Roles
------ -----
rdhost1.contoso.com {RDS-RD-SERVER, RDS-CONNECTION-BROKER, RDS-WEB-ACCESS}
rdhost2.contoso.com {RDS-RD-SERVER}
```

```powershell
PS C:\> Remove-RDServer rdhost2.contoso.com RDS-RD-SERVER
```

When this process is complete, restart Server Manager. The Remote Desktop Services section should be functional again.

## More information

For more information about remote desktop cmdlets in Windows PowerShell, see [RemoteDesktop](/powershell/module/remotedesktop).
