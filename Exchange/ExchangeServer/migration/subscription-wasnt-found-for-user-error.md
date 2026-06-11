---
title: A subscription wasn't found for this user error when you migrate a public folder batch
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Exchange Server Online
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.custom: 
  - sap:Public Folder Configuration
  - Exchange Server
  - CI 123889
  - CI 9823
  - CI 11992
  - CSSTroubleshoot
ms.reviewer: batre, v-six, v-kccross
description: Describes the resolution to the Exchange error A subscription wasn't found for this user that you might receive when you migrate a public batch folder.
ms.date: 06/03/2026
---

# A subscription wasn't found for this user error when you migrate a public folder batch in Microsoft Exchange Server

## Summary

When you migrate public folders from Microsoft Exchange Server to Exchange Online, a migration batch fails or shows a `SyncedWithError` status, and returns the error message, "A subscription wasn't found for this user." This problem occurs if the public folder mailbox migration request that's associated with a migration user is missing or corrupted. To resolve the problem, stop and restart the migration batch to re-create the missing migration request.

## Symptoms

When you migrate public folders from Exchange Server to Exchange Online, the migration status displays `Failed` or `SyncedWithError`. Also, one or more migration users display a status value of `Failed`. When you select the migration user in the Exchange admin center (EAC), you see the following warning message:

> The subscription for the migration user MLPF3 couldn't be loaded. The following error was encountered: A subscription wasn't found for this user.

:::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-1.png" alt-text="Screenshot of an error message that the subscription for the migration user M L P F 3 couldn't be loaded.":::

You might also see the following error message:

> Couldn't find a request that matches the information provided. Reason: No such request exists in the specified index.

## Cause

This problem might occur if the public folder mailbox migration request that's associated with the migration user is missing or corrupted, as shown in the following screenshot.

:::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-2.jpg" alt-text="Screenshot of public folder mailbox migration request with missing or corrupted user.":::

## Resolution

Follow these steps:

1. Stop the migration batch. The process to terminate the migration batch might take some time to finish.
1. Make sure that the migration batch reaches the "Stopped" state.
1. Restart the migration batch. This action re-creates the missing public folder migration request.

    :::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-3.jpg" alt-text="Get-MigrationUser screen.":::

    :::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-4.jpg" alt-text="Get-PublicFolderMailboxMigrationRequest screen.":::
