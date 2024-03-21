---
title: Netsh utility to export and import DHCP scopes
description: Describes how to use the Netsh utility to export and import DHCP scopes.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\Dynamic Host Configuration Protocol (DHCP), csstroubleshoot
---
# How to use the Netsh utility to export and import DHCP scopes

This article describes how to use the Netsh utility to export and import DHCP scopes.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 281626

## Summary

The Netsh.exe utility in Windows Server 2003 contains two commands that are available for Dynamic Host Configuration Protocol (DHCP): export and import. You can use these commands to selectively export and import DHCP scopes.

## More information

You can use Netsh.exe to import and export DHCP scopes only if the active account is a member of the local Administrators group. If the active account belongs to the Domain Admins group, you may receive an "Access Denied" error message when you use Netsh.exe to import or to export. The Domain Admins group is a member of the built-in Administrators group.

To navigate to the DHCP commands in Netsh.exe, type the following commands from a Netsh command prompt, where **servername** is the name of the DHCP server to be administered:  
dhcp server \\\ **servername**  

From the NETSH DHCP SERVER command prompt, you may then export and import scopes by following below examples.

### Export examples

The following command exports the full service configuration to the c:\Temp\Dhcpdb file:  
export c:\temp\dhcpdb all  
The following command exports the configuration that pertains to scopes 10.0.0.0 and 20.0.0.0 to the c:\Temp\Dhcpdb file:  
export c:\temp\dhcpdb 10.0.0.0 20.0.0.0  

### Import examples

The following command imports the full configuration from the c:\Temp\Dhcpdb file:  
import c:\temp\dhcpdb all  
The following command imports the configuration pertaining to scopes 10.0.0.0 and 20.0.0.0 from the c:\Temp\Dhcpdb file:  
import c:\temp\dhcpdb 10.0.0.0 20.0.0.0
