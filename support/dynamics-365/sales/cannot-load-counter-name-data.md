---
title: Error when installing Update Rollup for CRM client for Outlook
description: Fixes an issue in which you get the "Cannot load Counter Name data" error when trying to install Update Rollups for the Microsoft Dynamics CRM Client for Outlook. 
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# An error may occur when trying to install Update Rollup for Microsoft Dynamics CRM client for Outlook

This article helps you fix an issue in which you get the "Cannot load Counter Name data" error when trying to install Update Rollups for the Microsoft Dynamics CRM Client for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2832079

## Symptoms

When installing update rollups for the Microsoft Dynamics CRM Client for Outlook, you get the below error:

> The type initializer for 'Microsoft.Crm.LocatorService' threw an exception.  
> Cannot load Counter Name data because an invalid index '' was read from the registry.

## Cause

The performance counters have been corrupted on the client machine and they must be rebuilt.

## Resolution

1. Go to **Start**, and type `cmd`.

2. Right-click cmd.exe and choose **Run as administrator**.

3. Type `lodctr /r` and press Enter.

   You will then get the message:

   > Info: Successfully rebuilt performance counter setting from system backup store.

4. Check if there are providers that are disabled, write `lodctr /q`, and press Enter

5. You will then get a long list of providers, make sure that the <*CRM Client*> is enabled, see below

    If not, write `lodctr /e:CRM Client` and press Enter.

6. Install the Microsoft Dynamics CRM for Outlook client Update Rollup.
