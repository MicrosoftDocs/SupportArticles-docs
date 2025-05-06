---
title: Can't retain cloud attachments
description: Provides a table to identify which sharing mechanisms are cloud attachments in Outlook and Teams for retention and which aren't.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Retention
  - CSSTroubleshoot
  - CI 158295
ms.reviewer: arungedela; meerak
appliesto: 
  - Microsoft Purview
search.appverid: MET150
ms.date: 06/24/2024
---

# Can't retain cloud attachments

Microsoft Purview provides tools that admins can use to retain cloud attachments that users share through Teams and Outlook. If you've configured cloud attachments to be retained, but you can't find them by using eDiscovery, it might be that the items weren't actually cloud attachments but separate copies or shared by using other mechanisms. Use the following table to identify which sharing mechanisms are cloud attachments in Outlook, Teams, and Viva Engage.

For information about how to retain cloud attachments that are shared in Outlook, Teams, and Viva Engage and known limitations for this scenario, see the retention label condition for cloud attachments in [Automatically apply a retention label to retain or delete content](/microsoft-365/compliance/apply-retention-labels-automatically).

### Cloud attachments in Outlook

|Sharing mechanism  |Is it a cloud attachment?|
|:------------------- |:---------------:|
|<u>Cloud attachments</u>: A display on an Outlook client that resembles a regular attachment, but is actually a reference to a stored file.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/stored-file.png" alt-text="Screenshot of a regular attachment, it's a reference to a stored file."::: |Yes        |
|<u>Attached copy</u>: A separate copy of the original file. <br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/attached-copy.png" alt-text="Screenshot of a separate copy of the original file.":::    |No        |
|<u>URLs</u>: An HTTP reference that's added to the email subject or body, or to the meeting text body that provides the address of a file that's stored online.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/http-reference.png" alt-text="Screenshot of an HTTP reference added into the email subject or body, or meeting text body.":::      |Yes        |
|<u>Embedded Images</u>: Images that are pasted into the email body.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/embedded-images.png" alt-text="Screenshot of image pasted into the email body.":::     |No        |

### Cloud attachments in Teams

|Sharing mechanism  |Is it a cloud attachment?|
| :------------------- |:---------------:|
|A file that's shared from OneDrive or uploaded from the computer.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/file-shared-from-onedrive.png" alt-text="Screenshot of file shared from OneDrive or uploaded from computer.":::       | Yes        |
|URL links to files, documents, or images that are pasted into the chat or a channel and are then resolved as chiclet graphics.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/url-links-to files-with-chiclet.png" alt-text="Screenshot of URL links to files, documents, or images with chiclet that are pasted into the chat or a channel and then resolve as chiclet graphics.":::       | Yes      |
|Audio and video files that are pasted directly into the message as links and are then resolved as chiclet graphics.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/audio-video-file.png" alt-text="Screenshot of audio and video files pasted directly into the message as links.":::      | Yes      |
|URL links to files, documents, or images that don't resolve as chiclet graphics, and the URL links remain as text-only links in the message. <br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/url-links-to files-without-chiclet.png" alt-text="Screenshot of URL links remain as text-only links in the message.":::     | Yes      |
|Images that are pasted directly into a chat.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/image-pasted-into-chat.png" alt-text="Screenshot of images pasted directly into a chat.":::     | No      |
|Reactions to messages.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/reaction-to-message.png" alt-text="Screenshot of Reactions to messages.":::     | No      |
|Emojis that are shared in a chat.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/emojis-shared-on-chat.png" alt-text="Screenshot of Emojis shared in a chat.":::     | No      |
|GIF files that are shared in a chat.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/gifs-shared-on-chat.png" alt-text="Screenshot of GIF files shared in a chat.":::    | No      |
|Live components that are shared in a chat.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/live-components-shared-on-chat.png" alt-text="Screenshot of live components shared in a chat":::    | No      |
|Stickers that are shared in a chat.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/stickers-shared-on-chat.png" alt-text="Screenshot of stickers shared in a chat.":::    | No      |
|Praise and approvals that are shared in a chat.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/praise-sent-in-chat.png" alt-text="Screenshot of praise sent in a chat.":::  | No      |

### Cloud attachments in Viva Engage

|Sharing mechanism  |Is it a cloud attachment?|
|:------------------- |:---------------:|
|Upload a file from a device. It will be stored it in a SharePoint or OneDrive location.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/upload-file-from-device.png" alt-text="Screenshot of file uploaded from a device.":::       | Yes        |
|Attach a file that's stored in a SharePoint or OneDrive location.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/attach-file-from-sp-odb.png" alt-text="Screenshot of sharing a file from a SharePoint or OneDrive location.":::       | Yes      |
|Include a hyperlink in the message body to a file that's stored in a SharePoint or OneDrive location<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/hyperlink-to-file-on-sp-odb.png" alt-text="Screenshot of sharing a link to file that's stored on SharePoint or OneDrive.":::      | Yes      |
