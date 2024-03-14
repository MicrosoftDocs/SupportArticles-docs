---
title: Use Dexterity Script Debugger to trace bug
description: Describes how to use the Dexterity Script Debugger to trace bugs and performance issues in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to use the Dexterity Script Debugger to trace bugs and performance issues in Microsoft Dynamics GP

This article describes how to use the Dexterity Script Debugger to trace bugs and performance issues in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 910982

## About the Dexterity Script Debugger

When you try to identify the cause of a bug or understand why some functions have slow performance, support teams typically request a Dexsql.log file. The Dexsql.log file shows all the communication between the application and the computer that is running Microsoft SQL Server. However, the Dexsql.log file doesn't show the internal processing that occurs in the application. Additionally, the Dexsql.log file doesn't show access to the tables that aren't based on SQL Server, such as local temporary tables.

The Dexterity Script Debugger uses two methods to trace what is occurring in the code:

- The Script log (Script.log) shows all the scripts that are called. The scripts are shown in their hierarchy and with their parameters.
- The Script Profile log (Profile.txt) lists all the scripts that are called and all the tables that are referenced. The Script Profile log also lists the times the scripts were called and the times the tables were referenced. The Script Profile log also lists the milliseconds each action took.

## How to enable the Dexterity Script Debugger

To enable the Dexterity Script Debugger in a live run-time environment, and to generate the Script log and the Script Profile log, follow these steps:

1. Change the Dex.ini file by adding the following lines to the **[General]** section.

    > ScriptDebugger=TRUE  
    ScriptDebuggerProduct=0

    > [!IMPORTANT]
    > The product ID is typically set to zero for Microsoft Business Solutions - Great Plains, but the product ID can be the product ID of any product in the Dynamics.set file.
2. Start Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains, and then sign in to the application.
3. In the application, move to a location just before the section of code that you want to analyze.
4. To analyze the code, follow these steps:
    1. Select **Debug**, select **Log Scripts**, and then specify a path for the Script.log file.
    2. Select **Debug**, and then select **Profile Scripts**.
    3. Select **Debug**, and then select **Clear Profile**.
5. Do the action that you want to analyze.
6. To stop the analysis, follow these steps:
    1. Select **Debug**, and then select **Log Scripts**.
    2. Select **Debug**, select **Save Profile**, and then specify a path for the Profile.txt file.
    3. Select **Debug**, and then select **Profile Scripts**.
7. Locate the Script.log file and the Profile.txt file, and then send these files to a developer or to the support team for analysis.

## Evaluating the logs

To identify the scripts that are experiencing slow performance, open the Profile.txt file by using Notepad. (Make sure that **Word Wrap** on the **Format** menu isn't selected.) The scripts that have the highest values in the **Count** column and in the **+Children** column may be the scripts that are experiencing slow performance. To identify the child scripts and the parent scripts of a particular script, search for the script in the Script.log file. Child scripts are shown under the script. The child scripts are indented. The parent scripts are higher in the hierarchy than the child scripts.

You can also use the Profile.txt file to identify the tables that Dexterity used while the Dexterity Script Debugger was running. However, tables that were accessed by stored procedures aren't shown in these statistics. Additionally, the internal workings of a stored procedure aren't captured by the Dexterity Script Debugger. To capture this information, you must run a trace in SQL Server.
