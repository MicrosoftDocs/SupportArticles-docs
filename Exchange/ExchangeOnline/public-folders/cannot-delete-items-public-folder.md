---
title: Can't delete items from public folder
description: Items in a public folder are still present after being deleted using Outlook on the web because the public folder reaches its recoverable items quota. This article provides a resolution. 
author: simonxjx
ms.author: batre
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: exchange-online
localization_priority: Normal
ms.custom: 
- Exchange Online
- CI 117577
- CSSTroubleshoot
ms.reviewer: batre
appliesto:
- Exchange Online
search.appverid: 
- MET150
---

# Can't delete items from public folder

## Symptoms

Items in a public folder are still present after being deleted by users with a permission to use Outlook on the web. There's no error message.

## Cause

The public folder mailbox hosting the public folder may have reached its recoverable items quota. Collect traces while reproducing the issue using Outlook on the web and locate the URL with words "action=DeleteItem", you may find the following response headers format:

`{"Header":{"ServerVersionInfo":{"MajorVersion":15,"MinorVersion":20,"MajorBuildNumber":2991,"MinorBuildNumber":0,"Version":"V2018_01_08"}},"Body":{"__type":"DeleteItemResponse:#Exchange","ResponseMessages":{"Items":[{"__type":"DeleteItemResponseMessage:#Exchange","MessageText":"An internal server error occurred. The operation failed.","ResponseCode":"ErrorInternalServerError","MessageXml":"<?xml version=\"1.0\"?>\r\n<XmlNodeArray xmlns:t=\"http://schemas.microsoft.com/exchange/services/2006/types\" xmlns:m=\"http://schemas.microsoft.com/exchange/services/2006/messages\">\r\n  <t:Value Name=\"InnerErrorMessageText\">Cannot delete message because the destination folder is out of quota.</t:Value>\r\n  <t:Value Name=\"InnerErrorResponseCode\">ErrorQuotaExceededOnDelete</t:Value>\r\n  <t:Value Name=\"InnerErrorDescriptiveLinkKey\">0</t:Value>\r\n</XmlNodeArray>","ResponseClass":"Error"}]}}`

## Resolution

Clear deleted items from the public folder to release storage and try to delete the item again:

1. Connect to the public folder using Outlook desktop client.
2. Go to the public folder and select **Recover deleted items** in the ribbon bar.
3. Select items to delete, select **Purge Selected Items**, and select **Ok**.
4. Delete those items again.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
