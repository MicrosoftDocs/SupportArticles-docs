---
title: Fix Contact Already Exists error in CRM Records
description: Learn how to resolve the "This contact already exists" error that's caused by a duplicate detection rule when you create a CRM record from the Sales app.
ms.date: 05/18/2026
ms.reviewer: shjais, v-shaywood
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# Record creation error because of duplicate detection rules in CRM

## Summary

This article helps you fix the "This contact already exists" error. This error occurs when you try to [create a new record in your CRM](/microsoft-sales-copilot/create-new-record) from the Sales app, and a [duplicate detection rule](/power-platform/admin/set-up-duplicate-detection-rules-keep-data-clean) blocks the record from being created.

The following areas are affected by this issue.

| Requirement type | Description                                             |
| ---------------- | ------------------------------------------------------- |
| **Client app**   | Sales app in Outlook                                    |
| **Platform**     | Web and desktop clients                                 |
| **OS**           | Windows and Mac                                         |
| **Deployment**   | User managed and admin managed                          |
| **CRM**          | Dynamics 365 and Salesforce                             |
| **Users**        | Users who try to create a CRM record from the Sales app |

## Symptoms

When a user tries to [create a new record in your CRM from the Sales app](/microsoft-sales-copilot/create-new-record), the following error message appears. The message indicates that the record creation failed because of a [duplicate detection rule in the CRM](/power-platform/admin/set-up-duplicate-detection-rules-keep-data-clean).

> This contact already exists. To create a duplicate contact, try adding it in Salesforce.

:::image type="content" source="media/duplicate-record-error/duplicate-record-error.png" alt-text="Screenshot that shows the duplicate record error that occurs when a user tries to create a CRM record.":::

## Cause

A duplicate detection rule in the CRM prevents specific fields from having duplicate values across multiple records. When a user tries to create a record from the Sales app that contains a duplicate field, the rule blocks the record from being created.

For example, a duplicate detection rule might prevent the creation of a record that has the same email address as an existing record. In this case, record creation fails if the new record's email address matches an existing address.

## Solution

To fix the error, use either of the following methods:

- Create the record again by using a different value for the field that caused the error. For example, if the error occurs because the new record's email address matches an existing record's email address, re-create the record by using a different email address.
- Ask your administrator to change the duplicate detection rule in the CRM for the field that caused the error to allow the field to have duplicate values.

For information about duplicate detection rules in the CRM, see:

- Dynamics 365: [Set up duplicate detection rules to keep your data clean](/power-platform/admin/set-up-duplicate-detection-rules-keep-data-clean)
- Salesforce: [Duplicate Rules](https://help.salesforce.com/s/articleView?id=sf.duplicate_rules_map_of_reference.htm&type=5)

## Get help from the community

If your issue is still unresolved, go to the [Sales in Microsoft 365 Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to connect with other users and Microsoft experts.

## Related content

- ["Required fields are missing" error when creating a contact or record from Sales app in Outlook](required-fields-missing.md)
- [Invalid CRM Record ID error when saving notes from Sales agent](invalid-crm-record-id-error.md)
- [Can't update records because of missing record access in Salesforce CRM](missing-record-update-edit-access.md)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
