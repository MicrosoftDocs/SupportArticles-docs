---
title: Insufficient permissions to migrate a driver package
description: Fixes an issue where you can't migrate a driver package due to missing privileges for the driver package source path.
ms.date: 12/05/2023
ms.reviewer: kaushika, marcoh, erinwi, jarrettr
ms.custom: sap:Operating Systems Deployment (OSD)\Driver Management and Installation
---
# Migrating a driver package fails with the SCCM Provider is missing read, write, or delete privilege error

This article helps you resolve an issue where you can't migrate a driver package due to missing privileges for the driver package source path.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2741405

## Symptoms

While attempting to migrate a System Center Configuration Manager 2007 driver package to System Center 2012 Configuration Manager, the action fails and the following error is shown in the migmctrl.log file:

> SCCM Provider is missing read, write, or delete privilege for the driver package source path

## Cause

This problem can occur if the Configuration Manager Provider system has insufficient permissions on the driver package source path (NTFS or Share permissions).

## Resolution

Grant the Configuration Manager Provider system full control permissions on the driver package source path.

## More information

During migration, the error is only shown for driver packages because Migration Manager needs to process some content in the source path, so it fails during the migration itself. If you migrate a regular software package, it succeeds no matter whether the destination site has access to the source path or not, but later, SMS_DISTRIBUTION_MANAGER (distmgr.log) which starts up to process this package fails due to insufficient permissions on the package source path.

For more information, see [How to Manage the Driver Catalog in Configuration Manager](/previous-versions/system-center/system-center-2012-R2/hh301101(v=technet.10)?redirectedfrom=MSDN).
