---
title: Can't sign in to Salesforce due to blocked Salesforce connector
description: Resolves the error message that occurs in Copilot for Sales when you can't sign in to Salesforce due to a blocked Salesforce connector.
ms.date: 12/26/2023
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
---
# Can't sign in to Salesforce due to blocked Salesforce connector

This article helps you troubleshoot and resolve the error that occurs in Microsoft Copilot for Sales when you can't sign in to Salesforce due to a blocked Salesforce connector.

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

When you try to sign in to Salesforce from Microsoft Copilot for Sales, the following error message is displayed with the error code as `ConnectionApiPolicyViolation`:

> Something went wrong

:::image type="content" source="media/sign-in-issue-with-blocked-connector/blocked-connector-error.png" alt-text="Screenshot that shows the error that occurs when the Salesforce connector is blocked.":::

## Cause

The Salesforce connector is blocked on the default environment.

The Data Loss Prevention (DLP) policy is enabled on the default environment in the tenant thereby blocking the Salesforce connector.

## Resolution

You must unblock the Salesforce connector in the DLP policy to resolve this issue.

1. Sign in to the Power Platform admin center with admin credentials.
1. In the left navigation pane, select **Policies** > **Data policies**.
1. Select the data policy that blocks the Salesforce connector, and then select **Edit Policy**.
1. On the **Prebuilt connectors** step, move the **Salesforce** connector to either **Business** or **Non-business**.
1. Go through rest of the steps, and then select **Update policy**.

## More information

If your issue is still not resolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
