---
title: Error (A subscription wasn't found for this user) when migrating a public folder batch in Exchange Server 2016
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.date: 01/24/2024
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Exchange Server Online
  - Exchange Server 2019
  - Exchange Server 2016
ms.custom: 
  - Exchange Server
  - CI 123889
  - CSSTroubleshoot
ms.reviewer: batre, v-six
description: Describes the resolution to the Exchange error A subscription wasn't found for this user when trying to migrate a public batch folder.
---

# Error (A subscription wasn't found for this user) when migrating a public folder batch

## Symptoms

When you migrate public folders from Exchange Server to Exchange Online, the migration status displays "Failed" or "SyncedWithError". Also, one or more migration users display "Failed" as their status. When you select the migration user in the Exchange admin center (EAC), you see the following warning message:

> The subscription for the migration user MLPF3 couldn't be loaded. The following error was encountered: A subscription wasn't found for this user.

:::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-1.png" alt-text="Screenshot of an error message that the subscription for the migration user M L P F 3 couldn't be loaded.":::

You may also see another error message:

> Couldn't find a request that matches the information provided. Reason: No such request exists in the specified index.

## Cause

The issue can occur if the public folder mailbox migration request that is associated with the migration user is missing or corrupted, as shown in the following screenshot.

:::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-2.jpg" alt-text="Screenshot of public folder mailbox migration request with missing or corrupted user.":::

## Resolution

1. Stop the migration batch.
    > [!note]
    > Terminating the migration batch may take some time to finish.
2. Make sure that the migration batch has reached the "Stopped" state.
3. Restart the migration batch. This will re-create the missing public folder migration request.

    :::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-3.jpg" alt-text="Get-MigrationUser screen.":::

    :::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-4.jpg" alt-text="Get-PublicFolderMailboxMigrationRequest screen.":::
