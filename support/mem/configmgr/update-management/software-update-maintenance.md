---
title: Software updates maintenance
description: Describes the maintenance processes for software updates in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Software updates maintenance in Configuration Manager

This article describes the maintenance processes for software updates. It also provides suggestions for how Configuration Manager administrators can maintain optimal performance of the WSUS database.

For more information about software updates in Configuration Manager, see [Software updates introduction](software-updates-introduction.md).

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3090526

## Expired updates

As part of the ongoing update revision process, some updates in the Microsoft Update Catalog are expired. This issue typically occurs when a newer version of the update is available. However, in rare cases, Microsoft may discover a problem with an update and therefore expire it. During software updates synchronization, these expired updates are marked as **Expired** in the Configuration Manager console. This expired status is indicated by a dimmed icon next to the update. These expired updates are automatically cleaned up from the Configuration Manager database on a regular schedule. The WSUS Synchronization Manager component removes expired updates only if the following conditions are true:

- The update is not referenced in an update assignment.
- The update is older than the value of **Updates Cleanup Age**. (By default, this value is seven days.)

WSUS Synchronization Manager at the top-level Configuration Manager site checks every hour for updates that must be removed, and it removes expired updates if they match the criteria in the previous list. When WSUS Synchronization Manager deletes expired updates, you can see the following entries in the WSyncMgr.log file:

> Deleting old expired updates... SMS_WSUS_SYNC_MANAGER  
> Deleted 100 expired updates SMS_WSUS_SYNC_MANAGER  
> \...  
> Deleted 2995 expired updates total SMS_WSUS_SYNC_MANAGER

## Content cleanup

As expired updates are removed, content for those expired updates may become orphaned. WSUS Synchronization Manager also cleans up this orphaned content. As part of the content cleanup, WSUS Synchronization Manager analyzes the packages that are owned by the current site, finds content that is no longer referenced, and removes that content from the package source directory. By default, content is removed only if it has been orphaned for more than one day.

If any content is removed, the cleanup process also updates the package so that the updated content is sent to the distribution points (DPs). When WSUS Synchronization Manager removes orphaned content, you can see the following entries in the WSyncMgr.log file:

> Deleting orphaned content for package CS100006 (EPDefinitions) from source \<PackageSource> SMS_WSUS_SYNC_MANAGER  
> Deleting orphaned content folder \\\\\<PackageSource>\51b6db15-6938-4b37-9fa8-caf513e13930... SMS_WSUS_SYNC_MANAGER  
> \...  
> \...  
> Deleting orphaned content folder \\\\\<PackageSource>\526b6a85-a62c-4d54-bc0d-b3409223b0df... SMS_WSUS_SYNC_MANAGER  
> Deleted 12 orphaned content folders in package CS100006 (EPDefinitions) SMS_WSUS_SYNC_MANAGER  
> Refreshing package CS100006 (EPDefinitions) SMS_WSUS_SYNC_MANAGER

For more information about the cleanup of expired updates and content, see [Software Update Content Cleanup in System Center 2012 Configuration Manager](https://techcommunity.microsoft.com/t5/configuration-manager-archive/software-update-content-cleanup-in-system-center-2012/ba-p/273069).

## WSUS server maintenance

To maintain optimal performance of the WSUS database, we recommend that you routinely run the WSUS Cleanup Wizard tasks on the WSUS database (SUSDB) and also reindex the WSUS database on each WSUS computer that is hosting a Software Update Point role in the Configuration Manager environment. When you run WSUS Cleanup Wizard actions in a multilevel hierarchy, run the cleanup process on the lowest tier of the WSUS chain first and then move up to the next tier to run the Cleanup Wizard tasks. You must continue on up the hierarchy until you reach the top-tier WSUS computer. You can run this WSUS maintenance routine at the same time on multiple servers in the same tier.

Although reindexing can be done in any order on any WSUS computer's SUSDB, we recommend that you run the cleanup and reindexing on each WSUS computer by running the reindex process first and then run the Cleanup Wizard tasks. If you tune the performance of the SUSDB first through reindexing, the Cleanup Wizard tasks will finish more quickly.

For more information about WSUS maintenance, see [Perform WSUS maintenance](wsus-maintenance-guide.md#perform-wsus-maintenance).

For more information about WSUS cleanup behavior and log entries in Configuration Manager (current branch), see [Software updates maintenance](/mem/configmgr/sum/deploy-use/software-updates-maintenance).
