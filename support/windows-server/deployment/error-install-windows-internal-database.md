---
title: MSSQL$MICROSOFT##WID service was unable to log on as NT SERVICE\MSSQL$MICROSOFT##WID error when you install WID in Windows Server 2012
description: Describes an issue in which installation of WID fails on a computer that's running Windows Server 2012. Provides workarounds.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Setup
ms.technology: windows-server-deployment
---
# Error when you install WID in Windows Server 2012: MSSQL$MICROSOFT##WID service was unable to log on as NT SERVICE\MSSQL$MICROSOFT##WID

This article provides workarounds for an issue in which installation of WID fails on a computer that's running Windows Server 2012.

_Original product version:_ &nbsp;Windows Server 2012 R2  
_Original KB number:_ &nbsp;2832204

## Symptoms

When you install Active Directory Federation Services (ADFS) by using the Add Roles and Features Wizard in Windows Server 2012, the Windows Internal Database (WID) installation fails. Additionally, you receive the following error message:

> The MSSQL$MICROSOFT##WID service was unable to log on as NT SERVICE\MSSQL$MICROSOFT##WID with the currently configured password due to the following error:  
Logon failure: the user has not been granted the requested logon type at this computer.  
Service: MSSQL$MICROSOFT##WID
>
> Domain and account: NT SERVICE\MSSQL$MICROSOFT##WID
>
> This service account does not have the required user right "Log on as a service."
>
> User Action
>
> Assign "Log on as a service" to the service account on this computer. You can use Local Security Settings (Secpol.msc) to do this. If this computer is a node in a cluster, check that this user right is assigned to the Cluster service account on all nodes in the cluster.
If you have already assigned this user right to the service account, and the user right appears to be removed, check with your domain administrator to find out if a Group Policy object associated with this node might be removing the right.

## Cause

When WID is installed, the NT SERVICE\MSSQL$MICROSOFT##WID local virtual account is created. This account is granted the **Log on as a service** user right by local Group Policy. If a Group Policy Object (GPO) that's linked to a site, domain, or organizational unit overwrites the local Group Policy setting, the NT SERVICE\MSSQL$MICROSOFT##WID account doesn't have the necessary user rights. So WID can't be installed.

## Workaround

To work around the issue, use one of the following methods:

- Assign the **Log on as a service** user right to NT SERVICE\ALL SERVICES in the GPO that defines the user right.
- Exclude the computer from the GPO that defines the user right.

## More information

You may also experience other symptoms in this situation. For example, the WID service may seem to be installed, but it doesn't start. Additionally, the Add Roles and Features Wizard indicates that a restart is pending.
