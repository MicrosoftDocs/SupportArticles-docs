---
title: Modify filtered properties of an object in ACL Editor
description: Discusses how to change the list of attributes shown in ACL Editor for a specific object type.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# How to modify the filtered properties of an object in ACL Editor for Directory Services objects

This article describes how to modify the filtered properties of an object in ACL Editor for Directory Services objects.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 296490

## Summary

The **Per-Property Permissions** tab for a user object that you view through Active Directory Users and Computers may not display every property of the user object. This is because the user interface for access control filters out object and property types to make the list easier to manage. While the properties of an object are defined in the schema, the list of filtered properties that are displayed is stored in the Dssec.dat file that is located in the %systemroot%\System32 folder on all domain controllers. You can edit the entries for an object in the file to display the filtered properties through the user interface.

## Filtered properties in the Dssec.dat file

A filtered property looks like this in the Dssec.dat file:

[User]  
propertyname=7

To display the read and write permissions for a property of an object, you can edit the filter value to display one or both of the permissions. To display both the read and write permissions for a property, change the value to zero (0):

[User]  
propertyname=0

To display only the write permission for a property, change the value to 1:

[User]  
propertyname=1

To display only the read permissions for a property, change the value to 2:

[User]  
propertyname=2

> [!NOTE]
> After you edit the Dssec.dat file, you must quit and restart Active Directory Users and Computers to see the properties that are no longer filtered.

> [!NOTE]
> The ACL Editor called by ADSIEdit seems to ignore the contents of DSSEC.DAT and shows all attributes by default.
