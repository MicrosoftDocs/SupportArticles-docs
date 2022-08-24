---
title: Can't delete items from public folder
description: Items in a public folder are still present after being deleted using Outlook on the web.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 117577
  - CI 165318
  - CSSTroubleshoot
ms.reviewer: batre, haembab, meerak
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 8/24/2022
---

# Can't delete items from public folder

## Symptoms

When you delete items in a public folder by using Outlook on the web, the deleted items reappear after you close and reopen Outlook on the web. No error message is displayed.

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

If you search for specific items in a public folder by using Outlook on the web, and delete the items from the search results, the deleted items reappear after you close and reopen Outlook on the web. The delete action for search results in OWA is not supported for public folder items. Either delete the public folder item directly without searching for it or use Microsoft Outlook to delete the item.
