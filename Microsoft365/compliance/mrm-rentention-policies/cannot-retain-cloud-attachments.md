---
title: Can't retain cloud attachments
description: Provides a table to identify which sharing mechanisms are cloud attachments in Outlook and Teams and which are not for retention.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
- CSSTroubleshoot
- CI 158295
ms.reviewer: arungedela; meerak
appliesto:
- Microsoft 365 Compliance
search.appverid: MET150
---

# Can't retain cloud attachments

Microsoft 365 Compliance provides tools that admins can use to retain cloud attachments that users share via Teams and Outlook. If you've configured cloud attachments to be retained but are not able to find them by using eDiscovery, it might be because they were not cloud attachments but separate copies, standard URL links, or other sharing mechanisms. Use the following table to identify which sharing mechanisms are cloud attachments in Outlook and Teams and which are not.

For information about how to retain cloud attachments that are shared in Outlook and Teams, and known limitations for this scenario, see [Automatically apply a retention label to retain or delete content](/microsoft-365/compliance/apply-retention-labels-automatically) and the retention label condition for cloud attachments.

### Cloud attachments in Outlook

|Sharing mechanism  |Is it a cloud attachment|
|:------------------- |:---------------:|
|<u>Cloud attachments</u>: The Outlook client displays the file like a regular attachment, but it is only a reference to a stored file.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/stored-file.png" alt-text="Screenshot of a regular attachment, it's a reference to a stored file."::: |Yes        |
|<u>Attached copy</u>: A separate copy of the original file. <br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/attached-copy.png" alt-text="Screenshot of a separate copy of the original file.":::    |No        |
|<u>URLs</u>: HTTP references added into the email subject or body, or meeting text body that provides the address of a file that's stored online.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/http-references.png" alt-text="Screenshot of HTTP references added into the email subject or body, or meeting text body. ":::      |No        |
|<u>Embedded Images</u>: Images pasted into the email body.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/embedded-image.png" alt-text="Screenshot of image pasted into the email body.":::     |No        |

### Cloud attachments in Teams

|Sharing mechanism  |Is it a cloud attachment|
| :------------------- |:---------------:|
|File shared from OneDrive or uploaded from computer.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/file-shared-from-onedrive.png" alt-text="Screenshot of file shared from OneDrive or uploaded from computer.":::       | Yes        |
|URL links to files, documents, or images with chiclet that are pasted into the chat or a channel and then resolve as chiclet graphics.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/url-links-to files-with-chiclet.png" alt-text="Screenshot of URL links to files, documents, or images with chiclet that are pasted into the chat or a channel and then resolve as chiclet graphics.":::       | Yes      |
|Audio and video files pasted directly into the message as links that resolve as chiclet graphics.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/audio-video-file.png" alt-text="Screenshot of audio and video files pasted directly into the message as links.":::      | Yes      |
|URL links to files, documents, or images without chiclet that don't resolve as chiclet graphics, and the URL links remain as text-only links in the message. <br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/url-links-to files-without-chiclet.png" alt-text="Screenshot of URL links remain as text-only links in the message.":::     | No      |
|Images pasted directly into chat.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/image-pasted-into-chat.png" alt-text="Screenshot of images pasted directly into chat.":::     | No      |
|Reactions to messages.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/reaction-to-message.png" alt-text="Screenshot of Reactions to messages.":::     | No      |
|Emojis shared on chat.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/emojis-shared-on-chat.png" alt-text="Screenshot of Emojis shared on chat.":::     | No      |
|GIFs shared on chat.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/gifs-shared-on-chat.png" alt-text="Screenshot of GIFs shared on chat.":::    | No      |
|Live components shared on chat.<br><br> Example: :::image type="content" source="media/cannot-retain-cloud-attachments/live-components-shared-on-chat.png" alt-text="Screenshot of live components shared on chat":::    | No      |
|Stickers shared on chat.<br><br> Example:<br> :::image type="content" source="media/cannot-retain-cloud-attachments/stickers-shared-on-chat.png" alt-text="Screenshot of stickers shared on chat.":::    | No      |
|Praise and approvals.   | No      |
