---
title: Can't sign in to Salesforce due to blocked Salesforce connector
description: Resolves an error message that occurs in Copilot for Sales when you can't sign in to Salesforce due to a blocked Salesforce connector.
ms.date: 01/25/2024
author: sbmjais
ms.author: shjais
ms.custom: sap:Setup, Installation and Sign-in\CRM Sign-In & Sign Out
---
# Can't sign in to Salesforce due to blocked Salesforce connector

This article helps you troubleshoot and resolve an error that occurs in Microsoft Copilot for Sales when you can't sign in to Salesforce due to a blocked Salesforce connector.

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
|**Users**     | All users  |

## Symptoms

When you try to sign in to Salesforce from Copilot for Sales, the following error message is displayed with the error code `ConnectionApiPolicyViolation`:

> Something went wrong

:::image type="content" source="media/sign-in-issue-with-blocked-connector/blocked-connector-error.png" alt-text="Screenshot that shows the error that occurs when the Salesforce connector is blocked.":::

## Cause

The Salesforce connector is blocked in the [msdyn_viva environment](/microsoft-sales-copilot/data-handling#copilot-for-sales-dataverse-and-your-crm).

The Data Loss Prevention (DLP) policy is enabled in the tenant's msdyn_viva environment, thereby blocking the Salesforce connector.

## Resolution

To resolve this issue, you must unblock the Salesforce connector in the DLP policy.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/) with admin credentials.
1. In the left navigation pane, select **Policies** > **Data policies**.
1. Select the data policy that blocks the Salesforce connector, and then select **Edit Policy**.
1. In the **Prebuilt connectors** step, move the **Salesforce** connector to either **Business** or **Non-business**.
1. Go through the rest of the steps, and then select **Update policy**.

For more information, see [Manage data loss prevention (DLP) policies](/power-platform/admin/prevent-data-loss).

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
