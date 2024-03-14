---
title: Large Address Aware capability change for Excel
description: Describes the added Large Address Aware functionality for Excel 2013, which lets Windows allocate increased RAM to the Excel. This capability was added by the May and June updates in 2016.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: lauraho, ammert
search.appverid: 
  - MET150
appliesto: 
  - Excel for Microsoft 365
  - Excel 2016
  - Excel 2013
ms.date: 03/31/2022
---

# Large Address Aware capability change for Excel

## Summary

32-bit versions of Microsoft Excel 2013 and Excel 2016 can take advantage of Large Address Aware (LAA) functionality after installation of the latest updates. (see the "Resolution" section) This change lets 32-bit installations of Excel 2016 consume double the memory when users work on a 64-bit Windows OS. The system provides this capability by increasing the user mode virtual memory from 2 gigabytes (GB) to 4 GB. This change provides 50 percent more memory (for example, from 2 GB to 3 GB) when users work on a 32-bit system. 

This change may minimize the frequency of the errors that are described in the following error messages when memory is constrained for 32-bit Excel installations:

```output
Excel cannot complete this task with available resources. Choose less data or close other applications.

Out of Memory

Not enough System Resources to Display Completely 

There isn't enough memory to complete this action. Try using less data or closing other applications. To increase memory availability, consider: 
* Using a 64-bit version of Microsoft Excel.
* Adding memory to your device.
```

## Resolution

To enable this change, you must be running the latest version of Microsoft Office.

## More Information

In the Windows 32-bit architecture, the address space for any program is shared between the application (user mode memory) and the operating system (system or kernel memory). For a 32-bit process, the total amount of addressable memory is 4 GB. By default, this memory is evenly divided between the process and the system. To support programs that may require more memory, Windows supports the LAA memory layout. This functionality is used only if the program can support it and identify itself as providing this support. LAA lets the system allocate more process memory at the expense of keeping less memory for itself. 

The current design change to 32-bit Excel makes it LAA-supportable and identifies it to Windows as an LAA program. The maximum amount of memory that Windows can provide to the program depends on the system bitness. 32-bit Windows systems can allocate no more than 3 GB for user mode memory. This shrinks available system memory to 1 GB. (A 32-bit system cannot exceed 4 GB total RAM). On 64-bit Windows systems, the addressable memory space for the system is much larger, and the system memory can be located outside the 4-GB limit. Therefore, the maximum available user memory for a 32-bit process that's running on a 64-bit system is the full 4-GB addressable range. 

This change applies only to 32-bit programs. Therefore, it affects only 32-bit versions of Excel. If you're running a 64-bit version of Excel, this change has no effect.

### 64-bit operating system and 32-bit Office

If you're running 64-bit Windows, this change is applied automatically. No action by you is required. The available memory for the Excel process is automatically doubled from 2 GB to 4 GB. This improves support for actions that use lots of memory. 

### 32-bit operating system and 32-bit Office

If you're running 32-bit Windows, this change cannot be applied automatically because it requires you to change the mode in which the operating system runs. More specifically, to take advantage of LAA on 32-bit Windows, you must enable the /3GB boot switch and then restart the system. For more information about this switch, see [Available switch options for the Windows XP and the Windows Server 2003 Boot.ini files](https://msdn.microsoft.com/library/windows/hardware/ff556232%28v=vs.85%29.aspx).

> [!NOTE]
> - This manual change can be reversed by removing the /3GB boot switch.   
> - By setting this switch, you reduce system memory resources to 1 GB. This may cause limitations in capabilities such as the number of programs that can be run at the same time and the number of windows (for all programs) that can be opened at the same time. Every system resource consumes some system memory. Therefore, although the /3GB switch expands memory for program resources, it reduces the memory that's available for system resources. Be aware of this tradeoff because it may trigger errors in other programs, not necessarily in the LAA program itself. 64-bit Windows systems do not have this limitation because system resources can be held outside the 32-bit addressable range.    
> - Also included in this update is ability to open Excel in its own instance by default. For more information, see [How to force Excel to open in a new instance by default](https://support.microsoft.com/help/3165211).   

### FAQ

Can the LAA update be applied to Excel 2013?

LAA applies to Excel 2016 Click-to-Run, Excel 2013 MSI, and Excel 2016 MSI versions. 

Can the LAA update be applied to the Excel 2016 MSI version?

Yes, Excel 2016 MSI can be applied after you install the [June 7, 2016, update for Excel 2016](https://support.microsoft.com/help/3115139).

Can I add more RAM to my computer to force LAA to exceed the standard limit (2 GB for 32-bit OS, 4 GB for 64-bit OS)?

Adding more RAM does not affect the maximum addressable memory for LAA programs. If your programs require more memory than the LAA maximums, you may want to move to a 64-bit system and a 64-bit version of Excel.

Will add-ins be affected by LAA?

Any code program can be affected by this change in subtle ways. Therefore, you will want to test add-ins to make sure that they work correctly. There should be no hard break of compatibility for any functionality. Therefore, correctly written add-ins should gain as much benefit from the change as does the host application itself. However, if the add-in was never tested in LAA, any existing code bugs may now be exposed to the user for the first time.

Will this change fix out-of-memory-resource errors in workbooks?

Many factors can cause out-of-memory errors in workbooks. LAA can help reduce memory pressure but does not solve every memory problem. Sometimes, one of the following actions may be required:

- Review the workbook to determine whether the file requires changes. For information about how to do this, see [How to clean up an Excel workbook so that it uses less memory.](https://support.microsoft.com/help/3070372)   
- Users may have to move to a 64-bit version of the system and a 64-bit version of Excel. For more information, see [64-bit editions of Office 2013](https://technet.microsoft.com/library/ee681792.aspx).   

### Additional content

- [Memory usage in the 32-bit edition of Excel 2013 and 2016](https://support.microsoft.com/help/3066990)
- [How to troubleshoot crashing and not responding issues with Excel](https://support.microsoft.com/help/2758592)
- [Excel not responding, hangs, freezes or stops working](https://support.microsoft.com/help/2735548)