---
title: Server principal cannot access database
description: Provides a solution to an error that occurs when using Audit Trails in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# "The server principal 'xxx' is not able to access the database 'XXXXX' under the current security context." Error message when using Audit Trails in Microsoft Dynamics GP

This article provides a solution to an error that occurs when using Audit Trails in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2450782

## Symptoms

A user who has Audit Trail permissions can no longer access Audit Trails or run Audit Trail reports. For example, in the Smart view window in Audit Trails, these messages occur (referencing the user's alias for the xxxxx and respective Audit database for the XXXXX):

> GPS Error epAuditTrailView I_PB_Refresh_CHG: 10

> SQL Error epAuditTrailView I_PB_Refresh_CHG: 916

> The server principal 'xxxxx' is not able to access the database 'XXXXX' under the current security context.

> ODBC Error epAuditTrailView I_PB_Refresh_CHG: 08004

## Cause

The security table in Audit Trails (mxTableAccess - MXAT4001) needs to be refreshed.

## Resolution

To resolve the issue you can install Audit Trails again to refresh the security table, as follows:

1. Select **Microsoft Dynamics GP**, point to **Tools**, point to **Company**, point to **Audit Trails**, and select **Install Audit Trails**.

2. In the **Install Audit Trails** window, select **Install**.

3. In the Install Wizard window, select **Install**.

4. Select **Finish**.

## More information

Installing Audit Trails again will automatically grant users access to the audit databases. Since Audit Trails is already installed for the company, the installation will realize it and move to Step #3 in the Install Wizard that will take the system through the process of adding new users to the database. It won't reset any audits or anything that is already set up. The current data in the audit tables will stay intact.
