---
title: Errors when you run GPMC
description: Provides help to fix errors that occur when you run Group Policy Management Console (GPMC).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, bjwhalen
ms.custom: sap:sysvol-access-or-replication-issues, csstroubleshoot
---
# "The Permissions for This GPO in the sysvol folder Are Inconsistent with Those in Active Directory" Message When You Run GPMC

This article provides help to fix errors that occur when you run Group Policy Management Console (GPMC).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 828760

## Symptoms

When you run GPMC in a Microsoft Windows Server domain, and then you click either **Default Domain Policy** or **Default Domain Controllers Policy**, you receive one of the following messages:

- If you have permissions to modify security on the Group Policy objects (GPOs), you receive the following message:  
  > The permissions for this GPO in the sysvol folder are inconsistent with those in Active Directory. It is recommended that these permissions be consistent. To change the permissions in SYSVOL to those in Active Directory, click OK

- If you do not have permission to modify security on the Group Policy objects (GPOs), you receive the following message:  
  > The permissions for this GPO in the sysvol folder are inconsistent with those in Active Directory. It is recommended that these permissions be consistent. Contact an administrator who has rights to modify security on this GPO.

## Cause

This issue occurs because the access control list (ACL) on the Sysvol portion of the Group Policy object is set to inherit permissions from the parent folder.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section of this article.

## Workaround

If you have permissions to modify security on the default GPOs, click **OK** in response to the message that is described in the "Symptoms" section. This action modifies the ACLs on the Sysvol portion of the Group Policy object and makes them consistent with the ACLs on the Active Directory component. In this case, Group Policy will remove the inheritance attribute in the Sysvol folder

## More information

Each Group Policy object (GPO) is stored partly in the Sysvol folder on the domain controller and partly in the Active Directory directory service. GPMC, Group Policy Object Editor, and the old Group Policy user interface that is provided in the Active Directory snap-ins present and manage a GPO as a single unit. For example, when you set permissions on a GPO in GPMC, GPMC sets permissions on objects both in Active Directory and in the Sysvol folder. For each GPO, the permissions in Active Directory must be consistent with the permissions in the Sysvol folder. You must not change these separate objects outside GPMC and Group Policy Object Editor. If you do so, this may cause Group Policy processing on the client to fail, or certain users who generally have access may no longer be able to edit a GPO.

Additionally, file system objects and directory service objects do not have the same available permissions because they are different types of objects. When permissions mismatch, it may not be easy to make them consistent. To help you make sure that the security for the Active Directory and for the Sysvol components of a GPO is consistent, GPMC automatically checks the consistency of the permissions of any GPO when you click the GPO in GPMC. If GPMC detects a problem with a GPO, you receive one of the messages that is described in the "Symptoms" section, depending on whether or not you have permissions to modify security on that GPO.
