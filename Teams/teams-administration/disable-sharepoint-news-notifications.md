---
title: Disable SharePoint News notifications in Teams
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 08/09/2024
audience: Admin
ms.topic: troubleshooting
search.appverid:
  - SPO160
  - MET150
appliesto:
  - Teams
ms.custom:
  - sap:Teams Admin
  - CI 194335
  - CSSTroubleshoot
ms.reviewer: anindara, jaikarkhanis, salarson
description: Provides a workaround to stop the notifications in Teams about SharePoint News.
---

# Disable SharePoint News notifications in Teams

## Symptoms

You see many notifications in Microsoft Teams about [News that's posted to Microsoft SharePoint sites](https://support.microsoft.com/office/what-happens-when-i-post-news-c0578139-6f2e-4474-9ba9-adf8a1a69a30). These notifications link to the Microsoft Viva Connections app in Teams.  

## Cause

The Viva Connections app delivers notifications in Teams about SharePoint News posts. The notifications link to the Viva Connections app, where you can read the News items.  

Because of a recent update, the Viva Connections app is now preinstalled for all Teams users. Therefore, you now receive notifications about SharePoint News when:

- News is published to a SharePoint team site or a communication site that you follow or that someone who works closely with you follows.
- News that's targeted to you is boosted.
- Someone comments on a new News item that you posted.
- Someone "Likes" a News item that you posted.
- Someone is @mentioned in a comment on a News item that you posted.  

## Workaround

Viva Connections notifications follow the Teams notification settings, including the Quiet Hours settings.

You can control which notifications you want to receive in the following manner:

- On Teams desktop and in Teams on the web, you can selectively enable or disable specific notification types under **Settings** > **Notifications and activity** > **Apps** > **Viva Connections**. These settings are also respected on Teams mobile.
- On Teams mobile, you can't selectively enable or disable notifications. However, you can toggle all push notifications (including Viva Connections) in the Teams mobile app under **Settings** > **Notifications** > **General Activity** > **Apps on Teams**. Even after you disable the notifications, they're still visible in the Teams activity feed.  

> [!NOTE]
> There is no organization-wide method for an administrator to control Viva Connections notifications.  
