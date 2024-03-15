---
title: GooglePermanentWebException error in a Google Workspace migration
description: Provides a resolution for a GooglePermanentWebException error that occurs when you try to batch migrate mailboxes from Google Workspace to Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 185304
ms.reviewer: shahmul, ninob, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 01/30/2024
---

# GooglePermanentWebException error in a Google Workspace migration

## Symptoms

You try to migrate a batch of mailboxes from Google Workspace to Microsoft Exchange Online. However, when you view the migration status in the Exchange admin center (EAC), or run the [Get-MigrationBatch](/powershell/module/exchange/get-migrationbatch#-includereport) PowerShell cmdlet to get the status, you see the following error message:

> Error: GooglePermanentWebException: The API call to Google ended in the error: uri=`https://www.googleapis.com/calendar/v3/users/<user>/calendarList?maxResults=250` response={"error":{"code":403,"message":"Google Calendar API has not been used in project \<project ID\> before or it is disabled. Enable it by visiting `https://console.developers.google.com/apis/api/calendar-json.googleapis.com/overview?project=<project ID>` then retry. If you enabled this API recently, wait a few minutes for the action to propagate to our systems and retry"... (403) Forbidden.

## Cause

The Google Calendar API is disabled in the Google Workspace account that hosts the mailboxes.

## Resolution

1. [Enable the Google Calendar API](https://support.google.com/googleapi/answer/6158841) in the Google Workspace account that hosts the mailboxes.

2. Wait 5&ndash;10 minutes for the API to become fully enabled, and then resume the batch migration.
