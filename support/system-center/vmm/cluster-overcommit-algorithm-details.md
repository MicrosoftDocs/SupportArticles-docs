---
title: Cluster overcommit algorithm approaches
description: Describes the slot-simple, slot-full, proof-simple, and proof-full approaches for the cluster overcommit algorithm in System Center 2012 R2 Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, hilange
---
# Details of the cluster overcommit algorithm in System Center 2012 R2 Virtual Machine Manager

This article describes four approaches for the cluster overcommit algorithm in Microsoft System Center 2012 R2 Virtual Machine Manager (VMM 2012 R2). You can [find an example here](#example-for-these-approaches) to help you understand the algorithm.  

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 3023928

## Overview of the approaches in the algorithm

The goal of the VMM 2012 R2 cluster overcommit check is to determine whether virtual machines will not be restarted if there is a concurrent failure of cluster reserve (_R_) nodes. The cluster is assumed to be overcommitted until proven otherwise. Four approaches are tried, and if any approach shows that the cluster is not overcommitted, the cluster state is set to **OK**. Otherwise, the cluster state is set to **Overcommitted**.

The four approaches can be visualized in a table as follows:

|Check methods|Proof method|Slot method|
|---|---|---|
|Simple check|Proof-simple|Slot-simple|
|Full complexity check|Proof-full|Slot-full|
  
### The four check methods

#### Proof method

The proof method works by determining whether there are enough virtual machines to fill all the hosts to a point where the largest virtual machine cannot start on any of the hosts. It considers the worst case in which the largest virtual machine is the last to be failed over and also the worst case in which every host has 1 byte of insufficient memory to start the virtual machine.

#### Slot method

The slot method works by assigning each virtual machine on a failed host to a single, standard-size slot whose size is equal to the size of the largest virtual machine on all failed hosts. It then counts the number of available slots on each remaining host and checks that there are enough free slots to assign all virtual machines currently on failed hosts.

#### Simple check

The simple check does not consider a specific set of failed hosts. Instead, it makes worst-case cluster-wide assumptions. The largest virtual machine size is used as the largest virtual machine in the whole cluster. The failing-over virtual machine sizes are not decided from a specific set of hosts. Instead the approach uses the theoretical highest sum that can be achieved from _R_ failing hosts. Similarly, the number of memory or slots that are available on other hosts is the sum across the lowest _N_-_R_ hosts (where _N_ represents the cluster size).

#### Full complexity check

The full complexity check iterates over every possible set of _R_ failing hosts. It recalculates the slot size, the largest virtual machine size, the target host memory sizes, and the slot count. It does this based on each possible combination of failing hosts. The number of sets that has to be considered is **Choose(N,R)**. This number can become prohibitively low for large values of _N_ and _R_. Because this number is approximately proportional to **N^R**, this check is run only if **N^R** is less than 5,000. Therefore, in practical terms, the full complexity check is performed only in the situations according to the following table:

|Cluster reserve (_R_)|Maximum cluster size (_N_)|
|---|---|
|1|4,999|
|2|70|
|3|17|
|4|8|

> [!NOTE]
> The full complexity check is only a marginal refinement over the simple check, and the simple proof check offers very similar results.

## Calculations and algorithms

### Value definitions and precalculations in the algorithm

> [!IMPORTANT]
> The `AdditionalMemory` and `AvailableSlots` values cannot be calculated by using the values from a single host. The value of `LargestClusterVM` or `SlotSize` from the source failing hosts must be known. In a simple check, they are equal to the largest virtual machine in the cluster. In a full complexity check, they are equal to the largest high availability (HA) virtual machine in the set of failing hosts. Some hosts will fail, and other hosts will receive that workload. The calculations of available space are incorrect unless they were completed for the failing hosts and not the receiving host.

#### Cluster values

The follow table shows the definitions of cluster values:

|Value name|Definition|
|---|---|
|_N_|The total number of hosts in the cluster|
|_R_|The cluster reserve value (that is, the maximum number of concurrent failures to model)|
|_H_|The remaining healthy hosts to be used as targets for failover (_H_ = _N_ - _R_)|

#### Host values

The following values are precalculated for each host. When a value is calculated for the  `LargestClusterVMMB` or `SlotSizeMB`, it is recalculated in each iteration of full complexity checks.

|Value name|Definition|
|---|---|
|`AvailableMemory`|This is the total usable host memory for failed-over virtual machines to use.<br/>`AvailableMemory` = Host total memory - existing VMs - host reserve|
|`AdditionalMemory`|This is the fill line after which a host will no longer be able to start the largest virtual machine that is failing over.<br/>`AdditionalMemory` = Max(`AvailableMemory` - `LargestClusterVM`,0)|
|`HAVMs`|This is the total of high availability (HA) virtual machines on this host.|
|`AvailableSlots`|This is the number of failing over virtual machines that this host is guaranteed to be able to start.<br/>`AvailableSlots` = `AvailableMemory` / `SlotSize`, rounded down|
|`UsedSlots`|This is the number of HA virtual machines on this host.|
|`TotalSlots`|Total number of slots on a host.<br/>`TotalSlots` = `AvailableSlots` + `UsedSlots`|

> [!NOTE]
>
> - A 64 megabyte (MB) buffer is added to each virtual machine's memory to account for hypervisor overhead.
> - Stopped, saved state, paused, and running virtual machines (VMs) are all counted. A tenant user who is starting a stopped virtual machine should be accounted for when the algorithm calculates overcommits.
> - If dynamic memory virtual machines are present in the cluster, their current memory demand is used.

### Algorithms in the four approaches

#### Slot-simple

The algorithms in the slot-simple approach are as follows:

- `SlotSize` = largest HA virtual machine in the cluster.
- Calculate the `AvailableSlots`, `UsedSlots`, and `TotalSlots` values for each host.
- `TotalSlotsRemaining` = sum of the smallest _H_ values of `TotalSlots`.
- If Sum(`UsedSlots`) <= `TotalSlotsRemaining`, cluster is not overcommitted.

#### Slot-full

Iterated over each set of _R_ failing hosts. The algorithms in the slot-full approach are as follows:

- `SlotSize` = largest HA virtual machines on the _R_ failing hosts.
- Calculate the `AvailableSlots`, `UsedSlots`, and `TotalSlots` values for each host.
- `TotalSlotsRemaining` = sum of `TotalSlots` on all non-failing hosts.
- Compare the Sum(`UsedSlots`) and `TotalSlotsRemaining` values:
  - If Sum(`UsedSlots`) > `TotalSlotsRemaining`, cluster may be overcommitted.
  - If Sum(`UsedSlots`) <= `TotalSlotsRemaining` for every set of failing hosts, cluster is not overcommitted.

#### Proof-simple

The algorithms in the proof-simple approach are as follows:

- `LargestClusterVM` = largest HA virtual machine in the cluster.
- Calculate `AdditionalMemory`, `HAVMs` for all hosts.
- `TotalAdditionalSpace` = sum of smallest _H_ values of `AdditionalMemory`.
- `TotalOrphanedVMs` = (sum of largest _R_ values of `HAVMs`) - `LargestClusterVM`.
- Compare the values:
  - If `TotalOrphanedVMs` <= `TotalAdditionalSpace`, cluster is not overcommitted.
  - If `TotalOrphanedVMs` is **0**, `LargestClusterVM` > **0** and `TotalAdditionalSpace` = **0**, cluster may be overcommitted.

#### Proof-full

Iterated over each set of _R_ failing hosts. The algorithms in the proof-full approach are as follows:

- `LargestClusterVM` = largest HA virtual machine on the _R_ failing hosts.
- Calculate `AdditionalMemory`, `HAVMs` for all hosts.
- `TotalAdditionalSpace` = sum of `AdditionalMemory` on non-failing hosts.
- `TotalOrphanedVMs` = (sum of `HAVMsMB` on the _R_ failing hosts) - `LargestClusterVM`.
- Compare the values:
  - If `TotalOrphanedVMs` > `TotalAdditionalSpace`, cluster may be overcommitted.
  - If `TotalOrphanedVMs` = **0**, `LargestClusterVM` > **0** and `TotalAdditionalSpaceMB` = **0**, cluster may be overcommitted.
  - If `TotalOrphanedVMs` < `TotalAdditionalSpace` for every set of failing hosts, cluster is not overcommitted.

## Combining the approaches and example

None of the methods show that the cluster is overcommitted. They can show only that the cluster is _not_ overcommitted. If none of the methods that are used can show that the cluster is not overcommitted, the cluster is flagged as overcommitted. If even a single method shows that the cluster is not overcommitted, the cluster is flagged as **OK**, and calculation is stopped immediately.

However, for the full complexity analysis, if even a single set of _R_ failing hosts shows that the cluster may be overcommitted, the method is immediately completed and does not flag the cluster as **OK**.  

### Example for these approaches

This example is designed specifically to be a borderline case. Only one method (proof-full) manages to show that the cluster is not overcommitted.

Assume that a cluster has four 32 gigabyte (GB) hosts. Host memory reserve is set to 9 GB. A 64-MB buffer is not added to virtual machine sizes in this example just to keep the numbers simpler. Cluster reserve (_R_) is set to **2**.

|Host|Virtual machine settings|AvailableMemory|HAVMs|Largest VM|
|---|---|---|---|---|
|Host A|4 GB HA, 4 GB HA|15 GB|8 GB|4 GB|
|Host B|4 GB HA, 4 GB HA|15 GB|8 GB|4 GB|
|Host C|8 GB HA, 8 GB non-HA|7 GB|8 GB|8 GB|
|Host D|6 GB non-HA, 2 GB HA, 2 GB HA|13 GB|4 GB|2 GB|

#### Slot-simple example

Slot size = 8 GB

|Host|AvailableSlots|UsedSlots|TotalSlots|
|---|---|---|---|
|Host A|1|2|3|
|Host B|1|2|3|
|Host C|0|1|1|
|Host D|1|2|3|

From the table, we know the following values:

- `TotalSlotsRemaining` = two smallest values of `TotalSlots` = (1+3) = 4
- `TotalUsedSlots` = 2+2+2+1 = 7

Because `TotalUsedSlots` is larger than `TotalSlotsRemaining`, the approach failed.

#### Slot-full example

`TotalUsedSlots` = 7, regardless of which hosts fail

|Failing hosts|Slot size|AvailableSlots on remaining hosts|TotalSlots on remaining hosts|
|---|---|---|---|
|A, B|4 GB|C: 1, D: 3|C: 2, D: 5. Total: 7 - Good|
|A, C|8 GB|B: 1, D: 1|B: 3, D: 3. Total: 6 - Failed|
|A, D|4 GB|B: 3, C: 1|B: 5, C: 2. Total: 7 - Good|
|B, C|8 GB|A: 1, D: 1|A: 3, D: 3. Total: 6 - Failed|
|B, D|4 GB|A: 3, C: 1|A: 5, C: 2. Total: 7 - Good|
|C, D|8 GB|A: 1, B: 1|A: 3, B: 3. Total: 6 - Failed|

As some sets of failing hosts led to `TotalUsedSlots` > `TotalSlotsRemaining`, the approach has failed.

#### Proof-simple example

`LargestClusterVM` = 8 GB

|Host|AdditionalMemory|
|---|---|
|Host A|7 GB|
|Host B|7 GB|
|Host C|0 GB|
|Host D|5 GB|

From the table, we know the following values:

- `TotalAdditionalSpace` = two smallest values of `AdditionalMemory` = 0 GB + 5 GB = 5 GB.
- `TotalOrphanedVMs` = (8 GB + 8 GB) - 8 GB = 8 GB.

Because `TotalOrpanedVMsMB` > `TotalAdditionalSpace`, the approach has failed.

#### Proof-full example

|Failing hosts|LargestHAVM|AdditionalMemory|OrphanedVMs|OrphanedVMs - LargestHAVM <= AdditionalMemory|
|---|---|---|---|---|
|A, B|4 GB|C: 3, D: 9. Total 12.|A: 8, B: 8, Total 16.|16-4<=12 - Good|
|A, C|8 GB|B: 7, D: 5. Total 12.|A: 8, C: 8, Total 16.|16-8<=12 - Good|
|A, D|4 GB|B: 11, C: 3. Total 14.|A: 8, D: 4, Total 12.|12-4<=14 - Good|
|B, C|8 GB|A: 7, D: 5. Total 12.|B: 8, C: 8, Total 16.|16-8<=12 - Good|
|B, D|4 GB|A: 11, C: 3. Total 14.|B: 8, D: 4, Total 12.|12-4<=14 - Good|
|C, D|8 GB|A: 7, B: 7. Total 14.|C: 8, D: 4, Total 12.|12-8<=14 - Good|

Because every set of failing hosts led to `OrphanedVMs` - `LargestHAVM` <= `AdditionalMemory`, the approach succeeded, and the whole cluster can be marked as **OK**.
