---
title: How to manage maximum concurrent migration batches
description: Describes how to manage the number of concurrent migration batches in Exchange Online in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-lanac, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# How to manage the maximum concurrent migration batches in Exchange Online in Microsoft 365

_Original KB number:_ &nbsp; 2797784

## Summary

This article describes how to manage the number of concurrent migration batches in Microsoft Exchange Online in Microsoft 365.

## Resolution

Administrators can set the number of concurrent migration batches for new and existing migration batches by using the Exchange Admin Center (EAC) or Exchange Online PowerShell.

To do this, use one of the following methods, as appropriate for your situation.

### Method 1 - Use the Exchange Admin Center

When you use the EAC, you can specify only the number of concurrent migration batches for an existing migration batch. To do this, follow these steps:

1. Create a migration batch by using either the EAC or Exchange Online PowerShell.
2. Sign in to the [Microsoft 365 portal](https://www.office.com/?auth=2), select **Admin**, and then select **Exchange** to open the EAC (if it's not already open).
3. In the left navigation pane, select **Recipients**, and then select **Migration**.
4. Select the migration batch that you want to change.
5. Under **Associated endpoint**, select **View details**.

    :::image type="content" source="media/how-to-manage-maximum-concurrent-migration-batches/associated-endpoint.png" alt-text="Screenshot of the status for current migration batches showing the Associated endpoint section.":::

6. In the **Edit Migration Endpoint** window, enter a value in the ***Maximum concurrent migrations** box.

    > [!NOTE]
    > There is a limit of 300 concurrent migrations for each type of migration endpoint.
7. Select **Save**.

### Method 2 - Use Exchange Online PowerShell

To set the maximum number of concurrent migration batches by using Exchange Online PowerShell, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the following command:

    ```powershell
    Set-MigrationEndpoint -Identity <name of associated endpoint> -MaxConcurrentMigrations < X >
    ```

    > [!NOTE]
    > The placeholder \<X> represents a numeric value.

## More Information

For more information about migration endpoints, see the Connect Microsoft 365 or Microsoft 365 to your email system section of the article [Perform a staged migration of email](/exchange/mailbox-migration/perform-a-staged-migration/perform-a-staged-migration).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
