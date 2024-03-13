---
title: Missing account balance if enabling Exclude inactive accounts
description: When the option exclude inactive accounts is selected, account balances are missing from Management Reporter 2012 reports. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Account balance is missing in Management Reporter 2012 for Dynamics GP when Exclude inactive accounts is checked

This article provides a resolution for the issue that the account balance is missing in Management Reporter 2012 for Dynamics GP when the **Exclude inactive accounts** option is checked.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2975343

## Symptom

When you generate a report in Management Reporter 2012 using the data mart with Microsoft Dynamics GP, the balance for some accounts are missing. This happens if you select the option **Exclude inactive accounts**, on the **Additional Options** tab of the report settings. If you clear this option, the account balance will display on the report.

## Cause

When an account is marked as inactive in Microsoft Dynamics GP, all of the accounts with the same main account number will be marked as inactive in Management Reporter 2012.

For example, in Microsoft Dynamics GP there is an account with a full account number of 00-1100-320. This account is marked inactive. The main account segment is 1100. There is another account with a full account number of 00-1100-420. This account is considered active in Microsoft Dynamics GP. If the **Exclude inactive accounts** checkbox is selected when you generate a report that includes the main account number of 1100 in the row definition, both of the 1100 accounts will return a result of zero.

## Resolution

There are two options for this issue.

Option 1: Leave the **Exclude inactive accounts** checkmark unchecked in the **Additional Options** of the Report Settings.

1. In the report designer, select Report definitions in the navigation section, and double-click to open the report definition.
2. On the **Settings** tab, select **Other**, and then select **Additional Options**. Clear the check box next to **Exclude inactive accounts**.
3. Select **OK**, save the report definition, and then generate the report.

Option 2: Leave the account active in Microsoft Dynamics GP.

1. In Microsoft Dynamics GP, select **Cards**, select **Financial** and then select **Account**.
2. Search for the account number and then clear the **Inactive** check box. Leave the option **Allow Account Entry** cleared.

This option will adjust the account so that it is no longer marked as inactive, but transactions cannot be posted to the account within Microsoft Dynamics GP.

## More information

This functionality is by design, however this could be changed in a future release of Management Reporter 2012.
