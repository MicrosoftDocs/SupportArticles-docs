---
title: IMAP account cannot download messages
description: Describes an issue that blocks an Outlook 2013 or Outlook 2016 IMAP account from downloading messages. Occurs if the UID SEARCH command is sent.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Internet email server (POP3, IMAP, or HTTP) connection error
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Outlook 2016
  - Outlook 2013
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook 2013 or Outlook 2016 IMAP account can't download messages because of UID SEARCH command

_Original KB number:_ &nbsp; 3216722

## Symptoms

You create an IMAP (Internet Message Access Protocol) mailbox account in Microsoft Outlook 2016 or Outlook 2013. When you sync the mailbox with the IMAP server, the folder list and folder hierarchy are downloaded. However, no email messages are downloaded. No error or warning messages are received in Outlook.

The Outlook IMAP transport log shows that the connection is closed after Outlook sends the `UID SEARCH` command:

> IMAP: 11:40:24 [tx] tbqs UID SEARCH SINCE 13-Dec-2016  
IMAP: 11:41:17 [db] Connection to 'IP address' closed

## Cause

This issue may occur if the IMAP server does not support the `UID SEARCH` command.

Installations of Outlook 2013 that have the [Description of the Outlook 2013 hotfix package (Outlook-x-none.msp; Outlookintl-.msp): October 16, 2013](https://support.microsoft.com/help/2825677) or a later update installed send the `UID SEARCH` command when communicating with the IMAP server. All versions of Outlook 2016 send the `UID SEARCH` command.

## Resolution

To fix this issue, the IMAP server must be updated to support the `UID SEARCH` command. Contact either the Internet service provider (ISP) or the IMAP server manufacturer to report the issue.

## More information

Customers have reported that one third-party IMAP server that does not support the `UID SEARCH` command is Alfresco 5.1.

After you [enable transport logging](/outlook/troubleshoot/performance/enable-transport-logging) in Outlook, the IMAP transport log is generated in the following location:

%temp%\Outlook Logging\IMAP-\<usernamedomainname>-\<date>-\<time>.log

When the issue occurs, the following events are logged in the Outlook transport log:

> IMAP: 11:40:24 [tx] wk2e SELECT "Drafts"  
IMAP: 11:40:24 [db] OnNotify: asOld = 5, asNew = 5, ae = 3  
IMAP: 11:40:24 [rx] \* 1 EXISTS  
IMAP: 11:40:24 [db] OnNotify: asOld = 5, asNew = 5, ae = 3  
IMAP: 11:40:24 [rx] \* 0 RECENT  
IMAP: 11:40:24 [rx] \* OK [UNSEEN 1] Message 1 is the first unseen  
IMAP: 11:40:24 [rx] \* OK [UIDVALIDITY 1477650566] UIDs valid  
IMAP: 11:40:24 [rx] \* OK [UIDNEXT 2504] Predicted next UID  
IMAP: 11:40:24 [rx] \* FLAGS (\Answered \Deleted \Draft \Flagged \Seen)  
IMAP: 11:40:24 [rx] \* OK [PERMANENTFLAGS (\Answered \Deleted \Draft \Flagged \Seen)] Limited  
IMAP: 11:40:24 [rx] wk2e OK [READ-WRITE] SELECT completed.  
IMAP: 11:40:24 [tx] tbqs UID SEARCH SINCE 13-Dec-2016  
IMAP: 11:41:17 [db] Connection to 'IP address' closed.  

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
