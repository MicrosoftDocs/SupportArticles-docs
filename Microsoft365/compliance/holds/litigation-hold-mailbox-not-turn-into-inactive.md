---
title: Litigation Hold mailbox doesn't turn into an inactive mailbox after license removal
description: Fixes an issue in which a Litigation Hold enabled mailbox doesn't turn into an inactive mailbox after the license is removed.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
- CSSTroubleshoot
- CI 151537
ms.reviewer: kellybos, lindabr, meerak
appliesto:
- Exchange Online
search.appverid: MET150
---

# Litigation Hold mailbox doesn't turn into an inactive mailbox after license removal

## Symptoms

Assume that you synchronize accounts from local Active Directory (AD) to Azure AD by using Azure AD Connect. After the Exchange license is removed from a Microsoft 365 account that has a mailbox with Litigation Hold enabled, the mailbox doesn't turn into an inactive mailbox. Additionally, when you view the account information in Microsoft 365 admin center, you see the following error message:

> The execution of cmdlet Disable-Mailbox failed..; Exchange: An unknown error has occurred.

## Cause

Removing the license will hard delete the mailbox, but a Litigation Hold enabled mailbox can't be deleted in Exchange Online. In this case, the mailbox won't become inactive.

## Resolution

Turn the Litigation Hold enabled mailbox into an inactive mailbox by following the steps in Azure AD:

1. Reassign the license to the account to recover the mailbox.
1. Delete the account from your local AD or delete the account from the scope of the synchronization with Azure AD Connect.

## More information

- [Remove-ADUser](/powershell/module/activedirectory/remove-aduser)
- [Create an Organizational Unit (OU) in an Azure Active Directory Domain Services managed domain](/azure/active-directory-domain-services/create-ou)
- [No soft-deleted mailbox after license removal in Microsoft 365](/exchange/troubleshoot/user-and-shared-mailboxes/no-soft-deleted-mailbox-after-license-removal)
- [Overview of inactive mailboxes](/microsoft-365/compliance/inactive-mailboxes-in-office-365)