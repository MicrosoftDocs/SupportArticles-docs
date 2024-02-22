---
title: No delegate permissions after a move from on-premises to Exchange Online
description: You can't viewing delegates or add or remove a delegate in Outlook after a migration from on-premises to Exchange Online.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Error viewing delegates in Outlook after a migration from on-premises to Exchange Online

## Symptoms

Assume that your mailbox is migrated from an on-premises Exchange environment to Microsoft Exchange Online. After you sign in to Microsoft Outlook, you may experience one of the following issues that affect the Outlook delegate feature:

- When you view the delegate permissions, a value of **None** is listed in the **Delegate Permissions** dialog box.

   :::image type="content" source="media/no-delegate-permissions-after-migration/none.png" alt-text="Screenshot of a value of None that is listed in the Delegate Permissions dialog box.":::

- When you try to remove or add a delegate, you receive the following error message:

  > The Delegates settings were not saved correctly. Unable to activate send-on-behalf-of list. You do not have sufficient permission to perform this operation on this object.

## Resolution

To resolve this issue after a move is made to Exchange Online from an on-premises environment, restart the Outlook client.

You can also force Outlook to download a new address book. To do this, select **Send / Receive** > **Send/Receive Groups** > **Download Address Book**.

:::image type="content" source="media/no-delegate-permissions-after-migration/address-book.png" alt-text="Screenshot of the Send/Receive tab.":::

Complete these steps to make sure that the Outlook client has the most up-to-date information.
