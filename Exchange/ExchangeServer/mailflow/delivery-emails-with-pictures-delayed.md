---
title: Delay in delivering emails with image attachments in Exchange Server 2016
description: Provides a workaround for an issue that delays delivery of emails that have picture attachments in Exchange Server 2016.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need Help with Configuring Mailflow, Mail routing (Connectors, Domains)
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: shanbram, genli, christys, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Delivery of emails with picture attachments is delayed in Exchange Server 2016

_Original KB number:_ &nbsp;4013607

## Symptoms

When you send an email with a picture attachment to a large distribution list (contact group) in a Microsoft Exchange Server 2016 environment, you may experience a significant delay in delivery of the message.

## Cause

This issue occurs because Exchange Server 2016 uses the [Windows Imaging Component](/windows/win32/wic/-wic-about-windows-imaging-codec) (WIC) to create thumbnails for picture attachments.

## Workaround

> [!NOTE]
> After you follow these steps, you must restart the Microsoft Exchange Mailbox Transport Delivery service to enable the workaround.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Start Registry Editor:
    - In Windows Server 2016, select **Start** > **Search**, enter *regedit* in the **Search** box, and then select **regedit.exe** in the search results.
    - In Windows Server 2012, point to the upper-right corner, select **Search**, enter *regedit* in the search box, and then select **regedit.exe** in the search result.
    - In Windows Server 2008, select **Start,** enter *regedit* in the **Search programs and files** box, and then select **regedit.exe** in the search results.
1. Locate and select the following subkey:

    `HKLM\SOFTWARE\Microsoft\ExchangeServer\v15\MailboxRole\AttachmentImageThumbnail`
1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
1. Enter *DisableThumbnailGeneration*, and then press Enter.
1. In the **Details** pane, select and hold (or right-click) **DisableThumbnailGeneration**, and then click **Modify**.
1. In the **Value data** box, enter *1*, and then click **OK**.
1. Exit Registry Editor.
