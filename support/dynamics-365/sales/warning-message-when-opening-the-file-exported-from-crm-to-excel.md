---
title: Cannot open the file that you exported to Excel
description: Describes a problem that occurs when you open a file that you export from Microsoft Dynamics CRM to Excel 2007. A workaround is provided.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# The file you are trying to open is in a different format than specified warning when opening a file that is exported to Excel

This article provides a workaround for the issue that a warning message may occur when you open a file that you exported to Microsoft Office Excel 2007 or Microsoft Office Excel 2010 from Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 946274

## Symptoms

When you try to open a file that you exported to Microsoft Office Excel 2007 or Office Excel 2010 from Microsoft Dynamics CRM, you receive the following warning message:

> The file you are trying to open, <File_name.xls> is in a different format than specified by the file extension. Verify that the file is not corrupted and is from a trusted source before opening the file. Do you want to open the file now?

> [!NOTE]
> The <File_name.xls> placeholder is a placeholder for the name of the file that you want to open.

This problem occurs if the following conditions are true:

- You exported one of the following types of worksheet from Microsoft Dynamics CRM:
  - Static worksheet
  - Dynamics PivotTable
  - Dynamics worksheet
- The view from which you exported the worksheet contained at least one record.

## Cause

This problem occurs because Microsoft Dynamics CRM exports the records as an .xml file. Because Excel 2007 also adds an .xml file filter, the .xml file has a different file type than the original file when Excel opens the .xml file.

## Workaround

To work around this problem, select **Yes** in the dialog box that contains the warning message. You can safely ignore the warning message.
