---
title: Emails not show in Cached mode Inbox after synchronized
description: E-mail messages don't appear in Cached mode Inbox after synchronization. Resolution for problem provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# Sometimes emails do not appear in Cached mode Inbox even if they were synchronized down from mailbox

_Original KB number:_ &nbsp; 2330226

## Symptoms

Sometimes e-mail messages do not appear in your Cached mode Inbox even though they were synchronized down from your mailbox. You can see the items in your Inbox using Online mode, Outlook Web Access, or Outlook Web App (OWA), but you can't see them in your Cached mode profile.

## Cause

This problem has been known to occur when the messages are stuck in the incoming item processing pipeline, a feature first introduced by Outlook 2007. This *pipeline* uses the hidden ItemProcSearch folder in your mailbox to process messages prior to showing them in your Inbox. Messages can become stuck in the pipeline due to unexpected conflicts or corrupt data.

## Resolution

To resolve this problem, use one of the following methods.

1. Start Outlook with the /cleanips switch.
   1. Exit Outlook if it is running.
   2. Start Outlook using the following command-line (select **Start** and then select **Run**):

        ```console
        Outlook.exe /cleanips
        ```

        > [!NOTE]
        > To use this switch you need at least Office 2007 Service Pack 2 installed for Outlook 2007. Later versions of Outlook have this functionality built into the product.

2. Clear the offline items in your Inbox so they can resynchronize.

    If for some reason, the /cleanips switch does not resolve the issue, try the following steps to resynchronize the items in your Inbox folder.

      1. Start Outlook.
      2. Right-click the Inbox folder and then select **Properties**.
      3. In the **Inbox Properties** dialog box, select the **General** tab.
      4. Select **Clear Offline Items**.
      5. Select **OK** when advised *Your data was removed from your Outlook data file (.ost)*.
      6. Select **OK** in the **Inbox Properties** dialog box.
      7. With your Inbox selected in the **Navigation** Pane, press Shift+F9 to force the resynchronization of your Inbox folder.

## More information

Usually when things work as expected in Outlook, new messages that are synchronized into the mailbox are temporarily hidden so they can be processed by the ItemProcSearch search folder. At this time, the ItemProcSearch search folder receives a *notification* that a new message has arrived and it starts the processing of the incoming item. After the item is processed, it is marked as unhidden and then you see it in your Inbox.

When the items don't appear in your Inbox, this *notification* fails to reach the ItemProcSearch search folder. Therefore, after the incoming message is flagged as hidden, it does not get processed by the ItemProcSearch search folder and marked as unhidden.
