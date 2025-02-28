---
title: Can't update records because of missing record access in Salesforce CRM
description: Resolves an error that occurs when users can't update CRM records in Microsoft Copilot for Sales because of missing record access in Salesforce CRM.
ms.date: 02/05/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:CRM Permissions and Configurations\CRM Permissions
---
# Can't update records because of missing record access in Salesforce CRM

This article helps you troubleshoot and resolve issues when users can't update CRM records in Microsoft Copilot for Sales because of missing record access in Salesforce CRM.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to update a CRM record from Copilot for Sales |

## Symptoms

When a user tries to update a CRM record from the [Copilot for Sales add-in for Outlook](/microsoft-sales-copilot/open-app#access-copilot-for-sales-in-outlook), the following error message is displayed:

> To update Salesforce, ask for edit access for this record.

:::image type="content" source="media/missing-record-update-edit-access/update-salesforce-ask-edit-access-record.png" alt-text="Error about unable to update records in Salesforce.":::

## Cause

The user doesn't have edit access to the record in Salesforce.

When a user tries to edit a record, Copilot for Sales checks if the user has edit access to the object and record in Salesforce. If the user has edit access to the object but not to the record, the error message is displayed.

## Resolution

A Salesforce administrator must provide edit access to the record in Salesforce by [manually sharing the record with the user](https://help.salesforce.com/s/articleView?id=sf.granting_access_to_records.htm&type=5).

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
