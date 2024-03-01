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

Access to Teams data is only supported by Microsoft Graph. Fully supported access to Teams message data is available through the [Microsoft Graph Teams Export API](https://docs.microsoft.com/microsoftteams/export-teams-content). Teams Export APIs allow you to export 1:1, group chat, meeting chats, and channel messages from Microsoft Teams.

## More information

If your organization’s application needs to export Microsoft Teams messages, you can extract them using Teams Export APIs, refer to [Teams Export API](https://docs.microsoft.com/microsoftteams/export-teams-content) for more information. Also, API references for Microsoft Teams are documented here: [Use the Microsoft Graph API to work with Microsoft Teams](https://learn.microsoft.com/graph/api/resources/teams-api-overview?view=graph-rest-1.0)
Additionally, you can also subscribe to change notification by creating a subscription for Teams resources. For more information, see [Create subscription](https://learn.microsoft.com/graph/api/subscription-post-subscriptions).

