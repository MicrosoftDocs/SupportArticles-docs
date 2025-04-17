---
title: The journal entry is not accessible message shows
description: When trying to view a journal entry in the Journal Entry Inquiry window, this message displays - The journal entry is not accessible. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# "The journal entry is not accessible" displays in the Journal Entry Inquiry window

This article provides a resolution for the issue that when you view a journal entry in the Journal Entry Inquiry window, the **journal entry is not accessible** message is shown.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2397557

## Symptoms

When trying to view a journal entry in the Journal Entry Inquiry window, this message displays:

> The journal entry is not accessible.

## Cause

There are several reasons on why this message may happen:

1. A third-party product is interfering- see Method 1 in the Resolution section.
2. The transaction for the journal entry has been removed from the GL table - see Method 2 in the Resolution section below.
3. For any other reason, open a support case for further assistance and attach the Dexsql.log in Method 3.

## Resolution

Below are possible explanations on why the Journal Entry (JE) may not be accessible to view:

### Method 1 - A third-party product may cause the journal entry not to display

To test, follow these steps:

1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Customize** and select **Customization Status**.

2. Select any third-party product and then select **Disable**. (You can leave Microsoft Dynamics GP enabled, but can disable all others. Although any other Microsoft products should compatible.) Disable any third-party products that you recognize.

3. Exit out of the window.

4. Now test pulling up the Journal entry again. (You may need to go back and select **Enable** for a few modules and keep testing, until you find the module that is causing the problem.)

> [!NOTE]
> Disabling modules in the Customization Status window is temporary. Therefore, if you exit out of Microsoft Dynamics GP and log back in, all the products will automatically become enabled again.

### Method 2 - Check if the transaction does exist in the General Ledger (GL) tables

If it is missing from the open table, this would explain why it doesn't pull up. To do this, follow these steps:

1. Open SQL Server Management Studio.
2. Select **New Query** in the top menubar.
3. Select the company database from the drop-down list.
4. Copy in these scripts to look for the transaction in the GL Year-to_Date transaction Open table (GL20000) or the GL Account Transaction History table (GL30000). Execute these scripts against the company database to locate where the Journal Entry resides.

    ```sql
    Select * from GL20000 where JRNENTRY = 'xxx' (insert in the JE# for the xxx placeholder)
    Select * from GL30000 where JRNENTRY = 'xxx' (insert in the JE# for the xxx placeholder)
    ```

    > [!NOTE]
    > You should get at least two lines returned from the open table: each journal entry will have at least one debit and one credit record. If you don't get any results returned, then the journal entry has been removed from the GL table which would explain why you are not able to view it.
    >
    > The Journal Entry Inquiry window is designed to pull from the open table. So if you find it in the history table, you would not be able to view it using the Journal Entry Inquiry window. You can only view historical journal entries using Smartlist.

### Method 3 - For any other reason, turn on a dexsql.log of trying to view the journal entry and open a new chargeable support case for further assistance

1. Turn on the dexsql.log using the steps in [How to create a Dexsql.log file to troubleshoot error messages in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-850996-how-to-create-a-dexsql-log-file-to-troubleshoot-error-messages-in-microsoft-dynamics-gp-67f4d9e9-51dd-69a8-57d8-6625416e3cb1).

2. Sign in to Microsoft Dynamics GP and select **Inquiry**, point to **Financial** and select **Journal Entry Inquiry**.
3. Type in the Journal Entry number and stop.
4. Delete the dexsql.log that was created up into this point in the GP code folder, as we don't need any data in the log up to this point.
5. Back in the Journal Entry Inquiry window, select **OK** to reproduce the message. Stop there.
6. Flip over to the GP code folder and immediately rename the dexsql.log that was created, so you do not write anything else you do in Microsoft Dynamics GP to this log.
7. Open a support case and attach the dexsql.log to the case for review.
