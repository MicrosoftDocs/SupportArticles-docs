---
title: Unable to update records because of missing record access in Salesforce CRM
description: Troubleshoot and resolve error issues when users are unable to update CRM records in Sales Copilot because of missing record access in Salesforce CRM.
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Unable to update records because of missing record access in Salesforce CRM

This article helps you troubleshoot and resolve issues when users are unable to update CRM records in Sales Copilot because of missing record access in Salesforce CRM.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to update a CRM record from Sales Copilot |

## Symptom

When trying to update a CRM record from the Sales Copilot add-in for Outlook, the following error message is displayed: `To update Salesforce, ask for edit access for this record.`

:::image type="content" source="media/tsg-update-record.png" alt-text="Error about unable to update records in Salesforce.":::

## Cause

User doesn't have edit access to a record in Salesforce.

When a user tries to edit a record, Sales Copilot checks if the user has edit access to the object and record in Salesforce. If the user has edit access to the object but not to the record, the error message is displayed.

## Solution

Salesforce administrator must provide edit access to the record in Salesforce by [manually sharing the record with the user](https://help.salesforce.com/s/articleView?id=sf.granting_access_to_records.htm&type=5).

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.