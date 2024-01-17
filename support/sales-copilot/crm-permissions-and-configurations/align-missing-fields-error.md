---
title: Align missing fields error in Copilot for Sales
description: Resolves an error that occurs due to field mismatching between Microsoft Dynamics 365 and Copilot for Sales.
ms.date: 01/16/2024
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

This article helps you troubleshoot and resolve the "Align missing fields" error in Microsoft Copilot for Sales.

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

When a user tries to use Copilot for Sales, the following error message occurs. It indicates a field mismatch between CRM and Copilot for Sales.

> Align missing fields

:::image type="content" source="media/align-missing-fields-error/align-missing-fields-error.png" alt-text="Screenshot that shows the field mismatch error.":::

## Cause

A field of a record exists in Copilot for Sales but not in CRM. The field is removed from the CRM after an administrator has configured fields of the record from the [Copilot for Sales administrator settings](/microsoft-sales-copilot/customize-forms-and-fields).

## Resolution

To solve this issue, check with the record owner to see if the field is removed by mistake. If the field is removed by mistake, ask the record owner to add the field back to the record in CRM. If the field is removed intentionally, [remove the field from the record in Copilot for Sales](/microsoft-sales-copilot/customize-forms-and-fields#remove-fields).

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
