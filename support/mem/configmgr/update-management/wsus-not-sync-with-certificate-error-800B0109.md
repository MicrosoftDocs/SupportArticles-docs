---
title: WSUS doesn't sync and returns a certificate error 800B0109
description: Fixes an issue in which WSUS doesn't sync with Microsoft on Windows Server 2008 R2 servers because of a certificate error.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Software Update Management (SUM)\Software Update Synchronization
---
# WSUS doesn't sync with Microsoft on Windows Server 2008 R2 servers because of a certificate error

This article helps you fix an issue in which Windows Server Update Services (WSUS) doesn't sync with Microsoft on a Windows Server 2008 R2 server because of a certificate error 800B0109.

_Original product version:_ &nbsp; Windows Server Update Services 3.0 Service Pack 2  
_Original KB number:_ &nbsp; 4535405

## Symptoms

When you initiate a sync from WSUS to Microsoft, the WSUS sync fails on a Windows Server 2008 R2 server and logs the following error entry in the SoftwareDistribution.log file:

> The given certificate chain has not Microsoft Root CA signed root (800B0109)  
> The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel

If you are using Configuration Manager, the sync will fail, logging the following error in WSYNCMGR.log:

> Sync Failed: USSCommunicationError: WebException: The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel

## Cause

This problem occurs because the WSUS application on the server is not SHA2-compliant. We recently changed the signing process to sign by using SHA2 only.

## Resolution

To fix this problem, download and install [Update for Windows Server 2008 R2 for x64-based Systems (KB4484071)](https://www.catalog.update.microsoft.com/Search.aspx?q=KB4484071) that was released on November 12, 2019.

You can check the following logs for the installation progress:

- %temp%
- MWusCa.log
- MWusSetup.log

### Prerequisites

To install this update, the user must sign in as **sysadmin** to the SQL Server instance that runs the SUSDB database.

### Restart requirement

No reboot is required after installing this update.
