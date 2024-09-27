---
title: Can't convert a user mailbox to inactive by removing the user's license
description: Resolves an issue in which you can't convert a user mailbox to inactive by removing the user's license.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Retention
  - CSSTroubleshoot
  - CI 1021
ms.reviewer: apascual, sathyana, meerak, v-shorestris
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 09/27/2024
---

# Can't convert a user mailbox to inactive by removing the user's license

## Symptoms

You try to convert a regular user mailbox to an [inactive mailbox](/purview/create-and-manage-inactive-mailboxes) in Microsoft Exchange Online by removing the license for the user. However, the mailbox remains active, and you see the following error message in the Microsoft 365 admin center:

> The execution of cmdlet Disable-Mailbox failed..; Exchange: An unknown error has occurred.

The issue occurs for user mailboxes in both on-premises Exchange hybrid and Exchange Online environments.

## Cause

The issue occurs if you remove the user license for a mailbox that has a hold applied. This behavior is by design.

> [!NOTE]
> If you remove the user license for a mailbox that doesn't have a hold applied, Exchange Online immediately disconnects (disables) the mailbox and then permanently deletes it after 30 days. You can't access a disconnected mailbox.

## Resolution

To convert a regular user mailbox that has a hold to an inactive mailbox, follow these steps:

1. [Reassign a license to the user](/microsoft-365/admin/manage/assign-licenses-to-users#use-the-active-users-page-to-assign-or-unassign-licenses) to resolve the error.

2. If the cloud user account is synced from on-premises, delete the on-premises account or turn off sync.

3. If the user account was created directly in the cloud:

   1. [Delete the user account](/power-platform/admin/delete-users#delete-users-in-microsoft-365-admin-center) in the Microsoft 365 admin center.

   2. [Permanently delete the user account](/entra/fundamentals/users-restore#permanently-delete-a-user). 

> [!NOTE]
> Exchange Online automatically unassigns the license for a deleted user account.
