---
title: Fix financial tags missing or not populated in Dynamics 365 Finance
description: Financial tags missing in Dynamics 365 Finance journals, postings, or imports? Troubleshoot caching, Feature management, and data entity mappings. Fix it now.
ms.date: 04/14/2026
ms.reviewer: ethankallett, anaborges, jowalker, setharvila, moaamer, nedavis, twheeloc, shgustaf, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
---

# Financial tags are missing or not populated on journals, postings, or imports

## Summary

This article provides troubleshooting steps for issues where [financial tags](/dynamics365/finance/general-ledger/financial-tag) are missing, empty, or show incorrect values in Microsoft Dynamics 365 Finance. Financial tags might not appear on journal forms, might be empty after a [data management import](/dynamics365/fin-ops-core/dev-itpro/data-entities/data-entities-data-packages#import), or might be missing from voucher transactions after posting. These problems can result from browser or server caching, the [Feature management](/dynamics365/fin-ops-core/fin-ops/get-started/feature-management/feature-management-overview) configuration, or data entity field mappings.

## Symptoms

You experience one or more of the following symptoms:

- Financial tag columns are missing from journal entry forms like general journals, invoice journals, or project expense journals.
- Financial tags are empty after you import a general journal through the **Data management** workspace, even though no error messages appear during the import.
- Financial tag fields are missing from data management entities like the project expense journal line data entity or the hour journal data entity.
- Financial tag values that you previously configured disappear from journal views.
- A financial tag shows values that aren't on the configured tag list.

## Verify that financial tags are configured and activated

You must configure and activate financial tags in each legal entity where you want to use them. If you don't activate the tags, they don't appear in journal forms or during transaction entry. For more information about initial setup, see [Financial tags](/dynamics365/finance/general-ledger/financial-tag).

To verify the configuration, follow these steps:

1. Go to **General ledger** > **Ledger setup** > **General ledger parameters**, and then select the **Financial tags** tab.
1. Verify that a **Financial tag segment delimiter** is defined. You must set the delimiter before you can use financial tags.
1. Go to **General ledger** > **Chart of accounts** > **Financial tags** > **Financial tags**.
1. Verify that the tags you expect are listed and that the **Status** column shows **Active** for each tag.
1. If a tag shows **Inactive**, select the tag, and then select **Activate**.
1. Switch to each legal entity where you expect financial tags, and repeat these steps. Financial tag configurations are legal entity specific.

## Clear cached financial tag configuration

Financial tag columns might disappear from journal forms because of stale cached values for the financial tag configuration. This issue can affect multiple users in an environment and can occur after an environment update or database refresh.

To clear the cache, follow these steps:

1. Ask all affected users to clear their browser cache, and then sign in again.
1. If the issue persists, go to **General ledger** > **Chart of accounts** > **Financial tags** > **Financial tags**.
1. Temporarily rename one of the existing financial tags to a different name. This action triggers an update to the financial tag configuration and clears the cached values.
1. Open a journal entry form and verify that the financial tag columns are visible.
1. Rename the financial tag back to its original name.
1. Verify that the financial tags remain visible after you restore the original name.

If the issue persists after you clear the cache, verify that the correct financial tag features are enabled in [Feature management](/dynamics365/fin-ops-core/fin-ops/get-started/feature-management/feature-management-overview). For details on configuring your **Feature management** settings, see [Check Feature management settings](#check-feature-management-settings).

## Check Feature management settings

If you recently migrated, restored, or refreshed an environment, the [Feature management](/dynamics365/fin-ops-core/fin-ops/get-started/feature-management/feature-management-overview) settings might differ between environments. For example, a sandbox environment might use the newer financial tags entry experience, while the production environment still uses the legacy experience.

To verify the Feature management settings, follow these steps:

1. Verify that both environments are on the same Dynamics 365 Finance application version.
1. Go to **System administration** > **Workspaces** > **Feature management**.
1. Search for features related to financial tags.
1. Verify that the same financial tag features are enabled in both the source and target environments.

## Verify data entity field mappings and redeploy financial tag table triggers

If financial tags are empty after you import a general journal through the **Data management** workspace, verify the data entity mapping and import configuration.

To verify the data entity mapping and import configuration, follow these steps:

1. Go to **System administration** > **Workspaces** > **Data management**.
1. Open the import project that you used for the general journal import.
1. Select **View map** to review the field mappings between the source file and the data entity.
1. Verify that the financial tag columns in your source file are correctly mapped to the corresponding financial tag fields in the data entity. Financial tag fields in the data entity are named **Financial tag**, **Financial tag 2**, **Financial tag 3**, and so on, matching the order in which the tags are configured.
1. Confirm that the source data file contains the correct financial tag values in the mapped columns.
1. Reimport the journal and verify that the financial tags are populated.

If the mapping is correct but the tags are still empty after the import, the issue might be related to an environment update. In this case, follow these steps:

1. Go to **System administration** > **Periodic tasks** > **Data maintenance**.
1. Select the **Misc** tab.
1. Search for **Deploy financial tag table triggers**, and then select **Run now**.
1. After the action completes, reimport the journal and verify that the financial tags are populated.

## Enforce validation by using Fixed list or Fixed custom list value types

If a financial tag shows values that aren't in the configured list, this behavior comes from the [value type](/dynamics365/finance/general-ledger/financial-tag#creating-financial-tags) that's assigned to the tag.

By design, financial tags that use the **Custom list** or **List** value type [accept any entered value without validation](/dynamics365/finance/general-ledger/financial-tag-financial-dimension) against the defined list. Users can enter values that don't exist in the predefined list without receiving an error or warning.

To enforce validation, follow these steps:

1. Verify that your environment runs Dynamics 365 Finance version 10.0.44 or later.
1. Go to **General ledger** > **Chart of accounts** > **Financial tags** > **Financial tags**.
1. Select the financial tag that needs validation.
1. Change the **Value type** field to one of the following options:
   - **Fixed list**: for system table-backed lists with validation.
   - **Fixed custom list**: for custom lists with validation.
1. Select **Activate** to activate the tag with the new value type.

After you make this change, only values defined in the list are accepted during transaction entry.

## Check data entity support for financial tags

If financial tag fields are missing from specific data management entities, such as the project expense journal line data entity or the hour journal data entity, the data entity might not yet support financial tags. Each new release of Dynamics 365 Finance adds financial tag support to more journals and data entities. For the current list of supported journals, see [Financial tags](/dynamics365/finance/general-ledger/financial-tag).

To check if a data entity supports financial tags, follow these steps:

1. Go to **System administration** > **Workspaces** > **Data management**.
1. Select **Data entities**.
1. Search for the data entity that's missing financial tag fields.
1. Select the data entity, and then select **Entity structure** to view the available fields.
1. If the financial tag fields aren't listed, the data entity doesn't currently support financial tags. Check whether a newer version of Dynamics 365 Finance adds support for financial tags on that data entity by reviewing [What's new or changed in Dynamics 365 Finance](/dynamics365/finance/get-started/whats-new-home-page).
1. If you need to import financial tags for a journal type where the data entity doesn't support them, consider using the general journal data entity as an alternative import method.

## Related content

- [Financial tag rule reference](/dynamics365/finance/general-ledger/financial-tag-rule-reference)
- [Financial dimension value is missing or unavailable](cant-find-dimension-value.md)
- [Common dimension-related errors](common-dimension-related-errors.md)
