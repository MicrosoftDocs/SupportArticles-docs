---
title: Sending attachment outside of Outlook fails
description: This article provides a solution to an issue where sending attachments outside of Microsoft Outlook fails.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: tmoore, gregmans
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2013
  - Outlook 2010
ms.date: 01/30/2024
---
# Event ID 27 when sending attachments outside of Outlook fails

_Original KB number:_ &nbsp; 3007812

## Symptoms

You attempt to send a file as an attachment from a program other than Microsoft Outlook (for example, Microsoft Word), and nothing happens.

In reviewing the Application Event log, you find an error for Outlook with Event ID 27 containing the following error text:

> MAPISendMail: Failed to submit message. Attachments to the message exceeded the size limit set by your Administrator

This event log entry is shown in the following figure:

:::image type="content" source="./media/event-27-mapisentmail-error-send-attachments/event-viewer.png" alt-text="Screenshot of Application event log entry.":::

## Cause

This error will appear in the Application Event log if you've attempted to send an email attachment that is over the size limit established in your Exchange environment, and the attempt was made outside of Outlook. An example of this would be when you right-click a file and select **Send To** and select **Mail Recipient**.

If the selected file is over the attachment size limit and Outlook is not running, you may be prompted for an Outlook profile if Prompt for a profile to be used is selected in the Mail Control Panel; however, a new message in which to send the attachment will not appear.

## Resolution

There may be several options to prevent the Event ID 27, and successfully deliver the attachment.

- Reduce the size of the attachment if possible; for example, lower the attachment size by adding it to a compressed (ZIP) folder.
- Place the file on a share or web host accessible by the intended recipient, and send a link to the file via email instead.
- Request that your Exchange administrator increase the allowable limit for email attachments.

## More information

Attempting to send the same attachment within Outlook, by selecting **Attach File** from the **Message** or **Insert** ribbon, results in one of the following error dialogs:

- Outlook 2013
  > The file you're attaching is bigger than the server allows. Try putting the file in a shared location and sending a link instead.

   :::image type="content" source="./media/event-27-mapisentmail-error-send-attachments/outlook-2013-error.png" alt-text="Screenshot of the error in Outlook 2013." border="false":::

- Outlook 2010
  >The attachment size exceeds the allowable limit.

  :::image type="content" source="./media/event-27-mapisentmail-error-send-attachments/outlook-2010-error.png" alt-text="Screenshot of the error in Outlook 2010." border="false":::

You can use the following steps to review Event ID 27 in the Application event log:

1. In Control Panel, open **Administrative Tools**.
2. Double-click **Event Viewer**.
3. In the left pane, select **Application** under **Windows Logs**.
4. In the **Actions** pane, click **Filter Current Log**.
5. In the **Filter Current Log** dialog box, select **Error** under **Event level**, and enter **27** as the Event ID (as shown in the following figure) and then click **OK**.

    :::image type="content" source="./media/event-27-mapisentmail-error-send-attachments/filter-event-27.png" alt-text="Screenshot of filtering Event ID 27 in the Application event log." border="false":::
