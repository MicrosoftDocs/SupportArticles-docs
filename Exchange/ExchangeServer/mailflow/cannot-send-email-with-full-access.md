---
title: Can't send email message when Full Access is granted to a shared mailbox
description: Describes an issue that prevents email from being sent in an Exchange 2013, Exchange 2016 or Exchange Online environment. Occurs when you have Full Access permissions to a shared mailbox. Resolutions are provided.
author: simonxjx
audience: ITPro
ms.service: exchange-powershell
ms.topic: article
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Microsoft Outlook 2010
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2013 Enterprise
---

# Can't send an email message when Full Access permission is granted to a shared mailbox in Exchange Server

## Symptoms

Consider the following scenario:

- You have Full Access and Send On Behalf Of permissions to a shared mailbox in an Exchange Server environment.    
- You configure a Microsoft Outlook profile for the shared mailbox and enter your own credentials to access it.    
- You send an email message from this Outlook profile.    
 
If you are running Outlook in Cached mode in this scenario, you receive a non-deliverable report (NDR) in your Inbox that contains the following details:

```asciidoc
    Subject: Undeliverable: Subject_Of_Message Your message did not reach some or all of the intended recipients.
   Subject: Subject_Of_Message
 Sent: Date_and_Time

The following recipient(s) cannot be reached:
 RecipientName on Date_and_Time This message could not be sent. Try sending the message again later, or contact your network administrator. Error is [0x80070005-00000000-00000000].
```
  
Or
    
```asciidoc
Subject: Undeliverable: Subject_of_Message Your message did not reach some or all of the intended recipients.

Subject: Subject_Of_Message
 Sent: Date_and_Time The following recipient(s) cannot be reached: RecipientName on Date_and_Time

This message could not be sent. Try sending the message again later, or contact your network administrator. You do not have the permission to send the message on behalf of the specified user. Error is [0x80070005-0x0004dc-0x000524].     
```

And if you are running Outlook in Online mode, you receive the following error message:

**You do not have the permission to send the message on behalf of the specified users.**    

![You do not have the permission to send the message on behalf of the specified users.](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4055369_en_1)  

## Cause

In this configuration, Exchange Server requires Send As permissions to send the email message. If you don't have Send As permissions for the shared mailbox, Outlook can't send the message.

## Resolution

Grant Send As permission to the user for the shared mailbox. For information about how to do this in the EAC or by using PowerShell, see [Manage permissions for recipients](https://technet.microsoft.com/library/jj919240%28v=exchg.160%29.aspx).