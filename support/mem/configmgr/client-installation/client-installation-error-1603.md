---
title: Error 1603 installing the Configuration Manager client
description: Fixes an issue in which you receive error code 1603 when installing the Configuration Manager client.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Client Installation, Registration and Assignment\Client Installation
---
# MSI: Configuration Manager Client is not installed

This article helps you fix an issue in which you receive error code 1603 when installing the Configuration Manager client.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 2467702

## Symptoms

Attempts to install the Configuration Manager client may fail with the following error messages in the ccmsetup.log:

> MSI: Configuration Manager Client is not installed. ccmsetup 12-11-2010 16:26:12 3264 (0x0CC0)  
> Installation failed with error code 1603 ccmsetup 12-11-2010 16:26:12 3264 (0x0CC0)

If you check the client.msi.log, you may notice the following lines:

> MSI (s) (54:74) [16:26:11:416]: Checking in-progress install: install for same configuration.  
> MSI (s) (54:74) [16:26:11:416]: Suspended install detected. Resuming.

## Cause

This can occur if a previously failed installation of the Configuration Manager client left behind an IPI installer file (.ipi) in the `%systemroot%\installer` directory on the target computer.

## Resolution

Search for \*.ipi files in the `%systemroot%\installer` directory on the target computer and temporarily move them to a different folder. Next run the setup of the client installation again and it should complete successfully.
