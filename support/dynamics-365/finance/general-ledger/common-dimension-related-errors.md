---
title: Fix Financial Dimension Errors in Dynamics 365 Finance
description: Troubleshoot and fix financial dimension issues, such as inactive dimensions, suspended values, and derived dimension rule conflicts, in Dynamics 365 Finance.
ms.date: 03/04/2026
ms.reviewer: anaborges, setharvila, ethankallett, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting/Issues with financial dimensions and financial tags
---

# Common dimension-related errors

## Summary

This article helps you resolve common [financial dimension](/dynamics365/finance/general-ledger/financial-dimensions) errors in Microsoft Dynamics 365 Finance. These errors can occur during posting or transaction entry, or if you configure dimension values, [account structures](/dynamics365/finance/general-ledger/configure-account-structures), or [advanced rule structures](/dynamics365/finance/general-ledger/tasks/create-assign-advanced-rule-structures). Each section describes a specific error message, its cause, and the steps to fix it.

## Symptoms

You might receive one of the following error messages when you work with financial dimensions in Dynamics 365 Finance:

- [Unable to return DimensionAttributeValue record for \<DimensionName>](#missing-dimension-value-record)
- [The financial dimension name \<DimensionName> contains invalid characters.](#invalid-characters-in-dimension-name)
- [The value \<Value> doesn't exist for \<DimensionName>.](#dimension-value-doesnt-exist)
- [\<DimensionName> is suspended.](#suspended-dimension-value)
- [\<DimensionName> isn't active.](#inactive-dimension-value)
- [The combination wasn't validated beyond the \<DimensionName> financial dimension.](#dimension-combination-not-fully-validated)
- [You must select a value in the \<DimensionName> field in combination with the following dimensions values that are valid.](#blank-dimension-value-not-allowed)
- [Blank isn't allowed for \<DimensionName> for the combination.](#blank-dimension-value-not-allowed)
- [\<DimensionName> is not an allowed value in combination with the following dimensions values that are valid.](#disallowed-dimension-value-in-combination)
- [Dimension values were validated with this advanced rule structure or account structure \<RuleOrAccountStructureName>](#account-structure-or-advanced-rule-violation)
- [\<DimensionValue> isn't a valid dimension value in account structure.](#invalid-dimension-value-in-account-structure)
- [The \<DimensionName> dimension with value \<Value> isn't allowed due to derived dimension rules. The allowed value should be \<AllowedValue>.](#derived-dimension-rule-prevents-value-changes)

## Missing dimension value record

You receive the following error message:

> Unable to return DimensionAttributeValue record for \<DimensionName>

This error message means the system can't find the dimension value. Several conditions can cause this issue.

### Add the missing dimension value

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. On the **Action Pane**, select **Financial dimension values**.
1. Check whether the dimension value exists.
1. If the value doesn't exist, add it.

### Check XDS and security role restrictions

[Extensible data security (XDS)](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies) policies that are combined with an insufficient security role might prevent you from viewing the dimension value. If XDS filters are applied to the backing entity, and your role doesn't include access to the company or entity where the value resides, the dimension value might appear blank or missing.

To check and assign the appropriate security role, follow these steps:

1. Go to **System administration** > **Users** > **Users**.
1. Select the affected user.
1. Select **Roles** > **Assign organizations**.
1. Review the access scope, and grant access to the required organizations. To test whether access restrictions cause the problem:
   1. Select **Grant access to all organizations**, and check whether the dimension value appears.
   1. If the dimension value appears, clear **Grant access to all organizations**, and then grant access to only the required organizations.

## Invalid characters in dimension name

You receive the following error message:

> The financial dimension name \<DimensionName> contains invalid characters.

[Financial dimension](/dynamics365/finance/general-ledger/financial-dimensions) names must follow specific naming conventions:

- Must start with an underscore or a letter (either lowercase or uppercase).
- Can contain only underscores, letters, or digits after the first character.
- Can't contain system field names such as `RecId`.

To fix this issue, follow these steps:

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Review the dimension name to make sure that it follows the naming conventions.
1. Rename the dimension, if it's necessary. Don't use system field names or invalid characters.

## Dimension value doesn't exist

You receive the following error message:

> The value \<Value> doesn't exist for \<DimensionName>.

This error typically means that the dimension value that you entered doesn't exist in the system.

To verify the dimension value, follow these steps:

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. On the Action Pane, select **Financial dimension values**.
1. Search for the value to verify that it exists.

If the dimension value doesn't appear, verify that you're in the correct legal entity. Certain entity-backed dimensions are company-specific and don't appear outside the company where you created them.

If the dimension value exists but you still receive this error message, try the following workaround:

1. Rename the dimension value to a temporary name.
1. Revert the name to the original name.

> [!NOTE]
> The rename process takes time because it runs as a background job through the Data Maintenance portal. To monitor the progress:
>
> 1. Go to **System administration** > **Periodic tasks** > **Data maintenance**.
> 1. Check the *Dimension value rename and modify chart of accounts delimiter process* job.

## Suspended dimension value

You receive the following error message:

> \<DimensionName> is suspended.

The dimension value is suspended, either at the header level or as a legal entity override.

### Reactivate the suspended dimension value

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Select the dimension type, and then select **Dimension values**.
1. Check whether the dimension value is marked as suspended. Reactivate it, if it's necessary.

### Check for default or derived dimensions that apply suspended values

If you didn't directly enter the suspended segment into the ledger account, default dimensions or [derived dimensions](/dynamics365/finance/general-ledger/financial-dimensions#derived-dimensions) in your setup might be applying it. To investigate this issue:

1. Review the main account for fixed dimensions that are suspended.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Update your default dimension setup accordingly.

## Inactive dimension value

You receive the following error message:

> \<DimensionName> isn't active.

The dimension value is inactive on the date of the transaction, either at the header level or as a legal entity override.

### Reactivate the inactive dimension value

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Select the dimension type, and then select **Dimension values**.
1. Check whether the dimension value is marked as inactive on the transaction date.

### Check for default or derived dimensions that apply inactive values

If you didn't directly enter the inactive segment into the ledger account, default dimensions or [derived dimensions](/dynamics365/finance/general-ledger/financial-dimensions#derived-dimensions) in your setup might be applying it:

1. Review the main account for fixed dimensions that are inactive.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Update your default dimension setup accordingly.

## Dimension combination not fully validated

You receive the following error message:

> The combination wasn't validated beyond the \<DimensionName> financial dimension.

The dimension value that you specified doesn't follow the [account structure](/dynamics365/finance/general-ledger/configure-account-structures) or [advanced rules](/dynamics365/finance/general-ledger/tasks/create-assign-advanced-rule-structures) that are set up for the ledger. The error message typically identifies the account structure or advanced rule that was violated.

### Review the account structure and advanced rule setup

1. Identify the violating rule from the error message.
1. Go to **General ledger** > **Ledger setup** > **Ledger**.
1. Review the account structure and advanced rule setup.
1. Verify that the account combination is allowed under the current configuration.

For more information, see [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures).

### Check whether the segment is suspended or inactive

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Review the financial dimension settings.
1. Check whether the dimension value is suspended or inactive. Reactivate it, if it's necessary.

### Check for default or derived dimensions that cause invalid segments

If you didn't directly enter the violating segment into the ledger account, default dimensions or [derived dimensions](/dynamics365/finance/general-ledger/financial-dimensions#derived-dimensions) in your setup might be applying it:

1. Review the main account for fixed dimensions that conflict with your entry.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Update your default dimension setup accordingly.

## Blank dimension value not allowed

You receive one of the following error messages:

> You must select a value in the \<DimensionName> field in combination with the following dimensions values that are valid.

> Blank isn't allowed for \<DimensionName> for the combination.

These errors appear if a ledger combination has a blank value that contradicts the [account structure](/dynamics365/finance/general-ledger/configure-account-structures) or [advanced rules](/dynamics365/finance/general-ledger/tasks/create-assign-advanced-rule-structures).

### Fill in the required dimension values

1. Go to the transaction where the error occurs.
1. Fill in the required dimension values that are currently blank.
1. Make sure that all mandatory dimensions have values according to the account structure.

### Check for default or derived dimensions that cause blanks

If you didn't directly leave the field blank, default dimensions or [derived dimensions](/dynamics365/finance/general-ledger/financial-dimensions#derived-dimensions) in your setup might be causing blank values:

1. Review the main account for fixed dimensions that should populate automatically.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Update your default dimension setup accordingly.

### Modify the account structure or advanced rules to allow blanks

As an alternative solution, modify the account structure or advanced rules to allow blank values:

1. Go to **General ledger** > **Chart of accounts** > **Structures** > **Account structures**.
1. Review the account structure settings, and modify them to allow blank values as appropriate.
1. Go to **General ledger** > **Chart of accounts** > **Structures** > **Advanced rule structures**.
1. Review and modify advanced rule configurations to allow blanks, if it's necessary.

For more information, see [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures).

## Disallowed dimension value in combination

You receive the following error message:

> \<DimensionName> is not an allowed value in combination with the following dimensions values that are valid.

This error message appears if a dimension value doesn't follow the [account structure](/dynamics365/finance/general-ledger/configure-account-structures) or [advanced rules](/dynamics365/finance/general-ledger/tasks/create-assign-advanced-rule-structures) that are set up for the ledger.

### Review the account structure and advanced rule setup

1. Identify the violating rule from the error message. Typically, the message identifies the account structure or advanced rule that was violated.
1. Go to **General ledger** > **Ledger setup** > **Ledger**.
1. Review the account structure and advanced rule setup.
1. Verify that the account combination is allowed under the current configuration.
1. Change the dimension value to one that's allowed by the account structure.

For more information, see [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures).

### Make sure the account structure is activated

1. Go to **General ledger** > **Chart of accounts** > **Structures** > **Configure account structures**.
1. Check the status of the account structure. If it shows **Draft**, the changes don't take effect.
1. Select **Activate** on the Action Pane.

### Verify the account structure is assigned to the ledger

1. Go to **General ledger** > **Ledger setup** > **Ledger**.
1. Verify that the account structure appears in the list.

### Check for default or derived dimensions that cause incorrect values

If you didn't directly enter the violating value, default dimensions or [derived dimensions](/dynamics365/finance/general-ledger/financial-dimensions#derived-dimensions) in your setup might be applying it:

1. Review the main account for fixed dimensions that conflict with your entry.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Update your default dimension setup accordingly.

## Account structure or advanced rule violation

You receive the following error message:

> Dimension values were validated with this advanced rule structure or account structure \<RuleOrAccountStructureName>

This error occurs if an account doesn't follow the [account structure](/dynamics365/finance/general-ledger/configure-account-structures) or [advanced rules](/dynamics365/finance/general-ledger/tasks/create-assign-advanced-rule-structures) that are configured for the ledger. Typically, the error message identifies which account structure or advanced rule was violated.

### Review the account structure and advanced rule setup

1. Go to **General ledger** > **Ledger setup** > **Ledger**.
1. Check the account structures that are assigned to the ledger.
1. Verify that the account combination complies with the configured rules.

For more information, see [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures).

### Check for default or derived dimensions that cause the violation

If you didn't manually enter the segment that caused the error, default or [derived dimensions](/dynamics365/finance/general-ledger/financial-dimensions#derived-dimensions) might be providing the value:

1. Review the main account for fixed dimension values that conflict with the account structure.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Update your default dimension setup accordingly.

## Invalid dimension value in account structure

You receive the following error message:

> \<DimensionValue> isn't a valid dimension value in account structure.

This error message appears if a value in the ledger account combination doesn't meet the constraints that are defined in the assigned [account structure](/dynamics365/finance/general-ledger/configure-account-structures).

### Use a valid dimension value

1. Review the account structure to identify which values are allowed for the dimension.
1. Go to the transaction where the error occurs.
1. Replace the invalid dimension value with one that's permitted by the account structure configuration.

### Activate the account structure

1. Go to **General ledger** > **Chart of accounts** > **Structures** > **Configure account structures**.
1. Select the account structure.
1. Select **Activate** on the Action Pane.

For more information, see [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures).

### Verify the account structure is assigned to the ledger

1. Go to **General ledger** > **Ledger setup** > **Ledger**.
1. Verify that the account structure appears in the list.

## Derived dimension rule prevents value changes

You receive the following error message:

> The \<DimensionName> dimension with value \<Value> isn't allowed due to derived dimension rules. The allowed value should be \<AllowedValue>.

This error occurs if a [derived dimension](/dynamics365/finance/general-ledger/financial-dimensions#derived-dimensions) rule has the **Prevent changes** option enabled for the segment that caused the error. If you enable this option, the derived dimension automatically populates the segment and prevents manual changes.

To resolve this issue, follow these steps:

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Select each dimension used in the account structure.
1. Review the derived dimension rules for each dimension.
1. If you don't want the derived dimension to automatically populate the specified segment, disable the **Prevent changes** option.

## Related content

- ["The account type for main account... is not valid" error when posting in General ledger](troubleshoot-posting-errors.md)
- [Can't post a journal due to imbalance](posting-fail-imbalance.md)
- [Plan your chart of accounts](/dynamics365/finance/general-ledger/plan-chart-of-accounts)
