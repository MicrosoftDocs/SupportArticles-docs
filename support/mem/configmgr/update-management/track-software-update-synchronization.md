---
title: Track software update synchronization
description: Describes the synchronization process on the top-level site and on a child primary site or secondary site.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Software Update Management (SUM)\Software Update Synchronization
---
# Track software update synchronization

_Applies to:_ &nbsp; Configuration Manager

Software updates synchronization in Configuration Manager connects to Microsoft Update to retrieve software updates metadata.

The top-level site (central administration site or stand-alone primary site) synchronizes with Microsoft Update on a schedule or when you manually start synchronization from the Configuration Manager console. When Configuration Manager finishes software updates synchronization at the top-level site, software updates synchronization starts at child sites, if they exist. When synchronization is complete at each primary site or secondary site, a site-wide policy is created that provides to client computers the location of the software update points.

## Synchronization on central administration site or standalone primary site

The software updates synchronization process at the top-level site contacts Microsoft Update and retrieves software update metadata that meets the criteria specified in the Software Update Point Component properties. This criteria is specified only at the top-level site. At the top-level site you can specify a synchronization source other than Microsoft Update, such as an existing Windows Server Update Services (WSUS) computer that's not in the Configuration Manager hierarchy.

The synchronization process at the top-level site performs the following steps:

### Step 1: Software updates synchronization starts either manually or on a schedule

When synchronization is initiated on a schedule, WSUS Synchronization Manager (WSyncMgr) wakes up on the configured schedule and initiates synchronization. The following are logged in WSyncMgr.log:

> Wakeup for scheduled regular sync         SMS_WSUS_SYNC_MANAGER  
> Starting Sync     SMS_WSUS_SYNC_MANAGER  
> Performing sync on regular schedule       SMS_WSUS_SYNC_MANAGER

When synchronization is initiated manually from the console, WSyncMgr is notified to initiate a sync by executing the `SyncNow` method in the `SMS_SoftwareUpdate` WMI class. This method updates the `Update_SyncStatus` table in the site database and sets the value of `SyncNow` to **SELF**. This triggers SMS Database Notification Monitor (SMSDBMON) to place a SELF.SYN file in WSyncMgr.box, and this awakens WSyncMgr and initiates synchronization.

The following is logged in SMSProv.log:

> ExecMethodAsync : SMS_SoftwareUpdate::SyncNow        SMS Provider

In SQL Server Profiler trace:

> update Update_SyncStatus set SyncNow = 'SELF' where SiteCode = dbo.fnGetSiteCode()  
> update Update_SyncStatus set SyncNow = null where SiteCode = dbo.fnGetSiteCode()

In SMSDBMON.log:

> RCV: UPDATE on Update_SyncStatus for SyncNotif_WSyncMgr [SELF][47788] SMS_DATABASE_NOTIFICATION_MONITOR  
> SND: Dropped E:\ConfigMgr\inboxes\WSyncMgr.box\SELF.SYN [47788]      SMS_DATABASE_NOTIFICATION_MONITOR  

In WSyncMgr.log:

> Wakeup by inbox drop SMS_WSUS_SYNC_MANAGER  
> Found local sync request file     SMS_WSUS_SYNC_MANAGER  
> Starting Sync      SMS_WSUS_SYNC_MANAGER  
> Performing sync on local request              SMS_WSUS_SYNC_MANAGER

WSyncMgr then reads the list of software update points (SUPs) from the site control file (SCF). WSyncMgr first synchronizes the SUP that was installed as the first SUP in the site and then synchronizes the remaining SUPs. All additional SUPs are configured as replicas of the first SUP. The following are logged in WsyncMgr.log:

> Read SUPs from SCF for CS1SITE.CONTOSO.COM      SMS_WSUS_SYNC_MANAGER  
> Found 1 SUPs                SMS_WSUS_SYNC_MANAGER  
> Found active SUP CS1SITE.CONTOSO.COM from SCF File.    SMS_WSUS_SYNC_MANAGER

When synchronization starts (either on schedule or manually), WSyncMgr creates status message ID 6701 to indicate that the WSUS synchronization has started. The following are logged in WsyncMgr.log:

> STATMSG: ID=6701 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER" SYS=\<SERVERFQDN> SITE=CS1 PID=432 TID=3404 GMTDATE=Thu Jan 16 18:53:52.608 2014 ISTR0="" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0           SMS_WSUS_SYNC_MANAGER

> [!TIP]
> To manually initiate a delta site wide synchronization, you can create a zero KB file named SELF.SYN in the `Program Files\Microsoft Configuration Manager\Inboxes\WSyncMgr.box` directory on the central administration site or standalone primary site server. Similarly, to initiate a full site wide synchronization, you can create a zero KB file named FULL.SYN in the same location.

### Step 2: WSUS Synchronization Manager sends a request to WSUS running on the software update point to start synchronization with Microsoft Update

The first phase of the synchronization process is to synchronize the WSUS server with Microsoft Update. WSyncMgr instructs the WSUS computer to start a synchronization with Microsoft Update and creates status message ID 6704 (WSUS Synchronization in progress. Current phase: Synchronizing WSUS Server). The following are logged in WsyncMgr.log:

> STATMSG: ID=6704 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER" SYS=\<SERVERFQDN> SITE=CS1 PID=432 TID=3404 GMTDATE=Thu Jan 16 18:53:53.698 2014 ISTR0="" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0         SMS_WSUS_SYNC_MANAGER  
> Synchronizing WSUS server cs1site.contoso.com ...         SMS_WSUS_SYNC_MANAGER  
> sync: Starting WSUS synchronization      SMS_WSUS_SYNC_MANAGER

In SoftwareDistribution.log:

> 2014-01-16 18:53:54.231 UTC Change w3wp.58 AdminDataAccess.StartSubscriptionManually    Synchronization manually started  
> 2014-01-16 18:53:56.168 UTC  Info         WsusService.15 EventLogEventReporter.ReportEvent  EventId=382,Type=Information,Category=Synchronization,Message=A manual synchronization was started.

### Step 3: WSUS synchronizes software update metadata from Microsoft Update. Any changes are inserted or updated in the WSUS database

WSUS starts synchronizing with Microsoft Update, and WSyncMgr begins monitoring synchronization progress. The following are logged in WsyncMgr.log:

> sync: WSUS synchronizing categories      SMS_WSUS_SYNC_MANAGER  
> sync: WSUS synchronizing updates          SMS_WSUS_SYNC_MANAGER  
> sync: WSUS synchronizing updates, processed 122 out of 130 items (93%), ETA in 00:00:03     SMS_WSUS_SYNC_MANAGER  
> sync: WSUS synchronizing updates, processed 130 out of 130 items (100%)    SMS_WSUS_SYNC_MANAGER  
> sync: WSUS synchronizing updates, processed 130 out of 130 items (100%)    SMS_WSUS_SYNC_MANAGER

The following entries in the log files indicate that WSUS has finished synchronizing with Microsoft Update:

- In SoftwareDistribution.log:

    > 2014-01-16 18:55:05.166 UTC  Info         WsusService.15 EventLogEventReporter.ReportEvent EventId=384,Type=Information,Category=Synchronization,Message=Synchronization completed successfully.  
    > 2014-01-16 18:55:06.307 UTC Info WsusService.31 CatalogSyncAgent.SetSubscriptionStateWithRetry Firing event SyncFinish...

- In WSyncMgr.log:

    > Done synchronizing WSUS Server \<SERVERFQDN> SMS_WSUS_SYNC_MANAGER  
    > Sleeping 2 more minutes for WSUS server sync results to become available    SMS_WSUS_SYNC_MANAGER  
    > Set content version of update source {C2D17964-BBDD-4339-B9F3-12D7205B39CC} for site CS1 to 33     SMS_WSUS_SYNC_MANAGER

### Step 4: WSUS Synchronization Manager synchronizes the software updates metadata

After WSUS has finished synchronization, WSUS Synchronization Manager synchronizes the software updates metadata. This is done from the WSUS database to the Configuration Manager database, and any changes after the last synchronization are inserted or updated in the site database. The software updates metadata is stored in the site database as a configuration item.

The second phase of the synchronization process is to synchronize the software update metadata from the WSUS database to the Configuration Manager database. At this point, WSyncMgr creates status message ID 6705 (WSUS Synchronization in progress. Current phase: Synchronizing site database).

The following are logged in WsyncMgr.log:

> STATMSG: ID=6705 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER" SYS=\<SERVERFQDN> SITE=CS1 PID=432 TID=3404 GMTDATE=Thu Jan 16 18:57:09.156 2014 ISTR0="" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0            SMS_WSUS_SYNC_MANAGER  
> Synchronizing SMS database with WSUS server \<SERVERFQDN> ...      SMS_WSUS_SYNC_MANAGER

WSyncMgr reads categories and updates from the WSUS database and inserts or updates the Configuration Manager database. Software update metadata for each update is stored in the site database as a configuration item (CI).

The following are logged in WsyncMgr.log:

> sync: SMS synchronizing categories SMS_WSUS_SYNC_MANAGER  
> ...\<log entries truncated>...  
> sync: SMS synchronizing categories, processed 223 out of 223 items (100%)     SMS_WSUS_SYNC_MANAGER  
> sync: SMS synchronizing updates SMS_WSUS_SYNC_MANAGER  
> ...\<log entries truncated>...  
> Synchronizing update af5eb87e-cdd6-40bf-984f-5d0630406de8 - Definition Update for Microsoft Endpoint Protection -
KB2461484 (Definition 1.165.1945.0) SMS_WSUS_SYNC_MANAGER  
> ...\<log entries truncated>...  
> sync: SMS synchronizing updates, processed 5 out of 5 items (100%) SMS_WSUS_SYNC_MANAGER  
> ...\<log entries truncated>...  
> Done synchronizing SMS with WSUS Server cs1site.contoso.com     SMS_WSUS_SYNC_MANAGER  
> Set content version of update source {C2D17964-BBDD-4339-B9F3-12D7205B39CC} for site CS1 to 34     SMS_WSUS_SYNC_MANAGER

After synchronization of the site database is complete, if any changes were made to the site database, the content version of the update source is updated in the database. After synchronization finishes successfully, WSyncMgr creates status message ID 6702 (WSUS Synchronization done). The following are logged in WsyncMgr.log:

> STATMSG: ID=6702 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER" SYS=\<SERVEFRFQDN> SITE=CS1 PID=432 TID=3404 GMTDATE=Thu Jan 16 18:57:46.304 2014 ISTR0="" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0                    SMS_WSUS_SYNC_MANAGER  
> Sync succeeded. Setting sync alert to canceled state on site CS1      SMS_WSUS_SYNC_MANAGER  
> Updated 130 items in SMS database, new update source content version is 34     SMS_WSUS_SYNC_MANAGER  
> Sync time: 0d00h03m53s          SMS_WSUS_SYNC_MANAGER

### Step 5: WSUS Synchronization Manager sends requests one at a time to the WSUS component running on other SUPs on the site

The WSUS computers on the other SUPs are configured as replicas of the WSUS installation running on the default SUP for the site.

The following are logged in WsyncMgr.log:

> Synchronizing replica WSUS servers        SMS_WSUS_SYNC_MANAGER  
> STATMSG: ID=6706 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=1840 TID=2832 GMTDATE=Thu Jan 16 19:17:13.575 2014 ISTR0="" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0     SMS_WSUS_SYNC_MANAGER  
> Synchronizing WSUS server ps1sys.contoso.com ...              SMS_WSUS_SYNC_MANAGER  
> sync: Starting Replica WSUS synchronization         SMS_WSUS_SYNC_MANAGER  
> sync: Replica WSUS synchronizing other items      SMS_WSUS_SYNC_MANAGER  
> sync: Replica WSUS synchronizing other items, processed 4 out of 4 items (100%)      SMS_WSUS_SYNC_MANAGER  
> Done synchronizing WSUS Server ps1sys.contoso.com      SMS_WSUS_SYNC_MANAGER

### Step 6: WSUS Synchronization Manager sends a synchronization request to all child sites

Sync notifications are sent to all child sites to instruct them to start synchronization. These notifications are sent through file replication and not database replication. The following are logged in WsyncMgr.log:

> Sending sync notification to child site(s): PS1, PS2               SMS_WSUS_SYNC_MANAGER  
> SQL Replication type has not been set for E:\ConfigMgr\inboxes\WSyncMgr.box\outbox\CS1.SYN, replicating to (PS1, PS2), inbox: E:\ConfigMgr\inboxes\replmgr.box                 SMS_WSUS_SYNC_MANAGER

### Step 7: The software updates configuration items are sent to child sites by using database replication

## Synchronization on child primary site and secondary sites

During the software update synchronization process on the top-level site, the software update configuration items are replicated to child sites by using database replication. At the end of the process, the top-level site sends a synchronization request to the child site, and the child site then starts the WSUS synchronization process. Because the software update metadata (configuration items) from the site database is replicated to the primary sites through database replication, the synchronization process on the child primary and secondary sites consists of only the WSUS synchronization phase.

The synchronization process on a child primary site or secondary site performs the following steps:

### Step 1: WSUS Synchronization Manager receives a synchronization request from the top-level site

When the sync notification that's sent by the parent site arrives in the WSyncMgr.box folder through file replication, WSyncMgr wakes up and starts synchronization. The following are logged in WsyncMgr.log:

> Wakeup by inbox drop SMS_WSUS_SYNC_MANAGER  
> Found parent sync notification file CS1.SYN. SMS_WSUS_SYNC_MANAGER  
> Starting Sync     SMS_WSUS_SYNC_MANAGER  
> Performing sync on parent request         SMS_WSUS_SYNC_MANAGER

WSyncMgr then reads the list of SUPs from the site control file (SCF). WSyncMgr will first synchronize the SUP that was installed as the first SUP in the site and then synchronize all remaining SUPs. All additional SUPs are configured as replicas of the first SUP. The following are logged in WsyncMgr.log:

> Read SUPs from SCF for PS1SITE.CONTOSO.COM    SMS_WSUS_SYNC_MANAGER  
> Found 2 SUPs                SMS_WSUS_SYNC_MANAGER  
> Found active SUP PS1SITE.CONTOSO.COM from SCF File.    SMS_WSUS_SYNC_MANAGER  
> Found active SUP PS1SYS.CONTOSO.COM from SCF File.     SMS_WSUS_SYNC_MANAGER

### Step 2: Software updates synchronization begins

The following are logged in WsyncMgr.log:

> STATMSG: ID=6701 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=1840 TID=2832 GMTDATE=Thu Jan 16 18:58:37.599 2014 ISTR0="" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0      SMS_WSUS_SYNC_MANAGER  
> Synchronizing WSUS server PS1SITE.CONTOSO.COM    SMS_WSUS_SYNC_MANAGER

### Step 3: WSUS Synchronization Manager makes a request to WSUS running on the first SUP to start synchronization

The following are logged in WsyncMgr.log:

> STATMSG: ID=6704 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=1840 TID=2832 GMTDATE=Thu Jan 16 18:58:38.909 2014 ISTR0="" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0      SMS_WSUS_SYNC_MANAGER  
> Synchronizing WSUS server ps1site.contoso.com ...    SMS_WSUS_SYNC_MANAGER

### Step 4: WSUS running on the SUP on the child site synchronizes software updates metadata from WSUS running on the SUP on the parent site

The following are logged in WsyncMgr.log:

> sync: Starting WSUS synchronization    SMS_WSUS_SYNC_MANAGER  
> sync: WSUS synchronizing categories    SMS_WSUS_SYNC_MANAGER  
> sync: WSUS synchronizing updates    SMS_WSUS_SYNC_MANAGER  
> sync: WSUS synchronizing updates, processed 130 out of 130 items (100%)    SMS_WSUS_SYNC_MANAGER  
> Done synchronizing WSUS Server ps1site.contoso.com SMS_WSUS_SYNC_MANAGER  
> Sleeping 2 more minutes for WSUS server sync results to become available     SMS_WSUS_SYNC_MANAGER  
> Set content version of update source {C2D17964-BBDD-4339-B9F3-12D7205B39CC} for site PS1 to 34       SMS_WSUS_SYNC_MANAGER

### Step 5: (For Configuration Manager with no service pack only) WSUS Synchronization Manager starts the synchronization process for WSUS running on the remote site system

When there is a remote Internet-based SUP, WSUS Synchronization Manager starts the synchronization process for WSUS running on the remote site system.

### Step 6: (For System Center 2012 Configuration Manager SP1 and System Center 2012 R2 Configuration Manager only) WSUS Synchronization Manager sends requests one at a time to WSUS running on other SUPs (including Internet-based SUPs) at the site

The WSUS servers on the other SUPs are configured as replicas of WSUS running on the default SUP at the site. WSyncMgr then creates status message ID 6706 (WSUS Synchronization in progress. Current phase: Synchronizing Internet-facing WSUS server). Even though the SUP may not be Internet-based, the status message will still be 6706.

The following are logged in WsyncMgr.log:

> Synchronizing replica WSUS servers        SMS_WSUS_SYNC_MANAGER  
> STATMSG: ID=6706 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=1840 TID=2832 GMTDATE=Thu Jan 16 19:17:13.575 2014 ISTR0="" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0 SMS_WSUS_SYNC_MANAGER  
> Synchronizing WSUS server ps1sys.contoso.com ...              SMS_WSUS_SYNC_MANAGER  
> sync: Starting Replica WSUS synchronization         SMS_WSUS_SYNC_MANAGER  
> sync: Replica WSUS synchronizing other items      SMS_WSUS_SYNC_MANAGER  
> sync: Replica WSUS synchronizing other items, processed 4 out of 4 items (100%)      SMS_WSUS_SYNC_MANAGER  
> Done synchronizing WSUS Server ps1sys.contoso.com        SMS_WSUS_SYNC_MANAGER

### Step 7: When synchronization has finished successfully, WSUS Synchronization Manager creates status message 6702

The following are logged in WsyncMgr.log:

> STATMSG: ID=6702 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=1840 TID=2832 GMTDATE=Thu Jan 16 19:01:35.117 2014 ISTR0="" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0      SMS_WSUS_SYNC_MANAGER  
> Sync succeeded. Setting sync alert to canceled state on site PS1    SMS_WSUS_SYNC_MANAGER  
> Successfully synced site with parent CS1, version 34    SMS_WSUS_SYNC_MANAGER  
> Sync time: 0d00h02m57s    SMS_WSUS_SYNC_MANAGER

### Step 8: From a primary site, WSUS Synchronization Manager sends a synchronization request to any child secondary sites

The secondary site starts the software updates synchronization with the parent primary site. The secondary site's SUP is configured as a replica of WSUS running on the parent site.

The following is logged in WsyncMgr.log:

> Sending sync notification to child site(s): SS1    SMS_WSUS_SYNC_MANAGER
