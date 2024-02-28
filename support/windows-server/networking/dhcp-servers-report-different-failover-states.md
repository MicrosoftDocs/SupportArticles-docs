---
title: DHCP servers don't replicate lease information
description: Resolves two issues that occur when you use DHCP failover in Windows Server 2012.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, joelch, waltere
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
---
# DHCP servers report different failover states or do not replicate lease information in a Windows Server 2012-based DHCP failover relationship

This article provides help to solve some known issues with Dynamic Host Configuration Protocol (DHCP) failover.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2751456

## Symptoms

You experience one or more of the following issues when you use DHCP failover in Windows Server 2012:

- Two DHCP servers in a failover relationship report different failover states. This issue occurs even though both servers are connected to the network. 
- Some lease information is not replicated successfully between the two DHCP servers even though both servers report a typical failover state. 

## Cause

These are known issues with DHCP failover in Windows Server 2012. These issues occur when the following conditions are true:

- Existing scopes are migrated to Windows Server 2012 by using netsh dhcp server export and netsh dhcp server import  commands. Or, an existing DHCP server is upgraded to Windows Server 2012.
- A scope has one or more inactive reservations when the scope is migrated or when the DHCP server is upgraded.

## Resolution

To resolve these issues, apply the cumulative update package that is described in the following article in the Microsoft Knowledge Base: [2756872](https://support.microsoft.com/help/2756872) Windows 8 Client and Windows Server 2012 General Availability Cumulative Update

> [!NOTE]
> To resolve the issues in an existing failover relationship, delete the relationship before you apply the update package, and then re-create the failover relationship. These issues do not occur if a failover relationship is created after you apply the cumulative update package.

## Workaround

To work around these issues, use the following Windows PowerShell commands to migrate scopes to Windows Server 2012:

- Export-DhcpServer
- Import-DhcpServer The following is a sample set of commands:

    ```powershell
    Export-DhcpServer $env:SystemRoot\System32\Dhcp\Temp.txt -Leases
    Import-DhcpServer -BackupPath $env:SystemRoot\System32\Dhcp\Backup -File $env:SystemRoot\System32\Dhcp\Temp.txt -ScopeOverwrite -Leases
    Restart-Service DHCPServer
    ```

## More information

These issues do not occur if scopes are migrated by using the Windows PowerShell commands Export-DhcpServer and Import-DhcpServer.
