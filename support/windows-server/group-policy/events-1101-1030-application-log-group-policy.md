---
title: Events 1101 and 1030 are logged in the Application log when applying Group Policy
description: Describes a problem that may occur when the Group Policy engine does not have read permissions to the gPLink attribute and the gPOptions attribute of the parent OUs. In this situation, the Group Policy engine cannot apply Group Policy settings.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
ms.subservice: group-policy
---
# Events 1101 and 1030 are logged in the Application log when applying Group Policy

This article provides a resolution for the issue that Events 1101 and 1030 are logged in the Application log when applying Group Policy.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 909260

## Symptoms

On a computer that is running Microsoft Windows XP or newer you may experience the following Error event entries in the Application log: If you enable user environment or GPSVC debug logging, the following entries are logged:

> ProcessGPOs: User name is: UserOrComputerDN , Domain name is: DomainName  
ProcessGPOs: Domain controller is: \\\\ DC FQDN Domain DN is DomainName  
...  
EvaluateDeferredOUs: Object OUName cannot be accessed  
GetGPOInfo: EvaluateDeferredOUs failed. Exiting

> [!NOTE]
> In these entries, **OUName** is the parent organizational unit (OU) of the user account or of a computer object.

## Cause

This problem occurs because the Group Policy engine in Windows XP Professional and newer does not have read permissions to the following attributes of the parent OUs:  

- distinguishedNanme (used in the search filter)
- gPLink (requested as data)
- gPOptions (requested as data)  

If the Group Policy engine does not have these permissions, the Group Policy engine cannot apply Group Policy settings.

In Microsoft Windows 2000 Server, the events that are described in the "Symptoms" section are not logged. The Group Policy engine in Windows 2000 Server then ignores the Group Policy settings that are linked to the OU. Windows XP was changed to not ignore this error.

By default, access to all OUs is granted according to an access control entry in the default security descriptor. This security descriptor is part of the schema that enables the Authenticated Users group to read all the properties.

## Resolution

To resolve this problem, grant sufficient permissions to access the parent OUs to all the user accounts and to all the computers that apply Group Policy settings through the OUs.

Granting permissions on the "distinguishedName" attribute through ACL Editor requires you to change the attribute visibility in DSSEC.DAT in the "[organizationalUnit]" section. You need to change the line "distinguishedname=7" to "distinguishedname=0".

When you then restart the application showing ACL Editor, the attribute should be visible.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
