---
title: Print to File without user intervention
description: Describes how to Print to File without user intervention.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration:-general-issues, csstroubleshoot
ms.technology: windows-server-printing
---
# How to Print to File without user intervention

This article describes how to Print to File without user intervention.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2528405

## Summary

When choosing the option to Print to File from an application, the user is prompted with a dialog to choose the location and name of the file to be saved. If it is desired to automate the `print to file` process in such a way as to save the file without user interaction, follow below steps.

## More information

Here are the steps to achieve it:  

1. Go to **Devices and Printers**.
2. Click on **Add Printers**.
3. Click on **Add a local or network printer as an administrator**.
4. Click on **Add a local printer**.
5. Click on Create a new port: Local Port.
6. You will get a Port Name Box - Type in Path and the file name. for example, "C:\\Temp\\PrintJob.txt".
7. Select the Manufacturer - Generic.
8. Select Printers - Generic / Text Only.
9. Select - Use the driver that is currently installed (recommended).
10. Type a name for the printer.  
11. Share the Printer if needed.
12. Finish.

After these steps, any print jobs sent to this printer will automatically be saved to the location specified as the port.
