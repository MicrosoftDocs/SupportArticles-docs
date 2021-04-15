---
title: Can't upgrade the Configuration Manager management pack
description: Fixes an issue where upgrading the Configuration Manager management pack for Operations Manager fails with the could not be imported error.
ms.date: 07/13/2020
ms.prod-support-area-path:
---
# Could not be imported error when upgrading Configuration Manager management pack for Operations Manager

This article helps you fix the **could not be imported** error when you upgrade the Configuration Manager management pack to version 5.0.8239.1009 for Operations Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager, System Center 2012 R2 Operations Manager, Microsoft System Center 2012 R2 Configuration Manager, Microsoft System Center 2012 Configuration Manager, Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 3192608

## Symptoms

When trying to upgrade the Configuration Manager management pack to version 5.0.8239.1009, you encounter the following error:

> Microsoft System Center 2012 Configuration Manager Discovery could not be imported.
>
> If any management packs in the Import list are dependent on this management pack, the installation of the dependent management packs will fail.
>
> Verification failed with 2 errors:  
> \----------------------------------------------------  
> Error 1:  
> Found error in 2\|Microsoft.SystemCenter2012.ConfigurationManager.Discovery\|5.0.7804.1000\|Microsoft.SystemCenter2012.ConfigurationManager.Discovery\|\| with message:  
> Version 5.0.8239.1009 of the management pack is not upgrade compatible with older version 5.0.7804.1000. Compatibility check failed with 1 errors:  
> \-------------------------------------------------------  
> Error 2:  
> Found error in 1\|Microsoft.SystemCenter2012.ConfigurationManager.Discovery/31bf3856ad364e35\|1.0.0.0\|Microsoft.SystemCenter2012.ConfigurationManager.SiteSystemInfo\|\| with message:  
> The property Key (ServerRemoteName) has a value that is not upgrade compatible. OldValue=True, NewValue=False.  
> \-------------------------------------------------------

## Cause

The error occurs because Microsoft.SystemCenter2012.ConfigurationManager.Discovery management pack version 5.0.8239.1009 is not upgrade-compatible with previous versions due to a design change.

## Resolution

To upgrade, remove (delete) the existing management pack (Microsoft.SystemCenter2012.ConfigurationManager.Discovery, version 5.0.7804.1000) that will not update, and then import the new one (Microsoft.SystemCenter2012.ConfigurationManager.Discovery, version 5.0.8239.1009).
