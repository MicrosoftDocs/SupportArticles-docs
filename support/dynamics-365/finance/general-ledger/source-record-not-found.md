---
title: Resolve Financial Dimension Source Record Errors in D365 Finance
description: Source record not found errors in Dynamics 365 Finance financial dimensions? Learn how to fix missing records, legal entity mismatches, XDS policies, and hidden characters that block dimension values.
ms.date: 04/02/2026
ms.reviewer: ethankallett, anaborges, jowalker, setharvila, moaamer, nedavis, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
---

# Source record not found for a financial dimension value

## Summary

This article helps you resolve errors that occur if Microsoft Dynamics 365 Finance can't find the source record for a financial dimension value. These errors can appear across areas that use financial dimensions, including vendors, customers, bank accounts, projects, items, fixed assets, and main accounts. Common causes include missing or deleted master data records, legal entity mismatches, Extensible Data Security (XDS) policies blocking access, and hidden or special characters in dimension values.

## Symptoms

When you work with financial dimensions, you receive one of the following error messages:

> No record with the value \<Value> exists in table \<Table> in data area \<Company>; this cannot be used as a dimension value.

> No record with the value \<Value> exists in table \<Table>; this cannot be used as a dimension value.

> Unable to return DimensionAttributeValue record for Dimension \<DimensionName> with value \<Value> in table \<Table> through view \<View> as no record exists, or you do not have access to it. Contact your system administrator for assistance.

> Unable to return DimensionAttributeValue record for Dimension \<DimensionName> with value \<Value> as no record exists in table \<Table> through view \<View>.

These errors can occur during operations such as transferring lines to a journal, posting transactions, or any process that assigns financial dimension values.

## A customization or integration references a record that doesn't exist

A customization or integration tries to assign a financial dimension value by using a record that doesn't exist in the system, that exists in a different legal entity than expected, or that references the wrong record type.

This problem can occur in any of several scenarios:

- **The record doesn't exist.** The process tries to use a value (such as a vendor or customer account number) as a dimension. However, the value either wasn't created in the corresponding master data table or it was deleted.
- **The record exists in a different legal entity.** The process looks for the record in one company, but the record exists only in a different company. For example, a vendor account exists in company 001, but the system searches in company 002.
- **The wrong record type is used.** The process looks up a value from one record type (such as a vendor), but tries to use it as a different dimension type (such as a customer dimension).
- **The record was deleted during an in-progress operation.** In rare cases, a record might be deleted while another part of the same operation tries to use it as a dimension value.

### Solution

Investigate the customization or integration that triggers the error:

1. Review any recent customizations, integrations, or extensions that interact with financial dimensions in the area where the error occurs.
1. Verify that the master data record that's referenced in the error message (the value and table) exists in the correct legal entity.
1. If a customization is the cause, work with your development team to correct it. For guidance, see [Best practices for financial dimension customizations](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization-errors).
1. If no customization is involved, open a support request, and include the full error message details.

## The current legal entity doesn't contain the record

The source record exists but belongs to a different legal entity (company) than the one where the process runs. Company-specific dimension values are visible only within their associated legal entity.

### Solution

1. Check the **data area** value in the error message to verify which company the system searched.
1. Switch to the legal entity where the record exists, and then retry the operation.
1. If the record should be available across companies, review whether the source entity and its dimension are configured as shared. For more information, see [Legal entity overrides](/dynamics365/finance/general-ledger/financial-dimensions#legal-entity-overrides).

## Extensible Data Security (XDS) policies block access

[Extensible Data Security (XDS)](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies) policies are enabled in the table or view that stores the financial dimension source records. XDS policies restrict which records a user can see, and these restrictions can prevent the financial dimension framework from finding the source record.

> [!IMPORTANT]
> XDS security policies aren't compatible with financial dimensions. Many system processes run under the current user's security context instead of a system administrator context. This behavior means that XDS restrictions can block dimension operations even if the underlying data exists.

In version 10.0.41 and later versions, the error message might indicate that XDS policies prevent resolution of the dimension value.

### Solution

1. Check whether XDS security policies are enabled on the table that's mentioned in the error message (such as `VendTable` or `CustTable`) or its corresponding dimension view (such as `DimAttributeVendTable` or `DimAttributeCustTable`).
1. If you find XDS policies on these tables or views, remove or adjust them so that the financial dimension framework can access the required records. For more information, see [Bypassing XDS policy](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies#bypassing-xds-policy).
1. After you remove the XDS policies, retry the operation that produced the error.

## Hidden or special characters in the dimension value

The source record's key field (such as a customer account number or vendor account number) contains hidden or invisible characters that prevent the financial dimension framework from finding an exact match. These characters might not be visible in the user interface or in standard database views, but they cause the lookup to fail because the values don't match exactly.

Common examples include:

- Invisible Unicode characters embedded in the value.
- A "hard space" character that looks identical to a normal space but is a different character.
- Leading or trailing invisible characters that aren't visible when you view the record.

In version 10.0.42 and later versions, the error message might indicate that a partial match was found but that the values don't match exactly because of string length or content differences.

### Solution

1. Go to the source record that's mentioned in the error message (for example, the customer or vendor record).
1. Select the key field (such as the account number), temporarily change the contents to a different value, and then save. Revert the contents to the intended value, and then save again. This process removes any hidden characters. For guidance to rename dimension values, see [Renaming financial dimensions](/dynamics365/finance/general-ledger/financial-dimensions#renaming-financial-dimensions).
1. After you correct the value, retry the operation that produced the error.
1. If your data comes from an external integration, review the integration to make sure that it validates and cleans data before it imports the data into Dynamics 365 Finance.

## Related content

- [Financial dimension activation errors](dimension-activation-errors.md)
- [Define financial dimensions](/dynamics365/finance/general-ledger/tasks/define-financial-dimensions)
- [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities)
