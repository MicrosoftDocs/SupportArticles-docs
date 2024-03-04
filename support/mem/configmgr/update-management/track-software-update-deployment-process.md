---
title: Track the software update deployment process
description: Describes how to track the deployment of software updates in System Center 2012 Configuration Manager by using log files.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Track the software update deployment process in Configuration Manager

This article describes how to track the deployment of software updates in Configuration Manager by using log files.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3090265

## Summary

When you deploy software updates in Configuration Manager, you typically add the updates to a software update group and then deploy the software update group to clients. When you create the deployment, the update policy is sent to client computers. And the update content files are downloaded from a distribution point to the local cache on the client computer. The updates are then available for installation on the client. In the following section, we examine this process in detail and show how the process can be tracked by using log files. This information may be helpful when you're trying to identify and resolve problems in the software update process.

For more information about software updates in Configuration Manager, see [Software updates introduction](software-updates-introduction.md).

> [!NOTE]
> The log snippets provided in this article apply to Configuration Manager 2012 and 2012 R2. Log entries for other Configuration Manager versions may be different.

## Create a software update group

When you create a software update group in the Configuration Manager console, an instance of the `SMS_AuthorizationList` class is created. This instance contains information about the software update group, and it has relationships with the software updates in the software update group.

The following are logged in SMSProv.log:

```output
CSspClassManager::PreCallAction, dbname=CM_PS1    SMS Provider  
PutInstanceAsync SMS_AuthorizationList       SMS Provider  
CExtProviderClassObject::DoPutInstanceInstance    SMS Provider  
Updating SDM content definition.   SMS Provider  
Try to sync permission table : Declare @Ids RBAC_Object_Type;insert into @Ids (ObjectKey, ObjectTypeID) values (N'ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_9D013E6D-EF76-43F6-ACC4-80749AB8D90A',34);exec spRBAC_SyncPermissions @ObjectIds=@Ids,@RoleIDs=N'',@AdminIDs=N''     SMS Provider  
Successfully synced permission table              SMS Provider  
Auditing: User CONTOSO\Admin created an instance of class SMS_AuthorizationList.    SMS Provider
```

As part of the software update group creation process, SMSProv inserts data in appropriate CI_ tables, including:

- CI_ConfigurationItems
- CI_ConfigurationItemRelations
- CI_ConfigurationItemRElations_Flat
- CI_DocumentStore
- CI_CIDocuments
- CI_LocalizedProperties

SMSDBMON monitors when data is inserted into these tables and drops CI Notification (CIN) files in objmgr.box. The following are logged in SMSDBMon.log:

```output
RCV: INSERT on CI_ConfigurationItems for CINotify_iud [16777264 ][60216]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: UPDATE on CI_ConfigurationItems for CINotify_iud [16777264 ][60217]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on CI_ConfigurationItemRelations_Flat for CI_ConfigurationItemRelations_Flat_From_iud [16777264 ][60218] SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on CI_ConfigurationItemRelations_Flat for CI_ConfigurationItemRelations_Flat_From_iud [16777264 ][60219] SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on CI_ConfigurationItemRelations_Flat for CI_ConfigurationItemRelations_Flat_From_iud [16777264 ][60220] SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on CI_ConfigurationItemRelations_Flat for CI_ConfigurationItemRelations_Flat_From_iud [16777264 ][60221] SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on CI_ConfigurationItemRelations_Flat for CI_ConfigurationItemRelations_Flat_From_iud [16777264 ][60222] SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on CI_ConfigurationItemRelations_Flat for CI_ConfigurationItemRelations_Flat_From_iud [16777264 ][60223] SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: UPDATE on CI_ConfigurationItems for CINotify_iud [16777264 ][60224]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: UPDATE on CI_ConfigurationItems for CINotify_iud [16777264 ][60225]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on RBAC_ChangeNotification for Rbac_Sync_ChangeNotification [363 ][60226] SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\objmgr.box\16777264.CIN [60225]    SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\hman.box\363.RBC [60226]    SMS_DATABASE_NOTIFICATION_MONITOR
```

Object Replication Manager wakes up when files are dropped in objmgr.box and processes the software update group. The following are logged in ObjReplMgr.log:

```output
File notification triggered.      SMS_OBJECT_REPLICATION_MANAGER  
+++Begin processing changed CIN objects      SMS_OBJECT_REPLICATION_MANAGER  
***** Processing AuthorizationList ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_9D013E6D-EF76-43F6-ACC4- 80749AB8D90A *****   SMS_OBJECT_REPLICATION_MANAGER  
Deleting notification file E:\ConfigMgr\inboxes\objmgr.box\16777264.CIN           SMS_OBJECT_REPLICATION_MANAGER  
+++Begin collecting targeting information for Affected CIs   SMS_OBJECT_REPLICATION_MANAGER  
+++Completed collecting targeting information for Affected CIs               SMS_OBJECT_REPLICATION_MANAGER  
Affected CIs (1): 16777264            SMS_OBJECT_REPLICATION_MANAGER  
CI 16777264 is NOT Targeted         SMS_OBJECT_REPLICATION_MANAGER  
Successfully processed AuthorizationList ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_9D013E6D-EF76-43F6-ACC4-80749AB8D90A   SMS_OBJECT_REPLICATION_MANAGER  
Set last row version for Configuration Item to 0x0000000000296047     SMS_OBJECT_REPLICATION_MANAGER
```

The changes to the CI_* tables are then replicated to the child sites through database replication. This operation allows the software update group to show up on the child site.

Software update groups are configuration items (CIs) themselves, and the CI **Type ID** for software update groups is **9**. You can view the software update groups by running the following SQL query:

```sql
SELECT * FROM vSMS_ConfigurationItems WHERE CIType_ID = 9
```

To see the relationships from a software update group CI to the software update CIs, run the following SQL query:

```sql
SELECT CIR.* FROM CI_ConfigurationItemRelations CIR
JOIN CI_ConfigurationItems CI ON CIR.FromCI_ID = CI.CI_ID
WHERE CI.CIType_ID = 9
```

## Manually create a deployment for software update group

When a deployment for a software update group is created, an instance of the `SMS_UpdateGroupAssignment` class is created. The instance contains information about the deployment. The following are logged in SMSProv.log:

```output
PutInstanceAsync SMS_UpdateGroupAssignment       SMS Provider  
CExtProviderClassObject::DoPutInstanceInstance        SMS Provider  
Auditing: User CONTOSO\Admin created an instance of class SMS_UpdateGroupAssignment.    SMS Provider
```

Updates are then downloaded to the specified package source directory by the Software Updates Patch Downloader component. The following are logged in PatchDownloader.log in %TEMP% directory:

```output
Trying to connect to the root\SMS namespace on the PS1SITE.CONTOSO.COM machine. Software Updates Patch Downloader  
Connected to \\PS1SITE.CONTOSO.COM\root\SMS      Software Updates Patch Downloader  
Trying to connect to the \\\PS1SITE.CONTOSO.COM\root\sms\site_PS1 namespace on the PS1SITE.CONTOSO.COM machine.     Software Updates Patch Downloader  
Connected to \\PS1SITE.CONTOSO.COM\root\sms\site_PS1     Software Updates Patch Downloader  
Download destination = \\PS1SITE\SOURCE\Updates\Win7\d09e9a92-20e7-455a-a51b-aaeca7b7d7e1.1\windows6.1-kb2807986-x86.cab .       Software Updates Patch Downloader  
Contentsource = http://wsus.ds.download.windowsupdate.com/msdownload/update/software/secu/2013/02/windows6.1-kb2807986-x86_83d5bb38d8c50d924f3dcd024b20fe33afbd9d14.cab.      Software Updates Patch Downloader  
Downloading content for ContentID = 471, FileName = windows6.1-kb2807986-x86.cab.     Software Updates Patch Downloader  
Download http://wsus.ds.download.windowsupdate.com/msdownload/update/software/secu/2013/02/windows6.1-kb2807986-x86_83d5bb38d8c50d924f3dcd024b20fe33afbd9d14.cab to C:\Users\Admin\AppData\Local\Temp\2\CABBA79.tmp returns 0       Software Updates Patch Downloader  
Successfully moved C:\Users\Admin\AppData\Local\Temp\2\CABBA79.tmp to \\PS1SITE\SOURCE\Updates\Win7\d09e9a92-20e7- 455a-a51b-aaeca7b7d7e1.1\windows6.1-kb2807986-x86.cab       Software Updates Patch Downloader  
Renaming \\PS1SITE\SOURCE\Updates\Win7\d09e9a92-20e7-455a-a51b-aaeca7b7d7e1.1 to \\\PS1SITE\SOURCE\Updates\Win7\d09e9a92-20e7-455a-a51b-aaeca7b7d7e1      Software Updates Patch Downloader  
Successfully moved \\PS1SITE\SOURCE\Updates\Win7\d09e9a92-20e7-455a-a51b-aaeca7b7d7e1.1 to \\PS1SITE\SOURCE\Updates\Win7\d09e9a92-20e7-455a-a51b-aaeca7b7d7e1      Software Updates Patch Downloader
```

After the updates are downloaded, SMS Provider adds each update to the specified package. The following are logged in SMSProv.log:

```output
Requested class =SMS_SoftwareUpdatesPackage    SMS Provider  
Requested num keys =1    SMS Provider  
CExtProviderClassObject::DoExecuteMethod AddUpdateContent    SMS Provider  
*** SspPackageInst::AddUpdateContent ***    SMS Provider  
CObjectLock::UserHasLock: ********** User CONTOSO\Admin has lock for object SMS_SoftwareUpdatesPackage.PackageID="PS100001" with LockID: DCE6F1B5-1EE8-47CB-85A7-3027E51119A7 **********     SMS Provider  
CObjectLock::ReleaseLock: ********** User CONTOSO\Admin has released lock for object SMS_SoftwareUpdatesPackage.PackageID="PS100001" with LockID: DCE6F1B5-1EE8-47CB-85A7-3027E51119A7 **********     SMS Provider  
SspPackageInst::AddContent() called for these ContentIDs - {471}    SMS Provider  
SspPackageInst::AddContent() called with these CIContentSourcePath - {"\\PS1SITE\SOURCE\Updates\Win7"}    SMS Provider  
RefreshDPs value is FALSE. DP(s) will not be updated at the end of the operation    SMS Provider  
These Contents will be added to Software Updates Package - PS100001 with PackageSource - \\PS1SITE\SOURCE\Updates\Win7    SMS Provider  
Adding Content with ID 471, UniqueID d09e9a92-20e7-455a-a51b-aaeca7b7d7e1 and ContentSource \\PS1SITE\SOURCE\Updates\Win7 to the Package    SMS Provider  
ContentFileName = windows6.1-kb2807986-x86.cab, SourceURL = http://wsus.ds.download.windowsupdate.com/msdownload/update/software/secu/2013/02/windows6.1-kb2807986- x86_83d5bb38d8c50d924f3dcd024b20fe33afbd9d14.cab, ImportPath = , ContentFileHash = SHA1:83D5BB38D8C50D924F3DCD024B20FE33AFBD9D14      SMS Provider  
File Source = \\PS1SITE\SOURCE\Updates\Win7\d09e9a92-20e7-455a-a51b-aaeca7b7d7e1\windows6.1-kb2807986-x86.cab    SMS Provider  
File Destination = \\PS1SITE\SOURCE\Updates\Win7\d09e9a92-20e7-455a-a51b-aaeca7b7d7e1     SMS Provider  
CExtUserContext::LeaveThread : Releasing IWbemContextPtr=57376560      SMS Provider
```

After all the updates are added to the package, SMS Provider updates the package and logs the following entries:

```output
CExtUserContext::EnterThread : User=CONTOSO\Admin Sid=0x01050000000000051500000068830AA65AAB72A155BCE9324F040000 Caching IWbemContextPtr=00000000036B7E50 in
Process 0xc68 (3176)    SMS Provider  
Context: SMSAppName=Configuration Manager Administrator console    SMS Provider  
Context: MachineName=PS1SITE.CONTOSO.COM    SMS Provider  
Context: UserName=CONTOSO\Admin    SMS Provider  
Context: ObjectLockContext=c00c315d-b15d-4b0e-9844-017205cc2443    SMS Provider  
Context: ApplicationName=Microsoft.ConfigurationManagement.exe    SMS Provider  
Context: ApplicationVersion=5.0.7958.1000     SMS Provider  
Context: LocaleID=MS\0x409    SMS Provider  
Context: __ProviderArchitecture=32      SMS Provider  
Context: __RequiredArchitecture=0 (Bool)      SMS Provider  
Context: __ClientPreferredLanguages=en-US,en    SMS Provider  
Context:  __GroupOperationId=755382    SMS Provider  
Context:  __WBEM_CLIENT_AUTHENTICATION_LEVEL=6    SMS Provider  
CExtUserContext : Set ThreadLocaleID OK to: 1033    SMS Provider  
CSspClassManager::PreCallAction, dbname=CM_PS1 SMS Provider  
ExecMethodAsync : SMS_SoftwareUpdatesPackage.PackageID="PS100001"::RefreshPkgSource    SMS Provider  
Requested class =SMS_SoftwareUpdatesPackage    SMS Provider  
Requested num keys =1    SMS Provider  
CExtProviderClassObject::DoExecuteMethod RefreshPkgSource    SMS Provider  
Auditing: User CONTOSO\Admin called an audited method of an instance of class SMS_SoftwareUpdatesPackage.     SMS Provider  
CExtUserContext::LeaveThread : Releasing IWbemContextPtr=57376336    SMS Provider
```

When the update group assignment is created, SMS Provider inserts information about the assignment in the `CI_Assignments` table. This triggers SMSDBMON, which notifies Object Replication Manager to process the update group assignment by dropping a .CIA file in objmgr.box. The following are logged in SMSDBMON.log:

```output
RCV: INSERT on CI_CIAssignments for CIAssignmentNotify_iu [16777222 ][60916]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on CrpChange_Notify for CrpChange_Notify_ins [14 ][60917]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: UPDATE on CI_CIAssignments for CIAssignmentNotify_iu [16777222 ][60920]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: UPDATE on CI_AssignmentTargetedCIs for CI_AssignmentTargetedCIs_CIAMGR [16777222 ][60921] SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: UPDATE on CI_CIAssignments for CIAssignmentNotify_iu [16777222 ][60923]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: UPDATE on CI_AssignmentTargetedCIs for CI_AssignmentTargetedCIs_CIAMGR [16777222 ][60924] SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: UPDATE on CI_CIAssignments for CIAssignmentNotify_iu [16777222 ][60926]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: UPDATE on CI_AssignmentTargetedCIs for CI_AssignmentTargetedCIs_CIAMGR [16777222 ][60927] SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\objmgr.box\16777222.CIA [60916]    SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\policypv.box\policytargeteval\14.CRP [60917]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on PolicyAssignmentChg_Notify for PolicyAssignmentChg_Notify_iu [16786995 ][60929] SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\policypv.box\policytargeteval\16786995.PAC [60929] SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on PkgNotification for PkgNotify_Add [PS100001 ][60930]     SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\distmgr.box\PS100001.PKN [60930]      SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on PolicyAssignmentChg_Notify for PolicyAssignmentChg_Notify_iu [16786995 ][60931] SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: UPDATE on PolicyAssignmentChg_Notify for PolicyAssignmentChg_Notify_iu [16786995 ][60932] SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\policypv.box\policytargeteval\16786995.PAC [60931] SMS_DATABASE_NOTIFICATION_MONITOR
```

After Object Replication Manager detects the CIA file in objmgr.box, it processes the file and creates the policy for the software update assignment. The following are logged in ObjMgr.log:

```output
File notification triggered.    SMS_OBJECT_REPLICATION_MANAGER  
+++Begin processing changed CIA objects    SMS_OBJECT_REPLICATION_MANAGER  
***** Processing Update Group Assignment {3ACE84D4-7B2A-4D86-81AF-07E2AC255745} *****   SMS_OBJECT_REPLICATION_MANAGER  
Deleting notification file E:\ConfigMgr\inboxes\objmgr.box\16777222.CIA    SMS_OBJECT_REPLICATION_MANAGER  
CI Assignment {3ACE84D4-7B2A-4D86-81AF-07E2AC255745} has 3 Targeted CI(s)    SMS_OBJECT_REPLICATION_MANAGER  
PolicyID {3ACE84D4-7B2A-4D86-81AF-07E2AC255745} PolicyVersion 1.00 PolicyHash SHA256:63BAFA808F969849B40B2B727B49BC5093B965782716DDE3490528681CF27ACC     SMS_OBJECT_REPLICATION_MANAGER  
Notifying policy provider about changes in policy content/targeting    SMS_OBJECT_REPLICATION_MANAGER  
Successfully created policy for CI Assignment {3ACE84D4-7B2A-4D86-81AF-07E2AC255745}    SMS_OBJECT_REPLICATION_MANAGER  
Notifying policy provider about changes in policy content/targeting    SMS_OBJECT_REPLICATION_MANAGER  
Successfully updated Policy Targeting for CI Assignment {3ACE84D4-7B2A-4D86-81AF-07E2AC255745}   SMS_OBJECT_REPLICATION_MANAGER  
No file trigger for E:\ConfigMgr\inboxes\objmgr.box\16777222.CIV - status 2    SMS_OBJECT_REPLICATION_MANAGER  
Assigned CIs: [ 16777264 ]    SMS_OBJECT_REPLICATION_MANAGER  
Begin processing Assigned CI: [16777264]    SMS_OBJECT_REPLICATION_MANAGER  
Creating VersionInfo policy for CI 16777264   SMS_OBJECT_REPLICATION_MANAGER  
Creating VersionInfo policy ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_9D013E6D-EF76-43F6-ACC4- 80749AB8D90A/VI    SMS_OBJECT_REPLICATION_MANAGER  
16777264 Referenced CIs: [ 929 930 1041 1042 1132 1133 ]    SMS_OBJECT_REPLICATION_MANAGER  
VersionInfo policy for CI 16777264 is Machine type    SMS_OBJECT_REPLICATION_MANAGER  
PolicyID ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_9D013E6D-EF76-43F6-ACC4-80749AB8D90A/VI PolicyVersion 1.00 PolicyHash SHA256:6EFE96F3D67773CA965EC67EC60B602FC78242509A096FCF44C2D5FDD5B2FC76     SMS_OBJECT_REPLICATION_MANAGER  
Notifying policy provider about changes in policy content/targeting    SMS_OBJECT_REPLICATION_MANAGER  
Updated dependent policy references to CIA {3ACE84D4-7B2A-4D86-81AF-07E2AC255745}     SMS_OBJECT_REPLICATION_MANAGER  
STATMSG: ID=5800 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_OBJECT_REPLICATION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5404 TID=3380 GMTDATE=Thu Jan 23 20:31:38.889 2014 ISTR0="Microsoft Software Updates - 2014-01-23 03:30:52 PM" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=414 AVAL0="{3ACE84D4-7B2A-4D86-81AF-07E2AC255745}"    SMS_OBJECT_REPLICATION_MANAGER  
Successfully updated CRCs for CI Assignment {3ACE84D4-7B2A-4D86-81AF-07E2AC255745}      SMS_OBJECT_REPLICATION_MANAGER  
Successfully processed Update Group Assignment {3ACE84D4-7B2A-4D86-81AF-07E2AC255745}     SMS_OBJECT_REPLICATION_MANAGER  
Set last row version for CI Assignment to 0x0000000000296628             SMS_OBJECT_REPLICATION_MANAGER
```

After being notified by the Object Replication Manager, Policy Provider updates the policy for the clients. The following are logged in PolicyPv.log:

```output
File notification triggered.    SMS_POLICY_PROVIDER  
Found 14.CRP    SMS_POLICY_PROVIDER  
Adding to delete list: E:\ConfigMgr\inboxes\policypv.box\policytargeteval\14.CRP    SMS_POLICY_PROVIDER  
Processing any pending PolicyAssignmentChg_Notify   SMS_POLICY_PROVIDER  
Updating ResPolicyMap    SMS_POLICY_PROVIDER  
Policy or Policy Target Change Event triggered.    SMS_POLICY_PROVIDER  
File notification triggered.    SMS_POLICY_PROVIDER  
Building Collection Change List from Collection Member Notification files    SMS_POLICY_PROVIDER

--Handle PolicyAssignment Resigning    SMS_POLICY_PROVIDER  
Completed batch with beginning PADBID = 16786995 ending PADBID = 16786996.    SMS_POLICY_PROVIDER

--Process Policy Changes    SMS_POLICY_PROVIDER  
Found some Policy changes, returning New LastRowversion=0x000000000029662B    SMS_POLICY_PROVIDER  
Processing Updated Policies    SMS_POLICY_PROVIDER  
Building Collection Change List from New and Targeting Changed Policies    SMS_POLICY_PROVIDER

--Update Policy Targeting Map    SMS_POLICY_PROVIDER  
**** Evaluating Collection 14 for targeting changes ****    SMS_POLICY_PROVIDER  
Advanced client policy changes detected for collection 14, ** 5 Added & 0 Deleted ***.     SMS_POLICY_PROVIDER

--Process Policy Targeting Map    SMS_POLICY_PROVIDER  
**** Process notification table to update resultant targeting table ****    SMS_POLICY_PROVIDER
```

SQL Server Profiler covering the entire process displays the following entries:

```output
insert into CI_CIAssignments (AssignmentAction, Description, AssignmentName, DesiredConfigType, DisableMomAlerts, DPLocality, AssignmentEnabled, EnforcementDeadline, EvaluationSchedule, ExpirationTime, LimitStateMessageVerbosity, LogComplianceToWinEvent, NonComplianceCriticality, NotifyUser, OverrideServiceWindows, PersistOnWriteFilterDevices, RaiseMomAlertsOnFailure, RandomizationEnabled, RebootOutsideOfServiceWindows, SendDetailedNonComplianceStatus, StartTime, StateMessagePriority, StateMessageVerbosity, SuppressReboot, UseBranchCache, UseGMTTimes, UserUIExperience, WoLEnabled, TargetCollectionID, LocaleID, Assignment_UniqueID, SourceSite, LastModifiedBy, AssignmentType, CreationTime, LastModificationTime, IsTombstoned) values (2, N'', N'Microsoft Software Updates - 2014-01-23 03:30:52 PM', 1, 0, 16, 1,
'01/30/2014 15:30:00', null, null, 1, 0, null, 1, 0, 1, 0, null, 0, 0, '01/23/2014 15:31:00', 5, 5, 0, 1, 0, 1, 0, 14, 1033, N'{3ACE84D4-7B2A-
4D86-81AF-07E2AC255745}', N'PS1', N'CONTOSO\Admin', 5, '01/23/2014 20:31:31', '01/23/2014 20:31:31', 0)

insert into CI_AssignmentTargetedGroups (CI_ID, AssignmentID) values (16777264, 16777222)

insert into CI_ContentPackages (Content_ID, ContentSubFolder, ContentVersion, Content_UniqueID, MinPackageVersion,PkgID) VALUES ('471', N'd09e9a92-20e7-455a-a51b-aaeca7b7d7e1', '1', N'd09e9a92-20e7-455a-a51b-aaeca7b7d7e1', '0', N'PS100001')

insert Policy(Version, PolicyHash, PolicyFlags, PolicyPriority, DeviceVersion, PolicyID)
values(N'1.00', N'SHA256:63BAFA808F969849B40B2B727B49BC5093B965782716DDE3490528681CF27ACC', 16592, 25, N'''', N'{3ACE84D4-7B2A-4D86-81AF-07E2AC255745}')

insert PolicyAssignment(PolicyAssignmentID, PADBID, Version, PolicyID, IsTombstoned, LastUpdateTime)
values(N'{8d9ba949-d038-4c09-a0cc-af3f07c39d71}', 16786995, N'1.00', N'{3ACE84D4-7B2A-4D86-81AF-07E2AC255745}', 0,
GetUTCDate())

DECLARE @AssignedCIs TABLE(CI_ID INT)  
BEGIN  
INSERT INTO @AssignedCIs  
SELECT DISTINCT ATG.CI_ID FROM CI_AssignmentTargetedGroups ATG  
INNER JOIN vCI_CIAssignments CIA ON CIA.AssignmentID = ATG.AssignmentID  
WHERE CIA.Assignment_UniqueID = '{3ACE84D4-7B2A-4D86-81AF-07E2AC255745}'  
IF @@ROWCOUNT = 0  
BEGIN  
INSERT INTO @AssignedCIs  
SELECT DISTINCT ATCI.CI_ID FROM vCI_AssignmentTargetedCIs_Actual ATCI  
INNER JOIN vCI_CIAssignments CIA ON CIA.AssignmentID = ATCI.AssignmentID  
WHERE CIA.Assignment_UniqueID = '{3ACE84D4-7B2A-4D86-81AF-07E2AC255745}'  
END  
END  
SELECT DISTINCT CI_ID FROM @AssignedCIs

insert Policy(Version, PolicyHash, PolicyFlags, PolicyPriority, DeviceVersion, PolicyID)
values(N'1.00', N'SHA256:6EFE96F3D67773CA965EC67EC60B602FC78242509A096FCF44C2D5FDD5B2FC76', 208, 25, N'''', N'ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_9D013E6D-EF76-43F6-ACC4-80749AB8D90A/VI')

UPDATE Policy SET DeviceBody = NULL where PolicyID='ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_9D013E6D- EF76-43F6-ACC4-80749AB8D90A/VI'

insert PolicyAssignment(PolicyAssignmentID, PADBID, Version, PolicyID, IsTombstoned, LastUpdateTime) values(N'{64ed94a2-ff08-42a7-9e42-b292409c79e8}', 16786996, N'1.00', N'ScopeId_FC8FCC38-4BB1-4245-92F5- 9CE841775019/AuthList_9D013E6D-EF76-43F6-ACC4-80749AB8D90A/VI', 0, GetUTCDate())

insert CI_AssignmentCRCs (AssignmentID, AssignmentCRC, PolicyCRC, ComplianceCRC) values (16777222, N'7a2e8acd', N'c10ba7c5', N'5aeb49f4')

insert into CI_ContentPackages (Content_ID, ContentSubFolder, ContentVersion, Content_UniqueID, MinPackageVersion,PkgID) VALUES ('534', N'de62f3b3-615b-4800-b6ba-51d7c826dd08', '1', N'de62f3b3-615b-4800-b6ba-51d7c826dd08', '0', N'PS100001')
```

## Create a deployment by using an automatic deployment rule

Automatic deployment rule (ADR) execution is triggered manually, per a schedule or after software update synchronization is completed. The Rule Engine component evaluates the rule. If any software updates match the defined criteria, the Rule Engine will:

- download the updates
- create a software update group
- create a software update group assignment

The following example shows the process of software update group and deployment creation:

RuleEngine.log shows beginning of rule processing:

```output
Found notification file E:\ConfigMgr\inboxes\RuleEngine.box\1.RUL   SMS_RULE_ENGINE  
RuleSchedulerThred: Change in Rules Object Signalled.   SMS_RULE_ENGINE  
Constructing Rule 1 using Auto Deployment Rule Factory  SMS_RULE_ENGINE  
Populating Rule Skeleton            SMS_RULE_ENGINE  
Populating Criterion Skeleton       SMS_RULE_ENGINE  
Populating Action Skeleton          SMS_RULE_ENGINE  
Populating Action Skeleton          SMS_RULE_ENGINE  
CRuleHandler: Need to Process 1 rules           SMS_RULE_ENGINE
```

RuleEngine.log shows rule processing and query to run to find updates that match the defined criteria:

```output
CRuleHandler: Processing Rule with ID:1, Name:ADR_Test.    SMS_RULE_ENGINE  
Evaluating Update Criteria for AutoDeployment Rule 1    SMS_RULE_ENGINE  
Evaluating Update Criteria...    SMS_RULE_ENGINE  
Rule Criteria is: <UpdateXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Name="SMS_SoftwareUpdate" LocaleId="1033"><UpdateXMLDescriptionItems><UpdateXMLDescriptionItem PropertyName="_Product" UIPropertyName=""><MatchRules><string>'Product:a38c835c-2950-4e87-86cc- 6911a52c34a3'</string></MatchRules></UpdateXMLDescriptionItem><UpdateXMLDescriptionItem PropertyName="IsSuperseded" UIPropertyName=""><MatchRules><string>false</string></MatchRules></UpdateXMLDescriptionItem><UpdateXMLDescriptionIte m PropertyName="_UpdateClassification" UIPropertyName=""><MatchRules><string>'UpdateClassification:e0789628-ce08-4437- be74-2495b842f43b'</string></MatchRules></UpdateXMLDescriptionItem></UpdateXMLDescriptionItems></UpdateXML>     SMS_RULE_ENGINE  
Inserting PropertyName:_Product, PropertyValue:'Product:a38c835c-2950-4e87-86cc-6911a52c34a3'      SMS_RULE_ENGINE  
Inserting PropertyName:IsSuperseded, PropertyValue:false    SMS_RULE_ENGINE  
Inserting PropertyName:_UpdateClassification, PropertyValue:'UpdateClassification:e0789628-ce08-4437-be74-2495b842f43b'     SMS_RULE_ENGINE  
Query to run is: select CI_ID from dbo.fn_ListUpdateCIs(1033) ci~where IsExpired=0~ and (IsSuperseded=0)~ and (CI_ID in (select CI_ID from v_CICategories_All where CategoryInstance_UniqueID in (N'Product:a38c835c-2950-4e87-86cc-6911a52c34a3')))~ and (CI_ID in (select CI_ID from v_CICategories_All where CategoryInstance_UniqueID in (N'UpdateClassification:e0789628-ce08-4437- be74-2495b842f43b')))    SMS_RULE_ENGINE  
Rule resulted in a total of 1 updates    SMS_RULE_ENGINE  
Evaluation Resultant XML is: <EvaluationResultXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><DefinitionUpdates/><CI_IDs><CI_ID>4514</CI_ID></CI_IDs></EvaluationResultXML>     SMS_RULE_ENGINE
```

Download is started for actionable updates:

```output
Enforcing Content Download Action SMS_RULE_ENGINE  
Download Rule Action XML is: <ContentActionXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><PackageID>CS100006</PackageID><ContentLocales><Locale>Locale:9</Locale ><Locale>Locale:0</Locale></ContentLocales><ContentSources><Source Name="Internet" Order="1"/><Source Name="WSUS" Order="2"/><Source Name="UNC" Order="3" Location=""/></ContentSources></ContentActionXML>        SMS_RULE_ENGINE  
Criteria Filter Result XML is: <EvaluationResultXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">  
<DefinitionUpdates/><CI_IDs><CI_ID>4514</CI_ID></CI_IDs> </EvaluationResultXML>    SMS_RULE_ENGINE  
1 update(s) need to be downloaded in package "CS100006" (\\CS1SITE\SOURCE\Updates\EPDefinitions)    SMS_RULE_ENGINE  
List of update(s) which match the content rule criteria = {4514} SMS_RULE_ENGINE  
Downloading contents (count = 34) for UpdateID 4514              SMS_RULE_ENGINE  
List of update content(s) which match the content rule criteria = {737,738,739,740,741,742,2182,2183,2184,2185,2186,2187,2188,2189,3047,3048,3187,3188,3189,3190,3191,3192,3545,3546,3547 ,3548,3549,3550,3551,3552,3553,3554,3555,3556}     SMS_RULE_ENGINE  
Contents 737 is already present in the package "CS100006". Skipping download.         SMS_RULE_ENGINE  
Contents 738 is already present in the package "CS100006". Skipping download.    S MS_RULE_ENGINE  
1 of 1 updates are downloaded and will be added to the Deployment. SMS_RULE_ENGINE
```

RuleEngine.log shows creation of update group and deployment:

```output
We need to create a new UpdateGroup/Deployment          SMS_RULE_ENGINE  
Associated Update Group: ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_4d3480d5-de12-4864-b872-187479e2b381 with RBAC Scope SMS00UNA       SMS_RULE_ENGINE
```

The following examples illustrate the update group creation process:

In SMSDBMON.log:

```output
RCV: INSERT on CI_ConfigurationItems for CINotify_iud [16777275 ][66146]           SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on CI_ConfigurationItemRelations_Flat for CI_ConfigurationItemRelations_Flat_From_iud [16777275 ][66148]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on CI_ConfigurationItemRelations_Flat for CI_ConfigurationItemRelations_Flat_From_iud [16777275 ][66149]    SMS_DATABASE_NOTIFICATION_MONITOR  
...
SND: Dropped E:\ConfigMgr\inboxes\objmgr.box\16777275.CIN [66148]                   SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\objmgr.box\16777275.CIN [66149]                   SMS_DATABASE_NOTIFICATION_MONITOR
```

In ObjReplMgr.log:

```output
File notification triggered.   SMS_OBJECT_REPLICATION_MANAGER  
***** Processing AuthorizationList ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_4d3480d5-de12-4864-b872-187479e2b381 *****        SMS_OBJECT_REPLICATION_MANAGER  
Deleting notification file E:\ConfigMgr\inboxes\objmgr.box\16777275.CIN       SMS_OBJECT_REPLICATION_MANAGER  
Added CI with CI_ID=4514 to the deployment       SMS_OBJECT_REPLICATION_MANAGER  
Created file trigger for E:\ConfigMgr\inboxes\objmgr.box\16777228.CIA             SMS_OBJECT_REPLICATION_MANAGER  
Created file trigger for E:\ConfigMgr\inboxes\objmgr.box\16777228.CIV             SMS_OBJECT_REPLICATION_MANAGER  
Successfully processed AuthorizationList ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_4d3480d5-de12-4864-b872- 187479e2b381    SMS_OBJECT_REPLICATION_MANAGER  
Set last row version for Configuration Item to 0x0000000000487EA9    SMS_OBJECT_REPLICATION_MANAGER
```

The following example shows the deployment creation process:

In SMSDBMON.log:

```output
RCV: INSERT on CI_CIAssignments for CIAssignmentNotify_iu [16777228 ][66190] SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\objmgr.box\16777228.CIA [66190]            SMS_DATABASE_NOTIFICATION_MONITOR
```

In ObjReplMgr.log:

```output
+++Begin processing changed CIA objects      SMS_OBJECT_REPLICATION_MANAGER  
***** Processing Update Group Assignment {2ba787b6-4ee9-4b33-b0ff-8663d181c84d} *****    SMS_OBJECT_REPLICATION_MANAGER  
Deleting notification file E:\ConfigMgr\inboxes\objmgr.box\16777228.CIA    SMS_OBJECT_REPLICATION_MANAGER  
CI Assignment {2ba787b6-4ee9-4b33-b0ff-8663d181c84d} has 1 Targeted CI(s)   SMS_OBJECT_REPLICATION_MANAGER  
PolicyID {2ba787b6-4ee9-4b33-b0ff-8663d181c84d} PolicyVersion 1.00 PolicyHash SHA256:0C6D50CBFB36750CCA381B61E014A6C55D821001487C824F9112DAA1C64BAD32     SMS_OBJECT_REPLICATION_MANAGER  
Notifying policy provider about changes in policy content/targeting    SMS_OBJECT_REPLICATION_MANAGER  
Successfully created policy for CI Assignment {2ba787b6-4ee9-4b33-b0ff-8663d181c84d}    SMS_OBJECT_REPLICATION_MANAGER  
Notifying policy provider about changes in policy content/targeting    SMS_OBJECT_REPLICATION_MANAGER  
Successfully updated Policy Targeting for CI Assignment {2ba787b6-4ee9-4b33-b0ff-8663d181c84d}   SMS_OBJECT_REPLICATION_MANAGER  
Found file trigger for E:\ConfigMgr\inboxes\objmgr.box\16777228.CIV    SMS_OBJECT_REPLICATION_MANAGER  
Assigned CIs: [ 16777275 ]   SMS_OBJECT_REPLICATION_MANAGER  
Begin processing Assigned CI: [16777275]    SMS_OBJECT_REPLICATION_MANAGER  
Creating VersionInfo policy for CI 16777275   SMS_OBJECT_REPLICATION_MANAGER  
Creating VersionInfo policy ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_4d3480d5-de12-4864-b872-187479e2b381/VI    SMS_OBJECT_REPLICATION_MANAGER  
16777275 Referenced CIs: [ 1395 1396 1397 1398 1399 1400 1401 3013 3014 3015 3016 3017 3018 3019 3020 3021 3959 3960 3961 4112 4113 4114 4115 4116 4117 4118 4502 4503 4504 4505 4506 4507 4508 4509 4510 4511 4512 4513 4514 ]       SMS_OBJECT_REPLICATION_MANAGER  
VersionInfo policy for CI 16777275 is Machine type   SMS_OBJECT_REPLICATION_MANAGER  
PolicyID ScopeId_FC8FCC38-4BB1-4245-92F5-9CE841775019/AuthList_4d3480d5-de12-4864-b872-187479e2b381/VI PolicyVersion 1.00 PolicyHash SHA256:01BECBBF2B3EE56BD5B0742A04404C1C895A4C87B6915D55078AB157FEBA1E0F   SMS_OBJECT_REPLICATION_MANAGER  
Notifying policy provider about changes in policy content/targeting    SMS_OBJECT_REPLICATION_MANAGER  
Updated dependent policy references to CIA {2ba787b6-4ee9-4b33-b0ff-8663d181c84d}    SMS_OBJECT_REPLICATION_MANAGER  
STATMSG: ID=5800 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_OBJECT_REPLICATION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=6176 TID=6868 GMTDATE=Thu Feb 06 20:09:17.989 2014 ISTR0="ADR_Test" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=414 AVAL0="{2ba787b6-4ee9-4b33- b0ff-8663d181c84d}"   SMS_OBJECT_REPLICATION_MANAGER  
Successfully updated CRCs for CI Assignment {2ba787b6-4ee9-4b33-b0ff-8663d181c84d}    SMS_OBJECT_REPLICATION_MANAGER  
Successfully processed Update Group Assignment {2ba787b6-4ee9-4b33-b0ff-8663d181c84d}    SMS_OBJECT_REPLICATION_MANAGER  
Set last row version for CI Assignment to 0x0000000000487EB6    SMS_OBJECT_REPLICATION_MANAGER  
+++Completed processing changed CIA objects    SMS_OBJECT_REPLICATION_MANAGER
```

The following example shows the Policy creation process:

In SMSDBMON.log:

```output
RCV: INSERT on CrpChange_Notify for CrpChange_Notify_ins [15 ][66199]   SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on RBAC_ChangeNotification for Rbac_Sync_ChangeNotification [399 ][66200]   SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\policypv.box\policytargeteval\15.CRP [66199]      SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\hman.box\399.RBC [66200]   SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on PolicyAssignmentChg_Notify for PolicyAssignmentChg_Notify_iu [16787957 ][66201]    SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\policypv.box\policytargeteval\16787957.PAC [66201]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: INSERT on PolicyAssignmentChg_Notify for PolicyAssignmentChg_Notify_iu [16787957 ][66202]    SMS_DATABASE_NOTIFICATION_MONITOR  
RCV: UPDATE on PolicyAssignmentChg_Notify for PolicyAssignmentChg_Notify_iu [16787957 ][66203]    SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\policypv.box\policytargeteval\16787957.PAC [66202]    SMS_DATABASE_NOTIFICATION_MONITOR  
SND: Dropped E:\ConfigMgr\inboxes\policypv.box\policytargeteval\16787957.PAC [66203]    SMS_DATABASE_NOTIFICATION_MONITOR
```

In PolicyPv.log:

```output
File notification triggered.   SMS_POLICY_PROVIDER

--Process Collection Changes    SMS_POLICY_PROVIDER  
Building Collection Change List from Collection Change Notification files    SMS_POLICY_PROVIDER

--Process Collection Member Changes    SMS_POLICY_PROVIDER  
Building Collection Change List from Collection Member Notification files    SMS_POLICY_PROVIDER

--Handle PolicyAssignment Resigning    SMS_POLICY_PROVIDER  
Found the certificate that matches the SHA1 hash.    SMS_POLICY_PROVIDER  
Completed batch with beginning PADBID = 16787957 ending PADBID = 16787958.    SMS_POLICY_PROVIDER

--Process Policy Changes    SMS_POLICY_PROVIDER  
Found some Policy changes, returning New LastRowversion=0x0000000000487EB7    SMS_POLICY_PROVIDER  
Processing Updated Policies    SMS_POLICY_PROVIDER  
Building Collection Change List from New and Targeting Changed Policies    SMS_POLICY_PROVIDER

--Update Policy Targeting Map    SMS_POLICY_PROVIDER  
**** Evaluating Collection 15 for targeting changes ****    SMS_POLICY_PROVIDER

--Process Policy Targeting Map    SMS_POLICY_PROVIDER  
**** Process notification table to update resultant targeting table ****    SMS_POLICY_PROVIDER

--Process Targeting and Collection Membership changes    SMS_POLICY_PROVIDER  
Updating Policy Map    SMS_POLICY_PROVIDER

--UpdateMDMUserTargetingForUser    SMS_POLICY_PROVIDER  
Start Update MDM User Targeting For User  SMS_POLICY_PROVIDER

--UpdatePolicyMapForPA    SMS_POLICY_PROVIDER  
Found 16787957.PAC    SMS_POLICY_PROVIDER  
Adding to delete list: E:\ConfigMgr\inboxes\policypv.box\policytargeteval\16787957.PAC    SMS_POLICY_PROVIDER  
Updating ResPolicyMap    SMS_POLICY_PROVIDER
```

RuleEngine.log shows completion of rule processing:

```output
CRuleHandler: Rule 1 Successfully Applied!   SMS_RULE_ENGINE  
Updated Success Information for Rule: 1     SMS_RULE_ENGINE
```

## Deployment evaluation and update installation on clients

After the deployment and the deployment policy have been created on the server, clients receive the policy on the next policy evaluation cycle. Before you review the deployment evaluation process, it's important to find the Deployment Unique ID of the deployment. To find the Deployment Unique ID, add the **Deployment Unique ID** column in the console. For the deployment in the following example, the **Deployment Unique ID** is {B040D195-8FA8-48D3-953F-17E878DAB23D}.

1. Policy Agent receives the policy on manual policy retrieval or on schedule. When policy is received, the following are logged in PolicyAgent.log:

    ```output
    Initializing download of policy 'CCM_Policy_Policy5.PolicyID="{B040D195-8FA8-48D3-953F-17E878DAB23D}",PolicySource="SMS:PR1",PolicyVersion="1.00"' from 'http://PR1SITE.CONTOSO.COM/SMS_MP/.sms_pol?{B040D195-8FA8-48D3-953F-17E878DAB23D}.SHA256:0EE489DB3036BE80BB43676340249A254278BEBDDD80B6004C11FF10F12BC9D6' PolicyAgent_ReplyAssignments  
    Download of policy CCM_Policy_Policy5.PolicyID="{B040D195-8FA8-48D3-953F-17E878DAB23D}",PolicySource="SMS:PR1",PolicyVersion="1.00" completed (DTS Job ID: {D53DAB18-ED97-4373-A3BE-3FBA5DB3C6C6}) PolicyAgent_PolicyDownload
    ```

    The following are logged in PolicyEvaluator.log:

    ```output
    Initializing download of policy 'CCM_Policy_Policy5.PolicyID="{B040D195-8FA8-48D3-953F-17E878DAB23D}",PolicySource="SMS:PR1",PolicyVersion="1.00"' from 'http://PR1SITE.CONTOSO.COM/SMS_MP/.sms_pol?{B040D195-8FA8-48D3-953F-17E878DAB23D}.SHA256:0EE489DB3036BE80BB43676340249A254278BEBDDD80B6004C11FF10F12BC9D6' PolicyAgent_ReplyAssignments  
    Download of policy CCM_Policy_Policy5.PolicyID="{B040D195-8FA8-48D3-953F-17E878DAB23D}",PolicySource="SMS:PR1",PolicyVersion="1.00" completed (DTS Job ID: {D53DAB18-ED97-4373-A3BE-3FBA5DB3C6C6}) PolicyAgent_PolicyDownload
    ```

    After the policy is evaluated, the scheduler for the deadline is evaluated. This operation is done by the Scheduler component. In this example, deadline randomization is disabled in Computer Agent client settings. So the deployment evaluation is started on deadline and without randomization. Here's what we see in the Scheduler.log file:

    ```output
    Initialized trigger ("3E692B0000080000") for schedule 'Machine/DEADLINE:{B040D195-8FA8-48D3-953F-17E878DAB23D}':  
    Conditions=1 with deadline 4320 minutes  
    Allow randomization override=1  
    HasMissedOccurrence=FALSE  
    ScheduleLoadedTime="02/09/2014 19:05:947"  
    LastFireTime="00/00/00 00:00:00"  
    CurrentTime="02/09/2014 19:05:947"    Scheduler  
    Processing trigger '3E692B0000080000' for scheduler 'Machine/DEADLINE:{B040D195-8FA8-48D3-953F-17E878DAB23D}'. MaxRandomDelay = 120, MissedOccur = 0, RandomizeEvenIfMissed = 1, PreventRandomizationInducedMisses = 0   Scheduler  
    Randomization is disabled in client settings and this schedule is set to honor client setting.   Scheduler  
    SMSTrigger '3E692B0000080000' for scheduler 'Machine/DEADLINE:{B040D195-8FA8-48D3-953F-17E878DAB23D}' will fire at 02/09/2014 07:15:00 PM without randomization.   Scheduler
    ```

2. At the scheduled deadline, Scheduler notifies the Updates Deployment Agent to start the deployment evaluation process, as shown in Scheduler.log:

    ```output
    Sending message for schedule 'Machine/DEADLINE:{B040D195-8FA8-48D3-953F-17E878DAB23D}' (Target: 'direct:UpdatesDeploymentAgent', Name: '')    Scheduler  
    SMSTrigger '3E692B0000080000' (Schedule ID: 'Machine/DEADLINE:{B040D195-8FA8-48D3-953F-17E878DAB23D}', Message Name: '', Target: 'direct:UpdatesDeploymentAgent') will never fire again.     Scheduler
    ```

    In UpdatesDeployment.log:

    ```output
    Message received: '<?xml version='1.0' ?>  
    <CIAssignmentMessage MessageType='EnforcementDeadline'>  
    <AssignmentID>{B040D195-8FA8-48D3-953F-17E878DAB23D}</AssignmentID>  
    </CIAssignmentMessage>'    UpdatesDeploymentAgent  
    ```

    Updates Deployment Agent starts the deployment evaluation process by requesting a software update scan. The scan ensures that the deployed updates are still applicable. In UpdatesDeployment.log:

    ```output
    Assignment {B040D195-8FA8-48D3-953F-17E878DAB23D} has total CI = 3   UpdatesDeploymentAgent  
    Deadline received for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D})   UpdatesDeploymentAgent  
    Detection job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}) started for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D})   UpdatesDeploymentAgent
    ```

    In UpdatesHandler.log:

    ```output
    Successfully initiated scan for job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}).   UpdatesHandler  
    Scan completion received for job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}).   UpdatesHandler  
    Initial scan completed for the job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}).   UpdatesHandler  
    Evaluating status of the updates for the job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}).   UpdatesHandler  
    CompleteJob - Job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}) removed from job manager list.    UpdatesHandler
    ```

3. At this point, the scan request is handled by Scan Agent component. Scan Agent calls WUAHandler to perform a scan and then hands the results back to Updates Handler and Updates Deployment Agent. For more information about the scan process, see [Software update scan on clients](track-software-update-compliance-assessment.md#software-update-scan-on-clients).

    After the scan is completed, Updates Deployment Agent is notified. Here's what we see in UpdatesDeployment.log:

    ```output
    DetectJob completion received for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) UpdatesDeploymentAgent  
    Making updates available for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) UpdatesDeploymentAgent  
    Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_e06056e3-0199-4c68-8ac3-bdddff356a0a) Name (Security Update for Windows Server 2008 R2 x64 Edition (KB2698365)) ArticleID (2698365) added to the targeted list of deployment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) UpdatesDeploymentAgent  
    Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_ada7cf51-66b0-4a00-b37b-68d569d6ff8b) Name (Security Update for Windows Server 2008 R2 x64 Edition (KB2712808)) ArticleID (2712808) added to the targeted list of deployment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) UpdatesDeploymentAgent  
    Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_3cbcf577-5139-49b8-afe8-620af5c52f95) Name (Security Update for Windows Server 2008 R2 x64 Edition (KB2705219)) ArticleID (2705219) added to the targeted list of deployment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) UpdatesDeploymentAgent
    ```

4. Updates Deployment Agent raises state messages for the deployment to update the current **Evaluation** and **Compliance** state. Here's what we see in UpdatesDeployment.log:

    ```output
    Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Evaluate, StateId = 2, StateName = ASSIGNMENT_EVALUATE_SUCCESS    UpdatesDeploymentAgent  
    Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Compliance, Signature = 5e176837, IsCompliant = False    UpdatesDeploymentAgent
    ```

    Updates Deployment Agent now starts a job to download the software update files from the distribution point. Here's what we see in UpdatesDeployment.log:

    ```output
    DownloadCIContents Job ({C531FD04-FADA-4F75-A399-EEA2D3EDB56C}) started for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D})   UpdatesDeploymentAgent  
    Progress received for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D})   UpdatesDeploymentAgent  
    Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_e06056e3-0199-4c68-8ac3-bdddff356a0a) Progress: Status = ciStateDownloading, PercentComplete = 0, Result = 0x0   UpdatesDeploymentAgent  
    Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_ada7cf51-66b0-4a00-b37b-68d569d6ff8b) Progress: Status = ciStateDownloading, PercentComplete = 0, Result = 0x0   UpdatesDeploymentAgent  
    Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_3cbcf577-5139-49b8-afe8-620af5c52f95) Progress: Status = ciStateDownloading, PercentComplete = 0, Result = 0x0   UpdatesDeploymentAgent
    ```

    We can also see in UpdatesHandler.log:

    ```output
    Initiating download for the job ({C531FD04-FADA-4F75-A399-EEA2D3EDB56C}). UpdatesHandler  
    Update Id = 3cbcf577-5139-49b8-afe8-620af5c52f95, State = StateDownloading, Result = 0x0 UpdatesHandler  
    Update Id = ada7cf51-66b0-4a00-b37b-68d569d6ff8b, State = StateDownloading, Result = 0x0 UpdatesHandler  
    Update Id = e06056e3-0199-4c68-8ac3-bdddff356a0a, State = StateDownloading, Result = 0x0 UpdatesHandler  
    Timeout Options: Priority = 2, DPLocality = 1048578, Location = 604800, Download = 864000, PerDPInactivity = 0, TotalInactivityTimeout = 0, bUseBranchCache = True, bPersistOnWriteFilterDevices = True, bOverrideServiceWindow = False UpdatesHandler
    ```

5. Updates Handler starts the download request from Content Access service for the three actionable updates that are listed above. The download job is started for the child update in the bundle and the Content ID is logged.

    In UpdatesHandler.log

    ```output
    Bundle update (3cbcf577-5139-49b8-afe8-620af5c52f95) is requesting download from child updates for action (INSTALL) UpdatesHandler  
    Content Text = <Content ContentId="fbb5724a-aa0f-47f9-908a-47068fd8ad6f" Version="1"><FileContent Name="windows6.1-kb2705219-v2-x64.cab" Hash="8E8E0175D46B5A8D52C4856FA3D282FAA12ACD63" HashAlgorithm="SHA1" Size="199093"/></Content>  
    Bundle update (ada7cf51-66b0-4a00-b37b-68d569d6ff8b) is requesting download from child updates for action (INSTALL) UpdatesHandler  
    Content Text = <Content ContentId="3e9b1132-9ccd-439d-b32a-5cefd19735d1" Version="1"><FileContent Name="windows6.1-kb2712808-x64.cab" Hash="060B60401B3DE3DCE053A68C65E9EB050874EB80" HashAlgorithm="SHA1" Size="805071"/></Content>  
    Bundle update (e06056e3-0199-4c68-8ac3-bdddff356a0a) is requesting download from child updates for action (INSTALL) UpdatesHandler  
    Content Text = <Content ContentId="d2a9ee23-9cab-4843-b040-e2da1cc167e9" Version="1"><FileContent Name="windows6.1-kb2698365-x64.cab" Hash="BF20BB36FC73C0D1F53EA1E635B8AA46C71D7B1F" HashAlgorithm="SHA1" Size="2496330"/></Content>
    ```

    Content Access service starts a download job for each update and creates a Content Transfer Manager (CTM) job. A CTM job is created for each update separately, and CAS.log entries resemble the following for each update:

    ```output
    Requesting content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1, size(KB) 0, under context System with priority Medium ContentAccess  
    Created and initialized a DownloadContentRequest ContentAccess  
    Target location for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 is C:\Windows\ccmcache\1 ContentAccess  
    CDownloadManager::RequestDownload fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1.System ContentAccess  
    Submitted CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249} to download Content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 under context System ContentAccess  
    Successfully created download request {856FA4CA-D02A-4E2C-841E-841ED3C7EC01} for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 ContentAccess  
    Created and submitted a new Content Request for fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1.System ContentAccess
    ```

6. Content Transfer Manager starts working on the download job. It first requests the location for the content that must be downloaded. This location request is handled by Location Services. Location Services sends the location request to the management point, obtains the location response, and then hands it back to the Content Transfer Manager. Here's what we see in ContentTransferManager.log:

    ```output
    Starting CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249}. ContentTransferManager  
    CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249} entered phase CCM_DOWNLOADSTATUS_DOWNLOADING_DATA ContentTransferManager  
    Queued location request '{C56C01F2-2388-4710-BF3B-A526DB40E35F}' for CTM job '{E0452CF4-5B04-4A1A-B8EB-10B11B063249}'. ContentTransferManager  
    CCTMJob::EvaluateState(JobID={E0452CF4-5B04-4A1A-B8EB-10B11B063249}, State=RequestedLocations) ContentTransferManager
    ```

    We can also see in LocationServices.log:

    ```output
    Created filter for LS request {C56C01F2-2388-4710-BF3B-A526DB40E35F}.   LocationServices  
    ContentLocationReply : <ContentLocationReply SchemaVersion="1.00"><ContentInfo PackageFlags="0"><ContentHashValues/></ContentInfo><Sites><Site><MPSite SiteCode="PR1" MasterSiteCode="PR1" SiteLocality="LOCAL" IISPreferedPort="80" IISSSLPreferedPort="443"/><LocationRecords><LocationRecord><URL Name="<http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f>" Signature="<http://PR1SITE.CONTOSO.COM/SMS_DP_SMSSIG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1.tar>"/><ADSite Name="Default-First-Site-Name"/><IPSubnets><IPSubnet Address="192.168.10.0"/><IPSubnet Address=""/></IPSubnets><Metric Value=""/><Version>7958</Version><Capabilities SchemaVersion="1.0"><Property Name="SSLState" Value="0"/></Capabilities><ServerRemoteName>PR1SITE.CONTOSO.COM</ServerRemoteName><DPType>SERVER</DPType><Windows Trust="1"/><Locality>LOCAL</Locality></LocationRecord></LocationRecords></Site></Sites><RelatedContentIDs/></ContentLocationReply>   LocationServices  
    Distribution Point='<http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f>', Locality='LOCAL', DPType='SERVER', Version='7958', Capabilities='<Capabilities SchemaVersion="1.0"><Property Name="SSLState" Value="0"/></Capabilities>', Signature='<http://PR1SITE.CONTOSO.COM/SMS_DP_SMSSIG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1.tar>', ForestTrust='TRUE',   LocationServices  
    Calling back with locations for location request {C56C01F2-2388-4710-BF3B-A526DB40E35F}   LocationServices
    ```

    Content Transfer Manager receives the distribution point location for the requested content and starts a Data Transfer Service job to start the download of the update. Here's what we see in ContentTransferManager.log:

    ```output
    CCTMJob::UpdateLocations({E0452CF4-5B04-4A1A-B8EB-10B11B063249})   ContentTransferManager  
    CTM_NotifyLocationUpdate   ContentTransferManager  
    Persisted location '<http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f>', Order 0, for CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249}   ContentTransferManager  
    Persisted locations for CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249}:  
    (LOCAL) '<http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f>'   ContentTransferManager  
    CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249} (corresponding DTS job {594E9A72-43D1-48D1-A639-D18DF7D286A2}) started download from 'http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f' for full content download.   ContentTransferManager  
    CCTMJob::EvaluateState(JobID={E0452CF4-5B04-4A1A-B8EB-10B11B063249}, State=DownloadingData)    ContentTransferManager  
    CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249} entered phase CCM_DOWNLOADSTATUS_DOWNLOADING_DATA    ContentTransferManager
    ```

    In CAS.log:

    ```output
    Location update from CTM for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 and request {856FA4CA-D02A-4E2C-841E-841ED3C7EC01} ContentAccess  
    Download location found 0 - <http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f> ContentAccess  
    Download request only, ignoring location update ContentAccess  
    Download started for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 ContentAccess
    ```

    At this point, Data Transfer Service creates a BITS job to download the file and then monitors the download progress as noted in DataTransferService.log:

    ```output
    DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} created to download from 'http://PR1SITE.CONTOSO.COM:80/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f' to 'C:\Windows\ccmcache\1'.   DataTransferService  
    DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'DownloadingManifest'.   DataTransferService  
    CDTSJob::ProcessManifestCallback - processing manifest for job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}'.  DataTransferService  
    DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'RetrievedManifest'.   DataTransferService  
    Execute called for DTS job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}'. Current state: 'RetrievedManifest'.   DataTransferService  
    DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'PendingDownload'.   DataTransferService  
    Starting BITS download for DTS job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}'.   DataTransferService  
    DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} set BITS job to use default credentials.   DataTransferService  
    Starting BITS job '{38E74FCB-4397-4CA9-94AE-BDD49F550EC9}' for DTS job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}' under user 'S-1-5-18'.   DataTransferService  
    DTS::SetCustomHeadersOnBITSJob - setting custom headers on DTS job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}':  
    <none>   DataTransferService  
    DTS::AddTransportSecurityOptionsToBITSJob - Removing security info from DTS job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}'.   DataTransferService  
    DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'DownloadingData'.   DataTransferService  
    Job: {594E9A72-43D1-48D1-A639-D18DF7D286A2}, Total Files: 1, Transferred Files: 0, Total Bytes: 199093, Transferred Bytes: 5760   DataTransferService  
    Job: {594E9A72-43D1-48D1-A639-D18DF7D286A2}, Total Files: 1, Transferred Files: 0, Total Bytes: 199093, Transferred Bytes: 199093   DataTransferService  
    CDTSJob::JobTransferred : DTS Job ID='{594E9A72-43D1-48D1-A639-D18DF7D286A2}' BITS Job ID='{38E74FCB-4397-4CA9-94AE-BDD49F550EC9}'   DataTransferService  
    Job: {594E9A72-43D1-48D1-A639-D18DF7D286A2}, Total Files: 1, Transferred Files: 1, Total Bytes: 199093, Transferred Bytes: 199093   DataTransferService  
    DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'RetrievedData'.   DataTransferService  
    DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} successfully completed download.   DataTransferService  
    BITS job '{38E74FCB-4397-4CA9-94AE-BDD49F550EC9}' is not found. The BITS job may have completed already.   DataTransferService  
    CBITSDownloadMonitor(DTSJobID={594E9A72-43D1-48D1-A639-D18DF7D286A2}, BITSJobID={38E74FCB-4397-4CA9-94AE-BDD49F550EC9}) ignoring cancelled object.   DataTransferService  
    DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'NotifiedComplete'.   DataTransferService  
    DTS job {594E9A72-43D1-48D1-A639-D18DF7D286A2} has completed:  
    Status : SUCCESS,  
    Start time : 02/09/2014 19:15:05,  
    Completion time : 02/09/2014 19:15:12,  
    Elapsed time : 7 seconds   DataTransferService
    ```

7. After the download is complete, CTM and Content Access service are notified, and they mark the download jobs as completed. Content Access service performs a hash verification of the downloaded content to verify the integrity of the downloaded file. This process occurs for each file, although the following example involves a single update being downloaded. Here's what we see in ContentTransferManager.log:

    ```output
    CCTMJob::EvaluateState(JobID={E0452CF4-5B04-4A1A-B8EB-10B11B063249}, State=Success)   ContentTransferManager  
    CCTMJob::EvaluateState(JobID={E0452CF4-5B04-4A1A-B8EB-10B11B063249}, State=Complete)   ContentTransferManager
    ```

    In CAS.log:

    ```output
    Download completed for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 under context System   ContentAccess  
    The hash we are verifying is SDMPackage:<Content ContentId="fbb5724a-aa0f-47f9-908a-47068fd8ad6f" Version="1"><FileContent Name="windows6.1-kb2705219-v2-x64.cab" Hash="8E8E0175D46B5A8D52C4856FA3D282FAA12ACD63" HashAlgorithm="SHA1" Size="199093"/></Content>  ContentAccess  
    CContentAccessService::NotifyDownloadComplete Start Content Hashing   ContentAccess  
    Hashing file c:\windows\ccmcache\1\windows6.1-kb2705219-v2-x64.cab   ContentAccess  
    Hash matches ContentAccess 2/9/2014 7:15:12 PM 3532 (0x0DCC)  
    Hash verification succeeded for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 downloaded under context System ContentAccess
    ```

    Then Updates Deployment Agent raises a state message to update the current enforcement state and then starts the installation of the update. We see the following message in UpdatesDeployment.log:

    ```output
    Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Enforce, StateId = 8, StateName = ASSIGNMENT_ENFORCE_ADVANCE_DOWNLOAD_SUCCESS   UpdatesDeploymentAgent  
    Starting install for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D})   UpdatesDeploymentAgent  
    ApplyCIs - JobId = {CEE4AA3A-DE7B-4D9F-8949-E421BBBF2993}   UpdatesDeploymentAgent  
    Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_3cbcf577-5139-49b8-afe8-620af5c52f95) Progress: Status = ciStateWaitInstall, PercentComplete = 0, DownloadSize = 0, Result = 0x0   UpdatesDeploymentAgent  
    Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_ada7cf51-66b0-4a00-b37b-68d569d6ff8b) Progress: Status = ciStateWaitInstall, PercentComplete = 0, DownloadSize = 0, Result = 0x0   UpdatesDeploymentAgent  
    Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_e06056e3-0199-4c68-8ac3-bdddff356a0a) Progress: Status = ciStateWaitInstall, PercentComplete = 0, DownloadSize = 0, Result = 0x0   UpdatesDeploymentAgent
    ```

    We also see this entry in UpdatesHandler.log:

    ```output
    Job {CEE4AA3A-DE7B-4D9F-8949-E421BBBF2993} is starting execution   UpdatesHandler  
    CDeploymentJob::InstallUpdatesInBatch - Batch or non-batch install is not in progress for the job ({CEE4AA3A-DE7B-4D9F-8949-E421BBBF2993}). So allowing install..   UpdatesHandler  
    Update (3cbcf577-5139-49b8-afe8-620af5c52f95) added to the installation batch   UpdatesHandler  
    Update (ada7cf51-66b0-4a00-b37b-68d569d6ff8b) added to the installation batch   UpdatesHandler  
    Update (e06056e3-0199-4c68-8ac3-bdddff356a0a) added to the installation batch   UpdatesHandler  
    Got execute info for (3) updates   UpdatesHandler  
    Updates installation started as batch   UpdatesHandler
    ```

8. Windows Update Agent Handler then copies the downloaded binaries to the Windows Update Agent cache (C:\Windows\SoftwareDistribution\Download) directory and instructs Windows Update Agent to start the installation process. Here's what we see in WUAHandler.log:

    ```output
    Adding file to list for CopyToCache(): C:\Windows\ccmcache\1\windows6.1-kb2705219-v2-x64.cab   WUAHandler  
    CopyToCache() for update (fbb5724a-aa0f-47f9-908a-47068fd8ad6f) completed successfully   WUAHandler  
    Adding file to list for CopyToCache(): C:\Windows\ccmcache\2\windows6.1-kb2712808-x64.cab   WUAHandler  
    CopyToCache() for update (3e9b1132-9ccd-439d-b32a-5cefd19735d1) completed successfully   WUAHandler  
    Adding file to list for CopyToCache(): C:\Windows\ccmcache\3\windows6.1-kb2698365-x64.cab   WUAHandler  
    CopyToCache() for update (d2a9ee23-9cab-4843-b040-e2da1cc167e9) completed successfully   WUAHandler  
    Update(s) downloaded to WUA file cache, starting installation.   WUAHandler  
    Async installation of updates started.   WUAHandler  
    Update 1 (3cbcf577-5139-49b8-afe8-620af5c52f95) finished installing (0x00000000), Reboot Required? Yes   WUAHandler  
    Update 2 (ada7cf51-66b0-4a00-b37b-68d569d6ff8b) finished installing (0x00000000), Reboot Required? Yes   WUAHandler  
    Update 3 (e06056e3-0199-4c68-8ac3-bdddff356a0a) finished installing (0x00000000), Reboot Required? Yes   WUAHandler  
    Async install completed.   WUAHandler  
    Installation of updates completed.   WUAHandler
    ```

    We also see the following entries in WindowsUpdate.log:

    ```output
    2014-02-09 19:15:26:130 800 ed0 Agent ** START ** Agent: Installing updates [CallerId = CcmExec]  
    2014-02-09 19:15:26:130 800 ed0 Agent * Updates to install = 3  
    2014-02-09 19:15:26:254 1048 84c Handler Starting install of CBS update FBB5724A-AA0F-47F9-908A-47068FD8AD6F  
    2014-02-09 19:15:29:218 1048 84c Handler Completed install of CBS update with type=3, requiresReboot=1, installerError=0, hr=0x0  
    2014-02-09 19:15:29:265 1048 84c Handler Starting install of CBS update 3E9B1132-9CCD-439D-B32A-5CEFD19735D1  
    2014-02-09 19:15:30:435 1048 84c Handler Completed install of CBS update with type=3, requiresReboot=1, installerError=0, hr=0x0  
    2014-02-09 19:15:30:451 1048 84c Handler Starting install of CBS update D2A9EE23-9CAB-4843-B040-E2DA1CC167E9  
    2014-02-09 19:15:39:296 1048 84c Handler Completed install of CBS update with type=3, requiresReboot=1, installerError=0, hr=0x0  
    2014-02-09 19:15:39:327 788 9f8 COMAPI - Reboot required = Yes  
    2014-02-09 19:15:39:327 788 9f8 COMAPI -- END -- COMAPI: Install [ClientId = CcmExec]
    ```

9. After the updates are installed, Updates Deployment Agent checks whether any updates require a reboot. Then, it notifies the user if client settings are configured to allow such notifications. Here's what we see in UpdatesDeployment.log:

    ```output
    No installations in pipeline, notify reboot. NotifyUI = True   UpdatesDeploymentAgent  
    Notify reboot with deadline = Sunday, Feb 09, 2014. - 19:15:39, Ignore reboot Window = False, NotifyUI = True UpdatesDeploymentAgent  
    Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Enforce, StateId = 5, StateName = ASSIGNMENT_ENFORCE_PENDING_REBOOT   UpdatesDeploymentAgent
    ```

10. After the computer restarts, a post-reboot detection scan is started for the deployment. The scan verifies that updates are installed and raises state messages for the update and deployment to indicate that updates are installed and that enforcement was successful. Here's what we see in UpdatesDeployment.log:

    ```output
    CTargetedUpdatesManager::DetectRebootPendingUpdates - Total Pending reboot updates = 3   UpdatesDeploymentAgent  
    Initiated detect for pending reboot updates after system restart - JobId = {53F4851F-7E63-4C7E-952D-78345039FFFC}   UpdatesDeploymentAgent  
    CUpdatesJob({53F4851F-7E63-4C7E-952D-78345039FFFC}): Job completion received.   UpdatesDeploymentAgent  
    CUpdatesJob({53F4851F-7E63-4C7E-952D-78345039FFFC}): Detect after reboot job completed with result = 0x0   UpdatesDeploymentAgent  
    Raised update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_e06056e3-0199-4c68-8ac3-bdddff356a0a) enforcement state message successfully. StateId = 10, StateName = CI_ENFORCEMENT_SUCCESSFULL   UpdatesDeploymentAgent  
    Raised update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_ada7cf51-66b0-4a00-b37b-68d569d6ff8b) enforcement state message successfully. StateId = 10, StateName = CI_ENFORCEMENT_SUCCESSFULL   UpdatesDeploymentAgent  
    Raised update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_3cbcf577-5139-49b8-afe8-620af5c52f95) enforcement state message successfully. StateId = 10, StateName = CI_ENFORCEMENT_SUCCESSFULL   UpdatesDeploymentAgent  
    Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Compliance, Signature = 5e176837, IsCompliant = True   UpdatesDeploymentAgent  
    Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Enforce, StateId = 4, StateName = ASSIGNMENT_ENFORCE_SUCCESS   UpdatesDeploymentAgent
    ```

    At this point, the software updates deployment has been downloaded and successfully installed on the client, and the process is complete.

## State message reporting

Throughout the deployment phase, multiple state messages are raised to indicate the current state of the updates and the deployment itself. After these state messages are raised, they're processed in the way that's described in [State messaging data flow](state-messaging-description.md#state-messaging-data-flow).
