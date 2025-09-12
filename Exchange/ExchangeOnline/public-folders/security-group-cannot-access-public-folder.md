---
title: Security group can't access a public folder in Exchange Online
description: Provides a resolution for an issue in which the members of a security group can no longer access a public folder in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
  - CI 188307
ms.reviewer: mahmoudadel, batre, meerak, v-trisshores
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 06/06/2024
---

# Security group can't access a public folder in Exchange Online

## Symptoms

Security group members can't access a public folder in Exchange Online even though the security group seems to have the appropriate access rights.

As an example, the [Get-PublicFolderClientPermission](/powershell/module/exchange/get-publicfolderclientpermission) PowerShell cmdlet generates the following output.

:::image type="content" source="media/security-group-cannot-access-public-folder/public-folder-permissions-command-output.png" border="false" alt-text="Screenshot of the output from the Get-PublicFolderClientPermission cmdlet.":::

The output shows that `Security group1` has [PublishingEditor](/powershell/module/exchange/set-mailboxfolderpermission#-accessrights) access rights to a public folder. However, if the security group members try to create, move, or delete a subfolder in the public folder, they receive an error message that indicates a lack of permissions.

## Cause

The issue occurs if the security identifier of the security group object in Microsoft Entra ID changes after the group is granted access to the public folder. If the security identifier changes, the security group no longer matches the entry in the access rights list for the public folder. Therefore, even though the security group entry is still in the access rights list, the security group members can no longer access the public folder.

> [!NOTE]
> To check the security identifier value for a security group, run the following commands in Exchange Online PowerShell:
>
> ```PowerShell
> $permissions = Get-PublicFolderClientPermission -Identity "<public folder>" -User "<security group name>"
> $permissions.User.RecipientPrincipal | FL DisplayName, Sid
> ```

Both the following scenarios cause the security identifier to change.

### Scenario 1

**Step 1**: You create a security group in Exchange Server, and then you sync from on-premises Active Directory to Microsoft Entra ID. The mail-enabled security group appears in Exchange Online.

**Step 2**: You grant the security group in Exchange Online access rights to a public folder in Exchange Online. The security group members can now access the public folder.

**Step 3**: You delete the on-premises security group in on-premises Active Directory.

**Step 4**: You restore the on-premises security group in on-premises Active Directory, and then you resync on-premises Active Directory to Microsoft Entra ID.

After step 4 is completed, the security group members can no longer access the public folder.

### Scenario 2

**Step 1**: You create a mail-enabled security group in Exchange Online.

**Step 2:** You grant the security group access rights to a public folder in Exchange Online. The security group members can now access the public folder.

**Step 3:** You delete the security group.

**Step 4:** You create a new mail-enabled security group in Exchange Online that has the same name as the deleted security group.

After step 3 is completed, the security group members can no longer access the public folder. After step 4 is completed, the security group members don't regain access.

## Resolution

To fix the issue, follow these steps to update the security group in the access rights list for the public folder:

1. Run the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to remove the public folder access rights for the original security group:

   ```PowerShell
   Remove-PublicFolderClientPermission -Identity "<public folder>" -User "<security group name>"
   ```

1. Run the following cmdlet in Exchange Online PowerShell to add public folder [access rights](/powershell/module/exchange/add-publicfolderclientpermission#-accessrights) for the restored or new security group:

   ```PowerShell
   Add-PublicFolderClientPermission -Identity "<public folder>" -User "<security group name>" -AccessRights "<access rights>"
   ```

As an example, the [Remove-PublicFolderClientPermission](/powershell/module/exchange/remove-publicfolderclientpermission) and [Add-PublicFolderClientPermission](/powershell/module/exchange/add-publicfolderclientpermission) PowerShell cmdlets generate the following output.

:::image type="content" source="media/security-group-cannot-access-public-folder/resolution-command-output.png" border="false" alt-text="Screenshot of the output from the Remove-PublicFolderClientPermission and Add-PublicFolderClientPermission cmdlets.":::
