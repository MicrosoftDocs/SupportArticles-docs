---
title: Print to File without user intervention
description: Describes how to Print to File without user intervention.
ms.date: 10/09/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Management and Configuration General issues
ms.technology: PrintFaxScan
---
# How to Print to File without user intervention

This article describes how to Print to File without user intervention.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2528405

## Summary

When choosing the option to Print to File from an application, the user is prompted with a dialog to choose the location and name of the file to be saved. If it is desired to automate the `print to file` process in such a way as to save the file without user interaction, follow below steps.

## More information

Here are the steps to achieve it:  

Go to Devices and Printers  
Click on "Add Printers"  
Click on "Add a local or network printer as an administrator"  
Click on "Add a local printer"  
Click on Create a new port: Local Port  
You will get a Port Name Box - Type in Path and the file name  
for example "C:\Temp\PrintJob.txt"  
Select the Manufacturer - Generic  
Select Printers - Generic / Text Only  
elect - Use the driver that is currently installed (recommended)  
Type a name for the printer.  
Share the Printer if needed  
Finish

After these steps, any print jobs sent to this printer will automatically be saved to the location specified as the port.
