---
title: Can't save emails to CRM as Enhanced Email isn't enabled in Salesforce CRM
description: Resolves the Update settings in Salesforce error when Enhanced Email isn't enabled in Salesforce CRM.
ms.date: 01/06/2024
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# Can't save an email to CRM when Enhanced Email isn't enabled in Salesforce CRM

This article helps you troubleshoot and resolve the "Update settings in Salesforce" error that occurs in Microsoft Copilot for Sales when **Enhanced Email** isn't enabled in Salesforce CRM.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshot in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | All users   |

## Symptoms

When you try to save an email to Salesforce, you receive the following error message:

> Update settings in Salesforce

:::image type="content" source="media/update-settings-in-saleforce-error/update-settings-error.png" alt-text="Screenshot that shows the Update settings error that occurs when Enhanced Email isn't enabled.":::

## Cause

**Enhanced Email** isn't enabled in Salesforce.

## Resolution

To resolve this issue, perform one of the following actions:

- [Enable Enhanced Email in Salesforce](https://help.salesforce.com/s/articleView?id=sf.enable_enhanced_email.htm&type=5).
- Ask your administrator to contact Microsoft support to allow emails to be saved to Salesforce without enabling **Enhanced Email** in Salesforce.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
