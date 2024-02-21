---
title: Microsoft iSCSI Software Target 3.3 limits
description: Provides the supported and tested Microsoft iSCSI Software Target 3.3 limits.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:iscsi, csstroubleshoot
---
# Supported and tested Microsoft iSCSI Software Target 3.3 limits

This topic provides the supported and tested Microsoft iSCSI Software Target 3.3 limits.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2535811

## Summary

The following tables display the tested limits and the enforced limits where applicable. In addition, the following limits apply:

1. You should not use network adapter teaming with Microsoft iSCSI Software Target 3.3 for iSCSI communication.
2. If you plan to use multiple network adapters for iSCSI communication, you should separate them into their own subnets, set up virtual IP addresses, and then implement MPIO.

Basic configuration

| Item| Limit| Enforced| Comment |
|---|---|---|---|
|iSCSI target instances per appliance|256|Not Enforced||
|Initiators that can connect to the same iSCSI target instance|16|Enforced|When used with MPIO, you can connect no more than 4 sessions per initiator.|
|iSCSI initiators per appliance|256|Not Enforced||
|Virtual disks per appliance|256|Not Enforced||
|Virtual disks per iSCSI target instance|128|Enforced||
|Simultaneous sessions|64|Enforced||
|Snapshots per virtual disk|512|Enforced|There is a limit of 512 snapshots per independent iSCSI application volume and 64 snapshots for file share volumes. If the iSCSI virtual disks and file shares are on a common volume, the iSCSI snapshot limit is 448 (512 - 64).|
|Locally mounted virtual disks or snapshots per appliance|32 (on stand-alone or snapshots per appliance)|Enforced||
  
Fault Tolerance

| Item| Limit| Enforced| Comment |
|---|---|---|---|
|Failover cluster nodes|5|Not Enforced||
|Error recovery level (ERL)|0|Enforced||
|Multiple Connections per Session (MCS)|Not supported|Enforced||
|Simultaneous connections|64|Not Enforced||
|Multipath Input/Output (MPIO)|Supported|N/A||
|MPIO Paths|4|Not Enforced||
|Virtual disks over MPIO per initiator on a stand-alone server|64|Not Enforced|There is an initial delay after creating the disks before they appear to the Virtual Disk Service and the Disk Management snap-in because PnP first detects the devices and then MPIO detects the paths for each disk. This happens only one time per disk per appliance.|
|Virtual disks over MPIO per initiator on a clustered application server|32|Not Enforced||
|Converting stand-alone iSCSI Software Target to failover cluster or vice versa|Supported|N/A|No VHD or target will be preserved.|
  
Network

| Item| Limit| Enforced| Comment |
|---|---|---|---|
|Maximum number of active network ports|6|Not Enforced|Applies to network ports that are dedicated to iSCSI traffic, rather than the total number of network ports in the appliance.|
|Network port speed|10 gigabits per second (Gbps)|Not Enforced||
|IPv4|Supported|||
|IPv6|Supported|||
|TCP offload|Supported|||
|iSCSI offload|Not Supported|||
|Jumbo Frames|Supported|||
|IPsec|Supported|||
  
iSCSI virtual disks

| Item| Limit| Enforced |
|---|---|---|
|From an iSCSI initiator, which converts the iSCSI target disk from a fixed disk to a dynamic disk|Not supported|Not enforced|
|VHD minimum size format|8 MB|Enforced|
|Parent VHD size|2088890 MB|Enforced|
|Fixed VHd size|16776703 MB|Enforced|
|Differencing VHD size|2088960 MB|Enforced|
|VHD fixed format|Supported|N/A|
|VHD differencing format|Supported|N/A|
|VHD dynamic format|Not supported|N/A|
|FAT/FAT32 (hosting volume of VHD)|Not supported|Not enforced|
|NTFS|Supported|N/A|
|NTFS cluster size|4 kb|N/A|
|Non-Microsoft CFS|Not Supported|Enforced|
|Number of differencing VHDs per VHD|256|Not enforced|
|Number of parent VHDs per differencing VHD|1|Enforced|
|Number of boot operating systems that can be installed on one VHD|1|Not enforced|
|Thin provisioning|Not supported|N/A|
|LUN shrink|Not supported|N/A|
|LUN cloning|Not supported|N/A|
  
Windows operating systems on which the VDS and VSS hardware providers are supported

| Operating System| Limit| Enforced |
|---|---|---|
|Windows Server 2003 R2 x64|Supported|Enforced|
|Windows Server 2003 R2 x86|Supported|Enforced|
|Windows Server 2008 SP2 x64|Supported|Enforced|
|Windows Server 2008 SP2 x86|Supported|Enforced|
|Windows Server 2008 R2 x64|Supported|Enforced|
|Windows Storage Server 2008 x64|Supported|Enforced|
|Windows Storage Server 2008 x86|Not supported|Enforced|
|Windows Storage Server 2008 R2 x64|Supported|Enforced|
|All client operating systems (Windows XP, Windows Vista, Windows 7)|Not supported|Enforced|
  
iSCSI Software Target provider interoperability  

| iSCSI target version| iSCSI provider version| Supported |
|---|---|---|
|3.1|3.1|Supported|
|3.2|3.1|Not supported|
|3.2|3.1 (in-place upgrade)|Not supported|
|3.1|3.2|Supported|
|3.2|3.2|Supported|
|3.2|3.3|Supported|
|3.3|3.3|Supported|
  
Note: In-place upgrades from Microsoft iSCSI Software Target 3.1 to Microsoft iSCSI Software Target 3.3 are not supported. To upgrade to Microsoft iSCSI Software Target 3.3, you must first uninstall Microsoft iSCSI Software Target 3.1.

iSCSI Software Target virtual disk compatibility

| Created in version| Mounted in version| Supported |
|---|---|---|
|3.0|3.1|Not supported|
|3.0|3.2|Supported|
|3.1|3.2|Supported|
|3.1|3.3|Supported|
|3.2|3.3|Supported|
  
Microsoft iSCSI Software Target snap-in interoperability  

| Snap-in installed on| Managing iSCSI target on| Supported |
|---|---|---|
|Windows Storage Server 2008 R2|Windows Storage Server 2008 R2|Supported|
|Windows Storage Server 2008 R2, stand-alone server|Windows Storage Server 2008 R2, failover cluster node|Supported|
|Windows Storage Server 2008 R2, failover cluster node|Windows Storage Server 2008 R2, stand-alone server|Supported|
  
Miscellaneous

| Item| Supported |
|---|---|
|Install Microsoft iSCSI Software Target 3.3 snap-in on Windows XP, Windows Vista, or Windows 7|Not supported|
|Install Microsoft iSCSI Software Target 3.3 snap-in on x86 version of Windows Storage Server 2008|Not supported|
|Use Microsoft iSCSI Software Target 3.3 snap-in to manage Microsoft iSCSI Software Target 3.2 target|Supported|
|Use Microsoft iSCSI Software Target 3.2 snap-in to manage Microsoft iSCSI Software Target 3.3 target|Not supported|
