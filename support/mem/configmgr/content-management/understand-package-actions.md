---
title: Understanding package actions
description: Describes the distribute, update, and redistribute package actions in content distribution.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Content Management\Content Distribution to Distribution Points
---
# Package actions in content distribution

This article helps you understand package actions in content distribution.

_Original product version:_ &nbsp; Configuration Manager current branch, Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  

## Introduction

Package actions in content distribution are divided into the following:

- **Distribute**

  The first major action pertaining to content distribution is the Distribute action. This refers to the initial distribution of a package to a distribution point. This is triggered by the Distribute Content wizard in the Configuration Manager console. This will transfer all files in a package to the target distribution points, excluding those which are already present in the content library of the DP as part of another package. If the package contains any files that are already in the content library on the distribution point, those files are shared between multiple packages.

- **Update**

  The second major action is the Update action. This is typically used when a package has been changed and all distribution points to which it is distributed need the updated content. This is triggered with **Update Distribution Points** action in the console. This will transfer the changed files to all distribution points. Unchanged files will not be transferred. If a file is removed from the package in the updated version, it will be deleted from the package on the distribution point (as long as no other packages that share the file are on the DP).

- **Redistribute**

  The third major action is the Redistribute action, triggered with **Redistribute** in the Configuration Manager console. This will transfer the entire content to a specific distribution point. Files will be transferred and overwritten even if they are already present in the content library on the distribution point. The primary purpose of the Redistribute action is to correct any inconsistencies that may exist in the content library.

## Create a package

The following steps explain the flow of events when you create a new package from the administrator console that hasn't been distributed to any DPs yet:  

### Step 1: Admin console creates an instance of the `SMS_PackageWMI` class

After the administrator creates the package in the console, admin console creates an instance of the `SMS_Package` WMI class within the SMS Provider namespace for the newly created package. **SMSProv.log** shows the following:

> SMS Provider 4680 (0x1248) CExtProviderClassObject::DoPutInstanceInstance~  
> SMS Provider 4680 (0x1248) Auditing: User CONTOSO\Admin created an instance of class SMS_Package.~  
> SMS Provider 816 (0x330) Processed insert instance notification for: SMS_Package.PackageID="PackageID"~

When this WMI instance is created, SMS Provider inserts a row in the `SMSPackages` view in the database:

```sql
insert SMSPackages (PkgID, Name, Version, Language, Manufacturer, Description, ISVString, Hash, NewHash, Source, SourceSite, StoredPkgPath, RefreshSchedule, LastRefresh, StoredPkgVersion, ShareName, PreferredAddress, StorePkgFlag, ShareType, HashVersion,Architecture, ImagePath,Permission, UseForcedDisconnect, ForcedRetryDelay, DisconnectDelay, IgnoreSchedule, Priority, PkgFlags, MIFFilename, MIFPublisher, MIFName, MIFVersion, SourceVersion, SourceDate, SourceSize, SourceCompSize, ImageFlags, PackageType, AlternateContentProviders, SourceLocaleID,  TransformReadiness, TransformAnalysisDate, UpdateMask, UpdateMaskEx, Action, DefaultImage) values (N'PackageID', N'Dummy1', N'', N'',N'',N'',N'',N'',N'',N'\\CS1SITE\SOURCE\Packages\Dummy1',N'CS1',N'',N'',N'04/10/1970 06:35:00', 0, N'',N'', 2, 1, 1, N'', N'', 15, 0, 2, 5, 0, 2, 16777216, N'',N'',N'',N'', 1, N'05/16/2016 15:22:12', 0, 0, 0, 0, N'', 1033, 0, N'1980/01/01 00:00:00', 0, 0, 2, 0)
```

After the row is inserted, a trigger on the view inserts a row in `SMSPackages_G` and `SMS_Packages_L` tables. This in turn causes a trigger on the `SMSPackages_G` table to insert a row in `PkgNotification` table. The row in the `PkgNotification` table is used to notify DistMgr to process the package, and this notification is provided to DistMgr by the `SMSDBMON` component.

```sql
insert PkgNotification (PkgID, Priority, Type, TimeKey) values (N'PackageID', 2, 2, GetDate())
```

### Step 2: SMSDBMON detects a change and notifies DistMgr to process the package by dropping a \<PackageID>.PKN file

SMSDBMON detects a change in the `PkgNotification` table, which causes it to drop a **\<*PackageID*>.PKN** file in `DistMgr.box` to instruct DistMgr to process the package:

> SMS_DATABASE_NOTIFICATION_MONITOR 3240 (0xca8) RCV: INSERT on PkgNotification for PkgNotify_Add [\<PackageID>][850902]  
> SMS_DATABASE_NOTIFICATION_MONITOR 3240 (0xca8) SND: Dropped E:\ConfigMgr\inboxes\distmgr.box\\\<PackageID>.PKN  [850902]

### Step 3: DistMgr processes the package on the package source site

DistMgr processes the package after detecting the PKN file in `DistMgr.box`. DistMgr processing is performed by multiple threads.

1. The main DistMgr thread creates a package processing thread.

   Main DistMgr thread wakes up, adds the package to the package processing queue and creates a package processing thread to process the package:

   > SMS_DISTRIBUTION_MANAGER 2624 (0xa40) Found package properties updated notification for package 'PackageID'  
   > SMS_DISTRIBUTION_MANAGER 2624 (0xa40) Adding package 'PackageID' to package processing queue.  
   > SMS_DISTRIBUTION_MANAGER 2624 (0xa40) ~Currently using 0 out of 3 allowed package processing threads.  
   > SMS_DISTRIBUTION_MANAGER 2624 (0xa40) ~Started package processing thread for package 'PackageID', thread ID = 0x16A8 (5800)

2. The package processing thread creates a package snapshot and writes content in the content library.

   The package processing thread (thread ID 5800 in this case) starts processing the package and creates a package snapshot. After creating the package snapshot, this thread also writes the package content to the content library on the site server.

   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) STATMSG: ID=2300 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=CS1SITE.CONTOSO.COM SITE=CS1 PID=1904 TID=5800 GMTDATE=Mon May 16 14:33:55.691 2016 ISTR0="Dummy1" ISTR1="\<PackageID>" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="\<PackageID>"  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) ~Processing package \<PackageID> (SourceVersion:1;StoredVersion:0)  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) Start adding package \<PackageID>...  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) ~The Package Action is 2, the Update Mask is 0 and UpdateMaskEx is 0.  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) ~CDistributionSrcSQL::UpdateAvailableVersion PackageID=\<PackageID>, Version=1, Status=2300  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) Taking package snapshot for package \<PackageID> from source \\\CS1SITE\SOURCE\Packages\Dummy1  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) The size of package \<PackageID>, version 1 is 204800 KBytes  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) Writing package definition for \<PackageID>  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) ~Successfully created RDC signatures for package PackageID version 1  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) Creating hash for algorithm 32780  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) The hash for algorithm 32780 is \<HashString>  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) The RDC signature hash for algorithm 32780 is \<HashString>  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) ~Adding these contents to the package PackageID version 1.  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) STATMSG: ID=2376 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=CS1SITE.CONTOSO.COM SITE=CS1 PID=1904 TID=5800 GMTDATE=Mon May 16 14:34:04.611 2016 ISTR0="\<PackageID>" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="\<PackageID>"

3. The package processing thread replicates the package to other sites.

   The package processing thread then replicates the package to the other sites in the hierarchy. Package metadata information is replicated to other sites via database replication, while package files are replicated using file replication. However, package files are only sent to a site if at least one DP in that site is added to the package. Package files are compressed before they are sent to another site. In this case, since no DPs are targeted, only package metadata is replicated to other sites but package files are not replicated.

   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) ~Package \<PackageID> does not have a preferred sender.  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) A program for package \<PackageID> has been added or removed, therefore it needs to be replicated to all child sites.  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) Package \<PackageID> is new or has changed, replicating to all applicable sites.  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) ~CDistributionSrcSQL::UpdateAvailableVersion PackageID=\<PackageID>, Version=1, Status=2301  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) ~StoredPkgVersion (1) of package \<PackageID>. StoredPkgVersion in database is 1.  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) ~SourceVersion (1) of package \<PackageID>. SourceVersion in database is 1.  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) ~Adding these contents to the package \<PackageID> version 1.

4. The package processing thread exits.

   The package processing thread exits after the package processing is complete and raises a status message with ID 2301 which means 'Distribution Manager successfully processed package \<*PACKAGENAME*> (package ID = \<*PKGID*>).'

   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) STATMSG: ID=2301 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=CS1SITE.CONTOSO.COM SITE=CS1 PID=1904 TID=5800 GMTDATE=Mon May 16 14:34:06.736 2016 ISTR0="Dummy1" ISTR1="\<PackageID>" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="\<PackageID>"  
   > SMS_DISTRIBUTION_MANAGER 5800 (0x16a8) ~Exiting package processing thread for package \<PackageID>.

### Step 4: (If applicable) DRS replicates the package to other sites

If there are other sites in the hierarchy, package metadata information is replicated to other sites via database replication. After the package information is replicated, a row in the `SMSPackages_G` table is inserted which triggers an insert in the `PkgNotification` table.

#### Step 5: (If applicable) SMSDBMON on the receiving site notifies DistMgr by dropping a \<PackageID>.PKN file

On the receiving site, SMSDBMON detects a change in the `PkgNotification` table which causes it to drop a **\<*PackageID*>.PKN** file in `DistMgr.box` to instruct DistMgr to process the package:

> SMS_DATABASE_NOTIFICATION_MONITOR 3120 (0xc30) RCV: INSERT on PkgNotification for PkgNotify_Add [\<PackageID> ][1035019]  
> SMS_DATABASE_NOTIFICATION_MONITOR 3120 (0xc30) SND: Dropped E:\ConfigMgr\inboxes\distmgr.box\\\<PackageID>.PKN [1035019]

### Step 6: (If applicable) DistMgr on the receiving site processes the package

On the receiving site, after receiving the *.PKN* file, DistMgr wakes up to process the package.

1. The main DistMgr thread creates a package processing thread.

   The main DistMgr thread adds the package to the package processing queue and creates a package processing thread:

   > SMS_DISTRIBUTION_MANAGER 3648 (0xe40) Found package properties updated notification for package '\<PackageID>'  
   > SMS_DISTRIBUTION_MANAGER 3648 (0xe40) Adding package '\<PackageID>' to package processing queue.  
   > SMS_DISTRIBUTION_MANAGER 3648 (0xe40) ~Currently using 0 out of 3 allowed package processing threads.  
   > SMS_DISTRIBUTION_MANAGER 3648 (0xe40) ~Started package processing thread for package '\<PackageID>', thread ID = 0x1378 (4984)

2. The package processing thread processes the package.

   In this case, there's nothing for this thread to do since no DPs have been targeted.

   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) STATMSG: ID=2300 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=4224 TID=4984 GMTDATE=Mon May 16 14:36:08.809 2016 ISTR0="Dummy1" ISTR1="\<PackageID>" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="\<PackageID>"  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) ~Processing package \<PackageID> (SourceVersion:1;StoredVersion:0)  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) Start adding package \<PackageID>...  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) ~The Package Action is 2, the Update Mask is 0 and UpdateMaskEx is 0.  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) ~Successfully created/updated the package \<PackageID>  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) STATMSG: ID=2311 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=4224 TID=4984 GMTDATE=Mon May 16 14:36:09.486 2016 ISTR0="PackageID" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="\<PackageID>"  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) ~Created policy provider trigger for ID \<PackageID>  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) ~Package \<PackageID> does not have a preferred sender.  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) ~CDistributionSrcSQL::UpdateAvailableVersion PackageID=\<PackageID>, Version=1, Status=2301  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) ~StoredPkgVersion (0) of package \<PackageID>. StoredPkgVersion in database is 0.  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) ~SourceVersion (1) of package \<PackageID>. SourceVersion in database is 1.  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) STATMSG: ID=2301 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=4224 TID=4984 GMTDATE=Mon May 16 14:36:10.061 2016 ISTR0="Dummy1" ISTR1="\<PackageID>" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="\<PackageID>"  
   > SMS_DISTRIBUTION_MANAGER 4984 (0x1378) ~Exiting package processing thread for package \<PackageID>.

## Distribute a package to DP across sites

The following steps outline the flow of events when a package is distributed to a DP in the primary site but the primary site server in question does **not** contain a copy of this package in the content library. This package was created on the central administration site and as a result, the central administration site is the package source site:

### On the package source site

#### Step 1: The admin console adds the DP to the package by calling the `AddDistributionPoints` method on the `SMS_PackageWMI` class

After the administrator distributes the package to a DP from the console, the admin console calls the `AddDistributionPoints` method of the `SMS_Package` class to add the specified DP to the package. **SMSProv.log** shows the following:

> SMS Provider 4616 (0x1208) Context: SMSAppName=Configuration Manager Administrator console~  
> SMS Provider 4616 (0x1208) ExecMethodAsync : **SMS_Package.PackageID="\<PackageID>"::AddDistributionPoints~**  
> SMS Provider 4616 (0x1208) CExtProviderClassObject::DoExecuteMethod AddDistributionPoints~  
> SMS Provider 4616 (0x1208) Auditing: User CONTOSO\Admin called an audited method of an instance of class SMS_Package.~

When this method is called, SMS Provider inserts a row in `PkgServers` with `Action` set to **2** (ADD).

```sql
insert PkgServers (PkgID, NALPath, SiteCode, SiteName, SourceSite, LastRefresh, RefreshTrigger, UpdateMask, Action) select N'PackageID', N'['Display=\\PS1SITE.CONTOSO.COM\']MSWNET:['SMS_SITE=PS1']\\PS1SITE.CONTOSO.COM\', N'PS1', Sites.SiteName, N'CS1', N'04/10/1970 06:35:00', 0, 0, 2  from Sites where SiteCode = N'PS1'
```

After a row is inserted in `PkgServers`, SMS Provider also inserts a row in the `PkgNotification` table. The row in the `PkgNotification` table is used to notify DistMgr to process the package, and this notification is provided to DistMgr by the `SMSDBMON` component.

```sql
insert PkgNotification (PkgID, Priority, Type, TimeKey) values (N'PackageID', 2, 4, GetDate())
```

#### Step 2: SMSDBMON detects the package change and notifies DistMgr by dropping a \<PackageID>.PKN file in DistMgr.box

SMSDBMON detects a change in the `PkgNotification` table that causes it to drop a **\<*PackageID*>.PKN** file in `DistMgr.box` to instruct DistMgr to process the package.

> SMS_DATABASE_NOTIFICATION_MONITOR 4944 (0x1350) RCV: INSERT on PkgNotification for PkgNotify_Add [\<PackageID> ][850967]  
> SMS_DATABASE_NOTIFICATION_MONITOR 4944 (0x1350)    SND: Dropped E:\ConfigMgr\inboxes\distmgr.box\\**\<PackageID>.PKN**  [850967]

#### Step 3: DistMgr wakes up to process the package after receiving the PKN file

1. The main DistMgr thread creates the package processing thread.

   The main DistMgr thread adds the package to the package processing queue and creates a package processing thread.

   > SMS_DISTRIBUTION_MANAGER 2496 (0x9c0) Adding package '\<PackageID>' to package processing queue.  
   > SMS_DISTRIBUTION_MANAGER 2496 (0x9c0) ~Currently using 0 out of 3 allowed package processing threads.  
   > SMS_DISTRIBUTION_MANAGER 2496 (0x9c0) ~Started package processing thread for package '\<PackageID>', thread ID = **0x1164 (4452)**

2. The package processing thread processes the package actions.

   The package processing thread processes the package actions to add/update/remove the package from the DP. In this case, the package source site is the central administration site and there are no package actions to process because the central administration site contains no DPs. On a site where there are package actions to process, the package processing thread creates DP threads for performing these actions and waits for the DP threads to exit before moving on to Step 3-3.

   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) ~Processing package \<PackageID> (SourceVersion:1;StoredVersion:1)  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) No action specified for the package \<PackageID>, however there may be package server changes for this package.  

3. The package processing thread creates a mini-job to send the compressed copy of the package to the destination site.

   This mini-job is processed by the scheduler to create a send request for Sender to transfer the compressed copy of the package to the destination site:

   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) ~Package \<PackageID> does not have a preferred sender.  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) ~Needs to send the compressed package for package \<PackageID> to site PS1  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) ~Sending a copy of package \<PackageID> to site PS1  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) ~The reporting site of site PS1 is this site.  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) ~Use drive E for storing the compressed package.  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) ~Setting CMiniJob transfer root to E:\SMSPKG\\\<PackageID>.PCK.1  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) Incremented ref count on file E:\SMSPKG\\\<PackageID>.PCK.1, count = 2  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) Decremented ref count on file E:\SMSPKG\\\<PackageID>.PCK.1, count = 1  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) ~**Created minijob to send compressed copy of package \<PackageID> to site PS1**.  Transfer root = E:\SMSPKG\\\<PackageID>.PCK.1.  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) The package and/or program properties for package \<PackageID> have not changed,  need to determine which site(s) need updated package info.  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) A distribution point has been changed at this site, adding site PS1 to the list of sites to which we are sending package \<PackageID>.  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) Parent site of PS1 is CS1

4. The package processing thread exits after processing the package:

   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) ~StoredPkgVersion (1) of package \<PackageID>. StoredPkgVersion in database is 1.  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) ~SourceVersion (1) of package \<PackageID>. SourceVersion in database is 1.  
   > SMS_DISTRIBUTION_MANAGER 4452 (0x1164) ~**Exiting package processing thread for package \<PackageID>**.

#### Step 4: The scheduler component processes the mini-job created by the package processing thread and creates a send request

The scheduler component wakes up after receiving a job to transfer the compressed copy of the package, and creates a send request for Sender so that Sender can send the compressed copy to the destination site.

> SMS_SCHEDULER 5492 (0x1574) ========  Processing Jobs  ========  
> SMS_SCHEDULER 5492 (0x1574) \<Activating JOB JOBID>[Software Distribution for Dummy1, Package ID = \<PackageID>]~  
> SMS_SCHEDULER 5492 (0x1574) Destination site:  PS1, Preferred Address: *, Priority: 2  
> SMS_SCHEDULER 5492 (0x1574) Instruction type:  MICROSOFT\|SMS\|MINIJOBINSTRUCTION\|PACKAGE~  
> SMS_SCHEDULER 5492 (0x1574) Creating instruction file: \\\CS1SITE.CONTOSO.COM\SMS_CS1\inboxes\schedule.box\tosend\JOBID.Icl~  
> SMS_SCHEDULER 5492 (0x1574) Transfer root:  E:\SMSPKG\\\<PackageID>.PCK.1~  
> SMS_SCHEDULER 5492 (0x1574) \<Updating JOB JOBID>[Software Distribution for Dummy1, Package ID = **\<PackageID>**]~  
> SMS_SCHEDULER 5492 (0x1574) Created new send request ID:  **202SQCS1**~

The scheduler will periodically update the send requests and will log useful information about the send requests which includes total size and remaining size:

> SMS_SCHEDULER 5492 (0x1574) ====== Updating Send Request List =======  
> SMS_SCHEDULER 5492 (0x1574) Send Request **202SQCS1** JobID: JOBID DestSite: PS1 FinalSite: State: Pending Status: Action: None Total size: 204864k Remaining: 204864k Heartbeat: 12:23 Start: 12:00 Finish: 12:00 Retry: SWD PkgID: \<PackageID> SWD Pkg Version: 1  

#### Step 5: The sender component starts working on the send request

The sender component processes the send request and sends the compressed copy of the package to the destination site.

1. The main sender thread starts a sending thread which is the thread that will perform all the work for this send request.

   > SMS_LAN_SENDER 6700 (0x1a2c) Found send request.  ID: 202SQCS1, Dest Site: PS1~  
   > SMS_LAN_SENDER 6700 (0x1a2c) Checking for site-specific sending capacity.  Used 0 out of 3.~  
   > SMS_LAN_SENDER 6700 (0x1a2c) ~Created sending thread (**Thread ID = 1150**)

2. The sending thread processes the send request and copies the compressed package file (**PCK** file) to the destination site along with the package instruction file (**SNI** file).

   > SMS_LAN_SENDER 4432 (0x1150) ~Trying the No. 1 address (out of 1)  
   > SMS_LAN_SENDER 4432 (0x1150) ~Passed the xmit file test, use the existing connection  
   > SMS_LAN_SENDER 4432 (0x1150) ~Package file = E:\SMSPKG\\\<PackageID>.PCK.1  
   > SMS_LAN_SENDER 4432 (0x1150) ~Instruction file = E:\ConfigMgr\inboxes\schedule.box\tosend\00000E2A.Icl  
   > SMS_LAN_SENDER 4432 (0x1150) ~Checking for remote file \\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.PCK  
   > SMS_LAN_SENDER 4432 (0x1150) ~Checking for remote file \\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.SNI  
   > SMS_LAN_SENDER 4432 (0x1150) ~Checking for remote file \\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.TMP …  
   > SMS_LAN_SENDER 4432 (0x1150) ~Attempt to create/open the remote file \\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.PCK  
   > SMS_LAN_SENDER 4432 (0x1150) ~Created/opened the remote file \\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.PCK  
   > SMS_LAN_SENDER 4432 (0x1150) ~Sending Started [E:\SMSPKG\\\<PackageID>.PCK.1]  
   > SMS_LAN_SENDER 4432 (0x1150) ~Attempt to write 1024 bytes to \\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.PCK at position 0  
   > SMS_LAN_SENDER 4432 (0x1150) ~Wrote 1024 bytes to \\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.PCK at position 0 …  
   > SMS_LAN_SENDER 4432 (0x1150) ~Attempt to write 380731 bytes to \\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.PCK at position 209398784  
   > SMS_LAN_SENDER 4432 (0x1150) ~Wrote 380731 bytes to \\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.PCK at position **209398784**  
   > SMS_LAN_SENDER 4432 (0x1150) ~Sending completed [E:\SMSPKG\\**\<PackageID>.PCK.1**]  
   > SMS_LAN_SENDER 4432 (0x1150) ~Finished sending SWD package \<PackageID> version 1 to site PS1 …  
   > SMS_LAN_SENDER 4432 (0x1150) ~Sending Started [E:\ConfigMgr\inboxes\schedule.box\tosend\00000E2A.Icl]  
   > SMS_LAN_SENDER 4432 (0x1150) ~Sending completed [E:\ConfigMgr\inboxes\schedule.box\tosend\00000E2A.Icl]  
   > SMS_LAN_SENDER 4432 (0x1150) ~Finished sending SWD package \<PackageID> version 1 to site PS1 …  
   > SMS_LAN_SENDER 4432 (0x1150) ~Renaming remote file \\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.TMP to \\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.SNI  
   > MS_LAN_SENDER 4432 (0x1150) ~Rename completed [\\\PS1SITE.CONTOSO.COM\SMS_SITE\202SQCS1.TMP]  
   > SMS_LAN_SENDER 4432 (0x1150) ~Sending completed successfully

   The sending thread copies these files to the `SMS_SITE` share on the receiving site.

   > [!TIP]
   > The **sender.log** file continuously logs the position it's writing to. For example, the position is **209398784** in the above log. This position is the byte offset it's writing to, and you can find how much data has been copied by converting this value. For example, 209398784 bytes = 199.69 MB.  

#### Step 6: The scheduler component marks the job as completed and deletes the send request

The scheduler component monitors the send requests, and after Sender has finished processing the send request, Scheduler marks the job as complete and deletes the send request:

> SMS_SCHEDULER 5492 (0x1574) ======  Checking Status of All Send Requests  ======  
> SMS_SCHEDULER 5492 (0x1574) ~====  Checking send requests for outbox \\\CS1SITE.CONTOSO.COM\SMS_CS1\inboxes\schedule.box\outboxes\LAN.~~  
> SMS_SCHEDULER 5492 (0x1574) Checking send request **202SQCS1**~  
> SMS_SCHEDULER 5492 (0x1574) Sending completed (13985442 bytes/sec).~  
> SMS_SCHEDULER 5492 (0x1574) \<Updating JOB JOBID>[Software Distribution for Dummy1, Package ID = \<PackageID>]~  
> SMS_SCHEDULER 5492 (0x1574) Send request has successfully completed.~  
> SMS_SCHEDULER 5492 (0x1574) **\<JOB STATUS - COMPLETE>**~  
> SMS_SCHEDULER 5492 (0x1574) Deleting instruction file \\\CS1SITE.CONTOSO.COM\SMS_CS1\inboxes\schedule.box\tosend\00000E2A.Icl.~  
> SMS_SCHEDULER 5492 (0x1574) Deleting job package source [E:\SMSPKG\\\<PackageID>.PCK.1].~  
> SMS_SCHEDULER 5492 (0x1574) Deleted reference counted file E:\SMSPKG\\\<PackageID>.PCK.1  
> SMS_SCHEDULER 5492 (0x1574) Decremented ref count on file E:\SMSPKG\\\<PackageID>.PCK.1, count = 0  
> SMS_SCHEDULER 5492 (0x1574) **Deleting send request with ID: 202SQCS1.**~  
> SMS_SCHEDULER 5492 (0x1574) Deleted job JOBID.~

After this step, the sending site has no more work to do and the receiving site starts the processing of the package.

### On the destination site

#### Step 7: Despooler processes the PCK and SNI files

During Step 5, **PCK** and **SNI** files were copied to the `SMS_SITE` share on the receiving site. On each Configuration Manager site, the *\inboxes\despoolr.box\receive* folder is shared as `SMS_SITE`. When these files arrive in the *despoolr.box\receive* folder, the `despooler` component wakes up to process the SNI file which is an instruction file.

1. The main despooler thread creates a despooling thread.

   Main Despooler finds the instruction file and creates a despooling thread to process the instruction file:

   > SMS_DESPOOLER 6128 (0x17f0) ~Found ready instruction 202sqcs1.sni  
   > SMS_DESPOOLER 6128 (0x17f0) ~Used 0 out of 3 despooling threads  
   > SMS_DESPOOLER 6128 (0x17f0) ~Created a new despooling thread EE8

2. (Sporadically) Despooling thread sometimes fails to process instruction on first attempt and retries after 5 minutes.

   The despooling thread processes the instruction file, however in many cases, the first-time despooler tries to process an instruction file for a package it will fail with a '*package information hasn't arrived yet for this version*' message because the package metadata information hasn't yet replicated to the receiving site. When this happens, **despooler.log** shows '*error code = 12*' but retries this instruction after five minutes, which is successful as the package information replicates during this time. Step 7-3 shows the successful processing of the instruction on retry.

   > SMS_DESPOOLER 3816 (0xee8) ~Verifying signature for instruction E:\ConfigMgr\inboxes\despoolr.box\receive\ds_s76nc.ist of type MICROSOFT\|SMS\|MINIJOBINSTRUCTION\|PACKAGE  
   > SMS_DESPOOLER 3816 (0xee8) ~Signature checked out OK for instruction coming from site CS1, proceed with the instruction execution.  
   > SMS_DESPOOLER 3816 (0xee8) ~Executing instruction of type MICROSOFT\|SMS\|MINIJOBINSTRUCTION\|PACKAGE  
   > SMS_DESPOOLER 3816 (0xee8) ~Received package PackageID version 1. Compressed file -  E:\SMSPKG\\\<PackageID>.PCK.1 as E:\ConfigMgr\inboxes\despoolr.box\receive\ds_s76nc.pkg  
   > SMS_DESPOOLER 3816 (0xee8)  ~Old package storedUNC path is .  
   > SMS_DESPOOLER 3816 (0xee8) ~**This package[\<PackageID>]'s information hasn't arrived yet for this version [1]. Retry later** ...  
   > SMS_DESPOOLER 3816 (0xee8) ~Created retry instruction for job JOBID  
   > SMS_DESPOOLER 3816 (0xee8) ~Despooler failed to execute the instruction, **error code = 12** …  
   > SMS_DESPOOLER 6128 (0x17f0) ~Instruction E:\ConfigMgr\inboxes\despoolr.box\receive\ds_3kyyh.sni won't be processed till 5/16/2016 12:29:11 PM Eastern Daylight Time

   If this happens, DistMgr will try to process the package, however since the compressed copy of the package hasn't been processed and extracted into the content library, the package processing thread will log the following and exit:

   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) ~Started package processing thread for package '\<PackageID>', thread ID = 0xAAC (2732)  
   > SMS_DISTRIBUTION_MANAGER 2732 (0xaac)  ~Processing package \<PackageID> (SourceVersion:1;StoredVersion:0)  
   > SMS_DISTRIBUTION_MANAGER 2732 (0xaac)  ~**The contents for the package \<PackageID> hasn't arrived from site CS1 yet, will retry later**.  
   > SMS_DISTRIBUTION_MANAGER 2732 (0xaac)  ~All DP threads have completed for package \<PackageID> processing thread.  
   > SMS_DISTRIBUTION_MANAGER 2732 (0xaac)  ~Exiting package processing thread for package \<PackageID>.

3. The despooling thread processes the instruction and writes content to the content library.

   The despooling thread processes the instruction, uncompresses the PCK file to a temp location, then writes the content to the content library.

   > SMS_DESPOOLER 4072 (0xfe8) ~Received package \<PackageID> version 1. Compressed file -  E:\SMSPKG\\\<PackageID>.PCK.1 as E:\ConfigMgr\inboxes\despoolr.box\receive\PKGj3uib.TRY  
   > SMS_DESPOOLER 4072 (0xfe8) ~Old package storedUNC path is .  
   > SMS_DESPOOLER 4072 (0xfe8) ~Use drive E for storing the compressed package.  
   > SMS_DESPOOLER 4072 (0xfe8) No branch cache registry entries found.  
   > SMS_DESPOOLER 4072 (0xfe8) Uncompressing E:\SMSPKG\\\<PackageID>.PCK to E:\SMSPKG\\\<PackageID>.PCK.temp  
   > SMS_DESPOOLER 4072 (0xfe8) Content Library: E:\SCCMContentLib  
   > SMS_DESPOOLER 4072 (0xfe8) Extracting from E:\SMSPKG\\\<PackageID>.PCK.temp  
   > SMS_DESPOOLER 4072 (0xfe8) Extracting package \<PackageID>  
   > SMS_DESPOOLER 4072 (0xfe8) Extracting content \<PackageID>.1  
   > SMS_DESPOOLER 4072 (0xfe8) **Writing package definition for \<PackageID>**  
   > SMS_DESPOOLER 4072 (0xfe8) ~Package \<PackageID> (version 0) exists in the distribution source, save the newer version (version 1).  
   > SMS_DESPOOLER 4072 (0xfe8) ~Stored Package \<PackageID>. Stored Package Version = 1

   After successfully extracting the content to the content library, despooler updates `StoredPkgVersion` in the `SMSPackages_L` table and inserts a row in the `PkgNotification` table so that DistMgr can be notified to process the package.

   ```sql
   update SMSPackages_L set StoredPkgPath = N'\\PS1SITE.CONTOSO.COM\E$\SMSPKG\<PackageID>.PCK', StoredPkgVersion = 1, UpdateMask = 160, UpdateMaskEx = 0, Action = 1 where PkgID = N'<PackageID>'
   insert PkgNotification (PkgID, Priority, Type, TimeKey) values (N'<PackageID>', 2, 1, GetDate())
   ```

4. The despooling thread updates the Type 1 row for the receiving site in `PkgStatus`, raises a status message with ID 4400 and then exits.

   ```sql
   update PkgStatus set Status = 2, UpdateTime = N'Date Time', Location = N'\\PS1SITE.CONTOSO.COM\E$\SMSPKG\PackageID.PCK', ShareName = N'', HTTPUrl = N'', SourceVersion = 1, Personality = 0, State = 0, SigURL = N'', SigLocation = N'' where ID = N'PackageID' and Type = 1 and SiteCode = N'PS1' and PkgServer = N'PS1SITE.CONTOSO.COM'
   ```

   > SMS_DESPOOLER 4072 (0xfe8) STATMSG: ID=4400 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DESPOOLER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=4072 GMTDATE=Mon May 16 16:31:21.400 2016 ISTR0="\<PackageID>" ISTR1="\\\PS1SITE.CONTOSO.COM\E$\SMSPKG\\\<PackageID>.PCK" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="\<PackageID>"  
   > SMS_DESPOOLER 4072 (0xfe8) ~Despooler successfully executed one instruction.

#### Step 8: SMSDBMON notifies DistMgr to process the package

SMSDBMON detects a change in the `PkgNotification` table and drops a PKN file in `DistMgr.box` to instruct DistMgr to process the package.

> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) RCV: INSERT on PkgNotification for PkgNotify_Add [\<PackageID> ][1035289]  
> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) SND: Dropped E:\ConfigMgr\inboxes\distmgr.box\\**\<PackageID>.PKN** [1035289]

#### Step 9: DistMgr wakes up to process the package

DistMgr wakes up after detecting the PKN file and processes the package.

1. The main DistMgr thread creates a package processing thread.

   The main DistMgr thread adds the package to the package processing queue and creates a package processing thread.

   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) Found package properties updated notification for package '\<PackageID>'  
   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) Adding package '\<PackageID>' to package processing queue.  
   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) ~Currently using 0 out of 3 allowed package processing threads.  
   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) ~Started package processing thread for package '\<PackageID>', thread ID = **0x93C (2364)**

2. The package processing thread creates DP threads to process package actions and waits for them to exit.

   The package processing thread (**TID 2364**) processes the package actions (add/update/remove) for the DPs. In this case, the package was distributed to a DP and the package processing thread creates a DP thread to add the package to the DP. After creating the DP thread, the package processing thread waits for all the DP threads to exit before moving further.

   > SMS_DISTRIBUTION_MANAGER 2364 (0x93c) ~Processing package \<PackageID> (SourceVersion:1;StoredVersion:1)  
   > SMS_DISTRIBUTION_MANAGER 2364 (0x93c) Start updating the package \<PackageID>...  
   > SMS_DISTRIBUTION_MANAGER 2364 (0x93c) ~The Package Action is 1, the Update Mask is 160 and UpdateMaskEx is 0.  
   > SMS_DISTRIBUTION_MANAGER 2364 (0x93c) ~Use drive E for storing the compressed package.  
   > SMS_DISTRIBUTION_MANAGER 2364 (0x93c) ~Successfully created/updated the package \<PackageID> …  
   > SMS_DISTRIBUTION_MANAGER 2364 (0x93c) Start adding package \<PackageID> to server ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\...  
   > SMS_DISTRIBUTION_MANAGER 2364 (0x93c) ~**Created DP processing thread 5204** for addition or update of package \<PackageID> on server ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\ …  
   > SMS_DISTRIBUTION_MANAGER 2364 (0x93c) ~**Waiting for all DP threads to complete** for package \<PackageID> processing thread.

3. The DP threads create a PkgXferMgr job to transfer content to the DPs and then exits.

   The DP thread (**TID 5204**) starts working on adding the package to the DP. DP threads do not copy the package contents to the DP directly, but instead create a job for Package Transfer Manager (PkgXferMgr) instructing it to copy the package contents to the DP. The following log entries show the DP thread creating a PkgXferMgr job. After the job is created, the DP thread's work is done and the DP thread exits.

   > SMS_DISTRIBUTION_MANAGER 5204 (0x1454) DP Thread: Attempting to add or update package \<PackageID> on DP ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\  
   > SMS_DISTRIBUTION_MANAGER 5204 (0x1454) STATMSG: ID=2342 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=5204 GMTDATE=Mon May 16 16:31:37.364 2016 ISTR0="Dummy1" ISTR1="["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=2 AID0=400 AVAL0="\<PackageID>" AID1=404 AVAL1="["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\"  
   > SMS_DISTRIBUTION_MANAGER 5204 (0x1454) The current user context will be used for connecting to ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\.~  
   > SMS_DISTRIBUTION_MANAGER 5204 (0x1454) ~**Created package transfer job to send package** \<PackageID> to distribution point ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\.  
   > SMS_DISTRIBUTION_MANAGER 5204 (0x1454) STATMSG: ID=2357 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=5204 GMTDATE=Mon May 16 16:31:46.670 2016 ISTR0="PackageID" ISTR1="["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=2 AID0=400 AVAL0="\<PackageID>" AID1=404 AVAL1="["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\"  
   > SMS_DISTRIBUTION_MANAGER 5204 (0x1454) Performing cleanup prior to returning.  
   > SMS_DISTRIBUTION_MANAGER 5204 (0x1454) Cancelling network connection to \\\PS1DP1.CONTOSO.COM\ADMIN$.

   When the DP thread creates a PkgXferMgr job, it does so by inserting a row in `DistributionJobs` table.

   ```sql
   insert into DistributionJobs (DPID,PkgID,PackageVersion,State,CreationTime,Action) values(32,N'PackageID',1,0,N'Date Time',1)
   ```

   After creating the job, the DP thread also resets the Action for the DP in the `PkgServers_L` table.

   ```sql
   update PkgServers_L set UpdateMask = 0, Action = 0, RefreshTrigger = 0, LastRefresh = N'Date Time' where PkgID = N'PackageID' and NALPath = N'["Display=\\PS1DP1.CONTOSO.COM\"]MSWNET:["SMS_SITE=PS1"]\\PS1DP1.CONTOSO.COM\' and SiteCode = N'PS1' and Action <> 3
   ```

4. The package process thread exits after all DP threads exit.

   After all the DP threads exit, the package processing thread exits as well:

   > SMS_DISTRIBUTION_MANAGER 2364 (0x93c) ~DP thread for package \<PackageID> with thread handle 000000000000218C and thread ID 5204 ended.  
   > SMS_DISTRIBUTION_MANAGER 2364 (0x93c) ~All DP threads have completed for package \<PackageID> processing thread.  
   > SMS_DISTRIBUTION_MANAGER 2364 (0x93c) ~ **Exiting package processing thread for package** \<PackageID>.

#### Step 10: SMSDBMON notifies PkgXferMgr to process the job created in step 9-3

After the PkgxferMgr job is created in step 9-3, SMSDBMON detects a change in the `DistributionJobs` table and drops a PKN file in `PkgTransferMgr.box` to instruct PkgXferMgr to process the job:

> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) RCV: UPDATE on DistributionJobs for DistributionJob_Creation [\<PackageID>][1035292]  
> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) SND: Dropped E:\ConfigMgr\inboxes\PkgTransferMgr.box\\**\<PackageID>.PKN** [1035292]

#### Step 11: PkgXferMgr wakes up to process the job

1. The main PkgXferMgr thread creates a sending thread to the specified DP:

   > SMS_PACKAGE_TRANSFER_MANAGER 5392 (0x1510) Found send request with ID: 577, Package: \<PackageID>, Version:1, Priority: 2, Destination: PS1DP1.CONTOSO.COM, DPPriority: 200  
   > SMS_PACKAGE_TRANSFER_MANAGER 5392 (0x1510)  ~Created sending thread (**Thread ID = 0x12EC**)

2. The sending thread copies the content to the DP.

   The sending thread starts copying the package contents to the DP. This process involves copying all of the files in the package to the DP in the `SMS_DP$` directory. Since the package was not redistributed to the DP, the Redistribute action is set to **0**, which means that if a file already exists in the content library on the DP, it does not get recopied.

   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) Sending thread starting for Job: 577, package: \<PackageID>, Version: 1, Priority: 2, server: PS1DP1.CONTOSO.COM, DPPriority: 200  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) Sent status to the distribution manager for pkg \<PackageID>, version 1, status 0 and distribution point ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\~  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) Sending legacy content \<PackageID>.1 for package \<PackageID>  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) **Redistribute=0**, Related=  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) Sending file '\\\PS1DP1.CONTOSO.COM\SMS_DP$\73E055438D4731F41DB6C3BCB90919F60000226B330C73942454A174D7E26533-PackageID.1.temp'  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) Adding Dummy1.txt file in \<PackageID>.1.  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) Completed post-actions for remote DP PS1DP1.CONTOSO.COM  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) ~Sending completed successfully  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) user(NT AUTHORITY\SYSTEM) runing application(SMS_PACKAGE_TRANSFER_MANAGER) from machine (PS1SITE.CONTOSO.COM) is submitting SDK changes from site(PS1)  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) ~**Finished sending SWD package \<PackageID> version 1 to distribution point** PS1DP1.CONTOSO.COM  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) STATMSG: ID=8200 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_PACKAGE_TRANSFER_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=4844 GMTDATE=Mon May 16 16:34:27.614 2016 ISTR0="\<PackageID>" ISTR1="1" ISTR2="PS1DP1.CONTOSO.COM" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=2 AID0=400 AVAL0="\<PackageID>" AID1=410 AVAL1="1"

3. The sending thread sends a status message to DistMgr.

   After the sending thread finishes sending the content (success/failure), it sends the status to DistMgr so that DistMgr can process and update the status in the database. This status is sent to DistMgr by dropping an STA file containing the package status in the `DistMgr.box\incoming` directory.

   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) **Sent status to the distribution manager** for pkg \<PackageID>, version 1, **status 3** and distribution point ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\~  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) STATMSG: ID=8210 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_PACKAGE_TRANSFER_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=4844 GMTDATE=Mon May 16 16:34:27.614 2016 ISTR0="\<PackageID>" ISTR1="1" ISTR2="PS1DP1.CONTOSO.COM" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=3 AID0=400 AVAL0="\<PackageID>" AID1=410 AVAL1="1" AID2=404 AVAL2="["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\"  
   > SMS_PACKAGE_TRANSFER_MANAGER 4844 (0x12ec) Sending thread complete~

#### Step 12: SMS DP Provider adds the content copied in step 11-2 to the content library

During step 11-2, after copying each file, PkgXferMgr instructs the DP to add the file to the content library by executing methods against the `SMS_DistributionPoint` WMI class in the SMS DP Provider namespace (root\SCCMDP). When the content is successfully added to the content library, **SMSDPProv.log** shows the following:

> 2996 (0xbb4) Content '\<PackageID>.1' for package '\<PackageID>' has been added to content library successfully

#### Step 13: DistMgr processes the status message sent in step 11-3

To process the incoming **STA** file (sent in step 11-3), DistMgr uses the replication processing thread. This thread wakes up to process the STA file, updates the Type 2 row in the `PkgStatus`tables in the database and raises a status message with ID 2330 which means '*Distribution Manager successfully distributed package to distribution point*.'

> SMS_DISTRIBUTION_MANAGER 6116 (0x17e4) ~Processing incoming file E:\ConfigMgr\inboxes\distmgr.box\INCOMING\1R7IEEHU.STA.  
> SMS_DISTRIBUTION_MANAGER 6116 (0x17e4) ~Processing STA for regular DP ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\  
> SMS_DISTRIBUTION_MANAGER 6116 (0x17e4) ~Processing status update for package \<PackageID>  
> SMS_DISTRIBUTION_MANAGER 6116 (0x17e4) ~Successfully updated the package server status for ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\ for package \<PackageID>, Status 3  
> SMS_DISTRIBUTION_MANAGER 6116 (0x17e4) **STATMSG: ID=2330** SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=6116 GMTDATE=Mon May 16 16:34:31.679 2016 ISTR0="\<PackageID>" ISTR1="["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=2 AID0=400 AVAL0="\<PackageID>" AID1=404 AVAL1="["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\"  
> SMS_DISTRIBUTION_MANAGER 6116 (0x17e4) ~Successfully delete package status file E:\ConfigMgr\inboxes\distmgr.box\INCOMING\1R7IEEHU.STA

This thread runs the following query to update the status in the database.

```sql
update PkgStatus set Status = 3, UpdateTime = N'Date Time', Location = N'MSWNET:["SMS_SITE=PS1"]\\PS1DP1.CONTOSO.COM\SMSPKGC$\PackageID\', ShareName = N'', HTTPUrl = N'http://PS1DP1.CONTOSO.COM/SMS_DP_SMSPKG$/\PackageID', SourceVersion = 1, Personality = 0, State = 0, SigURL = N'http://PS1DP1.CONTOSO.COM/SMS_DP_SMSSIG$/\PackageID', SigLocation = N'MSWNET:["SMS_SITE=PS1"]\\PS1DP1.CONTOSO.COM\SMSSIG$\\PackageID.1.tar'  where ID = N'\PackageID' and Type = 2 and SiteCode = N'PS1' and PkgServer = N'["Display=\\PS1DP1.CONTOSO.COM\"]MSWNET:["SMS_SITE=PS1"]\\PS1DP1.CONTOSO.COM\'
```

#### Step 14: Package status changes are replicated to other sites via database replication

After the package status is updated in the database, it is replicated to other sites via database replication.

## Distribute a package to standard DP

The following steps outline the flow of events when a package is distributed to a DP in the primary site, and this primary site server in question already has a copy of the package in the content library:  

### Step 1: The administrator distributes the package to the DP. The administrator can do so from the admin console connected directly to the primary site in question or the central administration site, or a different primary site

After the administrator distributes the package to a DP from the console, the admin console calls the `AddDistributionPoints` method of the `SMS_Package` class to add the specified DP to the package. **SMSProv.log** shows the following:

> SMS Provider 4416 (0x1140) Context: SMSAppName=Configuration Manager Administrator console~  
> SMS Provider 4416 (0x1140) ExecMethodAsync : SMS_Package.PackageID="\<PackageID>"::AddDistributionPoints~  
> SMS Provider 4416 (0x1140) CExtProviderClassObject::DoExecuteMethod AddDistributionPoints~  
> SMS Provider 4416 (0x1140) Auditing: User CONTOSO\Admin called an audited method of an instance of class SMS_Package.~

When this method is called, SMS Provider inserts a row in `PkgServers` with `Action` set to **2** (ADD):

```sql
insert PkgServers (PkgID, NALPath, SiteCode, SiteName, SourceSite, LastRefresh, RefreshTrigger, UpdateMask, Action) select N'<PackageID>', N'["Display=\\PS1DP2.CONTOSO.COM\"]MSWNET:["SMS_SITE=PS1"]\\PS1DP2.CONTOSO.COM\', N'PS1', Sites.SiteName, N'PS1', N'04/10/1970 06:35:00', 0, 0, 2  from Sites where SiteCode = N'PS1'
insert PkgNotification (PkgID, Priority, Type, TimeKey) values (N'<PackageID>', 2, 4, GetDate())
```

### Step 2: If the administrator distributes the package from a different primary site or the central administration site, Database Replication Service (DRS) replicates changes to the site in question

If the administrator distributes this package with the console connected to the central administration site or a different primary site, DRS replicates the changes in `PkgServers` to other sites.

### Step 3: SMSDBMON notifies DistMgr to process the package

After the change is replicated to the site where the DP resides, SMSDBMON detects a change in the `PkgNotification` table and drops a PKN file in `DistMgr.box` to instruct DistMgr to process the package:

> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) RCV: INSERT on PkgNotification for PkgNotify_Add [\<PackageID>][1035417]  
> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) SND: Dropped E:\ConfigMgr\inboxes\distmgr.box\\\<PackageID>.PKN [1035417]

### Step 4: DistMgr wakes up to process the package

DistMgr wakes up after detecting the PKN file and processes the package.

1. The main DistMgr thread starts a package processing thread.

   The main DistMgr thread adds the package to the package processing queue and creates a package processing thread.

   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) Adding package '\<PackageID>' to package processing queue.  
   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) ~Currently using 0 out of 3 allowed package processing threads.  
   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) ~Started package processing thread for package '\<PackageID>', thread ID = **0xB58 (2904)**

2. The package processing thread creates DP threads to process package actions, then waits for them to exit.

   The package processing thread (**TID 2904**) processes the package actions (add/update/remove) for the DP. In this case, the package was added to a DP and the package processing thread creates a DP thread to add the package to the DP. After creating the DP thread, the package processing thread waits for all the DP threads to exit before moving further:

   > SMS_DISTRIBUTION_MANAGER 2904 (0xb58) ~Processing package \<PackageID> (SourceVersion:1;StoredVersion:1)  
   > SMS_DISTRIBUTION_MANAGER 2904 (0xb58) No action specified for the package \<PackageID>, however there may be package server changes for this package.  
   > SMS_DISTRIBUTION_MANAGER 2904 (0xb58) Start adding package \<PackageID> to server ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\...  
   > SMS_DISTRIBUTION_MANAGER 2904 (0xb58) ~Created DP processing thread **3792** for addition or update of package \<PackageID> on server ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\
   > SMS_DISTRIBUTION_MANAGER 2904 (0xb58) ~Waiting for all DP threads to complete for package \<PackageID> processing thread.

3. The DP threads create a Package Transfer Manager (PkgXferMgr) job to transfer content to the DPs and then exits.

   The DP thread (**TID 3792**) starts the work of adding the package to the DP. The DP threads do not copy the package contents to the DP directly, but instead create a job for PkgXferMgr instructing it to copy the package contents to the DP. The following log entries show the DP thread creating a PkgXferMgr job. After the job is created, the DP thread's work is done and the DP thread exits.

   > SMS_DISTRIBUTION_MANAGER 3792 (0xed0) DP Thread: Attempting to add or update package \<PackageID> on DP ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\  
   > SMS_DISTRIBUTION_MANAGER 3792 (0xed0) ~**Created package transfer job to send package** \<PackageID> to distribution point ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\.  
   > SMS_DISTRIBUTION_MANAGER 3792 (0xed0) STATMSG: ID=2357 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=3792 GMTDATE=Mon May 16 19:26:58.642 2016 ISTR0="\<PackageID>" ISTR1="["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=2 AID0=400 AVAL0="\<PackageID>" AID1=404 AVAL1="["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\"

   When the DP thread creates a PkgXferMgr job, it does so by inserting a row in `DistributionJobs` table.

   ```sql
   insert into DistributionJobs (DPID,PkgID,PackageVersion,State,CreationTime,Action) values(35,N'PackageID',1,0,N'2016/05/16 15:26:58',1)
   ```

   After creating the job, the DP thread also resets the **Action** for the DP in `PkgServers_L` table:

   ```sql
   update PkgServers_L set UpdateMask = 0, Action = 0, RefreshTrigger = 0, LastRefresh = N'05/16/2016 19:26:58' where PkgID = N'PackageID' and NALPath = N'["Display=\\PS1DP2.CONTOSO.COM\"]MSWNET:["SMS_SITE=PS1"]\\PS1DP2.CONTOSO.COM\' and SiteCode = N'PS1' and Action <> 3
   ```

4. The package processing thread exits after all DP threads exit.

   After all of the DP threads exit, the package processing thread exits as well.

   > SMS_DISTRIBUTION_MANAGER 2904 (0xb58) ~DP thread for package \<PackageID> with thread handle 0000000000002524 and thread ID 3792 ended.  
   > SMS_DISTRIBUTION_MANAGER 2904 (0xb58) ~All DP threads have completed for package \<PackageID> processing thread.  
   > SMS_DISTRIBUTION_MANAGER 2904 (0xb58) ~Exiting package processing thread for package \<PackageID>.

### Step 5: SMSDBMON notifies PkgXferMgr to process the job

After the PkgxferMgr job is created, SMSDBMON this time detects a change in the `DistributionJobs` table and drops a PKN file in `PkgTransferMgr.box` to instruct PkgXferMgr to process the job:

> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) RCV: UPDATE on DistributionJobs for DistributionJob_Creation [\<PackageID>][1035419]  
> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) SND: Dropped E:\ConfigMgr\inboxes\PkgTransferMgr.box\\\<PackageID>.PKN [1035419]

### Step 6: PkgXferMgr wakes up to process the job

1. The main PkgXferMgr thread creates a sending thread.

   The main PkgXferMgr thread creates a sending thread to send the package to the specified DP.

   > SMS_PACKAGE_TRANSFER_MANAGER 5392 (0x1510) Found send request with ID: 582, Package: \<PackageID>, Version:1, Priority: 2, Destination: PS1DP2.CONTOSO.COM, DPPriority: 200  
   > SMS_PACKAGE_TRANSFER_MANAGER 5392 (0x1510) ~Created sending thread (Thread ID = **0xBCC**)

2. The sending thread copies content to the DP.

   The sending thread (**TID 3020**) starts copying the package contents to the DP. This process involves copying all the files in the package to the DP in the `SMS_DP$` directory. Since the package was not redistributed to the DP, the redistribute action is set to **0**, which means that if a file already exists in the content library on the DP, it does not get re-copied.

   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) Sending thread starting for Job: 582, package: \<PackageID>, Version: 1, Priority: 2, server: PS1DP2.CONTOSO.COM, DPPriority: 200  
   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) Sent status to the distribution manager for pkg \<PackageID>, version 1, status 0 and distribution point ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\~  
   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) Sending legacy content \<PackageID>.1 for package \<PackageID>  
   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) Redistribute=0, Related=
   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) Sending file '\\\PS1DP2.CONTOSO.COM\SMS_DP$\73E055438D4731F41DB6C3BCB90919F60000226B330C73942454A174D7E26533-PackageID.1.temp'  
   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) Adding Dummy1.txt file in \<PackageID>.1  
   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) Completed post-actions for remote DP PS1DP2.CONTOSO.COM  
   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) ~Sending completed successfully  
   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) ~Finished sending SWD package \<PackageID> version 1 to distribution point PS1DP2.CONTOSO.COM  
   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) STATMSG: ID=8200 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_PACKAGE_TRANSFER_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=3020 GMTDATE=Mon May 16 19:28:12.991 2016 ISTR0="\<PackageID>" ISTR1="1" ISTR2="PS1DP2.CONTOSO.COM" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=2 AID0=400 AVAL0="\<PackageID>" AID1=410 AVAL1="1"

3. The sending thread sends a status message to DistMgr.

   After the sending thread finishes sending the content (success/failure), it sends the status to DistMgr so that DistMgr can process and update the status in the database. This status is sent to DistMgr by dropping an **STA** file containing the package status in the `DistMgr.box\incoming` directory:

   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) Sent status to the distribution manager for pkg PackageID, version 1, status 3 and distribution point ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\~  
   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) STATMSG: ID=8210 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_PACKAGE_TRANSFER_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=3020 GMTDATE=Mon May 16 19:28:13.003 2016 ISTR0="\<PackageID>" ISTR1="1" ISTR2="PS1DP2.CONTOSO.COM" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=3 AID0=400 AVAL0="\<PackageID>" AID1=410 AVAL1="1" AID2=404 AVAL2="["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\"  
   > SMS_PACKAGE_TRANSFER_MANAGER 3020 (0xbcc) Sending thread complete~

### Step 7: SMS DP Provider adds the content to the content library

After copying each file, PkgXferMgr instructs the DP to add the file to the content library by executing methods against the `SMS_DistributionPoint` WMI class in the SMS DP Provider namespace (root\SCCMDP). When the content is successfully added to the content Library, **SMSDPProv.log** shows the following:

> 1304 (0x518) Content '\<PackageID>.1' for package '\<PackageID>' has been added to content library successfully

#### Step 8: DistMgr processes the status messages sent by PkgXferMgr

To process the incoming **STA** file (sent in step 6-3), DistMgr uses the replication processing thread. This thread wakes up to process the STA file, updates the Type 2 row in the `PkgStatus` tables in the database and raises a status message with ID 2330 which means '*Distribution Manager successfully distributed package to distribution point*.'

> SMS_DISTRIBUTION_MANAGER 6116 (0x17e4) ~Processing incoming file E:\ConfigMgr\inboxes\distmgr.box\INCOMING\FV8S6B6M.STA.  
> SMS_DISTRIBUTION_MANAGER 6116 (0x17e4) ~Processing STA for regular DP ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\  
> SMS_DISTRIBUTION_MANAGER 6116 (0x17e4) ~Processing status update for package \<PackageID>  
> SMS_DISTRIBUTION_MANAGER 6116 (0x17e4) ~Successfully updated the package server status for ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\ for package \<PackageID>, **Status 3**  
> SMS_DISTRIBUTION_MANAGER    6116 (0x17e4)    STATMSG: ID=2330 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=6116 GMTDATE=Mon May 16 19:28:16.577 2016 ISTR0="\<PackageID>" ISTR1="["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=2 AID0=400 AVAL0="\<PackageID>" AID1=404 AVAL1="["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\"  
> SMS_DISTRIBUTION_MANAGER    6116 (0x17e4)    ~Successfully delete package status file E:\ConfigMgr\inboxes\distmgr.box\INCOMING\FV8S6B6M.STA

This thread runs the following query to update the status in the database.

```sql
update PkgStatus set Status = 3, UpdateTime = N'Date Time', Location = N'MSWNET:["SMS_SITE=PS1"]\\PS1DP2.CONTOSO.COM\SMSPKGC$\\PackageID\', ShareName = N'', HTTPUrl = N'http://PS1DP2.CONTOSO.COM/SMS_DP_SMSPKG$/\PackageID', SourceVersion = 1, Personality = 0, State = 0, SigURL = N'http://PS1DP2.CONTOSO.COM/SMS_DP_SMSSIG$/\PackageID', SigLocation = N'MSWNET:["SMS_SITE=PS1"]\\PS1DP2.CONTOSO.COM\SMSSIG$\\PackageID.1.tar'  where ID = N'\PackageID' and Type = 2 and SiteCode = N'PS1' and PkgServer = N'["Display=\\PS1DP2.CONTOSO.COM\"]MSWNET:["SMS_SITE=PS1"]\\PS1DP2.CONTOSO.COM\'
```

### Step 9: Package status changes are replicated to other sites via DRS

After the package status is updated in the database, it is replicated to other sites via database replication.

## Distribute a package to pull DP

The following steps outline the flow of events when a Package is distributed to a pull DP in the primary site and this primary site server in question already has a copy of the package in the content library.

### Step 1: Administrator distribute the package to the DP. The administrator can do so from the admin console connected directly to the primary site in question or the central administration site or a different Primary Site

After the administrator distributed the package to a DP from the console, console calls the `AddDistributionPoints` method of the appropriate derived class of `SMS_Package` (`SMS_ContentPackage` for applications in the example below) class to add the specified DP to the package. **SMSProv.log** shows:

> SMS Provider 22172 (0x569c) Context: SMSAppName=Configuration Manager Administrator console~  
> SMS Provider 22172 (0x569c) ExecMethodAsync : SMS_ContentPackage.PackageID='P010000F'::AddDistributionPoints~  
> SMS Provider 22172 (0x569c) CExtProviderClassObject::DoExecuteMethod AddDistributionPoints~  
> SMS Provider 22172 (0x569c) Auditing: User CONTOSO\Admin called an audited method of an instance of class SMS_ContentPackage.~

When this method is called, SMS Provider inserts a row in PkgServers with `Action` set to **2** (ADD) and a notification is created in the `PkgNotification` table.  

### Step 2: If administrator distributes the package from a different primary site or the central administration site, DRS replicates changes to the site in question

If the administrator distributed this package with the console connected to the central administration site or a different primary site, DRS replicates the changes in PkgServers to other sites.

### Step 3: SMSDBMON notifies DistMgr to process the package

After this change is replicated to the site where the DP resides, SMSDBMON detects a change in `PkgNotification` table, and drops a PKN file in `DistMgr.box` to instruct DistMgr to process the package.

> SMS_DATABASE_NOTIFICATION_MONITOR 29748 (0x7434) RCV: INSERT on PkgNotification for PkgNotify_Add [P010000F ][145011]  
> SMS_DATABASE_NOTIFICATION_MONITOR 29748 (0x7434) SND: Dropped E:\ConfigMgr\inboxes\distmgr.box\P010000F.PKN [145011]

### Step 4: DistMgr wakes up to process the package

DistMgr wakes up after detecting the PKN file and processes the package.

1. Main DistMgr thread starts a Package Processing Thread.

   Main DistMgr thread adds the package to the package processing queue, and creates a package processing thread.

   > SMS_DISTRIBUTION_MANAGER 5292 (0x14ac) Adding package 'P010000F' to package processing queue.  
   > SMS_DISTRIBUTION_MANAGER 5292 (0x14ac) ~Currently using 0 out of 3 allowed package processing threads.  
   > SMS_DISTRIBUTION_MANAGER 5292 (0x14ac) ~Started package processing thread for package 'P010000F', thread ID = 0x2C44 (11332)

2. Package processing thread creates DP thread(s) to process package actions and waits for them to exit.

   Package processing thread (TID 11332) processes the package actions (add/update/remove) for the DP(s). In this case, the package was added to a DP and the package processing thread creates a DP thread to add the package to the DP. After creating DP thread(s), the package processing thread waits for all the DP threads to exit before moving further.

   > SMS_DISTRIBUTION_MANAGER    11332 (0x2c44)    ~Processing package P010000F (SourceVersion:3;StoredVersion:3)  
   > SMS_DISTRIBUTION_MANAGER    11332 (0x2c44)    No action specified for the package P010000F, however there may be package server changes for this package.  
   > SMS_DISTRIBUTION_MANAGER    11332 (0x2c44)    Start adding package P010000F to server ["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\...  
   > SMS_DISTRIBUTION_MANAGER    11332 (0x2c44)    ~Created DP processing thread 22444 for addition or update of package P010000F on server ["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\  
   > SMS_DISTRIBUTION_MANAGER    11332 (0x2c44)    ~Waiting for all DP threads to complete for package P010000F processing thread.

3. DP thread creates a PkgXferMgr job to transfer content to the DPs and exits.

   DP thread (TID 22444) starts working on adding the package to the DP. DP threads do not copy the package contents to the DP directly, and instead create a job for Package Transfer Manager (PkgXferMgr) instructing it to copy the package contents to the DP. Following log entries show the DP thread creating a PkgXferMgr job. After the job is created, DP thread's work is done and the DP thread exits.

   > SMS_DISTRIBUTION_MANAGER    22444 (0x57ac)    DP Thread: Attempting to add or update package P010000F on DP ["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\  
   > SMS_DISTRIBUTION_MANAGER    22444 (0x57ac)    Package Server ["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\ is a PullDP.  
   > SMS_DISTRIBUTION_MANAGER    22444 (0x57ac)    ~Created package transfer job to send package P010000F to distribution point ["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\.  
   > SMS_DISTRIBUTION_MANAGER    22444 (0x57ac)    STATMSG: ID=2357 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=P01SITE.CONTOSO.COM SITE=P01 PID=36968 TID=22444 GMTDATE=Mon Jan 07 20:05:18.665 2019 ISTR0="P010000F" ISTR1="["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=2 AID0=400 AVAL0="P010000F" AID1=404 AVAL1="["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\"

   When the DP thread creates a PkgXferMgr job, it does so by inserting a row in `DistributionJobs` table.

   ```sql
   insert into DistributionJobs (DPID,PkgID,PackageVersion,State,CreationTime,Action) values(8,N'P010000F',3,0,N'2019/01/07 20:05:18',1)
   ```

   After creating the job, the DP thread also resets the Action for the DP in `PkgServers_L` table.

4. Package processing thread exits after all DP threads exit.

   After all the DP threads exit, package processing thread exits as well.

   > SMS_DISTRIBUTION_MANAGER 11332 (0x2c44) ~DP thread for package P010000F with thread handle 0000000000003E2C and thread ID 22444 ended.  
   > SMS_DISTRIBUTION_MANAGER 11332 (0x2c44) ~All DP threads have completed for package P010000F processing thread.  
   > SMS_DISTRIBUTION_MANAGER 11332 (0x2c44) ~StoredPkgVersion (3) of package P010000F. StoredPkgVersion in database is 3.  
   > SMS_DISTRIBUTION_MANAGER 11332 (0x2c44) ~SourceVersion (3) of package P010000F. SourceVersion in database is 3.  
   > SMS_DISTRIBUTION_MANAGER 11332 (0x2c44) ~Exiting package processing thread for package P010000F.

### Step 5: SMSDBMON notifies PkgXferMgr to process the job

After the PkgxferMgr job is created, SMSDBMON this time detects a change in `DistributionJobs` table and drops a PKN file in `PkgTransferMgr.box` to instruct PkgXferMgr to process the job.

> SMS_DATABASE_NOTIFICATION_MONITOR    29748 (0x7434)    RCV: UPDATE on DistributionJobs for DistributionJob_Creation [P010000F  ][145013]  
> SMS_DATABASE_NOTIFICATION_MONITOR    29748 (0x7434)    SND: Dropped E:\ConfigMgr\inboxes\PkgTransferMgr.box\P010000F.PKN  [145013]

### Step 6: PkgXferMgr wakes up to process the job

1. Main PkgXferMgr thread creates a pull DP sending thread to send the package to the specified DP.

   > SMS_PACKAGE_TRANSFER_MANAGER    32936 (0x80a8)    Found send request with ID: 190, Package: P010000F, Version:3, Priority: 2, Destination: P01PDP1.CONTOSO.COM, DPPriority: 200  
   > SMS_PACKAGE_TRANSFER_MANAGER    32936 (0x80a8)    ~Created sending thread (Thread ID = 0x2B4C)

2. Pull DP sending thread sends a notification to the pull DP

   Unlike a regular sending thread, pull DP sending thread (TID 11084) instructs the pull DP to start downloading the content by sending a notification. This is done in 4 phases.

   **Phase 1:** Pull DP sending thread checks to see if the content being distributed to the pull DP is available on a source DP(s). If the content is not available on the source DP, the pull DP sending thread ends with the below message in the log and raises **Status Message ID 8212** which means '*This pull distribution point has no sources from which it can download content. We will try again later*.' Retries are attempted later based on **Retry** settings configured in **Software Distribution Component Configuration** > **Pull Distribution Point** tab.

   > ~Unable to find any source locations for one or more contents under package P0100009, for pull DP P01PDP1.CONTOSO.COM. Notification not sent.  
   > ~ PullDP notification failed. Failure count = 1/30, Restart time = 1/10/2019 2:00:42 AM Eastern Standard Time  
   STATMSG: ID=8212 SEV=I LEV=M SOURCE='SMS Server' COMP='SMS_PACKAGE_TRANSFER_MANAGER' SYS=P01SITE.CONTOSO.COM SITE=P01 PID=2336...

   Here's the query that is executed to check if content is available on a source DP:

   ```sql
   SELECT p.SourceDPServerName FROM PullDPMap p INNER JOIN ContentDPMap c ON p.SourceDPServerName = c.ServerName WHERE c.AccessType = 1 AND p.PullDPServerName = 'P01PDP1.CONTOSO.COM' AND c.ContentID = 'P0100009' AND c.Version = 4
   ```

   **Phase 2:** Pull DP sending thread checks to see if the pull DP has capacity for more jobs. By default, pull DPs can handle 50 jobs simultaneously. This is controlled by the **PullDP Number Of Active Jobs** SCF property for `SMS_DISTRIBUTION_MANAGER` and it's not recommended to increase the capacity because it can introduce [scalability issues](/windows/win32/bits/best-practices-when-using-bits#scalability). If the pull DP is already working at max capacity (i.e., it has 50 running jobs), the pull DP sending thread ends with the below message in the log and retries later based on **Retry** settings configured in **Software Distribution Component Configuration** > **Pull Distribution Point** tab.

   > PullDP \<DPNALPATH> has reached maximum capacity 50  
   > PullDP has no capacity. Restart time = \<timestamp>  
   > STATMSG: ID=8211 SEV=E LEV=M SOURCE="SMS Server" COMP="SMS_PACKAGE_TRANSFER_MANAGER" SYS=P01SITE.CONTOSO.COM SITE=P01 PID=17252 TID=4712…

   Here's the query that is used to determine if pull DP is at capacity:

   ```sql
   SELECT COUNT(*) FROM DistributionJobs job
   JOIN DistributionPoints dp ON dp.DPID=job.DPID AND dp.NALPath='["Display=\\P01PDP1.CONTOSO.COM\"]MSWNET:["SMS_SITE=P01"]\\P01PDP1.CONTOSO.COM\'
   WHERE job.State in (2, 3, 4) AND (job.Action<>5) AND (ISNULL(job.SendAction, '') <> '')
   ```

   **Phase 3:** Pull DP sending thread sends a package info bundle file which contains a metadata of the files that need to be downloaded. This file is a *\<PackageID>.TZ* file which generated from the package INI file from the site servers content library and is copied to the `SMS_DP$` directory on the pull DP.

   > SMS_PACKAGE_TRANSFER_MANAGER    11084 (0x2b4c)    Pull DP Sending thread starting for Job: 190, package: P010000F, Version: 3, Priority: 2, server: P01PDP1.CONTOSO.COM, DPPriority: 200  
   > SMS_PACKAGE_TRANSFER_MANAGER    11084 (0x2b4c)    Sending package info bundle P010000F to PullDP. ["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\

   **Phase 4:** Pull DP sending thread creates an instance of `SMS_PullDPNotification` class on the pull DP within `root\SCCMDP` namespace, which contains the package ID, package version and an XML notification. After creating the instance of `SMS_PullDPNotification` class, it executes the `NotifyPullDP` method in the `SMS_DistributionPoint` class in the `root\SCCMDP` namespace which instructs the DP WMI Provider to notify the pull DP component to start downloading the content.

   > SMS_PACKAGE_TRANSFER_MANAGER    11084 (0x2b4c)    ~Successfully performed WMI actions on pull DP P01PDP1.CONTOSO.COM.  
   > SMS_PACKAGE_TRANSFER_MANAGER    11084 (0x2b4c)    ~ PullDP notification sent. Attempted count = 1/30, Restart time = 1/7/2019 4:06:04 PM Eastern Standard Time  
   > SMS_PACKAGE_TRANSFER_MANAGER    11084 (0x2b4c)    Pull DP Sending thread complete~

   Notification XML is generated by calling `fnGetPullDPXMLNotification`. Here's how a sample query that generates the notification XML query looks like which shows that the **Action** is **add** since the content was not redistributed:

   ```sql
   SELECT [dbo].[fnGetPullDPXMLNotification]('P010000F', 3, 'P01PDP1.CONTOSO.COM', 2, 'add', 1, 'O:SYG:BAD:P(A;;FA;;;BA)(A;OICIIO;GA;;;BA)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)(A;;FA;;;BA)(A;OICIIO;GA;;;BA)', 0, 32780, '3ED23B9869F7E10E19439F11341405FF76E22022E56468DCF211475899BD2914', '') AS Notification
   ```

   The XML notification contains the content metadata along with the source DP location. Here's how a sample XML notification looks like:

   ```xml
   <PullDPNotification>
      <PullDPPackageNotification PackageID='P010000F' Version='3' Action='redist' AllowFallback='true' Priority='2' PackageType='content' PackageTypeID='8' PackageFlags='16777216' PackageSize='5532' SDDL='O:SYG:BAD:P(A;;FA;;;BA)(A;OICIIO;GA;;;BA)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)(A;;FA;;;BA)(A;OICIIO;GA;;;BA)' HashAlgorithm='32780' Hash='3ED23B9869F7E10E19439F11341405FF76E22022E56468DCF211475899BD2914' ExpandShare='0' ShareName='' ShareType='1'>
        <PullDPPackageContent ContentID='Content_3c9813ba-d7ab-4963-929c-36f90f479613.1' RelatedContentID='Content_162d6f21-176e-4e4b-a620-6e94a4b9f73e.1'>
           <DPLocation DPUrl='http://P01MP.CONTOSO.COM/SMS_DP_SMSPKG$/Content_3c9813ba-d7ab-4963-929c-36f90f479613.1' Rank='1' Type='Windows NT Server' Protocol='https' />
        </PullDPPackageContent>
      </PullDPPackageNotification>
   </PullDPNotification>
   ```

3. Pull DP sending thread updates the job so status polling can start.

   Unlike a sending thread for a standard DP which deletes the job after successful completion, pull DP sending thread updates the job in `DistributionJobs` table and sets the `SendAction` to `PullQueryResultAction` after successfully sending the notification to the pull DP.

   ```sql
   update DistributionJobs set DPID=8,SendAction = N'PullQueryResultAction', LastUpdateTime = N'2019/01/07 21:07:14' where JobID = 194
   ```

   State messages are used as the primary mechanism for distribution status reporting from the pull DP and the distribution job remains in the database until we are notified of success/failure status of the job. PkgXferMgr starts polling at scheduled intervals (configurable in the **Software Distribution Component Properties** > **Pull Distribution Point** tab) to check whether the content has been downloaded on the pull DP. Although the pull DP sends a state message containing the distribution status, PkgXferMgr also performs polling as a backup mechanism to get the distribution status in case pull DP cannot send a state message to the management point for some reason.

4. (On polling interval): Pull DP sending thread is created to poll the distribution status from the pull DP.

   A new pull DP sending thread starts after **Delay before polling (minutes)** value specified in the **Software Distribution Component Properties** to check the distribution status. In the below example, it queries the pull DP and finds that the content has been installed successfully and sends a status message to Distribution Manager.

   > SMS_PACKAGE_TRANSFER_MANAGER    18724 (0x4924)    Pull DP Sending thread starting for Job: 194, package: P010000F, Version: 3, Priority: 2, server: P01PDP1.CONTOSO.COM, DPPriority: 200  
   > SMS_PACKAGE_TRANSFER_MANAGER    18724 (0x4924)    ~Finished sending SWD package P010000F version 3 to distribution point P01PDP1.CONTOSO.COM  
   > SMS_PACKAGE_TRANSFER_MANAGER    18724 (0x4924)    Sent status to the distribution manager for pkg P010000F, version 3, status 3 and distribution point ["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\~  
   > SMS_PACKAGE_TRANSFER_MANAGER    18724 (0x4924)    STATMSG: ID=8210 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_PACKAGE_TRANSFER_MANAGER" SYS=P01SITE.CONTOSO.COM SITE=P01 PID=36968 TID=18724 GMTDATE=Mon Jan 07 22:22:16.059 2019 ISTR0="P010000F" ISTR1="3" ISTR2="P01PDP1.CONTOSO.COM" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=3 AID0=400 AVAL0="P010000F" AID1=410 AVAL1="3" AID2=404 AVAL2="["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\"  
   > SMS_PACKAGE_TRANSFER_MANAGER    18724 (0x4924)    Pull DP Sending thread complete~

   Note that the job is deleted from the database when after receiving a success status message from the pull DP, which causes the polling to stop.  

### Step 7: SMS DP Provider notifies pull DP component (CcmExec) to process the job

On execution of the `NotifyPullDP` method, DP WMI Provider notifies CcmExec which hosts the pull DP component. **SMSDPProv.log** shows:

> 4688 (0x1250)        Successfully notified PullDP

### Step 8: Pull DP loads the job(s) from WMI

On receiving a notification, pull DP component loads the job(s) from WMI as well as validates the *\<PackageID>.TZ* file that was copied by PkgxferMgr.

> PullDP    4404 (0x1134)    CPullDPService::LoadJobsFromXML for P010000F.3  
> PullDP    4404 (0x1134)    - P010000F.3 - XML has 1 content jobs.  
> PullDP    4404 (0x1134)    CPullDPPkgContJob::LoadContentJobFromXML(): Set JobState = NotStarted  
> PullDP    4404 (0x1134)    - P010000F.3 - Loaded content job {C10457F9-DE3A-4B45-878C-345919AFF97E} for content Content_3c9813ba-d7ab-4963-929c-36f90f479613.1 from XML...  
> PullDP    4404 (0x1134)    CPullDPPkgJob::LoadJobFromXML() successfully loaded job for package P010000F.3, there are 1 content jobs. ...  
> PullDP    4404 (0x1134)    Successfully verified content info Hash E:\SMS_DP$\P010000F.tz :3ED23B9869F7E10E19439F11341405FF76E22022E56468DCF211475899BD2914  
> PullDP    4404 (0x1134)    CPullDPService::ExecuteJobs(). 1 jobs to do  

### Step 9: Pull DP creates content job(s) to download the content associated with the package

> PullDP    4404 (0x1134)    P010000F.3 Starting Download  there are 1 content jobs.  
> PullDP    3812 (0xee4)    Content job {C10457F9-DE3A-4B45-878C-345919AFF97E} running.  
> PullDP    3812 (0xee4)    ContentExecuteJob {C10457F9-DE3A-4B45-878C-345919AFF97E} (state: 1-NotStarted) for package P010000F.3 content Content_3c9813ba-d7ab-4963-929c-36f90f479613.1.

In the example above, the job *{C10457F9-DE3A-4B45-878C-345919AFF97E}* is associated with content *Content_3c9813ba-d7ab-4963-929c-36f90f479613.1*. For a package with multiple content items, you would see the number of jobs (with a unique ID) associated with the package.

> PullDP    1320 (0x528)    P010000A.2 Starting Download  there are 2 content jobs.  
> PullDP    5012 (0x1394)    ContentExecuteJob {55692006-DFE8-4357-86D9-9839C8BF79CF} (state: 1-NotStarted) for package P010000A.2 content 2484568c-7aba-44ae-8557-05b61d62e70d.  
> PullDP    4112 (0x1010)    ContentExecuteJob {7175CD81-CF67-48C9-AA22-010BF60B640E} (state: 1-NotStarted) for package P010000A.2 content c085b4ba-8e8f-42bf-8e2d-bc1067697722.

### Step 10: (If applicable) Pull DP downloads content signature

(If applicable) Content job creates a Data Transfer Service (DTS) job to download the package signature. The signature file is a TAR file which is downloaded from the `SMSSIG$` virtual directory from the source distribution point and contains the RDC signatures for each file in the content. The RDC signatures are used to determine if the file content have changed and whether to download delta content or full content. This step is only applicable for content that has changed, so you may not always see this step, and would see step 11 instead.

> PullDP    3812 (0xee4)    Created SignatureDownload DTS job {3C962758-7ABE-40F2-A585-E5B59E378BEA} for package P010000F.3, content id Content_3c9813ba-d7ab-4963-929c-36f90f479613.1. JobState = NotStarted  
> PullDP    3812 (0xee4)    CPullDPPkgContJob::NotifyDeltaDownload. JobState = [Downloading Signature] Content_3c9813ba-d7ab-4963-929c-36f90f479613.1 for package P010000F.3 content job id {C10457F9-DE3A-4B45-878C-345919AFF97E}  
> PullDP    752 (0x2f0)    ContentExecuteJob {C10457F9-DE3A-4B45-878C-345919AFF97E} (state: 4-Downloading Signature) for package P010000F.3 content Content_3c9813ba-d7ab-4963-929c-36f90f479613.1.

**DataTransferService.log** shows the progress of the DTS job, which creates a BITS job to download the signature file and notifies upon completion:

> DataTransferService    3812 (0xee4)    DTSJob {3C962758-7ABE-40F2-A585-E5B59E378BEA} created to download from '<`https://P01MP.CONTOSO.COM:443/SMS_DP_SMSSIG$`>' to 'E:\SMS_DP$\P010000F\Content_3c9813ba-d7ab-4963-929c-36f90f479613.1'.  
> DataTransferService    3856 (0xf10)    Starting BITS download for DTS job '{3C962758-7ABE-40F2-A585-E5B59E378BEA}'.  
> DataTransferService    3856 (0xf10)    Starting BITS job '{43647077-986C-4727-A954-B327ECA50302}' for DTS job '{3C962758-7ABE-40F2-A585-E5B59E378BEA}' under user 'S-1-5-18'.  
> DataTransferService    3856 (0xf10)    Adding to BITS job: Content_3c9813ba-d7ab-4963-929c-36f90f479613.1.tar  
> DataTransferService    2528 (0x9e0)    DTSJob {3C962758-7ABE-40F2-A585-E5B59E378BEA} successfully completed download.  
> DataTransferService    3856 (0xf10)    Execute called for DTS job '{3C962758-7ABE-40F2-A585-E5B59E378BEA}'.  Current state: 'RetrievedData'.  
> DataTransferService    3856 (0xf10)    DTSJob {3C962758-7ABE-40F2-A585-E5B59E378BEA} in state 'NotifiedComplete'.  
> DataTransferService    3856 (0xf10)    DTS job {3C962758-7ABE-40F2-A585-E5B59E378BEA} has completed:

Pull DP receives the completion notification, and processes the signatures to determine if full or delta download is required.

> PullDP    4300 (0x10cc)    DTS message for content job {C10457F9-DE3A-4B45-878C-345919AFF97E} received, searching 1 active jobs for any containing this content job.  DTS Job is {3C962758-7ABE-40F2-A585-E5B59E378BEA}  
> PullDP    4300 (0x10cc)    DTS succeeded message received for P010000F.3, content job {C10457F9-DE3A-4B45-878C-345919AFF97E}, status is 0x0 :  
> PullDP    3856 (0xf10)    ContentExecuteJob {C10457F9-DE3A-4B45-878C-345919AFF97E} (state: 5-Signature Downloaded) for package P010000F.3 content Content_3c9813ba-d7ab-4963-929c-36f90f479613.1.

### Step 11: Pull DP creates a DataTransferService (DTS) job for content download

Pull DP creates a download job for the content. In this example, the content did not exist on the pull DP so a full download DTS job is created for the package. The DTS job can be used to track the download process in the **DataTransferService.log** in the next step:

> PullDP    4300 (0x10cc)    DTS message for content job {C10457F9-DE3A-4B45-878C-345919AFF97E} received, searching 1 active jobs for any containing this content job.  DTS Job is {3C962758-7ABE-40F2-A585-E5B59E378BEA}  
> PullDP    4300 (0x10cc)    DTS succeeded message received for P010000F.3, content job {C10457F9-DE3A-4B45-878C-345919AFF97E}, status is 0x0 :  
> PullDP    3856 (0xf10)    ContentExecuteJob {C10457F9-DE3A-4B45-878C-345919AFF97E} (state: 5-Signature Downloaded) for package P010000F.3 content Content_3c9813ba-d7ab-4963-929c-36f90f479613.1. ...  
> PullDP    3856 (0xf10)    File To Download: ConfigMgrTools.msi  
> PullDP    3856 (0xf10)    Content_3c9813ba-d7ab-4963-929c-36f90f479613.1: 0 files already exists, 1 files to download  
> PullDP    3856 (0xf10)    Created FullDownload(Manifest) DTS job {78635652-3D12-4A26-A51B-D553934ECB54} for package P010000F.3, content id Content_3c9813ba-d7ab-4963-929c-36f90f479613.1, content job id {C10457F9-DE3A-4B45-878C-345919AFF97E}.

### Step 12: DTS creates a BITS job which downloads the content and sends a completion notification

**DataTransferService.log** shows the progress of the job. With verbose logging enabled for the pull DP, **PullDP.log** would show more information about the download progress as well.

> DataTransferService    3856 (0xf10)    DTSJob {78635652-3D12-4A26-A51B-D553934ECB54} created to download from '<`https://P01MP.CONTOSO.COM:443/SMS_DP_SMSPKG$/Content_3c9813ba-d7ab-4963-929c-36f90f479613.1`>' to 'E:\SMS_DP$\P010000F\Content_3c9813ba-d7ab-4963-929c-36f90f479613.1\3'.  
> DataTransferService    3812 (0xee4)    Starting BITS job '{04498466-5A8E-4A22-97F2-A66306143A20}' for DTS job '{78635652-3D12-4A26-A51B-D553934ECB54}' under user 'S-1-5-18'.  
> DataTransferService    3812 (0xee4)    DTSJob {78635652-3D12-4A26-A51B-D553934ECB54} in state 'DownloadingData'.  
> DataTransferService    752 (0x2f0)    DTS job {78635652-3D12-4A26-A51B-D553934ECB54} has completed:  

### Step 13: Pull DP moves the content to Downloaded state

After the DTS job finishes, pull DP is notified and moves the content to **Downloaded** state:

> PullDP    3812 (0xee4)    DTS message for content job {C10457F9-DE3A-4B45-878C-345919AFF97E} received, searching 1 active jobs for any containing this content job.  DTS Job is {78635652-3D12-4A26-A51B-D553934ECB54}  
> PullDP    3812 (0xee4)    DTS succeeded message received for P010000F.3, content job {C10457F9-DE3A-4B45-878C-345919AFF97E}, status is 0x0 :  
> PullDP    3856 (0xf10)    ContentExecuteJob {C10457F9-DE3A-4B45-878C-345919AFF97E} (state: 9-Downloaded) for package P010000F.3 content Content_3c9813ba-d7ab-4963-929c-36f90f479613.1.

### Step 14: Content is moved to the content library and state moves to Succeeded

After the content is successfully **Downloaded**, pull DP then moves the content to the content library (which is also known as Single Instance Storage). After the content is moved to the content library, the content moves to **SIApplied** state followed by the **Succeeded** state.

> PullDP    3856 (0xf10)    CPullDPPkgContJob::ApplySingleInstancing(): JobState = Downloaded  
> PullDP    3856 (0xf10)    CPullDPPkgContJob::NotifySIApplied(). JobState = SIApplied  
> PullDP    3812 (0xee4)    Content job {C10457F9-DE3A-4B45-878C-345919AFF97E} running.  
> PullDP    3812 (0xee4)    ContentExecuteJob {C10457F9-DE3A-4B45-878C-345919AFF97E} (state: 13-SIApplied) for package P010000F.3 content Content_3c9813ba-d7ab-4963-929c-36f90f479613.1.  
> ...  
> PullDP    3812 (0xee4)    CPullDPPkgContJob::NotifySucceeded(). Content job {C10457F9-DE3A-4B45-878C-345919AFF97E} for package P010000F.3 and content Content_3c9813ba-d7ab-4963-929c-36f90f479613.1 has completed successfully. JobState = Succeeded  
> PullDP    3812 (0xee4)    Notification that content job {C10457F9-DE3A-4B45-878C-345919AFF97E} for package P010000F.3 has completed.

After each content item is added to the content library, SMSDPProv.log is also notified and reports the following:

> 4688 (0x1250)        Content 'Content_3c9813ba-d7ab-4963-929c-36f90f479613.1' for package 'P010000F' has been added to content library successfully

Note that there may be multiple content items associated with a single package (for example, an application with more than a Deployment Type or a Software Update Package). For each content associated with the package, a DTS job is created for content download and the content is moved to the content library (**Succeeded** state) upon successful completion. Because of this, you may see multiple content items for a package move to **Succeeded** state in the **PullDP.log** but the overall package status may still remain in **In Progress** state if other content items that are part of the package are still be downloading.  

### Step 15: After all content is downloaded, package moves to 'Succeeded' state

After all the content jobs for the package have completed successfully and applied to the content library, pull DP moves the package to **Succeeded** state.

> PullDP    3812 (0xee4)   All 1 content jobs for P010000F.3 have completed, notify of success for this pull dp job.  
> PullDP    3812 (0xee4)   P010000F.3 has completed successfully, will clear stored content job state.

### Step 16: Pull DP sends a state message to the management point (MP)

After completion of the download, a state message is sent to the management point with **State ID 1** indicating **Success**.

> PullDP    3812 (0xee4)    Report state message 0x00000001 (1) to MP for package 'P010000F.3'  
> PullDP    3812 (0xee4)    Request was successful.  
> PullDP    3812 (0xee4)    CPullDPResponse::ReportPackageState return value 0x00000000.

With verbose and debug logging enabled, you can see the entire message body:

> PullDP    3812 (0xee4)    Sending Report  
> PullDP    3812 (0xee4)    \<Report>\<ReportHeader>\<Identification>\<Machine>\<ClientInstalled>0\</ClientInstalled>\<ClientType>1\</ClientType>\<Unknown>0\</Unknown>\<ClientID IDType="0" IDFlag="1">925b0ab0-247b-466b-be0f-93d7cb032c87\</ClientID>\<ClientVersion>5.00.0000.0000\</ClientVersion>\<NetBIOSName>P01PDP1.CONTOSO.COM\</NetBIOSName>\<CodePage>437\</CodePage>\<SystemDefaultLCID>1033\</SystemDefaultLCID>\</Machine>\</Identification>\<ReportDetails>\<ReportContent>StateMessage\</ReportContent>\<ReportType>Full\</ReportType>\<Date>20190107200618.000000+000\</Date>\<Version>1.0\</Version>\<Format>1.1\</Format>\</ReportDetails>\</ReportHeader>  
\<ReportBody>\<StateMessage MessageTime="20190107200618.000000+000" SerialNumber="3">\<Topic ID="P010000F" Type="902" IDType="0"/>\<State ID="1" Criticality="0"/>\<UserParameters Flags="0" Count="4">\<Param>P010000F\</Param>\<Param>["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\\</Param>\<Param>{04AD1BB3-5E54-457A-9873-DFB2E8035090}\</Param>\<Param>\</Param>\</UserParameters>\</StateMessage>\</ReportBody>

During content download, there are intermediate state messages sent to the MP which include the download percentage. To see all available State IDs, see [Advanced troubleshooting tips for Content Distribution](advanced-troubleshooting-tips.md).

### Step 17: Pull DP clears the content job state in WMI

After sending the **Success** state message, pull DP clears the job states for the package.

> PullDP    3812 (0xee4)    Clearing content job states for all 1 content jobs in package P010000F.3.  
> PullDP    3812 (0xee4)    CPullDPService::ClearCompletedJobs(), removing 1 completed jobs.  
> PullDP    3812 (0xee4)    Removing job for package P010000F.3 from job array and WMI.  
> PullDP    3812 (0xee4)    Clearing content job states for all 1 content jobs in package P010000F.3.

### Step 18: MP_Relay endpoint on the MP receives the state message and moves it to site server

`MP_Relay` endpoint on the management point processes the state message and routes the state message SMX file to the `auth\statesys.box\incoming` directory on the site server. If the MP is co-located on the site server (example below), it's directly sent to the `inboxes\auth\statesys.box\incoming` directory. If the MP is remote, it moves it to `\mp\outboxes\StateMsg.box` directory on the MP, and MP file dispatch manager (MPFDM) moves the file to the `inboxes\auth\statesys.box\incoming` directory on the site server.

> MP_RelayEndpoint    25912 (0x6538)    Mp Message Handler: start message processing for Relay. -----------------------  
> MP_RelayEndpoint    25912 (0x6538)    Mp Message Handler: FileType=SMX  
> MP_RelayEndpoint    25912 (0x6538)    Message Body :  
> \<Report>\<ReportHeader>\<Identification>\<Machine>\<ClientInstalled>0\</ClientInstalled>\<ClientType>1\</ClientType>\<Unknown>0\</Unknown>\<ClientID IDType="0" IDFlag="1">925b0ab0-247b-466b-be0f-93d7cb032c87\</ClientID>\<ClientVersion>5.00.0000.0000\</ClientVersion>\<NetBIOSName>P01PDP1.CONTOSO.COM\</NetBIOSName>\<CodePage>437\</CodePage>\<SystemDefaultLCID>1033\</SystemDefaultLCID>\</Machine>\</Identification>\<ReportDetails>\<ReportContent>StateMessage\</ReportContent>\<ReportType>Full\</ReportType>\<Date>20190107200618.000000+000\</Date>\<Version>1.0\</Version>\<Format>1.1\</Format>\</ReportDetails>\</ReportHeader>  
> \<ReportBody>\<StateMessage MessageTime="20190107200618.000000+000" SerialNumber="3">\<Topic ID="P010000F" Type="902" IDType="0"/>\<State ID="1" Criticality="0"/>\<UserParameters Flags="0" Count="4">\<Param>P010000F\</Param>\<Param>["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\\</Param>\<Param>{04AD1BB3-5E54-457A-9873-DFB2E8035090}\</Param>\<Param>\</Param>\</UserParameters>\</StateMessage>\</ReportBody>  
> \</Report>  
MP_RelayEndpoint    25912 (0x6538)    Inv-Relay Task: Processing message body  
MP_RelayEndpoint    25912 (0x6538)    Relay: Outbox dir: E:\ConfigMgr\inboxes\auth\statesys.box\incoming

Note that verbose and debug logging should be enabled on the MP to see above log entries on the MP. Without verbose and debug logs, **MP_Relay.log** will just log "".  

### Step 19: State System component on site server processes the state message into the database

After the state message SMX file arrives in the `StateSys.box\incoming` directory, State System component on the site server processes the message. All state messages are processed by calling `spProcessReport` stored procedure. For pull DP state messages, `spProcessReport` calls `spProcessPullDPMessage` which updates the `PullDPResponse` table with the state message details.

> SMS_STATE_SYSTEM    23544 (0x5bf8)    CMessageProcessor - Processing file: N_6RB4OA3A.SMX  
> SMS_STATE_SYSTEM    23544 (0x5bf8)    CMessageProcessor - the cmdline to DB exec dbo.spProcessStateReport N'?\<Report>\<ReportHeader>\<Identification>\<Machine>\<ClientInstalled>0\</ClientInstalled>\<ClientType>1\</ClientType>\<Unknown>0\</Unknown>\<ClientID IDType="0" IDFlag="1">925b0ab0-247b-466b-be0f-93d7cb032c87\</ClientID>\<ClientVersion>5.00.0000.0000\</ClientVersion>\<NetBIOSName>P01PDP1.CONTOSO.COM\</NetBIOSName>\<CodePage>437\</CodePage>\<SystemDefaultLCID>1033\</SystemDefaultLCID>\</Machine>\</Identification>\<ReportDetails>\<ReportContent>StateMessage\</ReportContent>\<ReportType>Full\</ReportType>\<Date>20190107200618.000000+000\</Date>\<Version>1.0\</Version>\<Format>1.1\</Format>\</ReportDetails>\</ReportHeader>~~        \<ReportBody>\<StateMessage MessageTime="20190107200618.000000+000" SerialNumber="3">\<Topic ID="P010000F" Type="902" IDType="0"/>\<State ID="1" Criticality="0"/>\<UserParameters Flags="0" Count="4">\<Param>P010000F\</Param>\<Param>["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\\</Param>\<Param>{04AD1BB3-5E54-457A-9873-DFB2E8035090}\</Param>\<Param>\</Param>\</UserParameters>\</StateMessage>\</ReportBody>\~~\</Report>~~'

Note that **StateSys.log** does not log the message body unless verbose logging for **StateSys.log** is enabled. To enable verbose logging for **StateSys.log**, see [Enable verbose logging](advanced-troubleshooting-tips.md#enable-verbose-logging).

Here's the excerpt from `spProcessReport` stored procedure which processes the pull DP state messages:

```sql
else if @TopicType=902 -- Pull Distribution Point  
        exec @Ret=spProcessPullDPMessage @SenderID=@SenderID, @MessageTime=@tmMessageTime, @PkgID=@TopicID, @PkgVersion=@MessageSerialNumber, @StateID=@StateID, @P1=@P1, @P2=@P2, @P3=@P3, @P4=@P4, @P5=@P5, @Error=@Error OUTPUT  
```

### Step 20: SMSDBMON notifies DistMgr to update the status

After `PullDPResponse` table is updated, SMSDBMON detects a change in the table and drops a *.PUL* file for DistMgr to process, where the name of the file identifies the row that was inserted/modified.

> SMS_DATABASE_NOTIFICATION_MONITOR    29748 (0x7434)    RCV: INSERT on PullDPResponse for PullDPResponse_UpdIns [72057594037928008  ][145014]  
> SMS_DATABASE_NOTIFICATION_MONITOR    29748 (0x7434)    SND: Dropped E:\ConfigMgr\inboxes\distmgr.box\incoming\72057594037928008.PUL  [145014]

### Step 21: DistMgr updates the distribution status

DistMgr processes the *.PUL* file, and retrieves the row from `PullDPResponse` table based on the file name and updates the package status. After the response is processed, DistMgr deletes the processed row from the `PullDPResponse` table.

> SMS_DISTRIBUTION_MANAGER    32876 (0x806c)    SQL>>>select s.ID, s.PkgServer, s.SiteCode, p.StoredPkgVersion, s.Status, r.PkgVersion, r.ActionState, r.ActionData, p.PkgFlags, p.ShareType, CONVERT(VARCHAR(64), r.MessageTime, 127) AS MessageTime from PullDPResponse r join PkgStatus s on r.PkgStatusID = s.PKID AND r.PkgStatusID = 72057594037928008 join SMSPackages p on s.ID = p.PkgID  
> SMS_DISTRIBUTION_MANAGER    32876 (0x806c)    ~Processing PullDP response P01 - ["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\  
> SMS_DISTRIBUTION_MANAGER    32876 (0x806c)        Package P010000F, Version 3(3), ActionState 1, PkgStatus 0, ActionData =  
> SMS_DISTRIBUTION_MANAGER    32876 (0x806c)    ~Successfully updated the package server status for ["Display=\\\P01PDP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=P01"]\\\P01PDP1.CONTOSO.COM\\ for package P010000F, Status 3  
> SMS_DISTRIBUTION_MANAGER    32876 (0x806c)    SQL>>>DELETE FROM PullDPResponse WHERE PkgStatusID = 72057594037928008 AND MessageTime = '2019-01-07T20:06:18'  
> SMS_DISTRIBUTION_MANAGER    32876 (0x806c)    ~Successfully processed PullDP response file E:\ConfigMgr\inboxes\distmgr.box\INCOMING\72057594037928008.PUL

### Step 22: Database replication replicates the status change to other sites

After the package status is updated in the database, it is replicated to other sites via database replication.

## Update a package

When you update a package, the package content is resent to all of the distribution points that the package was distributed to. This is done by incrementing Package Source version, and only the content changes are sent to the DPs instead of sending all of the content again.

The following steps outline the flow of events that occur when a package is updated. In this example, we will look at the package update operation for a package that was created at a primary site and focus on process changes specific to the package update operation.

### Step 1: The admin console executes the `RefreshPkgSource` method against the `SMS_Package` WMI class in the SMS Provider namespace

After the administrator updates the package from the console, the admin console calls the `RefreshPkgSource` method of the `SMS_Package` class to update the package. **SMSProv.log** shows the following:

> SMS Provider 4716 (0x126c) Context: SMSAppName=Configuration Manager Administrator console~  
> SMS Provider 4716 (0x126c) ExecMethodAsync : **SMS_Package.PackageID="\<PackageID>"::RefreshPkgSource** ~  
> SMS Provider 4716 (0x126c) CExtProviderClassObject::DoExecuteMethod RefreshPkgSource~  
> SMS Provider 4716 (0x126c) Auditing: User CONTOSO\Admin called an audited method of an instance of class SMS_Package.~  

When this method is called, SMS Provider updates `SMSPackages` to set **Action** to **1**(UPDATE) and inserts a row in `PkgNotification` table.

```sql
update SMSPackages set Source = N'\\PS1SITE\SOURCE\Packages\200MB_1', StoredPkgVersion = 1, UpdateMask = 32, UpdateMaskEx = 8388608, Action = 1 where PkgID = N'PackageID'
insert PkgNotification (PkgID, Priority, Type, TimeKey) values (N'PackageID', 2, 1, GetDate())  
```

### Step 2: SMSDBMON notifies DistMgr to process the package

SMSDBMON detects a change in the `PkgNotification` table which causes it to drop a **\<*PackageID*>.PKN** file in `DistMgr.box` to instruct DistMgr to process the package:

> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) RCV: INSERT on PkgNotification for PkgNotify_Add [\<PackageID>][1036610]  
> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) SND: Dropped E:\ConfigMgr\inboxes\distmgr.box\\\<PackageID>.PKN [1036610]

### Step 3: DistMgr wakes up to process the package after receiving the PKN file

1. The main DistMgr thread starts a package processing thread.

   The main DistMgr thread adds the package to the package processing queue and creates a package processing thread.

   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) Found package properties updated notification for package '\<PackageID>'  
   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) Adding package '\<PackageID>' to package processing queue.  
   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) ~Currently using 0 out of 3 allowed package processing threads.  
   > SMS_DISTRIBUTION_MANAGER 4824 (0x12d8) ~Started package processing thread for package '\<PackageID>', thread ID = 0x1690 (5776)

2. The package processing thread creates a package snapshot, writes content to the content library and increments the package version.

   The package processing thread (thread ID 5776 in this case) starts processing the package and creates a package snapshot. After creating the package snapshot, this thread also writes the package content to the content library on the site server:

   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Processing package \<PackageID> (SourceVersion:1;StoredVersion:1)  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) Start updating the package \<PackageID>...  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) Taking package snapshot for package \<PackageID> from source \\\PS1SITE\SOURCE\Packages\200MB_1  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) The size of package \<PackageID>, version 2 is 204800 KBytes  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) Writing package definition for \<PackageID>  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Successfully created RDC signatures for package \<PackageID> version 2  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) Creating hash for algorithm 32780  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) The hash for algorithm 32780 is \<HashString>  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) The RDC signature hash for algorithm 32780 is 79A56464F7BAC44B3D183D5EFC1160E51F95A34FECA492AAD73BC73C8B6DBA38  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) STATMSG: ID=2376 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=5776 GMTDATE=Tue May 17 18:31:23.782 2016 ISTR0="PS100039" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="PS100039"  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~The source for package PS100039 has changed or the package source needs to be refreshed  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Adding these contents to the package PS100039 version 2.  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~The Package Action is 1, the Update Mask is 32 and UpdateMaskEx is 0.  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Use drive E for storing the compressed package.  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Successfully created/updated the package PS100039.  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) STATMSG: ID=2311 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=5776 GMTDATE=Tue May 17 18:31:23.982 2016 ISTR0="PS100039" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="PS100039"

3. Package processing thread processes starts DP threads to process package actions then waits for them to exit.

   The package processing thread processes the package actions to update the package, which involves updating the package on all the DPs where this package is distributed. Since there are package actions to process, the package processing thread creates DP threads to perform these actions and waits for the DP threads to exit before moving on.

   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) Start updating package PS100039 on server ["Display=\\\PS1SITE.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SITE.CONTOSO.COM\\...  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Created DP processing thread **920** for addition or update of package PS100039 on server ["Display=\\\PS1SITE.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SITE.CONTOSO.COM\\  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) Start updating package PS100039 on server ["Display=\\\PS1SYS.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SYS.CONTOSO.COM\\...  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Created DP processing thread **2060** for addition or update of package PS100039 on server ["Display=\\\PS1SYS.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SYS.CONTOSO.COM\\  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) Start updating package PS100039 on server ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\...  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Created DP processing thread **6076** for addition or update of package PS100039 on server ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) Start updating package PS100039 on server ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\...  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Created DP processing thread **5948** for addition or update of package PS100039 on server ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Waiting for all DP threads to complete for package PS100039 processing thread.

4. DP threads start and create PkgXferMgr jobs to transfer content to the DPs, then exit.

   DP threads start working on creating a PkgXferMgr job to update the package on the DPs. At this point there are four DP threads for four different DPs:

   > SMS_DISTRIBUTION_MANAGER 5948 (0x173c) DP Thread: Attempting to add or update package PS100039 on DP ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\  
   > SMS_DISTRIBUTION_MANAGER 5948 (0x173c) ~Created package transfer job to send package PS100039 to distribution point ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\.  
   > SMS_DISTRIBUTION_MANAGER 5948 (0x173c) Performing cleanup prior to returning.  
   > SMS_DISTRIBUTION_MANAGER 5948 (0x173c) Cancelling network connection to \\\PS1DP2.CONTOSO.COM\ADMIN$.

   When the DP thread creates a PkgXferMgr job, it does so by inserting a row in `DistributionJobs` table.

   ```sql
   insert into DistributionJobs (DPID,PkgID,PackageVersion,State,CreationTime,Action) values(35,N'PS100039',2,0,N'2016/05/17 14:31:35',1)
   ```

5. (if applicable) Package processing thread creates a mini-job to send the compressed copy of the package to other sites.

   After all the DP threads finish working, the package processing thread creates a mini-job to send the compressed copy of the package to other sites, if applicable. This mini-job is processed by Scheduler to create a send request for Sender to transfer the compressed copy of the package to the destination site:

   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~All DP threads have completed for package PS100039 processing thread.  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Package PS100039 does not have a preferred sender.  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) STATMSG: ID=2333 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=5776 GMTDATE=Tue May 17 18:31:44.977 2016 ISTR0="PS100039" ISTR1="PS2" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="PS100039" ...  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Needs to send the compressed package for package PS100039 to site PS2  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Sending a copy of package PS100039 to site PS2  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Use drive E for storing the compressed package.  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Setting CMiniJob transfer root to E:\SMSPKG\PS100039.DLT.1.2  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Created minijob to send compressed copy of package PS100039 to site PS2. Transfer root = E:\SMSPKG\PS100039.DLT.1.2. ...  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Needs to send the compressed package for package PS100039 to site SS1  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Sending a copy of package PS100039 to site SS1  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Use drive E for storing the compressed package.  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Setting CMiniJob transfer root to E:\SMSPKG\PS100039.DLT.1.2  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Created minijob to send compressed copy of package PS100039 to site SS1. Transfer root = E:\SMSPKG\PS100039.DLT.1.2.  

6. Package processing thread exits after processing the package:

   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) Package PS100039 is new or has changed, replicating to all applicable sites.  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~CDistributionSrcSQL::UpdateAvailableVersion PackageID=PS100039, Version=2, Status=2301  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~StoredPkgVersion (2) of package PS100039. StoredPkgVersion in database is 2.  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~SourceVersion (2) of package PS100039. SourceVersion in database is 2.  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) STATMSG: ID=2301 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=5776 GMTDATE=Tue May 17 18:31:45.415 2016 ISTR0="Dummy2" ISTR1="PS100039" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="PS100039"  
   > SMS_DISTRIBUTION_MANAGER 5776 (0x1690) ~Exiting package processing thread for package PS100039.

### Step 4: SMSDBMON notifies PkgXferMgr to process the job

SMSDBMON detects a change in the `DistributionJobs` table and drops a PKN file in `PkgTransferMgr.box` to instruct PkgXferMgr to process the job:

> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) RCV: UPDATE on DistributionJobs for DistributionJob_Creation [PS100039 ][1036623]  
> SMS_DATABASE_NOTIFICATION_MONITOR 1792 (0x700) SND: Dropped E:\ConfigMgr\inboxes\PkgTransferMgr.box\PS100039.PKN [1036623]

### Step 5: PkgXferMgr wakes up to process the job

For standard DPs, a sending thread copies the content to the DP, and the remaining process is identical to the process described in step 6 of [Distribute a package to standard DP](#distribute-a-package-to-standard-dp).

For pull DPs, a pull DP sending thread sends the notification to the pull DP to perform content download. Pull DP then downloads the content from the source DP, and the remaining process is identical to the process described in step 6 of [Distribute a package to pull DP](#distribute-a-package-to-pull-dp).

### Step 6: The package status changes are replicated to other sites via DRS

After the package status is updated in the database, it is replicated to other sites via database replication.

## Redistribute a package

When you redistribute a package to a DP, all of the package content files are re-copied to the DP even if the content already exists in the content library on the DP.

The following steps outline the flow of events that occur when a package is redistributed to a DP. In this example, the primary site server already has a compressed copy of the package. This process is identical to the process outlined in [Distribute a package to standard DP](#distribute-a-package-to-standard-dp) or [Distribute a package to pull DP](#distribute-a-package-to-pull-dp), so here we only look at detailed log snippets for relevant changes.

### Step 1: Administrator redistributes the package to the DP

### Step 2: If Administrator redistributed the package from a different primary site or the central administration site, DRS replicates changes to the site in question

### Step 3: SMSDBMON notifies DistMgr to process the package

### Step 4: DistMgr wakes up to process the package

1. The main DistMgr thread starts a package processing thread.
2. The package processing thread creates DP threads to process package actions and waits for them to exit.
3. The DP threads create a PkgXferMgr job to add the package to the DPs and then exits.

   The DP thread starts working on adding the package to the DP. DP threads do not copy the package content to the DP directly, but instead creates a job for Package Transfer Manager (PkgXferMgr) instructing it to copy the package content to the DP. The following log entries show the DP thread creating a PkgXferMgr job. After the job is created, the DP thread's work is done and the DP thread exits.

   > SMS_DISTRIBUTION_MANAGER 3792 (0xed0) DP Thread: Attempting to add or update package \<PackageID\> on DP ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\  
   > SMS_DISTRIBUTION_MANAGER 3792 (0xed0) ~Created package transfer job to send package \<PackageID\> to distribution point ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\.  
   > SMS_DISTRIBUTION_MANAGER 3792 (0xed0) STATMSG: ID=2357 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=3792 GMTDATE=Mon May 16 19:26:58.642 2016 ISTR0="\<PackageID>" ISTR1="["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=2 AID0=400 AVAL0="\<PackageID>" AID1=404 AVAL1="["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\"

   When the DP thread creates a PkgXferMgr job, it does so by inserting a row in the `DistributionJobs` table. For redistributing a package, **Action** is set to **2**.

   ```sql
   insert into DistributionJobs (DPID,PkgID,PackageVersion,State,CreationTime,Action) values(32,N'CS100026',1,0,N'2016/05/16 16:03:49',2)
   ```

4. The package processing thread exits after all DP threads exit.

### Step 5: SMSDBMON notifies PkgXferMgr to process the job

### Step 6: PkgXferMgr wakes up to process the job

1. The main PkgXferMgr thread creates a sending thread.
2. The sending thread or pull DP sending thread processes the job.

   **Standard DP:**

   Sending thread starts copying the package contents to the DP. This process involves copying all the files in the package to the DP in the `SMS_DP$` directory. Since the package was redistributed, PkgXferMgr shows that `Redistribute` is set to **1**, which means that all the files will get re-copied to the DP even if they already exist in the content library on the DP.

   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) Sending thread starting for Job: 583, package: \<PackageID>, Version: 1, Priority: 2, server: PS1DP1.CONTOSO.COM, DPPriority: 200  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) Sent status to the distribution manager for pkg \<PackageID>, version 1, status 0 and distribution point ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\~  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) Performing preactions package \<PackageID>, Distribution point PS1DP1.CONTOSO.COM  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) Sending legacy content \<PackageID>.1 for package \<PackageID>  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) **Redistribute=1**, Related=  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) Sending file '\\\PS1DP1.CONTOSO.COM\SMS_DP$\73E055438D4731F41DB6C3BCB90919F60000226B330C73942454A174D7E26533-\<PackageID>.1.temp'  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) ~Sending Started [E:\SCCMContentLib\FileLib\73E0\73E055438D4731F41DB6C3BCB90919F60000226B330C73942454A174D7E26533]  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) ~Attempt to write 983040 bytes to \\\PS1DP1.CONTOSO.COM\SMS_DP$\73E055438D4731F41DB6C3BCB90919F60000226B330C73942454A174D7E26533-\<PackageID>.1.temp at position 208732160  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) ~Wrote 983040 bytes to \\\PS1DP1.CONTOSO.COM\SMS_DP$\73E055438D4731F41DB6C3BCB90919F60000226B330C73942454A174D7E26533-\<PackageID>.1.temp at position 208732160 in 344 ticks  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) ~Sending completed [E:\SCCMContentLib\FileLib\73E0\73E055438D4731F41DB6C3BCB90919F60000226B330C73942454A174D7E26533]  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) Completed post-actions for remote DP PS1DP1.CONTOSO.COM  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) ~Sending completed successfully  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) ~Finished sending SWD package \<PackageID> version 1 to distribution point PS1DP1.CONTOSO.COM  
   > SMS_PACKAGE_TRANSFER_MANAGER 5272 (0x1498) STATMSG: ID=8200 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_PACKAGE_TRANSFER_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=5428 TID=5272 GMTDATE=Mon May 16 20:06:36.827 2016 ISTR0="\<PackageID>" ISTR1="1" ISTR2="PS1DP1.CONTOSO.COM" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=2 AID0=400 AVAL0="\<PackageID>" AID1=410 AVAL1="1"

   **Pull DP:**  

   Pull DP sending thread sends a notification to the pull DP to start downloading the content. Since the package was redistributed, the generated notification XML shows that **Action** is set to **redist**, which means that all the files will get re-downloaded by the pull DP even if they already exist in the content library on the pull DP.

   Here's how a sample query that generates the notification XML query looks like showing that the **Action** is **redist** since the content was redistributed:

   ```sql
   SELECT [dbo].[fnGetPullDPXMLNotification]('P010000F', 3, 'P01PDP1.CONTOSO.COM', 2, 'redist', 1, 'O:SYG:BAD:P(A;;FA;;;BA)(A;OICIIO;GA;;;BA)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)(A;;FA;;;BA)(A;OICIIO;GA;;;BA)', 0, 32780, '3ED23B9869F7E10E19439F11341405FF76E22022E56468DCF211475899BD2914', '') AS Notification
   ```

   On receiving a notification for a redistribute action, **PullDP.log** will show that all content will get redownloaded even if some/all of the content may exist in the content library.

   > PullDP    3676 (0xe5c)    Content_3c9813ba-d7ab-4963-929c-36f90f479613.1: redistribute/redownload all files

   After this is done, the remaining process is similar to the process described in step 6 of [Distribute a package to pull DP](#distribute-a-package-to-pull-dp).

3. The sending thread sends a status message to DistMgr.

### Step 7: SMS DP Provider adds the content to the content library

### Step 8: DistMgr processes the status messages sent by PkgXferMgr

### Step 9: Package status changes are replicated to other sites via DRS
