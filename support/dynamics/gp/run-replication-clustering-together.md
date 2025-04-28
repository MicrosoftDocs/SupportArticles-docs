---
title: Run replication and clustering together
description: Describes the requirements to run replication, clustering, log shipping, and database mirroring together with Microsoft Dynamics GP. Includes support contact information.
ms.reviewer: theley, kyouells
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Description of the requirements to run replication, clustering, log shipping, and database mirroring together with Microsoft Dynamics GP

This article describes the requirements to run replication, clustering, log shipping, and database mirroring together with Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 926490

## Replication

- The snapshot and the transactional replication are the only two types of replication that can be implemented together with Microsoft Dynamics GP.
- Microsoft Dynamics GP requires one-way replication. Two-way replication cannot be implemented together with Microsoft Dynamics GP because the Setup tables keep the next **Document Number** value when you create accounting transactions.
- Replication can be configured together with Microsoft Dynamics GP databases if you follow the following rules:

  - When you select a table for replication, disable the option to add a unique identifier to the table. Otherwise, the table structure is modified. The modification of the table structure causes problems in Microsoft Dynamics GP. NOTE: This option is only available on Microsoft SQL Server 2008 R2 and earlier.

      > [!NOTE]
      > Most Microsoft Dynamics GP tables have a **DEX_ROW_ID** column for the unique identifier. This column provides a unique identifier that can be used together with replication.
  - Before you upgrade Microsoft Dynamics GP, remove replication from the instance of Microsoft SQL Server. Otherwise, problems will occur during the upgrade process.
  - When choosing the tables to replicate, keep in mind replicating transaction tables may slow down certain processes in Microsoft Dynamics GP. Once replication is configured, test out all processes in Microsoft Dynamics GP to ensure you're comfortable with performance.
- For more information about the configuration of replication, contact the Microsoft SQL Server Support Team at 800-936-5800.

## Clustering

- You can run Microsoft Dynamics GP in a single-instance clustering environment and in a multiple-instance clustering environment if there's a one-to-one relationship in an instance of SQL Server.
- For more information about the configuration for a clustering environment, contact the Microsoft SQL Server Support Team at 800-936-5800.

## Log shipping and database mirroring

- You can run Microsoft Dynamics GP in an environment in which log shipping and database mirroring are enabled.

- For more information about the configuration for log shipping or for database mirroring, contact the Microsoft SQL Server Support Team at 800-936-5800.
- Before you upgrade Microsoft Dynamics GP, remove database mirroring from the Microsoft Dynamics GP databases. Otherwise, problems will occur during the upgrade process.

> [!NOTE]
> If you are using Replication, Log Shipping, or Database Mirroring and users have to access Microsoft Dynamics GP on the secondary server, the passwords for the users will no longer be valid. To reset the password, follow these steps:

1. Sign in to Microsoft Dynamics GP as the sa user.
2. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP**  menu, point to **Setup**, point to **System**, and then select **User**.
3. Select the **lookup** button next to **User ID**, and then select the appropriate user.
4. In the **Password** box, enter a new password, and then select **Save**.
