---
title: Align missing fields error
description: Resolves an error that occurs due to field mismatching between Dynamics 365 and Copilot for Sales.
ms.date: 01/12/2024
ms.topic: article
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
ms.custom:
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:12/22/2023
  - ai-gen-desc
---

# "Align missing fields" error in Copilot for Sales

This article helps you troubleshoot and resolve the "Align missing fields" error in Copilot for Sales.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshot in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365        |
|**Users**     | Users who get a field mismatch error  |

## Symptoms

When users try to use Copilot for Sales, the following error message is displayed indicating a field mismatch between CRM and Copilot for Sales:

> Align missing fields

Due to this error, users are unable to use Copilot for Sales.

:::image type="content" source="media/align-missing-fields-error/align-missing-fields-error.png" alt-text="Field mismatch error.":::

## Cause

A field in a record exists in Copilot for Sales but not in CRM. The field is removed from the CRM after an administator has configured fields of the record from admin settings in Copilot for Sales.

## Resolution

Check with the record owner to see if the field is removed by mistake. If the field is removed by mistake, ask the record owner to add the field back to the record in CRM. If the field is removed intentionally, [remove the field from the record in Copilot for Sales](customize-forms-and-fields.md#remove-fields).

## More information

Visit the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.