---
title: FRS event log error codes
description: Introduces a list of events that are caused by File Replication Service (FRS). These events are displayed in the FRS log.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, Nedpyle
ms.custom: sap:frs, csstroubleshoot
ms.subservice: networking
---
# FRS event log error codes

This article introduces the event log entries that the File Replication Service (FRS) generates.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 308406

## Event ID 13500, 13501, 13502, 13503, 13504, 13505, and 13506

> Event ID=13500  
Severity=Error  
File Replication Service

> Event ID=13501  
Severity=Informational  
The File Replication Service is starting.  

>Event ID=13502  
Severity=Informational  
The File Replication Service is stopping.  

> Event ID=13503  
Severity=Informational  
The File Replication Service has stopped.

>Event ID=13504  
Severity=Error  
The File Replication Service stopped without cleaning up.

> Event ID=13505  
Severity=Error  
The File Replication Service has stopped after taking an assertion failure.

> Event ID=13506  
Severity=Error  
The File Replication Service failed a consistency check (%3) in "%1" at line %2.

When these event logs appears, the File Replication Service will restart automatically at a later time. If this problem persists, a subsequent entry in this event log describes the recovery procedure.

For more information about the automatic restart, press Win + R, run *compmgmt.msc* to open **Computer Management**, **System Tools**, **Services**, **File Replication Service**, and **Recovery**.

## Event ID 13507

> Event ID=13507  
Severity=Error  
The File Replication Service can't start replica set %1 on computer %2 for directory %3 because the type of volume %4 isn't NTFS 5.0 or later.

The volume's type can be found by running `chkdsk %4`.

The volume can be upgraded to NTFS 5.0 or later by running `chkntfs /E %4` command.

## Event ID 13508

> Event ID=13508  
Severity=Warning  
The File Replication Service is having trouble enabling replication from %1 to %2 for %3 using the DNS name %4. FRS will keep retrying.

Following are some of the reasons you would see this warning.

1. FRS can't correctly resolve the DNS name %4 from this computer.  
2. FRS is not running on %4.  
3. The topology information in the Active Directory Domain Services for
this replica has not yet replicated to all the Domain Controllers.

This event log message will appear once per connection.  After the problem is fixed, you'll see another event log message indicating that the connection
has been established.

## Event ID 13509, 13510

> Event ID=13509  
Severity=Warning  
The File Replication Service has enabled replication from %1 to %2 for %3 after repeated retries.

> Event ID=13510  
Severity=Error  
The File Replication Service on the computer %1 can't communicate with the File Replication Service on the computer %2.  

To troubleshoot the issues, follow these steps:

1. Verify that the computer %2 is up and running.

2. Verify that the File Replication Service is running on %2 by typing *net start ntfrs* on %2.

3. Verify that the network is functioning between %1 and %2 by typing `ping %1` on %2 and `ping %2` on %1.  
   If the pings succeed, then retry the failed operation.  
   If the pings fail, then there may be problems with the DNS server.

The DNS server is responsible for mapping computer names to IP addresses. The commands `ipconfig` and `nslookup` help diagnose problems with the DNS server.

Typing `ipconfig /all` will list the computer's IP address and the IP address of the computer's DNS servers. Type `ping <DNS server's IP address>` to verify that a DNS server is available. The DNS mapping for %2 or %1 can be verified by typing `nslookup` and then typing *%2* and then *%1* on %1 and %2. Be sure to check out the DNS server on both %1 and %2; a DNS problem on either computer will prevent proper communication.

- Some network problems between %1 and %2 can be cleared up by flushing the DNS Resolver Cache. Type `ipconfig /flushdns`.
- Some network problems between %1 and %2 can be cleared up by renewing the IP address. Type `ipconfig /release` followed by `ipconfig /renew`.
- Some network problems between %1 and %2 can be cleared up by resetting the computer's DNS entry. Type `net stop NetLogon` followed by `net start NetLogon`.
- Some problems between %1 and %2 can be cleared up by restarting the File Replication Service. Type `net stop ntfrs` followed by `net start ntfrs`.
- Some problems between %1 and %2 can be cleared up by restarting the computers %1 and %2 after closing running applications, especially dcpromo. Then, restart the computer.

Other network and computer problems are beyond the scope of this event log message.

## Event ID 13511

> Event ID=13511  
Severity=Error  
The File Replication Service is stopping on computer %1 because there is no free space on the volume containing %2.

The available space on the volume can be found by typing *dir %2*.

Once free space is made available on the volume containing %2, the File Replication Service can be restarted immediately by typing `net start ntfrs`. Otherwise, the File Replication Service will restart automatically at a later time.

For more information about the automatic restart, press Win + R, run *compmgmt.msc* to open **Computer Management**, **System Tools**, **Services**, **File Replication Service**, and **Recovery**.

For more information about managing space on a volume type `copy /?`, `rename /?`, `del /?`, `rmdir /?`, and `dir /?`.

## Event ID 13512

> Event ID=13512  
Severity=Warning  
The File Replication Service has detected an enabled disk write cache on the drive containing the directory %2 on the computer %1.

The File Replication Service might not recover when power to the drive is interrupted and critical updates are lost.  

## Event ID 13513

> Event ID=13513  
Severity=Error  
The File Replication Service on computer %1 is stopping because the database %2 is corrupted.  

The database can be recovered by typing `esentutl /d %2`.

Once the database has been successfully recovered, the File Replication Service can be restarted by typing `net start ntfrs`.

## Event ID 13514

> Event ID=13514  
Severity=Warning  
File Replication Service is initializing the system volume with data from another  
domain controller. Computer %1 cannot become a domain controller until this process  
is complete. The system volume will then be shared as SYSVOL.  

To check for the SYSVOL share, at the command prompt, type: `net share`.

When File Replication Service completes the initialization process, the SYSVOL share will appear.

The initialization of the system volume can take some time. The time is dependent on the amount of data in the system volume, the availability of other domain controllers, and the replication interval between domain controllers.

## Event ID 13515

> Event ID=13515  
Severity=Warning  
The File Replication Service may be preventing the computer %1 from becoming a domain controller while the system volume is being initialized and then shared as SYSVOL.  

Type `net share` to check for the SYSVOL share. The File Replication Service has stopped preventing the computer from becoming a domain controller once the SYSVOL share appears.

The initialization of the system volume can take some time. The time is dependent on the amount of data in the system volume.

The initialization of the system volume can be bypassed by first typing *regedit* and setting the value of SysvolReady to 1 and then restarting the Netlogon service.

> [!NOTE]
> Bypassing the system volume initialization is not recommended. Applications may fail in unexpected ways.

The value **SysvolReady** is located at `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters`.

The Netlogon service can be restarted by typing `net stop netlogon` followed by `net start netlogon`.

## Event ID 13516

> Event ID=13516  
Severity=Informational  
The File Replication Service is no longer preventing the computer %1 from becoming a domain controller. The system volume has been successfully initialized and the Netlogon service has been notified that the system volume is now ready to be shared as SYSVOL.  

Type `net share` to check for the SYSVOL share.

## Event ID 13517

> Event ID=13517  
Severity=Warning  
The File Replication Service won't check access to the API "%1".  

Access checks can be enabled for %1 by running *regedit*.

1. Press Win + R, type *regedit* in **Run** box and press Enter.
2. Expand `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Access Checks`, change %1 and %2 strings to **Enabled**.

Permissions can be changed by right clicking %1 and then clicking **Permissions...**.

## Event ID 13518

> Event ID=13518  
Severity=Warning  
The File Replication Service did not grant the user "%3" access to the API "%1".  

Permissions for %1 can be changed by running *regedit*.

1. Press Win + R, type *regedit* in **Run** box and press Enter.
2. Expand `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Access Checks`.
3. Right click %1, and then click **Permissions...**.

Access checks can be disabled for %1. Double-click on %2 and change the string to Disabled.

## Event ID 13519

> Event ID=13519  
Severity=Error  
The File Replication Service could not grant an unknown user access to the   API "%1".

Access checks can be disabled for "%1" by running *regedit*.

1. Press Win + R, type *regedit* in **Run** box and press Enter.
2. Expand `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Access Checks`, change %1 and %2 strings to **Enabled**.

Permissions can be changed by right clicking %1 and then clicking **Permissions...**.

## Event ID 13520

> Event ID=13520  
Severity=Warning  
The File Replication Service moved the pre-existing files in %1 to %2.  

The File Replication Service may delete the files in %2 at any time. Files can be saved from deletion by copying them out of %2. Copying the files into %1 may lead to name conflicts if the files already exist on some other replicating partner.

In some cases, the File Replication Service may copy a file from %2 into %1 instead of replicating the file from some other replicating partner.

Space can be recovered at any time by deleting the files in %2.

## Event ID 13521

> Event ID=13521  
Severity=Error  
The File Replication Service cannot enable replication on the comptuer %1   until a backup/restore application completes.  

A backup/restore application has set a registry key that prevents the File Replication Service from starting until the registry key is deleted or the system is rebooted.

The backup/restore application may still be running. Check with your local administrator before proceeding further.

The registry key can be deleted by running *regedit*.

> [!Caution]
> Deleting the registry key is not recommended. Applications may fail in unexpected ways.

1. Press Win + R, type *regedit* in **Run** box and press Enter.
2. Expand `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Backup/Restore`.
3. Delete **Stop NtFrs from Starting**.

## Event ID 13522

> Event ID=13522  
Severity=Warning  
The File Replication Service paused because the staging area is full. Staging files are used to replicate created, deleted, or modified files between partners. FRS will automatically remove least recently used files from this staging area (in the order of the longest time since the last access) until the amount of space in use has dropped below 60% of the staging space-limit, after which replication will resume.

If this condition occurs frequently, check the following information:

- Confirm that all direct outbound replication partners receiving updates from this member are online and receiving updates.
- Verify that the replication schedule for receiving partners is open or "on" for a sufficient window of time to accommodate the number of files being replicated.
- Consider increasing the staging area to improve system performance.

To change the staging space limit, run *regedit*:

1. Press Win + R, type *regedit* in **Run** box and press Enter.
2. Expand `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters`.
3. Change the value **Staging Space Limit in KB**.

## Event ID 13523

> Event ID=13523  
Severity=Warning  
The File Replication Service paused because the size of a file exceeds the   staging space limit. Replication will resume only if the staging space limit is increased.  

<!-- The staging space limit is %1 KB and the file size is %2 KB. -->

To change the staging space limit, run *regedit*:

1. Press Win + R, type *regedit* in **Run** box and press Enter.
2. Expand `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters`.
3. Change the value **Staging Space Limit in KB**.

## Event ID 13524

> Event ID=13524  
Severity=Error  
The File Replication Service is stopping on the computer %1 because a universally unique ID (UUID) cannot be created.

The SDK function `UuidCreate()` returned the error.

The problem may be the lack of an Ethernet address, token ring address, or network address. The lack of a network address implies an unsupported `netcard`.

The File Replication Service will restart automatically at a later time.

For more information about the automatic restart, press Win + R, run *compmgmt.msc* to open **Computer Management**, **System Tools**, **Services**, **File Replication Service**, and **Recovery**.

## Event ID 13525

> Event ID=13525  
Severity=Warning  
The File Replication Service cannot find the DNS name for the computer %1 because the "%2" attribute could not be read from the distinguished name "%3".

The File Replication Service will try using the name %1 until the
computer's DNS name appears.

## Event ID 13526

> Event ID=13526  
Severity=Error  
The File Replication Service cannot replicate %1 with the computer %2 because the computer's SID cannot be determined from the distinguished name "%3".

The File Replication Service will retry later.

## Event ID 13527 to 13546

> Event ID=13527  
Severity=Error  
The RPC binding failed in the Open function of the FileReplicaSet Object. The counter data for this object will not be available. The FileReplicaSet object contains the performance counters of the Replica sets whose files are being replicated by the File Replication Service.

> Event ID=13528  
Severity=Error  
The RPC binding failed in the Open function of the FileReplicaConn Object. The counter data for this object will not be available. The FileReplicaConn object contains the performance counters of the connections over which files are being replicated by the File Replication Service.

> Event ID=13529  
Severity=Error  
The RPC call failed in the Open function of the FileReplicaSet Object. The counter data for this object will not be available. The FileReplicaSet object contains the performance counters of the Replica sets whose files are being replicated by the File Replication Service.

> Event ID=13530  
Severity=Error  
The RPC call failed in the Open function of the FileReplicaConn Object. The counter data for this object will not be available. The FileReplicaConn object contains the performance counters of the connections over which files are being replicated by the File Replication Service.

> Event ID=13531  
Severity=Error  
The RPC binding failed in the Collect function of the FileReplicaSet Object. The counter data for this object will not be available until the binding succeeds. The FileReplicaSet object contains the performance counters of the Replica sets whose files are being replicated by the File Replication Service.

> Event ID=13532  
Severity=Error  
The RPC binding failed in the Collect function of the FileReplicaConn Object. The counter data for this object will not be available until the binding succeeds. The FileReplicaConn object contains the performance counters of the connections over which files are being replicated by the File Replication Service.

> Event ID=13533  
Severity=Error  
The RPC call failed in the Collect function of the FileReplicaSet Object. The counter data for this object will not be available until the call succeeds. The FileReplicaSet object contains the performance counters of the Replica sets whose files are being replicated by the File Replication Service.

> Event ID=13534  
Severity=Error  
The RPC call failed in the Collect function of the FileReplicaConn Object. The counter data for this object will not be available until the call succeeds. The FileReplicaConn object contains the performance counters of the connections over which files are being replicated by the File Replication Service.

> Event ID=13535  
Severity=Error  
The call to VirtualAlloc failed in the Open function of the FileReplicaSet Object. The counter data for this object will not be available. The FileReplicaSet object contains the performance counters of the Replica sets whose files are being replicated by the File Replication Service.

> Event ID=13536  
Severity=Error  
The call to VirtualAlloc failed in the Open function of the FileReplicaConn Object. The counter data for this object will not be available. The FileReplicaConn object contains the performance counters of the connections over which files are being replicated by the File Replication Service.

> Event ID=13537  
Severity=Error  
The call to the Registry failed in the Open function of the FileReplicaSet Object. The counter data for this object will not be available. The FileReplicaSet object contains the performance counters of the Replica sets whose files are being replicated by the File Replication Service.

> Event ID=13538 Severity=Error  
The call to the Registry failed in the Open function of the FileReplicaConn Object. The counter data for this object will not be available. The FileReplicaConn object contains the performance counters of the connections over which files are being replicated by the File Replication Service.

> Event ID=13539  
Severity=Error  
The File Replication Service cannot replicate %1 because the pathname of the replicated directory is not the fully qualified pathname of an existing, accessible local directory.  

> Event ID=13540  
Severity=Error  
The File Replication Service cannot replicate %1 because the pathname of the customer designated staging directory: %2 is not the fully qualified pathname of an existing, accessible local directory.

> Event ID=13541  
Severity=Error  
The File Replication Service cannot replicate %1 because it overlaps the File Replication Service's logging pathname %2.  

> Event ID=13542  
Severity=Error  
The File Replication Service cannot replicate %1 because it overlaps the File Replication Service's working directory %2.

> Event ID=13543  
Severity=Error  
The File Replication Service cannot replicate %1 because it overlaps the staging directory %2.  

> Event ID=13544  
Severity=Error  
The File Replication Service cannot replicate %1 because it overlaps the replicating directory %2.  

> Event ID=13545  
Severity=Error  
The File Replication Service cannot replicate %1 because it overlaps the staging directory %2 of the replicating directory %3.  

> Event ID=13546  
Severity=Error  
The File Replication Service could not prepare the root directory %1 for replication. This is likely due to a problem creating the root directory or a problem removing pre-existing files in the root directory.  

Check that the path leading up to the root directory exists and is accessible.

## Event ID 13547

> Event ID=13547  
Severity=Warning  
The File Replication Service detected an invalid parameter value in the registry. %1.  
>
> The expected registry key name is "%2".  
The expected value name is "%3".  
The expected registry data type is %4.  
The allowed range for this parameter is %5  
The data units for this parameter value are %6.  
The File Replication Service is using a default value of "%7".

To change this parameter, follow these steps:

1. Press Win + R, type *regedit* in **Run** box and press Enter.
2. Expand `HKEY_LOCAL_MACHINE`, click the key path: "%8", double-click on the value name and update the value. Add the value name if it does not exist.
3. Under the Edit Menu item. Type the value name exactly as shown above using the above registry data type. Make sure you observe the data units and allowed range when entering the value.

## Event ID 13548

> Event ID=13548  
Severity=Error  
The File Replication Service is unable to replicate with its partner computer because the difference in clock times is outside the range of plus or minus %1 minute.  
>
> The connection to the partner computer is: "%2" The detected time difference is: %3 minutes.

> [!Note]
> If this time difference is close to a multiple of 60 minutes, then it is likely that either this computer or its partner computer was set to the incorrect time zone when the computer time was initially set. Check that the time zone and the system time are correctly set on both computers.

If necessary, the default value used to test for computer time consistency may be changed in the registry on this computer. (Note: This is not recommended.)

To change this parameter, follow these steps:

1. Press Win + R, type *regedit* in **Run** box and press Enter.
2. Browse to `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NtFrs\Parameters`
3. Double-click on the value name `Partner Clock Skew In Minutes` and update the value.

If the value name is not present, add it by clicking **New** -> **DWORD** value function under the **Edit** menu item. Type the value name exactly as shown above.

## Event ID 13549

> Event ID=13549  
Severity=Error  
The File Replication Service is unable to replicate from a partner computer because the event time associated with the file to be replicated is too far into the future. It is %1 minute greater than the current time. This can happen if the system time on the partner computer was set incorrectly when the file was created or updated. To preserve the integrity of the replica set this file update will not be performed or propagated further.
>
> The file name is: "%2"  
The connection to the partner computer is:  
&nbsp;&nbsp;"%3"

> [!Note]
> If this time difference is close to a multiple of 60 minutes, then it is likely that this file may have been created or updated on the partner computer while the computer was set to the incorrect time zone when its computer time was initially set. Check that the timezone and time are correctly set on the partner computer.

## Event ID 13550

> Event ID=13550  
Severity=Error  
The File Replication Service is unable to open the customer designated staging directory for replica set %1. The path used for the staging directory is,  
&nbsp;&nbsp;"%2"  
The customer designated root path for this replica set is:  
&nbsp;&nbsp;"%3"

The service is unable to start replication on this replica set. Among the possible errors to check are:  

- An invalid staging path,
- A missing directory,
- A missing disk volume,
- A file system on the volume that does not support ACLs,
- A sharing conflict on the staging directory with some other application.

Correct the problem and the service will attempt to restart replication automatically at a later time.

## Event ID 13551

> Event ID=13551  
Severity=Error  
The File Replication Service is unable to open (or create) the pre-install directory under the customer designated replica tree directory for replica set %1. The path used for the pre-install directory is,  
&nbsp;&nbsp;"%2"  
The customer designated root path for this replica set is:  
&nbsp;&nbsp;"%3"

The service is unable to start replication on this replica set. Among the
possible errors to check are:  

- An invalid root path,
- A missing directory,
- A missing disk volume,
- A file system on the volume that does not support NTFS 5.0
- A sharing conflict on the pre-install directory with some other application.

Correct the problem and the service will attempt to restart replication automatically at a later time.

## Event ID 13552

> Event ID=13552  
Severity=Error  
The File Replication Service is unable to add this computer to the following replica set:  
&nbsp;&nbsp;"%1"  

This could be caused by a number of problems such as:  

- An invalid root path,
- A missing directory,
- A missing disk volume,
- A file system on the volume that does not support NTFS 5.0

The information below may help to resolve the problem:

- Computer DNS name is "%2"
- Replica set member name is "%3"
- Replica set root path is "%4"
- Replica staging directory path is "%5"
- Replica working directory path is "%6"
- Windows error status code is %7
- FRS error status code is %8

Other event log messages may also help determine the problem. Correct the problem and the service will attempt to restart replication automatically at a later time.

## Event ID 13553

> Event ID=13553  
Severity=Informational  
The File Replication Service successfully added this computer to the following replica set:  
&nbsp;&nbsp;"%1"  

Information related to this event is shown below:

- Computer DNS name is "%2"
- Replica set member name is "%3"
- Replica set root path is "%4"
- Replica staging directory path is "%5"
- Replica working directory path is "%6"

## Event ID 13554

> Event ID=13554  
Severity=Informational  
The File Replication Service successfully added the connections shown below to the replica set:  
&nbsp;&nbsp;"%1"  

More information may appear in subsequent event log messages.

## Event ID 13555

> Event ID=13555  
Severity=Error  
The File Replication Service is in an error state. Files will not replicate to or from one or all of the replica sets on this computer until the following recovery steps are performed.  

Recovery Steps:

1. The error state may clear itself if you stop and restart the FRS service. This can be done by performing the following in a command window:

   ```console
   net stop ntfrs
   net start ntfrs
   ```

    If this fails to clear up the problem, proceed as follows.

2. For Active Directory Domain Services Domain Controllers that do not host any DFS alternates or other replica sets with replication enabled:  

    If there is at least one other Domain Controller in this domain, then restore the "system state" of this DC from backup (using ntbackup or other backup-restore utility) and make it non-authoritative.

    If there are not other Domain Controllers in this domain, then restore the "system state" of this DC from backup (using ntbackup or other backup-restore utility) and choose the Advanced option that marks the sysvol as primary.

    If there are other Domain Controllers in this domain but ALL of them have this event log message, then restore one of them as primary (data files from primary will replicate everywhere) and the others as non-authoritative.

3. For Active Directory Domain Services Domain Controllers that host DFS alternates or other replica sets with replication enabled:

   1. If the Dfs alternates on this DC do not have any other replication
    partners then copy the data under that Dfs share to a safe location.
   2. If this server is the only Active Directory Domain Services Domain Controller for this domain then, before going to (3-c), make sure this server does not have any
   3. inbound or outbound connections to other servers that were formerly Domain Controllers for this domain but are now off the net (and will never be coming back online) or have been fresh installed without being demoted.  
   To delete connections, use the Sites and Services snap-in and look for Sites -> NAME_OF_SITE -> Servers->NAME_OF_SERVER->NTDS Settings -> CONNECTIONS.
   4. Restore the "system state" of this DC from backup (using ntbackup or other backup-restore utility) and make it non-authoritative.
   5. Copy the data from step (3-a) above to the original location after the sysvol share is published.

4. For other Windows servers:

   1. If any of the DFS alternates or other replica sets hosted by this server do not have any other replication partners then copy the data under its share or replica tree root to a safe location.

      ```console
      net stop ntfrs
      rd /s /q %1
      net start ntfrs
      ```

   2. Copy the data from step above to the original location after the service has initialized (5 minutes is a safe waiting time).

      > [!Note]
      > If this error message is in the event log of all the members of a particular replica set, then perform steps above on only one of the members.

## Event ID 13556

> Event ID=13556  
Severity=Error  
The File Replication Service has detected what appears to be an attempt to change the root path for the following replica set:  
&nbsp;&nbsp;"%1"

This is not allowed. To perform this operation, you must remove this member from the replica set and add the member back with the new root path.

It is possible that this is a transient error due to Active Directory Domain Services replication delays associated with updating FRS configuration objects. If file replication does not take place after an appropriate waiting time, which could be several hours if cross site Active Directory Domain Services replication is required, you must delete and readd this member to the replica set.

Information related to this event is shown below:

- Computer DNS name is "%2"
- Replica set member name is "%3"
- The current Replica set root path is "%4"
- The desired new Replica set root path is "%5"
- Replica staging directory path is "%6"

## Event ID 13557

> Event ID=13557  
Severity=Error  
The File Replication Service has detected a duplicate connection object between this computer "%6" and a computer named "%1".  
This was detected for the following replica set:  
&nbsp;&nbsp;"%2"

This is not allowed and replication will not occur between these two computers until the duplicate connection objects are removed.

It is possible that this is a transient error due to Active Directory Domain Services replication delays associated with updating FRS configuration objects. If file replication does not take place after an appropriate waiting time, which could be several hours if cross site Active Directory Domain Services replication is required, you must manually delete the duplicate connection objects by following the steps below:

1. Start the Active Directory Domain Services Sites and Services Snap-in.
2. Click on "%3, %4, %5, %6, %7".
3. Look for duplicate connections from "%1" in site "%8".
4. Delete all but one of the connections.

## Event ID 13558

> Event ID=13558  
Severity=Error  
The File Replication Service has detected a duplicate connection object between this computer "%7" and a computer named "%1".  
This was detected for the following replica set:  
&nbsp;&nbsp;"%2"

This is not allowed and replication will not occur between these two computers until the duplicate connection objects are removed.

It is possible that this is a transient error due to Active Directory Domain Services replication delays associated with updating FRS configuration objects. If file replication does not take place after an appropriate waiting time, which could be several hours if cross site Active Directory Domain Services replication is required, you must manually delete the duplicate connection objects by following the steps below:

1. Start the Active Directory Domain Services Users and Computers Snap-in.
2. Click the view button and advanced features to display the system node.
3. Click on "%3, %4, %5".
4. Under "%5" you will see one or more DFS-related replica set objects. Look for the FRS member object "%6" under the subtree for replica set "%2".
5. Under "%6" look for duplicate connections from "%1".
6. Delete all but one of the connections.

## Event ID 13559

> Event ID=13559  
Severity=Error  
The File Replication Service has detected that the replica root path has changed from "%2" to "%3". If this is an intentional move, then a file with the name NTFRS_CMD_FILE_MOVE_ROOT needs to be created under the new root path.  
This was detected for the following replica set:  
&nbsp;&nbsp;"%1"

Changing the replica root path is a two-step process that is triggered by
the creation of the NTFRS_CMD_FILE_MOVE_ROOT file.

1. At the first poll that will occur in %4 minutes this computer will be
deleted from the replica set.
2. At the poll following the deletion this computer will be re-added to the replica set with the new root path. This re-addition will trigger a full tree sync for the replica set. At the end of the sync, all the files will be at the new location. The files may or may not be deleted from the old location depending on whether they are needed or not.

## Event ID 13560 and 13561

> Event ID=13560  
Severity=Warning  
The File Replication Service is deleting this computer from the replica set "%1" as an attempt to recover from the error state,  
Error status = %2.  
At the next poll, which will occur in %3 minutes, this computer will be re-added to the replica set. The re-addition will trigger a full tree sync for the replica set.

> Event ID=13561  
Severity=Error  
The File Replication Service has detected that the replica set "%1" is in JRNL_WRAP_ERROR.  
>
> Replica set name is: "%1"  
Replica root path is: "%2"  
Replica root volume is: "%3"  

A Replica set hits JRNL_WRAP_ERROR when the record that it is trying to read from the NTFS USN journal is not found.

This can occur because of one of the following reasons.

1. Volume "%3" has been formatted.
2. The NTFS USN journal on volume "%3" has been deleted.
3. The NTFS USN journal on volume "%3" has been truncated. `Chkdsk` can truncate the journal if it finds corrupt entries at the end of the journal.
4. File Replication Service was not running on this computer for a long time.
5. File Replication Service could not keep up with the rate of Disk IO activity on "%3".

Following recovery steps will be taken to automatically recover from this error state.

1. At the first poll that will occur in %4 minutes this computer will be deleted from the replica set.
2. At the poll following the deletion this computer will be re-added to the replica set. The re-addition will trigger a full tree sync for the replica set.

## Event ID 13562 and 13563

> Event ID=13562  
Severity=Warning  
Following is the summary of warnings and errors encountered by File Replication Service while polling the Domain Controller %1 for FRS replica set configuration information.
>
> %2

> Event ID=13563  
Severity=Warning  
The File Replication Service has detected that the staging path for the replica set %1 has changed.  
>
> Current staging path = %2  
New staging path = %3

The service will start using the new staging path after it restarts.

The service is set to restart after every reboot. It is recommended that you manually restart the service to prevent loss of data in the staging directory. To manually restart the service, do the following:

1. Run `net stop ntfrs` or use the Services snap-in to stop File Replication Service.
2. Move all the staging files corresponding to replica set %1 to the new staging location. If more than one replica set are sharing the current staging directory, then it is safer to copy the staging files to the new staging directory.
3. Run `net start ntfrs` or use the Services snap-in to start File Replication Service.

## Event ID 13564

> Event ID=13564  
Severity=Warning  
The File Replication Service has detected that the volume holding the FRS debug logs is running out of disk space. This will not affect replication unless this volume hosts database, staging, or replica root paths as well.
>
> Path to the logs directory = %1

You can change the number and size of logs by adjusting the following registry values.

Sample values are shown below. These values are under the registry key `HKEY_LOCAL_MACHINE/SYSTEM/CurrentControlSet/Services/NtFrs/Parameters`

Debug Log Files REG_DWORD 0x5
Debug Log Severity REG_DWORD 0x2
Debug Maximum Log Messages REG_DWORD 0x2710

You can also change the path to the logs directory by changing the following value at the same location.

Debug Log File REG_SZ %windir%\debug

Changes to the registry values will take effect at the next polling cycle.

## Event ID 13565

> Event ID=13565  
Severity=Warning  
File Replication Service is initializing the system volume with data from another domain controller. Computer %1 cannot become a domain controller until this process is complete. The system volume will then be shared as SYSVOL.

To check for the SYSVOL share, at the command prompt, type:

```console
net share
```

When File Replication Service completes the initialization process, the SYSVOL share will appear.

The initialization of the system volume can take some time. The time is dependent on the amount of data in the system volume, the availability of other domain controllers, and the replication interval between domain controllers.

## Event ID 13566

> Event ID=13566  
Severity=Warning  
File Replication Service is scanning the data in the system volume. Computer %1 cannot become a domain controller until this process is complete.  
The system volume will then be shared as SYSVOL.

To check for the SYSVOL share, at the command prompt, type:

```console
net share
```

When File Replication Service completes the scanning process, the SYSVOL share will appear.

The initialization of the system volume can take some time. The time is dependent on the amount of data in the system volume.

## Event ID 13567

> Event ID=13567  
Severity=Warning  
File Replication Service has detected and suppressed an average of %1 or more file updates every hour for the last %2 hours because the updates did not change the contents of the file. The tracking records in FRS debug logs will have the filename and event time for the suppressed updates. The tracking records have the date and time followed by :T: as their prefix.  

Updates that do not change the content of the file are suppressed to prevent unnecessary replication traffic. Following are common examples of updates that do not change the contents of the file.

1. Overwriting a file with a copy of the same file.
2. Setting the same ACLs on a file multiple times.
3. Restoring an identical copy of the file over an existing one.

Suppression of updates can be disabled in registry editor.

1. Press Win + R, type *regedit* in **Run** box and press Enter.
2. Browse to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters`, and create or update the value "Suppress Identical Updates To Files" to 0 (Default is 1) to force identical updates to replicate.

## Event ID 13568

> Event ID=13568  
Severity=Error  
The File Replication Service has detected that the replica set "%1" is in JRNL_WRAP_ERROR.  
>
> Replica set name is: "%1"  
Replica root path is: "%2"  
Replica root volume is: "%3"  

A Replica set hits JRNL_WRAP_ERROR when the record that it is trying to read from the NTFS USN journal is not found. This can occur because of one of the following reasons.

1. Volume "%3" has been formatted.
2. The NTFS USN journal on volume "%3" has been deleted.
3. The NTFS USN journal on volume "%3" has been truncated. `Chkdsk` can truncate the journal if it finds corrupt entries at the end of the journal.
4. File Replication Service was not running on this computer for a long time.
5. File Replication Service could not keep up with the rate of Disk IO activity on "%3".

Setting the "Enable Journal Wrap Automatic Restore" registry parameter to 1 will cause the following recovery steps to be taken to automatically recover from this error state.  

1. At the first poll, which will occur in %4 minutes, this computer will be deleted from the replica set. If you do not want to wait %4 minutes, then run "net stop ntfrs" followed by "net start ntfrs" to restart the File Replication Service.
2. At the poll following the deletion this computer will be re-added to the replica set. The re-addition will trigger a full tree sync for the replica set.

> [!WARNING]
> During the recovery process data in the replica tree may be unavailable. You should reset the registry parameter described above to 0 to prevent automatic recovery from making the data unexpectedly unavailable if this error condition occurs again.

To change this registry parameter, follow these steps:

1. Press Win + R, type *regedit* in **Run** box and press Enter.
2. Expand `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NtFrs\Parameters`.
3. Double-click on the value name **Enable Journal Wrap Automatic Restore** and update the value.

If the value name is not present, you may add it with the New -> DWORD Value function under the Edit Menu item. Type the value name exactly as shown above.

## Event ID 13569

> Event ID=13569  
Severity=Error  
The File Replication Service has skipped one or more files and/or directories during primary load of the following replica set. The skipped files will not replicate to other members of the replica set.  
>
> Replica set name is: "%1"

A list of all the files skipped can be found at the following location. If a directory is skipped, then all files under the directory are also skipped.

Skipped file list: "%2"

Files are skipped during primary load if FRS is not able to open the file. Check if these
files are open. These files will replicate the next time they are modified.

## Event ID 13570

> Event ID=13570  
Severity=Error  
The File Replication Service has detected that the volume hosting the path
%1 is low on disk space. Files may not replicate until disk space is
made available on this volume.  

The available space on the volume can be found by typing
"dir /a %1".

For more information about managing space on a volume type *copy /?*,
*rename /?*, *del /?*, *rmdir /?*, and *dir /?*.

## Event ID 13571

> Event ID=13571  
Severity=Error  
The File Replication Service has detected that one or more volumes on
this computer have the same Volume Serial Number. File Replication
Service doesn't support this configuration. Files may not replicate
until this conflict is resolved.  

Volume Serial Number: %1
 List of volumes that have this Volume Serial Number: %2

The output of `dir` command displays the Volume Serial Number
before listing the contents of the folder.

## Event ID 13572

> Event ID=13572  
Severity=Error  
The File Replication Service was unable to create the directory "%1" to store debug log files.

If this directory doesn't exist, then FRS will be unable to write debug logs. Missing debug logs make it difficult, if not impossible, to diagnose FRS problems.

## Event ID 13573

> Event ID=13573  
Severity=Warning  
File Replication Service has been repeatedly prevented from updating:  
>
> File Name: "%1"
> File GUID: "%2"

Due to consistent sharing violations encountered on the file. Sharing violations occur when another user or application holds a file open, blocking FRS from updating it. Blockage caused by sharing violations can result in out-of-date replicated content. FRS will continue to retry this update, but will be blocked until the sharing violations are eliminated.

## Event ID 13574

> Event ID=13574  
Severity=Error  
The File Replication Service has detected that this server is not a domain controller. Use of the File Replication Service for replication of non-SYSVOL content sets has been deprecated and therefore, the service has been stopped. The DFS Replication service is recommended for replication of folders, the SYSVOL share on domain controllers and DFS link targets.

## Event ID 13575

> Event ID=13575  
Severity=Error  
This domain controller has migrated to using the DFS Replication service to replicate the SYSVOL share. Use of the File Replication Service for replication of non-SYSVOL content sets has been deprecated and therefore, the service has been stopped. The DFS Replication service is recommended for replication of folders, the SYSVOL share on domain controllers and DFS link targets.

## Event ID 13576

> Event ID=13576  
Severity=Error  
Replication of the content set "%1" has been blocked because use of the File Replication Service for replication of non-SYSVOL content sets has been deprecated. The DFS Replication service is recommended for replication of folders, the SYSVOL share on domain controllers and DFS link targets.  
