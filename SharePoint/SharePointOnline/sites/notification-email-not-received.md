---
title: Notifications sent to SharePoint sites connected to Microsoft 365 groups aren’t received
description: Provides a fix for an issue when notifications aren't received by the group that's connected to a SharePoint site.
manager: dcscontentpm
author: cloud-writer
ms.author: meerak
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: prbalusu; salarson
ms.custom: 
  - sap:Sites\Other
  - CSSTroubleshoot
  - CI 161041
  - CI 164597
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Notifications sent to SharePoint sites connected to Microsoft 365 groups aren’t received

As part of routine administration activities, email messages about requests for access to the site and notifications about the storage limit of the site are sent to the owners of a SharePoint site. If the SharePoint site is connected to a Microsoft 365 group, these email messages are sent to the group's email address.

The email messages are sent from a mail-enabled security group such as 'no-reply@sharepointonline.com'. When a Microsoft 365 group receives a message from such a security group, it treats the address as external and blocks it. This blocking occurs because Microsoft 365 groups aren’t allowed to receive email messages from external addresses by default.

To resolve the issue of blocked email messages, change the settings of the Microsoft 365 group to allow email messages from external addresses:

1. Open the [Microsoft 365 admin center](https://admin.microsoft.com).

1. Select **Group** > **Active groups**.

1. Search for and select the group whose settings you want to change.

1. Select the **Settings** tab.

1. Under **General settings**, select **Allow external senders to email this group**.

    **Note:** This setting will allow email messages from any external address to be sent to the group.

1. Select **Save**.

**Note:**: If the members of the group subscribe to receive copies of all the email messages that are received by the group, they can see the notifications either in their **Inbox** or in their **Junk Mail** folder depending on their individual mailbox settings.
