---
title: Delays in provisioning of user/mailbox or synchronizing changes in Exchange Online
description: Describes an issue in which provisioning of user/mailbox or synchronizing changes in Exchange Online delays. Provides a solution.
author: helenclu
ms.author: rroddy
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.prod: office 365
localization_priority: Normal
ms.custom: 
- Exchange Online
- CI 120630
- CSSTroubleshoot
ms.reviewer: rroddy
appliesto:
- Exchange Online
search.appverid: 
- MET150
---
# Delays in provisioning of user/mailbox or synchronizing changes in Exchange Online

## Symptoms

When a user is created or changed in Microsoft 365, or synced to Azure Active Directory from the on-premises environment, no mailbox is provisioned for the user, or the change isn't reflected in Exchange Online.

## Resolution

Here's how to fix this issue:

1. If a mailbox hasn't been created, make sure the user was assigned a valid Exchange Online license in the Microsoft 365 Admin Portal.
2. After the license has been assigned or the user's properties modified, allow 30 minutes for the change to apply.
3. Make sure the user doesn't receive a validation error. For more information about viewing validation errors, see this [article](https://support.microsoft.com/help/2741233).
4. Check if a Service Health notification in the Microsoft 365 admin portal applies.
5. The service typically takes less than 30 minutes to provision a user or to sync changes for a user. It could take up to 24 hours for provisioning to occur or for changes to sync. If the issue persists after 24 hours, submit a support service request.
