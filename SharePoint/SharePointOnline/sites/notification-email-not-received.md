---
title: Site storage notification emails for group-connected sites not received
description: This article describes an issue that prevents site storage notification email messages for group-connected sites from being received.
author: PramodBalusu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-matthamer
ms.custom: 
  - CSSTroubleshoot
  - CI 161041
appliesto: 
  - SharePoint Online
ms.date: 3/31/2022
---

# Site storage notifications for group-connected SharePoint sites aren't received

Site storage notification email messages that are sent to group-connected SharePoint sites are sent from 'no-reply@sharepointonline.com'. Microsoft 365 treats this address as external. By default, Microsoft 365 groups don’t allow email messages from external addresses. Therefore, the groups block these notifications.

To make sure that site storage notification email messages are received, change your Microsoft 365 group settings to allow email to be sent from an external address:

1. Open the [Microsoft 365 admin center](https://admin.microsoft.com).

1. Select **Group** > **Active groups**.

1. Search for and select the group whose settings you want to change.

1. Select the **Settings** tab.

1. Under **General settings**, select **Allow external senders to email this group**.

1. Select **Save**.

**Notes:**

- This change to enable external senders will allow mail from any external address to be sent to the group.

- Make sure that you check your Junk mail folder in case the external messages are marked as junk.
 
