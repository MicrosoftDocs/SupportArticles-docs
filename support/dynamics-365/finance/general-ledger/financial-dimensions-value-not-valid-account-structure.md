---
# required metadata

title: "Error when posting: financial dimension value isn't valid or isn't allowed in combination"
description: Troubleshooting steps for resolving errors where a financial dimension value isn't valid or isn't allowed in combination within an account structure in Microsoft Dynamics 365 Finance.
author: ethanrimes
ms.date: 03/03/2026

# optional metadata

ms.search.form: DimensionDetails, DimensionValueDetails, LedgerChartOfAccountConfigure
audience: Application User
ms.reviewer: twheeloc
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions
ms.search.region: Global
ms.author: ethanrimes
ms.search.validFrom: 2016-05-18
ms.dyn365.ops.version: AX 7.0.0
---

# Error when posting: financial dimension value isn't valid or isn't allowed in combination

This article provides troubleshooting steps for resolving errors in Microsoft Dynamics 365 Finance where a financial dimension value is reported as invalid or not allowed in combination with other dimension values.

## Symptoms

When you post a document or enter a ledger account, you receive one of the following errors:

> Dimension_[Name] Value_[Value] is not an allowed value in combination with the following dimension values that are valid: [values]

> [Value] is not a valid dimension value in account structure [Structure]

> You must select a value in the [Dimension name] field in combination with the following dimension values that are valid: [values]

The user is certain the value has been used before or is set up correctly.

## Cause

This error is most commonly caused by a user configuration issue in one of the following areas:

- The account structure or an advanced rule is configured to disallow the value — either intentionally or accidentally.
- The dimension value is inactive, suspended, expired, or blocked for manual entry.
- Fixed dimensions on the main account are overwriting the entered value with a different value, or with a blank value, that the account structure doesn't allow.
- Derived dimensions are forcing an unexpected value from another segment.
- Organization model relations linked to the account structure are misconfigured.

Less commonly, the error is caused by a stale validation result in the dimension framework's performance cache. This can occur when an account structure is activated while users are actively entering data or batch processes are running.

## Resolution

### Before you begin

If you see a yellow warning triangle in a segmented entry control field, or a yellow or pink information bar at the top of the form, first try the following steps:

1. Clear the ledger account field and tab or click out of it so no error indicator remains.
2. Close any information bars at the top of the form.
3. Save the document or form.
4. Close and re-open the document.
5. Re-enter the account number and check whether the error returns.

If the error doesn't return, the configuration was recently updated and the form was displaying a stale validation result. No further action is needed.

If the error persists, continue to the following sections.

### Step 1: Check the dimension value properties

Navigate to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**, select the affected dimension, and then select **Dimension values**. Verify the following for the specific value shown in the error:

- **The value exists.** Confirm that the value is still listed. If it was deleted, it must be recreated or the transaction must use a different value.
- **Active from date.** If **Active from** is set to a future date, the value can't be used until that date arrives.
- **Active to date.** If **Active to** is set to a date in the past, the value has expired and can no longer be used.
- **Suspended.** If **Suspended** is set to **Yes**, the value is blocked from use.
- **Blocked for manual entry.** If this setting is enabled, the value can't be entered manually on documents.

Also check whether any of these settings are overridden at a legal entity level. Select the dimension value, and then review the **Legal entity overrides** section. A value may be active globally but suspended for a specific company.

### Step 2: Check the account structure configuration

Navigate to **General ledger** > **Chart of accounts** > **Structures** > **Configure account structures**. Select the account structure that the error references and review the constraint configuration for the segment that contains the failing value:

- **Constraint range.** Confirm that the value falls within the allowed range for the segment. If the range uses string-based comparison and the values are numeric, small numbers can sort unexpectedly. For example, a range of `1..2000` doesn't include `4` when values are sorted as strings, because `4` sorts after `2000` alphabetically. In this case, values must be zero-padded (for example, `0004`) to sort correctly, or the range must be adjusted.
- **Wildcard and specific values.** Confirm that no explicit exclusion or overly restrictive wildcard pattern blocks the value.
- **Advanced rules.** Select **Advanced rules** in the account structure to check whether any rules add further constraints. Pay particular attention to rules that have no **Where** clause — these rules always apply to every transaction line, not just when specific criteria are met. Confirm that the constrained values in every applicable advanced rule allow the value that's failing.

### Step 3: Check dimension defaulting setup

Dimension values can be overwritten at posting time by setup elsewhere in the system. Check the following:

- **Fixed dimensions on the main account.** Go to **General ledger** > **Chart of accounts** > **Accounts** > **Main accounts**, select the main account used in the failing transaction, and select **Legal entity overrides**. If a dimension is set to a **Fixed** value, that value is always applied, regardless of what the user entered. If a fixed value is set to **Blank**, the dimension is cleared on posting, which can cause a "must select a value" error when the account structure requires the segment.
- **Derived dimensions.** If derived dimensions are configured for any segment in the transaction, an unexpected derived value may replace what was entered. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**, select the dimension that's the source of the derivation, and select **Derived dimensions** to review the configured values.
- **Organization model relations.** If dimension values are linked to an organization hierarchy, confirm that the values are valid within the organization hierarchy configuration that's applied to the account structure.

### Step 4: Clear stale validation cache

If the configuration appears correct but the error persists, the system may be returning a cached validation result that was stored before a recent configuration change. The system caches dimension validation results to improve performance. If an account structure was activated while users were actively entering data, a stale result may have been reinserted after the cache was cleared.

### Option 1: Use the dimension cache menu items (available since version 10.0.14)

In the application URL bar, navigate to each of the following addresses and let the action complete before proceeding to the next:

1. `/?mi=DimensionClearValidationStatus` — Clears stored validation results. This is the most direct fix for this symptom.
2. `/?mi=DimensionClearCacheScopes` — Clears broader dimension caches. Use this if Option 1 doesn't resolve the issue.

After completing these actions, re-attempt the business process that produced the error.

### Option 2: Create and delete a temporary account structure

If the menu items aren't available in your version, use this approach instead:

1. Go to **General ledger** > **Chart of accounts** > **Structures** > **Configure account structures**.
2. Select **New** and create an account structure with a temporary name (for example, **TEMPDELME**).
3. Select **Create**.
4. Select **Delete**, and then confirm the deletion.

This process clears a large portion of dimension caches without activating an account structure.

If the error persists after clearing caches, the issue is caused by configuration rather than stale data. Continue reviewing the steps in the previous sections.
