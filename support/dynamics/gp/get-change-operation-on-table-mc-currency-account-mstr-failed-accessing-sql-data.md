---
title: Error when approving employee expense
description: You receive an error in Personal Data Keeper (PDK) of A get/change operation on table 'MC_Currency_Account_MSTR' failed accessing SQL data when you attempt to approve an employee expense.
ms.reviewer: ppeterso
ms.topic: troubleshooting
ms.date: 04/22/2021
---
# "A get/change operation on table 'MC_Currency_Account_MSTR' failed accessing SQL data" error when approving an employee expense in Project Accounting

This article provides a resolution for the issue that an error occurs when you approve an employee expense that was entered in an originating currency in Project Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2489329

## Symptoms

When you approve an employee expense that was entered in an originating currency in Personal Data Keeper (PDK) after you install a new version of Microsoft Dynamics GP, you receive the following message:

> A get/change operation on table 'MC_Currency_Account_MSTR' failed accessing SQL data

When you select the **More Info** button, you receive the following error:

> Number of results columns doesn't match table definition

## Cause

There was a table change made to the MC00200 (Multicurrency Account Master) table in version 11.0.1524 of Microsoft Dynamics GP that PDK was not aware of. This caused an incompatibility issue between the two applications.

## Resolution

A new version of PDK must be installed. You need to install version 11.00.1525 of Personal Data Keeper (PDK) to be compatible with Microsoft Dynamics GP 2010 Service Pack 1.
