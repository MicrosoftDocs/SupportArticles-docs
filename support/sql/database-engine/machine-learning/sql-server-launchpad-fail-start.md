---
title: SQL Server Launchpad Service Fails to Start
description: Resolves a problem where the SQL Server Launchpad service fails to start after installing Windows update KB5044284 (OS Build 26100.2033) or a later version.
ms.date: 02/14/2025
ms.custom: sap:Machine Learning Services (in database)
ms.reviewer: jaferebe, v-sidong
---
# SQL Server Launchpad service fails to start after installing Windows updates

## Symptoms

You're running a Windows 11 machine with SQL Server installed with the [SQL Server Machine Learning Services](/sql/machine-learning/install/sql-machine-learning-services-windows-install) feature. After installing Windows update [KB5044284 (OS Build 26100.2033)](https://support.microsoft.com/topic/october-8-2024-kb5044284-os-build-26100-2033-6baf4a06-9763-4d9b-ba8a-f25ba6ed477b) or a later version, you notice the [SQL Server Launchpad service](/sql/machine-learning/concepts/extensibility-framework#launchpad) fails to start. After checking the [ExtLaunchErrorlog](/sql/machine-learning/troubleshooting/data-collection-ml-troubleshooting-process#system-events) file, you see the following error messages at the end of the file:

```output
<timestamp>	Security Context Manager initialization failed. ErrorCode: 0x8032000c.
<timestamp>	Satellite Session Manager initialization failed. ErrorCode: 0x8032000c.
<timestamp>	Initialization of satellite session manager failed. ErrorCode: 0x8032000c.
``` 

> [!NOTE]
> This issue doesn't impact Windows Server operating systems.

## Cause

Windows update [KB5044284 (OS Build 26100.2033)](https://support.microsoft.com/topic/october-8-2024-kb5044284-os-build-26100-2033-6baf4a06-9763-4d9b-ba8a-f25ba6ed477b) changed the behavior of the Windows API [CreateAppContainerProfile](/windows/win32/api/userenv/nf-userenv-createappcontainerprofile) that is called by the Launchpad service. This change causes the API to return an error, ultimately leading to the failure of the Launchpad service.

## Resolution

This symptom has been resolved in the latest version of the Windows cumulative update.
