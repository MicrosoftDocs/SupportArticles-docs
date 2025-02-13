---
title: SQL Server Launchpad service fails to start
description: This article provides a resolution for the problem where the SQL Server Launchpad service fails to start after installing Windows update KB5044284 (OS Build 26100.2033) or a later version.
ms.date: 02/13/2025
ms.custom: sap:Machine Learning Services (in database)
ms.reviewer: jaferebe
---
# SQL Server Launchpad service fails to start after installing Windows update

## Symptoms

You're running a Windows 11 machine with SQL Server installed with the [SQL Server Machine Learning Services](/sql/machine-learning/install/sql-machine-learning-services-windows-install) feature. After installing Windows update [KB5044284 (OS Build 26100.2033)](https://support.microsoft.com/topic/october-8-2024-kb5044284-os-build-26100-2033-6baf4a06-9763-4d9b-ba8a-f25ba6ed477b) or a later version, you notice the [SQL Server Launchpad service](/sql/machine-learning/concepts/extensibility-framework#launchpad) fails to start. After checking the [ExtLaunchErrorlog](/sql/machine-learning/troubleshooting/data-collection-ml-troubleshooting-process#system-events) file, you see the following error messages at the end of the file.  

``` 
<timestamp>	Security Context Manager initialization failed. ErrorCode: 0x8032000c.
<timestamp>	Satellite Session Manager initialization failed. ErrorCode: 0x8032000c.
<timestamp>	Initialization of satellite session manager failed. ErrorCode: 0x8032000c.
``` 

> [!NOTE]
> This issue doesn't impact Windows Server operating system.

## Cause

Windows update [KB5044284 (OS Build 26100.2033)](https://support.microsoft.com/topic/october-8-2024-kb5044284-os-build-26100-2033-6baf4a06-9763-4d9b-ba8a-f25ba6ed477b) changed the behavior of windows API [CreateAppContainerProfile](/windows/win32/api/userenv/nf-userenv-createappcontainerprofile) that is called by the Launchpad service. This change causes the API to return an error and ultimately causes the Launchpad service to fail.

## Resolution

Microsoft is actively working on a fix. In the meantime, if you use the Launchpad service, revert to Windows update [KB5043080 (OS Build 26100.1742)](https://support.microsoft.com/topic/september-10-2024-kb5043080-os-build-26100-1742-407666c8-6b6d-4561-a982-abce4e7c2efb) or an earlier version. 