---
title: Litigation Hold mailbox doesn't turn into an inactive mailbox after license removal
description: Fixes an issue in which a Litigation Hold enabled mailbox doesn't turn into an inactive mailbox after the license is removed.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 151537
ms.reviewer: kellybos, lindabr, meerak
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 3/31/2022
---

# A mailbox that's on Litigation Hold or assigned to a retention policy doesn't turn into an inactive mailbox after license removal

[!include[Purview banner](../../../includes/purview-rebrand.md)]

## Symptoms

Assume that you synchronize accounts from your local Active Directory Domain Services (AD DS) to Azure Active Directory (Azure AD) by using Azure AD Connect. After the Microsoft Exchange Server license is removed from a Microsoft 365 account, which has a mailbox that's placed on Litigation Hold or assigned to a retention policy, the mailbox doesn't turn into an inactive mailbox, as expected. Additionally, when you view the account information in the Microsoft 365 admin center, you see the following error message:

> The execution of cmdlet Disable-Mailbox failed..; Exchange: An unknown error has occurred.

## Cause

Removing the Exchange Server license will hard delete the mailbox. However, a Litigation Hold-enabled mailbox, or a mailbox that's assigned to a retention policy, can't be deleted in Exchange Online. In this case, the mailbox won't become inactive.

## Resolution

To turn the mailbox that's placed on Litigation Hold or assigned to a retention policy into an inactive mailbox, follow these steps in Azure AD:

1. Reassign the license to the account to recover the mailbox.
1. Delete the account from AD DS, or delete the account from the scope of the synchronization with Azure AD Connect.

## More information

- [Remove-ADUser](/powershell/module/activedirectory/remove-aduser)
- [Create an Organizational Unit (OU) in an AD DS-managed domain](/azure/active-directory-domain-services/create-ou)
- [No soft-deleted mailbox after license removal in Microsoft 365](/exchange/troubleshoot/user-and-shared-mailboxes/no-soft-deleted-mailbox-after-license-removal)
- [Overview of inactive mailboxes](/microsoft-365/compliance/inactive-mailboxes-in-office-365)
- [How to identify the type of hold placed on an Exchange Online mailbox](/microsoft-365/compliance/identify-a-hold-on-an-exchange-online-mailbox?view=o365-worldwide&preserve-view=true)
