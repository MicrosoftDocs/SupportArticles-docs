---
title: Site storage notification emails for group-connected sites not received 
description: This article describes an issue that causes site storage notification emails for group-connected sites to not be received.
author: pramod.balusu
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
---

# Site storage notification emails for group-connected SharePoint sites aren't received

Site storage notification emails are sent from 'no-reply@sharepointonline.com'. Microsoft 365 treats it as external address. By default, Microsoft 365 groups don’t allow emails from external addresses, and block the email notification.

To make sure site storage notification emails are received, change your Microsoft 365 group settings to allow email from external addresses:

1. Open the [Microsoft 365 admin center](https://admin.microsoft.com).

1. Select **Group** > **Active groups**.

1. Search for and select the group whose settings you want to change.

1. Select the **Settings** tab.

1. Under **General settings**, select **Allow external senders to email this group**.

1. Select **Save**.

**Notes:**

- Enabling external senders for the group will allow any external address to send email to the group.

- Make sure to check your Junk mail folder in case the emails are being marked as junk. 