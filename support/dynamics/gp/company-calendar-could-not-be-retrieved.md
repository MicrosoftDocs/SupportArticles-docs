---
title: Company calendar could not be retrieved
description: Provides a solution to an error that occurs when you generate a report in Microsoft Management Reporter.
ms.reviewer: theley, kevogt, gbyer
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "The company calendar couldn't be retrieved" Error message when you generate a report in Microsoft Management Reporter

This article provides a solution to an error that occurs when you generate a report in Microsoft Management Reporter.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2688038

## Symptoms

When you generate a report in Management Reporter for Dynamics GP, you receive the following error message:

> The company calendar couldn't be retrieved from the source system

## Cause

Cause 1

The data provider version doesn't match the other installed Management Reporter components. See Resolution 1 in the [Resolution](#resolution) section.

Cause 2

The fiscal years or periods have an issue preventing Management Reporter from using the information. See Resolution 2 in the [Resolution](#resolution) section.

## Resolution

Resolution 1

1. Confirm the version of MR. You can browse to the folder `C:\Program Files\Microsoft Dynamics ERP\Management Reporter\2.0\Client and check the version of ReportDesigner.exe`.
2. Confirm the version of the data provider. Make sure that this version matches the MR version from step 1. Browse to `C:\Program Files\Microsoft Dynamics ERP\Management Reporter\2.0\Providers\Dynamics GP 11.0` and check the version of any of the .dll's in that folder.

The version of the data provider and the MR client must be the same. If it isn't the same, you'll have to download and apply the appropriate service pack.

Resolution 2  

1. Start Dynamics GP and sign in to the company in question as sa.
2. Select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Company** and then select **Fiscal Periods**.
3. Make sure that there is at least one year that doesn't have the Historical box marked. It's required for MR.
4. Make sure that for each non-historical year there is at least one Financial series period open.
5. Make sure that none of the years or periods have any gaps or overlap.
6. If there are gaps or overlaps, you must correct it in GP and then you should be able to use Management Reporter again. It would include if there are gaps in the years such as 1999 and then the next year being 2001, you would have to create the 2000 year and populate it with periods.
