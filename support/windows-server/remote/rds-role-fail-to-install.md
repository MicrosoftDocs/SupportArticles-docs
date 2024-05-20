---
title: RDS fails to install with error 0x800706D9
description: Provides a solution to an issue where Remote Desktop Services fails to install and you get the error code 0x800706D9.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Deployment, configuration, and management of Remote Desktop Services infrastructure, csstroubleshoot
---
# The Remote Desktop Services or Terminal Services Role fails to install when FireWall Service is set to disabled

This article provides a solution to an issue where Remote Desktop Services fails to install and you get the error code 0x800706D9.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2027551

## Symptoms

When installing the Remote Desktop Services Role on Windows Server 2008 server, you may receive the following error:

> Attempt to configure Terminal Server failed with error code *0x800706D9*. "There are no more endpoints available from the endpoint mapper"

During the process of installation you will receive the following error:

> Terminal Services  
Terminal Server  
\<Warning>: You may need to reinstall existing applications.  
\<Informational>: IE Enhanced Security Configuration will be turned off.  
Authentication method do not require Network Level Authentication  
Licensing mode Per user  
Groups allowed access Administrators, Domain\User  
TS Licensing  
Terminal Services: Restart Pending  
\<Warning>: You must restart this server to finish the installation process.  
>
> Full log (for troubleshooting only)  
Terminal Services: Installation succeeded with errors  
\<Error>: Attempt to configure Terminal Server failed with error code 0x800706D9. There are no more endpoints available from the endpoint mapper  
>
> The following role services were installed:  
Terminal Server  
Full log (for troubleshooting only)  
Operating System: Windows Server 2008

## Cause

The issue occurs if the Windows Firewall service is set to disabled. When the Windows Firewall service is not running, firewall exception cannot be set. This causes the WMI call *SetAllowTSConnections* that sets the RDP settings to fail.

The Installation uses the *SetAllowTSConnections* Method of the *Win32_TerminalServiceSetting* WMI Class to enable Remote Desktop and also to configure firewall exceptions.

## Resolution

The Firewall Service  startup type should be set to Automatic and the status should be  Started  when installing the Remote Desktop Services role.

## More information

[SetAllowTSConnections Method of the Win32_TerminalServiceSetting Class](/windows/win32/termserv/win32-terminalservicesetting-setallowtsconnections)
