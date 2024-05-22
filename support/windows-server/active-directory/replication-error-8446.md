---
title: Troubleshoot AD replication error 8446
description: Describes the symptoms, cause, and resolution steps for issues when Active Directory replication fails with error 8446.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, raviks, justintu
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# Troubleshooting AD Replication error 8446: The replication operation failed to allocate memory

This article describes the symptoms, cause, and resolution steps for issues when Active Directory replication fails with error 8446.

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com).

_Applies to:_ &nbsp; Windows Server (All supported versions)  
_Original KB number:_ &nbsp; 2693500

## Symptoms

This article describes the symptoms, cause, and resolution steps for issues when Active Directory replication fails with error 8446: "The replication operation failed to allocate memory".

1. REPADMIN.exe reports that replication attempt has failed with error "8446" - The Replication operation failed to allocate memory  

    > DC=Contoso,DC=com  
        Default-First-Site-Name\\DomainController via RPC  
            DC object GUID: \<source DCs ntds settings object object guid>  
            Last attempt @ \<Date Time> failed, result 8446 (0x20fe):  
                The replication operation failed to allocate memory.  
            1359 consecutive failure(s).  
            Last success @ \<Date & Time>.  
    >
    > CN=Configuration,DC=Contoso,DC=com  
        Default-First-Site-Name\\DomainController via RPC  
            DC object GUID: \<source DCs ntds settings object object guid>  
            Last attempt @ \<Date Time> failed, result 8446 (0x20fe):  
                The replication operation failed to allocate memory.  
            1358 consecutive failure(s).  
            Last success @ \<Date & Time>.  
    >
    > Source: Default-First-Site-Name\\DomainController  
    ******* 1359 CONSECUTIVE FAILURES since \<Date Time>  
    >
    > Last error: 8446 (0x20fe):  
      The replication operation failed to allocate memory.  

2. DCPROMO fails with error 1130
  
    > 06/05 09:55:33 [INFO] Error - Active Directory could not replicate the directory partition CN=Configuration,DC=contoso,DC=com from the remote domain controller 5thWardDC1.contoso.com. (1130)  
    06/05 09:55:33 [INFO] NtdsInstall for domain.net returned 1130  
    06/05 09:55:33 [INFO] DsRolepInstallDs returned 1130  
    06/05 09:55:33 [ERROR] Failed to install to Directory Service (1130)  
    Non critical replication returned 1130  
    err.exe 1130  
    ERROR_NOT_ENOUGH_SERVER_MEMORY / Not enough server storage is available to process this command.

3. NTDS Replication, NTDS General Events with the 8466 status are logged in the directory service event log.  

    | **Event Source**| **Event ID**| **Event String** |
    |---|---|---|
    | NTDS Replication| 1699| The local domain controller failed to retrieve the changes requested for the following directory partition. As a result, it was unable to send the change requests to the domain controller at the following network address. 8446 The replication operation failed to allocate memory |
    | NTDS General| 1079| Active Directory could not allocate enough memory to process replication tasks. Replication might be affected until more memory is available Increase the amount of physical memory or virtual memory and restart this domain controller |

4. When you try to manually initiate replication using Repadmin or Active Directory Sites and Services, you get the following error message:

    > The following error occurred during the attempt to synchronize naming context `Contoso.com` from domain controller \<Source DC > to domain controller \<Destination DC>:  
    The replication Operation failed to allocate memory. This operation will not continue.  

5. The domain controller may become unresponsive and a reboot will provide a temporary workaround.  

## Cause

The 8446 (operation failed to allocate memory. This operation will not continue) status can occur when the Active Directory replication engine cannot allocate memory to perform Active directory replication.

### These events can occur due to the following conditions

- Low available physical memory
- Low available paging file size versus physical memory (Wrong configuration of paging file): Paging file should be 1.5 times the size of physical memory
- Paged Pool or Non-Paged pool exhaustion in the kernel  
- The Virtual Memory depletion could be a leak inside the LSASS User mode Process, or the Database Cache (ESE Cache) may be consuming all the available memory.  

### The following information is important to understand

Lsass.exe memory usage on domain controllers has two major components: one fixed and one variable.

The fixed component is made up of the code, the stacks, the heaps, and various fixed size data structures (for example, the schema cache). The amount of memory that LSASS uses may vary, depending on the load on the computer. As the number of running threads increases, so does the number of memory stacks. Lsass.exe usually uses 100 MB to 300 MB of memory. Lsass.exe uses the same amount of memory no matter how much RAM is installed in the computer.

The variable component is the database buffer cache. The size of the cache can range from less than 1 MB to the size of the entire database. Because a larger cache improves performance, the database engine for AD (ESENT) attempts to keep the cache as large as possible. While the size of the cache varies with memory pressure in the computer, the maximum size of the cache is limited by both the amount of physical RAM installed in the computer and by the amount of available virtual address space (VA). AD uses only a portion of total VA space for the cache.

## Resolution

Determine if there is depletion of following resources and fix the underlying cause:

- Physical RAM
- Paging File
- Paged Pool or Non-Paged Pool Depletion

### Domain Controller Scalability

If there is no apparent memory leak or resource depletion:

For 32-bit operating systems, depending on the size of the NTDS.DIT, the /USERVA boot.ini switch that increases the virtual mode address space on domain controllers may provide relief, but this might cause kernel mode depletion as this reduces the size of the kernel mode address space. Prior to implementing the /UserVA switch, it is best to consult with a Windows memory performance tuning expert for an analysis of kernel mode and user mode memory usage.
Database cache consumes all available virtual memory for the LSASS process.  
Run Performance Monitor with database counters, review the following counters:

- LSASS - Working Set
- LSASS - Virtual Bytes
- Database - "Database Cache Size"

### LSASS ESE Database cache is not limited by default

If you determine it is the database cache that is consuming memory using performance monitor, you can add the following registry value to limit the database cache.

You can use the "EDB max buffers" registry value for limiting ESE cache allocation (number of pages is 8912 bytes) to prevent the conditions.

**Value Name:** EDB max buffers  
**Type:** reg_dword  
**Setting:** \<refer to the values below>  
**Registry key:** `HKLM\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`  

> [!CAUTION]
> Ensure that you set an optimal value to the registry value (EDB max buffers), if the cache limit is too low then it might cause performance degradation.
You may apply the following values as start for an optimization, depending is the /3GB boot.ini switch is use or not:
>
> Without /3GB switch: "EDB max buffers", Reg_DWord: 157286 (1.2 GB); expected LSASS consumption ~1.5 GB With /3GB switch: "EDB max buffers", Reg_DWord: 235929 (1.8 GB); expected LSASS consumption ~2.1 GB

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
