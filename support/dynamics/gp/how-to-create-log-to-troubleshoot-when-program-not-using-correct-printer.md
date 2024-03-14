---
title: How to create log file for printer in Named Printers Options
description: Provides information that will help you troubleshoot problems that may occur when you print by using named printers in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to create a log file to troubleshoot when program not using the printer specified in Named Printers Options

This article describes how to create a log file that you can use to troubleshoot Microsoft Dynamics GP when the program does not use the printer that you specified in the **Named Printers Options** dialog box. Microsoft Dynamics GP may use the wrong printer even though you specifically changed the printer in the **Named Printers Options** dialog box.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850068

You can use the ST_Debug.LOG file to troubleshoot named printers. This log file provides information about any problems that occurred when you tried to change printers. To create the ST_Debug.LOG file, follow these steps:

1. Add the following line to the Dex.ini file in the local Microsoft Dynamics GP folder.

    ```console
    ST_Debug=LOG
    ```

    > [!NOTE]
    > In Microsoft Dynamics GP 10.0, the Dex.ini file is in the Data subfolder in the local Microsoft Dynamics GP folder.
2. Try to print again.
3. In the local Microsoft Dynamics GP directory, view the ST_DEBUG.LOG file.

    > [!NOTE]
    > In Microsoft Dynamics GP 10.0, the log file is in the Data subfolder of the local Microsoft Dynamics GP directory.

4. After you resolve the problem, remove the ST_Debug=LOG line from the Dex.ini file.

Microsoft Dynamics GP may use the wrong named printer if the printer name contains more than 30 characters. (This includes the slashes.) To review the printer name, select **Tools**, point to **Setup**, point to **System**, and then select **Named Printers**.
