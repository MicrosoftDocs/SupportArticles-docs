---
title: Create a batch file to schedule a job
description: Describes how to create a batch file to schedule a job by using Windows Task Scheduler.
ms.reviewer: theley, kyouells
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to create a batch file to schedule a job by using Windows Task Scheduler when you use Microsoft Dynamics GP on a computer that is running SQL Server Express Edition

This article describes how to create a batch file to schedule a job by using Windows Task Scheduler when you use Microsoft Dynamics GP on a computer that is running Microsoft SQL Server 2005 Express Edition or Microsoft SQL Server 2008 Express Edition.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 958368

## Introduction

If you're running SQL Server 2005 Express Edition or SQL Server 2008 Express Edition on the computer, the SQL Server Agent service is unavailable.

When you use Microsoft Dynamics GP together with Microsoft SQL Server Express Edition, Microsoft Dynamics GP creates a default job to truncate the PJOURNAL table for each company database. The PJOURNAL table stores temporary records that are related to posting. Because the SQL Server Agent service isn't available, you must use Windows Task Scheduler to schedule these jobs when you use SQL Server Express Edition.

## More information

To create a batch file to schedule a default job by using Windows Task Scheduler, follow these steps:

1. In Notepad, paste the following code:

    ```sql
    OSQL -S <SERVERNAME> -E -q "exit(DELETE <DBNAME>..PJOURNAL)"
    ```

    > [!NOTE]
    > The *SERVERNAME* placeholder represents the name of your instance of SQL Server. The *DBNAME* placeholder represents your company database name.

2. If you have multiple company databases, you must create a delete statement for each company. Then, you must add this delete statement to the Notepad file that you created in step 1. Or, you can create a separate batch file for each company.
3. Select **File**, select **Save**, and then save the file as *PJOURNAL.bat*.
4. On the computer that is running Microsoft SQL Server Express, select **Start**, point to **All Programs**, point to **Accessories**, point to **System Tools**, and then select **Scheduled Tasks**.
5. Double-click **Add Scheduled Task**.
6. In the Scheduled Task Wizard, select **Next**.
7. Select **Browse**, select the PJOURNAL.bat file that you created in step 4, and then select **Open**.
8. Type PJOURNAL for the name of the task, and then select **Daily**. Then, select **Next**.
9. Specify information for a schedule to run the Task. We recommend that you run it at least one time every day. Then, select **Next**.
10. In the **Enter the user name** field and in the **Enter the password** field, type a username and a password. Then, select **Next**.
11. Select **Finish**.
    > [!NOTE]
    > Microsoft Dynamics GP 9.0 is not supported on SQL Server 2008. However, Microsoft Dynamics GP 9.0 is supported on SQL Server 2005.
