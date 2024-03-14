---
title: Create a Dexsql.log file to troubleshoot
description: Describes how to create a Dexsql.log file that can help you troubleshoot error messages.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to create a Dexsql.log file to troubleshoot error messages in Microsoft Dynamics GP

This article describes how to create a Dexsql.log file for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850996

## Introduction

When you receive an error message in Microsoft Dynamics GP, a Dexsql.log file is a helpful tool that can frequently provide more information to troubleshoot issues. If you can re-create the error message, the Dexsql.log file can capture this information.

## More information

To create a Dexsql.log file, follow these steps:

1. Open the Dex.ini file. By default, this file is in the following location:
   - Microsoft Dynamics GP 10.0 and later releases:  
       `C:\Program Files\Microsoft Dynamics\GP\Data`

2. Locate the following statements in the Dex.ini file:

    ```sql
    SQLLogSQLStmt=FALSE SQLLogODBCMessages=FALSE SQLLogAllODBCMessages=FALSE
    ```

3. If the statements are currently set to FALSE, change the statements to TRUE, as follows:

    ```sql
    SQLLogSQLStmt=TRUE SQLLogODBCMessages=TRUE SQLLogAllODBCMessages=TRUE
    ```

4. Start Microsoft Dynamics GP. If Microsoft Dynamics GP is already started, exit Microsoft Dynamics GP, and then restart it.
5. Re-create the scenario in which you received the error message. Sign into the window needed, bug before you do the steps to generate the error message, you should go clear out the dexsql.log that has run to this point (as you only want it to capture generating the error message only, and don't need anything captured up to this point). To do it, go to the next step.
6. In Windows Explorer, open the Microsoft Dynamics GP application folder that you opened in step 1. Locate the **Dexsql.log** file. Delete or rename this file, as you don't need anything it captured up to this point.

    (If you don't see the Dexsql.log file listed, select **View**, and then select **Refresh** so that you can see the new file. Or check your path.)
7. Now back in Microsoft Dynamics GP, continue to do the final steps to re-create the error message. A new Dexsql.log file will be generated in the Microsoft Dynamics GP application folder again, that contains only the syntax of generating the error message.
8. Turn off the dexsql.log: To do it, open the Dex.ini file, and then reset the statements to FALSE or to the original settings.

    > [!NOTE]
    > It will continue to run until the user signs out of Microsoft Dynamics GP and back in again. It doesn't hurt to leave it run either, but may result in the log getting large and causing performance issues down the road.
