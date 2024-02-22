---
title: Can't access hidden mailbox after migration
description: Describes an issue in which users cannot access a hidden mailbox in Outlook after a migration to Microsoft 365 hybrid environment. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't access a hidden mailbox in Outlook after a migration to Microsoft 365 hybrid environment

_Original KB number:_ &nbsp; 4034273

## Symptoms

After a migration to Microsoft 365, users can't open a folder or add a hidden mailbox in Outlook. Also, users may receive the following error messages, depending on what they're trying to add or access.

- Additional mailbox

  > The name cannot be resolved. The name cannot be matched to a name in the address list.

- Additional Exchange account

  > The name cannot be matched to a name in the address list.

- Calendar or other folders

  > Microsoft Outlook does not recognizeUserName.

## Cause

This behavior is expected when you try to add a hidden mailbox.

## Resolution

Auto-mapping enables users who have **Full Access** permissions to access a hidden mailbox. If you migrate from an on-premises environment, refer to the following article for instructions to enable auto-mapping in a hybrid environment:

[Auto-mapping doesn't work as expected in a Microsoft 365 hybrid environment](https://support.microsoft.com//help/3080561/)  
