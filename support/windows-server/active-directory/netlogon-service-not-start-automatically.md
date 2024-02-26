---
title: Netlogon doesn't keep settings
description: Describes an issue that prevents the Netlogon service on domain controllers from starting automatically after you upgrade to Windows Server 2016 or Windows Server 2019. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:domain-join-issues, csstroubleshoot
---
# Netlogon service doesn't keep settings after an in-place upgrade to Windows Server 2016 or Windows Server 2019

This article provides a resolution for an issue that prevents the Netlogon service on domain controllers from starting automatically after you upgrade to Windows Server 2016 or Windows Server 2019.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 3201247

## Symptoms

Assume that you have one or more computers that are running Windows Server 2012 or Windows Server 2012 R2 and configured as domain controllers or member servers in an Active Directory domain. You decide to do an in-place upgrade on the domain controllers to Windows Server 2016 or Windows Server 2019.

After you upgrade the domain controllers, you notice that one or more of the following symptoms occur:

- User logon failures
- SID to name translation fails in object picker UIs
- RDP connection failures
- DNS SRV resource record registration failures
- The firewall profile on member servers and workstations fails to select the domain profile

Additionally, you may receive the following event in the System log:

> Log Name: System  
Source: Microsoft-Windows-Time-Service  
Date: **date** **time**  
Event ID: 46  
Task Category: None  
Level: Error  
Keywords:  
User: LOCAL SERVICE  
Computer: **computer_name**  
Description:  
The time service encountered an error and was forced to shut down. The error was: 0x80070700: An attempt was made to logon, but the network logon service was not started.

## Cause

This issue occurs because the in-place upgrade process doesn't set the startup value for the Netlogon service type to Automatic on the upgraded server. When the Netlogon service isn't running, a domain controller doesn't advertise itself as a domain controller, and all the other functionality and dependencies of the Netlogon service fail. Any service that depends on Netlogon to be running also fails.

## Resolution

This issue can be avoided by letting the setup process install the latest updates during the in-place upgrade.

If the issue already occurs, to resolve this problem, change the Netlogon service Startup type to Automatic. To do this, follow these steps:

1. Click **Start**, type *services.msc* in the **Start Search** box, and then click **Services Desktop** app.
2. Locate and double-click Netlogon, and then click **Automatic** in the **Startup type** box.
3. Click **OK**, and then start the Netlogon service.

Although this action doesn't require a restart, we recommend that you restart the computer to make sure that all services that depend on Netlogon are started and correctly registered on the Network.

## References

[Windows Time Service settings aren't preserved during an in-place upgrade to Windows Server 2016 or Windows 10 Version 1607](windows-time-service-values-reverted.md)
