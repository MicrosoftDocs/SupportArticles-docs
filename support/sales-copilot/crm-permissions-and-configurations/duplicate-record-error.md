---
title: Record creation error due to duplicate detection rules in CRM
description: Resolves the error that occurs due to duplicate detection rules in CRM when a user tries to create a record from within Copilot for Sales.
ms.date: 02/23/2024
author: sbmjais
ms.author: shjais
---

# Record creation error due to duplicate detection rules in CRM

This article helps you troubleshoot and resolve the error that occurs due to duplicate detection rules in CRM when a user tries to create a record from within Copilot for Sales.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce       |
|**Users**     | Users who try to create a CRM record from within Copilot for Sales   |

## Symptoms

When a user tries to create a CRM record from within Copilot for Sales, the following error is displayed. It indicates that the record creation failed due to duplicate detection rules in CRM.

:::image type="content" source="media/duplicate-record-error/duplicate-record-error.png" alt-text="Screenshot showing duplicate record error.":::

## Cause

The duplicate detection rules in CRM is configured to prevent specific fields from having duplicate values acorss multiple records. When a user tries to create a record from within Copilot for Sales, the duplicate detection rules in CRM prevents the creation of the record. For example, if the duplicate detection rules is configured to prevent the creation of a record with the same email address as an existing record, the record creation fails if the email address of the new record matches the email address of an existing record.

## Resolution

To resolve the error, do either of the following:

- Create the record again with a different value for the field that caused the error. For example, if the error occurred because the email address of the new record matches the email address of an existing record, create the record again with a different email address.

- Ask your administator to modify the duplicate detection rules in CRM to allow duplicate values for the field that caused the error.

For information about duplicate detection rules in CRM, see the following articles:
- Dynamics 365: [Set up duplicate detection rules to keep your data clean](/power-platform/admin/set-up-duplicate-detection-rules-keep-data-clean)
- Salesforce: [Duplicate Rules](https://help.salesforce.com/s/articleView?id=sf.duplicate_rules_map_of_reference.htm&type=5)

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.