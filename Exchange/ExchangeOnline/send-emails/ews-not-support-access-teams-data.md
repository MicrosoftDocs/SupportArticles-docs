---
title: EWS isn't supported when accessing Teams data
description: Describes an issue in which EWS isn't supported for accessing Teams data. It is only supported by using Microsoft Graph API.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 119824
  - CSSTroubleshoot
ms.reviewer: danba, v-six
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---
# EWS isn't supported when accessing Teams data

## Summary

Microsoft Exchange Web Services (EWS) and other messaging application programming interfaces (API) aren't supported when accessing the Microsoft Teams data stored in a user's mailbox. Third-party applications aren't allowed to access or use Teams data in mailboxes. Teams can change its location and use of data at any time. Therefore, the use of email APIs such as EWS, Exchange REST, MAPI, or Outlook Object Model poses the risk of code failure.

Access to Teams data is only supported by Microsoft Graph API (preview). Teams Graph calls will be supported after the Teams Graph calls leave preview through an update to the Microsoft Graph API. Meanwhile, refer to [StackOverflow](https://stackoverflow.com/) for assistance.

## More information

To access Teams messages, subscribe to changes for messaging. You can subscribe a listener application to receive notifications for certain types of changes in Microsoft Graph's specified resource. This API is currently in the Beta testing phase. For more information, see [Create subscription](/graph/api/subscription-post-subscriptions).
