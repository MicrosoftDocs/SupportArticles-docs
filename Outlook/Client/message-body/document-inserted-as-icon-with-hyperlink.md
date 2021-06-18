---
title: Document inserted as icon with hyperlink in message
description: This article provides a workaround for the issue that attachment may be added as an icon with a hyperlink to the body of an email message.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer: aruiz, vijayde
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook for Office 365
search.appverid: MET150
---
# Outlook 2016 inserts document as icon with hyperlink in body of message

_Original KB number:_ &nbsp; 3175690

## Symptoms

When you use Microsoft Outlook 2016 to connect to a Microsoft Exchange 2013 or earlier mailbox and you insert a OneDrive for Business or SharePoint 2016 file into a new email message, the attachment may be added to the body of the message as an icon with a hyperlink.

## Cause

Outlook 2016 includes support for new Exchange Server 2016 document sharing functionality. This functionality is not supported with Exchange Server 2013 or earlier mailboxes.

## Workaround

To work around this issue, change the format of the email message to Rich Text or Plain Text before attaching a document from a OneDrive for Business or SharePoint 2016 file. To change the format, use the following steps:

1. In a new email message, select the **Format Text** tab in the ribbon.
2. Select **Plain Text** or **Rich Text**.
3. Select the **Message** tab in the ribbon and then select **Attach File**.
4. Attach the file the way you normally do.

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available.

## More information

Exchange Server 2016 includes a new approach to attachments to simplify document sharing. You can use either Outlook 2016 and Outlook on the web to attach a link to a SharePoint 2016 or OneDrive for Business document instead of a traditional attachment. This provides the benefits of coauthoring and version control.

Although the user interface in Outlook 2016 has been updated, attaching documents as links to SharePoint 2016, SharePoint Online (SPO), or OneDrive for Business is not supported with Exchange Serve 2013 or earlier mailboxes.
