---
title: User doesn't receive an email invitation to a shared resource
description: This article describes an issue where SharePoint Online user doesn't receive an email invitation to a shared resource, and provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# SharePoint Online user doesn't receive an email invitation to a shared resource

## Problem

You share a resource from SharePoint Online with a user for the first time and you select the Send an email invitation option. In this situation, the user doesn't receive the email message. However, the user is granted access to the resource. Additionally, if you share resources on the same site collection again, the user receives the email message.

## Solution/Workaround

To work around this issue, share the resource on the same site collection with the user again.

## More information

This issue occurs when the following conditions are true:

- The SharePoint Online user doesn't have a Microsoft Exchange Online license.

- You aren't using directory synchronization.

> [!NOTE]
> Although the initial email invitation isn't received by the user, the user is granted access to the resource.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
