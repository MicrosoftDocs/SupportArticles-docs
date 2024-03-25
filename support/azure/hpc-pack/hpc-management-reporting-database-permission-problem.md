---
title: Resolve HPC reporting database permission problem
description: Resolve a high-performance computing (HPC) reporting database permission problem in the HPC Cluster Manager.
ms.date: 10/17/2022
editor: v-jsitser
ms.reviewer: cargonz, v-leedennis
ms.service: hpcpack
#Customer intent: As a Microsoft HPC Pack user, I want to resolve a reporting database permission problem in the HPC Cluster Manager so that I can successfully use a high-performance computing (HPC) management database.
---
# Resolve an HPC reporting database permission problem

This article describes how to resolve a high-performance computing (HPC) reporting database permission problem in the Microsoft HPC Cluster Manager.

## Symptoms

In the HPC Cluster Manager, after you select an item in the **Charts and Reports** pane of the HPC management console, the Cluster Manager can no longer connect to the reporting database, and you receive an error message that resembles the following text:

> The HPC Cluster Manager cannot connect to the reporting database. Please check connection string 'Data Source=\<data-source-name>;Initial Catalog=CHHPCReporting;Integrated Security=True;' and make sure you have access.
>
> The EXECUTE permission was denied on the object 'GetHelperInfo', database 'CHHPCReporting', schema 'HpcReportingSp'.

## Cause

The user account wasn't added to the `db_datareader` database, or the account wasn't granted the EXECUTE permission on the `dbo` schema.

## Solution

Follow these steps to add the user account and apply the necessary permissions.

### Part 1: Set up the HPC database and add an admin group for HPC reports

1. Follow the procedure in [Run SetupHpcDatabase script][run-script] to complete the configuration of the HPC databases and SQL Server sign-ins.

1. On the **Start** menu, search for and select **SQL Server Management Studio**.

1. In the **Microsoft SQL Server Management Studio** window, select the **Open File** icon.

1. Browse to and open *AddHpcReportsAdminGroup.sql*.

1. In the SQL file, replace all instances of `$(TargetAccount)` with the account that you're using (for example, `hpc1\guest1`).

1. Select the **Execute** icon. The **Messages** pane appears, displaying the "Commands completed successfully" message.

1. In the **Object Explorer** pane, expand **HPCReporting** > **Security** > **Schemas**.

### Part 2: Verify that the HpcReportingSp schema has the expected permissions

1. In the **Object Explorer** pane, select the **HpcReportingSp** schema.

1. Select the **Properties** icon (wrench). The **Schema Properties - HpcReportingSp** dialog box appears.

1. In the **Select a page** pane, select **Permissions**.

1. In the **Users or roles** list, select the name of the user account. The **Permissions for \<account-name>** section's **Explicit** tab will contain the following row of data.

   | Permission  | Grantor | Grant | With Grant | Deny |
   |-------------|---------|:-----:|:----------:|:----:|
   | **Execute** | **dbo** | X     | O          | O    |

1. Select the **Cancel** button.

### Part 3: Verify that the HpcReportingView schema has the expected permissions

1. In the **Object Explorer** pane, select the **HpcReportingView** schema.

1. Select the **Properties** icon (wrench). The **Schema Properties - HpcReportingView** dialog box appears.

1. In the **Select a page** pane, select **Permissions**.

1. In the **Users or roles** list, select the name of the user account. The **Permissions for \<account-name>** section's **Explicit** tab will contain the following rows of data.

   | Permission          | Grantor | Grant | With Grant | Deny |
   |---------------------|---------|:-----:|:----------:|:----:|
   | **Select**          | **dbo** | X     | O          | O    |
   | **View definition** | **dbo** | X     | O          | O    |

1. Select the **Cancel** button.

### Part 4: Verify that the error doesn't occur anymore

In the HPC Cluster Manager, go to the HPC management console, and then select an item in the **Charts and Reports** pane. The dialog box error message about a denied EXECUTE permission shouldn't appear anymore.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[run-script]: /powershell/high-performance-computing/step-1-prepare-the-remote-database-servers#BKMK_Script
