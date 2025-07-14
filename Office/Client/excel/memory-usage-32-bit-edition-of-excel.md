---
title: Memory usage in the 32-bit edition of Excel
description: Describes memory usage after you upgrade from Excel 2010 to Excel 2013.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
  - Excel 2016
ms.date: 05/26/2025
---

# Memory usage in the 32-bit edition of Excel 2013 and 2016

## Symptoms

After you upgrade to Microsoft Office 2013 or 2016, you experience one or more of the following symptoms:  

- The computer uses more memory when you open multiple Microsoft Excel files, save Excel files, or make calculations in Excel workbooks.
- You can no longer open as many Excel workbooks in the same instance as you could before you upgraded to Excel.
- When you insert columns in an Excel workbook, you receive an error about available memory.
- When you are working with an Excel worksheet, you receive the following error message:

    ```output
    There isn't enough memory to complete this action.
    Try using less data or closing other applications.
    To increase memory availability, consider:
    - Using a 64-bit version of Microsoft Excel.
    - Adding memory to your device 
    ```

   :::image type="content" source="media/memory-usage-32-bit-edition-of-excel/error-message.png" alt-text="Screenshot of the error message, showing there isn't enough memory to complete this action." border="false":::
  
## Cause

Although improvements in Office 2013/2016 did not significantly affect system requirements, Office 2013/2016 does use more available system resources than Office 2010 did. The limit of virtual address space for 32-bit editions of Windows-based applications is 2 gigabytes (GB). For Excel, this space is shared by the Excel application itself together with any add-ins that run in the same process. The size of the worksheet itself also affects the usage of virtual address space. Because Excel loads the worksheet into addressable memory, some worksheets that have a file size of less than 2 GB may still require Excel to use more than 2 GB of addressable memory. This situation results in the error message that is mentioned in the "Symptoms" section.

## Resolution

Excel expert users who work with complex Excel worksheets can benefit from using the 64-bit edition of Office 2013/2016. This is because the 64-bit edition of Office does not impose hard limits on file size. Instead, workbook size is limited only by available memory and system resources. On the other hand, the 32-bit edition of Office is limited to 2 GB of virtual address space, and this space is shared by Excel, the workbook, and add-ins that run in the same process. (Worksheets smaller than 2 GB on disk might still contain enough data to occupy 2 GB or more of addressable memory.)

The following options can help improve performance in Excel 2013/2016:

- Excel users who regularly work with large, complex Excel worksheets may benefit from using the 64-bit edition of Office 2013 because 64-bit editions of Windows-based applications can address up to 8 terabytes (TB) of memory. Learn more about [64-bit editions of Office 2013](https://technet.microsoft.com/library/ee681792.aspx).
- The 2-GB limitation is per windows process instance of Excel. You can run multiple files in one instance. However, if the files are really large and have to be open, consider opening multiple instances for the other files. For information about limits that you may encounter, see [You cannot paste any attributes into a workbook in another instance of Excel](cannot-paste-attributes.md).
- If you are running Windows 7 or Windows 2008, we suggest that you install [Platform update for Windows 7 SP1 and Windows Server 2008 R2 SP1](https://support.microsoft.com/help/2670838).
- Test performance without COM add-ins. COM add-ins can use memory at the expense of the 2-GB limitation. For testing, disable COM add-ins, and then start Excel. If COM add-ins are causing the memory issue, contact your third-party vendor for an updated copy or a 64-bit version of the COM add-ins.
- Disable hardware graphics acceleration. This shuts off animations. To do this, on the **File** menu, click **Options**, click **Advanced**, click **Display**, and then select **Disable hardware graphics acceleration**.
- Change your workbook to streamline areas that use memory unnecessarily. For suggested changes, see [How to clean up an Excel 2013 workbook so that it uses less memory](clean-workbook-less-memory.md).

> [!NOTE]
> 32-bit Excel 2016 will be enabled for Large Address Aware with update May 4, 2016 build number 16.0.6868.2060 for the O365 Current Channel subscribers. For more information, see [Large Address Aware capability change for Excel](laa-capability-change.md).

## More Information

You can use [Process Explorer](/sysinternals/downloads/process-explorer) to check whether you are approaching the 2-GB limit in Excel. Consider anything over 1.75 GB as a maximum for the 32-bit edition of Excel. The column to focus is not there by default and can be added by Choosing View> Select Columns> Process Memory tab and clicking on Virtual Size.

Before moving to a 64-bit version of Office, see [64-bit editions of Office 2013](/previous-versions/office/office-2013-resource-kit/ee681792(v=office.15)).

[How to troubleshoot "available resources" errors in Excel](available-resources-errors.md)
