---
title: Job status failure messages in DPM
description: Describes an issue that may occur if the real-time monitoring component of an antivirus program is configured to monitor replicas and transfer log files of Data Protection Manager protected volumes.
ms.date: 04/08/2024
ms.reviewer: Mjacquet, ankito
---
# You receive job status failure messages in Data Protection Manager

This article helps you fix an issue in which job status failure messages occur if the real-time monitoring component of an antivirus program is configured to monitor replicas and transfer log files for Data Protection Manager protected volumes.

_Original product version:_ &nbsp; System Center Data Protection Manager  
_Original KB number:_ &nbsp; 928840

## Symptoms

After you configure Microsoft System Center Data Protection Manager to help protect the data on one or more file servers, you experience the following symptoms:

- File servers contain inconsistent replicas.
- When you use the Data Protection Manager Administrator console, you notice that data transfer rates may randomly slow.
- Data replication jobs may fail on one or more file servers. In this situation, job status information that resembles the following is generated on the affected file servers:

    Status message 1

    > Type: Consistency check  
    > Status: Failed  
    > Description: The DPM service was unable to communicate with the DPM File Agent on server localhost. (ID 52 Details: The specified network name is no longer available (0x80070040))  
    > Start time: \<*startTime*>  
    > Time elapsed: \<*elapsedTime*>  
    > Data transferred: 118.51 GB (127253828784 bytes)  
    > Data transfer rate: 464 KB/s  
    > Source details: \<*Volume*> on \<*ServerName*>  
    > Protection group members: 7  
    > Details  
    > Protection group: \<*ProtectionGroup*>  

    Status message 2

    > Type: Synchronization  
    > Status: Failed  
    > Description: The replica on the DPM server for \<*Volume*> on \<*ServerName*> is inconsistent. Changes cannot be applied to file \<*FilePath*>. (ID 109 Details: The process cannot access the file because it is being used by another process (0x80070020))  
    > Start time: \<*startTime*>  
    > Time elapsed: \<*elapsedTime*>  
    > Data transferred: 1.79 GB (1916715024 bytes)  
    > Data transfer rate: 100 KB/s  
    > Source details: \<*Volume*> on \<*ServerName*>  
    > Protection group members: 7  
    > Details  
    > Protection group: \<*ProtectionGroup*>

    Status message 3

    > Type: Synchronization  
    > Status: Failed  
    > Description: The replica on the DPM server for \<*Volume*> on \<*ServerName*> is inconsistent. Changes cannot be applied to file \<*FilePath*>. (ID 109 Details: Access is denied (0x80070005))  
    > Start time: \<*startTime*>  
    > Time elapsed: \<*elapsedTime*>  
    > Data transferred: 1.57 GB (1691028040 bytes)  
    > Data transfer rate: 207 KB/s  
    > Source details: \<*Volume*> on \<*ServerName*>  
    > Protection group members: 2  
    > Details  
    > Protection group: \<*ProtectionGroup*>

    Status message 4

    > Type: Synchronization  
    > Status: Failed  
    > Description: The replica on the DPM server for \<*Volume*> on \<*ServerName*> is inconsistent. Changes cannot be applied to file \<*FilePath*>. (ID 109 Details: The system cannot find the path specified (0x80070003))  
    > Start time: \<*startTime*>  
    > Time elapsed: \<*elapsedTime*>  
    > Data transferred: 116.74 MB (122411432 bytes)  
    > Data transfer rate: 221 KB/s  
    > Source details: \<*Volume*> on \<*ServerName*>  
    > Protection group members: 2  
    > Details
    > Protection group: \<*ProtectionGroup*>

    > [!NOTE]
    > You may also receive other job status failure messages.

- Data Protection Manager synchronization may fail. In this situation, you receive status messages that resemble one of the following:

    Status message 1

    > Description: Since \<*date and time*>, synchronization jobs for \<*path*> on \<*ServerName*> have failed. The total number of failed jobs = 4. The last job failed for the following reason: (ID 3115) DPM was not able to complete this job within the time allocated for the set of jobs associated with this protection group. (ID 3151).

    Status message 2

    > Type: Synchronization  
    > Status: Failed  
    > Description: The replica on the DPM server for \<*path*> on \<*ServerName*> is inconsistent. Changes cannot be applied to file \<*path and file name*>. (ID 109 Details: Access is denied (0x80070005)  
    > Start time: \<*date and time*>  
    > Time elapsed: \<*elapsedTime*>  
    > Data transferred: 18.75 MB (19662648 bytes)  
    > Data transfer rate: 83 KB/s  
    > Source details: \<*path*> on \<*ServerName*>  
    > Protection group: \<*ProtectionGroup*>

## Cause

This problem may occur if the real-time monitoring component of an antivirus program is configured to monitor replicas and to transfer log files for Data Protection Manager protected volumes. You may experience this problem if the real-time monitoring component of an antivirus program monitors the Msdpmfsagent.exe program on the Data Protection Manager server.

## Resolution

To resolve this problem, see [Run antivirus software on the DPM server](/system-center/dpm/run-antivirus-server).

## More information

Antivirus real-time monitoring of replicas and of transfer log files decreases performance in Data Protection Manager. This behavior occurs because the real-time monitoring process causes the antivirus program to scan the transfer logs every time that Data Protection Manager synchronizes with the file server. Also, the real-time monitoring process causes the antivirus program to scan all the affected files every time that Data Protection Manager applies changes to the replicas.

We recommend that you configure the antivirus program to delete infected files from file servers and from the Data Protection Manager server instead of using the quarantine feature to archive infected files. This is to help prevent data corruption of replicas and shadow copies.

If an antivirus program is configured to automatically clean and quarantine an infected file, the antivirus program modifies the file. However, Data Protection Manager is unable to detect these changes to the file. When Data Protection Manager tries to synchronize a replica that has been modified by another program, the replica and the shadow copies of the file may be corrupted. For more information about how to configure an antivirus program to delete infected files, see the program documentation, or contact the manufacturer of the antivirus program.
