---
title: Contact already exists error when creating a CRM record
description: Resolves an error that occurs due to a duplicate detection rule in CRM when a user tries to create a record from Copilot for Sales.
ms.date: 04/30/2024
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# Record creation error due to duplicate detection rules in CRM

This article provides a resolution for an error message that occurs when a user tries to create a record from Microsoft Copilot for Sales.

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce       |
|**Users**     | Users who try to create a CRM record from Copilot for Sales   |

## Symptoms

When a user tries to [create a new record in your CRM from Copilot for Sales](/microsoft-sales-copilot/create-new-record), the following error is displayed. It indicates that the record creation failed due to a [duplicate detection rule in CRM](/power-platform/admin/set-up-duplicate-detection-rules-keep-data-clean).

> This contact already exists. To create a duplicate contact, try adding it in Salesforce.

:::image type="content" source="media/duplicate-record-error/duplicate-record-error.png" alt-text="Screenshot that shows the duplicate record error that occurs when a user tries to create a CRM record.":::

## Cause

A duplicate detection rule in CRM is configured to prevent specific fields from having duplicate values across multiple records. When a user tries to create a record that contains a duplicate field from Copilot for Sales, the duplicate detection rule in CRM prevents the record from being created.

For example, if a duplicate detection rule is configured to prevent the creation of a record with the same email address as an existing record, the record creation fails if the new record's email address matches the existing record's email address.

## Resolution

To resolve the error, use either of the following methods:

- Create the record again with a different value for the field that caused the error. For example, if an error occurs because the new record's email address matches an existing record's email address, re-create the record with a different email address.
- Ask your administrator to modify the duplicate detection rule in CRM to allow duplicate values for the field that caused the error.

For information about duplicate detection rules in CRM, see:

- Dynamics 365: [Set up duplicate detection rules to keep your data clean](/power-platform/admin/set-up-duplicate-detection-rules-keep-data-clean)
- Salesforce: [Duplicate Rules](https://help.salesforce.com/s/articleView?id=sf.duplicate_rules_map_of_reference.htm&type=5)

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
