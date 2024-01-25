---
title: Database garbage collection process
description: Describes the Active Directory database garbage collection process and calculation of allowed intervals.
ms.date: 12/16/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-database-issues-and-domain-controller-boot-failures, csstroubleshoot
ms.subservice: active-directory
---
# The Active Directory database garbage collection process and calculation of allowed intervals

This article describes the Active Directory database garbage collection process and calculation of allowed intervals.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 198793

## Summary

The Active Directory database incorporates a garbage collection process that runs independently on each domain controller in the enterprise.

## More information

Garbage collection is a housekeeping process that is designed to free space within the Active Directory database. This process runs on every domain controller in the enterprise with a default lifetime interval of 12 hours. You can change this interval by modifying the garbageCollPeriod attribute in the enterprise-wide DS configuration object (NTDS).

The path of the object in the `Contoso.com` domain would resemble the following:  
CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=CONTOSO,DC=COM

Use an Active Directory editing tool to set the garbageCollPeriod attribute. Supported tools include Adsiedit.msc, Ldp.exe, and Active Directory Service Interfaces (ADSI) scripts.

When an object is deleted, it is not removed from the Active Directory database. Instead, the object is instead marked for deletion at a later date. This mark is then replicated to other domain controllers. Therefore, the garbage collection process starts by removing the remains of previously deleted objects from the database. These objects are known as *tombstones*. Next, the garbage collection process deletes unnecessary log files. Finally, the process starts a defragmentation thread to claim additional free space.

In addition, there are two methods to defragment the Active Directory database. One method is an online defragmentation operation that runs as part of the garbage collection process. The advantage of this method is that the server does not have to be taken offline for the operation to run. However, this method does not reduce the size of the Active Directory database file (Ntds.dit). The other method takes the server offline and defragments the database by using the Ntdsutil.exe utility. This approach requires that the database to start in repair mode. The advantage of this method is that the database is resized and unused space is removed. Therefore, and the size of the Ntds.dit file is reduced. To use this method, the domain controller must be taken offline.

Limits for garbageCollPeriod:  
The minimum value is 1, and the maximum is 168 for one week. The default for the value is 12 hours.

Minimum for Tombstone Lifetime:  
The minimum for Tombstone Lifetime is 2 days for the purposes of the KCC stay of execution calculation.

The AD database layer enforces an additional metric. TSL days must not be smaller than three times the garbage collector interval. Based on the Default of 12 hours, TSL is a minimum of 2 days. If GC interval is 20 hours, the TSL minimum is 3 days (must be bigger than 60 hours). If the GC interval is 25 hours, you get beyond three days (with 75 hours) and the TSL minimum is 4 days.

The catch with the checks both DB layer and KCC perform is that if TSL is lower than the allowed minimum, it does not revert to the minimum value of 2 or more days, but to the default of 60 or 180 days.

> [!IMPORTANT]
> In case TSL is corrected to the default because of a mismatch, the value for the garbage collection interval is also set to the default of 12 hours.

### Tombstone lifetime defaults  

### History  

The default tombstone lifetime (TSL) in Windows Server 2003 was 60 days and was proven to be too short. For example, a prestaged domain controller may be in transit for longer than 60 days. An administrator may not resolve a replication failure or bring an offline domain controller into operation until the TSL is exceeded. Windows Server 2003 Service Pack 1 (SP1) increased the TSL from 60 to 180 days in the following scenarios:  

- A Windows NT 4.0 domain controller is upgraded to Windows Server 2003 by using Windows Server 2003 SP1 installation media to create a new forest.  
- A Windows Server 2003 SP1 computer creates a new forest.  

Windows Server 2003 SP1 does not modify the value of TSL when either of the following conditions is true:  

- A Windows 2000 domain is upgraded to Windows Server 2003 by using installation media for Windows Server 2003 with SP1.  
- Windows Server 2003 SP1 is installed on a domain controller that is running the original release version of Windows Server 2003.  

Increasing the TSL for a domain to 180 days has the following benefits:  

- Backups that are used in data recovery scenarios have a longer useful life.  
- System state backups that are used for installation from media promotions have a longer useful life.  
- Domain controllers can be offline longer. Prestaged computers approach TSL expiration less frequently.  
- A domain controller can successfully return to the domain after a longer time offline.  
- Knowledge of deleted objects is retained longer on the originating domain controller.  

The default setting in your forest will depend on the OS at the 'birth' of the forest and the upgrade methods from there as above.  

If you are unsure about the value of TSL used in your forest, we recommend to explicitly set it, and also msDS-deletedObjectLifetime as needed.  
Reference: [The AD Recycle Bin: Understanding, Implementing, Best Practices, and Troubleshooting](https://techcommunity.microsoft.com/t5/Ask-the-Directory-Services-Team/The-AD-Recycle-Bin-Understanding-Implementing-Best-Practices-and/ba-p/396944)  
