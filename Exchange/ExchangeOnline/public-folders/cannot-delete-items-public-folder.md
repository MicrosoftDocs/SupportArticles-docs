---
title: Can't delete items from public folder
description: Items in a public folder persist after you try to delete them in Outlook on the web.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CI 117577
  - CI 165318
  - CSSTroubleshoot
ms.reviewer: batre, haembab, meerak, v-six
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# Can't delete items from public folder in Outlook on the web

## Symptoms

When you try to delete items in a public folder by using Outlook on the web (OWA), the deleted items reappear after you close and reopen Outlook on the web. When this issue occurs, you don't receive an error message.

## Cause

The public folder mailbox that hosts the public folder might have reached its recoverable items quota. You can [collect a network trace](/azure/azure-web-pubsub/howto-troubleshoot-network-trace) while you reproduce the issue in OWA. Search on "action=DeleteItem" to locate the OWA URL. You might see the following complete response:

> {"Header":{"ServerVersionInfo":{"MajorVersion":15,"MinorVersion":20,"MajorBuildNumber":2991,"MinorBuildNumber":0,"Version":"V2018_01_08"}},"Body":{"__type":"DeleteItemResponse:#Exchange","ResponseMessages":{"Items":[{"__type":"DeleteItemResponseMessage:#Exchange","MessageText":"An internal server error occurred. The operation failed.","ResponseCode":"ErrorInternalServerError","MessageXml":"\<?xml version=\\"1.0\\"?>\r\n\<XmlNodeArray xmlns:t=\\"`http://schemas.microsoft.com/exchange/services/2006/types`\\" xmlns:m=\\"`http://schemas.microsoft.com/exchange/services/2006/messages`\\">\r\n  <t:Value Name=\\"InnerErrorMessageText\\">Cannot delete message because the destination folder is out of quota.</t:Value>\r\n  <t:Value Name=\\"InnerErrorResponseCode\\">ErrorQuotaExceededOnDelete</t:Value>\r\n  <t:Value Name=\\"InnerErrorDescriptiveLinkKey\\">0</t:Value>\r\n\</XmlNodeArray>","ResponseClass":"Error"}]}}

## Resolution

Clear deleted items from the public folder to release storage, and then try again to delete the item:

1. Connect to the public folder by using Outlook desktop client.
2. Go to the public folder, and select **Recover deleted items** on the ribbon.
3. Select items to delete, select **Purge Selected Items**, and then select **OK**.
4. Delete those items again.

## More information

If you search for specific items in a public folder by using Outlook on the web, and you delete the items from the search results, the deleted items reappear after you close and reopen Outlook on the web. The delete action for search results in OWA is not supported for public folder items. Either delete the public folder item directly without searching for it or use Microsoft Outlook to delete the item.
