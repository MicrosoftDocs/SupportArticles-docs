---
title: Can't manage Send on Behalf permissions for shared mailboxes in the EAC
description: Explains that the Send As and Send on Behalf permissions are not available for shared mailboxes in Exchange Online. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kellybos, ninob, v-six
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Microsoft 365
ms.date: 01/24/2024
---
# Can't manage Send on Behalf permissions for shared mailboxes in the EAC

## Symptoms

When you sign in to the Exchange Admin Center (EAC) in Microsoft Exchange Online, you see limited options to set the permissions of a shared mailbox. The option to individually manage the **Send on Behalf** permissions is available for user mailboxes. However, only the option to manage full mailbox permissions is available for shared mailboxes.

## Cause

This issue occurs because the **Send on Behalf** permission can't be managed in the EAC.

## Workaround

To work around this issue, add the **Send on Behalf** permission by using Windows Remote PowerShell. To do this, follow the instructions on the following Microsoft TechNet website:

[Manage permissions for recipients in Exchange Online](/exchange/recipients-in-exchange-online/manage-permissions-for-recipients)

> [!NOTE]
> If you use Microsoft 365, you can use Microsoft 365 Admin Portal to assign the **Send on Behalf** permission to shared mailboxes.

## More Information

For more information about shared mailboxes, see [Shared Mailboxes](/exchange/shared-mailboxes-exchange-2013-help).