---
title: Do you want to add this code error when saving Analytical Accounting Transaction Dimension Code
description: Describes a problem where the AAG00401 table is not updated when you save an Analytical Accounting transaction dimension code in Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Do you want to add this code" error when saving an Analytical Accounting Transaction Dimension Code in Microsoft Dynamics GP

This article provides a resolution for the **Do you want to add this code** that occurs when you add an Analytical Accounting transaction dimension code in the Analytical General Transaction Entry window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968057

## Symptoms

When you add an Analytical Accounting transaction dimension code in the Analytical General Transaction Entry window, you receive the following message:

> Do you want to add this code?

You continue to receive this message even though the code is saved in the Transaction Dimension Code Maintenance window.

## Cause

This problem is caused because the following triggers are missing from the AAG00401 table:

- aagTR_AAG00401Del
- aagTR_AAG00400Ins
- aagUpdateDateTimefor401

## Resolution

To resolve this problem, you will need to add back the triggers using these steps:

1. Open SQL Server Management Studio.
2. In the Object Explorer section, expand the **Databases**, expand the appropriate company database, expand **Tables**, expand **dbo.AAG00401**, and then expand **Triggers**.
3. Right-click **aagTR_AAG00401Del**, point to **Script trigger as**, point to **CREATE to**, and then select **New Query Editor Window**.
4. After the script is created in a new query window, run the script against the company database to create the trigger.
5. Repeat step 3 and step 4 for the following triggers:

    - aagTR_AAG00400Ins
    - aagUpdateDateTimefor401
