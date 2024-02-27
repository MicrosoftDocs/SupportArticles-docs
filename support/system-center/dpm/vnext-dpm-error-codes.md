---
title: System Center vNext DPM error codes
description: Lists error codes that may occur in System Center vNext Data Protection Manager.
ms.date: 02/27/2024
ms.reviewer: aaronmax, jchornbe, DPMTechReview, sooryar
---
# System Center vNext Data Protection Manager error codes

This article describes the error codes that may occur in Microsoft System Center vNext Data Protection Manager.

_Original product version:_ &nbsp; System Center Data Protection Manager  
_Original KB number:_ &nbsp; 3041345

> [!NOTE]
>
> - For some error codes, the tables in this article list additional troubleshooting information.
> - In the messages and troubleshooting information, italic text that's enclosed by angle brackets (for example, \<_ServerName_>) represents the name of a specific entity (such as a server name).

## Error codes 0-100

|Error code|Message|Additional information|
|---|---|---|
|0|Unable to create the Shadow Copy. The cause of the failure was the replica is lost association between the replica and diff area.| |
|7|Unable to connect to the Active Directory Domain Services database.|Make sure that the DPM server is a member of a domain and that a domain controller|
|8|PreDiscoveryConcurrencyError| |
|9|SavedInquiryConcurrencyError| |
|10|ADGConcurrencyError| |
|11|DPM cannot browse <_ServerName_> because the host is unreachable.|Verify that <*ServerName*> is online and is remotely accessible from the DPM server. If a firewall is enabled on <*ServerName*>, verify that it's not blocking requests from the DPM server.|
|12|DPM can't browse <_ServerName_> because access was denied.|Verify that the computer that is running DPM has DCOM launch and access permissions for <*ServerName*> and that the system time on the DPM server and <*ServerName*> is synchronized with the system time on the domain controller.|
|13|DPM can't browse <_ServerName_> because the protection agent isn't responding.|Check the recent records from the DPMRA source in the Application log on <*ServerName*> to find out why the agent failed to respond.<ol><li>Verify that the DPM server is remotely accessible from <*ServerName*>.</li><li> If a firewall is enabled on the DPM server, verify that it's not blocking requests from <*ServerName*>. </li><li>Restart the DPM Protection Agent (DPMRA) service on <*ServerName*>. If the service doesn't start, reinstall the protection agent.</li></ol>|
|14|DPM can't browse <_ServerName_> because of a communication error between DPM and the protection agent on the computer.|<br/>1. Verify that <*ServerName*> is remotely accessible from the DPM server. <br/>2. If a firewall is enabled on <*ServerName*>, verify that it's not blocking requests from the DPM server. <br/>3. Restart the DPM Protection Agent (DPMRA) service on <*ServerName*>. If the service doesn't start, reinstall the protection agent.|
|15|DPM cannot browse <_ServerName_> because a protection agent isn't installed on <*ServerName*> or the computer is restarting.|Install the protection agent.|
|16|DPM can't access the path <_FileName_> because part of the path has been deleted or renamed.|Check the path, and then enter it again.|
|17|ADGAgentUnableToReadOrAccess| |
|18|ADGUnprotectableNE| |
|19|ADGAgentUnableToAccessFolder| |
|30|DPM can't contact <_ServerName_> until you complete the protection agent installation by restarting the computer.|Restart the server, and then try the operation again.|
|31|DPM can't browse <_ServerName_> because the host is unreachable. |<br/>1. Make sure that <*ServerName*> is online and is remotely accessible from the DPM server. <br/>2. If a firewall is enabled on <*ServerName*>, make sure that it's not blocking requests from the DPM server.|
|32|DPM can't browse <_ServerName_> because access is denied.|On the **Agents** tab in the **Management** task area, check the status of the agent. Also, verify that the system times on the DPM server and the protected computer are synchronized with the system time on the domain controller.|
|33|DPM can't browse <_ServerName_> because the agent isn't responding.|If you just installed an agent on <*ServerName*>, the computer might be restarting. Wait a few minutes after Windows starts for the agent to become available. Otherwise, to troubleshoot this error, follow these steps: <ol><li>Check recent records from the DPMRA source in the Application event log on <*ServerName*> to find out why the agent failed to respond. </li><li>Make sure that the DPM server is remotely accessible from <*ServerName*>.</li><li>If a firewall is enabled on the DPM server, make sure that it's not blocking requests from <*ServerName*>. </li><li> Restart the DPM Protection Agent service on <*ServerName*>. If the service doesn't start, reinstall the protection agent.</li></ol>|
|34|DPM can't browse <_ServerName_> because of a communication error with the agent.|If you just installed an agent on <*ServerName*>, the computer might be restarting. Wait a few minutes after Windows starts for the agent to become available. Otherwise, to troubleshoot this error,  follow these steps: <ol><li>Make sure that the DPM server is remotely accessible from <*ServerName*>. </li><li>If a firewall is enabled on the DPM server, make sure that it's not blocking requests from <*ServerName*>. </li><li>Restart the DPM Protection Agent service on <*ServerName*>. If the service doesn't start, reinstall the protection agent.</li></ol>|
|35|DPM can't browse <_ServerName_>, either because no agent is installed on <*ServerName*> or because the computer is rebooting.|Install the protection agent.|
|36|DPM can't access the path *\<Component>* because part of the path has been deleted or renamed.|Check the path, and then enter it again.|
|37|DPM can't access <_FileName_> because an element has been exclusively locked by another process.|Try the selection later or check to see if the object is locked by another process.|
|38|DPM is unable to enumerate contents in *\<Component>* on the protected computer <_ServerName_>. Recycle Bin, System Volume Information folder, non-NTFS volumes, DFS links, CDs, Quorum Disk (for cluster) and other removable media can't be protected.|None.|
|39|DPM failed to access the path <_FileName_>.|Verify the path exists and is accessible.|
|40| *\<ObjectName>* contains a mount point at *\<MountPointPath>* whose destination volume is *\<VolumeName>*. Do you also want to protect the volume *\<VolumeName>*?| |
|41|DPM failed to communicate with <_ServerName_> because the computer is unreachable. |<br/>1. Make sure that <*ServerName*> is online and remotely accessible from the DPM server. <br/>2. If a firewall is enabled on <*ServerName*>, make sure that it's not blocking requests from the DPM server. <br/>3. If you are using a backup LAN, make sure that the backup LAN settings are valid. <br/>4. If you are using clustered remote SMB storage, you may see this error when a backup job tries to start just after the primary cluster owner is switched. If it's the case, wait for some time and retry the operation.|
|42|DPM failed to communicate with the protection agent on <_ServerName_> because access is denied. |<br/>1. Verify that the DPM server has DCOM launch and access permissions for <*ServerName*> and that the system time on the DPM server and the protected computer is synchronized with the system time on the domain controller. <br/>2. If this computer doesn't have to be protected any longer, you may want to remove the record for this computer from the database. To remove the record, in the **Management** task area on the **Agents** tab, select the computer name. In the **Details** pane, select **Remove Record**. <br/>3. Make sure that your domain controller can be reached from the DPM server and the protected computer. <br/>4. If you're still having communication issues between DPM and the protected computer, review the event log on the DPM server and the protected computer for events related to communication issues.|
|43|DPM failed to communicate with the protection agent on <_ServerName_> because the agent isn't responding. |<ol><li>Check recent records from the DPMRA source in the Application Event log on <*ServerName*> to find out why the agent failed to respond. </li><li> Make sure that the DPM server is remotely accessible from <*ServerName*>. </li><li> If a firewall is enabled on the DPM server, make sure that it's not blocking requests from <*ServerName*>.</li><li>Restart the DPM Protection Agent service on <*ServerName*>. If the service doesn't start, reinstall the protection agent.</li></ol><br/>If the steps above don't resolve the issue,see [Error ID 43 or 60 when you use System Center 2012 Data Protection Manager](https://support.microsoft.com/help/3082409).|
|44|RmFsCaseSensitive||
|45|DPM failed to communicate with the protection agent on <_ServerName_> because the agent isn't installed or the computer is restarting.|Install the protection agent. If the computer is in the process of restarting, allow some time for the computer to come online.|
|46|DPM failed to perform the operation because too many objects are selected. Select fewer objects, and then retry the operation.|<ul><li>If you're trying to protect a large number of data sources on a volume, consider protecting the whole volume instead of individual data sources.</li> <li> If you're trying to recover a large number of folders or files from a volume, consider recovering the parent folder, or divide the recovery into multiple operations.|
|47|Some components of the protection agent on <_PSServerName_> weren't installed or configured properly.|<br/>1. Verify that the targeted computer <*PSServerName*> isn't running an unsupported version of the operating system. <br/>2. Restart the computer <*PSServerName*>. If the problem persists, on <*PSServerName*>, uninstall the DPM protection agent by using **Add or Remove Programs**. Then, on the DPM server, in the **Management** task area on the **Agents** tab, reinstall the protection agent on <*PSServerName*>.|
|48| <_ServerName_> needs to be restarted. It might be because the computer hasn't been restarted since the protection agent was installed.|Restart the server. If you have protected data on this server, synchronize the data by performing a consistency check after the restart.|
|49|The protection agent timed out while trying to access the file <_FileName_> for volume *\<PSVolumeName>* on <_PSServerName_>.|Make sure that the file is accessible. Synchronize the data with a consistency check.|
|50|The DPM protection agent on <_PSServerName_> failed to perform a consistency check for file <_FileName_> on volume *\<PSVolumeName>*.|Make sure that the file is available and rerun the consistency check.|
|51|Root directories were added to or removed from protection for volume *\<PSVolumeName>* on <_PSServerName_>.|No action required.|
|52|The DPM service was unable to communicate with the protection agent on <_ServerName_>.|Restart the DPM Replication Agent (DPMRA) service on <*ServerName*>.|
|53|DPM failed to communicate with <_ServerName_> because of a communication error with the protection agent.|<br/>1. Make sure that <*ServerName*> is remotely accessible from the DPM server.<br/>2. If a firewall is enabled on <*ServerName*>, make sure that it's not blocking requests from the DPM server.<br/>3. Restart the DPM Replication Agent service on <*ServerName*>. If the service doesn't start, reinstall the protection agent.|
|54|RmFSFInsufficientResources| |
|55|The protected volume *\<VolumeName>* on <_ServerName_> couldn't be accessed. The volume might have been removed or dismounted, or another process might be exclusively using it.|To resolve this error, make sure that volume *\<VolumeName>* can be accessed. <br/><br/>If a new volume *\<VolumeName>* was created to replace a previously protected volume with the same name, and you want to protect the new volume, you must remove the original volume from its protection group, and then add the new volume to the protection group. You can retain the replica for future recoveries. <br/><br/>If you no longer want to protect any data sources on the computer, you can uninstall the protection agent from the computer. If the volume has been permanently removed or deleted, remove the volume from its protection group (optionally choosing to retain the replica for future recoveries), and then inactivate the alert by selecting **Inactive alert**.|
|56|DPM failed to move data because it didn't receive the completion status from the protection agent.|Retry the operation.|
|57|DPM can't continue to protect the data on *\<_TargetServerName_>* because there is not enough disk space available on one or more of its volumes.|Free up disk space and retry.|
|58|DPM is out of disk space for the replica.|Make sure that there are no pending disk threshold alerts active for this data source, and then rerun the job. DPM might have automatically grown the volume and resolved the alerts.|
|59|DPM was used to initiate the recovery for <_DatasourceType_><_DatasourceName_> on <_ServerName_>. After this operation is complete, DPM must synchronize its replica with the data recovered on the protected computer in order to continue protection. The replica is being marked inconsistent to enable DPM to run a consistency check to synchronize the replica.|No action required.|
|60|The protection agent on <_ServerName_> was temporarily unable to respond because it was in an unexpected state.|Retry the operation. If the problem remains, it may be because there is an open file on the server being protected. In this scenario there are three potential workarounds: <ul><li>Stop the application and then manually run the DPM replica or consistency checks. </li> <li>Develop a process that copies the data to be protected to a separate folder, then configure DPM to protect that folder. </li> <li>Configure pre-backup and post-backup scripts on the protected server that utilize .cmd batch files to stop the application that's holding the file open, let the DPM backup run, and then restart the application after the backup is complete. This option means that the application will be unavailable during the time that the backup is running.</li> </ul>|
|61|RmFileMovedIn| |
|62|Cannot find the volume *\<VolumeName>* on the computer running DPM.|Make sure that the storage pool disk is accessible. If it isn't, reallocate disk space, and then reprotect the data.|
|63|DPM can't protect <_FileName_> because there is no virtual name configured for the Resource Group to which the file belongs.|Make sure that the Resource Group has a virtual name configured. Also, check that the dependencies between cluster resources are configured correctly.|
|64|Volume *\<VolumeName>* is offline on the DPM server.|On the DPM server, open Server Manager, expand **Diagnostics** > **Event Viewer** > **Windows Logs**, and then take the recommended action in the Application log.|
|65|The DPM service was unable to communicate with the protection agent on <_ServerName_>.|Restart the DPM Replication Agent service on the server.|
|77|The consistency check job failed due to an internal error.|Rerun the consistency check job.|
|78|DPM is unable to continue protection for data sources on the protected computer <_ServerName_> because DPM has detected an incompatible filter installed on this computer.|To resolve, see [Incompatible filter driver errors](/previous-versions/system-center/data-protection-manager-2010/ff399635(v=technet.10)).|
|91|The replica of <_DatasourceType_><_DatasourceName_> on <_ServerName_> isn't consistent with the protected data source.|No action required.|
|92|Can't access volume on the replica of <_DatasourceType_><_DatasourceName_> on <_ServerName_>.|Stop protection of <*DatasourceName*>, and then reconfigure protection for this data source.|
|93|The replica of <_DatasourceType_><_DatasourceName_> on <_ServerName_> is being created.|If the replica creation is scheduled for a later time, no action is required. If you have chosen to manually create the replica, copy the data, and then synchronize with consistency check.|
|94|The data source <_DatasourceType_><_DatasourceName_> on <_ServerName_> is no longer protected, and DPM no longer has a replica of it. The replica was probably deleted because the **Stop Protection without retaining replica** task was run for this data source.|Wait for the replica creation operation to complete. Then, retry the job. No action is required. Wait for the DPM database to be updated to reflect that this data source is no longer protected.|
|95|Job failure on replica of <_DatasourceName_> on <_ServerName_> was caused by an ongoing synchronization operation.|Cancel the ongoing synchronization operation, or wait for it to complete. Then retry the operation.|
|96|Job failure on replica of <_DatasourceName_> on <_ServerName_> was caused by an ongoing replica creation.|Cancel the consistency check operation, or wait for it to complete. Then retry the job.|
|97|Job failure on replica of <_DatasourceName_> on <_ServerName_> was caused by an ongoing consistency check operation.|Cancel the consistency check operation, or wait for it to complete. Then retry the job.|
|98|Job failure on replica of <_DatasourceName_> on <_ServerName_> was caused by a recovery operation currently in progress.|Cancel the recovery operation, or wait for it to complete. Then retry the job.|
|99|Job failure on replica of <_DatasourceName_> on <_ServerName_> was caused by an ongoing stop-protection job.|Cancel the stop-protection operation, or wait for it to complete. Then retry the job.|
|100|Job failure on replica of <_DatasourceName_> on <_ServerName_> was caused by an ongoing recovery point creation.|Cancel the recovery point operation, or wait for it to complete. Then retry the operation.|
  
## Error codes 101-200

|Error code|Message|Additional information|
|---|---|---|
|101|The job failed because the replica for this data source is being deleted, probably because the **Stop Protection without retaining replica** task was run for this data source.|No action is required. Wait for the DPM database to update to reflect that this data source is no longer protected.|
|104|An unexpected error occurred while the job was running.<br/><br/> or <br/><br/>Unknown error (0x80041010)|This error can appear if you are trying to protect a SQL Server database that has files on a remote share. It isn't supported by DPM. <br/><br/>Which can also occur if you are attempting to back up a Hyper-V VM on a host running Windows Server 2012 R2. DPM 2012 SP1 doesn't support this scenario. To backup a Hyper-V VM on a host running Windows Server 2012 R2 or later, upgrade DPM 2012 SP1 to DPM 2012 R2.|
|107|The DPM protection agent is no longer tracking changes on *\<PSVolumeName>* on <_PSServerName_>.|<br/>1. Check recent records from the FSRecord source in the System event log on <*PSServerName*> to find out why the problem occurred. <br/>2. Synchronize with consistency check.|
|108|RmMonitoringLogIsFull| |
|109|The replica on the DPM server for <_DatasourceType_><_DatasourceName_> on <_ServerName_> is inconsistent with the protected data source. Changes can't be applied.|No action required.|
|110|RmSpillLogIsNotPresentOrHasIncorrectSize| |
|111| <_ServerName_> has been restarted without being properly shut down.|No action required.|
|112|Changes for <_DatasourceType_><_DatasourceName_> on <_ServerName_> can't be applied to <_FileName_>.|No action required.|
|113|Job failure for <_DatasourceType_><_DatasourceName_> on <_ServerName_> was caused by an ongoing conflicting operation on <*ServerName*>.|Cancel the ongoing operation, or wait for it to complete. Then retry the job.|
|114|Job failure on <_DatasourceName_> on <_ServerName_> was caused by ongoing backup operation.|Cancel the operation, or wait for it to complete. Then retry the operation.|
|115|Job failure on <_DatasourceName_> on <_ServerName_> was caused by ongoing recovery from tape operation.|Cancel the operation, or wait for it to complete. Then retry the operation.|
|116|Job failure on <_ServerName_> was caused by other ongoing conflicting operations on that computer. Some applications don't allow parallel recovery and backup operations on the same data source.|Cancel the operations, or wait for them to complete. Then retry the operation.|
|117|The synchronization job failed due to an internal error.|<ul><li>For SQL Server, Exchange, or Windows SharePoint Services data, create a recovery point, enable short-term disk protection, and select **Create a recovery point by using express full backup**. </li><li>For other types of data, create a recovery point, and then select **Create a recovery point after synchronizing**.|
|118|The selected data cannot be recovered to the DPM server <_ServerName_> because the replica isn't in the **Replica creation pending** state.|Make sure that the replica is in **Replica creation pending** state before recovering.|
|130|You can't add more recovery points because the maximum number of recovery points for the entire retention range is *\<MaxLimit>*.|To increase the recovery points per day, you must either decrease the retention range or select fewer days of week.|
|131|File name extensions must begin with a `.` and can't contain any of the following characters: `/`, `\`, `:`, `*`, `?`, `"`, `<`, `>`, `|`|No action required.|
|132|Remove duplicate file name extensions.|Remove the extensions.|
|133|You can't choose this recovery point because the time difference between it and a previous recovery point is less than your specified synchronization frequency.<br/><br/>Specified synchronization frequency: *\<ValueEntered>*|Choose a recovery point that has a time difference with a previous recovery point that is equal to or greater than the specified synchronization frequency.|
|135|Can't protect this folder because data on other mount points of this volume have been selected for protection.|No action required.|
|136|Unable to create protection group because no disks or tape libraries available.|Configure a tape library or add a disk to the storage pool.|
|137|The protection group name entered already exists.|Specify a different name.|
|138|You have enabled protection of data on the system volume *\<ObjectName>*. If you also want to protect the system state of this computer, you must add the System State as a member of the protection group separately.|No action required.|
|139|InvalidTimeOffset| |
|140|The network bandwidth usage throttling rate must be between 1 Mbps and 10000 Mbps.|Specify a valid value.|
|141|Cannot perform *\<_InputParameterTag_>* because the replica isn't idle.|Wait for the ongoing job to complete or cancel the job.|
|143|If you use DPM to protect data on NETLOGON or SYSVOL shares on a domain controller, restoring the data using DPM will corrupt the domain controller's copy of the Active Directory Domain Services database.|No action required.|
|144|The backup frequency for long-term protection needs to be equal to or greater than the backup frequency for short-term protection.<br/><br/>Backup frequency for short-term protection: *\<_InputParameterTag_>*|No action required.|
|145|You can't reduce the express full backup schedule because it would affect the long-term recovery goals of this protection group.|Before you can reduce the express full backup schedule of this protection group, you must modify the protection group properties to specify a backup frequency that is equal to or greater than weekly.|
|146|The specified protection group name isn't valid. A protection group name must be between 1 and 64 characters, with at least one alphabet letter.|Specify a valid name.|
|147|To view the protected computers, you need to enable protection of these computers.|Enable protection.|
|148|You have chosen to protect replicas on another DPM server (primary DPM server).|We recommend that you protect the DPM database (DPMDB) of the primary DPM server along with the replicas. Without protecting the DPMDB, you won't be able to recover the replicas of the primary DPM server in case of a disaster where the DPMDB and the replicas are lost.|
|149|You have specified the change journal size on volume *\<VolumeName>* for <_ServerName_> to be set to *\<ValueEntered>*. However, it's greater than the available space on the selected computer.|Free space on the volume on the protected computer, and then retry the task.|
|150|You are trying to protect replicas on a primary DPM server.<br/><br/>File exclusions won't apply to these replicas, but they'll apply to all other protection group members.|No action required.|
|151|The size and used disk space information for *\<VolumeName>* on <_ServerName_> couldn't be retrieved. Disk space can't be allocated to protect data on this volume until this information is retrieved. Do you want to retry?|Retry the action.|
|152|DPM data source can't be added to the protection group because of existing settings.|Create a new protection group.|
|153|The size and used space information for *\<VolumeName>* on <_ServerName_> couldn't be retrieved. Disk can't be allocated to protect the data on this volume until this information is retrieved.| |
|154|The size and used space information for *\<VolumeName>* on <_ServerName_> couldn't be retrieved. Disk can't be allocated to protect the data on this volume until this information is retrieved.| |
|155|The size and used space information for *\<VolumeName>* on <_ServerName_> couldn't be retrieved. Disk can't be allocated to protect the data on this volume until this information is retrieved.| |
|156|The ability to add members to this protection group is temporarily disabled while initial synchronization of one or more members occurs.|Either cancel the initial synchronization jobs for the members or wait until they complete.|
|157|<_DatasourceName_> can't be added to protection because it's already a member of a protection group.|No action required.|
|158| *\<ValueEntered>* isn't a valid value. The maximum is *\<MaximumSizeUnit>*.|Specify a valid value.|
|159| *\<ValueEntered>* isn't a valid value.|Specify a valid value.|
|160|*\<ValueEntered>* doesn't meet the minimum allocation value of *\<OriginallyCalculatedValue>\<Unit>*.|Specify a valid value.|
|162|DPM can optimize its disk allocation recommendation by calculating the size of the selected data on *\<VolumeName>* on <_ServerName_>. Do you want to proceed?|Proceed to optimize.|
|164| *\<VolumeName>* on <_ServerName_> doesn't meet the minimum size requirement of 1 GB.|Don't select the volume.|
|168|The replicas for one or more of the volumes being protected are missing. It may be a result of one or more disks in the DPM storage pool being offline or the deletion of volumes created by DPM to store the replicas. You cannot modify disk allocation or configure protection for any members on these volumes until the replicas have been reallocated.|Select **Review Pending Members** in the protection group, and allocate disk space for protection.|
|169|Although you chose to retain the replica for this previously protected volume, the replica is now missing from the DPM server. Either the volume used to store the replica has been deleted from the storage pool, or the disk on which the replica was stored cannot be detected. You can't protect this previously protected volume until you delete the record of this replica from DPM.|Select the relevant member in the protection group and select **Remove inactive protection**. Make sure that **Delete replica on disk** is selected.|
|170|The requested changes to the protection group *\<ProtectedGroup>* will initiate an immediate consistency check on the following: *\<ListOfVolumes>*. <br/><br/>Do you want to apply the requested changes?| |
|171|There is insufficient space on the storage pool disks to allocate the replica and recovery point volumes.|This error can occur when you attempt to stop bare metal recovery (BMR) for a protection group. By default, when you stop only BMR, DPM tries to convert BMR protection to System State protection, which requires more space for system backup than BMR. If available space isn't sufficient to convert to System State protection, you'll receive this error. <br/><br/>If you stop BMR protection to gain more disk space, select Stop protection of member for both **Bare Metal Recovery** and **System State**. |
|172|The inputs aren't valid for custom scheme.|No action required.|
|173|You can't protect the selected database now. This database is already selected for protection as part of Windows SharePoint Services protection to which the database belongs.|If you want to protect only this database, then you have to remove the Windows SharePoint Services farm from protection.|
|174|You cannot protect the selected Windows SharePoint Services data now. Some of the databases which are components of the Windows SharePoint Services farm have already been selected for protection.|If you want to protect this Windows SharePoint Services data, you have to remove the databases from protection.|
|175|Existing volumes do not meet the size requirements for replica and recovery point volumes for <_DatasourceType_><_DatasourceName_> on <_ServerName_>.|Either use the DPM storage pool disks for protection or create volumes that are adequately sized. DPM will not use any volumes in which either operating system or DPM component is installed.|
|176|DPM failed to use the volume <_VolumeLabel_> to create the replica because it is not adequately sized.|Volumes to be used for the replica should be greater than <_MinimumSize_> GB.|
|177|DPM failed to use the volume <_VolumeLabel_> to create the recovery point volume because it is not adequately sized.|Volumes to be used for storing recovery points should be greater than <_MinimumSize_> GB.|
|178|DPM failed to use volume <_VolumeLabel_> since this has already been selected to protect <_DatasourceType_><_DatasourceName_> on <_ServerName_>.|No action required.|
|179|DPM cannot resize volumes <_VolumeLabel_> and <*VolumeLabel*>, which are being used to protect <_DatasourceType_><_DatasourceName_> on <_ServerName_> because these are custom volumes.|Use Disk Management to resize your volumes.|
|180|Failure to allocate disk space to the storage pool for storing the replica and the recovery points for <_VolumeName_> on <_ServerName_>. No protection will be initiated for <*VolumeName*> on <*ServerName*> until disk space has been allocated to the storage pool.|Select **Review Pending Members** for a protection group, and allocate disk space for protection.|
|181|DPM could not create <_ProtectedGroup_> because of failed disk allocations.|Refer to the allocation errors listed below, and then try to create the protection group again.|
|182|Eseutil consistency check cannot be performed for this protection group, because Eseutil.exe is not present on the DPM server.|Copy the Ese.dll and Eseutil.exe files from the Exchange Server installation folder to <_FolderPath_> on the DPM server.<br/><br/>You can also choose not to run an Eseutil consistency check for this protection group by clearing the **Run Eseutil Consistency check** option. However, we don't recommend this because it doesn't make sure of the recoverability of the protected data.|
|183|Select a single item for creating a recovery point on disk. You have currently selected multiple items in the list view.|No action required.|
|184|Cannot create a recovery point for the application data source because protection is stopped.|No action required.|
|186|DPM cannot use the volumes <_VolumeLabel_> for disk allocation as they are already in use by DPM. Specify a volume that is unallocated or used by DPM.| |
|185|There was a failure during recovery point consolidation.|Locate the relevant alert and resolve the issue. Then retry recovery.|
|192|The requested operation could not be completed because the replica was in an inconsistent state.|Run a consistency check, and then retry the operation.|
|193|Data source does not exist.| |
|194|PGIDNotFound| |
|195|Your changes cannot be applied because the protection group properties have changed. The protection group properties could have changed due to either of the following reasons:<ul><li>An auto discovery job ran and modified the properties of this protection group.</li><li>Another user is using DPM Administrator Console to modify the properties of this protection group.</li></ul>|Retry the operation.|
|196|IntentTranslationInProgress| |
|197|InvalidProtectedGroupSpec| |
|198|NotEnoughMediaInFreePool| |
|199|DPM was unable to protect the members in the resource group <_ObjectName_>. This resource group contains resources that have dependencies that are not part of this resource group.|<br/>1. Check your cluster configuration to make sure that the shares and the hard disks on which the shares reside are part of the same resource group.<br/>2. Check your cluster configuration to make sure that the application and the hard disks that it requires are part of the same resource group.|
|200|DPM could not perform the requested action on the selected items. This might be because one or more of the selected items or a property associated with the selected items has changed, which prevents the requested action.|Retry the operation.|
  
## Error codes 201-300

|Error code|Message|More information|
|---|---|---|
|201|DPM failed to protect the SQL database <_DatasourceName_> since this was part of the SharePoint Farm <_ReferentialDatasourceName_> which is either under active protection or has an inactive replica available.|To protect the SQL database, do either of the following: <ul><li> Rename the database and then protect it</li><li>Stop protection of the SharePoint farm and remove the replica associated with this farm. Then protect this database.</li></ul>|
|202|DPM could not recover the requested data.<br/><br/> The selected recovery point is no longer available for recovery.|Select another recovery point.|
|203|Recovery failed because the data source files have been moved since this recovery point was created.|<ul><li>Choose a recovery point created after the move operation.</li><li>Choose a different recovery type.</li></ul>|
|204|Maximum allowed frequency is 5 years.| |
|205|No tape labels have been specified; you need to specify tape labels for the identification of tapes.| |
|206|The specified retention range is invalid. <br/><br/>Specify a value for retention range which is equal to or less than 5148 weeks or 1188 months or 99 years.| |
|207|An unexpected error occurred on DPM server machine during a VSS operation.|Retry the operation.|
|208|No recovery point was created, either because synchronization has not occurred since the last recovery point was created, or because no changes were found during synchronization.|If synchronization has not occurred since the last recovery point was created, you can synchronize the replica with the protected data on the protected computer and then create a recovery point. For more information, see [How to synchronize a replica](/previous-versions/system-center/data-protection-manager-2010/ff399458(v=technet.10)) and [How to create a recovery point](/previous-versions/system-center/data-protection-manager-2010/ff399308(v=technet.10)) in [DPM Help](/previous-versions/system-center/data-protection-manager-2010/ff399540(v=technet.10)).|
|209|DPM has detected that files have been deleted or moved on the protected computer. You cannot recover using Recover to original location.|Select **Recover as virtual machine to any host** and select the original host computer as the destination.|
|210|DPM was unable to create the recovery point due to a general failure in the Volume Shadow Copy service.|<br/>1. Make sure that the Volume Shadow Copy service is enabled on the DPM server.<br/>2. Check recent records from the VolSnap source in the Application event log to find out why the problem occurred.<br/>3. Retry the operation.|
|211|Cannot create a recovery point because another recovery point creation is in progress.|Wait for a few minutes and then retry the operation.|
|212|Cannot delete recovery point because it is in use either for recovery or for backup to tape.|Wait for all recovery jobs on the replica and backup to tape jobs to complete and then retry the operation.|
|213|A recovery point was created and immediately deleted because of insufficient disk space.|Modify disk allocation to increase space allocation for the recovery point volume.|
|214|DPM does not have sufficient storage space available on the recovery point volume to create new recovery points.|Ensure there are no pending recovery point volume threshold alerts active for this data source and rerun the job. DPM may have automatically grown the volume and resolved the alerts.|
|215|Cannot create a recovery point because of a transient problem.|<br/>1. To find out why the problem occurred, check recent records from the VolSnap source in the Application event log.<br/>2. Retry the operation.|
|218|You must specify the e-mail addresses of the recipients to send notifications.| |
|219|You must specify the SMTP server settings before you can subscribe to notifications.|To configure settings, on the **Action** menu, select **Options**. Select the **SMTP Server** tab.|
|220|DPM cannot enable e-mail subscription for reports unless SMTP details are configured in the remote SQL Server Reporting Service installation. SMTP details need to be configured manually when an existing SQL Server is chosen to be used for DPM during DPM setup.<br/><br/>Enter the SMTP server name, SMTP port number, and SMTP From address manually in the SQL Server Reporting Services configuration file.<br/><br/>Configuration file path: <_FileName_> <br/><br/>Server: <_ServerName_> <br/><br/>The SMTP Server details on the SMTP Servers tab in the Options dialog enables only DPM alert notifications. For more information, see DPM Help.| |
|221|<_UserName_> does not have administrator privileges on the DPM Server.|Add the user to the Administrators group or use a different administrator username and try again.|
|222|DPM cannot browse <_ServerName_> because access is denied.|On the **Agents** tab in the **Management task** area, check the status of the agent. Also, verify that the system times on the DPM server and the protected computer are synchronized with the system time on the domain controller.|
|223|DPM cannot browse <_ServerName_> because the agent is not responding.|<br/>1. To find out why the agent failed to respond, check recent records from the DPMRA source in the Application event log on <*ServerName*>.<br/>2. Make sure that the DPM server is remotely accessible from <*ServerName*>.<br/>3. If a firewall is enabled on the DPM server, make sure that it is not blocking requests from <*ServerName*>.<br/>4. Restart the DPM Replication Agent service on <*ServerName*>. If the service fails to start, reinstall the protection agent.|
|224|DPM cannot browse <_ServerName_> either because no agent is installed on <*ServerName*>or because the computer is rebooting.|<br/>1. Make sure that <*ServerName*> is remotely accessible from the DPM server.<br/>2. If a firewall is enabled on <*ServerName*>, make sure that it is not blocking requests from the DPM server.<br/>3. Restart the DPM Replication Agent service on <*ServerName*>. If the service fails to start, reinstall the protection agent.|
|225|DPM cannot browse <_ServerName_> either because no agent is installed on <*ServerName*> or because the computer is rebooting.|To install a protection agent on <*ServerName*>, in the **Management task** area, on the **Agents** tab, select **Install** in the **Actions** pane. If the computer is in the process of restarting, allow some time for the computer to come online.|
|226|RrNodeMissing| |
|227|DPM cannot access <_FileName_> because the file or folder has been exclusively locked by another program.|Make sure that the item is not locked by another process.|
|229|DPM failed to access the path <_FileName_>.|Verify that the path can be accessed successfully by using Windows Explorer.|
|231|RrShadowCopyMissing| |
|232|Only %MaxListItemsInBrowseView; of the items in <_ObjectName_> can be displayed. Either select <*ObjectName*> for recovery or use the Search tab to find specific items to recover.| |
|233|You have specified the same library for both primary library and copy library.<br/><br/>The library you select as the primary library will read from the source tape and the library you select as the copy library will copy the data to tape.<br/><br/>Specify two different libraries or specify a multi-drive library as a primary library.| |
|234|You have selected a library that doesn't contain the online recovery tapes. The library that contains online recovery tapes is shown as recommended.<br/><br/>If you don't select the recommended library, ensure that you transfer the recovery tapes to the selected library after you finish the recovery wizard.| |
|235|No library is available for recovery to proceed.|To bring libraries online, from the **Library** tab in **Management**, select **Rescan**.|
|236|DPM will look for your recovery tapes only in the selected library. Ensure that you load the tapes required for recovery to this selected library.| |
|237|You have chosen to recover the 'Latest' recovery time.<br/><br/>For Exchange mailbox recovery, DPM supports only the **Previous point in time** recovery option.<br/><br/>For the selected mailbox, it is <_Recovery Point Timestamp_>.| |
|238|<_ServerName_> cannot be used as a destination for recovery because it has not been restarted since the protection agent was installed.|Restart <*ServerName*> and then try the recovery operation again.|
|239|<_ServerName_>is not protected. You can filter the list only by computers and data sources that have been protected.| |
|241|The volume <_VolumeName_> on <_ServerName_> is not currently protected.| |
|242|The share "<_ObjectName_>" on <_ServerName_> is not currently protected.|Make sure that the share name and computer name are accurate.|
|243|You must configure your SMTP server settings before you can use notifications.|From the **Action** menu, select **Options**. Then select the **SMTP server** tab to configure settings.|
|244|This volume is currently not protected.| |
|245|You must specify the e-mail addresses of users whom you want to notify about this recovery operation.|In the Recipients box on the Recovery tab, type the e-mail addresses.|
|246|You must install agents on one or more servers before you can recover files.|To install an agent, select the **Management task** area, select the **Agents** tab, and in the **Actions** pane select **Install**.|
|247| <_InputPath_> is not a valid network path. You must specify a path in the \\\server\share format. No wildcards are allowed.| |
|248| <_InputPath_> is not a valid local path. You must specify a path such as *d:\\*, _d:\folder_. No wildcards are allowed.| |
|252|You are attempting to recover an object that contains a mount point.| |
|249|<_InputName_> is not a valid file or folder name. Make sure that the file name is correct and that the path is entered only in the appropriate Original location field.| |
|250|Any recovery point or synchronization jobs that are running, or are scheduled to run in the next 10 minutes, on the volumes from which the data is being recovered will be canceled. Do you want to continue?| |
|251|You are browsing to a mount point.| |
|252|You are attempting to recover an object that contains a mount point.| |
|253|If you create a recovery point now, the oldest recovery point will be deleted and cannot be restored. Do you want to continue?| |
|254|DPM did not run the recovery successfully.|Retry recovery.|
|255|The selected recovery point no longer exists.| |
|256|CmdProcHostUnreachable| |
|257|CmdProcAccessDenied| |
|258|CmdProcResponseTimeout| |
|259|CmdProcCommunicationError| |
|260|CmdProcNotInstalled| |
|260|CmdProcNotInstalled| |
|262|CmdProcAgentTooOld| |
|263|HASH(0x2f3b33c)| |
|264|HASH(0x2f3b98c)| |
|265|DPM encountered an error while reading from the recovery point used for recovery. Either the recovery point no longer exists or, if you selected a share for recovery, the path to its contents is missing from the recovery point.|Recover the data from another recovery point.|
|266|HASH(0x2f41ddc)| |
|267|The following computers do not meet the minimum software requirements for installing the DPM protection agent: <_List of Servers_>|If the operating system has been recently updated, Active Directory updates may still be pending. Wait until the Active Directory updates are complete, and then try to install the protection agent again. The time needed for Active Directory updates depends on your Active Directory domain replication policy.<br/><br/>For more information about software requirements, see [DPM 2010 System Requirements](/previous-versions/system-center/data-protection-manager-2010/ff399554(v=technet.10)?redirectedfrom=MSDN).|
|268|HASH(0x2f3dabc)| |
|269|The Shadow Copy that you were operating on has been deleted.| |
|270|The agent operation failed on <_ServerName_> because DPM could not communicate with the DPM protection agent. The computer may be protected by another DPM server, or the protection agent may have been uninstalled on the protected computer.<br/><br/>If <*ServerName*> is a workgroup server, the password for the DPM user account could have been changed or may have expired.|To troubleshoot this issue, check the following:<ol><li> If the agent is not installed on <*ServerName*>, run DpmAgentInstaller.exe with this DPM computer as a parameter. For details, see the [DPM Deployment Guide](/previous-versions/system-center/data-protection-manager-2010/ff399163(v=technet.10)). </li><li>To attach the computer correctly to this DPM server, run the SetDpmServer tool with the `-Add` option on the protected computer.</li><li>If the computer is protected by another DPM server, or if the protection agent has been uninstalled, remove the protected data sources on this computer from active protection. Then, remove the entry of this computer from the **Agents** tab in the **Management** task area.</li><li>If <*ServerName*> is a workgroup server, run `SetDpmServer` with the `-UpdatePassword` flag on the protected computer and `Update-NonDomainServerInfo.ps1` on the DPM server to update the password.</li><li> If the DPM server and the protected computer are not in the same domain, ensure that there is a two-way trust setup between the two domains.</li></ol>|
|271|The user <_UserName_> does not have administrator access to the following items: <_ServerName_>|Remove the computers from the **Select Computers** page, or provide credentials for an account that has administrator access to all of the selected computers.|
|272|Work hours are not valid. Specify valid work hours.| |
|273|Alias or Display name cannot be empty or contain any of the following characters <_InputName_>.|Specify valid names to search.|
|274|Unable to configure security settings for <_ServerName_> on the computer <_ComputerName_>.|Make sure that the user name and password you have provided has administrator permissions on the target computer.|
|275|Unable to remove <_ServerName_> from the security group on <_ComputerName_>.|Make sure that the user name and password you have provided has administrator permissions on the target computer.|
|276|A site, document, list or list-item cannot be empty or contain any of the following characters <_InputName_>.|Enter a valid value to search.|
|277|Could not connect to the Service Control Manager on <_ServerName_>.|<br/>1. Make sure that <*ServerName*>is online and remotely accessible from the DPM server.<br/>2. If a firewall is enabled on <*ServerName*>, make sure that it is not blocking requests from the DPM server.|
|278|Unable to connect to the Active Directory Domain Services database.|Make sure that:<br/>1. Server is a member of a domain and that a domain controller is running.<br/>2. There is network connectivity between the server and the domain controller.<br/>3. The **File and Printer sharing for Microsoft Networks** property is enabled in **Local Area Connection**.|
|290|The protection agent could not be removed from <_ServerName_>. The computer may no longer have an agent installed or may no longer be in the domain. You may need to remove this record from the DPM database, and then uninstall the agent from the computer using Add/Remove Programs.<br/><br/>Remove the DPM record from the DPM database?| |
|291|The protection agent installation failed. The credentials you provided do not have administrator privileges on <_ServerName_>.|Verify that the credentials you provided have administrator permissions on <*ServerName*> and then try to reinstall the protection agent again.|
|292|You cannot uninstall protection agents from the protected computers until you remove all protected members on the associated computers from protection groups.|Remove all of the members that are associated with the following computers from protection groups before uninstalling the protection agents: <_ListofServers_>. |
|293|The protection agent operation failed. The credentials you provided do not belong to a valid domain user account.|To troubleshoot this issue, follow these steps: <ol><li> Verify that the credentials you entered belong to a valid domain user account, and then retry the operation.</li><li> Verify that the domain controller is available and functioning properly.</li></ol> |
|294|The protection agent installation or upgrade succeeded. However, DPM could not remove the bootstrap service.|You must restart the protected computer <_ServerName_> before it can be protected.|
|295|DPM could not remove the Protection Agent Coordinator service from <_ServerName_> or prerequisites are missing.|<br/>1. Use **Add or Remove Programs** in Control Panel to uninstall the DPM Agent Coordinator service on <*ServerName*>.<br/>2. Verify that VCRedist 2012 is installed on <*ServerName*>. If it's not installed, install it from the DPM install directory.<br/>3. Verify that .NET Framework 4.0 is installed on <*ServerName*>. If it's not installed, install it from the DPM install directory.|
|296|Failed to update protection agent, error: Data Protection Manager Error ID: 296|Update the protection agent to a version that is compatible with the DPM server. In the DPM Administrator Console, select the **Agents** tab in the **Management** task area. Select the computer on which the protection agent is installed, and then in the **Actions** pane, select **Update**.|
|297|The protection agent is incompatible with the version of DPM that is installed on this computer. All subsequent protection and recovery tasks will fail on this computer until you reinstall the correct version of the protection agent.|Uninstall the protection agent from this computer and then reinstall the protection agent.|
|298|Recovery failed for <_DatasourceType_><_%DatasourceName_> on <_ServerName_>.|Recover to an alternate location or try recovering from another recovery point.|
|299|For %DatasourceType; %DatasourceName; on <_ServerName_>, the following items could not be recovered: <_TempListOfFiles_>.|Make sure that the file is not already present and in use on the destination computers and that there is sufficient disk space for the files.|
|300|The protection agent operation failed because it could not communicate with <_ServerName_>.|To troubleshoot this issue, do the following: <ol><li>Verify that <*ServerName*> is online and remotely accessible from the DPM server.</li><li> If a firewall is enabled on <*ServerName*>, verify that it is not blocking requests from the DPM server. </li><li> Verify that Internet Protocol Security (IPsec) is configured on both the DPM server and the protected computer. If IPsec is only configured for one computer, turn off IPsec.</li></ol> |
  
## Error codes 301-400

|Error code|Message|Additional information|
|---|---|---|
|301|The protection agent upgrade failed because the protection agent is not installed on <_ServerName_>.|<br/>1. In DPM Administrator Console, in the **Management** task area, on the **Agents** tab, select the computer on which the protection agent is installed, and then in the **Actions** pane, select **Uninstall** to remove the protection agent record.<br/>2. On the **Agents** tab, select **Install** to reinstall the agent on <*ServerName*>.|
|302|The protection agent operation failed because it could not access the protection agent on <_ServerName_>. <*ServerName*> may be running DPM, or the DPM protection agent may have been installed by another DPM server.|Uninstall DPM or the DPM protection agent from<*ServerName*>and install the DPM protection agent again from the computer that you want to use to protect the computer.|
|303|The protection agent operation failed on <_ServerName_>.|<ul><li>Another installation is running on the specified server.<br/><br/> **Resolution**: Wait for the installation to complete, and then retry the operation.</li> <li>The boot volume on the server is formatted as file allocation table (FAT).<br/><br/> **Resolution**: Convert the boot volume to NTFS file system if you have sufficient space.</li></ul> |
|304|The protection agent operation failed because another agent operation was running on <_ServerName_>.|Wait for the protection agent operation on <*ServerName*> to finish, and then try reinstalling the protection agent again.|
|305|The agent operation failed because the operating system on <_ServerName_> is not supported.|Verify that the operating system is Windows Server 2003 Service Pack 1 (SP1) or later on the selected computers. If the operating system has been recently updated, Active Directory updates may be pending. In this case, wait until Active Directory is finished updating, and then try installing the protection agent again. The time required for Active Directory updates depends on your domain Active Directory replication policy.<br/><br/>For more information about software requirements, see [DPM 2010 System Requirements](/previous-versions/system-center/data-protection-manager-2010/ff399554(v=technet.10)?redirectedfrom=MSDN).|
|306|The protection agent installation failed because another version of the protection agent is already installed on <_ServerName_>.|The protection agent installation failed because another version of the protection agent is already installed on the DPM server.<br/><br/> **Resolution**: Use **Add or Remove Programs** in Control Panel to uninstall the protection agent from the DPM server, and then try reinstalling the protection agent.|
|307|The protection agent operation failed because DPM detected an unknown DPM protection agent on <_ServerName_>.|Use **Add or Remove Programs** in Control Panel to uninstall the protection agent from <*ServerName*>, then reinstall the protection agent and perform the operation again.|
|308|The protection agent operation failed because DPM could not communicate with the Protection Agent service on <_ServerName_>.|If you recently installed a protection agent on <*ServerName*>, the computer may be restarting. Wait a few minutes after restarting the computer for the protection agent to become available.<br/><br/>If the problem persists, follow these steps: <ol><li>Verify that <*ServerName*> is remotely accessible from the DPM server. </li><li>If a firewall is enabled on <*ServerName*>, verify that it is not blocking requests from the DPM server.</li><li>If <*ServerName*> is a workgroup server, the password for the DPM user accounts may have changed or expired. To resolve this error, run `SetDpmServer` with the `-UpdatePassword` flag on the protected computer and `Update-NonDomainServerInfo.ps1` on the DPM server.</li><li>Restart the DPM Protection Agent service on <*ServerName*>. If the service doesn't start, uninstall the protection agent by using **Add or Remove Programs** in Control Panel on <*ServerName*>. Then in the **Management** task area, on the **Agents** tab, in the Actions pane, select **Install** to reinstall the protection agent on <*ServerName*>.</li></ol> |
|309|The agent operation failed because the ADMIN$ share on <_ServerName_> does not exist.|Verify that the system root is shared as ADMIN$ on <*ServerName*>.|
|310|The agent operation failed because it could not access the ADMIN$ share on <_ServerName_>.|Verify that you have ADMIN$ share permissions on <*ServerName*>, and that the system time on the DPM server and <*ServerName*> is synchronized with the system time on the domain controller.|
|311|The DPM protection agent on <_ServerName_> is not working properly.|To resolve this error, do the following:<ul><li>If the agent is not installed on <*ServerName*>, run **DpmAgentInstaller.exe** and use the name of this DPM computer as a parameter. For information about the DPM protection agent, see [Deploy the DPM protection agent](/system-center/dpm/deploy-dpm-protection-agent).</li><li>In DPM Administrator Console, uninstall the DPM protection agent. In the **Management** task area, on the **Agents** tab, select the protection agent, and then in the **Actions** pane, select **Uninstall**.</li></ul> |
|312|The agent operation failed because the DPM Agent Coordinator service is not responding.|Restart the DPM Agent Coordinator service on <_ServerName_>.|
|313|The agent operation failed because an error occurred while running the installation program on <_ServerName_>.|Review the log files on <*ServerName*>, such as %windir%\temp\msdpm*.log, and then take appropriate action. Retry the operation. If the error persists, restart the computer and then try the operation again.|
|314|The agent operation failed because an installation is already in progress on <_ServerName_>.|Wait for the installation to complete, and then retry the agent operation.|
|315|The agent operation failed because server <_ServerName_> is part of a cluster. DPM does not support protection of clustered servers.|No user action is required.|
|316|The protection agent operation on <_ServerName_> failed because the service did not respond.|If you recently installed a protection agent on <*ServerName*>, the computer may be restarting. Wait a few minutes after restarting the computer for the protection agent to become available.<br/><br/>Otherwise, to resolve this error, do the following: <ol><li> Check the recent records from the DPMRA source in the Application Event Log on <*ServerName*> to find out why the agent failed to respond. </li><li> Verify that the DPM server is remotely accessible from <*ServerName*>.</li><li>If a firewall is enabled on the DPM server, verify that it is not blocking requests from <*ServerName*>.</li><li>If <*ServerName*> is a workgroup computer configured to use NETBIOS, make sure that the NETBIOS name of the DPM server is accessible from <*ServerName*>. Otherwise verify that the DNS name is remotely accessible.</li><li> If <*ServerName*> is a workgroup server, make sure that the DPM server has an IPSEC exception to allow communication from workgroup servers.</li><li>If <*ServerName*> is a workgroup server the password for the DPM user accounts could have been changed or may have expired. To resolve this error, run `SetDpmServer` with the `-UpdatePassword` flag on the protected computer and `Update-NonDomainServerInfo.ps1` on the DPM server.</li><li> Restart the DPM Protection Agent service on <*ServerName*>. If the service does not start, reinstall the DPM protection agent.</li></ol> |
|317|The protection agent installation failed because the files needed to install the protection agent (version <_AgentVersion_>) are missing from the <_ServerName_> DPM server.|Reinstall the missing files by running DPM Setup and DPM updates.|
|318|The agent operation failed because DPM was unable to identify the computer account for <_ServerName_>.|Verify that both <*ServerName*> and the domain controller are responding. Then, in Microsoft Management Console (MMC), open the Group Policy Object Editor snap-in for the local computer, and verify the local DNS client settings in **Local Computer Policy\Computer Configuration\Administrative Templates\Network\DNS Client**.|
|319|The agent operation failed because of a communication error with the DPM Agent Coordinator service on <_ServerName_>.|To resolve this error, do the following:<ol><li>If the protected computer is running a localized version of Windows Server 2003 SP1, first upgrade the operating system to Windows Server 2003 SP2.</li><li>On the protected computer, download and install the appropriate localized hotfix in article [975759](https://support.microsoft.com/help/975759), and then try the upgrade again.</li></ol><br/>**Note**<br/>The **Hotfix Download Available** form displays the languages for which the hotfix is available.|
|320|The agent upgrade failed because the protection agent is not installed on <_ServerName_>.|In DPM Administrator Console, in the **Management** task area, on the **Agents** tab, select **Uninstall** to remove the agent record from DPM. Then select **Install** to reinstall the agent on <*ServerName*>.|
|321|The selected servers will reboot immediately after the agents have been installed.<br/><br/>Are you sure that you want to install agents on these servers?|No user action is required.|
|322|The following computers <_ListofServers_> were not found in Active Directory Domain Services, or they do not have a Windows Server operating system installed.|To resolve this error, do the following:<ol><li>Check the spelling of the computer name.</li><li>Verify that Windows Server 2003 with Service Pack 1 or later is installed on the computer.</li><li>Verify that you entered the fully qualified domain name for the computer.</li><li>If the computer has recently been added to the domain, you may need to wait for Active Directory to update.</li><li>If the computer was recently restarted, wait a few moments and then retry the agent operation again.</li><li>Verify that a two-way trust is enabled between the domain that the selected computer belongs to and the DPM server's domain, and that the trust is of type forest.</li></ol> |
|323|Upgrading the protection agents will cause the backup jobs that are running on the protected computers to fail. Upgrading the protection agents may also cause the replicas of the protected data to become inconsistent. You may need to schedule a consistency check after the upgrade is complete. Click Yes to continue.|No user action is required.|
|324|The agent operation failed because the DPM Agent Coordinator service on <_ComputerName_> did not respond.|To troubleshoot this issue, do the following:<br/>1. Check the recent DPMAC source records in the application event log on <*ComputerName*>.<br/>2. Verify that the DPM server is remotely accessible from <*ComputerName*>.<br/>3. If a firewall is enabled on the DPM server, verify that it is not blocking requests from <*ComputerName*>.<br/>4. Verify that the time on the DPM server and the selected computer is synchronized with the domain controller. At a command prompt, type `net time /set` to synchronize the time with the domain controller.<br/>5. Based on which agent operation you were performing before you received the error, do the following:<ul><li>**If you were installing an agent by using DPM Management Console, follow this step:** <br/><br/>On the targeted computer, install the protection agent manually, and then add the computer to the DPM server. For step-by-step instructions, see [Installing Protection Agents Manually](/previous-versions/system-center/data-protection-manager-2010/ff399459(v=technet.10)?redirectedfrom=MSDN).<br/> </li><li>**If you were uninstalling an agent by using DPM Management Console, follow these steps:** <ol><li>On the targeted computer, in Control Panel, navigate to **Programs and Features**.</li><li>In the programs list, right-click **Microsoft Data Protection Manager 2010 Agent**, and then select **Uninstall**.</li><li>On the DPM server, open DPM Management Shell.</li><li> At the command line, type `RemoveProductionServer.ps1`, and then press Enter to remove the targeted computer from the DPM server.</li><li>When prompted, type the DPM server name, press Enter, type the name of the computer that you want to remove, and then press Enter again.</li></ol></li><li>**If you were upgrading an agent by using DPM Management Console, follow these steps:** <ol><li>Copy the 32-bit or 64-bit version of the DPMAgentInstaller.exe file to a network share that is accessible from the computer on which you want to upgrade the agent.</li><li> On the targeted computer, navigate to the network share, right-click **DPMAgentInstaller.exe**, and then select **Run as administrator**.</li><li> On the DPM server, open DPM Administrator Console, on the navigation bar, select **Management**, and then select the **Agents** tab.</li><li> In the **Details** pane, select the targeted computer, and then, in the **Actions** pane, select **Refresh information**.</li></ol></li></ol>|
|325|The agent operation failed because the protection agent is not active until you restart the selected computers.|Restart the selected computers.|
|326|The protection agent operation failed because access was denied to the <_ServerName_> DPM server.|To resolve this error, do the following:<ol><li>If <*ServerName*> is protected by another DPM server, you cannot install the protection agent on it.</li><li>If the DPM Agent Coordinator service is installed on <*ServerName*>, use **Add or Remove Programs** in Control Panel on <*ServerName*> to uninstall it.</li><li>If another protection agent management job is running on <*ServerName*>, wait for it to complete, and then retry the operation.</li></ol>|
|327|AMRemoteACNotInstalled| |
|328|The agent operation failed because the Remote Registry service is not running on <_ServerName_>.|Start the Remote Registry service on <*ServerName*>. On the **Administrative Tools** menu, select **Services**. In the right pane, right-click **Remote Registry**, and then select **Start**.<br/><br/> **Note**<br/>You can disable the Remote Registry service after the agent operation is complete.|
|329|The agent operation failed because an incompatible version of <_Name_> is installed on <_ServerName_>.|Install <*Name*> version <_Version_> or later, or uninstall <*Name*> from the computer. If <*Name*> was installed by your original equipment manufacturer (OEM), contact your OEM support for instructions.|
|330|The agent operation failed because the Windows Installer service on <_ServerName_> is disabled.|Start the Windows Installer service on <*ServerName*>. On the **Administrative Tools** menu, select **Services**. In the right pane, right-click **Windows Installer**, and then select **Start**.<br/><br/>You can disable the Windows Installer service after the agent operation has completed.|
|331|The agent operation was skipped because similar operation is already running on <_ServerName_>.|Wait for the other operation to finish and then retry the operation.|
|333|A protection agent is already installed on <_ServerName_>.|No user action is required.|
|334|You cannot install the protection agent on <_ServerName_> because it is the DPM server.|No user action is required.|
|335|Installing a protection agent on a computer that is running Windows 2003 Server causes the computer to briefly lose network connectivity.|No user action is required.|
|336|The protection agent uninstall is unavailable because the DPM server is currently communicating with the protection agent on the following protected computers: <_ListofServers_>.|Wait a few moments and then try uninstalling the protection agent again.|
|337|You cannot install the protection agent on <_ServerName_> because access to the computer has been denied.|To resolve this error, do the following: <ol><li>If another DPM server is currently protecting <*ServerName*> use that DPM server to uninstall the protection agent from <*ServerName*>. Then, use this DPM server to install the protection agent on <*ServerName*>.</li><li>Verify that the time on the DPM server and the selected computer is synchronized with the domain controller. At a command prompt, type `net time /set` to synchronize the time with the domain controller.</li><li>If the computer is a domain controller, verify that the primary domain controller (the PDC Emulator) is running Windows Server 2003 with Service Pack 1 (SP1), and that Active Directory has completed replication between the domain controllers since the Windows Server 2003 SP1 installation.</li></ol>|
|338|You can only select <_MaxInstallServers_> computers to install at a time.|Select fewer than <*MaxInstallServers*> computers to add to the **Selected Computers** list.|
|339|AMFilterManagerMissing| |
|340|The protection agent upgrade failed because <_ServerName_> has a more recent version of the protection agent (version <_AgentVersion_>) installed.|Uninstall the existing DPM protection agent from <*ServerName*> using **Add or Remove Programs** in Control Panel. Then, in DPM Administrator Console, reinstall the DPM protection agent version that you want. In the **Management** task area, on the **Agents** tab, select **Install** in the **Actions** pane.|
|341|The agent operation failed because the credentials you provided do not have sufficient user rights on <_ServerName_>.| **Possible Issue 1** <br/><br/>The account that is used does not have sufficient user rights and permissions on the server.<br/><br/> **Resolution:** Retry the agent operation and provide credentials that have administrator user rights on the DPM server.<br/><br/> **Possible Issue 2** <br/><br/>The system times of the DPM server, the server on which you are installing the agent, and the domain controller are not synchronized; therefore the Kerberos authentication fails.<br/><br/> **Resolution:** Verify that system times on the DPM server and the server on which you are installing the agent are synchronized with the system time on the domain controller.<br/><br/> **Possible Issue 3** <br/><br/>The DNS setting on the DPM server or the computer on which you are installing the protection agent is incorrect.<br/><br/> **Resolution:** Verify that the DNS settings are correct.|
|342|The agent operation failed because the DPM server could not communicate with <_ServerName_>.|To resolve this error, do the following:<br/>1. Verify that <*ServerName*> is online and remotely accessible from the DPM server.<br/>2. If a firewall is enabled on <*ServerName*>, verify that it is not blocking requests from the DPM server.<br/>3. Verify that the Remote Registry service on <*ServerName*> is running during the protection agent operation. If the Remote Registry service is not started, on the **Administrative Tools** menu, select **Services**. In the right pane, right-click **Remote Registry**, and then select **Start**. <br/><br/>**Note**<br/>You can disable the service after the protection agent operation is complete.|
|343|The agent operation failed because <_ServerName_> is not a 32-bit x86-based computer or a 64-bit x64-based computer.|No user action is required.|
|344|DPM could not find the correct version of the DPM protection agent on the selected computer.|To resolve this error, do the following:<ol><li>Make sure that the correct version of the agent is installed on the selected computer.</li><li>If the protection agent has been recently upgraded, in DPM Management Shell, run `Attach-ProductionServer.ps1 <Computer Name>`, and then refresh the agent status again.|
|345|The agent operation failed because of a communication error with the DPM Agent Coordinator service on <_ServerName_>.|Restart the DPM Agent Coordinator service on <*ServerName*>, and then try to reinstall the protection agent.|
|346|DPM is unable to retrieve the configuration information from <_ServerName_>.|Make sure that the Windows Management Instrumentation (WMI) service is started. If the firewall is turned on, on <*ServerName*> make sure that an exception for WMI is created.|
|347|An error occurred when the agent operation attempted to create the DPM Agent Coordinator service on <_ServerName_>.|To resolve this issue, do the following:<br/>- Verify that the DPM Agent Coordinator service on <*ServerName*> is responding, if it is present. Review the error details, take the appropriate action, and then retry the agent installation operation.<br/>- Try installing the protection agent manually on the targeted computer. For more information, see [Installing Protection Agents Manually](/previous-versions/system-center/data-protection-manager-2010/ff399459(v=technet.10)?redirectedfrom=MSDN).<br/>- If the targeted computer is running Windows Server 2008, on the targeted computer, do the following: <ol><li>Download and manually install the hotfix described in article [975759](https://support.microsoft.com/help/975759).</li><li>Resolve any errors that you receive during the installation of the hotfix. If you receive the error, **The service cannot be started, either because it is disabled or because it has no enabled devices associated with it**, do the following:<ol><li>In **Service Manager**, expand **Configuration**, and then select **Services**.</li><li>In the **Services** pane, right-click **Windows Update**, and then select **Properties**.</li><li>In the **Windows Update Properties** dialog box, in the **Start-Up type** list, select **Manual**, select **Apply**, and then, in the **Service** status area, select **Start**.</li><li>Retry the agent installation operation.</li></ol></li></ol>|
|348|An error occurred when the agent operation attempted to communicate with the DPM Agent Coordinator service on <_ServerName_>.| **Possible Issue 1** <br/><br/>An error occurred when the agent operation attempted to communicate with the DPM Agent Coordinator service on the DPM server.<br/><br/> **Resolution:** Verify that the Agent Coordinator service on the DPM server is responding, if it is present. Review the error details, take the appropriate action, and then retry the agent operation.<br/><br/> **Possible Issue 2** <br/><br/>Incorrect security settings for the COM object on the computer.<br/><br/> **Resolution:** Verify COM permissions on the server. Verify that the DCOM configuration settings are set as follows:<br/><br/> **COM Security Default Access Permissions** <br/>- Local Access and Remote Access permitted to Self<br/>- Local Access permitted to System<br/><br/> **COM Security Machine Access Restriction (Security Limits)** <br/>- Local and Remote Access permitted to NT AUTHORITY\ANONYMOUS LOGON<br/>- Local and Remote Access permitted to BUILTIN\Distributed COM Users<br/>- Local and Remote Access permitted to \Everyone<br/><br/> **COM Security Default Launch Permissions** <br/>- Launch permitted to NT AUTHORITY\SYSTEM<br/>- Launch permitted to NT AUTHORITY\INTERACTIVE<br/>- Launch permitted to BUILTIN\Administrators<br/><br/> **COM Security Machine Launch Restriction (Security Limits)** <br/>- Local Launch and Activate permitted to \Everyone<br/>- Local and Remote Launch, Local and Remote Activate permitted to BUILTIN\Administrators<br/>- Local and Remote Launch, Local and Remote Activate permitted to BUILTIN\Distributed COM Users|
|349|An error occurred when the agent operation attempted to transfer agent installation files to <_ServerName_>.|Review the error details, take the appropriate action, and then retry the agent operation.|
|350|Disk <_NTDiskNumber_> is already in the storage pool.|Select a different disk to add to the storage pool.|
|351|Disk <_NTDiskNumber_> cannot be added to the storage pool.|Make sure that the disks being added to the storage pool do not contain any of the following: system volume, boot volume, OEM or other special volumes, DPM software, or SQL Server databases.|
|352|Disk <_NTDiskNumber_> cannot be added to the storage pool because the disk either failed or is missing.|Check Disk Management to see whether the disk is online. If the disk is offline, check the hardware configuration and then rescan. If the disk is greater than 2 TB in size, make sure that it is a GUID Partition Table (GPT) disk.|
|353|The protection agent upgrade is unavailable because the DPM server is currently communicating with the protection agents on the following protected computers: <_ListofServers_>.|Wait a few moments and then try upgrading the protection agent again.|
|354|Disk <_NTDiskNumber_> is not listed in the storage pool.|In the **Management** task area, on the **Disks** tab, select **Rescan** to refresh all disks that are in the DPM storage pool.|
|355|Disk <_NTDiskNumber_> cannot be removed from the storage pool because it contains storage pool volumes.|No user action is required.|
|356|The folder on which the <_VolumeUsage_> volumes must be mounted already exists.|Clear all unmounted directories from the <_DlsVolumesRoot_> directory, and then retry the operation.|
|358|The allocation of disk space for storage pool volumes failed because there is not enough unallocated disk space in the storage pool.|Add more disks to the storage pool or reduce the volume size requirement.|
|359|InvalidMountPointName| |
|360|The operation failed due to a virtual disk service error.|Retry the operation.|
|361|Disk <_NTDiskNumber_> was not added to the storage pool because it could not be converted to a dynamic disk.|For more information about supported disk types, see the DPM 2010 Deployment Guide.|
|362|The replica cannot be increased because the replica volume is missing.|Reallocate the replicas before trying to increase them.|
|363|VolumeSetNotPresent| |
|364|DPM encountered an unexpected error while performing a disk related operation.|Make sure that the Virtual Disk Service is running correctly, and then retry the operation.|
|365|DPM is currently shutting down and cannot complete the requested operation.|After DPM shuts down, restart DPM and then retry this operation.|
|366|The computer running DPM has deleted volume [<_VolumeGuid_>, <_VolumeLabel_>] from DPM disk <_NTDiskNumber_> because it was not a volume in the DPM storage pool.|In the **Management** task area, on the **Disks** tab, review all disks that are in the DPM storage pool.|
|367|DpmSync has completed with the following errors: <_DPSSyncSummary_>.|On the DPM server, use Event Viewer to view details for this event. The details are available in the application event log.|
|368|DPM has deleted volume [<_VolumeGuid_>, <_VolumeLabel_>] because the size of the volume was modified externally by using system tools.|Do not use system tools to change the size of volumes on disks that are in the DPM storage pool.|
|369|A protection agent is not installed on <_Node_> in the <_Cluster_> server cluster. Protection may fail if a failover occurs to <*Node*>.|Install a protection agent on each node of the server cluster.|
|370|Agent operation failed.|No user action is required.|
|371|All protection and recovery jobs on _ServerName_ will fail until the agent is re-enabled.<br/><br/>Do you want to proceed?|No user action is required.|
|372|The agent operation failed because DPM detected a more recent version of the DPM protection agent (version <_AgentVersion_>) on <_ServerName_>.|Upgrade the DPM server to <*AgentVersion*> or install the protection agent of <_LocalDPMVersion_> on <*ServerName*>.|
|373|The computer <_ServerName_> hosts the SQL Server database for this DPM computer. If the operating system of <*ServerName*> is Windows Server 2003, installing the agent may require you to reboot the computer. The DPM Engine and DPM Administrator Console will not work until the reboot completes. Do you want to install the protection agent?|No user action is required.|
|400|The DPM server was unable to retrieve information about the remote system using the Windows Management Instrumentation (WMI) service on <_ServerName_>.|To resolve this error, do one of the following:<br/>- From the command prompt, type `DPMAgentInstaller.exe <dpmservername>` to install the protection agent on the protected computer. Then attach the protection agent to the DPM server by using the Protection Agent Installation Wizard. Verify the following:<ul><li><*ServerName*> is online and remotely accessible from the DPM server.</li><li>If a firewall is enabled on <*ServerName*>, that it is not blocking WMI requests from the DPM server.</li><li>The WMI service on <*ServerName*> is running.</li><ul>|
  
## Error codes 401-500

|Error code|Message|Additional information|
|---|---|---|
|401|The agent installation failed while trying to install the Agent Coordinator service.|To resolve this error, verify the following:<br/>- The share \\\\<_ServerName_>\ADMIN$ is accessible.<br/>- Remote calls from the DPM server to the Service Control Manager (SCM) on <*ServerName*> are not blocked by a firewall.|
|402|When trying to retrieve information from the Windows Management Instrumentation (WMI) service on <_ServerName_>, access was denied.|To resolve this error, follow these steps.<br/><br/> **Caution**<br/>Serious problems can occur if you modify the registry incorrectly. These problems could require you to reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk. Always make sure that you back up the registry before you modify it, and that you know how to restore the registry if a problem occurs. <ol><li>On the target computer, select **Start** > **Run**, type **regedit**, and then select **OK**. </li><li>Locate the following registry subkey, and then delete it:<br/><br/> `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MicrosoftFirewall\DomainProfile\RemoteAdminSettings` <br/></li><br/><li>Restart the target computer, and then try to add the target computer to the DPM server again.</li></ol>|
|403|Access was denied when trying to create the lock file in \\\\<_ServerName_>\ADMIN$.|Verify that you have permissions to create the lock file in \\\\\<*ServerName*>\ADMIN$.|
|404|The agent operation failed when trying to install the Agent Coordinator service.|To resolve this error, verify the following:<br/>- The share \\\\<_ServerName_>\ADMIN$ is accessible.<br/>- The remote calls from the DPM server to the Service Control Manager (SCM) on <*ServerName*> are not being blocked by a firewall.|
|405|DPM could not detect if computer <_ServerName_> is clustered.|Agent installation on <*ServerName*> can continue. To protect clustered resources, you must install a DPM protection agent on all nodes of the cluster. Review the error details, and make sure that the Windows Management Instrumentation service is running and can be accessed remotely from the DPM server.|
|406|DPM detected that server <_ChosenServerName_> is clustered, but could not identify the fully qualified domain name of <_ServerName_>.|Agent installation on <*ChosenServerName*> can continue. To protect clustered resources, you must install a DPM protection agent on all nodes of the cluster. Make sure that the cluster state is correctly configured and verify that all nodes are joined to the domain.|
|407|You have selected basic disks. DPM will convert to dynamic disks and any existing volumes on these disks will be converted to simple volumes. Do you want to continue?|No user action is required.|
|408|Are you sure that you want to remove the selected disk from the storage pool?|No user action is required.|
|409|The missing disk contains protection group members. To continue protecting these members, you must allocate them to another disk. Do you want to continue?|No user action is required.|
|417|HASH(0x315eebc)| |
|418|HASH(0x30e56c4)| |
|419|DPM could not set security permissions on the replica or recovery point volume that was created.|Review the error details, take appropriate action, and retry the operation.|
|420|DPM could not obtain security permissions on the replica or recovery point volume.|Review the error details, take the appropriate action, and then retry the operation.|
|450|An invalid path name was specified for the DPM database location.|Specify the correct path of the .mdf or .bak file, and then try again.|
|451|The path name specified for the DPM Report database location is not valid.|No user action is required.|
|452|The DPM service failed to stop.|Check the application and system event logs for information on the error.|
|453|The DPM service failed to start.|Check the application and system event logs for information on the error.|
|454|DpmSync failed to connect to the specified SQL Server instance.|Make sure that you have specified a valid instance of SQL Server associated with DPM and that you are logged on as a user with administrator privileges.|
|455|Failed to attach database [<_DatabaseName_>] at location [<_DatabaseLocation_>] to SQL Server.|Make sure that the SQL Server services are running and that you are restoring a valid DPM database backup.|
|456|There were failures in the synchronization operation.|For more detail, review the Application event log.|
|457|The command-line arguments specified are not valid.|For help about DpmSync, in DPM Management Shell, at the command prompt, type `DpmSync -?`. |
|458|The DPM database on the DPM server <_ServerName_> has been restored from a backup. As a result, the alerts that were generated before <_DBRestoreTime_> do not reflect the current state of alerts on the DPM server.|To synchronize the Operations Manager view with the current state on the DPM server, do the following:<ol><li>In the Operations Manager Operator console, resolve all alerts for <*ServerName*>, and the computers that it protects: In **Alerts**, display all alerts for System Center Data Protection Manager (DPM), sort the alerts by Source, and then select the alerts for <*ServerName*>. To remove the selected alerts, right-click the alerts, click **Set Alert Resolution State**, and then select **Resolved**.</li><li>On the DPM server, in DPM Administrator Console, in the **Actions** pane, select **Options**, and then, on the **Alert Publishing** tab, select **Publish Active Alerts**. This publishes all existing alerts that may require a user action to Operations Manager.</li></ol>|
|460|The command syntax is not valid.|For help about DpmSync, in DPM Management Shell, at the command prompt, type `DpmSync -?`.|
|461|The instance name specified could not be found.|Specify the correct name for the instance of SQL Server.|
|462|Unable to retrieve DPM database file path.|Specify the correct path, and then try the operation again.|
|464|Path not found: <_FileName_>.|Make sure that the database backup exists at the specified path.|
|465|Unable to close all connections for detaching the database.|Review the error details, and then try again.|
|466|Unable to copy database files to <_FileName_>.|Review the error details, and then try the operation again.|
|467|The specified action can be performed only on a computer with DPM installed.|Run the tool on the DPM server to complete these steps.|
|469|Unable to detach the database.|Make sure that you have the appropriate permission to detach the DPM database.|
|470|The DPM database was not found in the specified instance of SQL Server.|Make sure that the DPM database is present in the specified instance of SQL Server.|
|471|Unable to attach the database.|Make sure that the DPM database backup is valid.|
  
## Error codes 501-600

|Error code|Message|Additional information|
|---|---|---|
|517|The message cannot be sent to the SMTP server.|Check the SMTP server settings.|
|518|An authentication error occurred when trying to connect to the SMTP server.|You typed an incorrect user name, password, or SMTP server name. Type the correct user name or password to enable e-mail delivery of reports and alert notifications.|
|519|The SMTP server has rejected one or more of the recipient addresses.|Confirm the recipient addresses.|
|520|The SMTP server port number must be between 1 and 65535.|Enter a valid port number.|
|521|Cannot resolve the SMTP server host name.|Verify the SMTP server host name.|
|522|Cannot connect to the SMTP server.|Verify the SMTP server name and port number.|
|523|The passwords entered do not match.|Reenter the passwords.|
|524|The protection agent TCP port number must be between 1 and 65535.|Enter a valid port number.|
|525|The protection agent TCP port number must be between 1 and 65535.|Enter a valid port number.|
|526|The protection agent TCP port number must be different from the protection agent port number.|Reenter the port numbers.|
|527|The SMTP server reports that the From address is not valid.|Make sure that the appropriate permissions exist to send e-mail to the specified server by using SMTP.|
|528|An e-mail message has been successfully sent to <_Recipient_>.| |
|529|An e-mail message has been successfully sent to the specified recipients.|No user action is required.|
|530|A blank password is not allowed.|Enter a non-blank password.|
|531|The DPM alerts have been published to the DPM Alerts event log.|No user action is required.|
|532|Changes to end-user recovery settings do not fully take effect for each protection group until the next successful synchronization is complete.|No user action is required.|
|533|The DPM backup events have been published to the DPM Backup event log.| |
  
## Error codes 800-899

|Error code|Message|Additional information|
|---|---|---|
|801|To install DPM, you must be logged on as an administrator or a member of the local administrators group.|Sign in to the computer as an administrator or member of the local administrators group, and then run Setup again.|
|802|The computer processor speed does not meet the DPM minimum configuration requirements. The minimum required processor speed is <_ClockSpeed_>.|Upgrade the computer hardware to meet the DPM minimum configuration requirements, or install DPM on a different computer. For information about DPM system requirements, see [Get DPM installed](/system-center/dpm/install-dpm).|
|803|The available memory on the computer is less than the DPM minimum memory requirement. The minimum memory requirement is <_MinimumMemoryRequired_> MB, and the recommended memory requirement is 2 GB.|Upgrade the computer hardware to meet the DPM minimum configuration requirements, or install DPM on a different computer. For information about DPM system requirements, see [Get DPM installed](/system-center/dpm/install-dpm).|
|805|There is not enough disk space for <_InstallItem_>.|Free up additional disk space on this disk, and then retry the operation.|
|806|Setup failure - Active Directory not found.|No user action is required.|
|807|Setup failure - Target not configured correctly.|No user action is required.|
|808|HASH(0x314255c)| |
|809|DPM cannot load the file <_FileName_>. The file may be missing or corrupt.|Run DPM Setup from the DPM product DVD. If you ran Setup from the DVD, the DVD is corrupt.|
|810|The DPM installation failed.|Review the error details, take appropriate action, and then run DPM Setup again.|
|811|The DPM database was not created.|Use **Add or Remove Programs** in Control Panel to remove the DPM files and registry entries that were created during Setup. Verify that SQL Server is properly installed and that it's running, and then run Setup again.|
|812|Report configuration failed.|Verify that SQL Server Reporting Services is installed properly and that it is running.<br/><br/>For more information, see [SQL Installation and Reporting Issues with Data Protection Manager](/archive/blogs/askcore/sql-installation-and-reporting-issues-with-data-protection-manager).|
|813|The DPM uninstall failed.|Review the error details, take appropriate action, and then try uninstalling DPM again.|
|814|The configuration data for this product is corrupt.|Troubleshoot your Windows Installer installation. Contact your support personnel for further help.|
|817|The Setup log file path <_FileName_> is too long after being fully qualified.|Verify that the Application Data folder path has fewer than 260 characters, and then run DPM Setup again.|
|818|The Setup log file path <_FileName_> is not valid.|Specify a valid Application Data folder path.|
|820|Setup cannot query the system configuration.|If you encountered this error while you are on the **Installation** page of the DPM Setup Wizard, to resolve the error, do the following:<ol><li>On the DPM server, select **Start** > **All Programs** > **Microsoft SQL Server 2008** > **Configuration Tools** > **SQL Server Configuration Manager**.</li><li>In SQL Server Configuration Manager, select **SQL Server Services**, and then in the **Details** pane, make sure that the SQL Server and SQL Server Agent services that are related to the DPM 2010 database are running.</li><li>If either service is stopped, in the **Details** pane, right-click the service, and then select **Start**.</li><li>If the services don't start, change the logon account for both services to the Local system account by doing the following:<ol><li>In the **Details** pane, right-click the service, and then select **Properties**.</li><li>On the **Log On** tab, select **Built-in account**. In the Built-in account list, select **Local system**, and then select **OK**.</li><li>In the **Details** pane, right-click the service, and then select **Start**.</li></ol></li><li>Now change the logon account for both services back to the MICROSOFT$DPM$Acct account by doing the following:<ol><li>In the **Details** pane, right-click the service, and then select **Properties**.</li><li>On the **Log On** tab, select **This account**, in the **Account name** box, type **.\MICROSOFT$DPM$Acct**, in the **Password** and **Confirm password** boxes, type the same password that you used during DPM 2010 RTM setup, and then select **OK**.</li><li>In the **Details** pane, right-click the service, and then select **Start**.</li></ol></li><li> Install or upgrade to DPM 2010 RTM again.</li></ol>|
|822|DPM Setup could not access the SQL Server Reporting Services configuration.|Verify that the Windows Management Instrumentation (WMI) service is running. If the WMI service isn't running, in Control Panel, select **Administrative Tools**, and then select **Services**. Right-click **Windows Management Instrumentation**, and then select **Start**.|
|823|DPM Setup cannot access registry key <_RegistryKey_>.|Verify that the registry key <*RegistryKey*> exists, and then run DPM Setup again.|
|824|Reporting Server web server URL is not accessible. Run Reporting Services Configuration Manager to check reporting server web URL and settings.| |
|828|DPM cannot connect to the Service Control Manager (SCM).|To troubleshoot this issue, review the recent errors in the Windows event log.|
|829|DPM cannot open the handle to the <_SetupServiceName_> service.|To troubleshoot this issue, review the recent errors in the Windows event log.|
|830|DPM cannot read the service <_ServiceName_> configuration.|On <_ServerName_>, review the recent errors in the Windows event log.|
|832|Setup cannot grant the <_UserName_> account access to the DPM database.|Verify that SQL Server is properly installed and that it is running.|
|833|Setup could not delete the <_UserName_> user account.|To delete the <*UserName*> user account, on the **Administrative Tools** menu, select **Computer Management**, expand **Local Users and Groups**, and then select **Users**. Right-click <*UserName*>, and then select **Delete**.|
|834|Setup cannot remove the deployed reports.|To delete the reports manually, go to `http://<ComputerName>/ReportServer$<InstanceName>`.|
|836|The DPM repair failed.|Verify that the DPM server meets the software requirements. Uninstall DPM, and then run DPM Setup again.|
|841|Setup cannot calculate the disk space for the specified location.|Specify a different installation location.|
|842|Setup cannot access the <_RegistryKey_> registry key for the <_SqlInstance_> instance of SQL Server.|Verify that SQL Server 2008 is properly installed.|
|845|DPM Setup could not delete the DPMDB database.|To delete the DPMDB database, in SQL Server Management Studio, connect to server <_DPM server name_>\\<_InstanceName_>. Expand the <*InstanceName*> instance of SQL Server, expand **Databases**, right-click the **DPMDB** database, and then select **Delete**.|
|846|DPM cannot locate SqlCmd.exe.|Verify that the SQL Client Tools are installed. If they are not installed, you must install the SQL Client Tools, and then run DPM Setup again.|
|847|DPM cannot create the <_SetupServiceName_> service. Failure to create the service may be due to a pending restart.|Restart the computer, uninstall DPM, and then run Setup again.|
|848|Setup is unable to copy the files from <_SourceLocation_> to <_InstallLocation_>.|Verify that Setup has access to the installation location.|
|849|Setup is unable to delete the folder <_InstallLocation_>.|Delete the folder manually.|
|850|Setup is unable to mark files at <_FolderPath_> for deletion.|After DPM setup is complete, delete the files manually.|
|851|Cannot start Setup.|Run the Setup program from the DPM product DVD. If you ran Setup from the DVD, the DVD is corrupt.|
|853|Setup is unable to register DPM in Add or Remove Programs.|No user action is required.|
|854|Another instance of DPM Setup is running.|Verify that no other instance of DPM Setup is running, and then proceed with DPM Setup.|
|855|Setup was unable to delete the scheduled jobs.|Open SQL Server Management Studio, and then connect to the DPM instance of SQL Server. Expand the instance of SQL Server, expand **SQL Server Agent**, expand **Jobs**, and then delete the <_ScheduleCategory_> category.|
|856|DPM could not access the existing DPM database, or the DPM database is corrupt.|Verify that the SQL Server service is running. If the SQL Server service is running, restore the DPM database, and then run DPM Setup again.|
|857|DPM cannot enumerate the list of computers on which protection agents are installed because it cannot gain access to the DPM database.|Protection agents may be installed on some of the computers. Uninstall the agents on the protected computers by using **Add or Remove Programs** in Control Panel.|
|858|The DPM product key is invalid.|Enter a valid DPM product key. The product key is located on the back cover of the Data Protection Manager product DVD.|
|859|Setup cannot parse the SQL Server 2008 Reporting Services configuration file <_FileName_> for the SMTP server address and the address of the sender.|Verify that SQL Server is properly installed.|
|860|DPM cannot stop service <_SetupServiceName_>.|Review the error details, take the appropriate action, and then try installing DPM again.|
|861|DPM cannot read the installation path registry key. Some of the folders will not be deleted.|Manually delete the folders after completing DPM Setup.|
|862|Setup cannot start the <_SetupServiceName_> service.|Review the error details, take the appropriate action, and then try installing DPM again.|
|863|You cannot use the selected location <_DirectoryPath_> to install DPM. DPM can only be installed on the local drive of the computer. DPM cannot be installed to read-only folders, hidden folders, folders within mount points, root volumes, or directly to local system folders such as <_FolderPath_>.|Select a different location on which to install DPM.|
|864|You cannot install DPM on removable media or a network share. The location <_DriveName_> cannot be used as an installation location.|Select a location on a local hard drive to install DPM.|
|865|Setup could not enumerate the information about volumes allocated to DPM.|On the **Administrative Tools** menu, select **Computer Management** > **Disk Management**. Delete the volumes allocated to DPM from the disks that were added to the storage pool.|
|866|The Windows account that was created in DPM Administrator Console in the Recovery task area could not be removed.|On the **Administrative Tools** menu, select **Computer Management**. Expand **Local Users and Groups**, select **Users**, right-click the Windows account, and then select **Delete**.|
|868|DPM cannot query the volume information for directory <_DirectoryPath_>.|Select another installation location on a local hard drive to install DPM.|
|869|The <_DirectoryPath_> directory is not on an NTFS volume.|Install the prerequisite software and DPM on a volume formatted with NTFS.|
|870|DPM cannot query the attributes of directory <_DirectoryPath_>.|Select another installation location on a local hard drive to install DPM.|
|871|DPM Setup has detected an existing installation of DPM on this computer. The existing installation is a later version than the version you are trying to install.|To install the earlier version of DPM, you must first uninstall the existing version.|
|872|SQL Server 2000 is not installed on this machine.|Install SQL Server (Standard or Enterprise) on this machine.|
|873|SQL Server 2000 SP 3a is not installed on this machine.|Install SQL Server 2000 SP 3a or higher on the instance of SQL Server you will use.|
|874|QFE 859 for SQL Server 2000 is not installed on this machine.|Install SQL Server 2000 QFE 859 on the instance of SQL Server you will use.|
|875|SQL Server 2000 Reporting Services is not installed on this machine.|Install SQL Server 2000 Reporting Services on the instance of SQL Server you will use.|
|876|DPM Setup cannot create the folder <_FolderPath_>.|If the folder already exists, delete the folder, and then run DPM Setup again.|
|877|DPM Setup cannot write to file <_FileName_>.|If the file already exists, delete the file, and then run Setup again.|
|878|Setup cannot create the protection job schedules.|Open SQL Server Management Studio, and then connect to the DPM instance of SQL Server. Expand the instance of SQL Server, expand **SQL Server Agent**, expand **Jobs**, and then delete the <_ScheduleCategory_> category.|
|879|DPM Setup could not delete service <_SetupServiceName_>.|To delete the service manually, at the command prompt, type `sc delete <SetupServiceName>`.|
|880|The DPM protection agent configuration failed.|Review the error details, take the appropriate action, and then try installing DPM again.|
|881|The required local group could not be created.|Try installing DPM again.|
|882|DPM Setup could not create a required service. This computer may be protected by another computer running DPM. You cannot install DPM on a computer on which a protection agent is installed.|If the DPM protection agent is installed on this computer, use **Add or Remove Programs** in Control Panel to uninstall it, and then run DPM Setup again.|
|883|DPM Setup cannot read the <_FileName_> file.|Verify that the current user has permissions to read the file.|
|884|DPM Setup cannot delete folder <_FolderPath_>.|Manually delete the folder <*FolderPath*> after completing DPM Setup.|
|885|DPM Setup cannot create the <_FileName_> file.|Verify that the current user has permissions to create the file.|
|886|This program is for internal DPM use only.|To launch the DPM Setup program, double-click **Setup.exe** in the root folder of the product DVD.|
|887|An error occurred while trying to configure DPM.|Uninstall DPM by using **Add or Remove Programs** in Control Panel, and then run DPM Setup again.|
|888|DPM Setup could not create the DPM shortcut on your desktop.|To start using DPM, select **Start**, point to **All Programs**, and then select **Microsoft System Center Data Protection Manager 2010**.|
|889|The database files from a previous DPM installation were found at <_Location_>.|Delete the existing files at <*Location*>, or select an alternative location for your database.|
|890|An older version of DPM is installed on this computer. Uninstall it and launch setup again.|No user action is required.|
|891|PrerequisiteInstallFailed| |
|892|The computer <_ComputerName_> could not be removed from the intranet security zone settings in Internet Explorer.|In Internet Explorer, on the **Tools** menu, select **Internet Options**. In the **Internet Options** dialog box, on the **Security** tab, select **Local intranet** > **Sites** > **Advanced**, and then remove computer <*ComputerName*> from the intranet zone.|
|893|Setup cannot delete the volumes that are allocated to DPM.|On the **Administrative Tools** menu, select **Computer Management** > **Disk Management**. Delete the volumes allocated to DPM from the disks that were added to the storage pool.|
|894|DPM Setup could not delete the DPM shortcut on your desktop.|Manually delete the DPM shortcut from your desktop.|
|895|The service <_SetupServiceName_> was not deleted from the computer.|Restart the computer to delete the service <*SetupServiceName*>.|
|896|DPM could not connect to database <_DatabaseName_>.|Verify that the SQL Server service <_ServiceName_> is started and that you have permissions to query SQL Server.|
|897|DPM could not delete database <_DatabaseName_>.|In SQL Server Management Studio, delete the following databases: <*DatabaseName*>, <_TempDatabaseName_>.|
|898|DPM Setup cannot query the SQL Server Reporting Services configuration.|Verify that the Windows Management Instrumentation (WMI) service is running, and that your SQL Server Reporting Services installation is not corrupt.|
|899|DPM Setup could not delete the MSDPMTrustedMachines local group.|Manually delete the MSDPMTrustedMachines group. On the **Administrative Tools** menu, select **Computer Management**. Expand **Local Users and Groups**, and then select **Groups**. Right-click **MSDPMTrustedMachines**, and then select **Delete**.|
  
## Error codes 900-999

|Error code|Message|Additional information|
|---|---|---|
|900|DPM Setup could not delete all the registry keys that DPM uses.|No user action is required.|
|901|DPM Setup could not delete the DPM Agent Coordinator service.|Manually delete the DPM Agent Coordinator service. On the **Administrative Tools** menu, select **Services**. Right-click **DPM Agent Coordinator**, and then select **Delete**.|
|902|The job encountered an internal fatal error.|Contact Microsoft Customer Support.|
|904|The protection agent on <_ServerName_> is not compatible with the DPM version. The protection agent version is <_AgentVersion_>, and the DPM version is <_EngineVersion_>.|Update the protection agent on <*ServerName*>.|
|905|The protection agent on <_ServerName_> is not compatible with the DPM version. The protection agent version is <_AgentVersion_>, and the DPM version is <_EngineVersion_>.|Verify that all required DPM updates are applied to this computer.|
|906|JobRedefinition| |
|907|The job encountered an internal database error.|Retry the operation.|
|908|The job was canceled. The user either canceled the job or modified the associated protection group.|Retry the operation.|
|909|DPM has received an improperly formed message and was unable to interpret it.|Retry the operation. If the problem persists, contact Microsoft Customer Service and Support.|
|910|The DPM service terminated unexpectedly during completion of the job. The termination may have been caused by a system restart.|Retry the operation.|
|911|DPM was not able to complete this job within the allotted time.|In the **Monitoring** task area, group jobs by type and review the job details. If the next scheduled occurrence of this job is currently running, no action is required. If the job is not currently running, retry the job.|
|912|The job has been canceled because of the failure of another job on which it depended.|Retry the operation.|
|913|The job was canceled because it was scheduled during the inactivity timeframe.|Retry the operation.|
|914|The job failed because of an unexpected error.|Make sure that the DPMRA service is running on the selected computer.|
|915|The operation failed because the data source VSS component <_Component_> is missing.|Make sure that the protected data source is installed properly and that the VSS writer service is running.|
|916|Cannot connect to the DPM service because it is running in recovery mode, which was initiated by the DpmSync tool.|Wait for DpmSync to complete its operation. If DpmSync is not running and the DPM service is still in recovery mode, run DpmSync again.|
|917|Connection to the DPM service has been lost.|Review the application event log for information about a possible service shutdown. Make sure that the following services are enabled:<br/>- DPM<br/>- DPM Replication Agent<br/>- SQLAgent$<_InstanceName_><br/>- MSSQL$<*InstanceName*><br/>- Virtual Disk Service<br/>- Volume Shadow Copy|
|918|Connection to the DPM service has been lost.|Make sure that the DPM service is running, and review the Application event log for information about a possible service shutdown.|
|919|Connection to the DPM service has been lost.| |
|920|DPM failed to write events to the DPM Alerts event log. Either the DPM Alerts event log has been deleted or the permissions have been changed.|Uninstall DPM, and then reinstall DPM to recreate the DPM Alerts event log.|
|921|The operation failed because an error occurred while enumerating the data source for <_Component_>.|Make sure that the data source specified in the error message is online and accessible.|
|927|HASH(0x31d4df4)| |
|928|HASH(0x31d767c)| |
|929|DPM Management Shell is not connected to any DPM server or the previous connection was lost.|Use the `Connect-DPMServer` command to connect to a DPM server. If you are already connected to a DPM server and still seeing this error, make sure that the DPM service is running and review the application event log for any errors.|
|939|The DPM Administrator Console version <_Version_> is incompatible with the DPM server version.|Make sure that the version is between <_MinimumUIVersion_> and <_MaximumUIVersion_>.|
|940|Unable to connect to the database because of a fatal database error. It is unlikely that the database has been damaged.|Review the event log and take appropriate action. Make sure that SQL Server is running.|
|941|Unable to connect to the DPM database.|Make sure that SQL Server is running and configured correctly, and then retry the operation.|
|942|The integrity of the database is questionable because of a hardware or software problem.|Contact your SQL Server administrator. Review the Windows event log. Run **DBCC CHECKDB** to determine the extent of the damage. It is possible that the problem is in the cache only and not on the disk itself. If so, restarting SQL Server corrects the problem. Otherwise, use DBCC to repair the problem. In some cases, it may be necessary to restore the DPM database.|
|943|Unable to connect to the DPM database because the database is in an inconsistent state.|Contact your SQL Server administrator. In some cases, it may be necessary to restore the DPM database. If the problem persists, contact Microsoft Customer Service and Support.|
|944|Database operation failed.|Make sure that SQL Server is running and that it is configured correctly, and then retry the operation.|
|945|Unable to connect to the DPM database because of a general database failure.|Make sure that SQL Server is running and configured correctly.|
|946|Another instance of DPM is currently running.|Restart the computer, and then retry the operation again.|
|947|SqmUploadFailed| |
|948|Unable to connect to <_ServerName_>.|To resolve this error, do the following:<br/><br/> **Restart the DPM Services** <ol><li>On the DPM server, open Service Manager, expand **Configuration**, and then select **Services**.</li><li>In the **Services** pane, restart the following DPM services:<ul><li>DPM (MSDPM)</li><li>DPM Access Manager Service (DPMAMService)</li><li>DPM Writer (DpmWriter)</li><li>DPMLA (DPM Library Agent)</li><li>DPMRA (DPM Replication Agent)</li></ul></li><li>If you cannot restart the services, do the following:<ol><li>In Service Manager, expand **Diagnostics**, expand **Event Viewer**, and then expand **Windows Logs**.</li><li>Check the logs for errors, resolve any errors that you find, and then try to open DPM Administrator Console again.</li></ol></li></ol> <br/>**Rerun the `DPMSync -Sync` Command** <ol><li>On the DPM server, select **Start** > **All Programs** > **Microsoft SQL Server 2008** > **SQL Manager Management Studio**.</li><li>In the **Connect to Server** dialog box, in the **Server name** box, type the computer name and the name of the instance of SQL Server that is used for the DPM database in the following format: <**ComputerName**\\**InstanceName**>.</li><li> In SQL Manager Management Studio, expand **Databases**, right-click **DPMDB**, and then select **New Query**.</li><li> Type the following SQL query, and then select **Execute**.<br/>`Select * from Tbl_dls_globalsetting where PropertyName='DBRecovery'`.</li><br/><li>If the PropertyValue returned is **1**, a `DPMSync -Sync` operation ended or was canceled before it was completed. Rerun `DPMSync -Sync`, let the operation finish completely, and then try to open the DPM Administrator Console again.|
|949|A connection to DPM Server <_ServerName_> is already open.| |
|950|InvalidSchedule| |
|951|No schedules found for the job definition.|No user action is required.|
|952|ScheduleRedefinition| |
|953|SqlAgentError| |
|954|DlsSchedulerError| |
|955|The consistency check resulted in the following changes to SQL Server Agent schedules: Schedules added: <_SchedulesAdded_><br/>Schedules removed: <_SchedulesRemoved_> <br/>Schedules updated: <_SchedulesUpdated_>.|No user action is required.|
|956|DPM cannot protect your Windows SharePoint Services farm until you install DPM protection agents on the following computers: <_ServerName_>.|To resolve this error, do the following:<ol><li>To install agents on these computers, in the **Management** task area, select the **Agents** tab, and then, in the **Action** pane, select **Install**.</li><li>If any of the computers are a node of a cluster or a mirror, you must install a DPM protection agent on all physical nodes of that cluster or mirror.</li><li>If SQL aliasing is used in the SharePoint farm, make sure that SQL Client Connectivity components are installed on the SharePoint front-end web server.</li><li>If SQL aliasing is used in the SharePoint farm, you can run the `ConfigureSharePoint.exe -ResolveAllSqlAliases` command on the SharePoint front-end web server to identify the SQL aliases that cannot be resolved by DPM.|
|957|DPM is unable to protect your mirrored SQL Server databases <_Component_> until you install DPM protection agents on the following computers: <_ServerName_>.|To install protection agents on these computers, in the **Management** task area, select the **Agents** tab, and then, in the **Action** pane, select **Install**. If any of the computers are a node of a cluster, you must install a DPM protection agent on all physical nodes of the cluster.|
|958|DPM cannot browse the contents of the virtual machine on the protected computer <_protected computer_>.|Perform a full restore of the virtual machine.<br/><br/>If none of the conditions listed in the Explanation section are present, and you still get this error, try the workaround explained in [Error when you manage a VHD file in Windows Server 2008 or Windows Server 2008 R2: "A Virtual Disk Provider for the specified file was not found"](https://support.microsoft.com/help/2013544/).|
|959|DPM could not enumerate one or more volumes on protected computer <_ServerName_>.|Make sure that the disks are fixed and that volumes are formatted with the NTFS file system.|
|960|DPM could not enumerate one or more VSS applications on the protected computer <_ServerName_>.|Make sure that all VSS writers are in a good state by checking the Event Viewer for errors from VSS.|
|961|DPM could not enumerate one or more non-VSS applications on protected computer <_ServerName_>.|Make sure that all VSS writers are in a good state by checking the Event Viewer for errors from VSS. Also make sure that the PSDataSourceConfig.xml file is configured properly.|
|962|DPM could not enumerate one or more SharePoint search writers on protected computer <_ServerName_>.|Make sure that all SharePoint search writers are in a good state.|
|963|DPM could not enumerate one or more components for application <_Component_> on protected computer <_ServerName_>.|Make sure that the application writer is in a good state.|
|964|DPM could not enumerate application component <_Component_> on protected computer <_ServerName_>.|Make sure that the writer is in a good state.|
|965|DPM could not enumerate instances of SQL Server by using Windows Management Instrumentation on the protected computer <_ServerName_>.|Make sure that Windows Management Instrumentation for SQL Server is in a good state.|
|966|DPM could not connect to the instance of SQL Server <_Component_> on the protected computer <_ServerName_>.|Make sure that the instance of SQL Server is in a good state.|
|967|DPM could not enumerate SharePoint data sources on the protected computer <_ServerName_>.|To resolve this error, do the following: <ol><li>Make sure that the front-end Web server of the SharePoint farm has been configured for protection by using `ConfigureSharePoint.exe -EnableSharePointProtection`.</li><li>If you are protecting SharePoint Search, also run `ConfigureSharePoint.exe -EnableSPSearchProtection` on the front-end Web server.</li></ol> |
|968|The current selections will be reset, and you must select them again.|To reset, select **Yes**. To keep the current selection, select **No**.|
|969|The DPM Administrator Console version <_Version_> is incompatible with the DPM server version.|Ensure that DPM server has latest updates installed on it.|
|970|Click Yes to claim ownership of this data source and to resume backup and recovery of the data source.| |
|975|The arguments for the job definition are not valid.|Retry the operation with the correct argument syntax.|
|976|The DPM job failed because it could not contact the DPM engine.|Restart the DPM service.|
|997|A non-fatal failure instance has been detected for process <_DpmProcessName_>. This will be reported to Microsoft.|No user action is required.|
|998|The operation failed because of a protection agent failure.|Retry the operation.|
|999|An unexpected error caused a failure for process <_DpmProcessName_>.|Restart the DPM process <*DpmProcessName*>.|
  
## Error codes 1000-1999

|Error code|Message|Additional information|
|---|---|---|
|1000|Login failure caused by incorrect user name or password.|Verify the user name and password, and then try again.|
|1001|InvalidJobDefinition|This error can occur when attempting to do an item-level recovery for a Hyper-V VM from a disk-to-tape (D2T) configuration, which is unsupported. To work around this issue, restore the VM as a folder or configure a disk-to-disk-to-tape (D2D2T) backup for the VM.|
|1002|You cannot cancel the selected job at this time.|No user action is required.|
|1003|JobNotFound| |
|1004|JobDefinitionNotFound| |
|1005|CanNotCreateJobDefinition| |
|1100|DPM: Information alert: <_ServerName_>.|No user action is required.|
|1101|DPM: Warning alert: <_ServerName_>.|No user action is required.|
|1102|DPM: Critical alert: <_ServerName_>.|No user action is required.|
|1103|DPM: Recovery alert: <_ServerName_>.|No user action is required.|
|1104|DPM: Resolved information alert: <_ServerName_>|No user action is required.|
|1105|DPM: Resolved warning alert: <_ServerName_>|No user action is required.|
|1106|DPM: Resolved critical alert: <_ServerName_>|No user action is required.|
|1107|The following alert became inactive at <_ResolvedTime_>.|No user action is required.|
|1108|The following alert occurred at <_OccuredSince_>.| |
|1109|For more information, open DPM Administrator Console and review the alert details in the Monitoring task area.|No user action is required.|
|1200|Status: <_AlertStatus_> <br/><br/>Volume: <_VolumeName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Used disk space on replica volume exceeds threshold of <_ThresholdValue_>%.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1201|Status: <_AlertStatus_> <br/><br/>Data source type: <_DatasourceType_> <br/><br/>Data source: <_DatasourceName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Protection group: <_ProtectedGroup_> <br/><br/>Description: Replica volume cannot be detected.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1202|Status: <_AlertStatus_> <br/><br/>Protection Group: <_ProtectedGroup_> <br/><br/>Description: DPM discovered one of the following changes:<br/>- New shares or volumes<br/>- Deleted volumes or shares<br/>- Shares have been remapped|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1204|The replica for <_DatasourceName_> on <_ServerName_> is currently being synchronized with consistency check. A consistency check can be started automatically or manually. To configure automatic consistency check options, change this protection group by using the Modify Protection Group Wizard. To start a manual consistency check, in the **Protection** task area, on the **Actions** pane, select **Perform Consistency Check**.|For more information, open the DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1205|Status: <_AlertStatus_> <br/><br/>Data source type: <_DatasourceType_> <br/><br/>Data source: <_DatasourceName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Replica is being created.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1206|The replica of <_DatasourceName_> on <_ServerName_> is inconsistent with the protected data source. All protection activities for this data source will fail until the replica is synchronized with consistency check.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1209|Status: <_AlertStatus_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Recovery jobs started at <_StartDateTime_>.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1210|Status: <_AlertStatus_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Recovery jobs started at <_StartDateTime_> completed with failures.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1211|Recovery to <_TargetServerName_> that started at <_StartDateTime_> completed. Some jobs have successfully recovered data and some jobs have failed.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1212|Status: <_AlertStatus_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Recovery jobs started at <_StartDateTime_> completed successfully.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1214|Status: <_AlertStatus_> <br/><br/>Data source type: <_DatasourceType_> <br/><br/>Data source: <_DatasourceName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Last <_FailureCount_> recovery points were not created.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1215|Status: <_AlertStatus_> <br/><br/>Data source type: <_DatasourceType_> <br/><br/>Data source: <_DatasourceName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Synchronization jobs failing.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1216|Status: <_AlertStatus_> <br/><br/>Data source type: <_DatasourceType_> <br/><br/>Data source: <_DatasourceName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: DPM failed to stop protection.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1217|Status: <_AlertStatus_> <br/><br/>Description: New protectable computers found.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1218|The replica for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not created. You have chosen to create the replica manually. All subsequent protection activities for this data source will fail until the replica is created and synchronized with consistency check.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1219|The replica for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not created. Replica creation job is scheduled to run at a later time. Data protection will not start until replica creation is complete.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1220|Status: <_AlertStatus_> <br/><br/>Description: The disk <_DiskName_> cannot be detected or has stopped responding. All subsequent protection activities that use this disk will fail until the disk is brought back online.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1221|Status: <_AlertStatus_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Incompatible DPM protection agent.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1222|Status: <_AlertStatus_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Unable to contact DPM protection agent.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1223|Status: <_AlertStatus_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Failed to update end-user recovery permissions.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1224|Status: <_AlertStatus_> <br/><br/>Volume: <_VolumeName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Network bandwidth usage throttling not working.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1225|Unsupported data found.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1226|Status: <_AlertStatus_> <br/><br/> <_LibraryType_>: <_Library_> <br/><br/>Description: <*LibraryType*>: <*Library*> is not available, and all jobs for this library will fail until the connection is established.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1227|Status: <_AlertStatus_> <br/><br/> <_LibraryType_>: <_Library_> <br/><br/>Description: Library is not functioning efficiently.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1228|Status: <_AlertStatus_> <br/><br/> <_LibraryType_>: <_Library_> <br/><br/>Drive: <_LibraryDrive_> <br/><br/>Description: Tape is decommissioned and should be removed from the library.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1229|Status: <_AlertStatus_> <br/><br/> <_LibraryType_>: <_Library_> <br/><br/>Description: Number of free tapes is less than or equals the threshold value.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1230|Status: <_AlertStatus_> <br/><br/> <_LibraryType_>: <_Library_> <br/><br/>Tape: <_MediaLabel_> <br/><br/>Description: Tape erase job failed.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1231|Status: <_AlertStatus_> <br/><br/> <_LibraryType_>: <_Library_> <br/><br/>Tape: <_MediaLabel_> <br/><br/>Description: Tape verification job couldn't start or failed.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1232|Status: <_AlertStatus_> <br/><br/>Description: Data copy job failed.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1233|Status: <_AlertStatus_> <br/><br/>Description: Library catalog for backup job was not built correctly.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1234|Status: <_AlertStatus_> <br/><br/>Description: Backup to tape failed.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1237|Status: <_AlertStatus_> <br/><br/> <_LibraryType_>: <_Library_> <br/><br/>Drive: <_LibraryDrive_> <br/><br/>Description: A drive in the library is not functioning.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1238|Status: <_AlertStatus_> <br/><br/> <_LibraryType_>: <_Library_> <br/><br/>Tape: <_MediaLabel_> <br/><br/>Description: Tape has been verified.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1240|Status: <_AlertStatus_> <br/><br/> <_LibraryType_>: <_Library_> <br/><br/>Description: Job requires tape that is not available in the library.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1241|AlertBeingResolved| |
|1242|CannotResolveAutomatically| |
|1243|Detailed inventory failed.|To resolve this error, do the following:<ul><li>Perform a fast inventory after each tape operation.</li><li>Make sure that the tape specified for a detailed inventory is not in a drive and being backed up.</li><li>To reduce the number of detailed inventory failure alerts, create the following registry key. To open the Registry Editor, select **Start** > **Run**, and then type **regedit**.<br/> Registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Data Protection Manager\1.0\Alert` <br/>Entry name: `DetailedInventoryFailed` <br/>Type: **DWORD** <br/>Value data: **0** </li></ul><br/> **Caution**<br/>Serious problems can occur if you modify the registry incorrectly. These problems could require you to reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk. Always make sure that you back up the registry before you modify it, and that you know how to restore the registry if a problem occurs.<br/><br/> **Note** <br/>After you have created the registry key, you can check whether detailed inventory jobs fail or succeed by using the Jobs tab in the **Monitoring** view.|
|1244|Database size on DPM server has exceeded the threshold value.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1245|Status: <_AlertStatus_> <br/><br/> <_LibraryType_>: <_Library_> <br/><br/>Tape: <_MediaLabel_> <br/><br/>Description: Data integrity verification failed.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1246|Status: <_AlertStatus_> <br/><br/>Volume: <_VolumeName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Used disk space for recovery point volume exceeds threshold of <_ThresholdValue_>%.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1247|Status: <_AlertStatus_> <br/><br/>Data source type: <_DatasourceType_> <br/><br/>Data source: <_DatasourceName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: DPM failed to configure protection.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1248|Status: <_AlertStatus_> <br/><br/>Data source type: <_DatasourceType_> <br/><br/>Data source: <_DatasourceName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Consolidation of recovery points failed.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1249|Status: <_AlertStatus_> <br/><br/>Description: DPM detected multiple disks with the same disk identification number (DiskID). None of these disks will be added to the DPM Storage Pool.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1250|Status: <_AlertStatus_> <br/><br/>Data source type: <_DatasourceType_> <br/><br/>Data source: <_DatasourceName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Data corruption detected.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1251|Status: <_AlertStatus_> <br/><br/>Computer: <_PSServerName_> <br/><br/>Description: Agent ownership is required to run backup/recovery jobs on <*PSServerName*>.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1252|Status: <_AlertStatus_> <br/><br/>Data source type: <_DatasourceType_> <br/><br/>Data source: <_DatasourceName_> <br/><br/>Computer: <_ServerName_> <br/><br/>Description: Last <_FailureCount_> online recovery points not created.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|1255|The share <_Share Name_> that was previously mapped to <_OldFolderPath_> has changed to <_NewFolderPath_>. DPM will continue to protect <_Old FolderPath_>, but recommends you modify protection as suggested in Recommended Action.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
  
## Error codes 2000-3999

|Error code|Message|Additional information|
|---|---|---|
|2000|DPM failed to run the operation because another conflicting operation is in progress.|Retry the operation later.|
|2001|WorkitemNotActive| |
|2002|ConcurrencyRulesViolation| |
|2003|SubtaskIsAlreadyRunning| |
|2004|ProtectionNotDefinedForSubtask| |
|2005|ReplicaRootDirectoryAlreadyUsed| |
|2006|VolumeAlreadyProtected| |
|2007|DirectoryNotInProtectedVolume| |
|2008|DirectoryIsInExclusionList| |
|2010|CanNotConnectWithHost| |
|2011|CommunicationProblem| |
|2012|AuthorizationFailed| |
|2013|Host authentication failed.|Retry authentication.|
|2014|HostUnreachable| |
|2015|RASVolumeNotFound| |
|2016|FsCaseSensitive| |
|2017|NeedRebootServer| |
|2018|FSFServiceFailure| |
|2019|RemoteCommunicationProblem| |
|2020|VolumeNotFound| |
|2021|NotEnoughSpaceForFilterLog| |
|2022|NotEnoughSpaceForSpillLog| |
|2023|NotEnoughSpaceOnReplica| |
|2024|FSFSessionNotExists| |
|2025|RootDirMovedIn| |
|2026|CannotApplyChanges| |
|2027|MonitoringLogIsFull| |
|2028|FSFTimeoutExpired| |
|2029|FSFFailedValidate| |
|2030|InvalidFileSpec| |
|2031|The specified destination path is not valid.|Restore to an alternate location.|
|2032|The specified path does not exist.|Select a valid path.|
|2033|DPM encountered an error while performing an operation for <_FileName_> on <_AgentTargetServer_>.|To resolve this error, do the following:<br/>1. Refer to the detailed error code in the description above. Retry the operation after the issue has been fixed.<br/>2. If the error was caused by insufficient resources, it could be a transient failure, and you should retry the operation later.<br/>3. If error is because of privileges with SMB share, wait for some time or reboot the file server, and then retry the operation.|
|2034|The specified path does not reside on an NTFS volume.|Restore to an NTFS volume.|
|2035|The operation failed because of insufficient disk space.|Increase the amount of free disk space on volume <_VolumeName_> on the destination computer, and then retry the operation, or recover to an alternate destination that has sufficient free disk space.|
|2036|The operation failed because DPM was unable to access the file or folder <_FileName_> on <_AgentTargetServer_>. This could be because the file or folder is corrupt, or the file system on the volume is corrupt.|To resolve this error, do the following:<br/>1. Run **chkdsk** on the affected volume, and then run synchronization with consistency check.<br/>2. If running **chkdsk** doesn't solve the problem, and the computer indicated above is a protected computer (and not the DPM server), consider deleting this file or folder from the source, and then running synchronization with consistency check.|
|2037|DPM could not detect the selected volume <_VolumeName_> on <_ServerName_>.|Make sure that <*VolumeName*> on <*ServerName*> exists. If the volume exists, retry the operation.|
|2038|Some items were not recovered because recovering items across a reparse point is not permitted. The folder <_ReparsePtPath_> under the recovery destination is a reparse point.|Retry the recovery to a destination that does not contain a reparse point.|
|2039|DPM failed to run the operation because it could not retrieve the ownership information for the targeted computer.|Retry the operation later.|
|2040|DPM failed to access the volume <_VolumeName_> on <_AgentTargetServer_>. This could be caused by cluster failover during backup or insufficient disk space on the volume.|If cluster failover has happened during backup, retry the operation. Otherwise, increase the amount of free disk space on volume <*VolumeName*> on the targeted computer, and then retry the operation.|
|3000|The requested report history could not be found in SQL Server Reporting Services.|No user action is required.|
|3002|DPM could not generate the report. A parameter is missing or was incorrectly specified.|No user action is required.|
|3003|The SQL Server Reporting Services service is not running.|Start the service on the computer on which the DPM database was created. On the **Administrative Tools** menu, select **Services**. Right-click **SQL Server Reporting Services**, and then select **Start**.|
|3004|You don't have sufficient permissions to perform this action on the report.|Make sure that you are a member of the local Administrators group on the DPM server. If the DPM database is on a remote computer, make sure that you are a member of the **DPM Administrators** group on the remote computer.|
|3005|DPM could not generate the report. A parameter is missing or was incorrectly specified.|No user action is required.|
|3008|The SQL Server Agent service <_InstanceName_> is not responding.|Restart the SQL Server Agent service <*InstanceName*>.|
|3009|DPM could not set up a schedule for this report. The information is either missing or it is incorrectly specified.|No user action is required.|
|3010|DPM cannot set up an e-mail subscription for this report. The information may be missing or incorrect.|In the **Actions** pane, select **Options**, and then, on the **SMTP Server** tab, provide the correct SMTP server name and email address.|
|3011|There is not enough content to generate a report for this time period.<br/><br/>The number of days of available data must be at least <_DaysCount_> before DPM can generate this report.|To generate this report, specify at least <*DaysCount*> days.|
|3012|DPM cannot perform this action because no valid property settings have been detected for this report.|To repair the configuration, follow the steps for repairing DPM in [Repairing DPM 2010](/previous-versions/system-center/data-protection-manager-2010/ff399388(v=technet.10)).|
|3013|DPM could not connect to SQL Server Reporting Services.|Restart SQL Server Reporting Services, and then try the operation again.|
|3014|An error occurred causing the reporting job on <_ServerName_> to fail. The system files may be corrupt.|Retry the reporting task. If the problem persists, repair your DPM installation by using the steps described in [Repairing DPM 2010](/previous-versions/system-center/data-protection-manager-2010/ff399388%28v=technet.10%29).|
|3015|DPM is unable to change the e-mail settings.|Log on to <_ServerName_>. On the **Start** menu, point to **All Programs**, point to **Microsoft SQL Server 2008**, point to **Configuration Tools**, and then select **Reporting Services Configuration**. In **Configure Report Server**, update the email settings.|
|3016|A Windows account is required to view DPM reports.|To create the account, reinstall DPM using the steps described in DPM Setup Help.|
|3017|The user account that DPM Reporting created is not enabled.|To re-enable the account, in DPM Administrator Console, on the **Navigation** bar, select **Reporting**. In the **Actions** pane, select **Options**, and then, on the **Reporting Password** tab, enter a valid password.|
|3018|The reporting password for the Windows account has expired.|Change the password for account <_AccountName_>. On the **Administrative Tools** menu, select **Computer Management**. Expand **Local Users and Groups**, and then select **Users**. Right-click **<*AccountName*>**, and then select **Set Password**.|
|3019|ErrorAccessDenied| |
|3020|Unable to configure local Windows account in the system. The operation is allowed only on the primary domain controller for the domain.|Review the error details, take appropriate action, and then retry the operation.|
|3021|DPM is unable to create the Windows account group because the group already exists.|Delete the Windows account group, and then retry the operation.|
|3022|DPM is unable to create the Windows account because the account already exists.|Delete the Windows account, and then retry the operation.|
|3023|DPM is unable to configure the Windows account because the password you entered does not meet the Group Policy requirements.|Enter another password for the account.|
|3024|DPM cannot grant the DPM database access to the <_UserName_> account.|Make sure that SQL Server is running and configured correctly.|
|3025|You are unable to add the local computer to the intranet security zone in Internet Explorer because of insufficient permissions.|Log on as an administrator or backup operator, and then try the operation again.|
|3026|You cannot view the selected report because the Web site <_HttpMachine_> is not in a trusted site zone. Do you want to add the site and view the report?|No user action is required.|
|3027|The report schedule has expired and will be reset.|Check the DPM report settings.|
|3028|You cannot add the computer to the trusted zone.|We recommend that you reinstall Internet Explorer Enhanced Security Configuration. Use **Add or Remove Programs** in Control Panel. select **Add/Remove Windows Components**, and then check **Internet Explorer Enhanced Security Configuration**. However, you can proceed to the report by specifying your user name and password in subsequent steps.|
|3030|DPM is unable to create the report schedule because the date specified has already passed.|Specify today or a later date.|
|3031|Specify today or a later date.|Specify a future date.|
|3034|DPM reporting requires ASP.NET 2.0, which is not found or installed on this computer.|Install ASP.NET 2.0. Use **Add or Remove Programs** in Control Panel. select **Add/Remove Windows Components**, check **Applications Server**, and then select **Details**. select **ASP.NET and Internet Information Services (IIS)**, and then select **OK**.|
|3035|DPM is unable to read the registry to retrieve report settings because of insufficient permissions.|Log on as an administrator, and then retry the operation.|
|3036|DPM reporting cannot query the IIS configuration.|Connect to the computer on which the DPM database was created. Make sure that the Windows Management Instrumentation service is running.|
|3037|ReportingAccessIISFailed| |
|3038|SQL Server Reporting Services is not installed or is not configured properly.|Make sure that SQL Server Reporting Services is properly installed and is running.|
|3039|DPM reporting is not yet activated because the required security settings could not be applied to the DPMReport local account.|On the **Administrative Tools** menu, select **Local Security Policy**. Expand **Local Policies**, and then select **User Rights Assignment**. Right-click **Allow log on locally** policy, and then select **Properties**. Select **Add User or Groups**, and then add the DPMReport account. If the DPMReport account is listed in the **Deny log on locally** policy, remove it.|
|3040|DPM Setup is unable to update the report server configuration to configure e-mail settings.|Log on to <_ServerName_>. On the **Start** menu, point to **All Programs**, point to **Microsoft SQL Server 2008**, point to **Configuration Tools**, and then select **Reporting Services Configuration Manager**. In **Reporting Services Configuration Manager**, update the email settings.|
|3041|DPM is unable to generate reports. This may be because the web.config file for the SQL Server Reporting Services is not valid or is inaccessible.|To resolve this error, do the following:<br/>1. Make sure that the SQL Server Reporting Services is properly installed and running.<br/>2. Make sure that the web.config file is valid.|
|3042|The report might be incorrect because the colocation of data on tape is enabled.|No user action is required.|
|3050|Unable to update shares or share permissions.|Rerun synchronization or wait for the next synchronization to occur. If the problem persists, check your domain configuration.|
|3051|Unable to update the Active Directory Domain Services database.|Either run a synchronization, or wait for the next scheduled synchronization to occur. If the problem persists, check your domain configuration.|
|3052|Active Directory Domain Services schema is not configured properly.|Redo the schema extension operation.|
|3053|No nodes have been detected for cluster <_Cluster_>.|To resolve this error, do the following:<br/>1. On the **Agents** tab in the **Management** task area, make sure that the cluster nodes are accessible.<br/>2. Use the cluster administrative console to make sure that the cluster is still clustered.|
|3054|One or more volumes are missing for the following applications: <_ListOfDataSources_>.|Make sure that the dependent volumes for the data sources are online.|
|3055|DPM is unable to enumerate <_Component_> on computer <_ServerName_>.|Make sure that <*Component*> is accessible to the protection agent.|
|3100|The used disk space on the computer running DPM for the replica of <_DatasourceType_><_DatasourceName_> has exceeded the threshold value of <_ThresholdValue_>%, or there is not enough disk space to accommodate the changed data. If you do not allocate more disk space, synchronization jobs may fail.|Allocate more disk space for the replica. If no free disk space is available in the storage pool, you may need to add physical disks to the computer running DPM.|
|3101|Recovery data for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> in protection group <_ProtectedGroup_> resides on a volume that cannot be detected. All subsequent protection activities relating to <*DatasourceName*> will fail until this volume is brought back online or the replica is re-created.|Make sure that the disk containing the replica volume and the recovery point volume appears in Disk Management. If you are unable to locate the volumes in Disk Management, try following:<ol><li>In the **Management** task area in DPM Administrator Console, on the **Disks** tab, rescan the disk containing the replica volume and the recovery point volume, and then make sure that the volume is back online.</li><li>In the **Protection** task area in DPM Administrator Console, stop protection of the data source by using the **Stop protection of member** option, and then add the data source to a protection group again.</li><ol>|
|3102|AdgMemberChange| |
|3103|DPM failed to obtain catalog information as part of the backup for <_DatasourceType_><_DatasourceName_> on <_ServerName_>. Your recovery point is valid, but you cannot perform item-level recoveries by using this recovery point.|If you don't expect to perform item-level recoveries by using this recovery point, dismiss this alert; otherwise, take the recommended actions:<ol><li>If the operation failed for a short-term backup to disk, in the **Protection** task area, select the data source, and then select **Create recovery point** to restart the backup.</li><li>If the operation failed for a short-term backup to tape, in the **Protection** task area, select all the failed data sources that belong to the same protection group, and then select **Create recovery point - tape**. This will make sure that the tape backups are located on the same tape.</li><li>Dismiss this alert immediately after starting your backup.</li><ol>|
|3104|The replica for <_DatasourceType_> <_DatasourceName_> is currently being synchronized with consistency check. A consistency check can be started automatically or manually. To configure automatic consistency check options, modify this protection group using the Modify Protection Group Wizard. To start a manual consistency check, in the **Protection** task area, in the **Actions** pane, select **Perform Consistency Check**.|No user action is required.|
|3105|The replica of <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is being created. After the initial replica is created, only incremental changes are synchronized.|No user action is required.|
|3106|The replica of <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is inconsistent with the protected data source. All protection activities for data source will fail until the replica is synchronized with consistency check. You can recover data from existing recovery points, but new recovery points cannot be created until the replica is consistent.<br/><br/>For SharePoint farm, recovery points will continue getting created with the databases that are consistent. To back up inconsistent databases, run a consistency check on the farm.|To resolve this error, synchronize with consistency check.|
|3107|DPM cannot run a backup/recovery job on <_PSServerName_> because it is managed by the DPM server <_ServerName_>.|To have this DPM server manage <*PSServerName*>, click the recommended action link that appears below the alert window. This will cause backup/recovery jobs for <*PSServerName*> to fail on DPM server <*ServerName*>.|
|3109|The recovery jobs for <_DatasourceType_> <_DatasourceName_> that started at <_StartDateTime_>, with the destination of <_ServerName_>, are in progress.|No user action is required.|
|3110|The recovery jobs for <_DatasourceType_> <_DatasourceName_> that started at <_StartDateTime_>, with the destination of <_ServerName_>, have completed. Some jobs successfully recovered data and some jobs failed.<br/><br/>The following items could not be recovered: <_TempListOfFiles_>.|Make sure that the file is not already present and in use on the destination computer, and that there is sufficient disk space for the files.|
|3111|The recovery jobs for <_DatasourceType_> <_DatasourceName_> that started at <_StartDateTime_>, with the destination of <_TargetServerName_>, have completed. Most or all jobs failed to recover the requested data.| **Possible solutions** <br/>- In the **Monitoring** task area, on the **Jobs** tab, select **Type** to group the jobs by type to view details of the recovery jobs.<br/>- You may see this error if the VMMS service is down. Retry the action after you start the service.<br/>- If you are seeing this error because of SMB share privileges, you should wait for some time or restart the server and then try the operation again.|
|3112|The recovery jobs for <_DatasourceType_> <_DatasourceName_> that started at <_StartDateTime_>, with the destination of <_ServerName_>, have successfully completed.|No user action is required.|
|3113|Exchange recovery|If you are recovering to Exchange server that is cluster continuous replication (CCR) or local continuous replication (LCR), perform following steps:<ol><li>Reseed the replica of the recovered storage group.</li><li>Resume the storage group copy for the recovered storage group.</li></ol>|
|3114|Recovery point creation jobs for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> have been failing. The number of failed recovery point creation jobs = <_FailureCount_>.<br/><br/>If the data source being protected is SharePoint, select **Error Details** to view the list of databases for which recovery point creation failed.|No user action is required.|
|3115|Since <_OccurredSince_>, synchronization jobs for <_DatasourceName_> on <_ServerName_> have failed. The total number of failed jobs = <_FailureCount_>. The last job failed for the following reason:|No user action is required.|
|3116|DPM failed to stop protection for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>.|If you no longer want to protect any data sources on the computer, you can uninstall the protection agent from the computer. You can also retry the stop protection job.|
|3117|DPM discovered new computers that you may want to protect.|To view a list of the new computers, select **Details**.|
|3118|The replica for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not created. You have chosen to create the replica manually. All subsequent protection activities for this data source will fail until the replica is created and synchronized with consistency check.|To resolve this error, do the following:<ol><li>Manually copy data to the replica path as specified in the details for this data source in the **Protection** task area.</li><li>After you copy the data, select **Protection**  > **Perform consistency check**.</li></ol>|
|3119|The replica for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not created. A replica creation job is scheduled to run at a later time. Data protection will not start until the replica creation is complete.|No user action is required.|
|3120|The disk <_DiskName_> cannot be detected or has stopped responding. All subsequent protection activities that use this disk will fail until the disk is brought back online.|In the **Management** task area, on the **Disks** tab, check the status of the disks. If a disk is missing, rescan the disk configuration to detect the disk. If the disk is still missing, verify physical disk connections, and then scan the disk again. If the disk is no longer available, you can remove the disk from the storage pool. To continue protecting the affected data, stop protection of the data sources by using the **Stop protection of member** option, and then add the data sources to a protection group again.|
|3121|The DPM protection agent on <_ServerName_> is incompatible with this version of DPM. All subsequent protection and recovery activities for <*ServerName*> will fail until the correct version of the agent is installed.|In the **Management** task area, On the **Agents** tab, check the status of the agent and update it to the correct version.|
|3122|The DPM protection agent on <_ServerName_> could not be contacted. Subsequent protection activities for this computer may fail if the connection is not established. The attempted contact failed for the following reason: <_Reason_>|In the **Management** task area, on the **Agents** tab, check the status of the agent.|
|3123|Failed to update permissions used for end-user recovery on <_ServerName_>. Permissions update failed for the following reason: <_Reason_>|No user action is required.|
|3124|DPM network bandwidth usage throttling is not working because the Windows Quality of Service (QoS) Packet Scheduler is not enabled on <_ServerName_>.|Either stop the DPM protection agent service on <*ServerName*>, and then make sure that the QoS Packet Scheduler is enabled, or disable network bandwidth usage throttling for the computer. To install the QoS Packet Scheduler:<br/><br/>In Control Panel, point to **Network Connections**, right-click the appropriate connection, and then select **Properties**. On the **General** tab, select **Install** > **Service** > **Add** > **QoS Packet Scheduler** > **OK**.|
|3125|DPM has discovered new unsupported files or folders on one or more protected volumes. DPM will continue to protect the supported data on these volumes, but will not protect the unsupported data.|No user action is required.|
|3126|The share <_ShareName_> that previously mapped to <_OldFolderPath_> has changed to <_NewFolderPath_>. DPM will continue to protect <*OldFolderPath*>, but we recommend that you modify protection as suggested in the Recommended Action.|To start protecting <*NewFolderPath*>, in the **Protection** task area, perform the following steps:<br/>1. Stop protection for this share.<br/>2. Reprotect the same share.|
|3127|DPM detected multiple disks with the same disk identification number (DiskID). None of these disks will be added to the DPM Storage Pool.|To resolve this error, do the following:<br/>1. Check to see that multipath software is running on the DPM server.<br/>2. In the **Management** task area, on the **Disks** tab, select **Rescan**.|
|3128|DPM detected an inconsistent replica of the data source for <_ListOfDataSources_>. Attempts to fix this may not have been successful. Older recovery points may not be recoverable because of hardware issues on the protected computer or DPM server.|To resolve this error, do the following:<ol><li>Review the System event logs for hardware-related errors on the protected computers and the DPM servers.</li><li>Perform test recoveries of the last recovery point on the volume and the older recovery points that may have issues.</li><li>Manually create new recovery points for the data sources that are indicated in the error.</li><li>Run more frequent integrity checks.</li></ol>|
|3129|DPM has detected an inconsistent replica of the data source during the backup of <_ListOfDataSources_>. This is because of an IO error on a protected server with possible hardware issues.|To resolve this error, do the following:<ol><li>Review the System Event log for any hardware-related errors on the protected computer.</li><li>Run hardware diagnostic tools to verify the health of the hardware.</li><li>Run application-specific integrity checks to make sure of logical consistency of the data. In case of a failure, recover the data from latest recovery point, and then perform an application-specific integrity check. Repeat this process with previous recovery points until you recover a logical consistent recovery point.</li><li>Manually create new recovery points for the data source indicated in the error.</li><li> Run more frequent integrity checks.</li></ol>|
|3130|DPM failed to fixup VHD parent locator post backup for <_DatasourceType_> <_DatasourceName_> on <_ComputerName_>. Your recovery point is valid, but you will be unable to perform item-level recoveries using this recovery point.|To resolve this error, do one or more of the following:<br/><br/>If you don't expect to be performing item-level restores using this recovery point, then dismiss this alert; otherwise, take the following recommended actions:<ol><li>Install the Hyper-V role on the DPM server.</li><li>In the **Protection** task area, select the data source, and then select **Create recovery point** to restart the backup.</li></ol>|
|3131|DPM failed to obtain active virtual hard disk information as part of the backup for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>. Your recovery point is valid, but you will not be able to perform item-level recoveries by using this recovery point.|If you don't expect to perform item-level recoveries by using this recovery point, dismiss this alert; otherwise, take the following recommended actions: <ol><li>Make sure that the Hyper-V WMI provider call succeeds on the Hyper-V host.</li><li>In the **Protection** task area, select the data source, and then click **Create recovery point** to restart the backup.</li></ol>|
|3132|DPM failed to fixup the VHD parent locator after the backup for <_DatasourceType_><_DatasourceName_> on <_ServerName_>, because the operation was canceled. Your recovery point is valid, but you will not be able to perform item-level recoveries by using this recovery point.|If you don't expect to perform item-level recoveries by using this recovery point, dismiss this alert; otherwise, in the **Protection** task area, select the data source, and then select **Create recovery point** to restart the backup.|
|3133|DPM failed to gather item level catalog for <_x_> databases of the SharePoint Farm <_Farm Name_>. Some of the recovery points for these databases in the farm would be associated with an earlier successful catalog.|Restart the catalog job for the SharePoint farm by running the `Start-CreateCatalog` cmdlet in DPM Management Shell.|
|3134|DPM could not obtain backup metadata information for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>. If the data source is a SharePoint farm, a valid recovery point was created. However, content databases from this recovery point can be recovered only by using the alternate location option.|If the data source is a SharePoint farm, make sure of the following:<ol><li>That `ConfigureSharePoint.exe -EnabledSharePointProtection` has been run on the front-end Web server with the current SharePoint farm administrator credentials.</li><li> The SharePoint VSS writer is running on the front-end Web server.</li></ol>|
|3135|Cannot run the catalog job for the data source <_DatasourceName_> because it is not a SharePoint farm.|Rerun the cmdlet by providing a data source that is a SharePoint farm.|
|3136|DPM failed to provide the Windows Group <_GroupName_> read permissions on the replica for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>. Your recovery point is valid, but you may not be able to perform item-level recoveries in an optimized manner using this recovery point.|You may choose to perform unoptimized item-level restores using this recovery point, then dismiss this alert; otherwise in the **Protection** task area, select the data source and select **Create recovery point** to restart the backup.|
|3137|Cannot find the group <_GroupName_>. DPM will automatically recreate this group but optimized item level recovery will fail for older recovery points.|Perform unoptimized item level recovery for older recovery points. This will take more time than it normally takes. Detailed steps to perform this are provided in the documentation.|
|3151|DPM was unable to complete this job within the time allocated.|In the **Monitoring** task area, group jobs by type, and then review the job details. If the next scheduled occurrence of this job is currently running, no action is required. If the job is not currently running, retry the job.<br/><br/>If you retry a synchronization job and it fails again, consider enabling on-the-wire compression. For more information, see [How to Enable On-the-Wire Compression](/en-us/previous-versions/system-center/data-protection-manager-2010/ff399412(v=technet.10)).|
|3152|Choose to send Microsoft anonymous feedback automatically about your hardware and software configurations, and feature usage patterns.|Opt in or opt out of the Customer Experience Improvement Program.|
|3153|AlertAlreadyResolved| |
|3154|Description: New data source found.|For more information, in DPM Administrator Console, in the **Monitoring** task area, review the alert details.|
|3155|Description: Data source is missing.|For more information, in DPM Administrator Console, in the **Monitoring** task area, review the alert details.|
|3158|AlertIDNotFound| |
|3159|Creation of recovery points for <_DatasourceName_> on <_ServerName_> have failed. The last recovery point creation failed for the following reason: <_Reason_>|No user action is required.|
|3160|Synchronization jobs for <_DatasourceName_> on <_ServerName_> have failed.|No user action is required.|
|3161|Recovery data for <_DatasourceName_> on <_ServerName_> in protection group <_ProtectedGroup_> resides on a volume that cannot be detected. All subsequent protection activities relating to <*DatasourceName*> will fail until this volume is brought back online or the replica is recreated.|Make sure that the disk containing the replica volume appears in Disk Management. Or, in the **Protection** task area in DPM Administrator Console, use the **Modify disk allocation** action to allocate replica space.|
|3162|The replica of <_DatasourceName_> on <_ServerName_> is being created. After the initial copy is made, only incremental changes are synchronized.|No user action is required.|
|3163|The replica of <_DatasourceName_> on <_ServerName_> is inconsistent with the protected data source. All protection activities for data source will fail until the replica is synchronized with consistency check.|No user action is required.|
|3164|The recovery jobs for <_DatasourceName_> that started at <_StartDateTime_>, with the destination of <_ServerName_>, are in progress.|No user action is required.|
|3165|The recovery jobs for <_DatasourceName_> that started at <_StartDateTime_>, with the destination of <_ServerName_>, have completed. Some jobs have successfully recovered data and some jobs have failed.|In the **Monitoring** task area, on the **Jobs** tab, sort the jobs by type to view the details of the recovery jobs.|
|3166|The recovery jobs for <_DatasourceName_> that started at <_StartDateTime_>, with the destination of <_TargetServerName_>, have completed. Most or all jobs failed to recover the requested data.|In the **Monitoring** task area, on the **Jobs** tab, filter the jobs by type to view details of the recovery jobs.|
|3167|The recovery jobs for <_DatasourceName_> that started at <_StartDateTime_>, with the destination of <_ServerName_>, have successfully completed.|No user action is required.|
|3168|The DPM database (DPMDB) size has exceeded the threshold limit.<br/><br/>DPM database size: <_DPMDBSize_> GB<br/><br/>DPM database location: <_DPMDBLocation_> on <_ServerName_>.|The DPM database (DPMDB) size cannot be reduced. To resolve this alert, you need to increase the free space in the DPMDB volume, or increase the alert threshold value in the tape catalog retention dialog. If the tape catalog is large, reducing the size of the tape catalog may make sure that DPM database does not grow any further.<br/><br/> **SharePoint** <br/><br/>You may see this warning if you are protecting a large SharePoint farm with millions of items in it. Make sure that you have enough disk space on the DPM database volume for the database to grow.|
|3169|The used disk space on the computer running DPM for the recovery point volume of <_DatasourceType_> <_DatasourceName_> has exceeded the threshold value of <_ThresholdValue_>% (DPM requires 600 MB of internal usage in addition to free space available). If you do not allocate more disk space, synchronization jobs may fail due to insufficient disk space.|Allocate more disk space for the recovery point volume by using the **Modify disk allocation** action in the **Protection** task area. If no free disk space is available in the storage pool, you may need to add physical disks to the computer that is running DPM.|
|3170|DPM could not start a recovery, consistency check, or initial replica creation job for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> for following reason: <_Reason_>|No user action is required.|
|3171|The start time is greater or equal to the end time.|Correct the filter definition.|
|3172|At least one library must be selected in the filter definition.|No user action is required.|
|3173|At least one data source must be selected in the filter definition.|No user action is required.|
|3174|At least one job type and job status must be specified in the filter definition.|No user action is required.|
|3175|Data transferred and time elapsed must be an integer, and greater than or equal to zero, and less than the maximum number size.|No user action is required.|
|3176|Date not entered in the correct format.|No user action is required.|
|3177|The default filter cannot be updated or deleted.|No user action is required.|
|3178|Consolidation of recovery points of the replica failed for <_DatasourceType_><_DatasourceName_> on <_ServerName_> when one of the following operations was being performed:<br/>1. Express full backup<br/>2. Consistency check<br/>3. Recovery|If you are seeing this error, the following are a list of possible solutions:<ul><li> In the **Monitoring** task area, check the **Alerts** tab to locate the specific alert for one of the operations indicated above. Follow the recommended action for that alert. If you do not find any active alerts for the operations indicated above, click the link that appears below the alert window to inactivate this alert.</li><li>Run consistency check and retry the operation again.</li></ul>|
|3179|A filter with the specified name already exists.|Specify a different filter name.|
|3180|DPM could not run the backup/recovery job on <_PSServerName_> because it is managed by the DPM server <_ServerName_>.|To resolve this error, do the following:<br/>1. Resolve any active Agent ownership required alert for the computer.<br/>2. To rerun the failed job, click the link that appears below the alert window.|
|3181|Some computers in the protection group have not been synchronized for <_ThresholdValue_> days.|To review the list of computers that DPM has not backed up, click **View Error Details**, and then take the appropriate action. To modify the number of days after which DPM should display an alert for client computers that are not being backed up, modify the protection group properties.|
|3182|The recovery jobs for <_DatasourceType_> <_DatasourceName_> that started at <_StartDateTime_>, with the destination of <_ServerName_>, have successfully completed.<br/><br/>Virtual machine recovery to alternate host is complete.|Verify the virtual machine configuration before starting it. You may need to reconfigure the network adapter for the virtual machine on the alternate host before starting it.|
|3183|The backup SLA is not being met for the following computers:<br/><br/> <_ServerName_>|No user action is required.|
|3184|DPM could not run the backup/recovery job for the data source because it is owned by a different DPM server.<br/><br/>Data source: <_DatasourceName_> <br/><br/>Owner DPM Server: <_ServerName_>.|<br/>1. Either stop protecting this data source from this DPM server or take over ownership of the data source for this DPM server.<br/>2. After taking ownership, click on the link below to rerun the failed job.|
|3185|DPM could not run the backup job for the data source because the number of currently running backup and recovery jobs on the Production server has reached its limits.<br/><br/>Data source: <_DatasourceName_> <br/><br/>Production Server: <_ServerName_>.|Reduce the number of backup/recovery jobs running on this production server, or wait for some backup and recovery jobs to complete and retry the operation.|
|3186|DPM could not run the recovery job for the data source because the number of currently running backup and recovery jobs on the Production server has reached its limits.<br/><br/>Data source: <_DatasourceName_> <br/><br/>Production Server: <_ServerName_>.|Reduce the number of backup/recovery jobs running on this production server, or wait for some backup and recovery jobs to complete and retry the operation.|
|3187|Creation of online recovery points for <_DatasourceName_> on <_ServerName_> have failed. The last online recovery point creation failed for the following reason:| |
|3188|Creation of online recovery points for <_ServerName_> have failed. The last online recovery point creation failed for the following reason: (ID: 3188)<br/><br/>Windows Azure Backup Agent was unable to create a snapshot of the selected volume. (ID: 100034)|This can occur if the DPMWriter service isn't running. To resolve the issue, set the DPMWriter service to **Automatic**, and make sure that the service is started.|
|3189|Online backup could not be started for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> as one or more jobs are in progress.| |
|3190|Online backup skipped for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>.| |
|3200|Could not access end-user recovery-specific information in Active Directory Domain Services.|Check the domain configuration to make sure that the DPM schema extension has been successfully applied to the Active Directory. Also verify that DPM has permissions to access the data in the extended schema.|
|3201|DPM failed to log in with the specified user name and password.|Check your user name and password, and then retry the operation.|
|3202|Could not access end-user recovery-specific content in Active Directory Domain Services.|Rerun synchronization or wait for the next synchronization to occur. If the problem persists, check your domain configuration.|
|3210|The wizard was interrupted before <_ProductName_> could complete successfully.|The system has not been modified. To install this program at a later time, run the installation again.|
|3211|Your system has not been modified. To install this program at a later time, run the installation again.|No user action is required.|
|3212|Data Protection Manager Active Directory Domain Services update error.|No user action is required.|
|3213|Active Directory Domain Services could not be configured.|No user action is required.|
|3214|Configuration failed because the account used is not a member of the Schema Admins group.|Try again, using an account that is a member of the Schema Admins group.|
|3215|Active Directory Domain Services could not be configured because the domain could not be found.|Make sure that the domain name is properly constructed. The following example shows a properly constructed domain name: city.corp.contoso.com.|
|3216|Active Directory Domain Services could not be configured because the DPM computer with the specified name could not be found.|No user action is required.|
|3217|The computer name you entered is not valid.|Enter the name of the DPM computer that should be given access to the end-user recovery data in Active Directory Domain Services.|
|3218|Not a valid DPM computer name.|No user action is required.|
|3219|Configuration failed because this computer is not in the given domain, the domain cannot be found, or the account used doesn't have Active Directory Domain Services update privileges.|No user action is required.|
|3221|DPM was unable to configure Active Directory Domain Services for end-user recovery because a recent change to Active Directory Domain Services has not yet been replicated between domain controllers.|Make sure that the schema master replicates the latest changes to at least one domain controller, and then retry the operation.|
|3222|Invalid domain name.|Provide the complete domain name in FQDN format.|
|3223|The DNS domain name you entered is not valid.|Specify the DNS domain name of the DPM server to which you want to grant access to end-user recovery data in Active Directory Domain Services.|
|3301| <_LibraryType_> <_Library_> could not be contacted. All jobs for <*LibraryType*> <*Library*> will fail if the connection is not established.|No user action is required.|
|3302| <_LibraryType_> <_Library_> is not functioning efficiently for the following reason:<br/><br/>The drive information for <*LibraryType*> <*Library*> is incorrect and needs to be refreshed.|The number of drives reported for this library is different from the number of drives detected by DPM. If any drives are out of the library for servicing, ignore this alert; otherwise, remap the drives within the library manually. For information about remapping tape library drives, see [Remap a tape drive](/previous-versions/system-center/system-center-2012-R2/jj628138(v=sc.12)).|
|3303|Library drive < _LibraryDrive>_ in <_Library_> is not functioning and library jobs may fail until the drive is repaired. The drive is not functioning for the following reason: <_Reason_>|No user action is required.|
|3304|DPM has marked the <_MediaLabel_> tape as decommissioned, which means that data cannot be written to this tape in the future. You may be able to recover data from this tape.|This tape is decommissioned and should be removed from the library. You may be able to recover data from this tape. If recovery from this tape fails, check for a duplicate or older copy of the data.|
|3305|The number of free tapes in the <_LibraryType_> <_Library_> is less than or equals the threshold value of <_ThresholdValue_>. You must add tape to the library and mark it as free in order to prevent future backups from failing.|Add tape to the library and mark it as free.|
|3308| <_MediaLabel_> could not be erased for the following reason: <_Reason_>|No user action is required.|
|3309|Data on the tapes <_MediaList_> cannot be verified for the following reason: <_Reason_>|No user action is required.|
|3310|The data copy job failed for the following reason: <_Reason_>|No user action is required.|
|3311|The back up to tape job failed for the following reason: <_Reason_>|Look at the suberror and take appropriate action.|
|3312|The backup to tape job completed, but the catalog was not built correctly for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>. Although no data is lost, you must rebuild the catalog to access the data of the backup job.|No user action is required.|
|3313|Verification is complete for the following tapes in <_LibraryType_> <_Library_>: <_MediaList_>|No user action is required.|
|3314|The recovery job is paused because the required tape is not available in <_LibraryType_><_Library_>.|Insert the required tape in the library through the I/E port or by unlocking the library door. If you insert the required tape without using the **Add tape (I/E port)** or **Unlock Door** actions on the **Libraries** tab in the **Management** task area, select **Continue Job** in the **Details** section of this alert.|
|3315| <_TaskName_> is paused because the required tape <_MediaLabel_> is not available in the library <_LibraryType_> <_Library_>.|Insert the tape with label <*MediaLabel*> in the library through the I/E port or by unlocking the library door. If you insert the required tape without using the **Add tape (I/E port)** or **Unlock Door** actions on the **Libraries** tab in the **Management** task area, select **Continue Job** in the **Details** section of this alert.|
|3316|The detailed inventory of tape failed for the following reason: <_Reason_>|No user action is required.|
|3317|Data verification of <_DatasourceName_> on tape <_MediaList_> in <_LibraryType_> <_Library_> found data integrity issues on the following files:<br/><br/> <_TempListOfFiles_>|No user action is required.|
|3500|Your search returned more than 250 results. Only 250 results can be displayed.|Use the search controls to refine your search.|
|3598|This action will set this DPM's ownership on <_PSServerName_>. This will result in the backup or recovery jobs for <*PSServerName*> on the DPM server <_ServerName_> to fail.<br/><br/>Do you want to set ownership?|No user action is required.|
|3599|This action will set this DPM's ownership on <_PSServerName_>. This will result in:<br/>1. Backup or recovery jobs for <*PSServerName*> on the DPM server <_ServerName_> to fail.<br/>2. Backup or recovery jobs currently running on <*PSServerName*> to be canceled. <br/><br/>Do you want to set ownership?|No user action is required.|
|3600|This action will rerun the selected job. Do you want to run this job again?|No user action is required.|
|3601|This action will cancel the selected job. Do you want to cancel this job?|No user action is required.|
|3602|This action will start a new recovery job for the failed recoveries. Do you want to continue?|No user action is required.|
|3603|To cancel pending replica creation for <_VolumeName_> on <_ServerName_>, remove all members from the protection group <_ProtectedGroup_> that reside on this volume.|To reschedule replica creation, add the members back to the protection group.|
|3604|The protection group configuration has changed and therefore this job cannot be rerun.|In the **Monitoring** task area, on the **Jobs** tab, rerun this job.|
|3605|This job cannot be rerun because the data is not valid.|To retry, in the **Recovery** task area, copy the data to tape by using the Recovery Wizard.|
|3606|This job cannot be rerun because the data is not valid.|To retry, in the **Recovery** task area, in the **Actions** pane, select **Verify data**.|
|3607|This job cannot be rerun because the data is not valid.|To retry, in the **Recovery** task area, recatalog the tape's contents.|
|3608|Rerunning this job will back up this data source to a new tape. If you want all data sources in this protection group to be backed up to the same tape, select the Alerts tab, select one of the backups to tape failure alerts for this protection group, and then in the Details section of this alert, select Rerun backup to tape job .<br/><br/>Do you want to back up this data source to a new tape?|No user action is required.|
|3609|This job cannot be rerun because the protection group associated with it has been modified.|No user action is required.|
|3610|Inactivating these alerts will also change protection status to OK in the Protection task area and the alerts will be resolved in Operations Manager. Do you want to inactivate the selected alerts?|No user action is required.|
|3611|The job cannot be rerun because a dependent job is still running for a data source that is a part of this Windows SharePoint Services data source.|Retry the operation when the dependent jobs have completed for all dependent data sources.|
|3700|An incompatible version of the database was detected. DPM cannot open DPM Administrator Console.|Restore a valid database, and then retry the operation. For more information, see [Back up with a secondary DPM server](/system-center/dpm/back-up-the-dpm-server#back-up-with-a-secondary-dpm-server) and [What's supported and what isn't for DPM?](/system-center/dpm/dpm-support-issues) |
|3750|Version <_DatabaseVersion_> of the DPM database and version <_BinariesVersion_> of the DPM application are not compatible.|Restore a valid database, and then retry the operation. For more information, see [Back up with a secondary DPM server](/system-center/dpm/back-up-the-dpm-server#back-up-with-a-secondary-dpm-server) and [What's supported and what isn't for DPM?](/system-center/dpm/dpm-support-issues). |
|3751|The evaluation copy of DPM has expired.|You must purchase a DPM license. For details about obtaining a DPM license, see [How to buy System Center](https://www.microsoft.com/cloud-platform/system-center-pricing).|
|3752|DPM could not find the MSDPMTrustedMachines security group. Either this group has been deleted or the entry is corrupt.|Uninstall DPM, and then reinstall DPM to recreate the security group.|
|3753|The version of the DPM database installed on this computer is later than the version of the DPM application.|To continue using DPM, you must install any service packs or hotfixes that were part of your previous DPM installation.|
|3754|DPM Administrator Console can be opened only by a user belonging to a domain.|Log on using a domain user account, and then try again.|
  
## Error codes 4000-5999

|Error code|Message|Additional information|
|---|---|---|
|4001|There is insufficient disk space on system volume <_SystemDrive_> to complete the installation.|To continue with the installation, free up <_SystemDiskSpaceRequired_> MB of disk space on the system volume.|
|4002|The SQL Server Reporting Services installation is not valid because it is installed on a computer on which Internet Information Services (IIS) or ASP.NET is not installed.|Uninstall SQL Server, and then install DPM again to install the prerequisite software.|
|4003|The installation of Reporting Services is not correctly configured or no instance of Reporting Services is linked to <_InstanceName_> of SQL Server.|<br/>1. To use the local dedicated <*InstanceName*> instance with DPM, uninstall SQL Server and run the program again.<br/>2. To use the option of installing DPM with an existing instance of SQL Server, make sure that the Reporting Services instance is also installed and linked correctly. For information about installing DPM and its prerequisites, see [Get DPM installed](/system-center/dpm/install-dpm).|
|4005|DPM found the following databases that were created by an earlier installation of SQL Server Reporting Services: <_CommaSeparatedDatabaseName_>.|Setup will delete these databases.|
|4006|Service <_Name_> is running under <_Credentials_> credentials. <*Name*> must run under local user credentials.|DPM Setup will change the credentials to a local user account.|
|4007|Service <_Name_> is not installed. The <_Prerequisite_> installation is not valid.|Uninstall <*Prerequisite*> and then run the program again.|
|4012|The <_Name_> service is running under <_Credentials_> credentials. We recommend that the service run under the NT Authority NETWORK SERVICE account.|In the Reporting Services Configuration tool, choose **Service account**, and then change the settings to the built-in Network Service account for <_SqlInstance_> instance of SQL Server.|
|4015|You installed DPM protection agents on several computers. We recommend that you uninstall them before proceeding.|In DPM Administrator Console, select **Management** on the Navigation bar. On the **Agents** tab, select the agents, and then select **Uninstall**.|
|4017|DPM database <_DpsDb_> is missing or corrupt.|If you are performing a clean installation of DPM, you must delete the DPM database before you run Setup. If you are upgrading or repairing an existing installation of DPM, you must restore a valid DPM database, and then proceed with Setup.|
|4019|There is an existing DPM database in the <_SqlInstance_> instance of SQL Server. DPM cannot be installed on an existing database.|In SQL Server Management Studio, delete the <_DpsDb_> database, and then run the program again. If you need to reuse an older DPM database, back up the database and restore it after completing the DPM installation.|
|4020|DPM Setup detected several existing protection groups.|In DPM Administrator Console, in the **Protection** task area, remove the groups from protection, and then run DPM Setup again.|
|4021|You cannot proceed because Active Directory Domain Service is not accessible.|Verify that the computer is joined to a domain, that DNS is correctly configured, and that you are logged on as a domain user with administrator privileges and run the program again.|
|4023|The <_Prerequisite_> installation failed. All changes made by the <*Prerequisite*> installation to the system were rolled back.|Manually install <*Prerequisite*>. For information about installing DPM and its prerequisites, see [Get DPM installed](/system-center/dpm/install-dpm).|
|4024|The <_Prerequisite_> installation failed. All changes made by the <*Prerequisite*> installation to the system were rolled back.|Manually install <*Prerequisite*>. For information about installing DPM and its prerequisites, see [Get DPM installed](/system-center/dpm/install-dpm).|
|4025|The <_Prerequisite_> configuration failed.|Use Add or Remove programs in Control Panel to uninstall <*Prerequisite*>. After uninstalling <*Prerequisite*>, run DPM Setup again.|
|4026|DPM Setup failed to configure the service <_ServiceName_>.|Use **Add or Remove Programs** in Control Panel to uninstall DPM. After uninstalling, run DPM Setup again.|
|4027|DPM Setup was unable to collect information about volumes in the storage pool because access to the database was denied.|Manually delete the volumes allocated to the storage pool or format the disks.|
|4028|Setup was unable to delete the <_DbName_> database.|Manually delete the database using SQL Server Management Studio.|
|4029|Setup was unable to delete the schedules from the master database.|Open SQL Server Management Studio, and connect to the DPM instance of SQL Server. Expand the instance of SQL Server, browse to SQL Server Agent, and then in Jobs, delete the <_ScheduleCategory_> category.|
|4030|Setup was unable to remove reports deployed with SQL Server Reporting Services.|If you are reinstalling DPM on this computer, no action is necessary. If you are not reinstalling DPM, you must uninstall SQL Server to remove the reports.|
|4031|The computer <_ComputerName_> could not be removed from the intranet security zone settings in Internet Explorer.|In Internet Explorer, on the Tools menu, select **Internet Options**. In the **Internet Options** dialog box, on the **Security** tab, select **Local intranet** > **Sites** > **Advanced**, and then remove computer <*ComputerName*> from the intranet zone.|
|4032|DPM could not delete the <_AccountName_> user account.|Manually delete the <*AccountName*> account.|
|4033|DPM Setup could not remove the DPM Administrator Console shortcuts from: <_CommaSeparatedShortcutLocations_>.|Manually delete the DPM Administrator Console shortcuts.|
|4034|DPM Setup could not delete service <_ServiceName_>.|Manually delete service <*ServiceName*>. On the **Administrative Tools** menu, select **Services**.|
|4035|DPM Setup could not delete the <_GroupName_> group on computer <_ComputerName_>.|Delete the group manually. On the **Administrative Tools** menu, select **Computer Management**. Expand **Local Users and Groups**, and then select **Groups**. Right-click <*GroupName*>, and then select **Delete**.|
|4036|The DPM database was removed; however, DPM could not remove database files <_DataFilesCompleteLocation_>.|Delete the database files manually.|
|4037|To finish deleting service <_ServiceName_>, you must restart the computer.|Restart your computer.|
|4038|DPM Setup was unable to unmount the volumes from <_VolumesDir_>.|Manually unmount the volumes using Disk Management.|
|4039|This computer has less than the recommended amount of memory for optimal performance of DPM. The recommended amount of memory is 2 GB.|Add more memory to this computer or install DPM on a different computer.|
|4040|DPM Setup has detected that this computer is a domain controller.|Before proceeding with the DPM Setup, make sure that you have followed the steps given in the link that appears below the alert window.|
|4045|DPM Setup was unable to set permissions on folder <_DirectoryPath_>.|Verify that the folder <*DirectoryPath*> is a valid location and that the current user has access to the location.|
|4046|DPM cannot delete <_FileName_>.|Verify that the current user has permissions to delete the file.|
|4047|DPM Setup was unable to configure service <_SetupServiceName_>.|Review the error details, take the appropriate action, and then try running DPM Setup again.|
|4051|There is insufficient disk space on the program files volume <_BinaryDrive_> to complete the installation.|To continue the DPM installation, free up <_BinaryDiskSpaceRequired_> MB of disk space on the volume.|
|4052|You cannot install DPM on a server if a DPM protection agent has been installed it.|No user action is required.|
|4053|DPM Setup was unable to remove the protected computers from the DComUsersGroup group.|Delete the protected computers from the group. On the **Administrative Tools** menu, select **Computer Management**. Expand **Local Users and Groups**, and then select **Groups**. Select **Distributed COM users** in the right pane and remove the entries for the protected computers from this group.|
|4054|Setup was unable to add protected computers to the DCom Users Group group.|Review the error details. Use **Add or Remove Programs** in Control Panel to uninstall DPM, and then run DPM Setup again.|
|4056|DPM Setup was unable to add DPM to the Windows Firewall Exceptions.|Review the error details. In Control Panel, click **Windows Firewall**, and on the **General** tab, verify that the Don't allow exceptions option is unchecked. Use **Add or Remove Programs** in Control Panel to uninstall DPM and then run DPM Setup again.|
|4057|There is insufficient disk space on the database volume  <_DatabaseDrive_> to complete the installation.|To continue with the installation, free up  <_DatabaseDiskSpaceRequired_> MB of disk space on the volume.|
|4065|You did not specify the user name.|Specify a user name.|
|4066|You did not specify a company name.|Specify a company name.|
|4067|The number of DPM licenses must be greater than or equal to zero.|Specify a number for the DPM licenses greater than or equal to zero.|
|4068|Installation source <_FolderPath_> for installing prerequisites either does not exist or cannot be accessed or Setup cannot find one or more prerequisites at the location.|Make sure that the DPM installation DVD is copied correctly and rerun Setup.|
|4069|The input <_InputParameterTag_> is mandatory.|Specify a valid input <*InputParameterTag*>.|
|4070|The prerequisite check failed with errors.|Review the errors in the DPM setup log file <_SetupLogFile_>. Resolve the errors, and then run DPM Setup again.|
|4071|DPM Setup could not delete the DPM Administrator Console shortcut from: <_CommaSeparatedShortcutLocations_>.|Delete the shortcuts manually.|
|4072|The specified path <_FileName_> is invalid.|Specify a valid path and verify that the path is accessible.|
|4073|The command-line argument <_CommandlineArgument_> is invalid.|For information about installing DPM and its prerequisites, see [Get DPM installed](/system-center/dpm/install-dpm#BKMK_SQL).|
|4074|The path <_FileName_> exceeds <_MaxLimit_> characters.|Choose a path with a shorter length.|
|4075|The command-line argument <_CommandlineArgument_> is already specified.|For information about installing DPM and its prerequisites, see [Get DPM installed](/system-center/dpm/install-dpm#BKMK_SQL).|
|4076|The value for <_CommandlineArgument_> was not specified.|For information about installing DPM and its prerequisites, see [Get DPM installed](/system-center/dpm/install-dpm#BKMK_SQL).|
|4077|DPM is not installed on this computer.|Run DPM Setup from the DPM product DVD.|
|4078|DPM is already installed on this computer.|To uninstall DPM, use **Add or Remove Programs** in Control Panel.|
|4079|DPM is not installed on this computer.|To install DPM, see [Installing DPM](/system-center/dpm/install-dpm).|
|4080|No IN file is specified in the command line.|For information about installing DPM and its prerequisites, see [Get DPM installed](/system-center/dpm/install-dpm#BKMK_SQL).|
|4081|DPM configuration failed.|For information about installing DPM and its prerequisites, see [Get DPM installed](/system-center/dpm/install-dpm#BKMK_SQL).|
|4082|DPM cannot start service <_SetupServiceName_>.|Start the service manually. On the **Administrative Tools** menu, select **Services**. Right-click <*SetupServiceName*>, and then select **Start**.|
|4083|DPM setup could not configure agents.|For information about installing DPM and its prerequisites, see [Get DPM installed](/system-center/dpm/install-dpm#BKMK_SQL).|
|4085|DPM setup could not extract the prerequisites.|For information about installing DPM and its prerequisites, see [Get DPM installed](/system-center/dpm/install-dpm#BKMK_SQL).|
|4086|DPM has been successfully installed. However, DPM Setup could not delete the extracted folder <_FolderPath_>.|Delete folder <*FolderPath*> manually.|
|4087|DPM Setup could not delete the extracted folder <_FolderPath_>.|Delete folder <*FolderPath*> manually.|
|4089|DPM Setup could not configure the database <_Database Name_>.|Verify that the MSSQL$<_InstanceName_> service is started. If the service is not started, on the Administrative Tools menu, click Services. Right-click MSSQL$<*InstanceName*>, and then click **Start**.|
|4096|CmdProcXmlTooLarge| |
|4097|DPM Setup was unable to remove the following registry keys: `CommaSeparatedRegKeys`.|Delete the registry keys using **Microsoft Registry Editor**.|
|4103|DPM setup detected that installed DPM version doesn't support upgrade. Uninstall current DPM version and rerun setup.|Uninstall current DPM version and then rerun setup.|
|4105|DPM setup detected that this DPM machine doesn't have latest updates installed. Install System Center 2016 UR4 Data Protection Manager <_KBnumber_> and then rerun the setup.|Install System Center DPM2016 UR4 <*KBnumber*> from <_KBLink_> and then rerun the setup.|
|4200|The DPM Writer service could not be accessed.|Review the Application Event log for more details. Verify that DPM is installed and that the DPM Writer service is running.|
|4201|The backup operation did not complete successfully. Some backup shadow copies could not be created.|Ensure that the DPM replicas are not busy and retry the operation.|
|4202|The backup operation failed. At least one replica volume does not have enough disk space for the backup shadow copy.|For more information, see [Monitoring DPM](/system-center/dpm/monitor-dpm).|
|4204|DpmBackup could not delete the backup shadow copies that were previously created.|For more information, see [Monitoring DPM](/system-center/dpm/monitor-dpm).|
|4205|DpmBackup was unable to back up either the DPM database or the DPM Report database.|Review the event log for details of the failure. For more information, see [Monitoring DPM](/system-center/dpm/monitor-dpm).|
|4206|DPM Writer could not connect to the <_DatabaseName_> database.|Make sure that the SQL Server instance used by DPM is running and is accessible over network.|
|4207|DPM Writer could not query the <_DatabaseName_> database.|Make sure that the SQL Server instance used by DPM is running and is accessible over network.|
|4208|DPM Writer could not access the registry.|Make sure that Data Protection Manager is installed correctly.|
|4209|DPM Writer encountered an internal error.|Restart the DPM Writer service, and then try the backup operation again. For additional troubleshooting information, review the application event log. For more information, see [Monitoring DPM](/system-center/dpm/monitor-dpm).|
|4210|DpmBackup encountered an internal error.|Check the Application Event Log for the cause of the failure. Fix the cause and retry the operation. For more information, see [Monitoring DPM](/system-center/dpm/monitor-dpm).|
|4211|You do not have sufficient privileges to perform this operation.|On the DPM server, use Event Viewer to view details for this event. The details are available in the application event log.|
|4212|DpmWriter service encountered an error during PrepareBackup as more than one component is selected for backup in the same snapshot set.|Select a single DPM replica for backup and try the operation again.|
|4213|The backup operation failed. DpmBackup was unable to start the DPM Writer service.|On the DPM server, use Event Viewer to view details for this event. The details are available in the application event log.|
|4214|DpmBackup was unable to stop the DPM Writer service.|Stop the service manually by using the MMC Services snap-in.|
|4216|DpmPathMerge could not query the <_DatabaseName_> database.|Make sure that the SQL Server services are running with appropriate privileges.|
|4217|DpmPathMerge could not access the registry.|Make sure that Data Protection Manager is installed correctly.|
|4218|DpmPathMerge encountered an internal error.|Try the operation again. For more information, see [Monitoring DPM](/system-center/dpm/monitor-dpm).|
|4219|Either because this replica was restored from a backup that was not created using the DpmBackup tool, or because the GUID of the protected volume has changed since the backup was created, DpmPathMerge cannot automatically remove extraneous path information.|To ensure that this replica is consistent with the protected data, run the FsPathMerge tool to manually remove extraneous path information from the restored replica. For instructions for using FsPathMerge, see [Archiving and Restoring Data](/previous-versions/system-center/data-protection-manager-2006/cc161432(v=technet.10)).|
|4220|DPM writer was unable to snapshot the replica of <_DatasourceName_>, because the replica is not in a valid state (Validity: <_Validity_>).|In DPM Administrator Console, run a consistency check for the data source to ensure that the replica is consistent.|
|4221|DPM Writer has timed out waiting for replica to be free and available for snapshot.|Try the operation again when no jobs are running for the selected data source.|
|4222|DPM has run out of free recovery point space and will fail snapshots for <_DatasourceName_> in order to prevent existing recovery points from getting recycled.|<br/>1. Increase the space allocated for the recovery point volume for <*DatasourceName*>.<br/>2. Retry the operation after increasing the space for the recovery point volume.|
|4223|DPM writer was unable to snapshot the replica of <_DatasourceName_>. This may be due to:<br/><br/>1) No valid recovery points present on the replica.<br/><br/>2) Failure of the last express full backup job for the datasource.<br/><br/>3) Failure while deleting the invalid incremental recovery points on the replica.|In DPM Administrator Console, run an express full backup job for the data source.|
|4300|DPM Setup could not delete the DPMRA service.|Delete the DPMRA service manually. At the command prompt, run the `sc delete DPMRA` command.|
|4301|DPM Setup was unable to uninstall the Dr. Watson version that DPM installed.| |
|4304|The Microsoft Hyper-V Role and PowerShell Management Tools windows feature are not installed. This software is required for Data Protection Manager to run correctly.|To install, run `start /wait dism.exe /Online /Enable-feature /All /FeatureName:Microsoft-Hyper-V /FeatureName:Microsoft-Hyper-V-Management-PowerShell /quiet /norestart`  from the command-line and restart the computer. Then run DPM Setup again|
|4305|There is a previous version of Microsoft Management Console on this computer.| |
|4306|DPM Setup is unable to use the credentials provided to log on as <_UserName_>.|Review the error log for details. Verify that the Remote SQL Server administrator credentials you provided are correct and that they have logon permissions on the local computer.|
|4307|DPM Setup is unable to connect to the specified instance of SQL Server.| **Possible Cause:** <br/>Remote connection to the computer running SQL Server is disabled.<br/><br/> **Resolution:** <br/>To enable the remote instance of SQL Server, do the following:<br/>1. From the Start menu, point to **All Programs**, point to **Microsoft SQL Server 2008**, point to **Configuration Tools**, and then select **SQL Server Configuration Manager**.<br/>2. In SQL Server Configuration Manager, in the console pane, expand **SQL Server Network Configuration**, and then select the network protocol for the DPM named instance.<br/>3. In the **Details** pane, if TCP/IP is disabled, right-click **TCP/IP** and select **Enable**.<br/><br/> **Possible Cause:** <br/>The SQL Server Browser service is disabled.<br/><br/> **Resolution:** <br/>To start the SQL Server Browser service, do the following:<br/>1. In SQL Server Configuration Manager, in the console pane, select **SQL Server Services**.<br/>2. In the Details pane, right-click **SQL Server Browser**, and then select **Properties**.<br/>3. In the **SQL Server Browser Properties** dialog box, on the **Service** tab, select **Automatic** from the **Start Mode** drop-down list, and then select **OK**. <br/><br/>**Note**<br/>By default, Microsoft SQL Server sets the SQL Server Browser service to start automatically.<br/><br/> **Possible Cause:** <br/>Make sure that the remote instance of SQL Server is in the following format:<br/><_ComputerName_>\\<_InstanceName_><br/><br/> **Note** <br/>Only use <*ComputerName*> for the default instance.<br/><br/> **Possible Cause:** <br/>There is no network connectivity between the DPM server and the computer running SQL Server.<br/><br/> **Resolution:** <br/>Make sure there is a connection between the DPM server and the computer running SQL Server.|
|4308|An invalid SQL Server instance was specified.|Specify a valid instance of SQL Server.|
|4311|SQL Server Management Tools are not installed on this machine. Install SQL Server tools compatible with the installed SQL Server version.| |
|4312|The Removable Storage service is running. To install DPM correctly, DPM Setup will stop and disable this service.| |
|4313|DPM Setup could not delete the DPM Library Agent service.|Delete the service manually. At the command prompt, type `sc delete DPMLA`.|
|4314|DPM Setup was unable to share the folder <_InstallLocation_>\Temp as MTATempStore$.|Review the error details, take the appropriate action, and then run DPM Setup again.|
|4315|DPM Setup could not configure the security settings for this computer.|Verify that the DPM server is a member of a domain and that a domain controller is running. Additionally, verify that there is network connectivity between the DPM server and the domain controller.|
|4316|DPM Setup was unable to configure the DPMRATrustedMachines Group security settings.|Review the error details, take the appropriate action, and then run DPM Setup again.|
|4317|DPM Setup failed to disable the Removable Storage service (NtmsSvc).|Manually stop and disable the **Removable Storage** service. On the **Administrative tools** menu, select **Services**. Right-click **Removable Storage**, and then select **Stop**. Then run DPM Setup again.|
|4318|DPM Setup failed to create the `DPMRADCOMTrustedMachines` or `DPMRADmTrustedMachines` group.|Review the error details, take the appropriate action, and then run DPM Setup again.|
|4319|DPM has been successfully installed. However, you must restart the computer to complete the DPM installation.|Restart the computer to complete the DPM installation.|
|4321|DPM cannot access registry key <_RegistryKey_> on computer <_ComputerName_>.|Verify that the registry key exists, that user <_UserName_> has full permissions, and that the **Remote Registry** service is running on this computer and computer <*ComputerName*>.|
|4323|Error: DPM Setup failed to add a user to the local group. Review the error details, take the appropriate action, and then run DPM Setup again.<br/><br/>ID: 4323. Details: A member could not be added to or removed from the local group because the member does not exist.|This issue can occur if the environment has a disjointed namespace (that is, if the domain has different NetBIOS and DNS names). For more information about how to resolve this issue, see [System Center 2012 R2 Data Protection Manager install fails and generates ID: 4323: "A member could not be added"](https://support.microsoft.com/help/2930276).|
|4324|You cannot choose the instance <_InstanceName_> on the local machine.|Specify a different instance to install DPM or choose the option to let DPM install its own SQL Server instance. If DPM's SQL Server instance already exists, it will be reused.|
|4325|DPM Setup failed to get the fully qualified domain name for either the computer running DPM or the computer with the selected instance of SQL Server.|Verify that computers are joined to the same domain, that the DNS client service is running, and that DNS is accessible over the network. Then run DPM Setup again.|
|4326|DPM Setup failed to create certificate stores required for DPM.|Review the error details, take the appropriate action, and then run DPM Setup again.|
|4327|Setup failed to delete the certificate stores created for DPM.|At a command prompt, run `certutil.exe -delstore` to delete the certificates in `DPMBackStore` and `DPMRestoreStore`.|
|4328|The service <_Name_> is running under <_Credentials_> credentials. It should be running under domain user credentials or Local System account.|Run SQL Configuration tool on the computer running SQL Server to change the account for the services. Then run the program again.|
|4330|DPM Setup could not remove the account <_UserAccountName_> from the group <_GroupName_>.|Manually delete account <*UserAccountName*> from the group.|
|4331|DPM Support Files on the SQL Server computer <_ComputerName_> were not removed.|If no other DPM server is using the server for hosting the DPM database, uninstall the DPM Support Files using **Add or Remove Programs** in Control Panel.|
|4332|Could not query database <_DatabaseName_> from the <_InstanceName_> instance of SQL Server.|Review the error message and retry the action:<br/> <_ExceptionMessage_> |
|4333|This application is already installed on this computer.|You can access this application from the **Start** menu.|
|4337|The DPM protection agent is not installed on the computer <_ComputerName_>.|Install the agent and try the operation again.|
|4338|Could not find configuration for <_ComputerName_>.|Enter a valid name for a computer configuration to migrate.|
|4339|Failed to copy file from <_SourceLocation_> to <_DestinationLocation_>.|Review the error details and take appropriate action. Then retry the operation.|
|4340|There is insufficient disk space on the database volume  <_DatabaseDrive_> on <_ComputerName_>.|Free  <_DatabaseDiskSpaceRequired_> MB of disk space on the volume to continue.|
|4341|Setup cannot query the SQL Server.|Make sure that SQL Server service is running.|
|4342|A restart is required to complete the uninstallation of Data Protection Manager.| |
|4344|Microsoft System Center DPM Support Files are not installed on the SQL Server.|Install SQL Server Prep from setup.exe located on the installation DVD or installation share, and try again.|
|4345|The selected SQL Server has an older version of Microsoft System Center DPM Support Files installed.|Run SQLPrepInstaller.exe (located on the installation DVD or installation share), and try again. The executable is located inside the SQLPrepInstaller folder.|
|4347|Copy for replica <_DatasourceName_> on computer <_ServerName_> failed and this data source is being skipped.|Review the error details and take appropriate action. Then retry the operation.|
|4348|DPM requires Named Pipes protocol to be enabled on the selected instance of SQL Server.|On the selected server, run SQL Server Configuration Manager tool and enable the network configuration for the selected instance.|
|4349|Unable to set permissions on the folder corresponding to `MTATempStore$` share.|Review the error details, take the appropriate action, and then retry the installation.|
|4350|DPM upgrade marked replicas as invalid.|No user action is required.|
|4351|Unable to set the required file/folder permissions during installation.| |
|4352|Setup was unable to mount replica volumes under the path <_VolumesDirectory_>.|Using Disk Management, manually mount the DPM volumes before using DPM.|
|4353|Setup was unable to dismount replica volumes under the path <_VolumesDirectory_>.|Using Disk Management, manually dismount the DPM volumes.|
|4355|The SQL Server Agent service on the selected instance is not configured to run as **Automatic**. This will reconfigure the service to ensure that DPM can function correctly after installation.| |
|4357|This DPM server is using a shared library.|Disable library sharing by running the following commands and run the program again:<br/><br/>1. `SetSharedDPMDatbase.exe RemoveDatabaseSharing`<br/><br/>2. `AddLibraryServerForDpm.exe -DpmServerWithLibrary <FQDNofLibraryServer> -Remove`<br/><br/>Back up the DPM database and if you are using a remote instance of SQL Server, attach it to the SQL Server.|
|4359|DPM Setup was unable to set security permissions on some of the volumes in the storage pool. The volume may be missing.|Ensure all volumes are online. In Disk Management console, right-click on every DPM volume and select **Properties**. From the **Security** tab, restrict access to the volumes for administrators group and the LocalSystem account only by applying the appropriate permissions.|
|4360|You cannot upgrade the existing installation because the DPM database version does not match with installed DPM version.|Ensure correct SQL data files are copied from an existing DPM SQL instance and attached to the given SQL instance. Then, run the program again.|
|4362|Some prerequisites have been installed, you must restart the computer and run the program again.| |
|4364|DPM Setup has detected that the specified user does not belong to the sysadmin role on the specified SQL Server instance.| |
|4365|DPM Setup has detected that the specified user does not belong to the Administrator group on the computer running the SQL Server instance.| |
|4366|DPM Setup has detected that:<br/><br/>1) The specified user does not belong to the Administrator group on the computer running the SQL Server instance.<br/><br/>2) The specified user does not belong to the sysadmin role on the specified SQL Server instance.| |
|4372|DPM Setup failed to attach the DPM database files to <_InstanceName_>.|Investigate why the DPM database files cannot attach to <*InstanceName*>and then install DPM again.|
|4373|Failed to create directory path <_DestinationLocation_>.|Review the error details and take appropriate action. Then retry the operation.|
|4374|DPM database files are missing from the selected instance of SQL Server.|Make sure that the correct database files are attached to the selected instance of SQL Server and then run the program again.|
|4375|Setup has detected that either DPM Management Shell or DPM Remote Administration is already installed on this computer.|Uninstall the application and then run Setup again|
|4376|You cannot install the DPM Management Shell on a DPM server.|No user action is required.|
|4377|The version of Windows Server Hyper-V to which you are trying to recover the virtual machine is earlier than the version under which it was running before it was backed up. DPM does not support this recovery scenario.| |
|4379|An error occurred while upgrading the DPM database. Review the error log for more information.| |
|4380|An error occurred while marking the replica invalid after upgrade.|Resolve the issue and run the Setup again.|
|4383|An error occurred while upgrading database for SystemState datasource.|Resolve the issue and run the Setup again.|
|4384|An error occurred while trying to verify the service account for the services on the remote SQL Server.|Make sure that the service account for SQL Server Reporting Service is Network Service and that SQL Server and SQL Server Agent are domain accounts.|
|4385|SQL Server Reporting Service on the selected instance is using Secure Socket Layer (SSL). This will be reconfigured so that Reporting Services will not use Secure Socket Layer. For more information on how to configure the Report Server for Secure Sockets Layer (SSL) connections, click on the link below.|The link appears below the alert window.|
|4386|The SQL Server installation failed because a restart was pending on this computer.|Restart the computer and then start DPM Setup again.|
|4387|An unexpected error occurred during the installation.|For more details, check the DPM Setup error logs.|
|4388|You are upgrading the DPM database attached to this SQL Server instance. Take a backup of the DPM database before proceeding with the upgrade.| |
|4501|There is something wrong with the scenarios or checks xml.|Check the XMLs and try again|
|4502|Check Succeeded| |
|4503|Failed to perform the check.|See the log file for details and try again.|
|4504|Skipping the check as SkipCheck flag is set for this check in the input xml.| |
|4505|Failed to load the xml.|See the log file for details and try again.|
|4506|Failed to write the xml.|See the log file for details and try again.|
|4507|The prerequisite <_Prerequisite_> required to perform this check is missing.| |
|4508|The missing prerequisite <_Prerequisite_> has been installed.|Restart the computer and run the application again.|
|4509|SQL Server instance -  <_Instance_> used in the current installation of DPM, is an instance of the Evaluation Edition of SQL Server.|You may continue using this version of SQL Server instance until the evaluation cycle ends. After that you will need to purchase a full SQL Server license to continue using this SQL Instance for DPM.|
|4510|The  <_Group Name_> group is not present in the current domain.|DPM cannot be installed until the group is created.|
|4511|The  <_User Name_> user is not part of the  <_Group Name_> group.|DPM cannot be installed until this user is added to the  <*Group Name*> group.|
|4512|The machine <_ComputerName_> is not part of the group <_GroupName_>.|DPM cannot be installed until this computer is added as part of the  <_Group Name_> group.|
|4513|The <_UserName_> user is not present in the current domain.|DPM cannot be installed until the <*UserName*> user is created.|
|4514|ReportSr.dll on the SQL Server computer <_ComputerName_> was not removed.|If no other DPM server is using the SQL instance for hosting the DPM database, delete the file from <_FolderPath_>.|
|4515|DPM requires TCP\IP protocol to be enabled on the selected SQL Server instance.|Run SQL Server Configuration Manager tool and enable the network configuration on the selected SQL Server instance.|
|4516|The SQL Server you have selected already has DPM installed.|On the selected server, uninstall DPM or use another SQL Server that does not have DPM installed.|
|4517|DPM requires SQL Native Client Configuration TCP\IP to be enabled.|Enable SQL Native Client Configuration TCP\IP on the DPM machine.|
|4518|Failed to Move file from <_SourceLocation_> to <_DestinationLocation_>.|Review the error details and take appropriate action. Then retry the operation.|
|4519|Central Console server components cannot be installed on a computer that does not have Operations Manager Server for System Center installed.|Try installing Central Console server components on an Operations Manager Server for System Center 2012 or higher.|
|4522|Setup could not delete all Sharepoint snapshot readers groups from DPM machine.|On the **Administrative Tools** menu, select **Computer Management**, and then open **Local Users and Groups**. Delete the groups whose names begin with the string `AutoRecoverableSnapShotReaders_`.|
|4523|One or both of the DPM Central Console Management Packs have not been imported to the Operations Manager Server.|Import the following management packs from the ManagementPacks folder located on the DPM installation DVD or installation file location:<ul><li>Microsoft.SystemCenter.DataProtectionManager.2016.Library.mp</li><li>Microsoft.SystemCenter.DataProtectionManager.2016.Discovery.mp.</li></ul>Then run the prerequisites check again.|
|4524|Unable to check whether DPM Central Console Management Packs have been imported to the Operations Manager Server. Make sure that Operations Manager Server is installed on this computer and its services are running.| |
|4525|Unable to load the Operations Manager Server SDK assembly. Make sure that Operations Manager Server is installed on this computer.| |
|4526|DPM Central Console setup will create the following registry key to optimize Operations Manager Server performance: <br/>`HKLM\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Modules\Global\PowerShell`<br/> `QueueMinutes`=dword:00000077.| |
|4527|DPM Central Console setup will automatically import the 'System Center Data Protection Manager Scale Override' management pack to optimize Operations Manager Server performance.| |
|4528|Some configuration steps for DPM Central Console server components failed. Execute the file DPMCentralConsoleServerConfig.bat from  <_Install Location_> manually to complete the configuration.| |
|4529|DPM Central Console setup skipped the creation of some default roles (used for Role Based Access Control) because they already exist on the Operations Manager Server. The existing roles may have incomplete configuration. Delete the roles manually and then rerun the DefaultRoleConfigurator.exe from  <_Install Location_> to recreate the roles.| |
|4530|One or both of the DPM Central Console Management Packs imported to the Operations Manager Server is of wrong version.|Remove the existing ManagementPacks and import the following management packs from the ManagementPacks folder located on the DPM installation DVD or installation file location:<ul><li> Microsoft.SystemCenter.DataProtectionManager.2016.Library.mp</li><li>Microsoft.SystemCenter.DataProtectionManager.2016.Discovery.mp.</li></ul>Then run the prerequisites check again.|
  
## Error codes 6000-7999

|Error code|Message|Additional information|
|---|---|---|
|6001|ADGAgentUnableToAccessVolume| |
|6002|Set the permissions for the SYSTEM account to allow Full Control of the item.|Set the permissions for the SYSTEM account to allow Full Control of the item.|
|6003|DPM cannot access the path <_FileName_> because the SYSTEM account has been denied permission.|Set the permissions for the SYSTEM account to allow Full Control of the item.|
|6011|ADGAgentUnableToAccessMountPoint| |
|6012|DPM cannot access mount points under the path <_FileName_> because the SYSTEM account has been denied permission.|Set the permissions for the SYSTEM account to allow list folder content and Read for items in the specified path.|
|6013|DPM cannot access mount points under the path <_FileName_> because the SYSTEM account has been denied permission.|Set the permissions for the SYSTEM account to allow list folder Content and Read for items in the specified path.|
|7001|The operating system on target computer is not a valid client operating system.|No user action is required.|
|7002|The computer could not be found in Active Directory Domain Services.|No user action is required.|
|7003|The selected data sources cannot be added to the same protection group. A protection group must have either client data sources or other data sources.|No user action is required.|
|7004|The option <_Name_> is not supported for client computers.|To specify the folders that need to be backed up, use <*Name*>. For more details, run `get-help <Name>`.|
|7005|The parameter <_Name_> cannot be used while configuring protection of client computers.|Refer to cmdlet help for more details.|
|7006|The parameter <_Name_> cannot be used while configuring protection of the selected data source.|Refer to cmdlet help for more details.|
|7007|Synchronization frequency specified is invalid. You can only set synchronization frequency to 1, 2, 4, 6, 12 or 24 hours.|No user action is required.|
|7009|Immediate or scheduled initial replication for client computers is not supported. The initial replication will happen as and when the client computers connect to the DPM server's network.|No user action is required.|
|7010|The computer <_Name_> is being protected as server. It cannot be protected as client simultaneously.|No user action is required.|
|7011|The option <_Name_> is not supported for computers protected as clients.|No user action is required.|
|7012|The computer <_Name_> is being protected as client. It cannot be protected as server simultaneously.|No user action is required.|
|7013|Some of the selected computers could not be added. To view the list of computers that could not be added, click the **Failed to add machines** link below the list of selectable computers.|No user action is required.|
  
## Error codes 23000-24999

|Error code|Message|Additional information|
|---|---|---|
|23043|DPM has unexpectedly reached the end of the tape <_MediaLabel_>. This could be because the tape was tampered with.|If you have another copy of this tape, then retry the recovery operation by using the copy.|
|23044|Rescan cannot be performed because DPM is currently performing other operations on the server.|Wait for the other operations to complete, and then retry this operation.|
|23045|DPM failed to move one or more tapes to the I/E port slots.|<br/>1. Check to see that the library door is locked and that the I/E port is retracted.<br/>2. Check to see that there are sufficient free I/E port slots in the library.|
|24001|InvalidMediaPoolPropertyXml| |
|24002|MediaNotTrackable| |
|24003|The tape is managed by another DPM server.|No user action is required.|
|24004|MediaContainsValidDataset| |
|24005|MediaNeedsErase| |
|24006|ReachedMaxMediaLimit| |
|24007|Tape <_MediaLabel_> cannot be marked as a cleaning tape because it is not a cleaning tape.|No user action is required.|
|24008|DPM cannot complete the requested operation on tape <_MediaLabel_> because this tape is being used by another job.|Retry the operation later.|
|24009|InvalidVolumeAssociation| |
|24010|CanNotMoveMedia| |
|24011|NoSlotFree| |
|24012|NoIEPortSlotFree| |
|24013|NoRecomendedPoolExists| |
|24014|The library lacks power or the cables are not connected properly.|To resolve this error, do the following:<br/><br/>1. Make sure that the library is turned on.<br/>2. Make sure that data connection and power cables are connected properly.<br/>3. Open **Computer Management** and, in **Device Manager**, verify that the library is displayed.|
|24015|The tape is stuck in the library autoloader.|Remove the tape from the library autoloader. Consult the documentation for your hardware for instructions on troubleshooting tape errors. When the tape is repaired, run the library job again.|
|24017|The <_LibraryType_> <_Library_> drive information needs to be refreshed.|In the **Management** task area, on the **Libraries** tab, select the library, and then, in the **Actions** pane, select **Rescan**.|
|24018|The drive cleaning failed or timed out.|Change the cleaning tape, and in the **Management** task area, on the **Libraries** tab, in the **Actions** pane, select the drive, and then select **Clean**.|
|24019|Drive <_DriveName_> in <_LibraryType_> <_Library_> needs servicing.|Contact product support for your hardware to have the drive serviced. You should also review all protection groups to identify if the absence of this drive requires changes to drive allocations.|
|24021|DPM attempted to move a tape to  <_ElementType_> <_ElementName_> but this  <*ElementType*> was in use. DPM may not be in synch with the current state of the library <_Library_>.|To resolve this error, do the following:<br/><br/>1. In the **Management** task area, on the **Libraries** tab, select the library <*Library*>, and then, in the **Actions** pane, select **Inventory**.<br/>2. If the <*ElementType*> contains a tape, remove this tape by using the front panel of your library.|
|24022|The  <_ElementType_> <_ElementName_> did not contain a tape when DPM expected it to. DPM might not be in synch with the state of the <_LibraryType_> <_Library_>.|In the **Management** task area, select the **Libraries** tab select the <*LibraryType*> <*Library*>, and then, in the **Actions** pane, select **Inventory library**.|
|24023|The library <_Library_> mandates that when a tape is dismounted, it should be moved back to the slot it was originally mounted from. However, slot <_SlotName_> is not empty.|To resolve this error, do the following:<br/><br/>1. Remove the tape in slot <*SlotName*> by using the front panel of your library.<br/>2. In the **Management** task area, select the **Libraries** tab, and then, in the **Actions** pane, select **Inventory library** to run an inventory.|
|24024|A library with the same name is already attached to this server.|Choose a different name for the library.|
|24025|The operation cannot be performed on <_LibraryType_> <_Library_> because it does not have any I/E ports.|No user action is required.|
|24026|Operation cannot be performed because DPM Administrator Console is not synchronized with the actual state of the library.|Close and then reopen DPM Administrator Console to synchronize it with the actual state of the library.|
|24027|The operation failed because the slot <_SlotName_> in library <_Library_> was empty. This tape is currently located in  <_MediaLocationType_> <_MediaLocationInfo_>.|Use the front panel of your library to move the tape from its current location to the slot specified above.|
|24028|MediaNotFound| |
|24029|Tape erase operation was skipped because <_LibraryType_> <_Library_> doesn't support tape erase.|No user action is required.|
|24031|DPM was unable to recatalog the tape in  <_MediaLocationType_> <_MediaLocationInfo_> in <_LibraryType_> <_Library_> because this tape has not been identified.|In the **Management** task area, select the **Libraries** tab, and then, in the **Actions** pane, select **Inventory library**. Then, select the tape <_MediaLabel_>, and then select **Identify unknown tape**.|
|24032|VerifyOmidNotSupported| |
|24033|A detailed inventory is not performed on the tape <_MediaLabel_> because it is already known to this DPM server.|No user action is required.|
|24034|DPM could not reserve the I/E port resource because one of required resources is not accessible.|Make sure that there are no pending alerts for the library. Also make sure that no I/E port slots have been left open; and if so, close the I/E port slots.|
|24035|TaskAbsentInPriorityQueue| |
|24036|The operation failed because the I/E port is currently in use.|Retry this operation after the I/E port is free.|
|24037|DPM failed to erase the selected tape because the state of the <_LibraryType_><_Library_> as seen by DPM is inconsistent with the actual state of the library.|Run a detailed inventory and a fast inventory.|
|24038|The barcode on the tape <_MediaLabel_> in  <_MediaLocationType_> <_MediaLocationInfo_> appears to have changed since the last time it was inventoried in DPM.|To resolve this error, refresh the tape bar code.|
|24039|Duplicate barcodes detected on tapes with labels <_MediaLabel_> and <*MediaLabel*>.|To resolve this error, do the following:<br/>1. Remove the tapes from the library.<br/>2. Clear duplicate barcode information from DPM.<br/>3. Replace the barcodes on the tapes and then insert them back into the library.<br/>4. Inventory the library.|
|24040|DPM failed to recatalog the imported tape <_MediaLabel_> because it has not been inventoried.|In the **Management** task area, on the **Libraries** tab, select **Inventory library**, and then select the option to perform a detailed inventory.|
|24041|DPM failed to recatalog the imported tape <_MediaLabel_> because the tape is blank.|DPM can only recatalog a tape that has valid data on it.|
|24042|DPM failed to recatalog the imported tapes because they do not contain the catalog information.|It is likely that your data spans multiple tapes and the catalog information is present on another tape. Insert all tapes associated with the backup, and then retry the operation.|
|24043|LibraryNotFound| |
|24044|DriveNotFound| |
|24045|MediaPoolNotFound| |
|24046|MediaPoolNotAdmin| |
|24047|MediaPoolNotFree| |
|24048|MountMediaFailed| |
|24049|DismountMediaFailed| |
|24050|Failed to perform the operation since the tape  <_Media Labe_> is not available in <_Library Type_> <_Library_>.|To resolve this error, do the following:<ol><li>In the DPM Administrator Console, select **Monitoring** on the navigation bar, and then select the **Alerts** tab. Check for any **Free tape threshold reached** alerts generated by the libraries. If such alerts are present, proceed to step 3.</li><li>In the DPM Administrator Console, select **Management** on the navigation bar, select the **Libraries** tab, and then do the following:<ul><li>Expand all library slots and check for any free or expired tapes. If there is none, proceed to step 3.</li><li>Check for any suspect tapes in the library. If suspect tapes are present, see [Managing Suspect Tapes](/previous-versions/system-center/data-protection-manager-2007/bb808923(v=technet.10)#managing-suspect-tapes).</li></ul></li><li>Insert new tapes into the library, and then run a **Fast inventory** action followed by an **Identify unknown tapes** action. In DPM Administrator Console, select **Management** on the navigation bar, select the **Libraries** tab, and make sure that the new tapes appear as free. Then, select **Monitoring** on the navigation bar, select the **Alerts** tab, and restart the failed jobs.</li></ol>|
|24051|Required tape resource <_MediaLabel_> is reserved by another task.|Wait for the other task to complete, or cancel the ongoing operation. Retry the operation.|
|24052|DPM could not reserve the drive resource because one of required drive resources is not online or it needs cleaning or servicing.|To resolve this error, do the following:<br/>1. View and resolve all alerts for the library and its drive(s). After resolving the alerts, retry the operation.<br/>2. In the **Management** task area, select the **Libraries** tab, and then, in the **Actions** pane, select **Rescan**. After the rescan operation has completed successfully, retry the operation.|
|24053|The required drive resource is reserved by another task.|View and resolve all alerts for the library and drive, or wait for the other operations to complete. Retry the operation after resolving the alerts.|
|24054|Operation cannot be performed on the tape in  <_MediaLocationType_> <_MediaLocationInfo_> because it is a cleaning tape.|No user action is required.|
|24055|Operation failed because no usable drives were available in <_LibraryType_> <_Library_>. Either there is no drive online or all the drives need cleaning or servicing.|To resolve this error, do the following:<br/>1. In the **Monitoring** task area, on the **Alerts** tab, resolve all alerts for this library and its drive. After resolving the alerts, retry this operation.<br/>2. If you have drives that are functioning correctly but that are currently being used, wait for the other operations to complete, and then retry this operation.|
|24056| <_LibraryType_> <_Library_> has been disabled by the DPM administrator.|To resolve this error, do the following:<br/>1. If this library is associated with an active protection group, modify the protection group to associate it with another library to prevent tape-related jobs from failing.<br/>2. If you want to use this library for your tape-related jobs, in the **Management** task area, on the **Libraries** tab, select this library, and then, in the **Actions** pane, select **Enable library**.|
|24057|DPM failed to create a copy of the tape backup for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> because the tape backup failed or did not run.|To resolve this error, do the following:<br/>1. Retry the failed tape backup job by using the alert in the **Monitoring** task area.<br/>2. If your copy failed because the tape backup job did not run at all, in the **Protection** task area, select **Create recovery point - tape** to create a short-term tape backup.<br/>3. After successfully running the tape backup, retry the failed copy job by using the alert in the **Monitoring** task area.|
|24058|The certificate <_CertificateName_> with serial number <_CertificateSerialNumber_> issued by  <_CertificateIssuer_> will expire by <_ExpiryDate_>. All encrypted backup jobs will fail after this time.|To resolve this error, do the following:<br/>1. If this certificate contains a private key, move this certificate to the DPM recovery certificates collection for recovering data in the future, and replace this certificate with a valid certificate in the DPM backup certificates collection to continue further backups.<br/>2. If this certificate does not contain a private key, replace this certificate with a valid certificate in the DPM backup certificates collection to continue further backups.|
|24059|The certificate <_CertificateName_> with serial number <_CertificateSerialNumber_> issued by <_CertificateIssuer_> will expire by <_ExpiryDate_>. All encrypted backup jobs will fail after this time.|To resolve this error, do the following:<ol><li>If this certificate contains a private key, move this certificate to the DPM recovery certificates collection for recovering data in future, and replace this certificate with a valid certificate in the DPM backup certificates collection to continue further backups.</li><li> If this certificate does not contain a private key, replace this certificate with a valid certificate in the DPM backup certificates collection to continue further backups.</li></ol>For more information about certificates, see [How to Encrypt Data in a Protection Group](/previous-versions/system-center/data-protection-manager-2010/ff399018(v=technet.10)). See also [Deploy protection groups](/system-center/dpm/create-dpm-protection-groups).|
|24060|Some certificates under DPMBackupStore have changed since the start of the job.|Retry the job.|
|24061|Unexpected tape detected in  <_MediaLocationType_> <_MediaLocationInfo_> in <_LibraryType_> <_Library_>.|Check to see if there are any active alerts indicating suspect tapes. If such an alert exists, take the appropriate recommended action, and then retry this job.|
|24070|Some of the certificates under DPMBackupStore have expired.|To resolve this error, do the following:<ol><li>If this certificate contains a private key, move this certificate to the DPM recovery certificates collection for recovering data in future, and replace this certificate with a valid certificate in the DPM backup certificates collection to continue further backups.</li><li> If this certificate does not contain a private key, replace this certificate with a valid certificate in the DPM backup certificates collection to continue further backups.</li></ol>For more information about certificates, see [How to Encrypt Data in a Protection Group](/previous-versions/system-center/data-protection-manager-2010/ff399018(v=technet.10)). See also [Deploy protection groups](/system-center/dpm/create-dpm-protection-groups).|
|24071|This DPM server is not authorized to read or write to this encrypted tape because there is no valid certificate in DPMBackupStore and DPMRestoreStore that can decrypt data.|To resolve this error, do the following:<ol><li>Make sure that DPMBackupStore has the certificate to decrypt this tape.</li><li>Use this tape on a DPM server that is authorized to read this tape.</li></ol>For more information about certificates, see [How to Encrypt Data in a Protection Group](/previous-versions/system-center/data-protection-manager-2010/ff399018(v=technet.10)). See also [Deploy protection groups](/system-center/dpm/create-dpm-protection-groups).|
|24072|`DPMBackupStore` or `DPMRestoreStore` is not present.|Use the Certificate Management console to recreate the `DPMBackupStore` and `DPMRestoreStore` certificate stores.|
|24073|No certificate is present under DPMBackupStore.|Add certificates to the DPM backup certificates collection.<br/><br/>For more information about certificates, see [How to Encrypt Data in a Protection Group](/previous-versions/system-center/data-protection-manager-2010/ff399018(v=technet.10)). See also [Deploy protection groups](/system-center/dpm/create-dpm-protection-groups).|
|24074|Failed to encrypt data on tape.|Retry the job.|
|24075|Certificates on this tape are corrupt. Data on this tape cannot be recovered.|No user action is required.|
|24076|The command sent by DPM to the library agent timed out.|Retry the operation.|
|24077|DPM failed to mount the tape <_MediaLabel_> in drive <_DriveName_> for the library <_Library_>. This is because DPM is not synchronized with the current state of the library.|In the **Management** task area, on the **Libraries** tab, select the library, and then select **Inventory library**. If enabled, select the **Fast inventory** option; otherwise, select the **Detailed inventory** option.|
|24078|No certificate with private key is present in DPMBackupStore.|In the Certificate Management console, open certificate stores for the **Computer** account on the DPM server. Add a certificate that has the private key to the DPMBackupStore certificates collection.<br/><br/>For more information about certificates, see [How to Encrypt Data in a Protection Group](/previous-versions/system-center/data-protection-manager-2010/ff399018(v=technet.10)). See also [Deploy protection groups](/system-center/dpm/create-dpm-protection-groups).|
|24079|DPM encountered an error while attempting to parse the tape catalog information for tape <_MediaLabel_>.|Retry the operation.|
|24080|DPM encountered a critical error while trying to parse the contents of the tape <_MediaLabel_>. This may be because the data on this tape is corrupt.|To resolve this error, do the following:<br/>1. If you have another copy of this tape, use that to retry the recovery.<br/>2. If you do not have another copy of this tape, in the **Recovery** task area, select all required individual recoverable items, and then perform the recovery.|
|24081|NoCertificatePresentInRestoreStore| |
|24082|DPM could not perform the operation because the specified recovery point does not exist.|No user action is required.|
|24083|Recovery failed for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>. Hardware snapshots of the DPM replica and recovery point volumes are not mounted on the protected computer for SAN recovery.|Use your SAN software to take hardware snapshots of the DPM replica and recovery point volumes, and to mount them on the protected computer.|
|24084|The tape in <_LibraryType_> <_Library_> at <_MediaLocationType_><_MediaLocationInfo_> has been written to by another tape backup application using an unsupported physical block size.|To resolve this error, do the following to erase the contents of the tape:<ul><li>In DPM Administrator Console, in the **Management** task area, select the **Libraries** tab, select the tape, and then click **Erase tape**. After erasing the tape, DPM can use it for backups.</li></ul> <br/>**NOTE**<br/>If you have a stand-alone tape drive, you might have to erase the tape by using a tool other than DPM.|
|24085|DPM cannot start a new thread.|Check the system memory and CPU utilization.|
|24086|DPM failed to dismount the tape <_MediaLabel_> in drive <_DriveName_> for the library <_Library_>. This is because DPM is not synchronized with the current state of the library.|In the **Management** task area, on the **Libraries** tab, select the library, and then, in the **Actions** pane, select **Inventory library**. If enabled, select the **Fast inventory** option; otherwise, select the **Detailed inventory** option.|
|24087|CouldNotAcquireGlobalDPMDBLock| |
|24088|Drive <_DriveName_> in <_LibraryType_> <_Library_> is not zoned properly.|Make sure that only drives of the <*LibraryType*> <*Library*> are visible to the DPM server and not the changer.|
|24089| <_LibraryType_> <_Library_> connected to <_ComputerName_> is offline because none of its drives are available.|To resolve this error, do the following:<br/>1. Make sure that drives of this library are zoned properly.<br/>2. Make sure that all drive-related alerts for this library are resolved.|
|24090|The global DPMDB database is not accessible.|To resolve this error, do the following:<br/>1. Make sure that the global DPMDB database is accessible.<br/>2. Make sure that the instance of SQL Server of the global DPMDB database is running.<br/>3. Make sure that the network connection to the computer hosting the global DPMDB database is properly configured.<br/>4. Make sure that the SQL Server Browser service is running on the global DPMDB database computer.<br/>5. Make sure that the MSDTC service is running on this DPM server and the global DPMDB database computer.|
|24091|The global DPMDB database is not accessible.|To resolve this error, do the following:<br/>1. Make sure that the global DPMDB database is accessible.<br/>2. Make sure that the instance of SQL Server of the global DPMDB database is running.<br/>3. Make sure that the network connection to the computer hosting the global DPMDB database is properly configured.<br/>4. Make sure that the SQL Server Browser service is running on the global DPMDB database computer.<br/>5. Make sure that the MSDTC service is running on this DPM server and the global DPMDB database computer.|
|24092|Error occurred while reserving resource for the operation.|Retry the operation.|
  
## Error codes 25001-30000

|Error code|Message|Additional information|
|---|---|---|
|25001|Rescan cannot be performed at this moment because DPM is performing other operations on the <_LibraryType_> <_Library_>.|Wait for the current library operations to complete, and then retry this operation.|
|25003|LARtnMediaToOriginalAddr| |
|25002|The tape in <_LibraryType_> <_Library_> at <_MediaLocationType_><_MediaLocationInfo_> appears to be a cleaning tape. However, this tape is not marked as a cleaning tape.|In the **Management** task area, on the **Libraries** tab, select this tape, and then select **Mark as cleaning tape**.|
|25005|The cleaning operation for drive <_DriveName_> on library <_Library_> took longer than expected. The cleaning operation may have failed.|To resolve this error, do the following:<br/>1. If supported, check the front panel of your library to verify that this cleaning operation completed successfully.<br/>2. If the cleaning operation failed, try changing the cleaning tape, and then run the cleaning job again.|
|25009|DPM is not synchronized with the current state of your library. Jobs running on the <_LibraryType_> <_Library_> can potentially fail.|In the **Management** task area, on the **Libraries** tab, select **Inventory library**. If available, select the **Fast Inventory** option, otherwise, select the **Detailed Inventory** option.|
|25010|DPM tried to access  <_ElementType_>  <_ElementName_> on library <_Library_>. This  <*ElementType*> does not exist.|To resolve this error, do the following:<br/>1. In the **Management** task area, on the **Libraries** tab, select **Inventory library** to run inventory. If enabled, select the **Fast inventory** option. Otherwise, select the **Detailed inventory** option. This will update the library state as seen by DPM.<br/>2. Retry the operation after DPM has completed the inventory successfully.|
|25011|DPM failed to inventory the <_LibraryType_> <_Library_>. This is possibly due to a hardware issue.|Refer to your hardware manual for troubleshooting steps.|
|25012|DPM is not synchronized with the current state of your library. Jobs running on the <_LibraryType_> <_Library_> can potentially fail.|In the **Management** task area, on the **Libraries** tab, select **Inventory library**. If available, select the option to perform a fast inventory, otherwise, perform a detailed inventory.|
|25013|DPM detected that the drive <_DriveName_> doesn't appear to be installed correctly.|Check the SCSI and bus mappings of the drive to make sure that the drive is mapped correctly. If you change any of the mappings, in the **Management** task area, on the **Libraries** tab, and then select **Rescan**.|
|25014| <_LibraryType_> <_Library_> is not ready.|To resolve this error, do the following:<br/>1. Make sure that the library is turned on.<br/>2. Check for loose connections of data or power channels.<br/>3. Make sure that the library appears in Device Manager.<br/>4. Make sure that the door on the library is closed.<br/>5. Refer to your hardware manual for other troubleshooting steps.|
|25015|DPM detected that drive <_DriveName_> is not ready.|To resolve this error, do the following:<br/>1. If the drive is being serviced, you can ignore this alert.<br/>2. Make sure that the drive is powered on.<br/>3. Make sure that the drive is connected properly.<br/>4. In Device Manager, if the drive is not enabled or is not visible, refer to your hardware manual for other troubleshooting steps.|
|25016|DPM failed to use the tape in <_MediaLocationType_> <_MediaLocationInfo_> because it appears to be a cleaning tape that is identified incorrectly as a backup tape.|Verify if the tape in slot <*MediaLocationType*> <*MediaLocationInfo*> is a cleaning tape. If it is, in the **Management** task area, select the **Libraries** tab, select this tape, and then, in the **Actions** pane, select **Mark as cleaning tape**.|
|25017|DPM could not access drive <_DriveName_> because another application is currently using it.|Wait until the other application to finish using the drive, or stop the other application.|
|25018|The cleaner media in <_MediaLocationType_> <_MediaLocationInfo_> has expired.|Change the cleaning tape, and then run the cleaning job again.|
|25100|DPM encountered an error while attempting to control the autoloader on library <_Library_>.|<br/>1. Turn off the library <*Library*>, and then turn it on and retry the operation.<br/>2. Examine the front panel of your library to see if any errors are being reported by your library.<br/>3. Refer to your hardware manual for other troubleshooting steps.|
|25101|DPM encountered an error while attempting to use tape <_MediaLabel_> on the drive <_DriveName_>. This could be a problem with your drive or tape.|<br/>1. Use the tape <*MediaLabel*> in a different drive. To do this, first disable the drive <*DriveName*>. Select this tape and select **Identify unknown tape**. If this operation fails, it indicates a potential problem with your tape.<br/>2. Use the tape <*MediaLabel*> in a different library. Load the tape in the other library, select this tape, and select **Identify unknown tape**. If this operation fails, it indicates a potential problem with your tape.<br/>3. If either of the above action resulted in the tape operation succeeding, it indicates a potential issue with your drive <*DriveName*>.<br/>4. Refer to your hardware manual for other troubleshooting steps.|
|25102|DPM attempted to move a tape to  <_ElementType_>  <_ElementName_> but this  <*ElementType*> was occupied. DPM may not be in synch with the current state of the library <_Library_>|<br/>1. On the **Libraries** tab in the **Management** task area, select the library <*Library*> and select **Inventory** in the **Actions** pane.<br/>2. If the  <*ElementType*> contains a tape, remove the tape by using the front panel of your library.|
|25103|LASourceElementEmpty| |
|25104|LATransportFull| |
|25105|Tape drives or library devices may have been disconnected or reconnected on the DPM server.|On the **Libraries** tab in the **Management** task area, select **Rescan** in the **Actions** pane.|
|25106| <_LibraryType_> <_Library_> is either turned off or has been disconnected|<br/>1. Check if the <*LibraryType*> <*Library*> is turned on.<br/>2. Check for loose data or power channel connections.<br/>3. Make sure the library is visible in Device Manager.|
|25107|Drive <_DriveName_> requires cleaning. The drive will not be used for further operations until it has been cleaned.|Drive <*DriveName*> will be automatically cleaned by DPM. If you are seeing this error frequently, service the drive.|
|25108|The library <_Library_> requires all drives to be empty in order to lock or unlock the door. However, the drive <_DriveName_> has a tape in it.|Use the front panel of the library <*Library*> to move the tape from the drive <*DriveName*> to an empty slot|
|25109|Tape might not be properly inserted in the stand-alone drive or the stand-alone drive is not ready.|1. Check to see if the tape has been inserted correctly into the drive.<br/>2. Check to see that the drive is ready and operational.|
|25123|The operation failed because the insert/eject (I/E) port of the library <_Library_> is open.|Use the front panel of the library to close the I/E port.|
|25124|Rescan failed because the tape drive or library hardware does not seem to have been set up correctly.|In Device Manager, check to see that the drivers for the tape drive or library hardware are installed correctly.|
|25125|DPM was unable to use <_Formatted Device Name Value Pairs_> since this was being used by some other process.|1. Determine if any other process on the DPM server is currently using the library. If this is the case, stop the process.<br/>2. Check to see that your library is powered up and functional|
|25126|Failed to obtain drive mapping information from the file DPMLA.xml. The information in this file is not formatted correctly.|Refer to the DPM Operations Guide for instructions on modifying the DPMLA.xml to correctly represent your current library configuration.|
  
## Error codes 30001-32000

|Error code|Message|Additional information|
|---|---|---|
|30001|CriticalIoError| |
|30002|After the tape mount operation, tape <_MediaLabel_> (Barcode- <*MediaLabel*>) was not found in the  <_MediaLocationType_>  <_MediaLocationInfo_> or the tape in the drive was changed.|To update the library state, perform an inventory, and then retry the operation. In the **Management** task area, on the **Libraries** tab, select **Inventory library**.|
|30003|The tape <_MediaLabel_> (barcode - <*MediaLabel*>) present in the <_LibraryType_> <_Library_> is write-protected.|Remove write-protection from the tape, and then retry the operation.|
|30004|The tape <_MediaLabel_> (barcode - <*MediaLabel*>) might not be compatible with the drive type of drive <_DriveName_> in <_LibraryType_> <_Library_>.|Verify that the tape and the drive type are compatible and that the drive is supported. Also find out if you need to upgrade the drive firmware.|
|30005|DPM has run out of scratch space on installation volume.|Ensure that sufficient storage is available on DPM installation volume|
|30006|TempAreaNotAccessible| |
|30007|InvalidDatasetId| |
|30008|DPM failed to recatalog the contents of the tape <_MediaLabel_> because it encountered a critical error while attempting to read catalog information from this tape. This may be because the tape data is corrupt.|If you have another copy of this tape, use that instead for the recatalog operation. If this is the only copy of the tape and you want to recover as much data as is possible:<br/><br/>1. On the **Libraries** tab in the **Management** task area, select the tape.<br/>2. Select **View contents**.<br/>3. Copy the contents of this tape to disk.|
|30009|CorruptOffsetFile| |
|30010|VssInfrastructureError| |
|30011|VssErrorRetryable| |
|30012|Errors occurred while taking a VSS snapshot of volume(s).|Retry the operation. If it fails consistently, remove the protected data from the protection group and reprotect it again.|
|30013|VolumeNotSupported| |
|30014|SnapshotOutOfResources| |
|30015|The specified recovery point does not exist|Increase the disk allocation space for the recovery point volume, or delete old recovery points by using the Remove-RecoveryPoint cmdlet. For information about deleting recovery points, open DPM Management Shell and run: <br/><br/>`Get-Help Remove-RecoveryPoint -detailed` <br/><br/>If you are using custom replica and recovery point volumes, such as in the case of a SAN, you cannot modify the disk space allocated by using DPM. In these cases follow these steps:<br/>1. In the **Modify disk allocation** dialog, identify the volume that corresponds to the recovery point volume for the data source.<br/>2. Select **Disk Management**, then right-click the custom volume.<br/>3. Select **Extend Volume**.|
|30016|UsnWrap| |
|30017|UsnNotPresent| |
|30018|UsnIdChange| |
|30019|RestoreAllFilesFailed| |
|30020|MaxNumberOfBitmapsReached| |
|30021|InvalidBitmapId| |
|30022|ApplicatorSyncError| |
|30023|ProductionServerDirtyShutdown| |
|30024|A critical inconsistency was detected, therefore changes cannot be replicated.|To validate exclusion or inclusion filters for the data source, select **Modify Protection Group**. After you modify the protection group, select the link below it to run a synchronization job with a consistency check.|
|30025|One or more databases in the storage group failed to mount|On the Exchange Server, verify the cause of failure from event logs entries.|
|30026|One or more databases in storage group failed to dismount|On the Exchange Server, verify the cause of failure from event logs entries.|
|30027|The post data verification cleanup failed because of an internal error for <_DatasourceName_> on <_ServerName_>.|Retry the operation.|
|30028|VerifyDatasetFailure| |
|30029|Eseutil.exe failed to apply logs on database files to bring the database to a clean shutdown state.|Retry the operation. If the problem persists, the recovery point may be corrupt. Retry recovery from another recovery point.|
|30030|SIS is not enabled on the server.|Enable SIS for the server.|
|30031|StatusBlockMismatch| |
|30032|ProductionServerVolumeResized| |
|30033|The volume is no longer available - it may be dismounted or offline|Verify that the volumes are online and mounted.|
|30034|FilterInternalError| |
|30035|ProductionServerVolumeDirty| |
|30036|StatusBlockCorrupt| |
|30037|DPM was unable to determine the last known backup tracking information for this data source.|Rerun the job.|
|30038|The change journal is corrupt due to bad sectors on the disk.|To delete the change journal, at a command prompt run:<br/><br/>`fsutil usn deletejournal`<br/><br/>For more information, see the command usage. To perform a consistency check, select **Protection**  > **Perform consistency check**.|
|30039|SQLLogChainBroken| |
|30040|SQLFailedServiceStart| |
|30041|SQLFailedServiceStop| |
|30042|SQLScratchPathTooLong| |
|30043|SQLDbMissing| |
|30044|SQL2kUpgraded| |
|30045|At least one of the databases is not online|Verify that all databases in the storage group are online, and then retry the job.|
|30046|Protection agent is unable to synchronize the replica.|Run synchronization with consistent check.|
|30047|VSSDatasourceUnavailable| |
|30048|SQLLogEarlyToApply| |
|30049|SQLServerRefusingConnection| |
|30050|SQLCommandFailed| |
|30051|Overwrite database flag is not set for one or more databases being recovered|On the Exchange server, set the **Overwrite database** flag and retry the operation.|
|30052|ReplicaAgentDirtyShutdownDetected| |
|30053|UsnEntryDeleted| |
|30054|StatusBlockOffset| |
|30055|PreScriptExecuteError| |
|30056|PostScriptExecuteError| |
|30057|PreScriptTimeOutError| |
|30058|PostScriptTimeOutError| |
|30059|ScriptConfigError| |
|30060|ApplicatorCaseSensitivityMismatch| |
|30061|ShadowcopyAreaFull| |
|30062|RSGSpecifiedForNonRSG| |
|30063|NonRSGSpecifiedForRSG| |
|30064|ExchangeAlternateRecoveryInvalidInput| |
|30065|ExchangeAlternateDatabaseMounted| |
|30066|LocalContinuousReplicationEnabled| |
|30067|VerifyDatasetTimeout| |
|30068|PreSnapStepExecuteError| |
|30069|PreSnapStepTimeOutError| |
|30070|PostSnapStepExecuteError| |
|30071|PostSnapStepTimeOutError| |
|30072|SystemStatePreSnapStepExecuteError| |
|30073|SystemStatePreSnapStepTimeOutError| |
|30074|ExchangeLogChainBroken| |
|30075|The volume for one of the specified database file locations does not exist. Check to see that the volumes for all file locations specified are available on the destination SQL server| |
|30076|Operation failed for <_DatasourceName_> on <_ServerName_> because the recovery point volume for this data source is not available on the DPM server. Future backups will also fail until this issue is fixed.|<ul><li>If your recovery point volume is offline, bring it online and then run consistency check for the affected data sources.</li><li>If your recovery point volume is not available to bring online, remove the affected members from protection and reprotect them. When stopping protection for the affected members, select the option to delete the replica on disk.</li></ul>|
|30077|DPM has run out of free space on the recovery point volume for <_DatasourceName_> on <_ServerName_>. Protection for this data source will fail to prevent existing recovery points from being deleted before their expiration.|Verify that there are no pending recovery point volume threshold alerts active for this data source and rerun the job. DPM may have automatically grown the volume and resolved the alerts.|
|30078|Operation failed for <_DatasourceName_> on <_ServerName_> due to a VSS error on the DPM server. Future backups are also likely to fail until this issue is fixed.|<br/>1. Rerun the consistency check and see if it resolves this issue.<br/>2. Check to see if your disks are connected properly to the DPM server. If there are any disk cabling issues, correct them and then run a consistency check.<br/>3. If you are certain that you do not have any disk cabling issues, clear the VSS fault. Next, run `chkdsk` on <_VolumeName_> and finally run a  consistency check.|
|30079|VssErrorOther| |
|30080|ExchangeCmdletFailed| |
|30081|ExchangePrerequisitesMissing| |
|30082|VssErrorNonRetryable| |
|30083|Operation failed for <_DatasourceName_> on <_ServerName_> due to a VSS error on the DPM server.|Rerun the consistency check and see if it resolves this issue.<br/><br/>If running a consistency check does not resolve this issue, increase the page file size on the DPM server and then run the consistency check job.|
|30084|Operation failed for <_DatasourceName_> on <_ServerName_> due to a VSS error on the DPM server. Check the volsnap events in the Windows Event Log|Rerun the consistency check.|
|30085|Operation failed for <_AgentTargetServer_> as the system ran out of memory.|Check the Event Viewer entries to determine the cause. After you correct the issue, retry the operation.|
|30086|BitmapfileCorrupt| |
|30087|DPM has detected a checksum mismatch during data transfer over the network|Retry the operation. If the problem persists, contact your network administrator to diagnose possible network issues.|
|30088|DPM cannot continue protection because SCR copy status is unhealthy for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>.|Verify that the SCR copy status is healthy, and then retry the job.|
|30089|Operation failed on <_TargetedServerName_> as an unsupported Single Instance Store (SIS) file <_FileName_> was found on the source volume.|To resolve this error, either change the file attributes or recover the entire virtual machine.|
|30100|DPM has detected an error in the replica to recovery point volume mapping for <_DatasourceName_> for server <_ServerName_>. All future backups will fail until this is resolved.|To resolve this issue, perform one of these actions:<ul><li>Migrate the datasource to use different volumes by using `MigrateDatasourceDataFromDPM.ps1` <br/><br/>For more information, see [Using MigrateDatasourceDataFromDPM](/previous-versions/system-center/data-protection-manager-2010/ff399384(v=technet.10)) and [Set-DPMDatasourceDiskAllocation](/powershell/module/dataprotectionmanager/set-dpmdatasourcediskallocation).</li><li>Use a different DPM server to protect this datasource.</li></ul>|
|30101|DPM encountered a critical error while performing an I/O operation on the tape <_MediaLabel_> (Barcode - <_MediaBarcode_>) in <_MediaLocationType_><_MediaLocationInfo_>.|To resolve this error, do the following:<br/>1. Download and install the latest driver and firmware updates from the tape drive vendor.<br/>2. Many tape drive vendors also offer utilities that you can use to diagnose hardware problems.<br/>3. Clean and service the tape drive. <br/><br/>**Modify the TapeSize registry value to match your tape size** <br/>When a tape reaches the end, some drivers incorrectly return a **Device I/O error** code instead of an **End of tape reached** code. To resolve this error, modify the value of the following registry key to match your tape size:<ul><li> Registry location: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Data Protection Manager\Agent` </li><li>DWORD name: **TapeSize** </li><li>Value data (in MBs): **00030000** </li></ul> <br/>**Reduce the number of parallel write buffers** <br/>An errant driver might not handle multiple parallel write requests. To resolve this error, create and modify the following registry key to reduce the number of parallel write buffers that DPM uses:<ul><li>Registry location: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Data Protection Manager\Agent` </li><li>DWORD name: **BufferQueueSize** </li><li>Value data: **00000001** </li></ul> <br/>**Caution**<br/>Serious problems can occur if you modify the registry incorrectly. These problems could require you to reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk. Always make sure that you back up the registry before you modify it, and that you know how to restore the registry if a problem occurs.|
|30102|There was an unrecoverable error during I/O operations on the drive.|Retry the operation with another tape, or try restoring partial data from backup.|
|30103|After a tape mount operation, no tape is found in the drive or the tape in drive has changed.|Update the library state by performing an inventory, and then retry the operation. On the **Libraries** tab in the **Management** task area, select **Inventory library**.|
|30104|DPM failed to write to tape because the tape is write-protected.|Remove the write protection from the tape and retry the operation.|
|30105|The tape and the drive type may not be compatible.|Check that the tape and the drive type are compatible, and the drive is supported. Also check if the drive firmware needs an upgrade.|
|30106|No more space left in Temp storage volume.|<br/>1. Create a folder called **temp**  under the DPM installation path on the DPM server (by default this path would be `%ProgramFiles%\Microsoft Data Protection Manager\DPM`.<br/>2. Share this folder out as a share called **temp**.<br/>3. Give the local system account on the DPM server **Full Control** permissions on this folder.|
|30107|RA cannot read from/write to temp area.|DPM will recreate the temp area with appropriate permissions|
|30108|Either the tape <_MediaLabel_> has corrupt data or this is not the right tape.|Use another copy of the tape and retry the operation. You can view the contents of the tape to confirm that it contains the expected data.|
|30109|DPM failed to recatalog the contents of the tape because it encountered a critical error while attempting to read catalog information from this tape. This may be because the tape data is corrupt.|If you have another copy of this tape, use that instead for the recatalog operation. If this is the only copy of the tape and you want to recover as much data as possible, then select this tape on the **Libraries** tab in the **Management** task area, click **View contents**, and copy the contents of this tape to disk.|
|30110|DPM has encountered a critical internal error. (Critical error in reading/parsing DirsAndFileOffsetFileList)|Retry the operation.|
|30111|The VSS application writer or the VSS provider is in a bad state. Either it was already in a bad state or it entered a bad state during the current operation.|Make sure that the required licenses are installed on the server, and then retry the backup.<br/><br/>This can also occur if you are attempting to back up a virtual machine and the VHD file is located in the root of a CSV. To work around this issue, create a folder and move the VHD inside the folder.|
|30112|DPM encountered a retryable VSS error.|Depending on which situation you were in when you encountered this error, the following sections describe how to resolve this error.<br/><br/> **Volume Shadow Copy Service (VSS) error on a virtual machine** <br/>To resolve this error in this situation, take one or more of the following actions:<ul><li>Make sure that the version of the Integration Components package on the virtual machine is up to date. On the host for the virtual machine, open **Server Manager**, expand **Roles**, select **Hyper-V**, and then in the **Events** list in the **Summary** area, look for a warning that the Integration Components package must be updated.</li><li> Make sure that all the writers on the virtual machine are in a stable state. On the virtual machine, open an elevated Command Prompt window, type `vssadmin list writers`, and then press Enter.</li><li> Make sure that there are no unresolved VSS errors on the virtual machine. On the virtual machine, open **Server Manager**, expand **Diagnostics**, expand **Event Viewer**, expand **Windows Logs**, and then select **Application**. Resolve any VSS errors that you find.<ul><li>Expand **Diagnostics**, expand **Windows Logs**, and then review the Application and System events for resolution steps.</li><li> Expand **Roles**, select **Hyper-V**, and then, in the **Summary** area, review the **Events** list for resolution steps.</li></ul></li></ul><br/> **Creating a recovery point by using incremental backup for a computer that's running Exchange Server 2010** <br/>Circular logging might be enabled on this data source. DPM 2010 does not support incremental backups for a computer that's running Exchange Server 2010 on which **Circular Logging** is enabled.<br/><br/>To resolve this error in this situation, clear the **Circular Logging** check box, and then try to create the recovery point again.<br/><br/> **The next incremental backup fails when an incremental backup is performed after you run ntbackup on the storage group.** <br/>Create a DPM full recovery point before performing an incremental backup.|
|30113|DPM encountered an error while trying to create a recovery point for one or more volumes for data source <_DatasourceName_> on <_ServerName_>. This may have happened because the volume name is no longer valid.|Retry the operation.|
|30114|No VSS provider supports one or more volumes for data source <_DatasourceName_> on <_ServerName_>, therefore DPM cannot create recovery points for these volumes.|Stop protection for this volume and any data sources that are hosted on this volume.|
|30115|DPM failed to synchronize changes for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> because the snapshot volume did not have sufficient storage space to hold the churn on the protected computer|Retry the operation at a later point when the churn is expected to be lower.|
|30116|VSS has deleted a shadow copy since it has probably run out of disk space on the server <_ServerName_>|Increase the space allocated for the VSS diff area of volumes involved in protection on this server.|
|30117|A journal wrap error has occurred on the change journal, and therefore DPM is unable to track any more changes or may have missed some changes for the data source <_DatasourceName_> on <_ServerName_>|To run synchronization with consistency check, select **Protection** > **Perform consistency check**.<br/><br/>If the problem persists, you can increase the change journal size or configure the current protection group to synchronize more often.<br/><br/>To change the change journal size<br/>1. Select **Modify disk allocation**, then select the **Protected Server** tab.<br/>2. Select **Modify** and change the space allocated.<br/><br/>To change the synchronization schedule:<br/>1. Select the protection group in the **Protection** task area.<br/>2. In the **Actions** pane, select **Modify protection group**.|
|30118|Change journal not initialized or is the wrong size|To configure change journal size, select the **Modify Disk Allocation** link that appears below the alert window. On the **Disk Allocation** page, select **Protected Server** and select **Modify**, then change the space allocated. <br/><br/>Verify that there is at least 300 MB of free space on the volume being protected.<br/><br/>After you modify the protection group, select **Protection** > **Perform consistency check**.|
|30119|The change journal ID may have changed since the last synchronization. DPM is unable to track changes on this computer.| |
|30120|DPM failed to recover all the files.|Recover to an alternate location or try recovering from another recovery point.|
|30121|File copy failed. The directory for source location <_SourceLocation_> or destination location <_DestinationLocation_> does not exist.<br/><br/>(<_Message_>)<br/><br/>Exception trace:<br/><br/> <_ExceptionMessage_>|Make sure that the source and target locations are correct and have appropriate permissions.|
|30122|File copy failed. The source location <_SourceLocation_> does not exist.<br/><br/>(<_Message_>)<br/><br/>Exception trace:<br/><br/> <_ExceptionMessage_>|Make sure that the source and target locations are correct and have appropriate permissions.|
|30123|File copy failed due to an I/O error.<br/><br/>Source location: <_SourceLocation_> <br/><br/>Destination location: <_DestinationLocation_>.<br/><br/>(<_Message_>)<br/><br/>Exception <br/><br/> <_ExceptionMessage_>|Make sure that the source and destination locations exist and have **Full Control** permissions for the local system account.|
|30124|Catalog for backup job was not built correctly for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>.|Retry the operation.|
|30125|Another backup job of <_DatasourceName_> on <_ServerName_> is in progress.|Wait for the earlier backup job to finish, and then retry the backup. Or, you can cancel the current job, and then retry the backup job.|
|30126|Backup of <_DatasourceName_> on <_ServerName_> cannot be completed. DPM could not find a valid recovery point on disk.|On the **Jobs** tab in the **Monitoring** task area, check for failures of synchronization jobs and resolve those. Next, create a valid recovery point and then run the backup to tape job again. To create a valid recovery point:<br/><br/>1. For application data, in the **Protection** task area, select **Create recovery point**, and then select **Express full backup on disk**.<br/>2. For file data, in the **Protection** task area, select **Create recovery point** and then select **Create a recovery point after synchronizing**.|
|30127|The incremental backup job was cancelled because the associated full backup for the data source is not available or there is a newer version of the backup on which this job depends.<br/><br/>This is a non-fatal error. Another backup has been created at approximately the same time as this backup. Use the other backup for recovery.|Retry the operation.|
|30128|Invalid backup type specified for <_DatasourceName_> on <_ServerName_>.|If you are backing up to tape, perform a full backup. If you are backing up to disk, perform an express full backup.|
|30129|DPM failed to generate the file list to complete the task.|On the **Libraries** tab in the **Management** task area, select the tape and then in the **Actions** pane, select **View Contents**.|
|30130|DPM failed to start tracking changes for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> because of insufficient memory resources|Verify that you do not have more than 100 protectable data sources on a single volume. If this is the case, check to see if you can split your data source across more volumes.|
|30131|DPM is not synchronized with the changes on <_DatasourceType_> <_DatasourceName_> on <_ServerName_>. Protection cannot continue.|Check to see if you are protecting a clustered resource which has undergone a dirty failover. In this case, DPM requires a synchronization with consistency check before it can continue protection.|
|30132|A critical internal error was detected while trying to archive a replica dataset of <_DatasourceName_>.|Retry the operation. If the problem persists, contact Microsoft Customer Service and Support.|
|30133|A critical inconsistency was detected for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> and therefore changes cannot be replicated for <_FileName_>.|To validate exclusion and inclusion filters for the data source, in the **Protection** task area, select **Modify Protection Group**. If modifying the protection group does not start a consistency check, run a synchronization with consistency check.|
|30134|DPM failed to clean up data of old incremental backups on the replica for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>. Synchronization will fail until the replica cleanup succeeds.|This may happen if the replica volume is being accessed from outside of DPM. See the detailed error, resolve the issue with respect to the replica volume path, and retry the job. Otherwise, DPM will synchronize with the changes during the next scheduled synchronization job.|
|30135|The replica of <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not consistent with the protected data source.<br/><br/>DPM has detected changes in file locations or volume configurations of protected objects since the data source was configured for protection.|Run synchronization with consistency check.|
|30136|The replica of <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not consistent with the protected data source.<br/><br/>DPM detected that some protected objects are missing since it was configured for protection.|In the **Protection** task area, select **Modify Protection Group** to update the configuration information for the data source on the DPM server and to increase the replica volume size if necessary. If modifying the protection group does not start a consistency check, run a synchronization with consistency check.|
|30137|The replica of <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not consistent with the protected data source.<br/><br/>DPM detected new protectable objects for the data source since it was configured for protection.|In the **Protection task** area, select **Modify Protection Group** to update the configuration information for the data source on the DPM server and to increase the replica volume size if necessary. If modifying the protection group does not start a consistency check, run a synchronization with consistency check.|
|30138|The replica of <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not consistent with the protected data source.<br/><br/>DPM detected changes in existing protected objects and detected new protectable objects for the data source since it was configured for protection.|In the **Protection task** area, select **Modify Protection Group** to update the configuration information for the data source on the DPM server and to increase the replica volume size if necessary. If modifying the protection group does not start a consistency check, run a synchronization with consistency check.|
|30139|The replica is inconsistent for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> due to a CCR failover. A synchronization job with consistency check will be automatically triggered after 30 minutes.|No action required.|
|30140|DPM tried to do a SQL log backup, either as part of a backup job or a recovery to latest point in time job. The SQL log backup job has detected a discontinuity in the SQL log chain for <_DatasourceType_> database <_DatasourceName_> since the last backup. All incremental backup jobs will fail until an express full backup runs.|**For backup failures** <br/>If you see this failure as part of a backup job, in the **Protection** task area, select the SQL Server database, select **Create recovery point**, and then run an express full backup. Alternately, you can wait for the next scheduled express full backup to run.<br/><br/> **For recovery failures** <br/>If this failure occurs as part of a recovery job, then try to recover from another point in time. Review the Application Event Viewer logs on the computer running SQL Server for more details. Make sure that this database is not already protected by another backup application.|
|30141|To recover <_DatasourceType_> <_DatasourceName_> on <_ServerName_>, DPM must stop and start the SQL Server service on <*ServerName*>. After stopping the service, DPM was unable to successfully start the service.|Check that the SQL Server service on the protected computer can be sent the start command successfully. After you ensure that the service can be successfully started, retry the recovery. If this error occurs again, try to recover the master database from another recovery point.|
|30142|To recover <_DatasourceType_> <_DatasourceName_> on <_ServerName_>, DPM must stop and start the SQL Server service on <*ServerName*>. DPM was unable to successfully stop the service.|Check that the SQL Server service on the protected computer can be sent the stop command successfully. After you ensure that the service can be successfully stopped, retry the recovery.|
|30143|Database mount failed for <_DatasourceType_> <_DatabaseName_> on <_AgentTargetServer_>.|Contact the Exchange Server admin. Verify the cause of failure from event logs entries on the Exchange server.|
|30144|Database dismount failed for <_DatasourceType_> <_DatabaseName_> on <_AgentTargetServer_>.|On the Exchange server, verify the cause of failure from event logs entries.|
|30146|Data consistency verification check failed for <_ObjectName_> of <_DatasourceType_> <_DatasourceName_> on <_ServerName_>.|If you recently upgraded your Exchange server, copy them from that server to the DPM server. Contact your Exchange Server administrator, and then verify the issue. You can recover the last known good backup to address the corrupted state.|
|30147|Eseutil.exe failed to apply logs on database files for <_DatasourceType_> <_DatasourceName_> on <_AgentTargetServer_> to bring the database to a clean shutdown state.|Contact the Exchange Server administrator. Event logs on the Exchange server may help resolve the issue. If the problem persists, the recovery point may be corrupt. Retry recovery from another recovery point.|
|30148|DPM was unable to access the cluster resource group <_VirtualName_> for <_DatasourceName_> of protection group <_ProtectedGroup_>|Verify that the cluster resource group <*VirtualName*> is accessible by using the Cluster Administration console.|
|30149|DPM cannot continue protection for <_DatasourceType_> <_DatasourceName_> on cluster <_VirtualName_> because this cluster experienced an unexpected failover.| |
|30150|DPM is attempting to back up or restore a SIS link file, which requires SIS to be enabled on <_ServerName_>.|Enable SIS on the computer by using Add/Remove Windows Components in Add or Remove Programs.|
|30151|DPM failed to read its change tracking information for <_DatasourceName_> on <_ServerName_>| |
|30152|DPM cannot continue protecting <_DatasourceName_> on <_ServerName_> because the volume on which this data resides on has been resized.| |
|30153|The file system on <_ServerName_> where data source <_DatasourceName_> of protection group <_ProtectedGroup_> is located, is either locked by BitLocker Drive Encryption or it is in an invalid state and is no longer available.|Verify that the volumes are online and that the file system is in a consistent state. If the volume is locked, unlock the volume and retry the operation.|
|30154|DPM encountered an unknown error while tracking changes for <_DatasourceName_> on <_ServerName_>| |
|30155|DPM is unable to continue protection for <_DatasourceName_> on <_ServerName_> because this computer has been powered off without shutting it down cleanly.| |
|30156|DPM is unable to continue protection for <_DatasourceName_> on <_ServerName_> because the change tracking information is corrupt| |
|30157|The alias of the user to which DPM has to connect the recovered mail box is online and connected to an Exchange server.|Specify an alias that is offline and not connected to any Exchange server.|
|30158|Verification failed for the tape backup of <_DatasourceType_> <_DatasourceName_> on <_ServerName_>   because the tape backup failed.|Retry the tape backup and then retry verification.|
|30159|DPM cannot continue protection for <_DatasourceType_> <_DatasourceName_> on cluster <_VirtualName_> because this cluster experienced a failover.| |
|30160|DPM failed to perform the tape backup for <_DatasourceType_> <_DatasourceName_> on cluster <_VirtualName_> because this cluster experienced a failover.|Retry the tape backup job.|
|30161|DPM is unable to determine tracking information for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>.|Retry the operation. If the replica has been marked inconsistent, run a consistency check on this data source.|
|30162|Protection cannot continue because the change journal used for tracking changes for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is corrupt due to bad sectors on the disk.|Delete the change journal on the protected computer by using the FsUtil.exe tool and recreate the change journal. Next, run a consistency check on the data source.|
|30163|The path to the SQL temporary folder for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is too long. This can cause backup or recovery jobs to fail.|DPM creates the temporary folder in the same location as the SQL Server database log file. The temporary folder name is **DPM_SQL_PROTECT**.<br/><br/>To fix this issue:<br/>1. Change the location of the database log file so that its physical path is as short as possible.<br/>2. Run a consistency check job for this database.|
|30164|The <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not available.|To troubleshoot this issue, verify the following:<br/>1. The database is online.<br/>2. The database is not in a restoring state.<br/>3. The database has not been deleted.<br/>4. The database is accessible.<br/>5. If the database was part of a mirroring session, either re-establish mirroring between the partner SQL Server databases or remove the database from protection and recreate the protection group for this database.|
|30166|DPM detected that the recovery point volume for <_DatasourceType_> <_DatasourceName_> is not available on the DPM server. Protection jobs will fail until the recovery point volume is brought online.|Ensure that all the disks added to the DPM storage pool are online.|
|30167|The backup job failed because DPM detected that some databases of the Exchange Server Storage Group instance <_DatasourceName_> on <_ServerName_> are offline.|Bring all databases in the storage group online and retry.|
|30168|Full backup is required for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> as <_ServiceName_> service has been restarted.|In the **Protection** task area, select **Create recovery point-disk** and select **Create a recovery point by using express full backup**.|
|30169|The operation failed for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> because the data source is not available.|To troubleshoot this issue, verify the following:<br/>1. The data source is online.<br/>2. The data source is not in a restoring state.<br/>3. The application VSS writer is running.<br/>4. The data source is accessible.<br/>5. The data source is not missing.<br/>6. If the data source is a member of a SharePoint farm, verify that it still exists in the SharePoint farm configuration. For more information on this error, go to [Hyper-V Protection Issues](/previous-versions/system-center/data-protection-manager-2010/ff634205(v=technet.10)).|
|30170|The recovery to the latest point in time failed. During a recovery to the latest point in time, DPM tries to do a tail log restore to apply the latest changes on the SQL database <_DatasourceName_> on <_ServerName_> at the end of the recovery. This tail log restore failed.|Check the Application Event Viewer logs on the SQL Server to find out why the tail log restore may have failed.<br/><br/>You can do the following to fix the issue:<br/>1. Recovery to the latest point in time is not possible immediately after another recovery has been performed on the same database. Allow a synchronization job to run before you attempt a recovery to the latest point in time.<br/>2. Choose an alternate point in time to recover to, if you run into this problem repeatedly.|
|30171|The recovery to the latest point in time has failed. During a recovery to the latest point in time, DPM tries to do a SQL Server transaction log backup to get the latest changes from the SQL Server database <_DatasourceName_> on <_ServerName_> before starting the recovery. This transaction log backup has failed.|Check the Application Event Viewer logs on the SQL Server to find out why the SQL Server transaction log backup may have failed.<br/><br/>You can do the following to fix the issue:<br/>1. If the SQL Server log chain is broken, you will have to run a full backup to reinitialize the log chain<br/>2. If the DPM replica for database is invalid, you will have to run a consistency check operation for this database. <br/><br/>Choose an alternate point in time to recover to, if transaction log backups cannot be successfully run against database.|
|30172|The DPM job failed for SQL Server 2012 database <_DbName_> on <_AGName_> because the SQL Server instance refused a connection to the protection agent (ID 30172 Details: Internal error code: 0x80990F75).|To resolve this issue, open the SQL Server management console, navigate to **Properties** > **General** > **Readable Secondary** for the **Availability Group**, and set both the primary and secondary server to **Yes**.|
|30173|Execution of SQL command failed for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> with reason: <_Reason_>.|Check the Application Event Viewer logs on the instance of SQL Server for entries that were posted by the SQL Server service to find out why the SQL command may have failed. For more information, look at the SQL Server error logs.|
|30174|Recovery failed for <_DatasourceType_> <_DatasourceName_> because the overwrite flag is not set for <_DatabaseName_> on <_AgentTargetServer_>.|On the Exchange Administrator Console, set the **Overwrite database** flags for the databases being recovered and retry the operation.|
|30175|DPM failed to replicate changes for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> due to the high amount of file system activity on this volume.|Check to see that no application running on this computer is malfunctioning to cause this high file system activity. If you consistently run into this error, in the **Protection** task area, select **Modify disk allocation**. To increase the change journal size on the protected computer, on the **Protected Computers** tab, select **Modify**.|
|30176|File delete failed due to I/O error. File may be in use by some other application. File location: <_Location_>|Ensure that the file location is correct and that the file has appropriate permissions.|
|30177|PrmFileDeleteNameNullError| |
|30178|PrmFileDeleteNameImproperError| |
|30179|PrmFileDeleteFileDoesNotExistError| |
|30180|PrmFileDeleteDirectoryNotFoundError| |
|30181|PrmFileDeletePathTooLongError| |
|30182|PrmFileDeleteNotSupportedError| |
|30183|File delete failed because of unauthorized access error. File path: <_Location_>|Ensure that the file location is correct and that the file has appropriate permissions.|
|30184|DPM cannot continue protection for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>.|In the **Monitoring** task area, resolve the **Unable to configure protection** alert for this data source, and then select the link that follows to retry the job.|
|30185|Recovery for <_DatasourceType_> <_DatasourceName_> to the latest recovery point cannot be performed because you have already recovered it to a previous recovery point.|In the **Recovery** task area, select the recovery point prior to the latest recovery point.|
|30186|The protection agent on <_ServerName_> is disabled.|In the **Management** task area of the DPM Administrator Console, on the **Agents** tab, enable the protection agent on the protected computer.|
|30187|Protection agent on <_TargetServerName_> was unexpectedly shut down during synchronization. DPM may have replicated data partially for <_DatasourceType_> <_DatasourceName_>.| |
|30188|Recovery point for <_DatasourceType_> <_DatasourceName_> was created when the replica was inconsistent. Some data from this recovery point may contain partially synchronized data.| |
|30189|The execution of the pre-backup script for <_DatasourceType_> <_DatasourceName_> returned an error.|Make sure that the pre-backup script does not have any errors and can execute successfully.|
|30190|The execution of the post-backup script for <_DatasourceType_> <_DatasourceName_> returned an error.|Make sure that the post-backup script does not have any errors and can execute successfully.|
|30191|The execution of the pre-backup script for <_DatasourceType_> <_DatasourceName_> timed out.|Make sure that the pre-backup script finishes execution within the time specified, or increase the timeout period.|
|30192|The execution of the post-backup script for <_DatasourceType_> <_DatasourceName_> timed out.|Make sure that the post-backup script finishes execution within the time specified, or increase the timeout period.|
|30193|The configuration of the pre-backup script or the post-backup script XML for <_DatasourceType_> <_DatasourceName_> is incorrect.|Make sure that the pre-backup script or post-backup script configuration XML file does not have any errors and that the XML is well formed.|
|30194|DPM cannot protect <_DatasourceName_> on <_ServerName_> because case-sensitive support is not enabled on the DPM server.| |
|30195|DPM has run out of free space on the recovery point volume and will fail synchronization for <_DatasourceName_> on <_ServerName_> in order to prevent existing recovery points from being deleted.|Make sure that there are no pending recovery point volume threshold alerts that are active for this data source, and then rerun the job. DPM may have automatically grown the volume and resolved the alerts.|
|30196|Recovery failed for <_DatasourceType_> <_DatasourceName_> on <_AgentTargetServer_> as the specified storage group is a recovery storage group.|Retry the operation and specify a storage group that is not a recovery storage group, or select the Recover to Recovery Storage Group option.|
|30197|Recovery failed for <_DatasourceType_> <_DatasourceName_> on <_AgentTargetServer_> as the specified storage group is not a recovery storage group.|Retry the operation and specify a recovery storage group.|
|30198|Recovery failed for <_DatasourceType_> <_DatasourceName_> on <_AgentTargetServer_> as the alternate storage group or the database specified is invalid.|Verify that the storage group or the database exists on the Exchange server.|
|30199|Recovery failed for <_DatasourceType_> <_DatasourceName_> on <_AgentTargetServer_> because the target database specified is in mounted state.|Verify that the target database is in a dismounted state.|
|30200|Prepare for backup operation for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> has been stopped because this operation depended on another backup operation that failed or was cancelled.|Retry the operation.|
|30201|Prepare for recovery operation for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> has been stopped because this operation depended on another recovery operation that failed or was cancelled.|Retry the operation.|
|30202|The SQL temporary folder for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not yet configured.|DPM creates the temporary folder in the same location as the SQL database log file. The temporary folder name is **DPM_SQL_PROTECT**.<br/><br/>DPM has not yet configured the temporary folder on <_Server Name_>. In the **Protection** task area, create a recovery point for this database.|
|30203|Replica for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is already consistent. Scheduled consistency check will not be run on consistent replica.| |
|30204|Replica writer is enabled for <_DatasourceType_> <_DatasourceName_> on <_AgentTargetServer_> for Exchange 2007 with LCR.|DPM requires the replica writer to be disabled for protecting Exchange Server 2007 with LCR. Disable the replica writer by adding a DWORD entry, `EnableVssWriter`, to the `HKLM\Software\Microsoft\Exchange\Replay\Parameters` subkey, setting the value to **0**, and restarting the **Microsoft Exchange Replication Service**. Then retry the operation.|
|30205|Recovery failed for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> because a database with the name you specified already exists on the SQL instance.|Provide an alternate name for the database to be recovered. Ensure that no database with the name you have specified already exists on the SQL server.|
|30207|DPM was unable to compile a list of recoverable objects for <_DatasourceType_> <_DatasourceName_>. You will be unable to perform granular level recoveries from this recovery point. No action is required because the next scheduled full backup will synchronize the list of recoverable objects. Alternately, in the **Protection** task area, select the required protected object, click **Create recovery point**, and select the option to create a recovery point using a full backup.| |
|30208|Data consistency check timed out for <_ObjectName_> of <_DatasourceType_> <_DatasourceName_> on <_ServerName_>.|If the error has been reported for your Exchange server, it indicates that the Exchange server backup files may be corrupt. Follow these steps to resolve the issue:<br/>1. Consult the Exchange server administrator to verify if the databases and logs on the Exchange server are in a good state.<br/>2. If the database and logs on the Exchange server are not corrupt, you need to run a synchronization with consistency check for this data source.<br/>3. In case the database and logs on the Exchange server are corrupt, you can choose to recover the Exchange data from the last known good backup.|
|30209|DPM has detected that the cluster configuration has changed for resource group <_VirtualName_> and has marked the replica inconsistent.| |
|30210|The execution of the pre-snapshot step returned an error.|Check to see that the pre-snapshot step does not have any errors and can execute successfully.|
|30211|The execution of the pre-snapshot step timed out.|Check to see that the pre-snapshot step can complete successfully within the timeout period.|
|30212|The execution of the post-snapshot step returned an error.|Check to see that the post-snapshot step does not have any errors and can complete successfully.|
|30213|The execution of the post-snapshot step timed out.|Check to see that the post-snapshot step can complete successfully within the timeout period.|
|30214|DPM failed to create the backup. If you are backing up only System State, verify if there is enough free space on the protected computer to store the System State backup. On protected computers that are running Windows Server 2008, verify that Windows Server Backup (WSB) is installed and that it is not performing any other backup or recovery task.|You can see the errors reported by WSB in the event log on the protected computer. For resolution actions and more information on these errors, go to [Backup Operations](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc734488(v=ws.10)).|
|30216|Windows Server Backup can truncate Exchange Server and SQL Server logs being protected by DPM.|To resolve this error, do the following:<ul><li>If you use Windows Server Backup to back up a volume, do this only by using the Backup Once Wizard.</li><li>If you use the Backup Schedule Wizard to perform scheduled backups, make sure that the volumes that are being protected by DPM do not contain application data such as Exchange Server mailbox stores or SQL Server databases.</li><li>Reconfigure Windows Server Backup. Then, in DPM Administrator Console, in the **Protection** task area, select the volume, select **Create recovery point**, and then, in the **Actions** pane, select **Express full backup**.</li></ul>|
|30215|Failed to create the System State backup within the timeout period.|Check the event log on the protected computer <_ServerName_> to determine why the backup timed out.|
|30217|The version of Eseutil in DPM does not match the one on the Exchange server being protected. This may cause the consistency check to fail.<br/><br/>Copy the following files from the installation folder of the Exchange server that you are protecting to <_FolderPath_> on the on DPM server.<br/><br/>ese.dll<br/><br/>eseutil.exe<br/><br/>You must also ensure that you do not copy a 64-bit version of eseutil.exe to a 32-bit DPM server. The 32-bit version of eseutil.exe is available on the Exchange server setup DVD.<br/><br/>You can also choose not to run Eseutil consistency check for this protection group, by deselecting the **Run Eseutil Consistency check** option. This is not recommended because it will not ensure that the protected Exchange data can be recovered.<br/><br/>Do you want to continue?| |
|30218|Operation failed because DPM encountered an unexpected VSS error.|Check the Application event log on <_ServerName_> for the cause of the failure. Fix the cause and retry the operation.<br/><br/>For more information on this error, see [Hyper-V Protection Issues](/previous-versions/system-center/data-protection-manager-2010/ff634205(v=technet.10)).|
|30219|Cmdlet execution failed (<_Reason_>) for <_DatasourceType_> <_DatasourceName_> on <_AgentTargetServer_>|Contact the Exchange Server admin and resolve the issue.|
|30220|Activation of COM component ExchangeCmdletWrapper failed on <_AgentTargetServer_>|Make sure that the COM component ExchangeCmdletWrapper is configured appropriately.|
|30221|DPM failed to replicate the changes for the <_DatasourceType_> <_DatasourceName_>. The operation failed while DPM was attempting to apply the changes to the replica.| |
|30222|DPM is unable to continue protection for <_DatasourceName_> on server <_ServerName_> since the change tracking information is corrupt| |
|30223|The recovery failed for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> because a mirroring session exists for this database.|Verify that the database that is being recovered is not a part of a mirroring session.|
|30224|Recovery point creation of data source <_DatasourceName_> on <_ServerName_> to DPM Online cannot be completed. DPM could not find a valid recovery point on disk.|On the **Jobs** tab in the **Monitoring** task area, check for failures of synchronization jobs and resolve those. Next, create a valid disk recovery point and then run DPM online recovery point creation job again. To create a valid recovery point:<br/>1. For application data, in the **Protection** task area, select **Create recovery point**, and then select **Express full backup on disk**.<br/>2. For file data, in the **Protection task** area, select **Create recovery point** and then select **Create a recovery point after synchronizing**.|
|30225|Job failure on replica of <_DatasourceName_> on <_ServerName_> caused by ongoing DPM Online recovery point creation.|Cancel the operation, or wait for it to complete. Then retry the operation.|
|30226|Job failure on replica of <_DatasourceName_> on <_ServerName_> caused by ongoing grow operation.|Wait for operation to complete. Then retry the operation.|
|30227|Job failure on replica of <_DatasourceName_> on <_ServerName_> caused because it is already valid.|No action is needed.|
|30228|The replica of <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not consistent with the protected data source.<br/><br/>DPM has detected changes in file locations or volume configurations of protected objects since the data source was configured for protection.|To update the configuration information for the data source on the DPM server, select the **Modify protection group for this data source**  link that appears below the alert window. Then run a synchronization job with consistency check.|
|30229|DPM cannot create a backup because Windows Server Backup (WSB) on the protected computer encountered an error (WSB Event ID: <_WindowsBackupEventID_>, WSB Error Code: <_WindowsBackupErrorCode_>).|For resolution actions and more information about the WSB error, go to [Backup Operations](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc734488(v=ws.10)).|
|30230|DPM cannot continue protection of <_DatasourceType_> <_DatasourceName_> on <_ServerName_> because protection agents are not upgraded on all nodes that the resource group of this data source could fail over to.|On the **Agents** tab in the **Management** task area, upgrade protection agents on all nodes that resource group of this data source could fail over to.|
|30231|The operation failed for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> because the data source caption has changed.|To restart the backups, do following:<br/>1. Stop protection (while retaining data).<br/>2. Reprotect the protection group.|
|30232|You cannot perform any recoveries because no backups have been taken after upgrade. However you can restore as files.|Perform restore as files to recover data.|
|30241|DPM is attempting to back up or restore a deduped file, which requires Deduplication to be enabled on <_AgentTargetServer_>.|Enable deduplication on the computer by using **Add/Remove Windows Components** in **Add or Remove Programs** in Control Panel.|
|30242|DPM is attempting to back up or restore deduped files, which requires target to be an NTFS volume and deduplication should be disabled for that volume.|Select a volume with NTFS filesystem as backup/recovery target and make sure deduplication is disabled for that volume.<br/><br/>To disable deduplication on one volume, use the [Disable-DedupVolume](/powershell/module/deduplication/disable-dedupvolume) cmdlet.|
|30288|Offline backup of virtual machine <_VirtualMachineName_> is not supported.|To allow offline backups of the virtual machines on <_ServerName_> set the registry key <_RegistryKey_> to **1** and then try running the job again.|
|30289|Hyper-V role is not installed on <_ServerName_>. Cannot recover a virtual machine to a host where Hyper-V role is not installed.|Install Hyper-V role on <*ServerName*> and then try running the job again.|
|30290|Failure occurred while adding one or more of the volumes involved in backup operation to snapshot set. Please check the event log on <_ServerName_> to troubleshoot the issue.|To resolve this error, make sure that the Challenge-Handshake Authentication Protocol (CHAP) credentials that are needed to create hardware snapshots are correctly configured on the host computer that is running Hyper-V. For more information, see the documentation from your VSS hardware provider vendor.|
|30294|NoDiffAreaAssoc| |
|30295|The shadow storage association for <_DatasourceName_> is missing.|Check the application event log for VSS errors.|
|30299|DPM encountered a retryable VSS error.|Ensure that the virtual machine that you are recovering is shut down, and then retry the recovery. If the error persists, check the Application event log on <_ServerName_> for the cause of the failure. Fix the cause and retry the operation.<br/><br/>For more information on this error, see [Hyper-V Protection Issues](/previous-versions/system-center/data-protection-manager-2010/ff634205(v=technet.10)).|
|30300|Synchronization for replica of <_DatasourceName_> on <_ServerName_> failed because the replica is not in a valid state or is in an inactive state.|Review the application event log on the protected computer for errors from the DPM writer service. Take appropriate action and retry the operation.|
|30301|The replica for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not consistent with the protected data source.|<br/>1. Check to see if some dependent data sources have been added to the protected data source <*DatasourceName*>. In that case run **Modify Protection** for the protection group and consistency check for the data source by selecting the respective links below the alert window.<br/>2. If no dependent data sources have been added to <*DatasourceName*>, verify if any of the dependent data sources are already getting directly protected by DPM. If this is the case, then go to the protection pane and stop protecting these data sources with the option to delete the replica. After this is done, recreate protection for <*DatasourceName*>.<br/>3. If neither of the earlier options are valid, verify if the associated VSS writers are running correctly on the backend Servers. If the writer is not in a healthy state, restart the writer.|
|30302|The replica for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not consistent with the protected data source.|Verify if any of dependent data sources of the protected data source <*DatasourceName*> were removed or got moved from one server to another. If either of this has happened, then on the Protection pane, stop protection for this data source, and select the **Retain current data backups** option. Then recreate the protection group <*DatasourceName*> again.|
|30303|DPM failed to back up <_DatasourceType_> <_DatasourceName_> on <_ServerName_> to tape.|<br/>1. Check to see if there are any dependent data sources that were added or removed from the protected data source <*DatasourceName*>. If a data source was added or removed, in the Protection pane, stop protection of <*DatasourceName*>, and select the **Retain current data backups** option. Then recreate the protection group for <*DatasourceName*>.<br/>2. If any of the dependent data sources that belong to <*DatasourceName*> are already being protected directly by DPM, then in the **Protection** task area, stop protecting these dependent data sources by selecting the **Delete the replica** option. Then, recreate the protection group for the <*DatasourceName*>.|
|30400|To protect the selected data source, <_ServerName_> needs to be restarted for creating the change journal.|Restart the computer and then synchronize with consistency check.|
|30500|Change tracking has been marked inconsistent due to one of the following reasons<br/><br/>1. Unexpected shutdown of the protected server.<br/><br/>2. Unforeseen issue in DPM Bitmap failover during cluster failover.|To troubleshoot this error:<br/>1. Verify that the newly added nodes of cluster have DPM agent installed on them.<br/>2. Run a synchronization job with consistency check.|
|30501|Change Tracking has been marked inconsistent due to one of the following reasons<br/><br/>1. Unexpected shutdown of the protected server<br/><br/>2. Unforeseen issue in DPM Bitmap failover during cluster failover of one or more datasources sharing the tracked volume.|Run a synchronization job with consistency check.|
|30502|Change Tracking has been marked inconsistent due to overflow of the DPM filter log file during Dismount.|Run a synchronization job with consistency check.|
|30503|Change Tracking has been marked inconsistent due to unforeseen issue during volume dismount or cluster failover.|Run a synchronization job with consistency check.|
|30504|DPM Agent cannot detect the DPM Bitmap.|Run a synchronization job with consistency check.|
|31000|Operation failed since the protected data source size had not been calculated for <_DatasourceName_> prior to running this operation.|Ensure that before this operation runs,`Get-DatasourceDiskAllocation` and `Set-DatasourceDiskAllocation` run successfully.|
|31001|Failed to create the protection group since some of the required schedules have not been specified.| |
|31002|Failed to create the protection group because a library or stand-alone tape drive has not been specified and tape protection has been selected.|Specify a library or stand-alone tape drive and then try to create the protection group.|
|31003|Operation failed because <_ServerName_> or one of its owner nodes are not accessible from the DPM server.|Use the cluster management software to check to see if the cluster resource group <*ServerName*> or any of its owner nodes are online.|
|31004|Failed to enumerate resource groups on the cluster <_ServerName_>| <*ServerName*> represents the cluster name.<br/>1. Verify that the cluster service is running on the cluster.<br/>2. Verify that you can ping the cluster from the DPM server.<br/>3. If the cluster service is online, refresh the nodes of the cluster in the **Agents Management** tab.|
|31005|DPM cannot protect the cluster resource group on <_ServerName_> because protection agents are not installed on all nodes that this resource group could fail over to.|On the **Agents** tab in the **Management** task area, install protection agents on all nodes that this resource group could fail over to.|
|31006|DPM cannot start the Create New Protection Group Wizard because there are no computers with protection agents installed.|On to the **Agents** tab in the **Management** task area, install protection agents on the computers that you want to protect. After installing the agents successfully, start the Create New Protection Group Wizard.|
|31007|Consistency check is a time intensive operation. It is recommended that you start it only if the replica is inconsistent with the protected data.<br/><br/>Do you want to perform the consistency check?| |
|31009|Modify Protection Group is disabled because the following network names have been deleted: <_InputParameterTag_>.|Stop protection of protected members on these clusters before you modify the protection group.|
|31010|Failed to create the protection group because no members were selected for protection.|Retry protection group creation by adding members.|
|31011|The parameter set that you have specified is incorrect. Specify only short-term disk policy objective.| |
|31012|The parameter set that you have specified is incorrect. Specify only short-term tape policy objective.| |
|31013|The parameter set that you have specified is incorrect. Specify only long-term tape policy objective.| |
|31014|The parameter set that you have specified is incorrect. Specify only short- and long-term tape policy objectives.| |
|31015|The parameter set that you have specified is incorrect. Specify only short-term disk and long-term tape policy objectives.| |
|31016|Incremental synchronization job cannot run on all the protected items in this protection group. Change the synchronization frequency to **Just before a recovery point**.| |
|31017|Long-term retention range can be specified only in weeks, months, or years.| |
|31018|The specified retention range supports the following backup frequencies only: <_InputParameterTag_>| |
|31019|The item <_ProtectableObject_> does not exist in protection group <_ProtectedGroup_>.| |
|31020|The item <_ProtectableObject_> cannot be excluded because it is a data source.| |
|31021|Recovery point cannot be created for external data source <_DatasourceName_>.| |
|31022|Recovery point cannot be created for unprotected data source <_DatasourceName_>.| |
|31023|Recovery point cannot be created on disk for data source <_DatasourceName_> because the protection for <_ProtectedGroup_> has been set to tape.| |
|31024|Cannot run an incremental synchronization and create a recovery point for <_DatasourceName_> because the application does not support it.| |
|31025|Recovery point cannot be created on tape for data source <_DatasourceName_> because the protection for <_ProtectedGroup_> has been set to disk.| |
|31026|Protection for <_ProtectedGroup_> has been set only to disk.| |
|31027| <_LibraryType_> <_Library_> has <_Total_> drives. You cannot specify a value more than that.| |
|31028|Data source <_DatasourceName_> does not belong to a protection group.| |
|31029|Data source <_DatasourceName_> has no inactive replica on <_MediaLabel_>.| |
|31030|No library has been specified for protection.| |
|31031|Protection for <_ProtectedGroup_> has been set only to tape.| |
|31032|Journal size cannot be set for <_DatasourceName_> because this data source does not use a change journal.| |
|31033|Operation failed because the recovery point specified for deletion was created as part of an incremental tape backup.<br/><br/>DPM can only delete recovery points that were created as part of a full tape backup. Retry the operation after specifying a recovery point created by a full tape backup. This will automatically delete all the recovery points created by the full tape backup as well as all dependent incremental tape backups.| |
|31034|The operation will remove the following recovery point(s) because they have dependencies on each other:| |
|31035|Do you want to proceed with the operation?| |
|31036|Consistency check schedule should be modified using the <_InputParameterTag_> cmdlet.| |
|31037|DayofWeek needs to be specified to continue.| |
|31038|Cannot specify consistency check schedule for protection groups configured only for tape-based protection.| |
|31039|RelativeInterval needs to be specified to continue.| |
|31040|Duplicate times specified, specify unique times.| |
|31041|Duplicate weekdays specified, specify unique days of the week.| |
|31042|Cannot specify offset schedules for protection groups configured only for tape-based protection.| |
|31043|Consistency check cannot be started for unprotected data source <_DatasourceName_>.| |
|31044|Consistency check cannot be started for data source <_DatasourceName_> because the protection for <_ProtectedGroup_> has been set to tape.| |
|31045|There are multiple copies of data. Choose one of the following and pass it to this cmdlet.| |
|31046|DPM cannot protect this data source. You can only select the DPM database for protection from the DPM server. To protect file systems, you have to enable the AllowLocalDataProtection setting using Set-DpmGlobalProperty cmdlet from DPM Management Shell.| |
|31048|Online recatalog can be run for volumes, file shares or client computers only.| |
|31049|The number of recovery point locations should be equal to the number of recoverable items passed to this cmdlet.| |
|31050|The recovery point location that you have passed is invalid. Try again with a different value.| |
|31051|Add the search path string and try again.| |
|31052|This step cannot be performed because some of the prerequisite steps have not run. Ensure that the appropriate steps among <_MissingStepList_> have run successfully and then retry this step. For more information, see the DPM Help.| |
|31053|This protection group does not support the given protection type. Try again with a different value.| |
|31054|All data sources passed should belong to the same protection group.| |
|31055|The data source <_DatasourceName_> specified is not a part of the protection group <_ProtectedGroup_>.| |
|31056|The minimum space required for the <_DiskItem_> is <_MinimumSize_>. Choose a value more than that and try again.| |
|31057|The disk space requirement for <_DiskItem_> cannot be less than the current value of <_UsedSize_>. Choose a value more than that and try again.| |
|31058|The data source <_DatasourceName_> is not protected and size calculations cannot be done on it.| |
|31059|Size optimization cannot be done on data source <_DatasourceName_>. This can be done only if a part of the data source is protected. Retry without the `-CalculateSize` option.| |
|31060|This recovery source location is on a disk and not on a tape.| |
|31061|Specify a scheduled replica creation time that is less than 1 year.| |
|31062|The protection type has been set to disk-based protection only, therefore this command is ignored.| |
|31063|This tape is marked as a cleaning tape. Run the command on the correct tape.| |
|31064|Incorrect start time specified. Enter the start time in the following format **hh:mm**| |
|31065|Child data source objects cannot be obtained for external data source <_DatasourceName_>.| |
|31066|Protection group <_ProtectedGroup_> does not contain this type of schedule.| |
|31067|This file type has not been specified for exclusion.| |
|31068|This member is not specified for protection and cannot be removed from protection.| |
|31069|No library specified for recovery.|Specify the library to use in the **RecoveryOption** for recovery from tape, and then retry the operation.|
|31070|This operation is valid only on a recovery point on tape.| |
|31071|The recovery point location passed does not belong to current recovery point.| |
|31072|This step cannot be performed because prerequisite steps have not been completed. For more information, type `Get-Help <CmdletName>` in DPM Management Shell.| |
|31073|Invalid Search Detail Passed| |
|31074|The target computer either does not exist or is currently not protected by DPM| |
|31075|Shares can be retrieved only from a volume recovery point| |
|31076|Recovery cannot proceed as the replica for the selected data source is not in **replica creation pending** state.|Before you recover data to the replica, make sure that you have run `DpmSync -reallocateReplica`. For details, see the DPM Operations Guide.|
|31077|The search string should use UNC Format if the protected computer is not specified. If the search is intended on a folder, then specify the protected computer name.| |
|31078|System state cannot be recovered back to the original location. Restore to an alternate location.| |
|31079|The recoverable item cannot be recovered. See DPM Help for more details.| |
|31080|The specified alternate instance is the same as original. Specify a different instance or change the database name| |
|31081|The specified target server and one or more database file locations are the same as the original. The recovery might fail or the files may be overwritten. Do you want to continue?| |
|31082|The specified alternate database name is a system database. DPM cannot recover a system database to an alternate location. Change the specified database name so that it is not a system database.| |
|31083|The alternate database name is empty. Provide a valid alternate database name to use for the recovery| |
|31084|The alternate SQL instance name is either empty or invalid. Provide a valid alternate SQL instance name to use for the recovery| |
|31085|DPM cannot detect the volume <_DatasourceName_> on server <_ServerName_>.|If the volume is present, this problem can be rectified by refreshing the state using the `Get-Datasource -ProductionServer <ProductionServer> -Inquire` cmdlet, then retry the current task.|
|31086|Data source <_DatasourceName_> cannot be selected for protection because it was previously protected as part of data source *<_ReferentialDatasourceName_>* and has inactive disk or tape replicas.|Remove the inactive protection for *<*ReferentialDatasourceName*>* in the **Protection** task area by selecting the data source and then, in the **Actions** pane, selecting **Remove inactive protection**.|
|31087|The selected database has multiple FILESTREAM data groups that cannot be recovered to the same file path.|Please select distinct file paths for the SQL FileStream groups of the database to continue with the recovery.|
|31088|The specified short-term backup frequency does not support creation of incremental backups.|Specify a daily backup frequency or remove the CreateIncrementals parameter.|
|31089|The specified IP address already exists in the list of IP addresses specified in the backup LAN IP address list.|If you would like to change the sequence number of the IP address, first remove the IP address and then add it to the appropriate sequence number.|
|31090|The specified IP address cannot be removed because it does not exist in the backup LAN IP address list.|Only the addresses that are currently a part of the Backup LAN can be removed. Use Get-BackupNetworkAddress to view a list of IP addresses that are a part of the Backup LAN.|
|31091|The specified address is not a valid subnet address.|Subnet address should be in either of the following formats, 10.212.12.55/16 (IPV4) or A821:db8:3c4d:15::/64 (IPV6)|
|31092|The specified sequence number is not valid. Try again with a valid number.|Use `Get-BackupNetworkAddress` command to see the list of valid sequence numbers|
|31093|The specified subnet mask is not valid for IPV6.|Valid subnet mask for IPV6 address lies between 1 - 128.|
|31094|The specified subnet mask is not valid for IPV4.|Valid subnet mask for IPV4 address lies between 1 - 32.|
|31095|The specified recovery options are not valid.|Check the parameters that you are passing to the cmdlet and ensure that these parameters correspond to the data source type that you are attempting to recover.|
|31096|Failed to perform Test-DPMTapeData on the specified recovery point since this was created by some other DPM installation.|Retry this operation on the DPM server that was used to create this recovery point.|
|31097| <_ServerName_> is not an owner for the Exchange cluster resource group <_VirtualName_>.|Contact your Exchange administrator or retry with the fully qualified domain name (such as test.contoso.com).|
|31098|The PreferredPhysicalNode is specified incorrectly.|Provide all the values and try again.<br/><br/>For example: `- PreferredPhysicalNode (ResourceGroup1.contoso.com, server1.contoso.com), (ResourceGroup2.contoso.com, server2.contoso.com)`.|
|31099|The retention range cannot be achieved with the current synchronization frequency.| |
|31100|Invalid command-line parameters specified.|Provide the correct parameters and try again.|
|31101|The rescan operation checks for new libraries attached to the DPM server and refreshes the state of currently attached libraries.<br/><br/>Do you want to proceed with rescan?| |
|31102|The rescan operation failed. For more details, view the **Jobs** tab in the **Monitoring** task area.| |
|31103|Rescan operation completed successfully.| |
|31104|Depending upon the library type, unlocking the door will cancel the jobs that are currently running in the library. New jobs will be added to the queue and begin when the library door is locked.<br/><br/>Do you want to unlock the door for <_LibraryType_> <_Library_>?| |
|31105|The door on the <_LibraryType_> <_Library_> could not be unlocked| |
|31106|Door successfully unlocked for <_LibraryType_> <_Library_>. You can now open the library door.<br/><br/>The door will be automatically locked again in <_TimeInMinutes_> minutes.| |
|31107|The door on the <_LibraryType_> <_Library_> could not be locked.|Check the library door and ensure that it is closed properly. If the door is not closed, close it and then retry this operation.|
|31108|Door successfully locked for <_Library Type_> <_Library_>.| |
|31109|Disabling libraries will affect the protection jobs that use the libraries.<br/><br/>Are you sure you want to disable the selected libraries?| |
|31110|The selected drive is in use.<br/><br/>To disable the drive, wait for the job to finish or cancel the job.| |
|31111|The selected drive is the only functioning drive in the library.<br/><br/>Disabling it would fail all the protection jobs that are configured for that library.<br/><br/>Do you want to disable the selected drive?| |
|31112|Selected drive is disabled.<br/><br/>Any protection jobs configured to use the library to which the selected drive belongs will use the remaining drives on the library.| |
|31113|Selected drives are enabled.| |
|31114|Cleaning tapes are not available in <_Library_>, to clean the selected drives.<br/><br/>Please add cleaning tapes and restart the cleaning job.| |
|31115|Mark the selected tape as a cleaning tape?| |
|31116|The selected tapes cannot be marked as free because they belong to protection groups.<br/><br/>You need to stop protection of the associated protection groups before you can mark the tapes as free. The protection group that a tape belongs to is listed in the Protection Group column.| |
|31117|MarkAsFreePGEraseIntentError| |
|31118|Marking the tapes as free does not erase the contents of the tapes, but only makes the tapes available for use by protection groups.<br/><br/>Do you want to mark the selected tapes as free?| |
|31119|DPM needs to recatalog the selected tape before it can display its contents.<br/><br/>Do you want to recatalog the tape now?| |
|31120|The selected tapes cannot be erased because they belong to protection groups.<br/><br/>You need to stop protection of the associated protection groups before you can erase the tapes. The protection group that a tape belongs to is listed in the Protection Group column.| |
|31121|Data cannot be retrieved from erased tape.<br/><br/>Do you want to erase the selected tapes?| |
|31122|DPM will recatalog the selected imported tapes to extract information about the data that they contain. After the recatalog operation is completed, this data will be listed under External DPM Tapes in the Recovery task area.<br/><br/>You can monitor the progress of this operation on the Jobs tab in the Monitoring task area.<br/><br/>In the jobs view, you may see fewer number of tapes selected because DPM will not recatalog the tapes that don't require recataloging.<br/><br/>Do you want to proceed with the recatalog operation?| |
|31123|I/E port door of <_Library_> is now open. Place the tapes to be added in the I/E port, and then click **OK**.<br/><br/>On clicking **OK**, the I/E port door will be closed and the tapes in I/E port will be added to the library.| |
|31124|The selected tapes could not be marked as free because another job has reserved them for use.| |
|31125|The selected tape(s) could not be marked as cleaning tapes because they are currently in use.| |
|31126| <_FailureCount_> tape(s) could not be marked as cleaning tapes because they are currently in use.| |
|31127|DPM could not perform the requested action on the selected items.<br/><br/>This could be because the selected items or some properties associated with these items have changes that prevent the action from being taken.|Close and reopen DPM Administrator Console to synchronize it.|
|31128|The selected data will be copied to the specified location.<br/><br/>You can monitor the progress of the copy job(s) on the Jobs tab in the Monitoring task area.| |
|31129| <_FailureCount_> out of <_Total_>; selected tapes cannot be marked as free because they belong to protection groups.<br/><br/>You need to stop protection of the associated protection groups before you can mark the tapes as free. The protection group that a tape belongs to is listed in the Protection Group column.| |
|31130| <_FailureCount_> out of <_Total_>; selected tapes could not be marked as free because another job has reserved them for use.| |
|31131| <_FailureCount_> out of <_Total_>; selected tapes cannot be marked as free. The tapes must be erased.<br/><br/>Click Erase tape in the Actions pane to erase the tapes. This requirement to erase the tapes was specified in the protection groups to which the tapes previously belonged.| |
|31132|The selected tapes will be moved to the I/E port of the library.<br/><br/>Do you want to proceed with the operation?| |
|31133| <_FailureCount_> out of <_Total_>; tapes cannot not be erased because they contain data that is being protected.<br/><br/>You need to stop protection of the associated protection groups before you can erase the tapes. The protection group that a tape belongs to is listed in the Protection Group column.| |
|31134|The selected tape(s) could not be unmarked as cleaning tapes because they are currently in use.| |
|31135| <_FailureCount_> tape(s) could not be unmarked as cleaning tapes because they are currently in use.| |
|31136|The selected tape is currently being recataloged.<br/><br/>The contents of this tape can be viewed only after the recatalog operation successfully completes.| |
|31137|Operation failed because <_LibraryType_> <_Library_> is offline.| |
|31138|Operation failed because <_LibraryType_> <_Library_> is disabled.| |
|31139|Door of <_LibraryType_> <_Library_> is already unlocked.| |
|31140|Door of <_LibraryType_> <_Library_> is being unlocked. Wait for the operation to complete.| |
|31141|Door of <_LibraryType_> <_Library_> is already locked.| |
|31142|Door of <_LibraryType_> <_Library_> is being locked. Please wait for the operation to complete.| |
|31143|Connection already exists to DPM server <_ServerName_>. You can only be connected to a single DPM server at a time. End the existing connection using Disconnect-DPMServer before attempting to run cmdlets that are targeted to another DPM server.| |
|31144|The server <_ServerName_> could not be found in Active Directory.|To verify that this server is accessible, ping it. Then retry the operation. If the server is accessible, verify that the DPM service is running and that the current user has a domain account and is a member of the local administrators group. If the problem persists, contact your DPM administrator.|
|31145|Tape in <_Location_> cannot be recataloged. Perform the following before retrying this cmdlet:<br/><br/>If the tape is marked as free, run Set-Tape -NotFree on this tape.<br/><br/>If the tape is marked as unknown, run Start-DPMLibraryInventory on this tape.| |
|31146|Operation failed because drive <_DriveName_> is offline.| |
|31147|Operation failed because drive <_DriveName_> is disabled.| |
|31148|This child datasource is already excluded from protection.| |
|31149|If you are using a shared library, the Refresh operation displays the latest status of the tape and the result of the last rescan performed on the library (or stand-alone tape drive) by any DPM server sharing the library. If you are using a dedicated library, DPM will refresh the state of the library and tapes automatically.<br/><br/>For more information about shared libraries, click Help.| |
|31150|All selected tapes were successfully moved to the I/E port slots of the library <_Library_>| |
|31151|This operation is not allowed on a suspect tape.|Take out the tape in <_Location_>, replace the barcode, and run detailed inventory on the tape.|
|31152|SharePoint search components cannot be recovered individually to their original location.| |
|31153|Before you start the recovery process, you must delete the SharePoint Service Provider (SSP) as well as its index files from the original location.<br/><br/>Click **Help** for more information about deleting SSP and its index files.<br/><br/>If you have already deleted the SSP and its index files from the original location, click **Yes**.| |
|31154|You cannot recover mirrored SQL Server databases to their original location.| |
|31155|This operation is not allowed on the selected data source.|The data source may not be protected on a disk.|
|31156|You cannot set protection options for Exchange Server SCR.| |
|31158|The selected data sources are protected by the primary DPM server <_InputParameterTag_>. This DPM server is protecting the replicas of selected data sources from the primary DPM server (secondary protection).<br/><br/>Do you want this DPM server to take over primary protection and protect these data sources directly?| |
|31159|The selected data sources were previously protected by the primary DPM server <_InputParameterTag_>. Performing this operation will resume their secondary protection and run a consistency check between the data on primary DPM server and secondary DPM server.<br/><br/>If some other data sources from the production servers of selected data sources are still directly protected on this DPM server, jobs for such data sources will fail until their protection is switched back to primary DPM server.<br/><br/>Do you want to switch back protection of selected data sources to <*InputParameterTag*>?| |
|31160|This DPM server is not protecting the replica of data source <_DatasourceName_> from the primary DPM server. You cannot switch disaster protection for this data source.| |
|31161|The selected datasources should have the same replica-protectiontype.| |
|31162|One or more of the selected data sources are already configured for protection on the primary DPM server. When you switch back protection, the replicas of these data sources will be protected from the primary DPM server.| |
|31163|The policy schedule cannot be set with the specified date.|To resolve this issue, specify the first day of the month as the start date, and then retry the operation.|
|31165|You need to choose at least two days for daily backup| |
|31200|DPM was unable to initiate recovery to the specified computer.|<br/>1. Check to see that the computer name provided is the fully qualified domain name.<br/>2. Check to see that the computer specified has a protection agent installed on it.<br/>3. If recovery is to a clustered server, ensure that all physical nodes belonging to this cluster have the protection agent installed.|
|31203|The selected recovery point is not valid for recovery to a DPM server.| |
|31204|This option is disabled as the DPM database cannot be recovered directly to the original location. For more information, see the DPM Operations Guide.| |
|31205|Latest point in time recovery is not supported from:<br/><br/>1) Secondary DPM server<br/><br/>2) Invalid replica<br/><br/>3) Inactive protection.| |
|31206|DPM cannot protect this member. On the secondary DPM server, you can only protect data sources for the primary DPM server or the data sources of the computers that the primary DPM server is protecting.| |
|31207|Cannot perform <_InputParameterTag_> on a replica that is pending manual replica creation.|Complete the manual creation of the replica and then retry this operation.|
|31208|Cannot perform <_InputParameterTag_> on a replica that is missing.|Verify that the disk containing the replica volume and the recovery point volume is shown in **Disk Management**. If you are unable to locate the volumes in the Disk Management console, open the **Protection** task area in DPM Administrator Console to stop protection of the data source using the **Delete replica** option, and then add the data source to a protection group again.|
|31209|Cannot perform <_InputParameterTag_> on a replica that is inconsistent.|Run synchronization with consistency check for this replica and then retry this operation.|
|31210|DPM cannot protect this member. On the secondary DPM server, partial protection of a replica is not allowed.| |
|31211|DPM cannot protect this member. On the secondary DPM server, you cannot protect data sources that are not protected by the primary DPM server.| |
|31212|You have selected a clustered resource group for switching protection. This operation will apply to all the nodes under this resource group: <_ServerName_>. Protection for other resource groups belonging to this cluster may fail. You need to perform this operation for all resource groups to resume protection.| |
|31213|You cannot recover data to its original location from a secondary DPM server without switching protection of the protected computer to the secondary DPM server.<br/><br/>To switch protection, right-click the data source, select **Switch disaster protection**, and then retry the operation.| |
|31214|Switch protection failed because there is no protection agent on the protected computer.| |
|31215|Invalid input. Switching protection back to primary DPM server is not allowed on a primary DPM server. Switching protection back to the primary DPM server is allowed only on a secondary DPM server.| |
|31216|Invalid input. You cannot switch protection for a primary DPM server. Switching protection is allowed to switch protection for protected computers only.| |
|31217|You can offset synchronization frequency only for incremental backups.| |
|31218|The offset is greater than synchronization frequency.| |
|31220|DPM failed to apply the required policies to this protection group since the recovery point limit for this DPM server has been exceeded.|If you see this error on the primary DPM server, <br/>1. Check to see if you can reduce the number of express fulls (or file recovery points) for the data sources that are currently being protected.<br/>2. Reduce the retention range for the existing protection groups.<br/>3. Reduce the number of data sources being protected by this DPM server.<br/><br/>If you see this error on the secondary DPM server, <br/>1. Check to see if you can reduce the synchronization frequency for applications (or file recovery points) that are currently being protected.<br/>2. Reduce the retention range for the existing protection groups.<br/>3. Reduce the number of data sources being protected by this DPM server.|
|31221|You cannot migrate a replica that is not in a valid state.| |
|31222|The specified disk(s) is invalid or does not have enough disk space.|Verify that you specified a valid set of disk objects with sufficient free disk space, and that the selected disks have been added to the DPM storage pool.|
|31223|The data source has been marked as Inconsistent during the migration.|Run a consistency check to resume protection.|
|31224| <_DatasourceName_> has recently been migrated. You cannot migrate <*DatasourceName*> again until the recovery points on the previous replica volume are available.| |
|31225|DPM does not support the migration for data source <_DatasourceName_> present in <_ServerName_>.|You cannot migrate a data source that does not have active disk-based protection, or a child data source without also migrating the parent. Verify that neither condition is true for the data source you are trying to migrate.|
|31226|The selected database has one or more FILESTREAM data groups. You cannot recover such database to the preconfigured file location.|Select a target SQL Instance that has custom file locations configured and retry the recovery.|
|31227|DPM cannot protect this data source because the secondary DPM server cannot protect a local data source that is protected on the primary DPM server.| |
|31228|The following databases were previously protected as part of another SharePoint data source: <_DatasourceName_>. If you select this data source for protection, DPM will delete the previous recovery points of these databases.|To preserve the previous recovery points of these databases, you must move the database back to the Share Point data source with which they were originally protected.<br/><br/>To protect the database as part of the new data source and to remove the older recovery points, continue with adding the data source to the protection group.|
|31229|Master database cannot be recovered as there is a version mismatch between the SQL instance where the database was backed up from and the SQL Server instance to which it is being recovered.|Recover the master database from a recovery point which was created on the same version of SQL Server instance as it is being recovered to.|
|31230|Recovery of <_DatasourceName_> from staging area (<_FolderPath_>) to <_ServerName_> (Start Time: <_StartDateTime_>) is in progress.|No action required.|
|31231|Recovery of <_DatasourceName_> from staging area (<_FolderPath_>) to <_ServerName_> (Start Time: <_StartDateTime_>) has successfully completed.|No action required.|
|31232|Recovery of <_DatasourceName_> from staging area (<_FolderPath_>) to <_ServerName_> (Start Time: <_StartDateTime_>) was partially successful. <_TransferredFilesCount_> files were recovered successfully.|Retry the job.|
|31233|Recovery of <_DatasourceName_> from staging area (<_FolderPath_>) to <_ServerName_> (Start Time <_StartDateTime_>) failed to recover the selected data.|Retry the job.|
|31234|Recovery of <_DatasourceName_> from staging area (<_FolderPath_>) to <_ServerName_> (Start Time: <_StartDateTime_>) is in progress.|No action required.|
|31235|Recovery of <_DatasourceName_> from staging area (<_FolderPath_>) to <_ServerName_> (Start Time: <_StartDateTime_>) has completed successfully.|No action required.|
|31236|Recovery of <_DatasourceName_> from staging area (<_FolderPath_>) to <_ServerName_> (Start Time: <_StartDateTime_>) was partially successful. <_TransferredFilesCount_> files were recovered successfully.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|31237|Recovery of <_DatasourceName_> from staging area (<_FolderPath_>) to <_ServerName_> (Start Time: <_StartDateTime_>) failed to recover the selected data.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|31238|Recovery from staging area failed since the metadata information was not present or it was corrupt.|Make sure the metadata information is available and is not corrupt. If this was recovered from any Internet source to the staging area, retry that recovery.|
|31239|The DPMComponentName GUID value is empty.|Try again with a valid value.|
|31240|DPM Setup failed to create the DPMDRTrustedMachines group.|Review the error details, take the appropriate action, and then run DPM Setup again.|
|31241|Unable to set permissions on the folder corresponding to `MTATempStore$` share.|Review the error details, take the appropriate action, and then retry the installation.|
|31242|Version <_LocalDPMVersion_> of the DPM, and version <_RemoteDPMVersion_> of the remote DPM are not compatible.|Upgrade the remote DPM so that its version is same as the local DPM's version, and then retry the operation.|
|31243|Version <_LocalDPMVersion_> of the DPM, and version <_RemoteDPMVersion_> of the remote DPM are not compatible.|Upgrade the local DPM so that its version is same as the remote DPM's version, and then retry the operation.|
|31244|Error occurred while migrating data source <_DatasourceName_>. Check the DPM administration console for recovery point creation errors corresponding to this data source and follow the appropriate recommended action. If the errors occurred due to insufficient space on the recovery point volume, expand the recovery point volume or free up some space on the recovery point volume by deleting older recovery points.| |
|31245|Failed to allocate storage on DPM Online.| |
|31246|Failed to deallocate storage on DPM Online.| |
|31247|Could not find critical product entries in the Windows Registry.|Repair the installation of Data Protection Manager on this machine.|
|31249|This option is disabled as selected datasources sizes are not small enough to be colocated.|Click Help to learn more|
|31250|DPM could not resolve the SQL alias <_SqlInstance_> on the SharePoint front-end web server.|<br/>1. Configure the SQL alias <*SqlInstance*> on the SharePoint front-end web server to point to the SQL Server or SQL Server instance of the principal database. Then retry the operation.<br/>2. Ensure that SQL Server Client Connectivity components are installed on the SharePoint front-end web server.<br/>3. You can run `ConfigureSharePoint.exe -ResolveAllSqlAliases` on the SharePoint front-end web server to identify the SQL Server aliases that cannot be resolved by DPM.|
|31251|This option is enabled only at the time of creating a new protection group or protecting datasource to disk for the first time.|To learn more, select **Help**.|
|31252|This option is disabled because the chosen data sources cannot be colocated.|To learn more, select **Help**.|
|31253|Consistency check would be performed for all those members which are in the inconsistent state in the selected protection group.<br/><br/>Consistency check is a time-consuming operation.<br/><br/>Do you want to perform the consistency check?| |
|31254|No DPM Online recovery point was created, because synchronization between DPM server and DPM Online has not occurred since the last recovery point was created, or because no changes were found during synchronization.|Placeholder|
|31255|DPM Online recovery point creation failed due to internal error. Retry after some time.|Retry the operation.|
|31256|Failed to Create DPM Online recovery point| |
|31257|To remove disk-based short-term recovery, you need to unselect online protection first.<br/><br/>This is because online protection can happen only if you have disk-based short-term protection.| |
|31258|DPM encountered an error while reading from the DPM Online recovery point. Either the recovery point no longer exists or, if you selected a share for recovery, the path to its contents is missing from the recovery point.|Recover the data from another recovery point.|
|31259|For the members that you have specified not to format the custom volumes (in Disk Allocation Dialog earlier), the selected settings will not apply. For these volumes, you need to perform a consistency check once you set the protection.| |
|31260|Failed to recover data from DPM Online since the recovery point is being deleted.|Try recovery from a different recovery point.|
|31261|Failed to delete DPM Online recovery point since the recovery point is being used by another job.|Try deletion after some time.|
|31262|Internal error occurred in connection with DPM Online| |
|31263|Failed to delete DPM Online recovery point| |
|31264|The operation was cancelled.|Retry the operation.|
|31265|DPM Online replica creation cannot be scheduled to run before DPM Server replica creation.|Schedule DPM Online replica creation to happen after DPM Server replica creation.|
|31266|CannotKeepAliveSALApi| |
|31267|One or more prerequisites for protecting Exchange 14 are missing.<br/><br/>Go to ([http://go.microsoft.com/fwlink/?LinkId=158965](https://go.microsoft.com/fwlink/?LinkId=158965)) for a detailed list of prerequisites for protecting Exchange 14 databases.| |
|31268|Physical node is the only supported topology for Exchange SCR Protection|Specify the physical node topology.|
|31269|DPM online replica cannot be initialized manually.|Only automatic initialization is allowed for DPM online replica. Specify whether the automatic initialization has to happen now or later.|
|31270|The parameter set that you have specified is incorrect. Specify only short-term disk and long-term Online policy objective.| |
|31271|The parameter set that you have specified is incorrect. Specify only short-term disk along with long-term Online or long-term tape policy objective.| |
|31273|Online retention range is provided for a maximum of 2 months.|Specify online retention range less than 2 months.|
|31274|DPMVersionMismatch| |
|31275|Switch Protection is not supported for protected computers that are part of DAG.| |
|31276|Failed to complete the operation due to an error in DPM Online service.|Refer to the detailed error code in the description above. Retry this operation after the issue has been fixed.|
|31280|Protection for item <_ProtectableObject_> is not allowed because long term protection to DPM Online is not set for protection group <_GroupName_>;| |
|31281|Protection for item <_ProtectableObject_> is not allowed because short term protection to disk is not set for protection group <_GroupName_>;| |
|31282|DPM Online protection is not allowed because DPM server <_ServerName_> is not activated to use DPM Online.|Activate DPM Online and try to create protection group.|
|31283|The protection group <_GroupName_>; contains only application data. DPM Online can only protect file data.| |
|31284|This item <_ProtectableObject_> cannot be protected to DPM Online. DPM Online can only protect file data.| |
|31300|Failed to create schedule with the specified start time because the date is invalid.|Specify a date that is less than or equal to 28.|
|31301|Recovery point cannot be created for <_DatasourceName_> since protection has been stopped for this data.| |
|31302|You cannot perform a data integrity check on a protection group that is configured for disk-to-tape backups. This option is only available for protection groups that are configured for disk-to-disk backups or disk-to-disk-to-tape backups.| |
|31303|You cannot perform a data integrity check on an incremental backup.|Restart the job and perform the data integrity check on a full backup.|
|31310|The SQL VSS Writer service is not running on <_ServerName_>.<br/><br/>Ensure that the SQL VSS writer service is started and running on the selected server and/or all nodes in the cluster.| |
|32000|DPM was unable to attach the database to the SQL Instance <_SqlInstance_>. <_ErrorDescription_>|<ul><li>Verify that the specified instance of SQL Server is online.</li><li>If your SQL database files do not have the .mdf, .ndf, and .ldf extensions for the primary data file, secondary data file, and log file, respectively, then DPM cannot attach the database to the specified SQL Server instance.</li></ul>|
  
## Error codes 32001-33000

|Error code|Message|Additional information|
|---|---|---|
|32001|DPM was unable to detect the presence of the Web application named `DPMRecoveryWebApplication` in the recovery farm.|1. Verify that the recovery farm is online and running.<br/>2. Verity that you have created a Web application in the recovery farm with the name `DPMRecoveryWebApplication`.<br/><br/>For more information, see the DPM Operations Guide.|
|32002|DPM was unable to attach the content database to the recovery farm. Exception Message = <_ExceptionMessage_>|<br/>1. Verify that the recovery farm is online and running.<br/>2. Verify that the `WSSCmdletWrapper` DCOM component is configured correctly on the front-end Web server hosting the recovery farm. For more information, see the DPM Operations Guide.|
|32003|DPM was unable to export the item <_SiteUrl_> from the recovery farm. Exception Message = <_ExceptionMessage_>|To resolve this issue:<ol><li>Verify that the recovery farm is online and running.</li><li>Verify that all features, web templates, and language packs present on the protected farm are also present on the specified recovery farm.</li><li>If the item you want to recover is not present in this version of the content database. Use a different recovery point for recovery.</li><li>To modify the environment variable `TEMP` to a location that has sufficient space, on the front-end web server, run: <br/>`ConfigureSharePoint.exe -SetTempPath`<br/><br/></li><li>If unattached item-level recovery is used, verify that the farm admins have adequate permissions to create an Unattached Content database on the specified SQL Server instance.</li><ol>|
|32004|DPM was unable to detach the content database <_ContentDatabase_> from the recovery farm. Exception Message = <_ExceptionMessage_>|To resolve this issue:<br/>1. Verify that the recovery farm is online and running.<br/>2. Open the SharePoint Central Administration Console of the recovery farm and delete the content database.|
|32005|DPM was unable to import the item <_SiteUrl_> <br/>to the protected farm. Exception Message = <_ExceptionMessage_>|To resolve this issue:<ol><li>Verify that the protected farm is online and running.</li><li>Verify that all features, web templates, and language packs present on the production farm are same as at the time of creation of recovery point.</li><li>To modify the environment variable TEMP to a location with sufficient space, on the front-end web server run: <br/>`ConfigureSharePoint.exe -SetTempPath`<br/><br/></li><li>Verify that the parent URL of the URL being recovered is a valid URL in the production farm.</li><ol>|
|32006|DPM found that `DPMRecoveryWebApplication` was not properly configured.|<br/>1. Verify that the protected farm is online and running.<br/>2. Open SharePoint Administration Console and delete the web application named `DPMRecoveryWebApplication` and then recreate it.<br/>3. Retry the operation.|
|32007|DPM failed to protect <_DatasourceName_> <br/>because DPM detected multiple front-end Web servers for the same SharePoint farm on which the SharePoint VSS writer is enabled.|Only one front-end Web server in this farm should have the SharePoint VSS writer enabled.<br/><br/>To resolve this issue:<br/>1. On the front-end Web servers on which you do not want to protect the data source, disable the SharePoint VSS writer.<br/>2. Close the **Create New Protection Group** wizard, and then retry the operation.|
|32008|DPM cannot protect this SharePoint farm as it cannot detect the configuration of the dependent SQL databases.|To resolve this issue:<br/>1. Verify that the SharePoint VSS writer is reporting content databases on the front-end web server.<br/>2. Verify that the SQL Server VSS writer is enabled and running in a healthy state on all the back-end SQL Server machines.<br/>3. Verify that some of the databases that are part of this SharePoint farm are already being protected by DPM.<ul><li>To protect the SharePoint farm, remove these databases from protection and delete their existing recovery points.</li></ul>|
|32009|DPM cannot protect the SharePoint Search Index because DPM did not detect all of the dependent databases and Search indices to be protected.|To resolve this issue:<br/>1. Verify that the appropriate SQL Server VSS writers are enabled.<br/>2. On the computers where the search indices are located, verify that the SharePoint SPSearch/Office Search VSS writers are enabled.|
|32010|DPM was unable to get the content sources of the SharePoint Service Provider (SSP) <_DatasourceName_> to a consistent state.|To resolve this issue, verify the following:<ol><li> The protected SharePoint Service Provider (SSP) is online and running.</li><li> On the front-end Web server hosting the protected farm, the `WSSCmdletWrapper` DCOM component is configured correctly.<br/>For more information, see [Back up SharePoint with DPM](/system-center/dpm/back-up-sharepoint).<br/><br/></li><li>Retry the operation and verify that no other application or process is trying to resume the SSP crawl during backup.</li></ol>|
|32011|DPM cannot continue with the recovery of the SharePoint Service Provider (SSP) because the SSP <_DatasourceName_> or the index files of the SSP have not been deleted.|Delete the SSP and verify that the index files are deleted, and then retry the recovery.|
|32012|DPM was not able to stop or disable the Windows SharePoint Services Search service on the Index server <_DatasourceName_>|Use the Services Management console to manually stop and disable the Windows SharePoint Services Search service. Don't delete the search configuration.|
|32013|DPM failed to recover to the original location because either the corresponding Windows SharePoint Services Search service on the index server <_DatasourceName_> doesn't exist or it has been configured differently from the time this recovery point was created.|Start the Windows SharePoint Services Search service with the original configuration, and then retry the recovery.|
|32014|DPM cannot continue protecting the selected database because it is not part of a mirroring session anymore.|To resolve this issue, do one of the following:<ul><li>If this is a temporary break-in mirroring, re-establish mirroring between the partner SQL Server databases.</li><li>If this is a permanent change, remove the database from protection and then re-create the protection group. If you have enabled SQL Server autoprotection on the instance of SQL Server where this database resides, you do not have to re-create protection for this database because the database will be treated as a new datasource and added to protection automatically.</li></ul>|
|32015|DPM is unable to continue protecting the selected database because DPM detected a mirroring session failover for this database.|Run a synchronization job with consistency check.|
|32016|DPM cannot continue protecting the requested database because this database is part of a new mirroring session.|<br/>1. If the database is protected as a SQL Server database, then remove the database from protection and recreate the protection group for this database. If autoprotection is configured for the SQL Server instance of this database in DPM, then recreation of protection for this database is not required as it will be treated as a new datasource and added to protection automatically.<br/>2. If the database is part of a SharePoint farm, this alert may get resolved automatically by DPM.<ol><li> Alternatively, go to the **Protection** pane and run **Modify Protection** for the protection group containing the SharePoint farm.</li> <li>In the Modify Protection Group wizard, on the **Select Group Members** page, expand the SharePoint front-end web server node and modify the protection group.</li><li>Run a consistency check on the SharePoint farm.</li></ol>|
|32017|DPM was unable to export the item <_SiteUrl_> <br/>from the content database <_ContentDatabase_>; Exception Message =<_ExceptionMessage_>|To resolve this issue:<br/>1. Verify that the production farm is online and running.<br/>2. On the front-end web server hosting the production farm, verify that the `WSSCmdletWrapper` DCOM component is configured correctly. For more information, see the DPM Operations Guide.<br/>3. On the protected farm are same as at the time of creation of recovery point, verify that all features, web templates, and language packs present.<br/>4. If the item you want to recover is not present in this version of the content database. Use a different recovery point for recovery.<br/>5. Verify that the farm admin has adequate permissions to create an unattached content database on the specified SQL Server instance.|
|32018|DPM was unable to query the unattached content database <_ContentDatabase_>; Exception Message =<_ExceptionMessage_>|To resolve this issue:<br/>1. Verify that the production farm is online and running.<br/>2. On the front-end web server hosting the production farm, verify that the `WSSCmdletWrapper` DCOM component is configured correctly. For more information, see the DPM Operations Guide.<br/>3. Verify that the farm admin has adequate permissions to create an unattached content database on the specified SQL Server instance.|
|32019|DPM Agent on the SharePoint front-end Web server <_ServerName_> is not configured appropriately. DPM was unable to invoke WssCmdletWrapper DCOM component successfully.|To resolve this issue:<ol><li>If your farm administrator password has expired, on the front-end web server run: <br/>`ConfigureSharePoint.exe -EnableSharePointProtection`<br/><br/>This resets the `WssCmdletWrapper` and update its logon credentials.<br/></li><li> If you are protecting SharePoint search, on the front-end web server run: <br/>`ConfigureSharePoint.exe -EnableSPSearchProtection`</li></ol>|
|32020|Failed to display the shadow copy as share <_ShareName_>|Try to perform unoptimized item-level recovery. This will take more time than normal. Detailed steps to perform this are provided in the documentation.|
|32021|Failed to hide shadow copy from share <_ShareName_>|Delete the share by running: <br/>`net share <ShareName> /delete`|
|32022|Failed to add permissions for user <_UserName_> to the share <_ShareName_>|Verify that the <*UserName*> group exists. If it doesn't, perform an unoptimized item level recovery. This will take more time than it normally takes. Detailed steps to perform this are provided in the documentation.|
|32023|Failed to add the <_UserName_> user to the <_GroupName_> group.|To resolve this issue:<br/>1. Verify that the <*GroupName*> group exists.<br/>2. Verify that the SQL Server service is not running as a local service or local machine account. <br/><br/>If the <*GroupName*> group doesn't exist and the service is not running, perform an unoptimized item-level recovery. This will take more time than normal. Detailed steps to perform this are provided in the documentation.|
|32024|Failed to remove the <_UserName_> user from the <_GroupName_> group.|Manually remove the user from the group. Otherwise, try to perform unoptimized item-level recovery. This will take more time than normal. Detailed steps to perform this are provided in the documentation.|
|32025|Failed to identify the SQL service account on the agent uniquely.|Make sure the SQL Server service isn't running as a local service or from local machine account. Otherwise, try to perform unoptimized item-level recovery. This will take more time than normal. Detailed steps to perform this are provided in the documentation.|
|32026|Failed to remove all the members from the <_GroupName_> group.|Make sure that the group exists. Remove all the members of the group from the server manager, and try again.|
|32027|Another site recovery for this data source is in progress.|Wait until the item-level recovery for this data source completes. Then retry the operation.|
|32028|DPM cannot continue protecting the selected database because it is not part of an Availability Group anymore.<br/>Database: <_DatasourceName_>|To resolve this issue, check the SQL Server Availability Group configuration.|
|32029|DPM was unable to determine the right node for backing up the Availability Group database and hence failed the backup.<br/>Database: <_DatasourceName_>|To resolve this issue, check the SQL Server Availability Group configuration.|
|32030|DPM failed the current backup because the previously standalone SQL database is now a part of a SQL Availability Group.<br/>Database: <_DatasourceName_>|Stop protection of the current standalone SQL Server database and reprotect it as an **Availability Group** database.|
|32057|You cannot shrink this recovery point volume currently. Possible reasons for this are:<br/>1. Windows is currently not allowing this volume to be shrunk due to the presence of a recovery point segment towards the end of the volume. As older recovery points expire, Windows should be able to shrink the volume. Retry this operation after a few recovery points have expired.<br/>2. The shrink (considering your intended number of recovery points) will result in negligible disk space gains.| |
|32058|Based on the expected data churn for the specified retention range, the recovery point volume can only be shrunk to a size between <_MinSizeAfterShrink_> and <_MaxSizeAfterShrink_>. Please choose a value between these thresholds and try again.| |
|32060|The cmdlet <_CmdletName1_> cannot have both <_Parameter1_> and <_Parameter2_> as parameters.| |
|32061|Dynamic disks use a private region of the disk to maintain a Logical Disk Manager (LDM) database. The LDM database will be at <_CurrentLdmOccupancy_> occupancy after this operation. When occupancy reaches <_LdmErrorThreshold_>, all volume creations and grows will be disabled and backups that require volume grows may fail|You can control the growth of the LDM database by migrating one or more data sources to a different volume.|
|32062|Dynamic disks use a private region of the disk to maintain a Logical Disk Manager (LDM) database. The LDM database is currently at <_CurrentLdmOccupancy_> occupancy. When occupancy reaches <_LdmErrorThreshold_>, all volume creations and grows will be disabled and backups that require volume grows may fail.|You can control the growth of the LDM database by migrating one or more data sources to a different volume.|
|32063|Status: <_AlertStatus_><br/>Description: Dynamic disks use a private region of the disk to maintain a Logical Disk Manager (LDM) database. The LDM database is currently at <_CurrentLdmOccupancy_> occupancy. When occupancy reaches <_LdmErrorThreshold_>, all volume creations and grows will be disabled and backups that require volume grows may fail.|You can control the growth of the LDM database by migrating one or more data sources to a different volume.|
|32064|Dynamic disks use a private region of the disk to maintain a Logical Disk Manager (LDM) database. This volume creation or grow was not allowed because the occupancy of the LDM database would have been <_CurrentLdmOccupancy_> after this operation which is above the DPM limit of <_LdmErrorThreshold_>|You can control the growth of the LDM database by migrating one or more data sources to a different volume.|
|32065|Dynamic disks use a private region of the disk to maintain a Logical Disk Manager (LDM) database. The current occupancy of the LDM database is <_CurrentLdmOccupancy_> which is over the DPM limit of <_LdmErrorThreshold_>. Hence, all volume creations and grows have been disabled.|You can control the growth of the LDM database by migrating one or more data sources to a different volume.|
|32066|Status: <_AlertStatus_><br/>Description: Dynamic disks use a private region of the disk to maintain a Logical Disk Manager (LDM) database. The current occupancy of the LDM database is <_CurrentLdmOccupancy_> which is over the DPM limit of <_LdmErrorThreshold_>. Hence, all volume creations and grows have been disabled.|You can control the growth of the LDM database by migrating one or more data sources to a different volume.|
|32067|There was an error during validation of the LDM database occupancy.|Retry operation after some time.|
|32068|There are a large number of dynamic disk volumes on your DPM. The number of volumes after this Create-PG/Modify-PG would have been <_CurrentVolumeCount_> while the DPM upper limit is only <_MaxVolumesThreshold_>. Hence this operation was disallowed.|Try colocating existing and new data sources.|
|32069|There was an error during validation of the volume count.|Retry operation after some time.|
|32070|Windows cannot shrink currently due to the presence of data towards the end of the volume. As older recovery points expire, Windows should be able to shrink the volume. Retry this operation after a few recovery points have expired.| |
|32071|Based on the expected data churn for the specified retention range, the recovery point volume cannot be shrunk further.| |
|32072|The shrinkable thresholds for the recovery point volume must be calculated prior to shrink. To find shrinkable thresholds, click **Shrink**.| |
|32073|The shrinkable thresholds for the recovery point volume must be calculated prior to shrink. To find shrinkable thresholds, use the Get-DatasourceDiskAllocation cmdlet with -CalculateShrinkThresholds parameter.| |
|32500|There is insufficient disk space in the cache volume.|To change the scratch location of the MABAgent service, follow these steps:<ol><li>Stop the Microsoft Azure Recovery Services Agent by running the following command at an elevated command prompt: <br/>`Net stop obengine`<br/><br/></li><li> Copy the scratch folder to a different drive that has sufficient space.<br/><br/> **Note**<br/>Required scratch space is at least 10 percent of the size of the data that is being backed up. (For example, backing up 100 gigabytes [GB] of data requires a minimum of 10 GB of free space in the scratch location.)</li><li>Update the following registry entries with the new path of the scratch folder:<br/><br/>`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Azure Backup\Config` - `ScratchLocation` <br/><br/>`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Azure Backup\Config\CloudBackupProvider` - `ScratchLocation` <br/><br/></li><li> Start the Microsoft Azure Recovery Services Agent by running the following command at an elevated command prompt: <br/>`Net start obengine`</li></ol>|
|32501|Invalid or incorrect scratch location [<_ScratchPath_>] specified.|Ensure that the specified scratch path is correct and that the SYSTEM account can access it.|
|32502|Azure Backup does not support `COMPRESSED`, `ENCRYPTED`, `OFFLINE`, `REPARSE_POINT`, `SPARSE_FILE` and `VIRTUAL` special attributes on the cache location.|Disable any of these special attributes or move the cache location to a volume without these attributes. For detailed steps, see [Frequently asked questions - Microsoft Azure Recovery Services (MARS) agent](/azure/backup/backup-azure-file-folder-backup-faq). |
|32503|Azure Backup is unable to initialize internal data structures.|Contact customer support for resolution.|
|32504|Unable to find changes in a file. This could be due to various reasons. Retry the operation.|Retry the operation.|
|32505|An unexpected error occurred during the operation.|Retry the operation.|
|32506|Unable to write to <_FileName_>.|Free up disk space and retry the operation.|
|32507|Unable to access to <_FileName_>.|Verify that the SYSTEM account can access the file.|
|32510|Status: <_AlertStatus_><br/><br/>Description: Database auto-protection failed.| |
|32511|One or more databases or VMware VMs could not be protected automatically because auto-protection failed. If the databases belong to a SharePoint farm, then the farm recovery points will continue to get created without these databases.|To resolve this issue:<ul><li>To fix auto-protection, resolve the errors and run `AutoProtectInstances.ps1` from DPM Management Shell.</li><li>If the databases belong to a SharePoint farm:<ol><li>On the **Protection** tab. for the protection group containing the SharePoint farm, select **Modify Protection**.</li><li> In the **Modify Protection Group** wizard, expand the SharePoint front-end web server node select the **Group Members** page and complete the wizard.</li><li>Run a consistency check on the SharePoint farm.</li></ol></li></ul>|
|32512|You cannot choose custom volumes for the SQL database <_DatabaseName_> as its instance <_InstanceName_>is auto-protected.|Use DPM's storage pool for this database or remove auto-protection for this instance.|
|32513|You cannot recover the database <_DatabaseName_> which has a FileStream file group to the SQL Server instance <_InstanceName_>where FileStream is not enabled.|Enable FileStream access on <*InstanceName*>and retry the operation.|
|32514|DPM Online protection is not supported for Exchange 14|Protect Exchange using Disk/Tape based protection|
|32515|If the Exchange mailbox databases are part of a DAG, you cannot protect it directly to tape.|For Exchange DAG mailbox databases, use short-term disk-based protection and long-term tape-based protection.|
|32516|Only selection of jobs with same type can be rerun| |
|32517|The backup job failed because no files or folders have been selected for protection.| |
|32519|The backup job was made to fail because another Task exists for the same data source.| |
|32520|The backup job failed because a recovery point on which it depends has been deleted by remove-RecoveryPoint cmdlet or by pruning.| |
|32521|The consistency check failed to trigger for client datasource as client initialization is pending. This will happen automatically when the client computer connects to the DPM server.| |
|32522|Copy to tape is not allowed for online recovery points.| |
|32523|You cannot upgrade protection agents for the primary DPM server from another computer. To upgrade the DPM server, install the new version on the DPM server.| |
|32524| <_DatasourceCount_> database(s) have been removed from the SharePoint farm <_SharePointFarmName_>. These databases are not part of the recovery point. Deleted databases are: <_DatasourceNameList_>.|Stop protection for this farm with retain data and reprotect it to update the farm configuration on DPM.|
|32525|One or more databases seem to have been added to the SharePoint farm <_SharePointFarmName_>. Recovery Point for the farm has been created without these databases.|This alert might get resolved automatically before the next recovery point generation.<br/><br/>Alternatively, to resolve this issue:<br/>1. On the Protection pane, or the protection group containing the SharePoint farm, select **Modify Protection**.<br/>2. In the **Modify Protection Group** wizard, expand the SharePoint front-end web server node on the **Select Group Members** page and complete the wizard.<br/>3. Run a consistency check on the SharePoint farm.<br/><br/>If any of the databases belonging to this SharePoint farm are already protected as an individual database by DPM, then:<br/>1. On the Protection pane, select the **Delete protected data** option to stop protecting these databases.<br/>2. In the **Modify Protection Group** wizard, expand the SharePoint front-end web server node on the **Select Group Members** page and complete the wizard.<br/>3. Run a consistency check on the SharePoint farm.|
|32526|DPM could not back up some of the required files for this data source. This could be caused by intermittent failures, or by a file type that is unsupported. If this backup is for a deduplicated volume, then some or all of the deduplicated files might not be recoverable from this recovery point.<br/>Number of files that failed to synchronize: <_FailureCount_> <br/>During the next synchronization, DPM will try to back up these files again.|For a list of files that could not be backed up, review the log. If any of the deduplicated metadata files could not be backed up, run consistency check to make sure that the next recovery point is suitable.|
|32527|Status: <_AlertStatus_> <br/>Data source type: <_DatasourceType_> <br/>Data source: <_DatasourceName_> <br/>Computer: <_ServerName_> <br/>Description: DPM could not back up some of the required files for this data source. This could be because of intermittent failures or if the file type is unsupported.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|32528|The selected datasource(s) cannot be configured for copy backup because it is either a standalone MailBox DB or a DR replica| |
|32529|Consistency check options are not configurable for client computers. If the replica is inconsistent next synchronization will automatically perform a consistency check.| |
|32530|DPM Server <_ServerName_> is already activated for DPM Online service.|To activate it with new parameters, you need deactivate and then activate the DPM Online service|
|32531|Deactivation of DPM Online service on DPM server <_ServerName_>, can be done only when there is no active and inactive online protection.|Remove any active and inactive online protection and then do the deactivation|
|32532|Activation of the DPM Online could not be completed because the DPM Online service is not reachable.|Verify the network settings and try activation again.|
|32533|Activation of the DPM Online could not be completed because account name or shared secret was incorrect.|Provide a valid account name and shared secret key.|
|32534|Activation of the DPM Online could not be completed|Retry activation by running the `Start-Online` cmdlet with a valid account name and shared secret key.|
|32535|Deactivation cannot be done as DPM server <_ServerName_> is not yet activated for DPM Online protection.| |
|32536|Could not open failed files log: <_FileName_>| |
|32537|Service required to upgrade protection agent failed to come up.|If the DPM protection agent is installed on this computer, use **Add or Remove Programs** in Control Panel to uninstall it, and then do a disconnected agent install.|
|32538|Number of files skipped for synchronization due to errors has exceeded the maximum allowed limit of <_MaxLimit_> files on this data source|Review the failure errors for individual files from the log file <_FileName_> and take appropriate action. If some files fail consistently, you can exclude the folders containing these files by modifying the protection group or moving the files to another location.|
|32540|DpmraServiceProxyError| |
|32541|This action will rerun jobs at SharePoint farm level. All the jobs for individual databases of the farm that failed during last operation will be rerun. Jobs that succeeded for the databases during last operation will not be run.<br/><br/>Do you want to continue?| |
|32542|The protection agent installation failed. There was an error in reading the files needed to install the protection agent (version <_AgentVersion_>) from this DPM server.|Check if the installation files exist and have required permissions and retry the operation.|
|32543|Some protection agents cannot be updated from the DPM console. Perform the following steps to update these agents:<br/>1. Copy the agent installer from the directory <_DirectoryPath_> under DPM installation directory to a network share<br/>2. Run the DPMAgentInstaller under administrator privileges on the protected computer<br/>3. Refresh the agent status in the DPM Management console.| |
|32544|This feature is supported only for short term disk based protection|For more information on colocation, see [DPM Help](/previous-versions/system-center/data-protection-manager-2010/ff399540(v=technet.10)).|
|32545|DOCVolumeNotPresent| |
|32546|The PrimaryDPMServer option is valid only for client protection.| |
|32547|There is no operation configured for this user on <_ServerName_>| |
|32548|DPM was unable to remove the protected computer <_ServerName_>|Make sure that the protected computer is attached to the DPM server. If the protected computer is in the Active Directory domain, make sure that you have provided the correct fully qualified domain name (FQDN) of the protected computer. If <*ServerName*> is a workgroup computer configured to use NETBIOS, specify the NETBIOS name. Otherwise specify the DNS name of the workgroup computer.|
|32549|The server name specified is invalid.|If <_ServerName_> is configured to use NETBIOS, specify the NETBIOS name. Otherwise specify the DNS name of the workgroup computer.|
|32550|The following file that is essential for backup is missing: <_FileName_>| |
|32551|Replica volume on disk has grown to become larger than the space allocated for it on DPM Online. Increasing the size of replica on DPM Online is not supported in current release.|Stop the online protection and reprotect the data.|
|32552|Job failure on replica of <_DatasourceName_> on <_ServerName_> caused by ongoing online recovery point creation job.|Cancel the ongoing operation, or wait for it to complete. Then retry the operation.|
|32553|Job failure on replica of <_DatasourceName_> on <_ServerName_> caused by ongoing online replica creation.|Wait for the online replica creation operation to complete. Then retry the job.|
|32554|Job failure on replica of <_DatasourceName_> on <_ServerName_> caused by ongoing online recovery point creation job|Cancel the operation, or wait for it to complete. Then retry the job.|
|32555|DPM was unable to remove the protected computer <_ServerName_>, which includes active or inactive protection on this DPM server.|Delete any active protection for this protected computer and then retry the operation.|
|32556|DPM was unable to remove the protected computer <_ServerName_> from one of the following groups:<br/>1. Distributed COM users<br/>2. DPMRADmTrustedMachines<br/>3. MSDPMTrustedMachines| Remove <*ServerName*> from the above groups.|
|32557|Task is cancelled because some other task in agent is not responding on <_AgentTargetServer_> machine.|Restart the task after some time.|
|32558|Task is cancelled because this task is not responding in agent on <_AgentTargetServer_> machine.|Restart the task after some time.|
|32559|Replica volume configuration for BMR datasource failed. The replica volume for the BMR datasource <_DatasourceName_> cannot be shared over the network.|Retry the operation.|
|32560|Cannot perform the operation because a conflicting job is in progress.|Wait for the ongoing job to complete or cancel the job from the **Monitoring** task area.|
|32561|DPM encountered a persistent VSS failure and hence restarted some VSS services to rectify the failure.|Check the Application Event Log on <_ServerName_> for the cause of the failure.<br/>For more information on this error, see [Hyper-V Protection Issues](/previous-versions/system-center/data-protection-manager-2010/ff634205(v=technet.10)).<br/>If the problem persists after some time, contact Microsoft Customer Service and Support.|
|32571|Authorization store could not be persisted into DPM Database. Operation Failed. See error logs for more details.|Retry the operation again.|
|32572|One or more library devices (drives and changers) were detected to be unreachable and hence were disabled from the system by DPM. This might be due to a hardware fault with the device. You can check the Device Manager to see which devices have been disabled.|Check if the device is properly connected. Use a diagnosability tool if provided by the device vendor to check if the device is working properly. Once the problem has been identified and fixed, enable the device in the Device Manager and then on the **Library Management** page of the DPM console, select **Rescan**.|
|32573|Description: One or more library devices (drives and changers) were detected to be unreachable and hence were disabled from the system by DPM.|For more information, open DPM Administrator console and review the alert details in the **Monitoring** task area.|
|32574|The drive is in an unexpected state. DPM will not use the drive until it is rectified or replaced.|Verify whether the drive is physically damaged or has a cleaner tape stuck inside. Use the vendor-supplied diagnosability tool to check for hardware problems. After the problem is fixed, run Fast Inventory on that library from the Library Management page of the DPM Console.|
|32575|The protection agent will be upgraded on the selected computers. Click Yes to continue.| |
|32576|CmdletUserNotAdmin| |
|32577|DPM could not log files that were skipped during backup to <_FileName_>|Close the file if it's opened in some other application and retry the operation.|
|32578|DPM failed to delete the saved state of the virtual machine <_VirtualMachineName_> after recovery to the host <_ServerName_>. The virtual machine may fail to start.|Delete the saved state of the virtual machine manually from the Hyper-V Manager on the host, and then try starting it.|
|32579|DPM was unable to access the cluster resource group <_VirtualName_> for <_DatasourceName_> of protection group <_ProtectedGroup_>. Recover the datasource using the alternate location workflow.|Verify that the cluster resource group <*VirtualName*> is accessible by using the Cluster Administration console.|
|32580|The SQL Server instance <_SqlInstance_> is already added as a recovery target with unrestricted target path to this DPM role. To add it as recovery target with path <_DestinationLocation_>, remove the recovery target with unrestricted path.| |
|32581|The SQL Server instance <_SqlInstance_> is already added as a recovery target to this DPM role with one or more specific target paths. Adding a recovery target with unrestricted target path will remove all the specified target paths for this instance. Do you want to continue?| |
|32582|The maximum number of data sources that a DPM server can protect is <_MaxDataSources_>. If you exceed this limit, DPM server will miss its backup SLA and eventually it may become unresponsive. You are currently protecting <_NumDataSources_> data sources on <_DPMServerName_>|1. Check if you can reduce the number of data sources currently being protected on <*DPMServerName*> to less than <*MaxDataSources*>.<br/>2. Consider adding a DPM server to protect the additional data sources.|
|32583|A DPM server can protect a maximum of <_MaxProtectedServers_> servers. If you exceed this limit, DPM server will miss its backup SLA and eventually it may become unresponsive. You are currently protecting <_NumProtectedServers_> servers on <_DPMServerName_>|1. Check if you can reduce the number of servers currently being protected on <*DPMServerName*> to less than <*MaxProtectedServers*>.<br/>2. Consider adding a DPM server to protect the additional servers.|
|32584|A DPM server can have a total replica size of <_MaxDPMReplicaVolSize_> TB. If you exceed this limit, the DPM server will miss its backup SLA and eventually it may become unresponsive. You currently have a total replica volume size of <_DPMReplicaVolSize_> TB on <_DPMServerName_>|1. Reduce the number of data sources you are protecting on <*DPMServerName*>.<br/>2. Consider adding a DPM server to protect the additional data sources.|
|32585|A DPM server can have a total recovery point volume size of <_MaxDPMShadowCopyVolSize_> TB. If you exceed this limit, the DPM server will miss its backup SLA and eventually it may become unresponsive. You currently have a total recovery point volume size of <_DPMShadowCopyVolSize_> TB on <_DPMServerName_>|1. Check whether you can reduce the retention period on <*DPMServerName*> such that the recovery point volume size is less than <*MaxDPMShadowCopyVolSize*> TB.<br/>2. Reduce the number of data sources that you are protecting on <*DPMServerName*>.<br/>3. Consider adding a DPM server to protect the additional data sources.|
|32588|A DPM server can back up up to <_MaxHyperVReplicaVolumeSize_> TB per day. If you exceed this limit, the DPM server may miss the backup SLA. If you go ahead with this protection, you will be backing up <_HyperVReplicaVolumeSize_> TB of Hyper-V data on <_DPMServerName_>|1. Consider reducing the number of Express Full backups scheduled per day for this protection group or any other existing protection groups protecting a Hyper-V workload.<br/>2. Reduce the number of Hyper-V virtual machines you are protecting on <*DPMServerName*>.|
|32589|A DPM server can have a maximum size of <_MaxSPReplicaVolumeSize_> TB for SharePoint replica volumes. If you exceed this limit, the DPM server may miss the backup SLA and eventually it may become unresponsive. You are currently using <_SPReplicaVolumeSize_> TB of SharePoint replica volume size on <_DPMServerName_>|If you expect the SharePoint farm to grow further, consider protecting the SharePoint SQL Server databases independently. However, you will not be able to perform granular restores for the SharePoint farm.|
|32590|Failed to copy data from replica for <_DatasourceName_> on <_ServerName_>. Current replica is marked invalid.| |
|32591|Protection for <_DatasourceName_> on <_ServerName_> has been switched to another DPM server.| |
|32592|Protection policy for <_DatasourceName_> on <_ServerName_> has changed to tape only.|No action is required.|
|32593|A DPM server can have a maximum of <_MaxExchangeEFs_> Express Full backups for each Exchange Server 2007 storage group or each Exchange Server 2010 database per week. If you exceed this limit, the DPM server may miss the backup SLA and eventually it may become unresponsive. You currently have <_NumExchangeEFs_> Express Full backups of <_DatasourceName_> on <_DPMServerName_>|Reduce the frequency of Express Full backups scheduled for <*DatasourceName*> on <*DPMServerName*> to less than <*MaxExchangeEFs*>.|
|32594|A DPM server can have a maximum of <_MaxPSMSSQLEFs_> Express Full backups of a SQL Server per week. If you exceed this limit, the DPM server may not meet the backup SLA and eventually it may become unresponsive. You currently have <_NumPSMSSQLPSEFs_> Express Full backups for <_ServerName_> on <_DPMServerName_>|1. Reduce the frequency of Express Full backups scheduled for <*ServerName*> on <*DPMServerName*> to less than <*MaxPSMSSQLEFs*>.<br/>2. If the protection group also contains other SQL Servers that have fewer than <*MaxPSMSSQLEFs*> Express Full backups, consider creating a new protection group to protect the databases on <*ServerName*> and schedule the frequency of Express Full backups for this protection group to be less than <*MaxPSMSSQLEFs*>.|
|32595|DPM backup and recovery jobs use a cache volume that cannot be detected. All subsequent online protection activities will fail until this volume is brought back online or is re-created.|Verify that the online cache volume and the disk containing the volume is shown in Disk Management.|
|32596|Description: DPM Online cache volume cannot be detected.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|32598|DPM Online activation failed when trying to retrieve information from the Windows Management Instrumentation (WMI) service on <_ServerName_>, access was denied.|Verify that you have access to the WMI service on <*ServerName*> and retry activation.|
|32599|The limit for the frequency of incremental backups of SQL Server databases on a SQL Server that has more than <_MaxSQLDbsForIncr_> databases should be less than one every <_MaxMSSQLIncrementals_> hours. If this limit is exceeded, DPM may not meet the backup SLA for all databases, and some of them may not be backed up to meet the SLAs. Currently, <_ServerName_> has <_NumSQLDbsForIncr_> SQL databases.|1. Reduce the frequency of incremental backups scheduled on <_DPMServerName_> to less than one every <*MaxMSSQLIncrementals*> hours.<br/>2. If the protection group also contains other SQL Servers that have fewer than <*MaxSQLDbsForIncr*> databases, consider creating a new protection group for databases on <*ServerName*>.<br/><br/>Schedule incremental backups every <*MaxMSSQLIncrementals*> or more hours for this protection group.|
|32600|DPM Access Manager service is not connected to any DPM server or the previous connection was lost.|To connect to the DPM Server, select the **Connect to DPM Server** button.|
|32601|This role name already exists.|Enter a different name.|
|32602|Unable to connect to the DPM Server <_ServerName_>|Verify that the DPM Access Manager service is running on this computer.|
|32603|This DPM role name does not exist. Enter a valid DPM role name.| |
|32604|The specified group name <_GroupName_> does not exist. Enter a valid Windows group name. Additional details: <_ExceptionMessage_>| |
|32605|Invalid entry for role name. The DPM role name you have provided contains special characters.|Remove any special characters in the role name or enter a new name.|
|32606|DPM Setup could not create the authorization store inside Windows Authorization Manager.|Retry the operation again.|
|32607|DeleteAzManStoreFailed| |
|32608|The specified SQL instance <_SqlInstance_> <br/>is either invalid or cannot be found.|If a SQL Server instance exists with the specified name, run the `Get-Datasource -ProductionServer <ProductionServer> -Inquire` cmdlet to refresh the information. Then retry the operation.|
|32609|DPM Self-Service Recovery Tool for SQL is out of sync with DPM AccessManager Service.|Reconnect to DPM AccessManager service.|
|32610|Since <_OccuredSince_>, DPM Online recovery point creation jobs for <_DatasourceName_> have failed. The total number of failed jobs = <_FailureCount_>. The last job failed for the following reason:| |
|32611|Status: <_AlertStatus_> <br/>Data source type: <_DatasourceType_> <br/>Data source: <_DatasourceName_> <br/>Computer: <_ServerName_> <br/>Description: DPM Online recovery point creation jobs failing.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|32612|Failed to prepare a Cluster Shared Volume (CSV) for backup as another backup using the same CSV is in progress.|If you are using software VSS providers, we recommend that you use hardware providers. For more information, see [Understanding Protection for CSV](/previous-versions/system-center/data-protection-manager-2010/ff634189(v=technet.10)).<br/><br/>If hardware VSS provider is already installed on the node, check the status of CSVs used by this virtual machine from the Cluster Administration Console and re-enable direct I/O for the CSV. Then retry the operation.|
|32613|Recovery failed because [OS volume]\ClusterStorage is not available for write access. This folder is protected by cluster service.|Choose a path to a cluster shared volume under _[OS volume]\ClusterStorage_ as the recovery target, for example, _C:\ClusterStorage\Volume3_.|
|32614|Invalid input for role name. DPM role name should be 27 characters or less in length.|Specify a role name that is 27 characters or less in length.|
|32615|The current user does not have write permission on the specified folder.|Specify a folder path where you have write access.|
|32616|Invalid input. You can use `-Editable` only when `-Name` is specified.|Specify the parameter `-Name` and then retry.|
|32617|The following recovery items could not be removed.| |
|32618|The following recovery targets could not be removed.| |
|32619|The following security groups could not be removed.| |
|32620|Backup of a VM is not supported when live migration is in progress.|Wait for the live migration to complete or cancel the live migration and then retry the backup.|
|32621|RDBSpecifiedForNonRDB| |
|32622|NonRDBSpecifiedForRDB| |
|32623|Recovery failed for <_DatasourceType_> <_DatasourceName_> on <_AgentTargetServer_> as the specified database is a recovery database.|Retry the operation and specify a database that is not a recovery database, or select the **Recover to Recovery Database** option.|
|32624|Recovery failed for <_DatasourceType_> <_DatasourceName_> on <_AgentTargetServer_> as the specified database is not a recovery database.|Retry the operation and specify a recovery database.|
|32625|PassiveCopySpecifiedForRecovery| |
|32626|Recovery failed for <_DatasourceType_> <_DatasourceName_> on <_AgentTargetServer_> as the specified database copy is a passive copy. Recovery to passive copy is not supported in this version of DPM.|To recover a passive copy, select **Copy to Network Folder** and follow this with manual reseed.|
|32627|ExchangeAnotherBackupInProgress| |
|32628|Backup failed as another copy of <_DatasourceName_> database is currently being backed up.|Wait for the backup to complete and then retry the operation.|
|32629|Failed to configure firewall rules.|DPM Self Service Recovery feature uses port 6075. Ensure the firewall rules are configured to accept incoming connections on this port. You can manually configure the firewall rules or run the following commands. <br/><br/>`netsh advfirewall firewall add rule name=DPMAM_WCF_SERVICE dir=in program="{DPM Install Path}\bin\DPMAMService.exe" profile=Any action=allow`<br/><br/>`netsh advfirewall firewall add rule name=DPMAM_WCF_6075 dir=in action=allow protocol=TCP localport=6075 profile=Any`<br/><br/>Ignore this warning if the firewall rules for port 6075 are already configured.|
|32630|A DPM server can have a maximum of <_MaxDPMMSSQLEFs_> Express Full backups of SQL Server per week. If you exceed this limit, the DPM server may miss the backup SLA and eventually it may become unresponsive. You currently have <_NumDPMMSSQLPSEFs_> Express Full backups of SQL Server on <_DPMServerName_>|<br/>1. Reduce the frequency of Express Full backups scheduled for SQL Server on <*DPMServerName*> to less than <*MaxDPMMSSQLEFs*>.<br/>2. Consider adding a DPM server to protect the additional SQL Server data sources.|
|32631|Failed to complete the operation due to a communication error.|<br/>1. Verify that the server is connected to the internet.<br/>2. Refer to the detailed error code in the description above. Retry this operation after the issue has been fixed.|
|32632|Failed to complete the operation due to an error while communicating with the service|Make sure you are connected to the internet. Verify that the proxy settings are configured correctly.|
|32633|DPM encountered an unknown error while communicating with DPM Online service|Retry the operation. If the problem persists, contact Microsoft Customer Service and Support.|
|32634|DPM was unable to notify DPMAMService about its start. AutoHeal might not work.|Restart DPMAMService.|
|32635|The server <_PSServerName_> does not have a DPM protection agent installed or is not protected by the DPM server <_ServerName_>| |
|32636|The recovery target location <_FolderPath_>, does not exist or cannot be accessed. Verify the recovery target location and retry.| |
|32637|The maximum number of disaster recovery (DR) data sources that a DPM server can protect is <_MaxDataSources_>. If you exceed this limit, DPM server will miss its backup SLA and eventually it may become unresponsive. You are currently protecting <_NumDataSources_> data sources on <_DPMServerName_>|Reduce the number of DR data sources currently being protected on <*DPMServerName*> to fewer than <*MaxDataSources*>.|
|32640|ExchangeCircularLoggingEnabled| |
|32641|Backup failed as circular logging is enabled on <_DatasourceName_> database. Incremental backups are not supported in case of circular logging.|Either disable circular logging and trigger an Express Full backup or disable incremental backups.|
|32642|ExchangeScrFilePathChanged| |
|32643|DPM has detected file path changes for <_DatasourceName_> storage group.|Run `remove-SCRSG.ps1` and `add-SCRSG.ps1` on SCR target for corresponding storage group, and then run consistency check.|
|32644|VssBackupMetadataInvalid| |
|32650|NoDeallocationAsDeactivated| |
|32651|DPM does not support switching protection for client computers to the secondary DPM directly| |
|32652|This computer cannot be synchronized because it is not connected to the DPM server.| |
|32653|Data integrity check feature is not supported for client computers.| |
|32654|Select a DPM role for this operation.| |
|32655|Are you sure that you want to permanently delete the selected DPM role?| |
|32656|You must add at least one item in the list view.| |
|32657|The name of the instance of SQL Server is invalid. It cannot be empty or have a default value.| |
|32658|Enter a valid SQL Server database name. To add the entire instance of SQL Server, clear the text in the list view.| |
|32659|Enter a valid file path. For unrestricted access, clear the file path entered in the list view.| |
|32660|The system cannot find the file specified.| |
|32661|DPMDRToDPMDCCommunicationError| |
|32662|DPM cannot continue secondary protection of this datasource because of insufficient disk space on its replica volume on the primary DPM server (<_TargetServerName_>).|<br/>1. Grow the replica volume on the primary DPM server.<br/>2. Retry the operation.|
|32663|Unable to start DPM Self Service Recovery Configuration Tool.| |
|32664|The DPM role configuration has been successfully saved.| |
|32665|The selected DPM role has been successfully deleted.| |
|32666|The name of the security group is invalid. It cannot be empty or have a default value.| |
|32667|SQL Server database with name, <_DatasourceName_> and SQL Server instance name, <_InstanceName_> could not be found.| |
|32670|The selected volume <_VolumeName_> cannot be protected as it does not have a drive letter or a mount point. DPM only protects volumes with a drive letter or a mount point.| |
|32671|Access denied on the primary DPM server <_ServerName_>|<br/>1. Make sure that <*ServerName*> is not protected by another DPM server.<br/>2. Reinstall the agent on <*ServerName*> by using the Install Agent wizard.|
|32680|The credentials specified for server <_ServerName_> are invalid.|Rerun the operation with the same credentials that were provided when running `SetDpmServer` for the target server.|
|32681|Failed to query server properties for server <_ServerName_>|Ensure that the target server is reachable and the DPM agent is installed on it.|
|32682|Failed to create user account for this username <_UserName_>| |
|32683|Failed to update password of local user account for server <_ServerName_>|<ul><li>If <*ServerName*> is configured to use NETBIOS, specify the NETBIOS name. Otherwise specify the DNS name of the workgroup computer. </li><li>Ensure that the user account exists on this server or specified protected computer name is correct. </li><li>Ensure that the specified server has been configured for non-domain protection. </li><li>The caller is an admin on the server.</li></ul>|
|32684|Unable to contact the protection agent on server <_ServerName_>|1. Ensure that the above server name is accessible from the DPM server.<br/>2. Ensure that the protection agent has been installed on the remote server. Also ensure that you have run `SetDpmServer.Exe` with the `-isNonDomainServer` option on the protected computer.|
|32685|This server does not match the DPM server setting on server <_ServerName_>|1. Ensure that you have specified the correct protected computer.<br/>2. In case you have specified the correct protected computer, run `SetDpmServer` on <*ServerName*> with the correct DPM server name, and then retry the operation.|
|32686|The selected server <_ServerName_> <br/>cannot be a recovery target as it has been configured for non-domain protection.|Select a server that has been configured for domain protection.|
|32687|One or more of the specified paths contain invalid characters.|Check all the paths provided for invalid characters and correct them.|
|32688|Failed to create a user account with the specified credentials.|Specify a password that meets the minimum security requirements for this server.|
|32689|The user account <_UserName_> is already in use.|DPM requires a unique and exclusive user account to communicate with the workgroup server.<br/><br/>Go to the protected computer and rerun `setdpmserver.exe` with the unique username. Then retry this operation with the new user credentials.|
|32690|The username you have specified does not match the user configured on server <_ServerName_>|Ensure that you entered the credentials for the same user as specified while running `SetDpmServer` on the above server.|
|32691| <_ServerName_> is not configured to be protected as a workgroup server.| |
|32692|SetDpmServerAccessDenied| |
|32693|SetDpmServerUserExists| |
|32694|SetDpmServerPasswordInvalid| |
|32695|SetDpmServerPasswordMismatch| |
|32696|SetDpmServerInvalidOption| |
|32697|SetDpmServerDnsSuffixInvalid| |
|32698|SetDpmServerNetbiosDnsMistmatch| |
|32699|SetDpmServerForceGuestEnabled| |
|32700|SetDpmServerWorkgroupInvalidOption| |
|32701|SetDpmServerInvalidUsername| |
|33000|Bare metal recovery cannot be directly protected to tape.|Change the protection type to short-term disk-based protection and long-term tape-based protection, if required|
  
## Error codes 33001-40000

|Error code|Message|Additional information|
|---|---|---|
|33001|System State cannot be removed when Bare Metal Recovery is protected.|To remove System State from the protection group first remove Bare Metal Recovery|
|33002|You cannot protect Exchange Server databases that are part of a DAG on the secondary DPM server.| |
|33004|Start time cannot be greater than or equal to end time. Correct the filter definition and retry.| |
|33101|The specified alternate database name is a system database. Change the specified database name so that it is not a system database.| |
|33102|A recovery job with the specified settings was started successfully.<br/><br/>You can monitor the job progress from the main console.| |
|33103|Stopping the recovery will cancel this job. Do you want to continue?| |
|33104|Are you sure you want to re-run the recovery job with same settings?| |
|33105|The recovery job is being performed again. You can monitor the progress on your main console.| |
|33106|Cannot connect to the DPM Server <_ServerName_>.<br/><br/>Make sure that the DPM Server is online and that the required firewall exceptions for port <_InputParameterTag_> have been configured on it. If the issue persists, contact your DPM administrator.| |
|33107|Connection refused by DPM Server <_ServerName_>. Your user account is not configured as an authorized end user on this server. For more information, contact your DPM administrator.| |
|33108|You do not have any databases available for recovery. None of the databases configured for your user account is protected by the DPM Server <_ServerName_>. For more information, contact your DPM administrator.| |
|33109|The recovery job could not be started.<br/><br/> <_ErrorDescription_> <_ReasonText_>| |
|33110|The recovery job could not be cancelled.<br/><br/> <_ErrorDescription_> <_ReasonText_>| |
|33111|Connection to the DPM server <_ServerName_> was lost.<br/><br/>Reconnect to continue.| |
|33112|The server <_ServerName_> could not be found in the Active Directory.| |
|33113|DPM Self Service Recovery Tool was unable to get a response from the DPM Server <_ServerName_>. This may be because the server is busy processing other requests. Retry this operation after some time. If the problem persists, contact your DPM administrator.| |
|33114|Cannot retrieve properties for the DPM server <_ServerName_>. DPM Self Service Recovery Tool will use the default properties.| |
|33115| <_ErrorDescription_>| |
|33116|DPM found no recovery points which you are authorized to restore on the specified DPM server. You can restore only those recovery points for which you were an administrator at the time the backup was taken. To restore other recovery points, contact your DPM administrator, or attempt to restore from another DPM.|Try to connect to a different DPM server.|
|33117|DPM encountered an error while attempting to share the data you have requested. Contact your DPM administrator to restore the data.|Contact your DPM administrator to restore the data.|
|33118|DPM could not share the data you have requested because it has expired. Reopen the UI and try again|Contact your DPM administrator to restore the data.|
|33119|DPM was unable to get the list of data sources on <_PSServerName_> that are protected by the primary DPM server <_ServerName_>.|Make sure that <*ServerName*> is protecting the data sources for which you want to set this DPM server as the secondary server. If the problem persists, restart the DPMWriter service on <*ServerName*>.|
|33120|Unable to configure security settings for DpmDRTrustedMachines group on the computer <_ComputerName_> for <_ServerName_>.|To resolve this issue:<br/>1. Verify that the user name and password that you used has administrator privileges on the target computer.<br/>2. Verify that the DpmDRTrustedMachines group is present on <*ComputerName*>.<br/>3. Verify that you have the same major version of DPM on <*ComputerName*> and <*ServerName*>.|
|33121|DPM Access Manager service is unable to process the request because of an internal failure. Additional details: <_ExceptionMessage_>|Retry the operation. If the failure persists, contact your support personnel for further assistance.|
|33122|DPM was unable to add the list of recovery items or targets to the DPM role.|Verify that the number of recovery items or targets does not exceed 300 for each DPM role.|
|33123|The replica of <_DatasourceType_> <_DatasourceName_> on <_ServerName_> is not consistent with the protected data source. DPM error ID = <_DpmErrorCode_>.| |
|33140|The operation failed because DPM failed to access the shadow copy on <_AgentTargetServer_>. This could be due to<br/>1) Cluster failover during backup or<br/>2) Inadequate disk space on the volume.|If cluster failover has happened during backup, retry the operation. Otherwise, increase the amount of free space on volume on the source server and then retry the operation.|
|33141|The <_DatasourceName_> data source on the <_ServerName_> server is being protected directly on the secondary DPM server. To switch protection of the selected data sources to the primary DPM server, stop protection of the <*DatasourceName*> data source (with or without retaining data), and then retry the operation.| |
|33142|DPM cannot protect this data source because its replica or recovery point volume is missing/offline.|To resolve this issue:<br/>1. Bring the missing disk volume online and then continue the protection process.<br/>2. Delete inactive protection for the data source and then add the data source to protection.<br/>3. Recreate the missing volume(s) by using the DpmSync tool: <br/>`DpmSync -ReallocateReplica` |
|33143|The volume for <_DatasourceName_> has grown from <_OldSize_> to <_NewSize_>.| |
|33144|DPM was unable to expand the volume for <_DatasourceName_>.| |
|33145|This operation is not allowed on the selected computer because it is a resource group, DPM server or because DPM protection agent is not installed on the server. If it is a resource group, retry the operation on the physical node.| |
|33150|DPM was not able to apply the permissions existing at the time of creation of recovery point while recovering SharePoint item <_SiteUrl_>. Exception Message = <_ExceptionMessage_>.|Apply the permissions manually.|
|33151|The following computers do not meet the minimum software requirements for upgrading the DPM protection agent: <_ListofServers_>|Verify that Windows Server 2003 Service Pack 2 is installed on the selected computers. If the operating system has been recently updated, Active Directory updates may still be pending. Wait until the Active Directory updates are complete, and then try to upgrade the protection agent again. The time needed for Active Directory updates depends on your Active Directory domain replication policy.<br/><br/>For more information about software requirements, see the DPM System Requirements.|
|33152|AdminChangedOnClient| |
|33153|The following client computers could not be added for protection by the auto-deployment script:| |
|33154|The following client computers were added for protection by the auto-deployment script:| |
|33155|The following auto-deployment protection groups could not be updated by the auto-deployment script:| |
|33156|The following auto-deployment protection groups were updated by the auto-deployment script:| |
|33157|The <_DPMServerName_> DPM server is excluded from auto-deployment of client computers.| |
|33158|The <_DPMServerName_> DPM server has reached capacity for auto-deployment.| |
|33159|The recovery point schedule specified in the protection group settings XML file is not valid.| |
|33160|The client computer was not found in the Active Directory Domain Services database.| |
|33161|All the DPM servers considered for auto-deployment have reached their capacity.| |
|33162|The auto-deployment process completed successfully.| |
|33163|Client computer enumeration in Active Directory failed with following errors:| |
|33164|Client computer enumeration in Active Directory was successful.| |
|33165|The <_ObjectId_> object ID specified is not a valid GUID. Refer to MSDN documentation for valid GUID string formats.| |
|33166|Invalid scope parameters. For more information, see DPM Console Scoping Parameters ([http://go.microsoft.com/fwlink/p/?LinkId=226330](https://go.microsoft.com/fwlink/p/?LinkId=226330)).| |
|33167|DPM did not raise this alert. You can only troubleshoot DPM alerts from this link. Click OK to return to Operations Manager.| |
|33168|This operation cannot be performed on the current protection group at this time. Run the Modify Protection Group wizard, and on the Select Group Members page, expand the protected computers whose data sources need to be refreshed. Then perform an Update Group operation.| |
|33170|Unable to open the browser. Reinstall the browser and retry the operation.| |
|33171|You don't have access permission to connect to the System Center Data Access service on <_Name_>. Check if it is a permission issue. Reopen the Operations Manager console and retry the operation. If the problem persists contact your Operations Manager administrator.| |
|33172|You don't have permission to access the registry key <_RegistryKey_> under the **Current User**. Check your permissions and retry the operation.| |
|33173|There was a problem while performing the task. Contact support.| |
|33175|Unable to open the Troubleshooting window for the selected item. The DPM Central Console client components installation is incomplete or corrupted. Reinstall the DPM Central Console client components. If the problem persists, contact your DPM administrator.| |
|33176|The selected object does not exist. Refresh the Operations Manager window and retry the operation.| |
|33177|Could not retrieve monitoring alerts.| |
|33179|The specified size is less than the currently allocated size.| |
|33185|An error occurred while starting the DPM Troubleshooting Console.|Start the DPM Troubleshooting Console manually.|
|33186|An unexpected error occurred while trying to start the requested operation.|Retry the operation.|
|33187|ObjectOutOfScope| |
|33188|SCOMAgentTaskReturnedFailure| |
|33189|An unexpected failure occurred while performing the operation. Retry the operation.|Retry the operation.|
|33193|You cannot migrate collocated data sources to custom volumes.|Retry the operation.|
|33210|Unable to connect to the DPM database on <_InstanceName_> SQL Server instance.|Verify that the instance of SQL Server meets the following requirements:<br/>1. A firewall is not blocking requests from the DPM computer. For steps to configure the firewall on the SQL Server, see [Configure the Windows Firewall to Allow SQL Server Access](/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access).<br/>2. The current user is part of the Administrator group on the computer running the SQL Server instance and has the sysadmin role on the SQL Server instance.<br/>3. The SQL Server Browser service is running on the SQL server.<br/>4. The TCP/IP protocol is enabled for the SQL Server instance.|
|33211|You must perform the steps given under the Recommended Action section of the alert.| |
|33212|CBPIdentityContextNotFound| |
|33213|The specified protection group set options are not valid|Check the parameters that you are passing to the cmdlet, and make sure that these parameters match the parameters that the cmdlet is expecting.|
|33214|The PGSet could not be created because another PGSet already exists with the same name.|Verify that a PGSet with the same name as the one you are creating does not already exist.|
|33215|The protection group could not be assigned to the protection group set because of a SQL error.|Verify that the protection group and protection group set exist, and that the protection group is not assigned to a different protection group set.|
|33216|The <_PGNameList_> protected groups could not be assigned to the protection group set.|Verify that the protection groups and protection group set exist, and that the protection groups are not assigned to a different protection group set.|
|33217|Cannot delete protection group set.|Verify that there are no protection groups assigned to the protection group set that you are trying to delete.|
|33218|The <_ServerName_> server could not be disabled or enabled. Check the database connection.| |
|33219|DPM could not identify whether the following computers are clustered: <_ListofServers_>|Agent installation on these computers can continue. To successfully protect clustered resources, you must install the DPM protection agent on all the members of the cluster. Review the error details. Ensure that the Windows Management Instrumentation service is running, and that it can be accessed remotely from the DPM server.|
|33220|The provided domain credentials do not have administrator access to the following items: <_ListofServers_>.|Remove the computers from the **Select Computers** page or provide credentials for an account that has administrator access to all of the selected computers.|
|33221|DPM could not connect to the Service Control Manager on these servers: <_ListofServers_>|Verify that the listed servers are online and accessible remotely from the DPM server.<br/>If a firewall is enabled, verify that it is not blocking requests from the DPM server.|
|33222|Backup job for datasource: <_DatasourceName_> on production server: <_PSServerName_> completed successfully.<br/>Recovery point created at: <_PreBackupTime_>.<br/>Backup Type: <_BackupType_> backup.| |
|33223|Backup job for datasource: <_DatasourceName_> on production server: <_PSServerName_> failed.<br/>Backup job failed at: <_BackupFailedTime_>.<br/>Backup Type: <_BackupType_> backup.| |
|33224|You cannot install the protection agent on the following as they have DPM server installed: <_ListofServers_>.| |
|33225|The following computers host the SQL Server database for this DPM computer: <_ListofServers_>.<br/>For computer with operating system Windows Server 2003, installing the agent may require you to reboot the computer. The DPM Engine and DPM Administrator Console will not work until the reboot completes. Do you want to install the protection agent on these computers?| |
|33226|This operation cannot be performed from the Troubleshooting window.|Retry the operation from the DPM Administrator Console.|
|33227|Resume action is not available for the alert <_Name_> on object <_InstanceName_>| |
|33228|RetryOperationAsTokenExpired| |
|33229|Provide the thumbprint along with the configure option. If credentials have already been configured, then use the regenerate option.|See the cmdlet help for more details.|
|33230|No certificate has been configured for machine <_ComputerName_>.|Configure the certificate first time using the thumbprint of the certificate.|
|33231|Unable to find certificate with the thumbprint <_InputParameterTag_> on the personal machine store of machine <_ComputerName_>.|Verify that the certificate with this thumbprint exists in the computer's personal store or provide a different thumbprint.|
|33232|An error occurred while trying to locate the certificate with the thumbprint <_InputParameterTag_> on the personal machine store of machine <_ComputerName_>. Exception Message = <_ExceptionMessage_>|See the logs for the error and take action.|
|33233|An error occurred while trying to validate the certificate with the thumbprint <_InputParameterTag_> on the personal machine store of machine <_ComputerName_>. Exception Message = <_ExceptionMessage_>|Verify that the certificate has Cryptography API Next Generation (CNG) keys. DPM does not support certificates with CNG keys. Otherwise, see the logs for the error and take action.|
|33234|The certificate provided with thumbprint <_InputParameterTag_> on the personal machine store of machine <_ComputerName_> does not correspond to the requirements of DPM.<br/>The following requirements are not met for the certificate.<br/> <_Message_>|Verify that the certificate fulfills the following requirements:<br/>1. The certificate is trusted on the local machine and has not expired.<br/>2. The revocation servers of the associated Certificate Authorities are online.<br/>3. The certificate has an associated private key with a valid exchange algorithm.<br/>4. The certificate's public key length is greater than or equal to 1024 bits.<br/>5. The certificate should have both Server and Client Authentication if Enhanced Key Usage is enabled.<br/>6. The subject of the certificate and its root CA should not be empty.<br/>7. DPM doesn't support certificates with Cryptography API Next Generation (CNG) keys.|
|33235|DPM could not add the firewall exception for opening the <_InputParameterTag_> TCP port.|Manually add the firewall exception for the <*InputParameterTag*> TCP port.|
|33236|DPM could not enable and start the <_ServiceName_> service.|Manually enable and start the <*ServiceName*> service from the server manager.|
|33237|DPM could not configure DPM credentials. Exception Message = <_ExceptionMessage_>.|See the error logs for more details.|
|33238|You do not have permissions to perform this action. Your DPM administrator must give you permissions to any one of the following tasks - <_Operation_>| |
|33239|The cmdlet <_CmdletName1_> is not supported in a scoped environment.| |
|33240|Central Console is already installed on this computer.|Uninstall all of the following installed components:<ul><li>DPM Central Console Server</li><li>Microsoft System Center 2012 DPM Remote Administration</li><li>Microsoft System Center 2012 SP1 DPM Remote Administration</li><li>Microsoft System Center 2012 R2 DPM Remote Administration</li><li>DPM Remote Administration</li></ul>|
|33241|Microsoft .NET Framework 4 not installed on this computer.|Install Microsoft .NET Framework 4 and retry the operation.|
|33242|The <_Parameter1_> parameter is missing.|Provide a valid value for the <*Parameter1*> parameter, and then retry the operation.|
|33243|Unable to find the authorized CA with the thumbprint <_InputParameterTag_> in the trust chain of the certificate.|Check if the authorized CA with this thumbprint exists in the trust chain of the certificate or provide a different thumbprint.|
|33244|An error occurred while trying to locate the trusted root of the certificate with the thumbprint <_InputParameterTag_>. Exception Message = <_ExceptionMessage_>.|See the logs for the error and take action.|
|33245|The action you are trying to perform needs higher privilege. Consult the DPM Administrator.| |
|33246|DPM detected that the following servers are clustered, but could not identify their fully qualified domain name: <_ListofServers_>.|Agent installation on above servers can continue. To successfully protect clustered resources, you must install the DPM protection agent on all the members of the cluster. Verify that the cluster state is correctly configured and verify that all members are joined to the domain.|
|33247|A protection agent is already installed on the following servers: <_ListofServers_>.| |
|33248|DPM has failed to write events to the DPM Backup Events event log. Either the DPM Backup Events event log has been deleted or the permissions have been changed.|Uninstall DPM and then reinstall DPM to recreate the DPM Backup Events event log.|
|33249|The current operation has timed out in DPMAMService running on DPM server.|Retry the operation and if the issue persists contact your DPM administrator.|
|33300|The DPM CPWrapper Service is not configured correctly for the <_ComputerName_> computer. Exception Message = <_ExceptionMessage_>.|See the error logs for more details.|
|33301|The DPM CPWrapper Service is using a certificate for the <_ComputerName_> computer that is not valid. Exception Message = <_ExceptionMessage_>.|See the error logs for more details.|
|33302|The DPM CPWrapper Service authentication failed on the <_ComputerName_> computer. Exception Message = <_ExceptionMessage_>.|See the error logs for more details.|
|33303|The DPM CPWrapper Service authorization failed on the <_ComputerName_> computer. Exception Message = <_ExceptionMessage_>.|See the error logs for more details.|
|33304|DPM CPWrapper Service on the <_ComputerName_> computer has encountered a failure and may be in an unusable state. Exception Message = <_ExceptionMessage_>.|To resolve this issue:<ul><li> Check that the relevant firewall exceptions are configured correctly.</li><li> Check if the certificate used by the DPM CPWrapper service on the <*ComputerName*> computer is trusted by the peer server.</li><li> Try to restart the DPM CPWrapper service on <*ComputerName*>.</li></ul>|
|33305|Could not find the installation location of DPM Central Console client components. Reinstall DPM Central Console client components. If the problem persists, contact your DPM administrator| |
|33306|Could not connect to the Operations Manager Health service on <_Name_>. Ensure that the computer hosting the Health Service is available and that the Operations Manager Health Service is running.| |
|33307|The change journal size can only be modified by a DPM administrator working on the Administrator console. Contact your DPM administrator for help.| |
|33308|This action will set the ownership for <_PSServerName_> to DPM server <_ServerName_>. This will result in the backup or recovery jobs currently running for <*PSServerName*> to fail.<br/><br/>Do you want to set ownership?| |
|33309|You do not have access rights to perform this action. Contact your DPM administrator.| |
|33310|DPM could not enumerate one or more shares on protected computer <_ServerName_>.|Verify that there are shares on the server.|
|33320|This operation requires the DPM Remote Administration <_Version_> to be installed on this computer. Retry the operation after installing DPM Remote Administration <*Version*>.| |
|33321|The computer <_DPMServerName_> is either not a DPM server or it does not support centralized management and troubleshooting.| |
|33322|The computer calling this API is not a trusted computer.| |
|33323|The Certificate used by DPM on <_ComputerName_> is due to expire on <_ExpiryDate_>|Renew the Certificate used by DPM on <*ComputerName*> before  <*ExpiryDate*> and import it to the Personal Certificate Store under Local Computer. The **Issued By Root** and **Issued to** fields of the new certificate should be same as that of the current certificate. Current Certificate Details Thumbprint - <_InputParameterTag_>. |
|33324|The Certificate used by DPM on <_ComputerName_> has expired/will expire on  <_ExpiryDate_>| Renew the Certificate used by DPM on <*ComputerName*> before <*ExpiryDate*> and import it to the Personal Certificate Store under Local Computer. The **Issued By Root** and **Issued to** fields of the new certificate should be same as that of the current certificate. Current Certificate Details Thumbprint - <_InputParameterTag_>. |
|33325|The Certificate used by DPM on <_ComputerName_> is due to expire on  <_ExpiryDate_>| Renew the Certificate used by DPM on <*ComputerName*> before <*ExpiryDate*> and import it to the Personal Certificate Store under Local Computer. The **Issued By Root** and **Issued to** fields of the new certificate should be same as that of the current certificate. Current Certificate Details Thumbprint - <_InputParameterTag_>. |
|33326|The Certificate used by DPM on <_ComputerName_> has expired/will expire on  <_ExpiryDate_>| Renew the Certificate used by DPM on <*ComputerName*> before <*ExpiryDate*> and import it to the Personal Certificate Store under Local Computer. The **Issued By Root** and **Issued to** fields of the new certificate should be same as that of the current certificate. Current Certificate Details Thumbprint - <_InputParameterTag_>.|
|33327|Cannot <_Operation_>, <_FailureCount_> out of <_Total_> selected jobs with errors: <_ErrorIds_>| |
|33328|Failed to perform user action with exception: <_ExceptionMessage_>| |
|33329|Unable to cancel jobs. Check if you have permission to perform the operation.| |
|33330|The job to recover <_DatasourceType_> <_DatasourceName_> to <_TargetServerName_>, that started at <_StartDateTime_>, failed using optimized ILR. Another job using unoptimized ILR has been triggered.|To view the details of the recovery jobs, on the **Monitoring** tab, go to **Jobs** and group the jobs by type.|
|33331|DPM could not obtain backup metadata information for <_DatasourceType_> <_DatasourceName_> on <_ServerName_>. If the data source is a Generic datasource, a valid recovery point has been created.|If the Datasource <*DatasourceName*> has a VSS writer, ensure that the writer is running properly.|
|33332|The cancel request could not be submitted to the DPM Server. Retry after sometime.| |
|33333|Unable to connect to <_ServerName_>.|To resolve this issue:<br/>1. Verify that the DPM service is running on this computer.<br/>2. Verify that the current user has been added to at least one of the roles in Operations Manager.<br/>3. Open the Operations Manager console and then try opening the DPM Console.|
|33334|Unable to resume backups on some of the alerts. Retry later.| |
|33335|Unable to resume backups on all the alerts. Retry later.| |
|33336|Resumed backups successfully.| |
|33337|Unable to connect to the System Center Data Access service. Verify that the System Center Data Access service is running on this computer and you have sufficient privileges.| |
|33338|DPM cannot enable e-mail subscription for reports unless SMTP details are configured on the remote SQL Server Reporting Service installation. SMTP details need to be configured manually if you choose an existing SQL Server during DPM setup.<br/><br/>Contact the Administrator on SQL Server to enter the SMTP server name, port number, and address manually in the SQL Server Reporting Service's configuration file.<br/><br/>The SMTP Server details on the **SMTP Servers** tab in the **Options** dialog box enables only DPM alert notifications. For more information, see DPM Help.| |
|33339|An older version of DPM is installed on this computer. Upgrade to System Center 2012 DPM Release Candidate and launch setup again.| |
|33340|If you have re-imported the management pack recently, the role configuration may be corrupted. Open the DPM-specific roles and check if the roles have tasks assigned to them. If not, delete the roles and recreate them. For more information on how to recreate the roles, see [http://go.microsoft.com/fwlink/p/?LinkId=234368](https://go.microsoft.com/fwlink/p/?LinkId=234368).| |
|33341|To manually mark a tape as Free, execute the ForceFree-Tape.ps1 script from DPM Management Shell.| |
|33342|The job was cancelled because the user modified the associated protection group.|Retry the operation.|
|33343|DPM has detected that protection agents are not installed on the following server(s): <_ListofServers_>|To install agents on these servers:<br/>1. In the **Management** task area, select the **Agents** tab.<br/>2. In the **Action** pane, select **Install**. <br/><br/>If any of the above servers correspond to a cluster or a mirror, install the DPM protection agent on all the physical nodes of that cluster/mirror.|
|33344|DPM skipped cloud backup for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> because the latest disk backup is already backed up to cloud.| |
|33345|Cannot connect to Data Protection Manager. This version of DPM is not supported with Central Console Client.|Connect to supported Data Protection Manager only.|
|33399|DPM was unable to configure and start the VmmHelperService on the DPM Server.<br/>Server name: <_ServerName_>.<br/>Exception Message: <_ExceptionMessage_>|To resolve this issue:<ol><li> Verify that VMM Console features are installed on the DPM Server.</li><li>Reconfigure the VMM server in DPM, by using the following cmdlet: <br/>`Set-DPMGlobalProperty -DpmServerName <DPMServerName> -KnownVMMServers <VMMServerName>`</li></ol>|
|33400|DPM was unable to establish a connection with the Virtual Machine Manager (VMM) server.<br/>Server name: <_ServerName_>.<br/>Exception Message: <_ExceptionMessage_>|To resolve this issue:<ol><li>Verify that VMM Console features are installed on the DPM Server.</li><li> Reconfigure the VMM server in DPM, by using the following cmdlet: <br/>`Set-DPMGlobalProperty -DpmServerName <DPMServerName> -KnownVMMServers <VMMServerName>`<br/><br/></li><li> Verify that the VMM server is configured to accept requests from this DPM server.</li></ol>|
|33401|DPM encountered an error while trying to query the properties of the virtual machine on the Virtual Machine Manager (VMM) server.<br/>Virtual machine name: <_DatasourceName_>.<br/>Server name <_ServerName_>.<br/>Exception Message: <_ExceptionMessage_>|To resolve this issue:<ol><li>Verify that VMM Console features are installed on the DPM Server.</li><li> Reconfigure the VMM server in DPM, by using the following cmdlet: <br/>`Set-DPMGlobalProperty -DpmServerName <DPMServerName> -KnownVMMServers <VMMServerName>`<br/><br/></li><li> Verify that the VMM server is configured to accept requests from this DPM server.</li></ol>|
|33402|DPM did not find a Virtual machine that is managed by Virtual Machine Manager (VMM) server.<br/>Virtual machine name: <_DatasourceName_>.<br/>Server name: <_ServerName_>.|To resolve this issue:<br/>1. Verify that the virtual machine is still managed by the specified VMM Server.<br/>2. If the virtual machine is not managed by the specified VMM server, add the virtual machine to the VMM server as a managed entity.|
|33403|The backup job was not completed successfully because DPM detected that the virtual machine has migrated from the configured server to a new server. DPM will update its virtual machine configuration and then automatically trigger a new backup job.<br/>Virtual machine name: <_DatasourceName_>.<br/>Configured server: <_ServerName_>.<br/>New server: <_PSServerName_>.|No action is required because DPM will update its virtual machine configuration and then automatically trigger a new backup job.|
|33404|DPM could not persist the protection group and change the server of data source.<br/>Data source: <_DatasourceName_> <br/>Server name: <_ServerName_>.|Retry the operation.|
|33405|Online recovery points cannot be deleted.| |
|33406| <_ServiceName_> raised the following alert for the subscription in use:| |
|33407|Restore to staging area failed as the staging area data for the recovery point is no longer valid.|Run a new recovery for the recovery point through the wizard.|
|33408|No data source has been selected for online protection.|Either select some data sources for online protection or remove the online protection option from data protection type.|
|33409|Recovery of <_DatasourceName_> on <_ServerName_> failed since the staging area path <_StagingAreaPath_> was not found.| |
|33410|Recovery of <_DatasourceName_> on <_ServerName_> failed since the staging area path <_StagingAreaPath_> could not be locked.| |
|33411|DPM server could not connect to backup service.|Check the internet connectivity and your backup subscription status using the backup service portal.|
|33412|Status: <_AlertStatus_><br/>Description: DPM server could not connect to backup service.|Check the internet connectivity and your backup subscription status using the backup service portal.|
|33413|Backup policies configured on backup service are out of sync with this DPM server.|Click the recommended action link that appears below the alert window for DPM to attempt to refresh the policies.|
|33414|Status: <_AlertStatus_><br/>Description: Backup policies configured on backup service are out of sync with this DPM server.|Click the recommended action link that appears below the alert window for DPM to attempt to refresh the policies.|
|33415|DPM could not create online recovery point for some of the required files for this data source. This could be because of intermittent failures or if the file type is unsupported.<br/>Number of files that failed during online recovery point creation: <_FailureCount_><br/>Next online recovery point creation job will try to back up these files again.|For a list of files that for which online recovery point creation did not succeed, review the log.|
|33416|Status: <_AlertStatus_><br/>Data source type: <_DatasourceType_><br/>Data source: <_DatasourceName_><br/>Computer: <_ServerName_><br/>Description: DPM could not do backup of the required files to cloud for this data source. This could be because of intermittent failures or if the file type is unsupported.|For more information, open DPM Administrator Console and review the alert details in the **Monitoring** task area.|
|33417|The recovery staging folder has not been configured.|To configure the recovery staging folder, go to the **Online Management** view and run the Register Online Protection wizard. Then retry the operation.|
|33418|Azure backup agent version is not compatible with DPM.|Make sure you have installed a compatible backup agent version on DPM server.|
|33419|DPM server could not connect to the backup service to get the registration status.|Refresh the backup subscription status from the **Cloud** tab in **Management** view and then retry the operation.|
|33420|One or more data sources are currently configured for online protection.|Remove online protection for these data sources and then try unregistration.|
|33421|DPM server is not configured for online protection.|To subscribe to <_ServiceName_> and install the <_AgentFriendlyName_>, select **Manage subscription** on the **Online** tab in **Management** view. Register this DPM server for online protection and then retry the operation.|
|33422| <_ServiceName_> only supports up to <_Parameter1_> recovery points for each data source. The Azure backup schedule you have specified exceeds this limit.|Decrease the retention range or the Azure backup frequency and retry the action.|
|33423|Cannot cancel the task with taskId <_Parameter1_>.|Try to cancel the job which contains this task.|
|33424|The DPM job failed for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> because the protection agent did not have sysadmin privileges on the SQL Server instance.|Add NT Service\DPMRA to the sysadmin role on the SQL Server instance.|
|33425|The job failed because the protected computer <_ServerName_> could not access the network path <_ShareName_>|Ensure that the protected computer has full access to the network path and then retry the job.|
|33426|DPM Setup is unable to detect if the SQL server specified is clustered.<br/>Check if the SQL server instance name provided in correct and the SQL server is up and running.| |
|33427|DPM Setup detected that the SQL server provided to it is clustered.<br/>For clustered SQL server, the SQL Reporting server needs to be different from the SQL server.| |
|33428|DPM Setup detected that the SQL server provided to it is not clustered.<br/>For non-clustered SQL server, the SQL Reporting server needs to be the same as the SQL server.| |
|33429|DPM Setup detected that the SQL Agent on node <_PhysicalNode_> runs under a different account name than other nodes in the cluster.| |
|33430|DPM Setup detected that SQLPrep on node <_PhysicalNode_> is installed on a different path than other nodes in the cluster.| |
|33431|DPM Setup is unable to connect to the specified instance of SQL Server Reporting Service.|Verify that the specified computer and the instance of SQL Server Reporting Service meets the following requirements:<ul><li> The computer is accessible over the network.</li><li> A firewall is not blocking requests from the DPM computer. To configure the firewall on the SQL Server, follow the steps described int [Configure the Windows Firewall to Allow SQL Server Access](/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access).</li><li>The specified user belongs to the Administrator group on the computer running the SQL Server instance and the sysadmin role on the SQL Server instance.</li><li>The SQL Browser service is running on the SQL server.</li><li>The TCP/IP protocol is enabled for the specified instance of the SQL server.</li></ul>|
|33432|DPM Setup cannot query the WMI service on the SQL server.|Verify that the Windows Management Instrumentation (WMI) service is running.|
|33433|The specified user name <_UserName_> is invalid.|Specify a valid user name in the format domain\username.|
|33434|The version of the SQL Server instance provided is lower than the minimum version supported by this product.| |
|33435|VCRedist installation failed on <_ServerName_>.|To resolve this issue:<br/>1. Verify that VCRedist 2010 is installed on <*ServerName*>. If it's not installed, install if from the DPM install directory.<br/>2. Retry the job.|
|33436|The instance provided is not a Reporting Server instance. Provide a Reporting Server instance.| |
|33437|The version of the Reporting Server instance provided is lower than the minimum version supported by this product.| |
|33438|The backup or consistency check window has not been properly specified. For example, the window on two different days may be overlapping with each other or there may be ambiguity.|To resolve this issue, specify the backup or consistency check window in an unambiguous manner.|
|33439|The backup or consistency check window can be set for short term protection only.|To resolve this issue, specify the backup or consistency check window for a protection group that has short term protection.|
|33440|This backup task for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> has been cancelled since it lies outside the backup window|Increase the backup window of this protection group if you want backup tasks to run for a longer time.|
|33441|This consistency check task for <_DatasourceType_> <_DatasourceName_> on <_ServerName_> has been cancelled since it lies outside the consistency check window|Increase the consistency check window of this protection group if you want tasks to run for a longer time.|
|33442|The datasource(s) in protection group <_PGName_> missed its SLA.The SLA specified for the protection group is <_SLA_>|Investigate if there were any backup failures for these data sources or if your backup frequency or SLA alert frequency needs to be changed. To view the list of data sources that have missed their backup SLA, click the **View Detailed Errors** link that appears above the alert window.|
|33443|CBPNotInstalled| |
|33444|The value supplied for SLAInHours is not valid|The following values are valid:<ul><li> 24 hours.</li><li> If less than 24 hours, the value must be an integer divisor for  24, for example 1, 2, 3, 4, or 6.</li><li>When greater than 24 hours, it's a multiple of 24, for example, 48 or 72. Up to a maximum of 2160 hours (90 days.)</li></ul>|
|33445|Could not find the protection group for the given protection group ID.|Pass the correct protection group ID of an existing protection group or make sure you are connected to the correct DPM server.|
|33446|This DPM server cannot find the primary DPM server(s) for the following production server(s). As a result they will not be available for protection.<br/> <_Message_>| |
|33447|ATL Failure in Initializing Security of msdpm.| |
|33448|Cannot find the local DPM Server's entry in the database. This can happen on server rename or domain join/leave events. Try restarting the DPM service and then the console to automatically correct this issue.<br/><br/>The management tab will now be disabled.| |
|33449|Couldn't access DataSourceInfo in the database for a "<_JobType_>". This may happen due to orphaned jobs containing bad DataSourceID(s).|Try modifying the corresponding protection group.|
|33450|Vault credentials are the new way to register the DPM server for Azure Backup. Registration through certificate is not supported.|Download the vault credential file from Azure Backup portal Quick Start page for registration.|
|33451|Only files on Network share are supported from Remote UI.|Provide a valid Network share path in the following format: <br/><br/>**\\\\\<Computer-Name>\\\<Vault-credential-folder>\\\<Vault-credential-file>**|
|33452|Recataloging is mandatory for recovery. It is either not initiated or it is in progress.| |
|33453|Recataloging cannot be done on the selected object.| |
|33454|Recataloging is already done. You can recover the items now.| |
|33461|The number of cloud backups exceeds the daily limit of <_BackupsPerDay_> backups a day.|Set a value within the limit.|
|33462|Some relative weeks are duplicated.|Make sure there aren't any duplicate weeks.|
|33463|Some months are duplicated.|Make sure there aren't any duplicate months.|
|33464|A new retention policy can't be set for this protection group. A retention policy has already been configured.|To reset the initial online replication method:<br/>1. Stop online protection for the protection group.<br/>2. Then add online protection with a new initial online replication method. <br/><br/> **Note** <br/>This action deletes all cloud data for the protected protection group.|
|33465|The retention schedule doesn't match the backup schedule.|Specify retention points that match the online backup schedule.|
|33466|Some retention intervals are duplicated.|Make sure there aren't any duplicate intervals.|
|33467|A new retention policy can't be set for this datasource. A retention policy has already been configured.|To set a new retention policy, you'll need to stop online protection for the data source and then add online protection with a new retention policy. This action deletes all cloud data for the protected data source.|
|33468|Retention policy could not be updated as Retention Range cannot be less than 7 days for daily backups, 4 weeks for weekly backups, 3 months for monthly backups and 1 year for yearly backups.|Make sure provided retention range value is greater than or equal to minimum retention value.|
|33469|This operation is not supported on the current version of MARS Agent.|Install the latest version of MARS Agent and try again.|
|33470|Security PIN required to complete this operation.|Use the SecurityPin parameter to provide the Security PIN.|
|33471|Some values for offline initial data replication are missing.|Specify all parameters.|
|33472|The specified network share path is invalid.|Specify a valid network share path in the following format: <br/><br/>**\\\\\<Computer-Name>\\\<Share-folder>\\\<file>**|
|33473|Waiting to copy initial backup data from the share to Azure storage.|To resolve this issue:<br/>1. Install the Azure Import tool from the link that appears below the alert window.<br/>2. Run the tool to copy data to disk.<br/>3. Ship the disk to Azure.|
|33474|Initial backup data transfer to staging location is complete.|Transfer the initial backup data with Azure Import job.|
|33475|Waiting for Azure import job to finish. Install the Azure Import tool and transfer the initial backup data at staging location with Azure Import job.|Complete the initial data transfer in accordance with the instructions.|
|33476|Could not read Publish Settings file.|Check if file is valid.|
|33477|This action needs cloud recataloging and may take sometime. Try this action after recatalog is complete.<br/>Do you want to proceed?| |
|33478|Initial online replication method is already configured.|To reset the initial online replication method:<br/>1. Stop online protection for the protection group.<br/>2. Then add online protection with a new initial online replication method. <br/><br/>**Note**<br/>This action deletes all cloud data for the protected protection group.|
|33480|Subscription ID and publish settings file entered are not related.|Verify the following:<br/>1. The Subscription ID entered.<br/>2. The Publish setting file is of the subscription for which subscription ID is entered.|
|33481|Failed to add online recoverable data from external DPM: <_ServerName_>.|Retry after some time has passed.|
|33482|No other DPM server is registered to this vault.|HASH(0x3e553b4)|
|33483|Either the recoverable data is not available or the selected server is not a DPM server.|HASH(0x3e55ddc)|
|33485|The full and forever backup options are not supported for daily and weekly.|HASH(0x3e501ec)|
|33486|The recovery point specified is already on hold|HASH(0x3e53c2c)|
|33487|The recovery point specified is not on hold|HASH(0x3e5462c)|
|33488|There are duplicate full/forever backup parameters|HASH(0x3e4f024)|
|33489|Azure Backup enables only one forever recovery point for monthly or yearly retention policies.|Select a single forever recovery point for monthly or yearly retention policies|
|33490|The cmdlet <_CmdletName1_> is not supported in a remote environment.| |
|33491|Import Job name must be between 2 and 64 characters long. It can contain only lowercase letters, numbers, hyphens, and underscores, must start with a letter, and may not contain spaces.|HASH(0x3e5ae74)|
|33492|Storage Account name should be between 3 and 24 characters long. It can contain only lowercase letters and numbers.|HASH(0x3e58884)|
|33493|Storage Container name should be between 3 and 63 characters long. It can contain only lowercase letters, numbers, and hyphens, and must begin with a letter or a number. The name can't contain two consecutive hyphens.|HASH(0x3e59284)|
|33494|Microsoft Azure Backup Agent cannot be installed on a machine which has Microsoft Azure Recovery Services Agent installed.|To install a Microsoft Azure Backup Agent on a target server which has Microsoft Azure Recovery Services Agent installed, uninstall the Microsoft Azure Recovery Services Agent, and try the installation again. For more information, see [Install and upgrade Azure Backup Server](/azure/backup/backup-azure-microsoft-azure-backup).|
|33495|Installation cannot proceed on a machine which has Microsoft Azure Recovery Services Agent installed.| To install a Microsoft Azure Backup Agent on a target server which has Microsoft Azure Recovery Services Agent installed, uninstall the Microsoft Azure Recovery Services Agent, and try the installation again. For more information, see [Install and upgrade Azure Backup Server](/azure/backup/backup-azure-microsoft-azure-backup). |
|33496|Microsoft Azure Backup cannot be installed on a machine which has System Center Data Protection Manager installed.| To install a Microsoft Azure Backup Agent on a target server which has Microsoft Azure Recovery Services Agent installed, uninstall the Microsoft Azure Recovery Services Agent, and try the installation again. For more information, see [Install and upgrade Azure Backup Server](/azure/backup/backup-azure-microsoft-azure-backup). |
|33497|Microsoft Azure Backup cannot be installed on a machine which has System Center Data Protection Manager Agent installed.| To install a Microsoft Azure Backup Agent on a target server which has Microsoft Azure Recovery Services Agent installed, uninstall the Microsoft Azure Recovery Services Agent, and try the installation again. For more information, see [Install and upgrade Azure Backup Server](/azure/backup/backup-azure-microsoft-azure-backup). |
|33498|Microsoft Azure Backup is already installed on this machine.| |
|33499|Setup has detected that Microsoft Azure Recovery Services Agent is already installed on this machine. Will skip its installation.| |
|33500|The database of this DPM server is located on this remote SQL server instance: <br/><_ServerName_>\\<_SqlInstance_><br/> <br/>To protect the database of this DPM server, you must install a protection agent on that computer, open this wizard, navigate to the remote instance of SQL server, and select the DPM database for protection.<br/>| |
|33501|This version of SQL Client Tools is not compatible with the installed SQL Server version. Install SQL Client Tools compatible with the installed SQL Server.| |
|33502|Cloud Metadata backup is already in progress. Skipping Cloud Metadata backup.| |
|33503|Machine cloud registration status is false. Cannot proceed with Cloud Metadata backup.| |
|33504|There is no change in Cloud Metadata. Skipping Cloud Metadata backup.| |
|33505|Unable to create a snapshot for this datasource. Following are possible reasons and recommended actions:<br/>1. Replica of datasource is in invalid state. Run consistency check on this datasource.<br/>2. Replica data is in inconsistent state. Create a disk recovery point of this datasource.<br/>3. Shadow copy volume should have <_MinDiffSpaceForCloudBackup_> Bytes free for taking a snapshot. Increase shadow copy volume size.|Check for the listed reasons of failure. Fix any that apply, then retry the operation. If the issue persists, contact Microsoft Support.|
|33506|DPM could not connect to Hyper-V WMI namespace.|Verify that the Windows Management Instrumentation (WMI) service is running and that the Hyper-V Management Tools are installed.|
|33507|DPM could not execute a WMI query. The query either returned an error or an empty result.|Retry the operation.|
|33508|DPM will format the volume before adding it to storage pool. Any data present on the volume will be deleted permanently. Do you want to continue?| |
|33509|The value <_ValueEntered_> is not allowed for the parameter <_Parameter1_>. Rerun the cmdlet with valid parameter values.| |
|33510|DPM could not find a suitable disk storage with enough free space for data source <_DatasourceName_>.|Verify that at least one of the disk storages allows protection of data source type <_DatasourceType_> and has enough free space. Or try to manually specify a disk storage with enough space for this data source.|
|33511|The disk storage selected for data source <_DatasourceName_> doesn't have enough free space.|Try selecting another disk storage or expanding the selected disk storage.|
|33512|DPM Setup was unable to delete backup data on disk storage.|Manually delete or format the disk storage.|
|33513|No manual initialization job pending on this datasource <_DatasourceName_>.| |
|33514|The used space on the DPM storage pool volume <_VolumeName_> has exceeded the threshold value of <_ThresholdValue_>%. If you do not expand the volume, backup jobs may fail.|Expand the storage pool volume or move storage for some data sources to other storage pool volumes.|
|33515|There is not enough space in DPM storage pool volume <_VolumeName_>|Expand the storage pool volume or move storage for some data sources to other storage pool volumes.|
|33516|DPM failed to communicate with a WMI Service while trying to execute a query.|Verify that the Windows Management Instrumentation (WMI) service, the Hyper-V Virtual Machine Management service and the Microsoft Storage Spaces SMP service are running and retry the operation.|
|33517|This operation is not allowed (<_Reason_>).|HASH(0x3e6797c)|
|33518|DPM storage pool volume <_VolumeName_> is missing.|Verify that the volume is online and healthy. Trigger a rescan from the DPM Disk Management tab.|
|33521|DPM could not find a suitable disk storage to reallocate replica for data source <_DatasourceName_>.|Make sure that atleast one of the disk storages is healthy and has enough free space.|
|33600|Password entered is too long. It should be less than <_MaxPasswdSize_> characters.|Enter a smaller password.|
|33601|Writing credential to secure store failed with error <_LastError_>.|Investigate and fix the issue with secure storage on the DPM computer.|
|33602|Enumerating credentials from secure store failed with error <_LastError_>.|Investigate and fix the issue with secure storage on the DPM computer.|
|33603|Deleting credential from secure store failed with error <_LastError_>.|Investigate and fix the issue with secure storage on the DPM computer.|
|33604|The credential name passed was either null or empty.|Pass a valid credential name.|
|33605|The user name passed was either null or empty.|Pass a valid user name.|
|33606|The credential name passed is already present.|Pass a new credential name.|
|33607|The credential name passed is not present.|Pass an existing credential name.|
|33608|Reading credential from secure store failed due to invalid credential handle.|Investigate and fix the issue with secure storage on the DPM computer.|
|33609|Passing credentials across machines is not permitted due to relaxed security settings.|Perform this operation on the DPM server so you do not have to pass credentials across the network.|
|33610|The Server ID passed is Guid.Empty.|Pass a valid Server ID.|
|33611|Specified server already exists. Please add a new server name.|Pass a new server name.|
|33612|The Server name passed is Guid.Empty.|Provide a valid server name.|
|33613|The proxy server does not exist.|Pass a valid proxy server that has DPMRA installed.|
|33614|DPM encountered error from VMware server <_ServerName_> with Fault - <_VMWareErrorCode_>|Verify that the VMware Server is in a good state.|
|33615|DPM could not enumerate VMware Server on the protected computer <_ServerName_>.| Verify that the VMware Server is in a good state. |
|33616|VMware server is not reachable.| |
|33617| <_ServerName_> is not a VMware server. This operation can only be performed on a VMware server.|Provide a valid VMware Server.|
|33618|Selected datastore is not available to selected host|Provide a valid datastore.|
|33619|Invalid resource pool. Selected resource pool does not belong to the selected host's compute resource|Provide a valid resource pool.|
|33620|DPM encountered error from VMware Disk SubSystem. Server - <_ServerName_> ErrorCode - <_VMWareErrorCode_>|Verify  that the VMware Server is in a good state.|
|33621|DPM encountered error from VMware while trying to get ChangeTracking information. Server - <_ServerName_> ErrorCode - <_VMWareErrorCode_>|Run a Consistency Check Job to synchronize the backup copy.|
|33622|Selected folder is invalid for recovery.|Select the folder from the VM folder hierarchy of the selected host system's datacenter|
|33623|Unable to communicate with VMware Server <_ServerName_>.| |
|33624|Description entered is too long. It should not be greater than <_MaxDescriptionSize_> characters.|Enter a shorter description.|
|33625|Unable to Delete credential <_CredName_>| This credential is used by <_NumberOfProdServers_> production server(s) for authentication purposes. A credential can be deleted only if this credential is not used by any production servers. Update Production Servers to use a different credential and then delete this credential.|
|33626|Unable to find Production Server <_ProdName_>.|Verify that the correct production server is specified as the input parameter. Rerun the command with right production server information.|
|33627|No settings provided to update Production Server <_ProdName_>.|Provide the production server settings that need to be updated on production server. Rerun the command with right production server settings.|
|33628|Credential name entered is too long. It should not be greater than <_MaxCredNameSize_> characters.|Enter a shorter credential name.|
|33629|User name entered is too long. It should not be greater than <_MaxUserNameSize_> characters.|Enter a shorter user name.|
|33630|Production Server cannot be removed until all protected members of the associated computer are removed from all protection groups.|Remove all protected member of the associated computers from protection groups: <_ListofServers_> |
|33631|Production server name entered is too long. It should not be greater than <_MaxProductionServerNameSize_> characters.|Enter a shorter Production server name.|
|33632| <_DatasourceName_> cannot be added to protection because it is already a member of another DPM Server| |
|33633|Tape protection is not supported for VMware VM data sources.| |
|34000|Unknown failure when removing record for <_ServerName_>|Retry the operation|
|34500|The backup failed as the total size of the data that has been backed up has exceeded the quota limit for your organization.|To prevent backup failures for subsequent scheduled backups:<br/>1. Reduce the retention range of your backups to ensure that older backups are deleted.<br/>2. Unregister unused servers to ensure that space is not allocated to them.|
|34501|The backup could not be started because the following virtual hard drive could not be mounted: <_FileName_>|Verify that the scratch space configured for backup is located in an unencrypted and uncompressed folder.|
|34502|The backup could not be started because of an unexpected error in the virtual disk service.|Restart the virtual disk service and try the backup operation again. If the issue persists, check the system event log for virtual disk service events.|
|34503|Windows Azure Backup Agent has detected file corruption when verifying the latest backup. A new recovery point could not be created.|The next backup will attempt to transfer the data again. If the issue persists, contact Microsoft support|
|34504|Backup has encountered an irrecoverable error.|Contact Microsoft Support for further assistance.|
|34505|The encryption passphrase for this server is not set. Configure an encryption passphrase.|Verify that the encryption passphrase is configured properly.|
|34506|The encryption passphrase stored for this computer is not correctly configured.|Verify that the encryption passphrase is configured properly.|
|34507|The encryption passphrase provided is incorrect.|Provide the same passphrase that you used previously to register this server to the vault.|
|34508|The certificate specified is not associated with any Backup Vaults.Try a different certificate.|Verify that the public key of the certificate you want to use has been uploaded to the Windows Azure Backup Vault.|
|34509|The server registration certificate could not be retrieved from the local certificate store. Verify that a valid certificate is present in the local certificate store, and then try again.|A valid certificate for Recovery Service registration has the following properties:<br/>1. The certificate has not expired.<br/>2. The certificate has a Client Authentication EKU and a Private Key that is associated with the Public Key uploaded to the Windows Azure Backup Vault.|
|34510|The local certificate store does not have a valid registration certificate for this server.|A valid certificate for Recovery Service registration has the following properties:<br/>1. The certificate has not expired.<br/>2. The certificate has a Client Authentication EKU and a Private Key that is associated with the Public Key uploaded to the Windows Azure Backup Vault.|
|34511|This server name is already registered with the backup vault.|To re-register this server, go to the server list of the backup vault in the Windows Azure Management Portal and select **Allow Re-registration**.|
|34512|No Backup Vaults found for this certificate. Check if the certificate is valid and supports backup service registration.| |
|34512|No Backup Vaults found for this certificate. Check if the certificate is valid and supports backup service registration.| |
|34513|Invalid vault credentials provided. The file is either corrupted or doesn't have the latest credentials associated with recovery service.|We recommend you to download a new vault credentials file from the portal and use it before 2 days from the day of download.|
|34514|Vault credentials file provided has expired|We recommend you to download a new vault credentials file from the portal and use it before 2 days from the day of download.|
|34515|You are trying to register this machine to a Deduplication enabled vault. For optimal Deduplication savings, you need to enter the same passphrase you provided for any other machine that you have previously registered to this vault.|HASH(0x3efb70c)|
|34516|Microsoft Azure Recovery Services Agent has detected inconsistencies while verifying the latest backup. A new recovery point could not be created.|The next backup will attempt to transfer the data again. If the issue persists, contact Microsoft support|
|34517|Microsoft Azure Recovery Services Agent has detected inconsistencies while verifying the latest backup. A new recovery point could not be created.|The next backup will attempt to transfer the data again. If the issue persists, contact Microsoft support|
|34518|Microsoft Azure Recovery Services Agent has detected inconsistencies while verifying the latest backup. A new recovery point could not be created.|The next backup will attempt to transfer the data again. If the issue persists, contact Microsoft support|
|34519|Microsoft Azure Recovery Services Agent has detected inconsistencies while verifying the latest backup. A new recovery point could not be created.|The next backup will attempt to transfer the data again. If the issue persists, contact Microsoft support|
|34522|Backup failed for <_VirtualMachineName_> on <_ServerName_>. Change tracking data was not found for the VHD. This can happen if one or more VHD(s) of this VM are replaced by another VHD(s).|Run a consistency check for the VM:<br/>1. On **Protection**, select the VM.<br/>2. Select **Consistency Check**.|
|34527|Unable to access the vault credentials file provided.|Verify that a local copy of the downloaded vault credentials file is accessible with system privileges on the protected machine and try again.|
|34528|Unable to read the vault credentials file provided.|Download a new vault credentials file and try again.|
|34529|The operation cannot be completed as a file required for completion of this operation is being used by another process.|Retry the operation after sometime has passed.|
|34530|The operation could not be completed at this time due to insufficient system resources.| Retry the operation after sometime has passed. |
|34531|Azure was unable to authenticate the operation at this time. This could be due to temporary issues.| Retry the operation after sometime has passed. If the issue persists, contact Microsoft Support.|
|34532|Unable to complete backup as the integrity of the data, created as result of backup, could not be verified at this time.| Retry the operation after sometime has passed. If the issue persists, contact Microsoft Support.|
|34645|Microsoft Azure Recovery Services Agent has detected inconsistencies while verifying the latest backup. A new recovery point could not be created.|The next backup will attempt to transfer the data again. If the issue persists, contact Microsoft support|
  
## Error codes 40001-100000

|Error code|Message|Additional information|
|---|---|---|
|40001|An unexpected internal error occurred in the StorageManager.| |
|40002|The VHD containing the replica or one of its snapshots could not be mounted or unmounted.|Verify that the storage containing the VHD is healthy, mounted, and the VHD is not in use by other processes, and retry the operation.|
|40003|The storage involving the current operation could not be read from or written to.|Verify that the storage is healthy, mounted, not in use by other processes, and has enough free space for this operation, and then retry the operation.|
|40004|The replica involving the current operation is in a corrupted state.|Unprotect and reprotect the datasource.|
|40005|The specified storage is unusable as it is a system volume, has existing data, is in an unhealthy state or formatted incorrectly.|Ensure that the storage is healthy and mounted and then retry the operation.|
|40006|The specified storage has already been added to DPM storage pool.|HASH(0x3ef7fbc)|
|40007|The specified storage is not in DPM storage pool.|HASH(0x3eff98c)|
|40008|The specified parameter combination is invalid.|HASH(0x3f00324)|
|40009|The specified operation requires the associated storage to be mounted first.|HASH(0x3f00c94)|
|40010|The VHD specified for mount or dismount operation cannot be found.|Check the storage hosting the related data source, refresh DPM storage, and retry the operation.|
|40011|The specified operation requires the associated storage to be unmounted first.|HASH(0x3ec6de4)|
|40012|Volume <_VolumeName_> cannot be removed from DPM storage because data sources are being actively/inactively backed up to it. Stop protection of those data sources with delete data to remove the volume from DPM storage.|HASH(0x3ec576c)|
|40013|This operation is not supported on data sources protected on legacy storage (DPM storage pool disks).|HASH(0x3ec30ec)|
|40014|The target disk storage specified is same as the source disk storage.|Specify another target disk storage.|
|50000|Microsoft Azure Backup does not support tape as backup target.|HASH(0x3ec94ac)|
|50001|Microsoft Azure Backup does not support Microsoft Virtual Machine Manager.|HASH(0x3ec9f1c)|
|50002|Microsoft Azure Backup server cannot protect another Azure Backup server|HASH(0x3ec4984)|
|50004|Microsoft Azure Backup server cannot continue the backup job as it has been disconnected from the Azure service for <_DaysCount_> or more days.|Restore network connectivity to Azure.|
|50005|Microsoft Azure subscription has expired. All backups to disk and Azure are stopped. In order for Microsoft Azure Backup to function properly, it is important to have an Active Azure subscription and network reachability to Azure service.|Sign in to Azure subscription portal and take corrective actions to make subscription Active. |
|50006|Microsoft Azure subscription has been de-provisioned. Backups to both disk and Azure are stopped. Recovery from Azure as well as disks are stopped. In order for Microsoft Azure Backup to function properly, it is important to have an Active Azure subscription and network reachability to Azure service.|Sign in to the Azure portal and reactivate your subscription.|
|50007|In order for Microsoft Azure Backup to function properly, it is important to have an Active Azure subscription and network reachability to the Azure service.|Verify that you can connect to the Azure service and that the Azure subscription is active|
|50008|Azure Backup Server needs a staging area for backup and recovery purposes.|To create a staging area:<br/>1. Sign in to the MABS UI and select the **Management** Tab.<br/>2. On the **Management** Tab, select **Online** and then select **Configure**.|
|50009|Azure Backup Server needs .NET Framework 4.6 to be installed. Install .NET Framework 4.6 from <https://go.microsoft.com/fwlink/?linkid=846809> and rerun Setup.| |
|50010|A required hotfix KB2919355 is missing. Install this hotfix from <https://support.microsoft.com/kb/2919355/>, and then re-run setup| |
|50011|Setup could not update registry metadata. This update failure could lead to over usage of storage consumption. To avoid this, please update the ReFS Trimming registry entry as mentioned in the article here: [https://aka.ms/mabstroubleshootingguide](https://aka.ms/mabstroubleshootingguide) | |
|50012|Setup could not update registry metadata. This update failure could lead to over usage of storage consumption. To avoid this, please update the Volume SnapOptimization registry entry as mentioned in the article here: [https://aka.ms/mabstroubleshootingguide](https://aka.ms/mabstroubleshootingguide) | |
|50013|Setup could not update registry metadata. This registry is intended to improve the performance. To get advantage of it, please update the Duplicate Extent BatchSize registry entry as mentioned in the article here: [https://aka.ms/mabstroubleshootingguide](https://aka.ms/mabstroubleshootingguide) | |
|50014|Setup could not update registry metadata. This registry is intended to improve the performance. To get advantage of it, please update the Duplicate Extent BatchSize registry entry as mentioned in the article here: [https://aka.ms/mabstroubleshootingguide](https://aka.ms/mabstroubleshootingguide) | |
|50500|Setup has detected that Microsoft Azure Backup is already installed on this machine. Will skip its installation.| |
|50501|Microsoft Azure Backup cannot be installed on a machine where registered backup vault is on protected storage model. Kindly change backup vault to protected instance model.| |
|50502|The version of the SQL Server Tools provided is lower than SQL Server 2014. The minimum supported version of the SQL Server Tools is SQL Server 2014.| |
|50503|SQL Server Management 2014 tools not installed on this machine.<br/>1) Please install SQL Tools from installation media.<br/>2) For more details about SQL Server tools go to [https://msdn.microsoft.com/data/hh297027](https://msdn.microsoft.com/data/hh297027). | |
|50504|.NET Framework 3.5 SP1 is not installed on this machine. Install it and rerun Setup.| |
|50506|A new version of Microsoft Azure Backup Server is available. You can review details about the new version and download it from [https://go.microsoft.com/fwlink/?LinkID=620846](https://go.microsoft.com/fwlink/?LinkID=620846). | |
  
## Error codes 100001+

|Error code|Message|Additional information|
|---|---|---|
|100001|This backup policy cannot be saved because required items are omitted.|Verify that you have configured the backup schedule, retention rules, selected valid files and folders, and then try to save the backup policy again.|
|100002|This backup policy cannot be saved because the files to backup are not specified.|Select the files to include in the backup and then try to save the policy again.|
|100003|This backup policy cannot be saved because the files specified for backup are not valid.|Select valid files to include in the backup and then try to save the policy again.|
|100004|This backup policy cannot be saved because the backup schedule is not specified.|Select the days and times on which to perform the backup and then try to save the policy again.|
|100005|This backup policy cannot be saved because the backup schedule is not complete.|Verify that you have selected both the days and times on which to perform the backup and then try to save the policy again.|
|100006|This backup policy must be saved before it can be used to perform a backup.| |
|100007|The backup policy you are attempting to delete does not exist on the server.| |
|100008|A new backup policy cannot be created because the current server already has an existing backup policy.|To create a new backup policy for this server, you must first delete the previous policy. To change when backups are performed or which items are included in the backup, modify the existing policy.|
|100009|The backup operation that is currently running has encountered invalid parameters.|Stop the backup operation and verify the files and folders included in the backup are valid.|
|100010|An internal error prevented the modification of the backup policy.| |
|100011|You must be a member of the local Administrator group or have equivalent rights to start this application.| |
|100012|The server must be registered with Microsoft Azure Backup before this operation can be performed.| |
|100013|To include this volume in the backup policy, you must specify at least one file or folder from the volume to include in the backup.| |
|100014|The backup schedule specified cannot be used because it has duplicate days or times.|Remove the duplicate items before attempting to save the schedule.|
|100015|The backup schedule specified cannot be used. Backup schedules can only be configured to run every half an hour starting from 00:00 hrs.|Choose a backup time that is either on the hour or on the half-hour.|
|100016|A backup policy cannot be saved without any files or folders.| |
|100017|The backup operation was unable to start.| |
|100018|The recovery operation was unable to start.| |
|100019|The current operation could not be stopped.| |
|100020|The Microsoft Azure Backup Agent replication engine failed to initialize, then retry the backup operation.| |
|100021|Microsoft Azure Backup Agent could not connect to the Microsoft Azure Backup to determine the state of the current operation.| |
|100025|The encryption passphrase for this server has expired.|Configure the encryption passphrase from the Microsoft Azure Backup MMC snap-in:<br/>1. In the **Action** pane, select **Change Properties**, and then select the **Encryption settings** tab.<br/>2. In the space provided, type the passphrase used to encrypt backups.|
|100027|Microsoft Azure Backup Agent is unable to obtain the encryption keys needed to perform the restore.|Contact Microsoft Support.|
|100028|The volume specified for the backup is configured as a read-only drive and cannot be backed up using Microsoft Azure Backup.| |
|100029|The volume specified for the backup is a cluster shared volume and cannot be backed up using Microsoft Azure Backup.| |
|100030|Microsoft Azure Backup Agent was unable to initialize a backup storage location with the Microsoft Azure Backup.|Try the operation again. If the issue persists, contact Microsoft Support.|
|100031|Microsoft Azure Backup Agent was unable to initialize the storage location with Microsoft Azure Backup required to perform the backup.|Try the operation again. If the issue persists, contact Microsoft Support.|
|100032|Microsoft Azure Backup Agent encountered an unexpected error at the completion of the backup operation. This backup might not be recoverable.|Try the operation again. If the issue persists, contact Microsoft Support.|
|100033|Microsoft Azure Backup Agent encountered an unexpected error at the completion of the backup operation. This backup might not be recoverable.|Try the operation again. If the issue persists, contact Microsoft Support.|
|100034|Microsoft Azure Backup Agent was unable to create a snapshot of the selected volume.|Try the operation again. If the issue persists, contact Microsoft Support.|
|100035|Microsoft Azure Backup Agent encountered an unexpected failure while transferring data to the Microsoft Azure Backup. This backup might not be recoverable.|Try the operation again. If the issue persists, contact Microsoft Support.|
|100036|Microsoft Azure Backup Agent encountered an unexpected error during the backup operation. This backup might not be recoverable.|Try the operation again. If the issue persists, contact Microsoft Support.|
|100037|The current operation was canceled by the administrator.| |
|100038|The current operation failed to complete successfully. See the data source error details for more information.| |
|100039|One or more volumes with files and folders selected for backup do not exist.|Verify that the volume(s) selected for backup are mounted, online, and accessible, and try again.|
|100040|The volume specified for backup is not a fixed volume. Microsoft Azure Backup can only be used with fixed volumes.| |
|100041|The volume specified for backup is currently protected by BitLocker Drive Encryption. You must unlock the volume before it can be backed up to the Microsoft Azure Backup.|Verify that the volume is unlocked and then try the operation again.|
|100042|The encryption passphrase for this computer is not correctly configured. Encryption passphrases must be at least 16 characters in length.|To proceed, specify a passphrase that is at least 16 characters in length.|
|100043|The encryption passphrase for this computer is not correctly configured. Encryption passphrases must be at least 16 characters in length.|To proceed, specify a passphrase that is at least 16 characters in length.|
|100044|The encryption passphrases entered do not match.|Verify that both the entered passphrases match and then proceed.|
|100045|This backup policy cannot be saved because the retention settings are not configured correctly.|Use the Schedule Backup wizard to configure the policy again.|
|100046|Microsoft Azure Backup Agent was unable to initialize the operation.|Review the system error details and system event logs and take appropriate action, then try the operation again.|
|100047|Backup policy settings cannot be modified when a backup or recovery operation is in progress.|Wait until the operation finishes or cancel the currently running operation, and then try again.|
|100048|The number of encryption keys for the server has exceeded the maximum limit.|Contact Microsoft Support.|
|100049|The operation attempted cannot be performed at this time because a backup or restore operation is currently in progress.|Wait until the operation finishes or cancel the currently running operation, and then try again.|
|100050|The Microsoft Azure Backup Agent was unable to connect to the Microsoft Azure Backup.|Check your network settings and verify that you are able to connect to the internet.|
|100051|The Microsoft Azure Backup Agent was unable to connect to the Microsoft Azure Backup before the connection request timed out.|Check your network settings and Verify that you are able to connect to the internet.|
|100052|The Microsoft Azure Backup Agent cannot connect to the OBEngine service.|Verify that the OBEngine service is present in the Services Control Panel and that the port <_InputParameterTag_> is available.|
|100053|Unable to get a response from the Microsoft Azure Backup Agent on this server. This may be because the Microsoft Azure Backup Agent is busy processing other requests. Retry this operation after some time.| |
|100055|An unexpected error caused the backup verification process to fail.|Review the error details and take appropriate action. Then try the operation again.|
|100056|The file name cannot contain any of the following characters `"\/:?<>|`.<br/>Searching for items to recover using the wildcard character (\*) is only supported for patterns such as \*abc\*, abc*or*abc.|Review the error details and take appropriate action. Then try the operation again.|
|100057|The current backup operation failed because the number of data transfer failures was more than <_FailureCount_> Specified files could not be processed.|Verify that the volume where the scratch space is configured is not full and retry the operation after addressing the individual errors in the log.|
|100058|The current recovery operation failed because the number of data transfer failure was more than <_FailureCount_> Specified files could not be processed.|Select another recovery point and try the recovery operation again.|
|100059|The operation failed as the log file <_FileName_> could not be created.| |
|100060|The backup job failed as none of the files could be processed.|Retry the operation after addressing the individual errors in the log|
|100061|The recovery job failed as none of the files could be processed.|Select another recovery point and retry the operation.|
|100062|The server registration status could not be verified with Microsoft Azure Backup.|Verify that you are connected to the internet and that proxy server settings are configured correctly. Then refresh the Microsoft Azure Backup MMC snap-in to update the server registration status.|
|100063|ConfigurationError|
|100064|Backup cannot be configured to run more than thrice a day.|Limit the number of scheduled backups to three times per day.|
|100065|Backups can be retained for 7, 15, or 30 days. And not any other value.|Choose whether to retain your backups for 7, 15, or 30 days.|
|100066|The current operation failed due to an internal service error [<_InputParameterTag_>]. Retry the operation after some time has passed.|If the issue persists, contact Microsoft Support.|
|100067|The operation failed because Microsoft Azure Backup Agent was unable to contact the Microsoft Azure Backup.|Verify that you are connected to the internet and that proxy server settings are configured correctly and then try again. If the issue persists, contact Microsoft Support.|
|100068|Azure backup does not support recovery to a network-share.|Select a locally mounted NTFS volume as the recovery destination and try again.|
|100069|Microsoft Azure Recovery Services Agent could not find the recovery location.|Ensure that specified recovery location is online and accessible|
|100070|The recovery destination selected for one or more files to be recovered is invalid.|Ensure that the recovery destination is located on a locally mounted NTFS volume.|
|100071|The specified volume for backup is invalid|Choose a volume on disk as backup source. To back up a volume, the volume must be formatted using NTFS and writable. Clustered shared volumes, network shares and removable media such as DVD drives and USB flash drives are not supported.|
|100072|Unable to complete recovery operation as the selected destination volume does not have free space.|Select a volume with adequate space and try again.|
|100073|The backup operation failed because the maximum allowed data source size of <_MaxSupportedSize_> GB was exceeded.|Reduce the amount of data included in the backup and retry the operation.|
|100074|VSS Snapshot created for backup disappeared while backup was in progress.|Retry the backup. If the issue persists, try to increase diff area allocation using the **vssadmin** command-line tool and verify that you have installed the latest updates.|
|100075|A failure occurred while adding one or more of the volumes involved in backup operation to the snapshot set. Check the event log to troubleshoot the issue.|Check recent records from the VolSnap data source in the Application Event Log to find out why the problem occurred.|
|100076|This operation cannot be performed because case-sensitivity is enabled on this server. Backup of case-sensitive file and folders is not supported even when case-sensitivity is disabled on the server.| |
|100077|The specified file path <_FileName_> is invalid for one or more of the following reasons<br/>1) File name cannot contain any of the following characters `<>:"/\|?`<br/>2) File path cannot contain any of the following characters `<>:"/\|*?`<br/>3) File path cannot be specified as a relative path. It cannot contain `.` and `..`<br/>4) File location cannot be specified using UNC path.|If the file location path uses a relative path or a UNC path, change the file path to use an absolute path. If the file name of folder contains an unsupported character, you must rename the items before they can be backed up.|
|100078|The volume containing the file path <_FileName_> is invalid for one or more of the following reasons<br/>1) Volume is protected by BitLocker Drive Encryption.<br/>2) Volume is not formatted with NTFS.<br/>3) Drive type is not fixed.<br/>4) Volume is read-only.<br/>5) Volume is not currently online.<br/>6) Volume is on a network share.| |
|100079|The specified file path <_FileName_> is invalid because it refers to a path that cannot be found.|Verify that the file path is correct and then try again.|
|100080|The specified file path <_FileName_> is invalid because it is under a reparse point. You cannot back up files that are under a reparse point.|Specify a file path that contains the destination of the reparse point, and then try again.|
|100081|The specified file path <_FileName_> is invalid for one or more of the following reasons<br/>1) It refers to a path that is not on the local server<br/>2) It is not a valid driver letter based file path|Specify a drive letter based file path, for example, C:\folder\subfolder\\*.txt or C:\mnt\E_vol\1.txt, and then try again.|
|100082|A newer version of Microsoft Azure Backup Agent is available.| |
|100083|A new version of Microsoft Azure Backup Agent is available. You can review details about the new version and download it from [http://go.microsoft.com/fwlink/p/?LinkId=229525](https://go.microsoft.com/fwlink/p/?LinkId=229525).| |
|100084|More than 80 percent of total storage space has been consumed.| |
|100085|More than 80 percent of total storage space has been consumed. To ensure that your backups occur without interruption modify your backup schedule to reduce the retention range of previous backups or reduce the number of items backed up.| |
|100086|Files from source volumes that have been optimized using data deduplication will be backed up in unoptimized form.| |
|100087|A server registration certificate was not available to authenticate this server with the backup service.|Ensure that you signed in with an administrator account and try again. If the issue persists, register the server again.|
|100088|The server registration certificate for this server is no longer valid and cannot be used to authenticate this server with the backup service.|You must register the server again to establish the server identity.|
|100089|The Microsoft Azure Backup Agent could not authenticate this server with the backup service.|You must register the server again to establish the server identity.|
|100090|Register or Unregister Server operation is in progress.|When the operation is complete, retry the Register or Unregister Server operation.|
|100091|An error was encountered while performing an operation for <_FileName_>.|To resolve this issue:<br/>- Retry the operation.<br/>- If the error is due to insufficient available resources, then it could be a transient failure. Retry the operation after some time has passed.|
|100092|The Microsoft Azure Backup Agent could not start the scheduled backup.|Verify that no other backup or recovery operation is in progress.|
|100093|An error was encountered while reading the specified location.|Verify that the location is valid and you have read and write permissions to the folder.|
|100094|The data format of the backup service and the Microsoft Azure Backup Agent do not match. Install the latest version of Microsoft Azure Backup Agent from the Microsoft Download Center (<https://go.microsoft.com/fwlink/p/?LinkId=229525>).|If the issue persists, contact Microsoft Support.|
|100095|The recovery operation cannot be performed as the original location for one or more files is no longer available|Specify another location as the recovery destination and try again.|
|100096|Invalid path specified.|Verify that the volume exists and specify the correct drive letter.|
|100097|Incorrect target volume specified.|Verify that the target volume exists and is not protected.|
|100098|Failed to perform rename-obvolume.|Retry the operation after some time has passed.|
|100099|Backup failed because Azure Backup was unable to create a snapshot for the selected backup volume(s) due to insufficient space.|Verify that there is at least 1 GB of free space available on each of the backed up volumes.|
|100100|One or more files or folders that you are selected for recovery are not present in the selected backup. This may happen if backup had completed with warnings with few failed files.|To resolve the issue:<br/>1. Try recovery from a backup which had succeeded without any warnings.<br/>2. Recover the parent folder of the current file.|
|100101|There must be a policy in active state for the backup to happen.| |
|100102|PolicyState cannot be set to Deleted. Use RemoveOBPolicy for deleting policy.| |
|100103|The algorithm name provided by you for encryption is not supported.|Verify that the algorithm name has been spelled correctly. To work with the default algorithm, remove the registry entry that specifies the algorithm name.|
|100104|The operation attempted cannot be performed at this time because maximum number of parallel backup jobs are already running.|Wait until the other backup operations finishes or cancel the currently running backup operation, and then try again.|
|100105|The operation attempted cannot be performed at this time because maximum number of parallel restore jobs are already running.|Wait until the other restore operations finishes or cancel the currently running restore operation, and then try again.|
|100107|A certificate was not available on this server to authenticate this server with the Microsoft Azure Backup Vault.|Verify that the certificate you installed on this server corresponds to the certificate that was uploaded to the Microsoft Azure Backup Vault, and then try again.|
|100108|The certificate associated with this server is no longer valid and cannot be used to authenticate this server with the Microsoft Azure Backup Vault.|Verify that certificate you installed corresponds to the certificate that was uploaded to the Microsoft Azure Backup Vault and that the certificate has not expired. Then try again.|
|100109|The number of recovery points cannot exceed <_MaxRecoveryPoints_>.|Modify the backup schedule and/or retention settings.|
|100110|This server is not registered to the vault specified by the vault credential.|Provide appropriate vault credential.|
|100111|The current operation is not supported for the type of vault associated with the provided vault credentials.|Provide appropriate vault credentials.|
|100112|The Publish Settings file provided is invalid.|Download the Publish settings file from Azure portal and create policy again|
|100113|The Subscription ID provided is invalid. Make sure a valid subscription ID is given corresponding to the Publish settings file provided|Check the subscription ID in Azure portal, download corresponding Publish settings file and create policy again|
|100114|The Import job name provided is invalid. Make sure the name consists of all lower case letters, digits, underscore and the name doesn't conflict with existing import jobs in the storage account|Check Import job name and check for duplicate names Import/Export tab in Storage account on the Azure portal|
|100115|The directory path provided doesn't exist or is not accessible|Check if directory exists and has valid permissions|
|100116|The string name provided is invalid|Check whether any invalid characters are used in specifying the name|
|100117|Pushing management certificate to local store failed|Check if a certificate is already present or store is inaccessible|
|100118|Import Job name must be between 2 and 64 characters long. It can contain only lowercase letters, numbers, hyphens, and underscores, must start with a letter, and may not contain spaces.|HASH(0x2ec9f14)|
|100119|Storage Account name should be between 3 and 24 characters long. It can contain only lowercase letters and numbers.|HASH(0x2ecb944)|
|100120|Storage Container name should be between 3 and 63 characters long. It can contain only lowercase letters, numbers, and hyphens, and must begin with a letter or a number. The name can't contain two consecutive hyphens.|HASH(0x2ef82c4)|
|100121|Azure Backup is not able to write to the specified recovery location.|Provide SYSTEM account read/write/modify permissions to the specified recovery location and try again.|
|100122|Microsoft Azure Recovery Services Agent UI and PowerShell Cmdlets cannot be used on a DPM Server.|Use the DPM UI or DPM PowerShell Cmdlets.|
|100123|Unable to recover files because selected items list for Recovery is large or selected items have long path names.|Retry the operation after reducing individual items (selecting complete folders can help).|
|100124|Cannot prepare the Staging Location for initiating Offline Backup.|Verify that the provided Staging Location is valid, online, and writeable, and try again.|
|100125|Could not create/update the configuration for Offline Backup.|Delete the existing schedule and reschedule backup. Verify that the Staging Location provided meets the following requirements:<br/>1. The Staging Location is valid, online, and writeable.<br/>2. The Staging Location has Local System privileges|
|100126|Recovery timed out due to expiry of the Vault Credential file used to initiate alternate server recovery.|Try again with a newly downloaded Vault Credential file and restore fewer items to finish the recovery within the Vault Credential expiry time of 48 hours.|
|100128|Cannot add new volume for protection when policy is in Offline Backup mode.|Wait until the policy mode changes to Online, and try again.|
|100129|Security PIN is not set.|To set a Security PIN, sign in to the Azure portal and navigate to **Recovery Services vault** > **Settings** > **Properties** > **Generate Security PIN**.|
|100130|Security PIN entered is incorrect.|Provide the correct Security PIN to complete this operation.|
|100132|Retention policy could not be updated as Retention Range cannot be less than 7 days for daily backups, 4 weeks for weekly backups, 3 months for monthly backups and 1 year for yearly backups|Verify that the Retention Range specified meets the minimum retention period requirements and try again.|
|100133|Source volume snapshot failed due to inconsistent datasource replica.|Run a consistency check on this datasource and try again.|
|100134|Source volume snapshot failed because metadata on replica is invalid.|Create a disk recovery point of this datasource and try online backup again.|
|100135|Unable to upload file catalog information.|Retry the operation. If the issue persists, contact Microsoft Support.|
|100136|Backup could not be started because of virtual hard drive named <_FileName could not be mounted_>|Verify that the RPC service is online and that Disk Management can connect to VDS. Restart the Virtual Disk service and the obengine service, and then try the backup operation again. For more details and solutions, search for the 0x800706BA code.|
|100137|Backup could not be started because of virtual hard drive named <_FileName could not be mounted_>|Restart the Virtual Disk service and retry the backup operation. Upgrade to latest operating system. For more details and solutions, search for the 0x80004005 code.|
|100138|Backup could not be started because of virtual hard drive named <_FileName could not be mounted_>|Restart the Virtual Disk service and retry the backup operation.|
|100139|Source volume snapshot failed because of low shadow copy volume space.|The shadow copy volume must have at least 1.2 GB free for taking snapshots. Increase the shadow copy volume size and try again.|
|100140|Source volume snapshot failed because replica is not idle.|The replica is not idle. Try again after some time has passed.|
|100141|Unable to authenticate as the time on this machine is not synchronized. All operations would fail until this is resolved.|Synchronize the time on your computer so that it is set accurately.|
|100142|Some important details needed for completing registration was not found. This may happen due to engine crash.|Enter the vault credential details again and try to register again.|
|100143|The operation failed because Microsoft Azure Recovery Services Agent was unable to contact Microsoft Azure Backup.|Verify that you are connected to the internet and that proxy server settings are configured correctly and then try again. Check if your firewall, vpn, or proxy server is blocking calls to Azure endpoints. If the issue persists, contact Microsoft Support.|
|100144|The operation failed because Microsoft Azure Recovery Services Agent was unable to contact Microsoft Azure Backup.|Verify that you are connected to the internet and that proxy server settings are configured correctly and then try again. Verify whether your firewall, vpn, or proxy server is blocking calls to Azure endpoints. If the issue persists, contact Microsoft Support.|
|100145|Unable to trigger wbadmin cmdlet or WSB PowerShell cmdlet.|Microsoft Azure Recovery Services Agent requires Windows Server Backup for its operations. Ensure that Windows Server Backup and the wbadmin command-line tool are installed and wbadmin service is running. <br/><br/>For more information, see [Install Windows Server Backup Tools](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732081(v=ws.11)?redirectedfrom=MSDN).|
|100146|The operation timed out before System State Backup could start on Windows Server Backup.|Verify that Windows Server Backup and the wbadmin command-line tool are installed. For more information, see [Install Windows Server Backup Tools](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732081(v=ws.11)?redirectedfrom=MSDN).|
|100147|Unable to get job status from Windows Server Backup.| Ensure that Windows Server Backup and the wbadmin command-line tool are installed. This can also happen if WSB process crashes.<br/><br/>For more information, see [Windows System State Backup to Azure with Azure Backup is generally available](https://azure.microsoft.com/blog/windows-server-system-state-backup-azure-ga/).|
|100148|The operation failed because another job is running on Windows Server Backup.|This job will be retried on its own.|
|100149|Unable to install Windows Server Backup tools that are required for System State Backup|Follow the instructions here to install Windows Server Backup and the wbadmin command-line tool.<br/><br/> For more information, see [Windows System State Backup to Azure with Azure Backup is generally available](https://azure.microsoft.com/blog/windows-server-system-state-backup-azure-ga/).|
|100150|The Target VHD path configured for System State backup is invalid.|Ensure that <_VhdFilePath_> is on a locally mounted volume and is online and accessible|
|100151|The Target Volume path configured for System State backup is invalid.|Ensure that <_VolumePath_> is on a locally mounted volume and is online and accessible|
|100152|Unable to create System State Backup VHDs using <_VhdFilePath_> and <_VolumePath_>.|Ensure that you have LOCAL SYSTEM ADMIN privileges to create files and directories on <*VhdFilePath*> and <*VolumePath*>.|
|100153|Unable to perform System State backup as the target volume has insufficient disk space|Ensure that you have minimum 20 GB disk space on the target volume and retry the operation.|
|100154|System State Backup is not supported for this machine.|For more information, see [Windows System State Backup to Azure with Azure Backup is generally available](https://azure.microsoft.com/blog/windows-server-system-state-backup-azure-ga/).|
|100155|Backup could not be started because staging vhd could not be prepared.|Check if LOCAL SYSTEM has access to <_VhdFilePath_> and scratch path and retry backup.|
|100156|Failed to stop WSB Job.|Retry the operation.|
|100157|Unable to perform the operation as Windows Server Backup job failed with error message: <_WSBMessage_>|For more information about resolving this issue, see [Microsoft Azure Recovery Services Agent System State Backup failure (error ID 8007007B)](https://support.microsoft.com/help/4053355).|
|100158|Unable to perform the operation as Windows Server Backup job failed with error message: <_WSBMessage_>|For more information about resolving this issue, see [Microsoft Azure Recovery Services Agent System State Backup failure (error ID 8007007B)](https://support.microsoft.com/help/4053355).|
|100159|Unable to perform the operation as Windows Server Backup job failed with error message: <_WSBMessage_>|For more information about resolving this issue, see [Microsoft Azure Recovery Services Agent System State Backup failure (error ID 8007007B)](https://support.microsoft.com/help/4053355).|
|100160|Job failed on WSB.|Retry the operation.|
|100161|Invalid System State Restore point.|Retry the operation.|
|100162|The operation failed because Microsoft Azure Recovery Services Agent failed to trigger System State Restore on WSB.|Verify that WSB and wbadmin are installed.|
|100163|Failed to start System State Restore job.|Retry the operation.|
|100164|Invalid System State Backup copy|Retry the operation.|
|100165|Microsoft Azure Recovery Services Agent was unable to initialize a backup storage location due to unresponsive VDS service.|Retry the operation. If the issue persists, contact Microsoft support.|
|100166|Microsoft Azure Recovery Services Agent was unable to initialize a backup storage location with Microsoft Azure Backup.|Retry the operation. If the issue persists, contact Microsoft support.|
|100167|Azure Backup does not support modifying items or backup and retention times for items configured for offline initial backup.|Wait until the completion of the offline backup job to make changes to the backup policy.|
|100168|Backup failed because of system file errors. This could be due to one or more actions (such as a reboot) pending on this server.|Run System File Checker to repair system file errors, reboot as required, and try the operation again. For more information, see [Use the System File Checker tool to repair missing or corrupted system](https://support.microsoft.com/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system).|
|100169|Backup failed because of system file errors. This could be due to one or more actions (such as a reboot) pending on this server.|Run System File Checker to repair system file errors, reboot as required, and try the operation again. For more information, see [Use the System File Checker tool to repair missing or corrupted system](https://support.microsoft.com/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system).|
|100170|Backup failed because the snapshot operation for one or more volumes selected for backup could not be initiated.|Ensure that the volume is not on a Virtual Hard Disk (VHD) that is contained in another VHD. Also, ensure that any file located on a VHD is not selected for backup, along with files on the volume containing the VHD.|
|100171|Windows Server Backup failed to back up System State due to low disk space. Windows Server Backup error message: <_WSBMessage_>|Increase disk space or move the scratch folder to a larger volume and retry the backup.|
|100172|Windows Server Backup failed to access some system files. Windows Server Backup error message: <_WSBMessage_>|Run System File Checker to fix system issues and retry the backup. For more information, see [Use the System File Checker tool to repair missing or corrupted system](https://support.microsoft.com/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system).|
|100173|Windows Server Backup failed to back up System State. Windows Server Backup error message: <_WSBMessage_>|To resolve the issue:<br/>1. Increase the amount of disk space or move the scratch folder to a larger volume and retry the backup. <br/>2. Run System File Checker to fix system issues and retry the backup.<br/><br/>For more information, see [Use the System File Checker tool to repair missing or corrupted system](https://support.microsoft.com/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system).|
|100174|Windows Server Backup failed to take system state backup. Windows Server Backup error message: <_WSBMessage_>|To resolve this issue:<br/>1. Apply the hotfix located in [2155347997 (0x8078001D) error code when you perform a system state backup operation in Windows 7 or in Windows Server 2008 R2](https://support.microsoft.com/help/2182466/2155347997-0x8078001d-error-code-when-you-perform-a-system-state-backu).<br/>2. Retry the backup.|
|100175|System Writer not found for System State backup. Windows Server Backup error message: <_WSBMessage_>|To resolve this issue, follow the procedures in [System State backup using Windows Server Backup fails with error: System writer is not found in the backup](https://support.microsoft.com/help/2009272/system-state-backup-using-windows-server-backup-fails-with-error-syste).|
|100176|This functionality is deprecated.|To resolve this error, use the Instant Recovery option and upgrade your DPM and MABS installation to the [recommended version](https://support.microsoft.com/topic/b50af79f-5966-4fa4-8fd2-12b56d1e6e9a) before installing MARS 2.0.9266.0.<br/><br/>This error can occur if you use an older DPM or MABS version that doesn't support iSCSI-based item-level recoveries, and upgrade to MARS 2.0.9266.0 or later.|
|100177|Backup failed because of system file errors. This could be due to one or more actions (such as a reboot) pending on this server.|Run System File Checker to repair system file errors, reboot as required and try the operation again. For more information, see [Use the System File Checker tool to repair missing or corrupted system](https://support.microsoft.com/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system).|
|100178|Backup failed because system file precheck timed out.|Retry the backup. For more information, see [Use the System File Checker tool to repair missing or corrupted system](https://support.microsoft.com/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system).|
|100179|System State backup cannot be done because there is a reboot pending on machine to apply latest Windows Updates.|Restart the computer and retry the backup.|
|100180|Backup failed because of non-transient errors in VSS.|If the issue persists, contact Microsoft Support.|
|100181|Backup failed because of transient errors in VSS.|Retry the backup after some time has passed. If this issue persists, restart the VSS service and try again.|
|100182|Backup failed because VSS writers timed-out before the successful completion of snapshot operations.|Retry the backup after some time has passed. If this issue persists, restart the VSS service and try again.|
|100183|Backup failed as Azure Backup could not communicate with VSS writers due to errors in VSS.|Restart the VSS Service. If the issue persists, restart this server and try again.|
|100184|Backup failed because the VSS service encountered an error. This could be a transient problem.|Restart the VSS service and try again.|
|100185|Backup failed because the creation of another snapshot is currently in progress.|Wait for some time to pass and try again.|
|100186|Backup failed because the VSS service timed out while flushing data to the volume being backed up. This could be due to excessive reads/writes on the volume.|Wait for volume activity to return to normal and try again.|
|100187|The shadow copy set contains only a subset of the volumes needed to correctly back up the selected components of the writer.|If the issue persists contact Microsoft Support.|
|100188|Backup failed due to unexpected errors in VSS.|Restart the VSS Writer services, restart the server, and try again.|
|100189|Backup failed due to unexpected errors in the VSS service. This could be a transient problem.|Retry the backup after some time has passed. If this issue persists, restart the VSS service and try again.|
|100190|Backup failed because the VSS writer service is unresponsive.|Restart the VSS Writer services, restart the server and try again.|
|100191|Backup failed because Azure Backup could not locate the disk-backup replica that is required for online backup.|To recreate the replica, run the following command from the DPM Console: <br/>`DpmSync.exe -ReallocateReplica`<br/><br/>Run a consistency check then try online backup again.|
|100192|Backup failed because the disk-backup replica mount-point could not be found due to a transient issue.|Retry the online backup. If the issue persists, contact Microsoft Support.|
|100193|Backup failed as the disk-backup replica could not be cloned.|Ensure that all previous disk-backup replica files (.vhdx) are unmounted and no disk to disk backup is in progress during online backups.|
|100194|Backup failed because the disk-backup replica mount-point could not be found due to a transient issue.|Retry online backup. If the issue persists, contact Microsoft support.|
|100195|Backup failed because the disk-backup replica is either invalid or missing.| This error appears when the disk replica files can't be mounted for online backup.<br/><br/>To work around this issue, follow these steps:<ol><li>Upgrade the MARS agent to the latest version and install the latest update rollup for DPM.</li><li>Retry the online backup for the failed datasource. </li><li>Create a new disk recovery point and retry the online backup.</li><li>Run a consistency check and retry the online backup.</li></ol>For more information, see [Online recovery point creation of a datasource might fail with error ID 33505 or 100195](/system-center/dpm/dpm-release-notes#online-recovery-point-creation-of-a-datasource-might-fail-with-error-id-33505-or-100195). <br/><br/> To fix this issue, apply [Hotfix 1 for Microsoft System Center Data Protection Manager 2022](https://support.microsoft.com/topic/intermittent-online-backup-failures-and-other-issues-in-data-protection-manager-2022-30df8903-f779-41c5-9b66-13a4b8461d0e).|
|100201|The current operation failed due to an internal service error **Authorization Failed**. Retry the operation after some time.|If the issue persists, contact Microsoft support.|
|100202|The current operation failed due to an internal service error **Authentication Failed**. Retry the operation after some time.|If the issue persists, contact Microsoft support.|
|100203|All folders which were part of the backup spec are not found.|Add the missing folders and try again.|
|100204|ACS to AAD migration has failed.|Restart the service.|
|100205|Microsoft Azure Recovery Services Agent was unable to complete the operation.|Retry the operation. If the issue persists, contact Microsoft support.|
|100206|Backup failed because Azure Backup could not initialize the metadata vhd at the configured cache location. This could be due to errors in the disk containing the cache location.|Move the cache location to a different disk and try this operation again.  For more information about how to update the cache location, see [Manage the backup cache folder](/azure/backup/backup-azure-file-folder-backup-faq#manage-the-backup-cache-folder).|
|100207|Retention policy could not be updated as Retention Range cannot be less than 7 days for daily backups, 4 weeks for weekly backups, 3 months for monthly backups and 1 year for yearly backups.|Update your retention policy and try again.|
|100208|Windows Server failed to take system state backup because a system writer reported an invalid path. Windows Server Backup error message: <_WSBMessage_>| |
|100209|Microsoft Azure Recovery Services Agent has detected inconsistencies while taking the latest backup.|The next backup will attempt to transfer the data again. If the issue persists, contact Microsoft support.|
|100210|Backup failed because Azure Backup could not prepare the metadata vhd at the configured cache location. This could be due to errors in the disk containing the cache location.|Move the cache location to a different disk and try this operation again. To learn how to update the cache location, see [Frequently asked questions - Microsoft Azure Recovery Services (MARS) agent](/azure/backup/backup-azure-file-folder-backup-faq).|
|100211|Windows Server failed to take system state backup because of low disk space to take a VSS snapshot. Windows Server Backup error message: <_WSBMessage_>|Refer to [Get-WBVolume](/powershell/module/windowsserverbackup/get-wbvolume) to find all critical volumes. Check if the VSS shadow copy storage area for all critical volumes is on a volume with sufficient free space.|
|100212|Windows Server failed to take system state backup because specified backup disk could not be found. This can happen if there are critical volumes (EFI or Recovery volume) from old Windows installation present on non-OS disk. Windows Server Backup error message: <_WSBMessage_>|Refer to [Get-WBVolume](/powershell/module/windowsserverbackup/get-wbvolume) to find all critical volumes. Format old critical volumes which are not in use and retry the backup.|
|100213|Windows Server failed to take system state backup EFI system partition is locked or other application is using files on the system partition. This can be due to some third-party security software. Windows Server Backup error message: <_WSBMessage_>|Exclude or unlock EFI system partition from your security software and retry the backup.|
|100214|VSS Snapshot created by Windows Server Backup disappeared while backup was in progress.|Refer to [Get-WBVolume](/powershell/module/windowsserverbackup/get-wbvolume) to find all critical volumes. Increase VSS shadow copy storage area for all critical volumes and/or move shadow copy storage area to a larger volume.|
|100215|A file reported by system writer is corrupt. Windows Server Backup error message: <_WSBMessage_>|Run System File Checker to fix system issues and retry the operation. For more information, see [Use the System File Checker tool to repair missing or corrupted system files](https://support.microsoft.com/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system).|
|100216|Operation failed as Windows Server Backup could not communicate with VSS writers due to errors in VSS. Windows Server Backup error message: <_WSBMessage_>|Restart the VSS Service. If the issue persists, restart this server and try again.|
|100217|Backup failed due to an unexpected error while reading the volume. This could be due to Disk error. Windows Server Backup error message: <_WSBMessage_>|Refer to [Get-WBVolume](/powershell/module/windowsserverbackup/get-wbvolume) to find all critical volumes, run chkdsk for critical volumes and retry the backup.|
|100218|Operation failed because of non-transient errors in VSS.|Run `vssadmin list writers` from an elevated command prompt, restart the associated services for the writers which are not in Stable state and retry the operation. If the issue persists contact Microsoft Support.|
|100219|Backup failed due to an unexpected error while reading the volume. This could be due to Disk error. Windows Server Backup error message: <_WSBMessage_>|Refer to [Get-WBVolume](/powershell/module/windowsserverbackup/get-wbvolume) to find all critical volumes, run chkdsk for critical volumes and retry the backup.|
|100220|Azure backup agent could not find any successful System State backup from WindowsServerBackup.|Retry the operation. If the issue persists contact Microsoft Support.|
|100221|Azure backup agent could not validate the System State backup taken by Windows Server Backup.|Retry the operation. If the issue persists contact Microsoft Support.|
|100222|Failed to connect with `wbengine` service.|Retry the operation. If the issue persists contact Microsoft Support.|
|100223|Backup failed due to insufficient disk space on the staging location.|Ensure that the staging location has available disk space greater than or equal to the cumulative size of the source data that you wish to back up via offline backup.|
|100224|Backup failed because size of data to be backed up from this volume exceeds the maximum allowed size of <_MaxSupportedSize_> TB for each volume on the current OS version.|Upgrade to Windows Server 2012 or above to protect up to 54 TB per volume, or ensure that no more than <*MaxSupportedSize*> TB of data is selected for backup per volume.|
|100225|Data did not get successfully transferred to the staging location.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft support.|
|100226|Unable to find changes in a file. This could be due to various reasons. Retry the operation.|Retry the operation.|
|100227|Operation failed because some of the System writers are in a bad state.|Check the list of failed writers in WSB Failure Logs link or run the `vssadmin list writers` command from elevated command prompt. Restart the associated services for the writers that are not in the Stable state and retry the operation. If the issue persists contact Microsoft Support.|
|100228|Failed to log on to Azure.|To resolve this issue, refer to [Troubleshoot Microsoft Azure Recovery Services (MARS) Agent](/azure/backup/backup-azure-mars-troubleshoot).|
|100229|Unable to locate provided storage account and container in the specified subscription.|Ensure that the storage account and container specified exist in the provided subscription, and try the operation again.|
|100230|Unable to make service calls to Azure that are required for querying Import Job status and moving backup data into the Recovery Services Vault.|To resolve this issue, refer to [Troubleshoot Microsoft Azure Recovery Services (MARS) Agent](/azure/backup/backup-azure-mars-troubleshoot).|
|100231|Unable to create resources and apply permissions for the provided Azure subscription ID as the current user is not an owner or service administrator for the provided subscription.|Ensure that you log on as an owner or admin of the provided Azure subscription and try again.|
|100232|Unable to locate Azure PowerShell on this server. Azure PowerShell is required to configure Offline backup.|To download and install Azure PowerShell, see [Install Azure PowerShell](/powershell/azure/install-az-ps). After you install Azure PowerShell, try again.|
|100233|Unable to log on to Azure as the subscription or the logon credentials provided is invalid.|Ensure that the entered subscription ID or the logon credentials are valid, and try the operation again.|
|100234|Operation failed as the shadow copy set contains only a subset of the volumes needed to correctly back up the System State. Windows Server Backup error message: <_WSBMessage_>|Restart the VSS Service. If the issue persists, contact Microsoft support.|
|100235|Windows Server Backup failed to back up System State due to dense directory structure. Windows Server Backup error message: <_WSBMessage_>|Apply the hotfix available from [You cannot back up the system state on a computer that is running Windows Server 2008 R2 or Windows Server 2012](https://support.microsoft.com/help/2807849/you-cannot-back-up-the-system-state-on-a-computer-that-is-running-wind). Then retry the backup. If the issue persists contact Microsoft Support.|
|100236|Windows Server Backup failed to back up System State because of transient errors in VSS.|Retry the backup after some time has passed. If this issue persists, restart the VSS service and try again.|
|100237|System State backup failed due to target disk not available.|Check if your antivirus and storage management applications have the Azure Backup scratch folder in their exclusion list and retry the backup.|
|100238|System State backup failed because Azure Backup agent failed to mount the staging disk.|Retry the backup.|
|100239|System State backup failed because multiple staging disks are mounted.|Open disk management and unmount all unnecessary disks and retry the backup.|
|100240|Failed to set Offline Seeding Policy as the required ARM Certificate XML file required for this policy could not be found.|Ensure that you have generated and imported the Certificate XML using the Microsoft Azure Offline Backup AD App and Certificate Generation Utility. For more information, see [Prerequisites](/azure/backup/backup-azure-backup-server-import-export#prerequisites).|
|100241|Offline Backup policy cannot be saved as the provided Import Job name has already been configured with a different storage account name "%StorageAccountName;" as part of another Backup policy configured on this server.|Reconfigure Offline Backup, with the same Import Job Name and storage account pair or choose a different Resource Group or Import Job Name.|
|100242|Unable to create Offline Backup policy for the current Azure account as this server's authentication information could not be uploaded to Azure.|Login using a different Azure account or refer to the steps listed at <https://go.microsoft.com/fwlink/?linkid=2051112>. If the issue persists, please contact Microsoft support.|
|100262|The encryption passphrase has not been validated to meet requirements. This is required to ensure successful online restores.|Please validate the encryption passphrase at the earliest by launching PassphraseValidator.exe from the `%ProgramFiles%\Microsoft Azure Recovery Services Agent\bin\` folder.|
|120001|The operation was performed successfully.| |
|120002|Operation failed.| |
|120003|Operation is in progress.| |
|130001|Microsoft Azure Backup encountered an internal error.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|130002|CloudInvalidInputError| |
|130003|The service version of the backup service and the Microsoft Azure Backup Agent do not match. Install the latest version of Microsoft Azure Backup Agent from the Microsoft Download Center ([http://go.microsoft.com/fwlink/p/?LinkId=229525](https://go.microsoft.com/fwlink/p/?LinkId=229525)).|If the issue persists, contact Microsoft Support.|
|130004|IdInvalidAudienceError| |
|130005|IdInvalidTokenError| |
|130006|IdIssuerNotTrustedError| |
|130007|IdMissingAudienceError| |
|130008|IdMissingExpiryFieldError| |
|130009|IdMissingIssuerError| |
|130010|IdTokenExpiredError| |
|130011|IdBadTokenSignatureError| |
|130012|IdClaimsIntegrityError| |
|130013|You are not authorized to perform this action| |
|130014|Microsoft Azure Backup encountered an internal error.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|130015|Microsoft Azure Backup was unable to complete the operation in the allotted time.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|130016|CloudConnectionError| |
|130017|AcsInvalidSAMLAssertionError| |
|130018|AcsNoOutputClaimError| |
|130019|AcsNoRPExistsError| |
|130020|AcsTokenResponseError| |
|130021|AcsTokenRequestError| |
|130022|SelfSignedCertCreationError| |
|130023|AcsMalformedTokenError| |
|130024|You are not authorized to perform this action.| |
|130025|CloudInvalidDataStreamError| |
|130026|The URL configured for the backup service is not valid, or the service is currently unavailable.|Verify that you can connect to the internet and that your network settings are correctly configured. Then wait a few minutes and try the operation again. If the issue persists, contact Microsoft Support.|
|130027|CloudXmlSchemaError| |
|130028|DataQueueConnectionStringConfigError| |
|130029|MessageDequeueCountThresholdExceededError| |
|130030|CloudWAQueueAccessError| |
|130031|The maximum message size quota for incoming messages has exceeded the configured value in cbengine.exe.config|To increase the quota, use the `MaxReceivedMessageSize` property on the appropriate binding element.|
|130032|WebExceptionInternalError| |
|130033|CloudTrUnknownExceptionError| |
|130034|CloudServiceFaultExceptionError| |
|130035|CloudInternalFaultExceptionError| |
|130036|InvalidTokenAuthZModeError| |
|130037|CloudWAQueueInitError| |
|130038|InterServiceTokenMissingExpiryField| |
|130039|InvalidInterServiceToken| |
|130040|InterServiceTokenBadSignature| |
|130041|InterServiceTokenExpired| |
|130042|Microsoft Azure Backup encountered an internal error.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|130043|The service encountered an internal error.|Retry the operation after some time has passed. If the issue persists, contact Microsoft Support.|
|130044|CloudOperationBlockedError| |
|130045|CloudTableInternalError| |
|130046|CloudTableConcurrencyError| |
|130047|CloudTableDuplicateEntityError| |
|130048|CloudDosLimitIncorrectDefinition| |
|130049|RandomNumberOutOfRange| |
|130050|Backup failed because your Microsoft Azure subscription has expired.|Renew your Azure subscription to continue backing up successfully.|
|130051|AcsTokenRequestRetryableError| |
|130052|Unable to authenticate as the time on this machine is not synchronized. All operations would fail until this is resolved.|Synchronize the time on your computer so that it is set accurately.|
|130053|Operation is blocked as a limit for certain resources has been reached.|Contact Microsoft Support.|
|130054|Operation is blocked for some time as it has been attempted beyond a limit.|Operation will again be allowed after some time. Retry the operation after some time has passed. Contact Microsoft Support if issue persists.|
|130055|Operation encountered an I/O error.|Operation will again be allowed after some time. Retry the operation after some time has passed. Contact Microsoft Support if issue persists.|
|130056|The role hosting internal endpoint is not configured correctly or hosted endpoint is currently unavailable.|Verify that role and cscfg settings are correctly configured. The operation will be retried by client. If the issue persists, contact engineering team.|
|130057|CloudTableConflictError| |
|130058|The service is temporarily unavailable.|Retry the operation after some time.|
|140001|AcsAddRulesFailureError| |
|140002|AcsCreateCertIdPFailureError| |
|140003|AcsCreateRGFailureError| |
|140004|AcsCreateRPFailureError| |
|140005|AcsDataServiceClientError| |
|140006|AcsDataServiceQueryError| |
|140007|AcsDataServiceRequestError| |
|140008|AcsDeleteCertIdPFailureError| |
|140009|AcsDeleteRulesFailureError| |
|140010|AcsGetRPFailureError| |
|140011|AcsGetRulesFailureError| |
|140012|IdAddMachineInDbFailureError| |
|140013|IdAddUserInDbFailureError| |
|140014|The server name specified is not registered with Microsoft Azure Backup.|Verify that the server name is correct and then try the operation again. If the issue persists, contact Microsoft Support.|
|140015|IdMissingAuthHeaderError| |
|140016|Failed to register the server with the Microsoft Azure Backup.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|140017|IdRegisterMachineInAcsFailureError| |
|140018|Failed to register the user with Microsoft Azure Backup.|Verify that you have specified the correct user ID and password for the operation.|
|140019|IdRegisterUserInAcsFailureError| |
|140020|Failed to unregister the computer with the Microsoft Azure Backup.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|140021|IdUnregisterMachineInAcsFailureError| |
|140022|IdUpdateMachineInDbFailureError| |
|140023|IdInvalidMachineCertificateError| |
|140024|AcsUpdateRPFailureError| |
|140025|AcsDeleteRGFailureError| |
|140026|Unable to renew the activation status of Microsoft Azure Backup for this server.| |
|140027|AcsDataServiceQueryRetryableError| |
|140028|AcsDataServiceRequestRetryableError| |
|140029|AcsDataServiceClientRetryableError| |
|140030|ComponentHasNoSubscription| |
|140031|No valid vault found|Ensure that you have a valid vault, then retry the operation after some time has passed. If the issue persists, contact Microsoft Support.|
|140032|IdMgmtStamp has companies more than the configured warning limit|1. Add more IdMgmt stamps.<br/>2. Increase the limit on the number of companies configured.|
|140033|IdUnregisterUserInAcsFailureError| |
|140034|DoSLimitMachinesPerCompany| |
|140035|MSODSGenericError| |
|140036|MSODSCookieReadError| |
|140037|MSODSNewCookieError| |
|140038|MSODSNonRetryableError| |
|140039|MSODSCertificateError| |
|140040|MSODSGetChangesFailed| |
|140041|MSODSGetDirectoryObjectsFailed| |
|140042|MSODSPublishFailed| |
|140043|MSODSCookieWriteError| |
|140044|IdContainerReRegisterNotAllowedError| |
|140045|BillingTaskInternalError| |
|140046|PushBillingEventsFailed| |
|140047|Invalid certificate uploaded.| |
|140048|Vault cannot be deleted as it contains registered servers|Delete the registered servers and then delete the vault.|
|140049|Could not get the activation Key from ACS|Verify that the vault exists.|
|140050|Could not update the activation key.|Verify that the vault exists.|
|140053|Azure Backup vault is on protected storage model. This billing model is not supported with current version of Microsoft Azure Backup.|Change the billing model of the backup vault to the protected instance, or change to another backup vault that is on the protected instance model.|
|150001|Unable to authorize the specified account.|Verify that you are using the correct account that has been previously registered with the service or contact your service administrator to get the correct credentials.|
|150002|TTInvalidOrgLiveTokenDecryptionError| |
|150003|Unable to authorize the specified account.|Contact your service administrator to validate that the credentials that you are using are correct and configured for Microsoft Azure Backup. If the issue persists, contact Microsoft Support.|
|150004|TTInvalidOrgLiveTokenSignatureError| |
|150005|TTSAMLTokenError| |
|150006|TTOrgLiveTokenPuidMissingError| |
|150007|TTOrgLiveTokenExpiredError| |
|160000|Microsoft Azure Backup encountered an unexpected error.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|160001|CloudStorageResourceNotFound| |
|160002|CloudStorageWriteFailed| |
|160003|CloudStorageResourcePathNotFound| |
|160004|You are not authorized to perform this action.|Make sure that your subscription is valid and is authorized to perform the operation.|
|160005|Microsoft Azure Backup Agent is unable to contact the online data store.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|160006|CloudStorageAccountAuthenticationFailed| |
|160007|CloudStorageAccountNotFound| |
|160008|CloudStorageResourceAlreadyExist| |
|160009|Microsoft Azure Backup encountered an unexpected error.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|160010|The Microsoft Azure Backup is undergoing heavy use and cannot service your request at this time.|Wait a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|160011|Win32OperationFailed| |
|160012|Win32OperationTimeout| |
|160013|CloudStorageTransientError| |
|160014|CloudStorageUnexpectedError| |
|160015|CloudStorageTimeout| |
|160016|VhdVolumeOnlineFailed| |
|160017|MetadataBlockCorrupt| |
|160018|BatCorrupt| |
|160019|AibCorrupt| |
|160020|VhdCorrupt| |
|160021|CatalogObjectNotFound| |
|160022|ReplicaSnapshotNotFound| |
|160023|BlobTypeNotAllocated| |
|160024|The service has detected unexpected entries in metadata that are not consistent with your backed up data.|To resolve these inconsistencies, contact Microsoft support.|
|160025|CloudStorageRequestPreCondtitionFailed| |
|160026|Win32FileNotFound| |
|160027|Win32PathNotFound| |
|160028|InvalidStorageAccountTenantType| |
|160029|TableBeingDeleted| |
|170001|ReplicaAlreadyAllocated| |
|170002|ReplicaNotFound| |
|170003|ReplicaSnapshotAlreadyExists| |
|170004|AddPolicyFailedError| |
|170005|UpdatePolicyFailedError| |
|170006|VhdMergeFailedBlobDeletion| |
|170007|ClearPageRangeFailedPageClearing| |
|170008|GCFailed| |
|170009|StorageAccountResourceNotFound| |
|170010|InsufficientBlobStorageForBackup| |
|170011|StorageAccountResourceIncorrectConfig| |
|170012|TenantAssignmentContentionError| |
|170013|StorageResourceManagerInternalError| |
|170014|NoStorageResourceInValidState| |
|170015|StorageAccountsNotProvisioned| |
|170016|CloudDatasourceSizeComputationFailed| |
|170017|Adding data source failed as you have reached the limit on total number of data sources that can be protected on a single resource.|Contact Microsoft Support.|
|170018|Operation failed as you have reached the limit on total number of snapshots for a single replica.|Contact Microsoft Support.|
|170019|Operation failed as you have reached the limit on total number of replicas for a single data source.|Contact Microsoft Support.|
|170020|Operation failed as you have reached the limit on total number of recoveries for a day.|Contact Microsoft Support.|
|170021|DoSLimitAddPolicyPerDay| |
|170022|DoSLimitDeletePolicyPerDay| |
|170023|DoSLimitUpdatePolicyPerDay| |
|170024|DoSLimitUpdatePassphrasePerDay| |
|170025|DoSLimitGetSASUriPerDay| |
|170026|Unable to save backup policy. Selected items list for Backup is large or selected items have long path names.|Reduce the number of individual items or select complete folders, and then retry the operation.|
|170036|The retention policy xml passed to the protection service is invalid.| |
|180001|The selected recovery point does not exist.|Choose another recovery point.|
|180002|Recovery point is unavailable or corrupt and cannot be used for recovery.|Choose another recovery point.|
|180003|VmLocalStorageFull| |
|180004|VhdMountFailed| |
|180005|VhdBlockIoFailed| |
|180006|SourceFileIoFailed| |
|180008|Access denied to the selected recovery point.|Make sure that you have provided the appropriate credentials and retry the operation.|
|180009|SpecNotFoundInReplicaSnapshot| |
|180010|CopyBlobGenericError| |
|180011|CopyBlobOverwritten| |
|180012|CopyBlobAborted| |
|180013|RecoveryTaskAborted| |
|190001|SqlTransientError| |
|190002|SqlDeadlockError| |
|190003|SqlAzureDatabaseFullError| |
|190004|SqlAuthenticationError| |
|190005|SqlDuplicateDataError| |
|190006|SqlDependentDataError| |
|190007|SqlExcessiveResourceError| |
|190008|SqlUnmappedError| |
|190009|SqlConcurrencyError| |
|190010|SqlDataTruncateError| |
|190011|SqlAzureBusyError| |
|190012|SqlAzureDistributedTransactionError| |
|190013|SqlExceptionError| |
|190014|SqlCmdUnexpectedRowCount| |
|190015|InvalidDBVersion| |
|190016|NoEligibleDbPresentForProv| |
|190017|InvalidFederationDetail| |
|190018|FederationOperationInProgress| |
|190019|InvalidFederationKey| |
|190020|InvalidFederatedMember| |
|190021|NoFederatedMemberPresentForProvisioning| |
|190022|SqlClientFirewallSettingNotConfigured| |
|200001|CatalogCommunicationError| |
|200002|CatalogInternalError| |
|200003|CatalogDuplicateDataError| |
|200004|CatalogConcurrencyError| |
|200005|EntityFrameworkError| |
|200006|CatalogUnauthorizedError| |
|200007|DenormalizedDataNotPresentError| |
|200008|CatalogDBResourceFull| |
|200009|CatalogDBVersionNotSupported| |
|200010|CatalogCriticalUnauthorizedError| |
|210001|Unable to authenticate using the provided credentials.|Ensure that the Microsoft Online Services sign-in assistant program is installed correctly and is running. Then retry the operation.|
|210002|The user ID or password specified is incorrect.|Verify that you have specified the correct user ID and password for the operation. Sign in to the Microsoft Azure Backup portal and verify that your subscription to the Microsoft Azure Backup is active and that the user ID that was specified during server registration has been assigned the Global administrator role. Once the service status and user ID role have been confirmed to be correct, try to register the server again. If the issue persists, contact Microsoft Support.|
|210005|The secret question and secret answer must be changed before you can sign in to this service.|Contact Microsoft support.|
|210006|The primary e-mail address has not been verified for the specified account|Validate the account's primary email address and try the operation again.|
|210007|Your account has been disabled.|Contact Microsoft support.|
|210008|There was an error while contacting the authentication service.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|210009|There was an error while contacting the authentication service.|Verify that you can connect to the internet and that your network settings are correctly configured. Then wait a few minutes and try the operation again.|
|210010|Your account is not activated yet because some additional information for your profile is required.|Contact Microsoft support.|
|210011|Your account is blocked until the sign-in name is changed.|Contact Microsoft support.|
|210012|Microsoft Online Services Sign-On assistant is not installed on server.|Reinstall Microsoft Online Services Sign-On assistant.|
|220001|InvalidResourceDetails| |
|220002|GetResourcesFailed| |
|220003|RefreshResourceLoadCacheFailed| |
|220004|ResourceLoadAddUpdateFailed| |
|220005|AddResourceToTenantFailed| |
|220006|AddResourceToTenantConcurrencyError| |
|220007|GetResourcesForTenantFailed| |
|220008|Microsoft Azure Backup is undergoing maintenance at this time.|Wait for a few minutes. If the issue persists, contact Microsoft Support.|
|220009|NoAvailableResourcesToAllocate| |
|220010|AcquireLockFailed| |
|220011|ReleaseLockFailed| |
|220012|StampDbResourceMisconfiguredError| |
|220013|GetTenantsForResourceFailed| |
|230001|NoEligibleProtectionStampFound| |
|230002|NoEligibleFileCatalogStampFound| |
|230003|SpecifiedStampNotFound| |
|230004|StampProvisioningFailed| |
|230005|MessageForwardingFailed| |
|230006|ResourceNotYetProvisioned| |
|240000|DatasourceAlreadyProtected| |
|240001|DsConfigTooLarge| |
|250000|A new recovery point could not be created as Microsoft Azure Backup Agent has detected data corruption when verifying the new backed up data.|The next backup will attempt to transfer the data again. If the issue persists, contact Microsoft Support.|
|250001|SkylineChecksumMismatch| |
|250002|BlockChecksumMismatch| |
|250003|The operation failed because backup has detected inconsistencies in the backup data.|Contact Microsoft support.|
|250004|The operation failed because backup has detected inconsistencies in the backup metadata.|Retry the operation. If you continue to see this error after retry, then contact Microsoft support.|
|250005|Operation failed as you have reached the limit on total number of Integrity checks for a day.|Contact Microsoft Support.|
|250006|Operation failed as you have reached the limit on total number of full Integrity checks for a day.|Contact Microsoft Support.|
|250007|Operation failed as you have reached the limit on total number of rebuild checksum store for a day.|Contact Microsoft Support.|
|250008|Operation failed as you have reached the limit on total number of rebuild metadata block stream operations for a day.|Contact Microsoft Support.|
|250009|NoMetadataBlocksInReplica| |
|260000|The recovery point requested is corrupt.|Retry the recovery operation using a different recovery point.|
|260001|A recovery point is not available for the requested time parameters.|Retry the recovery operation using a different time parameter. Backups are stored for 30 days by default.|
|260002|A recovery point for the specified server does not exist with the requested time and date parameters.|Retry the operation with either a different time and date parameter or a different server name.|
|260003|Your organization is not currently subscribed to the Microsoft Azure Backup.|Verify that your subscription is up to date and that you have used the correct administrative account. If the problem persists, contact Microsoft support for assistance.|
|260004|Current operation failed because the service has recovered from a serious error.|Reregister the server and then retry the operation.|
|260005|The recovery point specified cannot be found in the list of available recovery points.|Retry the operation by specifying a different recovery point.|
|260006|The recovery point does not contain the component type specified and that component is not supported by backup.|Retry the operation by specifying available and supported component type.|
|260007|The target version where the data is to be recovered cannot be reached from backup version of data.|Contact Microsoft support.|
|260008|The status of the specified task identifier could not be reported because the task is not listed as a valid recovery task.|Specify a valid task identifier to query its status.|
|260009|The requested operation was cancelled because that operation is assigned to a task that is currently in process.|You can use Task Scheduler to view the status of running tasks.|
|260010|The recovery operation requested was not able to be processed due to an internal error condition.|Contact Microsoft support.|
|260011|The recovery operation requested was not able to be processed due to an internal error condition.|Contact Microsoft support.|
|260012|Current operation failed because the service has recovered from a serious error.|Retry the operation.|
|260013|Backup is currently not available for this server.|The service might be installing an update or be in the process of being recovered. Try the operation again after a few minutes. If the problem persists, contact Microsoft Support.|
|260014|Current backup operations have been paused because the backup service has recovered from a serious error. As a result of this recovery, backup settings might have been modified.|Review and verify that the backup settings are correct. Once you have saved the backup schedule, backup operations will resume according to your schedule. If a problem persists, contact Microsoft Support.|
|260015|Specified DR recovery drill option string and version are not correctly formatted.|Review and specify the recovery drill optional in SQL Server connection string format.|
|260016|One or more backup blobs referenced from metadata state are not found in Blob Store.|Select another valid recovery point to recover data from (possibly latest), otherwise contact Microsoft Support.|
|260017|Target DB schema is not supported for the current version of the service.|Verify that the service upgrade has completed successfully. If issue persists, report this error to Product Group.|
|260018|Target DB schema version is not compatible for the current version of the service.|Validate that the service upgrade has completed successfully. If issue persists, report this error to the Product Group.|
|260019|Previously triggered pruning task is in progress, skipped current task trigger.|If issue persists, report this error to the Product Group.|
|260020|Pruning task triggered is within the expected next task trigger frequency. This task will be skipped.|If issue persists, report this error to the Product Group.|
|260021|BCDR pruning task aborted for a component type.|If issue persists, report this error to the Product Group.|
|260022|Current operation failed because the service has recovered from a serious error.|Retrigger the recovery.|
|260023|Current operation failed because the service has recovered from a serious error.|Retrigger the recovery.|
|260024|Backup service is under maintenance, the operation will not complete now.|After some time has passed, retry the operation. If the problem persists, contact Microsoft support for assistance.|
|260025|Current operation failed because the service has recovered from a serious error.|After some time, try registering the computer to the backup vault. If problem persists, create a new backup vault and register the computer under it.|
|270000|CloudAsyncInternalError| |
|270001|CloudAsyncWorkAlreadySubmitted| |
|270002|CloudAsyncWorkLimitReached| |
|270003|CloudAsyncWorkNoProgress| |
|270004|CloudAsyncWorkStatusIncompatibleSchema| |
|270005|CloudAsyncWorkSubmitted| |
|270006|CloudAsyncWorkNotComplete| |
|270007|WAStorageDataServiceQueryRetryableError| |
|270008|WAStorageDataServiceRequestRetryableError| |
|270009|WAStorageDataServiceClientRetryableError| |
|270010|WAStorageDataServiceQueryError| |
|270011|WAStorageDataServiceRequestError| |
|270012|WAStorageDataServiceClientError| |
|280001|The proxy server address specified is not a valid URI.| |
|280002|The proxy port specified should be a number between 1 and 65535.| |
|280003|A user ID has not been specified to use for proxy server authentication.| |
|280004|A password has not been specified to use for proxy server authentication.| |
|280005|The bandwidth usage for network throttling must be between 512 Kbps and 1023 Mbps.| |
|280006|You must select at least one working day to apply network throttling settings.| |
|280007|The start and end work hours specified for network throttling settings are the same.|Choose different start and end work hours.|
|280008|The configuration settings for this server were not able to be saved at this time.|Retry the operation.|
|280009|The configuration settings for this server were not able to be retrieved at this time.|Retry the operation.|
|280010|If the proxy server requires authentication, specify user ID and password.| |
|280011|Microsoft Azure Backup Agent could not connect to the proxy server.|Verify that the server settings and the proxy server address are correct.|
|290001|InvalidStampDetailsInMsgForwarderDb| |
|290002|MsgForwardingFailed| |
|290003|NoStampFoundForTenant| |
|300001|The deployment operation triggered has failed.|Look at the exception thrown and fix that. If the information is not enough to diagnose, contact Microsoft Support.|
|300002|Required environment setting was not found in the environment file.|Verify that the environment setting mentioned in the error message is present in the environment file. You can use the `GetADStorage` environment management cmdlet to examine the environment file.|
|300003|Resource entry with the given friendly name was not found in the environment file.|Verify that the resource with the friendly name mentioned in the error message is present in the environment file. You can use the `GetADStorage` environment management cmdlet to examine the environment file.|
|300004|Plugin assembly could not be loaded.|Verify that the DLL path and the type name mentioned in the config file is correct.|
|300005|The certificate present in environment file is invalid.|The certificate information present in the environment file must represent a valid certificate. The cert data stored in the environment file or pre-requisite file must be the Base64 string form of the cert body. The password must be correct for the certificate. If you are pushing a pre-requisite file to a secret store, make sure it is preprocessed (by using `Set-ADStorage` without the `-OverWrite` flag). If you are committing a pre-requisite file or environment file, you must fix the issue. If you are reading the environment file, you can download the non-decrypted environment file, fix the issue, commit it to storage, and then do the read operation|
|300006|The secret store environment name given is not found or not supported|Make sure that the secret store environment name is correct. If the secret store environment name is correct, contact PG to check that the given environment is supported by the Recovery services Deployment Infrastructure.|
|300007|The Secret Store was not able to connect to its end point|Check that the secret store's environment name and endpoint are correct. Make sure that the secret store service is running.|
|300008|The Secret Store operation failed|Look at the inner exception message for the reason for the failure.|
|300009|Reading deployment storage key from secret store failed|The `DeploymentStorageSSKey` should be a valid secret store key. Make sure that the deployment storage connection string is present in the secret store environment passed and the user executing the action should have the access to the key|
|300010|The deployment storage account connection string stored in secret store an invalid connection string|Make sure that the `DeploymentStorageSSKey` holds a valid connection string value of a storage account|
|300011|The secret store certificate not found in environment file or pre-requisite file under FriendlyName EncryptionCertificate|The secret store certificate must be present in environment file or pre-requisite file with the FriendlyName EncryptionCertificate.|
|300012|Invalid name of the secret store prefix. The prefix should follow the naming convention presented at this link|Make sure that the prefix does not contain back slash. Use forward slash instead. The secret store prefix will be part of the prefix of the secret keys generated by deployment infrastructure.|
|300013|Deployment configuration for the requested service is not found.|Make sure that the deployment target folder is complete and contains \Configs\DeploymentConfigs folder. The service's deployment configuration file should be present there.|
|300014|The stamp has one or more invalid settings.|If the settings in the environment file are valid, verify that the type name and dll of the setting processors are correctly mentioned in the deployment config. Also verify that the validation logic appropriately validates the invalidated settings.|
|300015|No resource DB resources found in storage account that can be committed to storage account.|Make sure you are providing the correct settings file (Add mode or Update(s) mode). If there are no resources provisioned, this is expected as there are no lying resource in storage account to be committed to service|
|300016|The Prereq file was evaluated as invalid.|Go through the error traces to identify which settings or resources were invalidated and the reasons for the same.|
|300017|Datacenter for provisioning action for the given stamp is not matching with the datacenter with which deployment context is initialized|If you are running on the PowerShell environment, make sure that SetEnvironment.ps was run for the same datacenter for which provisioning is being done.|
|300018|Executing the SQL query failed|Make sure the connection of the SQL DB is correct and the script file is correct. Look at the inner exception for more details|
|300019|Setting creation failed during deployment resource provisioning|Setting creation failed during resource provisioning. Look at the inner exception for more details|
|300020|Database creation encountered an error|Verify that the credentials are valid. Look at the inner exception for more details|
|300021|The specified stamp name was not found in the environment file|Verify that the stamp is present in the environment file or that you have mentioned the correct stamp name|
|300022|Azure Management REST API failed.|Examine the status code and the message to understand and mitigate the issue.|
|300023|The certificate cannot be installed because it is being used by another process.|Retry the operation.|
|310001|AzureResourceNotFound| |
|310002|AzureAuthenticationFailed| |
|310003|AzureInternalError| |
|310004|AzureOperationTimedOut| |
|310005|AzureBusy| |
|310006|AzureSubscriptionDisabled| |
|310007|AzureOperationConflict| |
|310008|AzureOperationFailed| |
|320001|ResourceNotFound| |
|320002|The request maps to an unexpected service stamp type <_StampType_>| |
|330001|ProviderNotRegistered| |
|330002|ProviderRegisteredIncorrectly| |
|340001| <_ParameterName_> is invalid.|Provide a valid <*ParameterName*>.|
|340002|The REST API call encountered an internal error.|Wait for a few minutes and then try the operation again. If the issue persists, contact Microsoft Support.|
|340003|RestApiClientError| |
|480001|Mounting the disk failed| |
|480002|Unexpected error encountered during recovery.| |
|480003|Recovery point corrupt.| |
|480004|Blob is missing.| |
|480005|Specific index is missing.| |
|480006|Recovery point is in a format that is not supported by current agent.| |
|480007|Recovery volume could not be mounted as Azure Backup could not connect to the iSCSI initiator service on this server.|Restart Microsoft iSCSI initiator Service on this server and try recovering again.|
|480008|Previous snapshot of the blob was not found.| |
|480010|Recovery volume could not be mounted as Azure Backup could not use the iSCSI initiator service which is disabled on this server.|Enable the Microsoft iSCSI initiator Service on this server and try recovering again.|
|480011|Azure Backup could not mount the recovery volume as it has detected that drivers for Microsoft iSCSI Initiator require an update.|Update the Microsoft iSCSI Initiator drivers by going to **Device Manager** > **Storage Controllers** and updating drivers for any entry listed as **Unknown Device**. For more information, see [Restore files to Windows Server using the MARS Agent](/azure/backup/backup-azure-restore-windows-server).|
