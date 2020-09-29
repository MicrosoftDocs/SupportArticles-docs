---
title: Number of physical processors is incorrect
description: Provides a solution to an issue where the number of Physical Processors (packages) is reported incorrectly.
ms.date: 09/16/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, arichard
ms.prod-support-area-path: Performance monitoring tools
ms.technology: Performance
---
# The number of physical processors is incorrectly reported in Windows Server 2008 x86 when MCM-based CPUs are used

This article provides a solution to an issue where the number of Physical Processors (packages) is reported incorrectly.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2711085

## Symptoms

Consider a system that has four CPU sockets. When all four sockets are populated, the number of Physical Processors (packages) is reported as 4. Now, remove two physical processors.

- On Windows Server 2008 x86, the number of packages is reported as 2 for some CPU models, but 4 for other CPU models (MCM-based CPUs).
- On Windows Server 2008 x64, the number of packages is reported as 2 for all CPU models.
- On Windows Server 2008 IA64, the number of packages is reported as 2 for all CPU models.

The number of packages can be viewed using a variety of tools. The [GetLogicalProcessorInformation function](/windows/win32/api/sysinfoapi/nf-sysinfoapi-getlogicalprocessorinformation) can be used to retrieve this information programmatically.

- MSInfo32 reports the Physical Packages as 'Processor' entries in the System Summary table.
- Sysinternals CoreInfo ([https://technet.microsoft.com/sysinternals/cc835722](https://technet.microsoft.com/sysinternals/cc835722)) reports the Physical Packages via the "Logical Processor to Socket Map" section:

    ```powershell
    C:\Tools>Coreinfo.exe

    Coreinfo v3.05 - Dump information on system CPU and memory topology
    Copyright (C) 2008-2012 Mark Russinovich
    Sysinternals - www.sysinternals.com

    Logical to Physical Processor Map:
    *----------------------- Physical Processor 0
    -*---------------------- Physical Processor 1
    --*--------------------- Physical Processor 2
    ---*-------------------- Physical Processor 3
    ----*------------------- Physical Processor 4
    -----*------------------ Physical Processor 5
    ------*----------------- Physical Processor 6
    -------*---------------- Physical Processor 7
    --------*--------------- Physical Processor 8
    ---------*-------------- Physical Processor 9
    ----------*------------- Physical Processor 10
    -----------*------------ Physical Processor 11
    ------------*----------- Physical Processor 12
    -------------*---------- Physical Processor 13
    --------------*--------- Physical Processor 14
    ---------------*-------- Physical Processor 15
    ----------------*------- Physical Processor 16
    -----------------*------ Physical Processor 17
    ------------------*----- Physical Processor 18
    -------------------*---- Physical Processor 19
    --------------------*--- Physical Processor 20
    ---------------------*-- Physical Processor 21
    ----------------------*- Physical Processor 22
    -----------------------* Physical Processor 23

    Logical Processor to Socket Map:
    *-*-*-*-*-*------------- Socket 0
    -*-*-*-*-*-*------------ Socket 1
    ------------*-*-*-*-*-*- Socket 2
    -------------*-*-*-*-*-* Socket 3

    Logical Processor to NUMA Node Map:
    *-*-*-*-*-*------------- NUMA Node 0
    ------------*-*-*-*-*-*- NUMA Node 1
    -*-*-*-*-*-*------------ NUMA Node 2
    -------------*-*-*-*-*-* NUMA Node 3

    Cross NUMA Node Access Costs (relative to same node access):
     00 01 02 03
    00: 3.6 3.9 3.7 3.9
    01: 4.5 4.6 4.6 4.6
    02: 1.5 1.2 1.0 1.0
    03: 3.6 3.4 2.7 2.6
    ...
    ```

- Using PowerShell and WMI, each instance of the `Win32_Processor` class is a Processor Package:

    ```powershell
    PS C:\> Get-WmiObject -class Win32_Processor | ft Name,DeviceID,NumberOfCores,NumberOfLogicalProcessors
    Name DeviceID NumberOfCores NumberOfLogicalProcessors
    ---- -------- ------------- -------------------------
    AMD Opteron(tm) Processor ... CPU0 6 6
    AMD Opteron(tm) Processor ... CPU1 6 6
    AMD Opteron(tm) Processor ... CPU2 6 6
    AMD Opteron(tm) Processor ... CPU3 6 6
    ```

## Cause

The kernel uses the System Resource Affinity Table (SRAT) to define the topology of the hardware. The SRAT defines the proximity of the logical cores to the NUMA nodes, and the proximity of RAM to the NUMA nodes. Each architecture of Windows Server 2008 has its own implementation of the SRAT interpretation. In the Windows Server 2008 x86 implementation, it's specified that a NUMA node has one or more physical packages in it. That is, a physical package can't span multiple NUMA nodes. This design matched the hardware capabilities of Windows Server 2008 x86 at launch.

Each logical processor within each package has a SRAT 'processor' record (Type = 0x00) that contains the NUMA proximity and APIC ID of the core.

The SRAT of a system can be viewed using the kernel debugger's `!srat`  command. Following is an abridged example of a system showing the header and the first two processors:

```powershell
11: kd> !srat
Retrieved srat address from HAL NUMA code
SRAT - HEADER - ffffffffffd0b010
  Signature:               SRAT
  Length:                  0x000002a0
  Revision:                0x02
  Checksum:                0x01
  OEMID:                   AMD
  OEMTableID:              F10
  OEMRevision:             0x00000001
  CreatorID:               AMD
  CreatorRev:              0x00000001
SRAT - BODY - ffffffffffd0b040
       Table Revision: 1
...
ENTRY:
 Type: 0x00
 Length: 0x10
 ProximityId: 0x00
 Processor:
  Enabled: TRUE
  APIC ID: 0x00
ENTRY:
 Type: 0x00
 Length: 0x10
 ProximityId: 0x00
 Processor:
  Enabled: TRUE
  APIC ID: 0x01
```

When all of the sockets are populated in a server, the SRAT will contain a processor record for each logical processor all assigned to the same proximity (NUMA node). Traditionally, when sockets are removed from the system, the processor entries of the removed packages are omitted from the SRAT. This is currently the case for Intel-based CPUs and non-MCM-based AMD CPUs.

When a Multi-chip module (MCM) based CPU (AMD is only known to make MCM-based CPU packages at this time) is present in a system with unpopulated sockets, the MCM CPU represents itself in the SRAT as multiple NUMA nodes. The MCM-based CPU spans the NUMA node that it (physically) populates, and a NUMA node that has an unpopulated socket. In this way, the memory controller within the MCM CPU will have separate cache affinity to the RAM associated with the two (or more) nodes spanned.

The reason that an MCM-based CPU can do this is that it physically contains separate pieces of silicon (dies) that contain cores and a memory controller. In the case of the AMD Opteron 6168 (12 core), there are two dies with six cores on each, and a shared piece of silicon for the memory controller. The cores are split over the NUMA nodes in alignment to their die locality. The SRAT reflects the configuration change by changing the ProximityId of the split off cores to the proximity of the vacant socket.

Windows Server 2008 x86 correctly assigns the logical cores to associate the associated NUMA node, but in doing so, no longer honors the APIC ID package mask due to the Package per NUMA node implementation assumption. Instead of honoring the package defined via the APIC ID (see next), the package processor mask is (implicitly) copied from the NUMA node processor mask, resulting in a package count that is equal to the NUMA node count.

The APIC ID standard defines a limit of 16 cores per package. Each package is defined by the formula "[APIC ID] & 0xF0 >> 8". For example, if there are two packages with four cores in each, the APIC ID numbering would be 0x00, 0x01, 0x02, 0x03, 0x10, 0x11, 0x12 and 0x13. The cores would map to two physical packages (0x 0 n and 0x one n) by virtue of the use of two package masks. Note, when an MCM-based CPU is present in a system with unpopulated sockets, the APIC ID does not change, only the proximity (ProximityID) changes.

## Hotfix information

A supported hotfix is available from Microsoft. For more information, please refer to the following Knowledge Base article:  
[Performance is slow on a multiprocessor computer that is running Windows Server 2008 or Windows Vista](https://support.microsoft.com/help/969468)

The hotfix resolves the performance issue described in the above article, as well as the physical processor package issue identified here.

## Sysinternals CoreInfo

Before you apply this hotfix, the Sysinternals CoreInfo reports 4 sockets and four NUMA nodes.

```powershell
C:\Tools>Coreinfo.exe

Coreinfo v3.05 - Dump information on system CPU and memory topology
Copyright (C) 2008-2012 Mark Russinovich
Sysinternals - www.sysinternals.com

Logical to Physical Processor Map:
*----------------------- Physical Processor 0
-*---------------------- Physical Processor 1
--*--------------------- Physical Processor 2
---*-------------------- Physical Processor 3
----*------------------- Physical Processor 4
-----*------------------ Physical Processor 5
------*----------------- Physical Processor 6
-------*---------------- Physical Processor 7
--------*--------------- Physical Processor 8
---------*-------------- Physical Processor 9
----------*------------- Physical Processor 10
-----------*------------ Physical Processor 11
------------*----------- Physical Processor 12
-------------*---------- Physical Processor 13
--------------*--------- Physical Processor 14
---------------*-------- Physical Processor 15
----------------*------- Physical Processor 16
-----------------*------ Physical Processor 17
------------------*----- Physical Processor 18
-------------------*---- Physical Processor 19
--------------------*--- Physical Processor 20
---------------------*-- Physical Processor 21
----------------------*- Physical Processor 22
-----------------------* Physical Processor 23

Logical Processor to Socket Map:
*-*-*-*-*-*------------- Socket 0
-*-*-*-*-*-*------------ Socket 1
------------*-*-*-*-*-*- Socket 2
-------------*-*-*-*-*-* Socket 3

Logical Processor to NUMA Node Map:
*-*-*-*-*-*------------- NUMA Node 0
------------*-*-*-*-*-*- NUMA Node 1
-*-*-*-*-*-*------------ NUMA Node 2
-------------*-*-*-*-*-* NUMA Node 3
...
```

After you apply this hotfix, the Sysinternals CoreInfo reports two sockets and four NUMA nodes.

```powershell
C:\Tools>Coreinfo.exe

Coreinfo v3.05 - Dump information on system CPU and memory topology
Copyright (C) 2008-2012 Mark Russinovich
Sysinternals - www.sysinternals.com

Logical to Physical Processor Map:
*----------------------- Physical Processor 0
-*---------------------- Physical Processor 1
--*--------------------- Physical Processor 2
---*-------------------- Physical Processor 3
----*------------------- Physical Processor 4
-----*------------------ Physical Processor 5
------*----------------- Physical Processor 6
-------*---------------- Physical Processor 7
--------*--------------- Physical Processor 8
---------*-------------- Physical Processor 9
----------*------------- Physical Processor 10
-----------*------------ Physical Processor 11
------------*----------- Physical Processor 12
-------------*---------- Physical Processor 13
--------------*--------- Physical Processor 14
---------------*-------- Physical Processor 15
----------------*------- Physical Processor 16
-----------------*------ Physical Processor 17
------------------*----- Physical Processor 18
-------------------*---- Physical Processor 19
--------------------*--- Physical Processor 20
---------------------*-- Physical Processor 21
----------------------*- Physical Processor 22
-----------------------* Physical Processor 23

Logical Processor to Socket Map:
*-*-*-*-*-*-*-*-*-*-*-*- Socket 0
-*-*-*-*-*-*-*-*-*-*-*-* Socket 1

Logical Processor to NUMA Node Map:
*-*-*-*-*-*------------- NUMA Node 0
------------*-*-*-*-*-*- NUMA Node 1
-*-*-*-*-*-*------------ NUMA Node 2
-------------*-*-*-*-*-* NUMA Node 3
...
```

## WMI - Win32_Processor

Before you apply this hotfix, the `Win32_Processor WMI` class exhibits the following behavior.

- The number of `Win32_Processor` instances that are returned is equal to the number of NUMA nodes that are available on the system. A single physical package may be spilt over multiple NUMA nodes, decreasing the number of cores in each NUMA node when compared to a system with fully populated sockets.
- The NumberOfCores  property returns the number of cores on the current instance, which may be less than what the package contains.
- The NumberOfLogicalProcessors  property returns the number of logical processors on the current instance, which may be less than what the package contains.

After you apply this hotfix, the `Win32_Processor WMI` class exhibits the following behavior.

- The number of Win32_Processor instances that are returned is equal to the number of physical processors (packages) that are available on the system.
- The NumberOfCores  property returns the number of cores on the current instance.
- The NumberOfLogicalProcessors property returns the number of logical processors on the current instance.

To determine whether MCM caused physical package splitting is occurring, compare the value of the NumberOfLogicalProcessors  property to the total core count of the processor (as indicated by the CPU vendor). Splitting is occurring if the value of the NumberOfLogicalProcessors  property doesn't match the vendor's count (it usually will be half the value expected).

> [!NOTE]
> The NumberOfLogicalProcessors property includes both physical cores and hyper-threaded cores. Use the NumberOfCores  property to count the number of physical cores (only) so the hyper-threaded configuration does not affect the count. To determine whether hyper-threading is enabled for the processor, compare the value of the NumberOfCores property to the value of the NumberOfLogicalProcessors  property. Hyper-threading is enabled if the value of the NumberOfCores property is less than the value of the NumberOfLogicalProcessors  property.

## Kernel Debugger

The kernel debugger can be used to view the SRAT data or the NUMA configuration via the `!srat`, `!numa` and `!numa_hal` commands. These commands work when live debugging and when using a kernel dump file.

The `!numa` and `!numa_hal` commands output the following when using a four socket system with two sockets populated with AMD Opteron 6168 (12 core) CPUs. Each package is split in to two dies associated with two NUMA nodes, with 6-cores on each die. The system runs with four NUMA nodes. If non-MCM CPUs were used, the NUMA count would be 2.

```powershell
11: kd> !numa
NUMA Summary:
------------
    Number of NUMA nodes : 4
    Number of Processors : 24
    MmAvailablePages     : 0x00FABB28
    KeActiveProcessors   : ************************-------- (00ffffff)

    NODE 0 (FFFFFFFF819435C0):
        ProcessorMask    : *-*-*-*-*-*--------------------- (00000555)
        Color            : 0x00000000
        MmShiftedColor   : 0x00000000
        Seed             : 0x00000002
        Zeroed Page Count: 0x00000000003BF4AD
        Free Page Count  : 0x000000000000CDA2

    NODE 1 (FFFFFFFFA8B2A550):
        ProcessorMask    : ------------*-*-*-*-*-*--------- (00555000)
        Color            : 0x00000001
        MmShiftedColor   : 0x00000008
        Seed             : 0x0000000C
        Zeroed Page Count: 0x00000000003EA164
        Free Page Count  : 0x0000000000009840

    NODE 2 (FFFFFFFF805EA550):
        ProcessorMask    : -*-*-*-*-*-*-------------------- (00000aaa)
        Color            : 0x00000002
        MmShiftedColor   : 0x00000010
        Seed             : 0x00000001
        Zeroed Page Count: 0x00000000003F4ABA
        Free Page Count  : 0x0000000000002053

    NODE 3 (FFFFFFFFA8B61550):
        ProcessorMask    : -------------*-*-*-*-*-*-------- (00aaa000)
        Color            : 0x00000003
        MmShiftedColor   : 0x00000018
        Seed             : 0x0000000D
        Zeroed Page Count: 0x00000000003DE670
        Free Page Count  : 0x0000000000004E05

11: kd> !numa_hal
HAL NUMA Summary
----------------
    Node Count      : 4
    Processor Count : 24

    Node   ProximityId
    ------------------
    0x00   0x00000000
    0x01   0x00000001
    0x02   0x00000002
    0x03   0x00000003

    Proc   Domain       APIC Id
    ---------------------------
    0x00   0x00000000   0x00000000
    0x01   0x00000000   0x00000001
    0x02   0x00000000   0x00000002
    0x03   0x00000000   0x00000003
    0x04   0x00000000   0x00000004
    0x05   0x00000000   0x00000005
    0x06   0x00000001   0x00000006
    0x07   0x00000001   0x00000007
    0x08   0x00000001   0x00000008
    0x09   0x00000001   0x00000009
    0x0A   0x00000001   0x0000000A
    0x0B   0x00000001   0x0000000B
    0x0C   0x00000002   0x00000010
    0x0D   0x00000002   0x00000011
    0x0E   0x00000002   0x00000012
    0x0F   0x00000002   0x00000013
    0x10   0x00000002   0x00000014
    0x11   0x00000002   0x00000015
    0x12   0x00000003   0x00000016
    0x13   0x00000003   0x00000017
    0x14   0x00000003   0x00000018
    0x15   0x00000003   0x00000019
    0x16   0x00000003   0x0000001A
    0x17   0x00000003   0x0000001B

    Domain      Range
    -----------------
    0x00000000  0x0000000000000000 -> 0x0000000480000000
    0x00000001  0x0000000480000000 -> 0x0000000880000000
    0x00000002  0x0000000880000000 -> 0x0000000C80000000
    0x00000003  0x0000000C80000000 -> 0xFFFFFFFFFFFFFFFF
```

After you apply this hotfix, the `!srat`, `!numa`, and `!numa_hal`  commands output the same content. The MCM packages still span two NUMA node each. There is no evidence that the package is reported correctly using these commands. If non-MCM CPUs were used, the NUMA count would be 2.
