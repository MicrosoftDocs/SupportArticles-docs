---
title: Error (This property is limited to 64 values) when adding more than 64 logon workstations
description: Describes a problem in which you cannot add more than 64 logon workstation entries by using the user account properties on a Windows Server 2003-based computer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: v-jomcc, kaushika
ms.custom: sap:Active Directory\User, computer, group, and object management, csstroubleshoot
---
# Error message when you try to add more than 64 logon workstations: "This property is limited to 64 values"

This article provides a solution to an error that occurs when try to add more than 64 logon workstations.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 938458

## Symptoms

In **Active Directory Users and Computers**, you try to add more than 64 logon workstation entries on the **Logon To** tab in the user account properties dialog box. After you do this, you may receive the following error message:

> This property is limited to 64 values. You must remove some of the existing values before you can add new ones.

## Cause

This problem occurs because the User-Workstations attribute has a Range-Upper value of 1,024 characters. When you enter the NetBIOS computer names by using **Active Directory Users and Computers**, the NetBIOS name has a maximum length of 16 characters. Therefore, you can store only 64 logon workstation entries.

## Status

This behavior is by design.

> [!NOTE]
> You can change the rangeUpper value on the User-Workstations attribute in the schema to a value up to 8192 to allow more entries in the list. Microsoft does not recommend higher values as you might hit object size limits.

## More information

**rangeUpper** is the Ldap-Display-Name for the Range-Upper value. Range-Upper is the maximum value or the maximum length of an attribute. The User-Workstations attribute is defined in the userWorkstations property of a user. The User-Workstations attribute is a single-valued property that represents a comma-separated list of NetBIOS computer names.

For more information about the User-Workstations attribute, visit the following Microsoft Web site: [User-Workstations attribute](/windows/win32/adschema/a-userworkstations)
