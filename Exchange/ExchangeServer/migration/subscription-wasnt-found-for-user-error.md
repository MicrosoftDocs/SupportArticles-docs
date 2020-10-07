---
title: Error (A subscription wasn’t found for this user) when migrating a public folder batch in Exchange
ms.author: v-todmc
author: mccoybot
manager: dcscontentpm
ms.date: 10/7/2020
audience: Admin
ms.topic: article
ms.service: exchange-online
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Exchange
ms.custom: 
- CI 123889
- CSSTroubleshoot 
ms.reviewer: batre
description: Describes the resolution to the Exchange error "A subscription wasn't found for this user" when trying to migrate a public batch folder.
---

# Exchange error (A subscription wasn’t found for this user) when migrating a public folder batch

## Symptoms

When you try to migrate a public folder batch, the batch enters into a failed or “SyncedWithError” state. When you select the migration user in the Exchange admin center (EAC), you see the following warning message:

> The subscription for the migration user MLPF3 couldn’t be loaded. The following error was encountered: A subscription wasn’t found for this user.

:::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-1.png" alt-text="A subscription wasn't found for this user error message.":::

Additionally, you may see the following error message when you select the migration user object in the EAC:

> Couldn't find a request that matches the information provided. Reason: No such request exists in the specified index.

## Cause

The issue can occur if the public folder mailbox migration request that is associated with the migration user is missing or corrupted, as shown in the following screenshot.

:::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-2.jpg" alt-text="Screenshot of public folder mailbox migration request with missing or corrupted user."::: 

## Resolution

1.	Stop the migration batch.
    > [!note]
    > Terminating the migration batch may take some time to finish.
2.	Make sure that the migration batch has reached the “Stopped” state.
3.	Restart the migration batch.

The process will re-create the missing public folder migration request.

:::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-3.jpg" alt-text="Get-MigrationUser screen.":::

:::image type="content" source="media/subscription-wasnt-found-for-user-error/subscription-wasnt-found-for-user-error-4.jpg" alt-text="Get-PublicFolderMailboxMigrationRequest screen.":::

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).