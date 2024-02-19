---
title: Feature and performance optimization of Hyper-V Replica (HVR)
description: This article describes the registry keys that apply to Hyper-V Replica feature
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, prvijay
ms.custom: sap:hyper-v-replica, csstroubleshoot
---
# Feature and performance optimization of Hyper-V Replica (HVR)

This article describes the registry keys that apply to Hyper-V Replica feature.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2767928

## Summary

Hyper-V Replica in Windows Server 2012 allows administrators to build a business continuity and disaster recovery solution for their virtualized infrastructure by replicating virtual machines from a Primary (or source) server to a Replica  (or destination) server. Changes in the primary virtual machine are tracked and transferred at a frequent interval to the replica server. In the event of an unplanned failure of the virtual machine on the primary server, administrators have the ability to failover the virtual machine on the replica server.

Using the registry keys mentioned in this article, administrators will have the ability to fine tune the system in different deployments. The article captures the registry keys and the values supported.

## More information

All the registry keys that are discussed in this article are available under the following node:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Replication`
  
The list of the registry keys discussed in this article:

- DisableCertRevocationCheck
- MaximumActiveTransfers
- ApplyVHDLimit
- ApplyVMLimit
- ApplyChangeReplicaDiskThrottle  

Note that the registry keys are Server level settings and need to be set on each node of the cluster where applicable and desired.

#### DisableCertRevocationCheck

Description: Hyper-V Replica supports certificate based mutual authentication, which allows the primary server to connect to the replica server over HTTPS. When establishing this connection, as part of validating the certificate, Hyper-V Replica checks if the issuing Certificate Authority (CA) has revoked the certificate.

However, due to deployment restrictions, this check would fail if the certificate revocation list (CRL) distribution point (CDP) is inaccessible. The check would also fail if self-signed certificates (generated using *makecert*) were used in lab deployments. Administrators can work around this restriction by setting this key.

Supported Values: 0, 1

Input interpretation:

- 0: Certificate revocation check is enabled
- 1: Certificate revocation check is disabled
 Default value: 0

Primary/Replica server:  This key can be set in both the primary and replica servers as required.

#### MaximumActiveTransfers

Description: Changes on the primary VM are tracked by Hyper-V Replica in a change log file that is transmitted to the replica server at a frequent interval. In a multi-VM-replication scenario, if the change log file for each of the replicating VM is transferred sequentially, this could starve or delay the transmission of the change log file of some other VM. If the change log file for all the replicating VMs are transferred in parallel, it would affect the transfer time of all the VMs due to network resource contention. In either scenario, the Recovery Point Objective (RPO) of the replicating VMs is affected.

An optimal value for the number of parallel transfers is got by dividing the available WAN bandwidth (measured in Mbps) by the TCP throughput. The TCP throughput can be got by observing the data transfer rate (Mbps) when copying a file between the primary and replica servers. It is worth noting that the value captures the number of parallel network transfers and *not* the number of VMs that are enabled for replication.

Supported Values: Specify any integer value between 1 and 1024.

Input interpretation:

- 1: Change log file for each replicating VMs log file is sent sequentially.
- 2: At any point, change log files from 2 replicating VMs are sent in parallel
- 3: At any point, change log files from 3 replicating VMs are sent in parallel
- N: At any point, change log files from N replicating VMs are sent in parallel.  

Default value: 3 (At any point, log files from 3 VMs are sent in parallel)

Primary/Replica server: This key is applicable on any server that has a VM on which replication is enabled (primary server). This key does not  throttle the number of incoming connections. The vmms service needs to be restarted after changing this key.

#### ApplyVHDLimit

Description: On the Replica server, Hyper-V Replica receives the incoming log file and applies the log file to the corresponding Replica VM. The apply log operation is at a VHD level and the operation is done in parallel across replicated VMs and across VHDs that belong to the same VM. Administrators can opt to pick a non-default value that would limit/increase the number of parallel operations for every VM.

Supported Values: Any value between 0 and 260

Input Interpretation:

- Setting a value '0' indicates that the 4 VHDs per VM are processed in parallel.
- Setting any other value indicates the corresponding set of VHDs per VM that can be processed in parallel.  

Default value: This name is not created by default under the Replication registry node. Administrators would need to manually create a DWORD under the following registry key and set the corresponding value.

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Replication`

> [!Note]
> If the value is not present or set to 0, it indicates that the replica server will process 4 VHDs in parallel per VM.

Primary/Replica server: This key is applicable only on the Hyper-V server that receives replication traffic (replica server). VMMS does not need to be restarted for the key to take effect.

#### ApplyVMLimit

Description: The Hyper-V Replica server can receive the VM replicas from different primary servers and administrators may wish to control the number of parallel apply log operations from a single primary server. This registry key allows the administrator to set this limit.

Supported Values: Any value greater than 0

Input Interpretation:

- Setting a value '0' indicates that the apply-log operation can happen on any number of VMs from one server.
- Setting any other value (1..N) controls the number of VMs from a single primary server, on which (parallel) apply-log operations can happen.  

 Default value: This name is not created by default under the Replication registry node. Administrators would need to manually create a DWORD under the following registry key and set the corresponding value.

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Replication`

> [!Note]
> If the key is not present or set to 0, it indicates that the replica server will process all the apply log operations in parallel.

Primary/Replica server: This key is applicable only on the Hyper-V server that receives replication traffic (replica server).

#### ApplyChangeReplicaDiskThrottle

Description: On the Replica server, Hyper-V Replica receives the incoming log file and applies the log file to the corresponding Replica VM. Based on the scale of the deployment and the disk subsystem, administrators might wish to throttle the apply-log disk operations by modifying this registry key.

Supported Values: Any value greater than and equal to zero.

Input Interpretation:

- 0 indicates that the apply-log operation in unbounded (maximum queue depth of 256 per VHD).
- Setting any other value dictates the queue depth across all replicated VHDs.
 Default value: This name is not created by default under the Replication registry node. Administrators would need to manually create a DWORD under the following registry key and set the corresponding value.

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Replication`

Primary/Replica server: This key is applicable only on the Hyper-V server that receives replication traffic (replica server).
