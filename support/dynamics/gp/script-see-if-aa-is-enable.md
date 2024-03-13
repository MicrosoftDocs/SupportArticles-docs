---
title: Script to see if AA is enabled
description: SQL Script to see if AA is enabled in Microsoft Dynamics GP.
ms.reviewer: theley, Cwaswick
ms.topic: how-to
ms.date: 03/13/2024
---
# Script to see if AA is enabled in Microsoft Dynamics GP

This article describes how to check to see if AA is active or not in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4316764

## Question

How can I check to see if AA is active or not in Microsoft Dynamics GP?

## Answer

Execute the below SQL script against the Dynamics database:

```sql
select a.CMPANYID AS CompanyID, a.INTERID AS SQLDatabase,a.CMPNYNAM AS CompanyName, b.aaCompanyStatus as AAType,

CASE b.aaCompanyStatus

WHEN 4 THEN 'Activated with Data'

WHEN 5 THEN 'INVALID AA'

ELSE 'Not Enabled'

END   AS AAStatus

FROM DYNAMICS..AAG00104 b join DYNAMICS..SY01500 a

on a.CMPANYID = b.CMPANYID order by AAType DESC, CompanyID
```

-- if your Dynamics database isn't named Dynamics, edit the script accordingly for your named database.

Any results with Activated with Data will mean that AA records are getting populated in that database. Any database with this result will have a default record created for every journal entry even if you haven't begun setting up AA, and for all GL accounts even if no accounts are linked to a dimension. If you're using Management Reporter 2012 CU10 or newer, you can choose whether or not it will be reading data from the AA tables. In Microsoft Dynamics GP 2015 or newer, that option is located in (Microsoft Dynamics GP under **Administration**, then **Setup**, then under **Company** and **Company and Options**). In Microsoft Dynamics GP 2010 and GP 2013, that option is available in the Management Reporter Configuration Console. If Enable Analytical Accounting Reporting is marked, MR will read solely from the AA tables.

A result of INVALID AA means that AA Activation was started but didn't complete correctly. In this scenario, you'll need to start over with AA Activation if AA is needed for the company.  If you don't have a backup to restore to, a support case would be needed to reset the database for reactivation.
