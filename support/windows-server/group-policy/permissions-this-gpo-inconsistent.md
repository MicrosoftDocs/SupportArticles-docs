---
title: Permissions for this GPO are inconsistent
description: Describes a permissions issue that occurs when you run Group Policy Management Console in a Windows 2008 or Windows Server 2003 domain. A resolution is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc
ms.custom: sap:Group Policy\Group Policy management (GPMC or GPedit), csstroubleshoot
---
# "Permissions for this GPO in the SYSVOL folder are inconsistent with those in Active Directory" message when you run GPMC

This article provides a solution to a permissions issue that occurs when you run Group Policy Management Console in a Windows 2008 or Windows Server 2003 domain.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2838154

## Symptoms

When you run Group Policy Management Console (GPMC) in a Windows Server 2008 or Windows Server 2003 domain, and then you select either **Default Domain Policy** or **Default Domain Controllers Policy**, you receive one of the following messages:

- > The permissions for this GPO in the SYSVOL folder are inconsistent with those in Active Directory. It is recommended that these permissions be consistent. To change the permissions in SYSVOL to those in Active Directory, click OK.

    You receive this message if you have the permissions to modify security on the Group Policy Objects (GPOs).

- > The permissions for this GPO in the SYSVOL folder are inconsistent with those in Active Directory. It is recommended that these permissions be consistent. Contact an administrator who has rights to modify security on this GPO.

    You receive this message if you don't have the permissions to modify security on the Group Policy Objects (GPOs).

## Cause

This issue occurs for one of the following reasons:

- The access control list (ACL) on the Sysvol part of the Group Policy Object is set to inherit permissions from the parent folder.
- The Special permission (List object) is set for the Authenticated Users group. However, the Authenticated Users group is missing from the **Delegation** tab of the Group Policy Object.

## Resolution

If you have permissions to modify security on the default GPOs, select **OK** in response to the message that is mentioned in the [Symptoms](#symptoms) section. This action modifies the ACLs on the Sysvol part of the Group Policy Object and makes them consistent with the ACLs on the Active Directory component. In this situation, Group Policy removes the inheritance attribute in the Sysvol folder.

If you still receive the message, follow these steps:

1. Make sure that you're running the latest service pack for the system. For more information, see:
    - [How to obtain the latest service pack for Windows Server 2008](https://support.microsoft.com/help/968849)

2. Check whether the List object permission is set for the Authenticated Users group and whether the Authenticated Users group is missing from the **Delegation** tab of the Group Policy Object.

    :::image type="content" source="media/permissions-this-gpo-inconsistent/authenticated-users.png" alt-text="Check whether the Authenticated Users group is missing.":::

    :::image type="content" source="media/permissions-this-gpo-inconsistent/delegation-tab.png" alt-text="Check whether the List object permission is set for the Authenticated Users group." border="false":::

If these conditions are true, take one of the following actions:

1. Select **Restore defaults** to reset the permissions to defaults.
2. Remove the Authenticated Users group that has the List object permission (not recommended).
