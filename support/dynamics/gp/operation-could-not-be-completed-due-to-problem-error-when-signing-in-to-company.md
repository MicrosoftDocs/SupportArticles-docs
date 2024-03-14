---
title: The operation could not be completed due to a problem in the data provider framework error when you sign in to a company
description: Describes an error message you may receive in Management Reporter 2012. Provides a resolution.
ms.reviewer: theley, kellybj, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Management Reporter
---
# "The operation could not be completed due to a problem in the data provider framework" error when signing in to a company

This article provides a resolution for the issue that you can't sign in to a company in Management Reporter 2012 Report Designer that is using the Data Mart provider.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics SL 2011, Microsoft Dynamics SL 2011 Service Pack 1  
_Original KB number:_ &nbsp; 2836757

## Symptoms

You may receive the following error when you sign in to a company in Management Reporter 2012 Report Designer that is using the Data Mart provider:

> The operation could not be completed due to a problem in the data provider framework
>
> Microsoft.Dynamics.Performance.DataProvider.Core.RequestException: The source system request did not complete successfully. ---> System.InvalidOperationException: Sequence contains no elements

## Cause

This error can be caused if you do not have any accounts created in the general ledger or you have not posted anything yet.

## Resolution

Make sure accounts have been created in the general ledger and that there is at least one transaction posted.
