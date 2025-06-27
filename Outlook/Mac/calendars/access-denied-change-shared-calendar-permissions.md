---
title: Error when you change shared calendar permissions in Outlook for Mac
description: Fixes an issue in which you receive an Access Denied error when you change permissions to a calendar shared by another user.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar
  - Outlook for Mac
  - CI 142018
  - CSSTroubleshoot
ms.reviewer: ahaque
appliesto: 
  - Outlook 2019 for Mac
  - Outlook 2021 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 02/21/2024
---
# Error when you change shared calendar permissions in Outlook for Mac

## Symptoms

You have owner permissions to a user's shared calendar in Microsoft Outlook for Mac. When you try to grant permissions to other users to access the shared calendar, you receive the following error message:

> Not allowed to share this calendar.

This error occurs when you change the permissions in the **Calendar Properties** dialog box.

You also see a similar message displayed in the logs for Outlook for Mac.

## Cause

This behavior is by design in Outlook for Mac.

## Resolution

Only the original owner of the shared calendar can grant permissions to other users to access the calendar.
