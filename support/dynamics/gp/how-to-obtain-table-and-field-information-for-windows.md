---
title: How to obtain table and field information for windows
description: Discusses different methods that you can use to obtain the table and field information for windows in Microsoft Dynamics GP.
ms.reviewer: 
ms.topic: how-to
ms.date: 03/13/2024
---
# How to obtain the table and field information for windows in Microsoft Dynamics GP

This article discusses the different methods that you can use to obtain the table and field information for windows in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 894335

There are several methods that you can use to obtain the table and field information for windows in Microsoft Dynamics GP. You can use one or more of the following methods:

- Obtain a list of tables
- Create a DEXSQL.log file
- Examine the transaction flow documents
- Manually select the table
- Use Dexterity Script Debugger
- Use Activity Tracking

## Obtain a list of tables

Method 1, method 2, and method 3 produce the same list of tables.

### Method 1

1. Open the Microsoft Dynamics GP window that contains the data for which you want the table and field information.
2. On the Tools menu, point to **Integrate**, and then select **Table Import**.

> [!NOTE]
> There should be only one window open when you use method 1.

### Method 2

1. Open the Microsoft Dynamics GP window that contains the data for which you want the table and field information.
2. On the **Tools** menu, point to **Customize**, and then select **Modify Current Window**.
3. When you are in the Modifier in the window layout, view the window object properties. If you do not see the Properties window, select **Properties** on the **Layout** menu.

    Usually, the most important table for a form has the **AutoLinkTable** property so that the table is automatically linked to the form.

4. To see the attached tables, close the window layout, and then view the **Tables** tab in the Form Definition window.

> [!NOTE]
>
> - When you are prompted to save changes to the window, do not save the changes.
> - In method 2, you can create additional windows in the Modifier that have not actually been modified. Before you use method 2, you should determine whether the window is already located in the Modifier. You can delete a window from the Modifier if no modifications have been made to it or if you do not want to keep the modified window.

### Method 3

1. Install Dexterity in Microsoft Dynamics GP from the second CD-ROM for Microsoft Dynamics GP.

    > [!NOTE]
    > The installation file is located in the Tools\Dex folder.

2. To see the attached tables, open the dictionary, and then view the Form Definition window.

## Create a DEXSQL.log file

1. To create a DEXSQL.log file, add or change the following lines in the Dex.ini file:
   - SQLLogSQLStmt=TRUE
   - SQLLogODBCMessages=TRUE
   - SQLLogAllODBCMessages=TRUE

2. Before you perform the steps that you want to log, delete the DEXSQL.log file in the Microsoft Dynamics GP code directory. Then, open the window that contains the data for which you want the table and field information. After you open the window, you can view the table and field information in the DEXSQL.log file.

## Examine the transaction flow documents

Install the software development kit (SDK). The SDK contains transaction flow documents that indicate the tables that you can use for specific transactions. A transaction flow document does not show all the tables. This document lists only the tables that are used most frequently.

## Manually select the table

You can open the Table Descriptions window and then manually select the table for which you want information. To open the Table Descriptions window, point to **Resource Descriptions** on the **Tools** menu, and then select **Tables**.

## Use Dexterity Script Debugger

Usually, only a Dexterity developer can use this method. We recommend that you use the settings that are mentioned in this section in a test environment. To enable the Dexterity Script Debugger, add the following lines to the Dex.ini file in the Microsoft Dynamics GP code directory:

- ScriptDebugger=TRUE
- ScriptDebuggerProduct=0

The product ID for Microsoft Dynamics GP is 0. To debug a module in Microsoft Dynamics GP, replace 0 with the product ID for the module. The product ID is shown in the Dynamics.set file. To obtain the table and field information, follow these steps:

1. Start Microsoft Dynamics GP or Microsoft Great Plains, and then sign in to the application.
2. In the application, move to a location just before the section of code that you want to analyze.

3. To analyze the code, follow these steps:

   1. Select **Debug**, select **Log Scripts**, and then specify a path for the Script.log file.
   2. Select **Debug**, and then select **Profile Scripts**.
   3. Select **Debug**, and then select **Clear Profile**.
4. Perform the action that you want to analyze.
5. To stop the analysis, follow these steps:

   1. Select **Debug**, and then select **Log Scripts**.
   2. Select **Debug**, select **Save Profile**, and then specify a path for the Profile.txt file.
   3. Select **Debug**, and then select **Profile Scripts**.

6. Locate the Script.log file and the Profile.txt file, and then send these files to a developer or to a support team for analysis.

Next, examine the script log file and the script profile file. The script log file lists all the Dexterity calls with their parameters and their hierarchies. The script profile file lists the scripts that were called. The script profile file also shows how many times the scripts were called and the time that was spent inside the call. The second half of the script profile file lists all the tables that were affected and the actions that occurred.

> [!NOTE]
> Step 6 logs only the Dexterity-based table actions. If a stored procedure is called, the stored procedure is not detected by Dexterity. Therefore, Dexterity does not log that table action.

## Use Activity Tracking

You can use activity tracking in Microsoft SQL Server to obtain the table and field information for windows. You can enable activity tracking in SQL Server Enterprise Manager. Activity tracking lets you see Microsoft SQL Server actions.
