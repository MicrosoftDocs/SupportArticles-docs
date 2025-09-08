---
title: Different type of Active Directory object exists error
description: Describes an issue in which one or more users aren't migrated when you try to migrate mailboxes from your on-premises Exchange organization to Exchange Online in a cutover migration. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: shahmul, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# A different type of Active Directory object already exists error when migrating mailboxes in cutover migration

_Original KB number:_ &nbsp; 2968722

## Symptoms

When you perform a cutover migration to migrate mailboxes from your on-premises Microsoft Exchange organization to Microsoft Exchange Online, one or more users aren't migrated, and you receive the following error message:

> A different type of Active Directory object already exists for "\<user>@\<domainname>.com" in the target forest. Please verify that the SMTP address is correct.

## Cause

This issue occurs because user objects that weren't migrated already are located in the target Exchange Online organization.

## Resolution

To resolve this issue, remove the user objects in Exchange Online. To do this, follow these steps:

1. Sign in to the Microsoft 365 portal as an admin.
2. Select **users and groups**, and then search for the users who didn't migrate.
3. Permanently delete the users. You can do this in the Microsoft 365 portal or by using the Microsoft Azure Active Directory module for Windows PowerShell.

> [!IMPORTANT]
> Deleting a user account will also delete the associated SharePoint Online and Skype for Business Online (formerly Lync Online) information for that user.

To delete users by using the Azure Active Directory module for Windows PowerShell, follow these steps:

  1. Connect to Microsoft Entra ID. For more information about how to do this, see [Microsoft Entra Cmdlets](/previous-versions/azure/jj151815(v=azure.100)).
  2. Run the following command:

        ```powershell
        Remove-MSOL -UserPrincipalName User@domain.com -RemoveFromRecycleBin
        ```

After you follow these steps, make sure that users are no longer listed in the portal, and then perform the migration.

## More information

For more information about cutover Exchange migration, see [Migrate email using the Exchange cutover method](/Exchange/mailbox-migration/cutover-migration-to-office-365).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
