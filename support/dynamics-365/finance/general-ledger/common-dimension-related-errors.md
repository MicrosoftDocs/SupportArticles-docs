---
title: Fix Financial Dimension Errors in Dynamics 365 Finance
description: Troubleshoot financial dimension errors in Dynamics 365 Finance, including inactive or suspended values and derived rule conflicts. Follow the steps to fix them.
ms.date: 07/21/2026
ms.reviewer: anaborges, setharvila, ethankallett, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
ai-usage: ai-assisted
---

# Fix financial dimension-related errors in Dynamics 365 Finance

## Summary

This article helps you resolve common [financial dimension](/dynamics365/finance/general-ledger/financial-dimensions) errors in Microsoft Dynamics 365 Finance. These errors can occur during posting or transaction entry, or if you configure dimension values, [account structures](/dynamics365/finance/general-ledger/configure-account-structures), or [advanced rule structures](/dynamics365/finance/general-ledger/tasks/create-assign-advanced-rule-structures). Each section describes a specific error message, its cause, and the steps to fix it.

## Symptoms

You might receive one of the following error messages when you work with financial dimensions in Dynamics 365 Finance:

- [The combination wasn't validated beyond the \<DimensionName> financial dimension.](#combination-not-validated-beyond-financial-dimension)
- [You must select a value in the \<DimensionName> field in combination with the following dimensions values that are valid.](#blank-isnt-allowed-for-dimension-in-combination)
- [Blank isn't allowed for \<DimensionName> for the combination.](#blank-isnt-allowed-for-dimension-in-combination)
- [\<DimensionName> is not an allowed value in combination with the following dimensions values that are valid.](#dimension-value-not-allowed-in-combination)
- [\<DimensionName> is suspended.](#dimension-value-is-suspended)
- [\<DimensionName> isn't active.](#dimension-value-isnt-active)
- [Dimension values were validated with this advanced rule structure or account structure \<RuleOrAccountStructureName>](#dimension-values-validated-with-account-structure-or-advanced-rule)
- [\<DimensionValue> isn't a valid dimension value in account structure.](#not-a-valid-dimension-value-in-account-structure)
- [The \<DimensionName> dimension with value \<Value> isn't allowed due to derived dimension rules. The allowed value should be \<AllowedValue>.](#value-isnt-allowed-due-to-derived-dimension-rules)
- [Unable to return DimensionAttributeValue record for \<DimensionName>](#unable-to-return-dimensionattributevalue-record)
- [The financial dimension name \<DimensionName> contains invalid characters.](#financial-dimension-name-contains-invalid-characters)
- [The value \<Value> doesn't exist for \<DimensionName>.](#value-doesnt-exist-for-financial-dimension)
- [The row with \<DimensionName> \<Criteria> overlaps with the row with \<Criteria>.](#rows-overlap-in-an-account-structure-or-advanced-rule)
- [The row with \<DimensionName> values \<Values> overlaps with the row with values \<Values>.](#rows-overlap-in-an-account-structure-or-advanced-rule)

## Combination not validated beyond financial dimension

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

If you didn't directly enter the violating segment into the ledger account, default dimensions or [derived dimensions](/dynamics365/finance/general-ledger/derived-dimensions) in your setup might be applying it:

1. Review the main account for fixed dimensions that conflict with your entry.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Update your default dimension setup accordingly.

## Blank isn't allowed for dimension in combination

You receive one of the following error messages:

> You must select a value in the \<DimensionName> field in combination with the following dimensions values that are valid.

> Blank isn't allowed for \<DimensionName> for the combination.

These errors appear if a ledger combination has a blank value that contradicts the [account structure](/dynamics365/finance/general-ledger/configure-account-structures) or [advanced rules](/dynamics365/finance/general-ledger/tasks/create-assign-advanced-rule-structures).

### Fill in the required dimension values

1. Go to the transaction in which the error occurs.
1. Fill in the required dimension values that are currently blank.
1. Make sure that all mandatory dimensions have values according to the account structure.

### Check for default or derived dimensions that cause blanks

If you didn't directly leave the field blank, default dimensions or [derived dimensions](/dynamics365/finance/general-ledger/derived-dimensions) in your setup might cause blank values:

1. Review the main account for fixed dimensions that should populate automatically.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Update your default dimension setup accordingly.

### Modify the account structure or advanced rules to allow blanks

As an alternative solution, modify the account structure or advanced rules to allow blank values:

1. Go to **General ledger** > **Chart of accounts** > **Structures** > **Account structures**.
1. Review the account structure settings, and modify them to allow blank values, as appropriate.
1. Go to **General ledger** > **Chart of accounts** > **Structures** > **Advanced rule structures**.
1. Review and modify advanced rule configurations to allow blanks, if necessary.

For more information, see [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures).

## Dimension value not allowed in combination

You receive the following error message:

> \<DimensionName> is not an allowed value in combination with the following dimensions values that are valid.

This error message appears if one or more financial dimension values conflict with the constraints defined in your [account structures](/dynamics365/finance/general-ledger/configure-account-structures), [advanced rules](/dynamics365/finance/general-ledger/tasks/create-assign-advanced-rule-structures), or dimension configuration.

### Review the account structure constraints

The account structure might explicitly prohibit the dimension value for the combination you entered.

1. Go to **General ledger** > **Chart of accounts** > **Structures** > **Configure account structures**.
1. Select the account structure that's referenced in the error message, and then select **Edit**.
1. Review the allowed values for each segment. Confirm that the dimension value from the error message falls within the allowed ranges or criteria.
1. If the account structure uses a criteria expression, verify that it uses semicolons (`;`) to separate multiple dimension values rather than commas (`,`). Commas in criteria expressions can cause values to be excluded unexpectedly.
1. If the account structure is in **Draft** status, the latest changes aren't in effect. Select **Activate** on the Action Pane to apply the changes.

For more information, see [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures).

### Check advanced rules

Advanced rules apply extra constraints on top of the base account structure. When multiple rules apply, the system enforces the most restrictive combination.

1. On the **Configure account structures** page, select **Advanced rules** for the relevant account structure.
1. Review each rule to check whether it further constrains the valid values beyond what the base account structure allows.
1. Check that every advanced rule has a criteria filter. A rule without a filter applies to all transactions and might cause unexpected restrictions.

### Verify that the dimension value is active

The main account or dimension value might be suspended, inactive, or outside its valid date range.

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Select the relevant dimension, and then select **Financial dimension values**.
1. Locate the value from the error message and confirm the following conditions:
   - The **Suspended** option isn't set to **Yes** on the **General** tab.
   - The **Active from** and **Active to** dates include the transaction date.
   - If [legal entity overrides](/dynamics365/finance/general-ledger/financial-dimensions#legal-entity-overrides) are configured, verify that the value isn't suspended or inactive for the specific legal entity where the transaction is entered.

### Check for fixed dimensions

A [fixed dimension value](/dynamics365/finance/general-ledger/dimensions-default-values) on a main account replaces whatever value is entered on the transaction line, even if that value is blank. If the account structure requires a nonblank value and the fixed dimension is blank, the validation fails.

1. Go to **General ledger** > **Chart of accounts** > **Accounts** > **Main accounts**.
1. Select the main account that's used in the transaction.
1. On the **Legal entity overrides** FastTab, check whether a fixed dimension value is set that conflicts with the value you entered or that forces a blank value where one isn't allowed.

### Verify the account structure is assigned to the ledger

1. Go to **General ledger** > **Ledger setup** > **Ledger**.
1. Verify that the correct account structure appears in the list.

### Check for default or derived dimensions that cause incorrect values

If you didn't directly enter the violating value, default dimensions or [derived dimensions](/dynamics365/finance/general-ledger/derived-dimensions) in your setup might be applying it:

1. Review the main account for fixed dimensions that conflict with your entry.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Check whether [interunit dimensions](/dynamics365/finance/general-ledger/example-balanced-journals-interunit-accounting) are enabled. Interunit balancing can cause the system to validate a different main account or dimension value than what you entered.
1. Update your default dimension setup accordingly.

## Dimension value is suspended

You receive the following error message:

> \<DimensionName> is suspended.

The dimension value is suspended, either at the header level or as a legal entity override.

### Reactivate the suspended dimension value

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Select the dimension type, and then select **Dimension values**.
1. Check whether the dimension value is marked as suspended. Reactivate it, if necessary.

### Check for default or derived dimensions that apply suspended values

If you didn't directly enter the suspended segment into the ledger account, default dimensions or [derived dimensions](/dynamics365/finance/general-ledger/derived-dimensions) in your setup might be applying it. To investigate this issue:

1. Review the main account for fixed dimensions that are suspended.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Update your default dimension setup accordingly.

## Dimension value isn't active

You receive the following error message:

> \<DimensionName> isn't active.

The dimension value is inactive on the date of the transaction, either at the header level or as a legal entity override.

### Reactivate the inactive dimension value

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Select the dimension type, and then select **Dimension values**.
1. Check whether the dimension value is marked as inactive on the transaction date.

### Check for default or derived dimensions that apply inactive values

If you don't directly enter the inactive segment into the ledger account, default dimensions or [derived dimensions](/dynamics365/finance/general-ledger/derived-dimensions) in your setup might apply it:

1. Review the main account for fixed dimensions that are inactive.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Update your default dimension setup accordingly.

## Dimension values validated with account structure or advanced rule

You receive the following error message:

> Dimension values were validated with this advanced rule structure or account structure \<RuleOrAccountStructureName>

This error occurs if an account doesn't follow the [account structure](/dynamics365/finance/general-ledger/configure-account-structures) or [advanced rules](/dynamics365/finance/general-ledger/tasks/create-assign-advanced-rule-structures) that are configured for the ledger. Typically, the error message identifies which account structure or advanced rule was violated.

### Review the account structure and advanced rule setup

1. Go to **General ledger** > **Ledger setup** > **Ledger**.
1. Check the account structures that are assigned to the ledger.
1. Verify that the account combination complies with the configured rules.

For more information, see [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures).

### Check for default or derived dimensions that cause the violation

If you didn't manually enter the segment that caused the error, default or [derived dimensions](/dynamics365/finance/general-ledger/derived-dimensions) might provide the value:

1. Review the main account for fixed dimension values that conflict with the account structure.
1. Check the journal header default dimensions that might be automatically applied.
1. Review the derived dimensions setup against each segment in the ledger account.
1. Update your default dimension setup accordingly.

## Not a valid dimension value in account structure

You receive the following error message:

> \<DimensionValue> isn't a valid dimension value in account structure.

This error message appears if a value in the ledger account combination doesn't meet the constraints that you defined in the assigned [account structure](/dynamics365/finance/general-ledger/configure-account-structures).

### Refresh the form and re-enter the value

If the error appears as a yellow triangle in an account field, or as a yellow or pink information bar at the top of the form, try the following steps first:

1. Clear the ledger account field, and then select the area outside the field to dismiss any error indicators.
1. Close any information bars at the top of the form.
1. Save the form.
1. Close and then reopen the form.
1. Re-enter the account number.

If no error appears after you re-enter the account number, the form now correctly reflects any recent configuration changes. If the error persists, go to the next sections.

### Verify the dimension value exists and is valid

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Select the relevant dimension, and then select **Financial dimension values**.
1. Find the value from the error message, and then verify the following conditions:
   - The value exists and isn't deleted.
   - The **Active from** date isn't set to a date that's later than the transaction date.
   - The **Active to** date isn't set to a date that's earlier than the transaction date.
   - The **Suspended** option isn't set to **Yes**.
   - If [legal entity overrides](/dynamics365/finance/general-ledger/financial-dimensions#legal-entity-overrides) are configured, check whether any of these three settings (**Active from**, **Active to**, or **Suspended**) are overridden for the legal entity where you enter the transaction.
   - The **Blocked for manual entry** option isn't enabled.

### Review the account structure constraints

1. Go to **General ledger** > **Chart of accounts** > **Structures** > **Configure account structures**.
1. Select the relevant account structure, and then select **Edit**.
1. Review the constraint nodes to determine which path applies to the dimension value.
1. Verify that the value is allowed in the constraint node for that segment.

> [!IMPORTANT]
> If the dimension value contains only numeric digits, verify that the range defined in the account structure treats it correctly as a string. For example, a range of `1..2000` doesn't include the value `4`, because `4` is sorted after `2000` in string order. If your values are numeric, prefix smaller values by including zeros (for example, `0004`) to ensure proper string sorting.

### Check advanced rules

1. On the **Configure account structures** page, select **Advanced rules** for the relevant account structure.
1. Check whether any [advanced rules](/dynamics365/finance/general-ledger/tasks/create-assign-advanced-rule-structures) further constrain the valid values. Account structures apply the most restrictive combination of all applicable constraint nodes.
1. Verify that no advanced rule was saved without having a criteria filter. A missing filter would cause the rule to always apply.

### Check for fixed dimensions

[Fixed dimensions](/dynamics365/finance/general-ledger/dimensions-default-values) that you set on a main account override whatever dimension value you enter. They might replace it by using a value that the account structure doesn't allow.

1. Go to **General ledger** > **Chart of accounts** > **Accounts** > **Main accounts**.
1. Select the main account from the transaction.
1. On the **Legal entity overrides** FastTab, check whether a fixed dimension value overwrites the entered value or forces a blank value.

### Check for derived dimensions

[Derived dimensions](/dynamics365/finance/general-ledger/derived-dimensions) might apply a value that you don't expect, based on another value earlier in the combination.

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Review the derived dimension rules for each dimension that's used in the account structure.

### Check interunit dimensions

If interunit dimensions are enabled, the error message might refer to a different main account or dimension value than the one you entered. This situation can occur because of the general ledger interunit balancing configuration.

1. Go to **General ledger** > **Ledger setup** > **Ledger**.
1. Review the interunit accounting setup, and verify that balancing entries use valid dimension values.

### Clear the dimension validation cache

If none of the previous sections identifies a configuration issue, stale validation data might cause the error. The system caches dimension validation results for performance. If the cached data becomes outdated (for example, if you activate an account structure while other processes are running), the system might return incorrect validation results.

To clear the validation cache, use one of the following methods.

#### Use data maintenance

1. Go to **System administration** > **Periodic tasks** > **Data maintenance**.
1. On the **All** tab, find the **Clear all dimension caches** data maintenance action.
1. Run the **Clear all dimension caches** data maintenance action to clear all dimension caches. This process typically finishes within five minutes.

#### Use the dimension cache clearing tools

Go to the following URLs to clear the validation cache:

1. **Clear dimension validation status**: Go to `https://<EnvironmentName>.com/?mi=DimensionClearValidationStatus`.
1. **Clear dimension cache scopes**: If other dimension issues occur, go to `https://<EnvironmentName>.com/?mi=DimensionClearCacheScopes`.

#### Reactivate the account structure

> [!IMPORTANT]
> Use this method only while no active data entry, import, or batch processing is occurring in the system.

1. Go to **General ledger** > **Chart of accounts** > **Structures** > **Configure account structures**.
1. Select the account structure that's referenced in the error message, and then select **Edit**.
1. Make a minor change (for example, add a constraint value that doesn't match any current values).
1. To send the activation to batch processing, select **Activate**.
1. Wait for the batch job to finish. Then, undo the previous change, and select **Activate** again.
1. Wait for the batch job to finish again, and then retry the business process.

If the error no longer occurs after you clear the cache, stale validation data caused the issue. To help prevent this situation in the future, avoid activating account structures while significant system activity (such as batch processing or data entry) is occurring.

## Value isn't allowed due to derived dimension rules

You receive the following error message:

> The \<DimensionName> dimension with value \<Value> isn't allowed due to derived dimension rules. The allowed value should be \<AllowedValue>.

This error occurs if a [derived dimension](/dynamics365/finance/general-ledger/derived-dimensions) rule has the **Prevent changes** option enabled for the segment that caused the error. If you enable this option, the derived dimension automatically populates the segment and prevents manual changes.

To resolve this issue, follow these steps:

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Select each dimension that's used in the account structure.
1. Review the derived dimension rules for each dimension.
1. If you don't want the derived dimension to automatically populate the specified segment, disable the **Prevent changes** option.

## Unable to return DimensionAttributeValue record

You receive the following error message:

> Unable to return DimensionAttributeValue record for \<DimensionName>

This error message means that the system can't find the dimension value. Several conditions can cause this issue.

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
1. Review the access scope, and grant access to the required organizations. To test whether access restrictions cause the issue:
   1. Select **Grant access to all organizations**, and check whether the dimension value appears.
   1. If the dimension value appears, clear the **Grant access to all organizations** checkbox, and then grant access to only the required organizations.

## Financial dimension name contains invalid characters

You receive the following error message:

> The financial dimension name \<DimensionName> contains invalid characters.

[Financial dimension](/dynamics365/finance/general-ledger/financial-dimensions) names must follow specific naming conventions:

- Must start with an underscore or a letter (either lowercase or uppercase)
- Can contain only underscores, letters, or digits after the first character
- Can't contain system field names such as `RecId`

To fix this issue, follow these steps:

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Review the dimension name to make sure that it follows the naming conventions.
1. Rename the dimension, if necessary. Don't use system field names or invalid characters.

## Value doesn't exist for financial dimension

You receive the following error message:

> The value \<Value> doesn't exist for \<DimensionName>.

This error typically means that the dimension value that you entered doesn't exist in the system.

To verify the dimension value, follow these steps:

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. On the **Action Pane**, select **Financial dimension values**.
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

## Rows overlap in an account structure or advanced rule

You receive one of the following error messages:

> The row with \<DimensionName> \<Criteria> overlaps with the row with \<Criteria>.

> The row with \<DimensionName> values \<Values> overlaps with the row with values \<Values>.

An overlap means that two rows allow the same dimension value, so the system can't tell which rule to follow. It doesn't let you activate the account structure until you fix the overlap.

The following list describes common situations that produce this error:

- **The overlap is with a different account structure** When you activate an account structure, the system checks it against every other active account structure on the same ledger, not just the one you're editing. The system always compares against the currently *active* versions of the other account structures, never the drafts. So even if you already fixed the overlap in another account structure, the overlap error still appears until you activate that other account structure.

  *Example:* Account structure A allows main accounts 100–199 and account structure B allows 200–299. To move account 250 into account structure A, you add 250 to account structure A and remove 250 from account structure B. Activating account structure A still fails on 250, because account structure B isn't activated yet and its active version still allows 250.

  *Fix:* Activate one account structure at a time so each change takes effect before you rely on it. Activate account structure B first to remove 250, then activate account structure A to add 250.

- **Two or more criteria in the same account structure have overlapping dimension values.** The system evaluates the rows like branches of a tree, comparing the criteria for each dimension from left to right. Criteria with identical values follow the same branch, and criteria with completely separate values break off into their own branches. An overlap happens when the values only partly overlap because the branch can't cleanly split, causing shared values to belong to multiple branches at once.

  In this structure, the cost center splits the rows into clean branches, so the criteria in both row 1 and row 2 can have `D1` in the Department dimension:

  | Main account | Cost center | Department |
  | ------------ | ----------- | ---------- |
  | 100–399      | C1          | D1         |
  | 100–399      | C2          | D1;D3      |

  ```tree
  100–399
  ├── C1 → D1
  └── C2 → D1;D3
  ```

  In this example, the main accounts are identical and the departments only partly overlap, so account `250` with department `D1` could follow either account structure rule - an overlap conflict:

  | Main account | Department | Cost center |
  | ------------ | ---------- | ----------- |
  | 100–399      | D1         | C2;C3       |
  | 100–399      | D1,D3      | C5          |

  ```tree
  100–399
  ├── D1    → C2;C3
  └── D1,D3 → C5      ← both include D1
  ```

  *Fix:* Remove the overlap in the Department dimension:

  | Main account | Department | Cost center |
  | ------------ | ---------- | ----------- |
  | 100–399      | D1         | C2;C3;C5    |
  | 100–399      | D3         | C5          |

- **Reordering the columns can create an overlap.** Because the system reads each row from left to right, moving a dimension to a different column without adjusting the criteria can create an overlap that wasn't there before. After you reorder, recheck the criteria so each row is still uniquely identified from left to right.

### Identify the overlapping rows

1. Go to **General ledger** > **Chart of accounts** > **Structures** > **Configure account structures**. For an advanced rule, go to **General ledger** > **Chart of accounts** > **Structures** > **Advanced rule structures**.
1. Open the account structure or advanced rule structure that you're configuring.
1. Locate the two rows that use the dimension and the criteria values named in the error message.
1. Change the value ranges or discrete values so that each value appears in only one row.
1. Use explicit, non-overlapping ranges instead of ranges that share endpoints or wildcards (`*`) that cover values already defined in another row.
1. Validate and activate the structure again.

For more information on overlapping criteria, see [Overlapping criteria in account structures](/dynamics365/finance/general-ledger/configure-account-structures#overlapping-criteria).

## Related content

- ["The account type for main account... is not valid" error when posting in General ledger](troubleshoot-posting-errors.md)
- [Can't post a journal due to imbalance](posting-fail-imbalance.md)
- [Plan your chart of accounts](/dynamics365/finance/general-ledger/plan-chart-of-accounts)
