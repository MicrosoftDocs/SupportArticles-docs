---
title: Align missing fields error in Sales agent
description: Resolves an error that occurs due to field mismatching between Microsoft Dynamics 365 and Sales agent.
ms.date: 05/14/2026
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
ms.reviewer: shjais, v-shaywood
---
# "Align missing fields" error in Sales agent

This article helps you troubleshoot and resolve the "Align missing fields" error in Sales agent.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales agent in Outlook        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365        |
|**Users**     | Users who get a field mismatch error  |

## Symptoms

When a user tries to use Sales agent, the following error message occurs. It indicates a field mismatch between CRM and Sales agent.

> Align missing fields

## Cause

A field of a record exists in Sales agent but not in CRM. The field is removed from the CRM after an administrator has configured fields of the record from the [Sales agent administrator settings](/microsoft-sales-copilot/customize-forms-and-fields).

## Resolution

To solve this issue, check with the record owner to see if the field is removed by mistake. If the field is removed by mistake, ask the record owner to add the field back to the record in CRM. If the field is removed intentionally, [remove the field from the record in Sales agent](/microsoft-sales-copilot/customize-forms-and-fields#remove-fields).

## More information

If your issue is still unresolved, go to the [Sales agent - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
