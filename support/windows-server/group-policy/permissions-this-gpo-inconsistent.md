---
title: Permissions for this GPO are inconsistent
description: Describes a permissions issue that occurs when you run Group Policy Management Console in a Windows Server domain. A resolution is provided.
ms.date: 04/29/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, arrenc
ms.custom: sap:Group Policy\Group Policy management (GPMC or GPedit), csstroubleshoot
---
# "Permissions for this GPO in the SYSVOL folder are inconsistent with those in Active Directory" message when you run GPMC

This article provides a solution to a permissions issue that occurs when you run Group Policy Management Console in a Windows Server domain.

_Applies to:_ &nbsp; Windows Server (All supported versions)  
_Original KB number:_ &nbsp; 2838154

## Symptoms

When you run Group Policy Management Console (GPMC), and then you select a Group Policy, you receive one of the following messages:

- > The permissions for this GPO in the SYSVOL folder are inconsistent with those in Active Directory. It is recommended that these permissions be consistent. To change the permissions in SYSVOL to those in Active Directory, click OK.

    You receive this message if you have the permissions to modify security on the Group Policy Objects (GPOs).

- > The permissions for this GPO in the SYSVOL folder are inconsistent with those in Active Directory. It is recommended that these permissions be consistent. Contact an administrator who has rights to modify security on this GPO.

    You receive this message if you don't have the permissions to modify security on the Group Policy Objects (GPOs).

## Cause

This issue occurs for one of the following reasons:

- The access control list (ACL) on the Sysvol part of the Group Policy Object is set to inherit permissions from the parent folder.
- Manual changes to the permissions on SysVol can cause a mismatch between the policy permissions in Active Directory and SysVol.

## Resolution

If you have permissions to modify security on the default GPOs, select **OK** in response to the message that is mentioned in the [Symptoms](#symptoms) section. This action modifies the ACLs on the Sysvol part of the Group Policy Object and makes them consistent with the ACLs on the Active Directory component. In this situation, Group Policy removes the inheritance attribute in the Sysvol folder if the attribute is present.

If you still receive the message, check whether permissions are set for the **Authenticated Users** group and correct the permissions if needed. A problematic setting is when accounts have the **List Object** permission in Active Directory. This permission doesn't map to a file system permission. Below is an example configuration for **Authenticated Users**:

:::image type="content" source="media/permissions-this-gpo-inconsistent/authenticated-users-permissions.png" alt-text="Authenticated Users permissions." border="true":::

Advanced permissions:

:::image type="content" source="media/permissions-this-gpo-inconsistent/authenticated-users-has-a-list-object-access.png" alt-text="Authenticated Users has a List Object access." border="true":::

> [!NOTE]
> Remember to set read and apply permissions according to [MS16-072: Description of the security update for Group Policy: June 14, 2016 - Microsoft Support](https://support.microsoft.com/topic/ms16-072-description-of-the-security-update-for-group-policy-june-14-2016-3cf9032b-ea6d-0125-0159-f3b3ce146400).

If this applies, take one of the following actions:

1. Select **Restore defaults** to reset the permissions to defaults.
2. Remove the group that has the **List object** permission from Active Directory permissions.
3. If appropriate, replace the entry for the account, such as **Authenticated Users**, with an Access Control Entry (ACE) that grants read and, if needed, Group Policy permissions. Specify the account in the **Scope** tab in GPMC.msc:

:::image type="content" source="media/permissions-this-gpo-inconsistent/screenshot-of-the-default-domain-controller-policy.png" alt-text="The screenshot of the default domain controller policy." border="true":::

Or you can do this in the **Advanced Permissions**:

:::image type="content" source="media/permissions-this-gpo-inconsistent/screenshot-of-the-advanced-permissions.png" alt-text="The screenshot of the Advanced Permissions." border="true":::
