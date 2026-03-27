---
# required metadata
title: Troubleshoot "dimension value record not found" errors when using financial dimensions
description: Describes resolutions for errors that occur when a financial dimension value can't be created because the underlying record doesn't exist in Dynamics 365 Finance.
author: ethanrimes
ms.date: 03/12/2026
---

# A financial dimension value can't be created because the source record doesn't exist

This article helps you resolve errors that occur when the system can't find the source record for a financial dimension value in Microsoft Dynamics 365 Finance. This error can occur across many areas that use financial dimensions, including vendors, customers, bank accounts, projects, items, fixed assets, and main accounts.

## Symptoms

You receive one of the following error messages when working with financial dimensions:

> No record with the value *{value}* exists in table *{table}* in data area *{company}*; this cannot be used as a dimension value.

> No record with the value *{value}* exists in table *{table}*; this cannot be used as a dimension value.

> Unable to return DimensionAttributeValue record for Dimension *{dimension name}* with value *{value}* in table *{table}* through view *{view}* as no record exists, or you do not have access to it. Contact your system administrator for assistance.

> Unable to return DimensionAttributeValue record for Dimension *{dimension name}* with value *{value}* as no record exists in table *{table}* through view *{view}*.

For example, you might see an error like:

> Unable to return DimensionAttributeValue record for Dimension MyCustomers with value Cust001 in table CustTable through view DimAttributeCustTable as no record exists, or you do not have access to it. Contact your system administrator for assistance.

These errors can occur during various operations such as transferring lines to a journal, posting transactions, or any process that assigns financial dimension values.

## Cause 1: A customization or integration is referencing a record that doesn't exist

A customization or integration is attempting to assign a financial dimension value using a record that either doesn't exist in the system, exists in a different legal entity than expected, or is referencing the wrong type of record.

This can happen in several ways:

- **The record doesn't exist.** The process is trying to use a value (for example, a vendor or customer account number) as a dimension, but that value hasn't been created yet in the corresponding master data table, or it has been deleted.
- **The record exists in a different legal entity.** The process is looking for the record in one company but the record only exists in a different company. For example, a vendor account exists in company **001** but the system is searching in company **002**.
- **The wrong record type is being used.** The process is looking up a value from one type of record (for example, a vendor) but trying to use it as a different type of dimension (for example, a customer dimension).
- **The record was deleted during an in-progress operation.** In rare cases, a record may be in the process of being deleted while another part of the same operation is attempting to use it as a dimension value.

### Resolution

This issue requires investigation into the customization or integration that is triggering the error. Follow these steps:

1. Review any recent customizations, integrations, or extensions that interact with financial dimensions in the area where the error occurs.
2. Verify that the master data record referenced in the error message (the value and table mentioned) actually exists in the correct legal entity.
3. If a customization is the cause, work with your development team to correct it. For guidance, see [Best practices for financial dimension customizations](/dynamics365/fin-ops-core/dev-itpro/financial/financial-dimension-customization-errors).
4. If no customization is involved, open a support request with Microsoft and include the full error message details.

## Cause 2: The current legal entity doesn't contain the record

The source record exists but belongs to a different legal entity (company) than the one the process is running in. Company-specific dimension values are only visible within their associated legal entity.

### Resolution

1. Check the **data area** value in the error message to confirm which company the system searched.
2. Switch to the legal entity where the record exists and retry the operation.
3. If the record should be available across companies, review whether the source entity and its dimension are configured as shared. For more information, see [Legal entity overrides](/dynamics365/finance/general-ledger/financial-dimensions#legal-entity-overrides).

## Cause 3: Extensible Data Security (XDS) policies are blocking access

[Extensible Data Security (XDS)](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies) policies are enabled on the table or view that stores the financial dimension source records. XDS security policies restrict which records a user can see, and these restrictions can prevent the financial dimension framework from finding the source record it needs.

> [!IMPORTANT]
> XDS security policies are not compatible with financial dimensions. Many system processes run under the current user's security context rather than a system administrator context, which means XDS restrictions can block dimension operations even when the underlying data exists.

On version 10.0.41 and later, the error message may specifically indicate that XDS policies are preventing resolution of the dimension value.

### Resolution

1. Check whether XDS security policies are enabled on the table mentioned in the error message (for example, **VendTable**, **CustTable**) or its corresponding dimension view (for example, **DimAttributeVendTable**, **DimAttributeCustTable**).
2. If XDS policies are found on these tables or views, remove or adjust them so that the financial dimension framework can access the required records. For more information on bypassing XDS policies, see [Extensible data security policies](/dynamics365/fin-ops-core/dev-itpro/sysadmin/extensible-data-security-policies#bypassing-xds-policy).
3. After removing the XDS policies, retry the operation that produced the error.

## Cause 4: Hidden or special characters in the dimension value

The source record's key field (for example, a customer account number or vendor account number) contains hidden or invisible characters that prevent the financial dimension framework from finding an exact match. These characters may not be visible in the user interface or in standard database views, but they cause the lookup to fail because the values don't match exactly.

Common examples include:

- Invisible Unicode characters embedded in the value.
- A "hard space" character (entered by pressing ALT+0160 on the numeric keypad) that looks identical to a normal space but is treated as a different character.
- Leading or trailing invisible characters that aren't visible when viewing the record.

On version 10.0.42 and later, the error message may specifically indicate that a partial match was found but the values don't match exactly due to string length or content differences.

### Resolution

1. Navigate to the source record mentioned in the error message (for example, open the customer or vendor record).
2. Select the key field (such as the account number) and temporarily change it to a different value, then save. Change it back to the intended value and save again. This removes any hidden characters. For guidance on renaming dimension values, see [Renaming financial dimensions](/dynamics365/finance/general-ledger/financial-dimensions#renaming-financial-dimensions).
3. After correcting the value, retry the operation that produced the error.
4. If your data comes from an external integration, review the integration to make sure data is validated and cleaned before it's imported into Dynamics 365 Finance to prevent this issue from recurring.
