---
title: Troubleshoot issues that occur when you send e-mail statements
description: Discusses several troubleshooting methods and items that you can review to troubleshoot issues that occur when you send e-mail statements in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Troubleshoot issues that occur when you send e-mail statements in Microsoft Dynamics GP

This article discusses different methods that you can use to troubleshoot issues that occur when you send e-mail statements in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 934699

Follow these steps to troubleshoot issues that occur when you send e-mail statements.

> [!NOTE]
> After each step, test to determine whether you can send e-mail statements successfully before you go to the next step.

1. Verify that you are sending the statement to the correct e-mail address. You must do this in the Receivables Management Setup window and in the Customer Maintenance Options window.

    - Receivables Management Setup window

        1. Click **Tools**, point to **Setup**, point to **Sales**, and then click **Receivables**.
        2. In the Receivables Management Setup window, make sure that the **Status Recipient** field in the **E-mailed Statements** area contains a valid e-mail address.

    - Customer Maintenance Options window

        1. Click **Cards**, point to **Sales**, and then click **Customer** to open the Customer Maintenance window.
        2. Click the lookup button next to the **Customer ID** field, and then click a customer.
        3. Click **Options**.
        4. In the Customer Maintenance Options window, make sure that the **Send E-mail Statements** check box is selected. When you are prompted, enter the path in which you want the E-mail Statements Status Report to be created.
        5. Make sure that the **To** field contains a valid e-mail address.

2. Verify that the correct options are enabled in the E-mail Statements Options window. To do this, follow these steps:

    1. Click **Tools**, point to **Routines**, point to **Sales**, and then click **Statements**.
    2. In the Print Receivables Statements window, click the lookup button next to the **Statement ID** field, and then click a statement.
    3. Click **E-mail Options**.
    4. In the E-mail Statements Options window, make sure that one of the following options is selected:
        - **Send E-mail Customer Statements**  
        - **Print and Send E-mail Customer Statements**

3. Confirm the path for the delivery of e-mail statements in the Dex.ini file. To do this, follow these steps:

    1. Open the Dex.ini file in a text editor such as Notepad. By default, the Dex.ini file is in the following location:

        C:\\Program Files\\Microsoft Dynamics\\GP

    2. Locate the line that contains the following item:

        EmailStmtStatusPath= **path**  

        If the "EmailStmtStatusPath" line does not exist in the Dex.ini file, create the file. To do this, use one of the following methods:

        - Manually add the "EmailStmtStatusPath" line to the Dex.ini file. Insert the "EmailStmtStatusPath" line under the "WindowHeight" line.

            For example, the Dex.ini file may resemble the following:

            WindowPosX=184  
            WindowPosY=184  
            WindowWidth=960  
            WindowHeight=559  
            EmailStmtStatusPath=c:\\users\\ *

        - Click to select the **Send E-mail Statements** check box so Microsoft Dynamics GP will create the "EmailStmtStatusPath" line in the Dex.ini file. To do this, follow these steps:
            1. On the **Card** menu, point to **Sales**, and then click **Customer**.
            2. Click **Options**.
            3. Click to select the **Send E-mail Statements** check box. When you do this, you are prompted to enter a path for the delivery of the e-mail statements.

    3. Confirm that the path for the delivery of e-mail statements resembles the following path:

        EmailStmtStatusPath=c:\\documents and settings\\ **user_name** \\desktop

4. Verify that a PDF writer that has been tested for use with Microsoft Dynamics GP is installed. Adobe PDF Writer is one PDF writer that has been tested.

5. Make sure that you use a MAPI compliant e-mail program such as Microsoft Outlook.
