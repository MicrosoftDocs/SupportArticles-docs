---
title: unable to allocate memory
description: Provides a resolution for the issue that it is unable to allocate memory from the system paged pool.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, mohak, weiwan
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# Unable to allocate memory from the system paged pool

This article provides a resolution for the issue that it is unable to allocate memory from the system paged pool.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 312362

## Symptoms

When your server is under a heavy load, the Server service may repeatedly log the following error in the System Event log. It indicates that the server is out of paged pool memory:  
>Source - SRV  
Type - Error  
Event ID - 2020  
Description -  
>
>The server was unable to allocate from the system paged pool because the pool was empty.  
Data -  
0000: 00040000 00540001 00000000 c00007e4  
0010: 00000000 c000009a 00000000 00000000  
0020: 00000000 00000000 0000000b  

## Cause

Several factors may deplete the supply of paged pool memory. Enabling pool tagging and taking `poolsnaps` at different time intervals may help you to understand which driver is consuming paged pool memory. If the `poolsnaps` indicate that the MmSt tag (Mm section object prototype PTEs) is the largest consumer and paged pool memory has been depleted or the system is logging error event 2020s, there is a large probability that there are a large number of files that are open on the server. By default, the Memory Manager tries to trim allocated paged pool memory when the system reaches 80 percent of the total paged pool. Depending on the system configuration, a possible maximum paged pool memory on a computer can be 343 MB and 80 percent of this number is 274 MB. If the Memory Manager is unable to trim fast enough to keep up with the demand, the event that is listed in the "Symptoms" section of this article may occur. By tuning the Memory Manager to start the trimming process earlier (for example, when it reaches 60 percent), it would be possible to keep up with the paged pool demand during sudden peak usage, and avoid running out of paged pool memory.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

The following tuning recommendation has been helpful in alleviating the problem:

1. Start Registry Editor (Regedt32.exe).
2. Locate and then click the following key in the registry:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management`  

3. On the **Edit** menu, click **Add Value**, and then add the following registry value:  
    Value name: PoolUsageMaximum  
    Data type: REG_DWORD  
    Radix: Decimal  
    Value data: 60  

    Setting the value at 60 informs the Memory Manager to start the trimming process at 60 percent of PagedPoolMax rather than the default setting of 80 percent. If a threshold of 60 percent isn't enough to handle spikes in activity, reduce this setting to 50 percent or 40 percent.  

    Value name: PagedPoolSize  
    Data type: REG_DWORD  
    Radix: Hex  
    Value data: 0xFFFFFFFF  

    Setting PagedPoolSize to 0xFFFFFFFF allocates the maximum paged pool in lieu of other resources to the computer.

    > [!CAUTION]
    > The 0xFFFFFFFF PagedPoolSize setting is not recommended for use on 32-bit Windows Server 2003-based computers that have 64GB of RAM. This will potentially bring the Free System PTE entry down and can cause continuous reboot of the computer. For this configuration, carefully choose a value based on the requirements and available resources.  

4. Quit Registry Editor.
5. Restart the server for the changes to take effect.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the "Applies to" section.
