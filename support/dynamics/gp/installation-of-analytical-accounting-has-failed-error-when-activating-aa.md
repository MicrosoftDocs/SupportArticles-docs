---
title: Installation of analytical accounting has failed error when activating Analytical Accounting
description: When trying to activate Analytical Accounting (AA), you receive an error message that states installation of analytical accounting has failed as there are other users logged into the system. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Analytical Accounting
---
# "Installation of analytical accounting has failed..." error when activating Analytical Accounting (AA)

This article provides a resolution for the issue that you can't activate Analytical Accounting (AA) due to the **Installation of analytical accounting has failed...** error in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4099427

## Symptoms

You receive this error when trying to activate Analytical Accounting (AA) in Microsoft Dynamics GP:

> Installation of analytical accounting has failed as there are other users logged into the system

There are other users logged into DYNAMICS, but not that particular Company where you are adding AA. You are wondering if everyone has to be out of Dynamics GP to create default records as well as running the AA Activation Wizard itself.

## Cause

Users logged into Dynamics GP while activating Analytical Accounting.

All users do need to be out of the system (all companies in same Dynamics database) when going through the AA activation process. This is mainly because Analytical Accounting uses the dynamics table (AAG00102) to populate the next record values in the AAG work, open, and history tables for all of the companies. When you activate AA, those tables will have default records created so that you can go back and add dimensions (using the AA edit analysis window) to posted journal entries should you need to. It will also update a flag setting in the dynamics AAG00104 table after the activation is completed. Since the Dynamics tables are impacted, all users need to be out of all company databases.

## Resolution

Run these scripts to see if anyone else is in the system and ask them to exit properly through the front-end. If all users are out, these tables should be empty, so provided `delete` scripts below as well.

```sql
SELECT * FROM DYNAMICS..ACTIVITY
SELECT * FROM DYNAMICS..SY00800
SELECT * FROM DYNAMICS..SY00801
SELECT * FROM TEMPDB..DEX_LOCK
SELECT * FROM TEMPDB..DEX_SESSION
----------------------------------------
DELETE DYNAMICS..ACTIVITY
DELETE DYNAMICS..SY00800
DELETE DYNAMICS..SY00801
DELETE TEMPDB..DEX_LOCK
DELETE TEMPDB..DEX_SESSION
```
