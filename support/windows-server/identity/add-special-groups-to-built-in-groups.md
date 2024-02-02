---
title: Add special groups to built-in groups
description: Describes how to add special groups to built-in groups.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.subservice: active-directory
---
# How to add special groups to built-in groups

This article describes how to add special groups to built-in groups.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 292781

## Summary

If you, as the administrator, delete one of the memberships of a special group, such as Authenticated Users, from a Built-in Domain Local Users group on a domain controller in Windows, you cannot readd the group by using the Active Directory Users and Computers tool. To add one of the special groups to a domain local group on a domain controller, use the `net localgroup` command.

For example, use the following command to add the Authenticated Users group back to the Built-in Domain Local Users group on a domain controller:

`net localgroup users "nt authority\authenticated users" /add`  

## More information

In Windows, there are certain special groups that are created by the system and that are used for special purposes. A list of these special groups includes:

Authenticated Users  
Anonymous Logon  
Batch  
Creator Owner  
Creator Group  
Dialup  
Enterprise Domain Controllers  
Everyone  
Interactive  
Network  
Proxy  
Restricted  
Self  
Service  
System  
Terminal Server User  

Because you cannot alter the membership of these groups, the groups are not listed in Active Directory Users and Computers (`Dsa.msc`). However, these groups are useful for operations such as assigning permissions to directories, files, shared network directories, or printers.

Users become members of these special groups depending on the operation that they're trying to perform. For example, a user gains the Interactive group membership in their token whenever they use a computer locally. The Network group would be added to a user's token anytime that a user connects over the network to a computer.
