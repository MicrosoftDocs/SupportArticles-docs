---
title: Unable to sign in to Salesforce due to blocked Salesforce connector
description: Troubleshoot and resolve error messages in Sales Copilot when a user is unable to sign in to Salesforce due to blocked Salesforce connector.
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
---

# Unable to sign in to Salesforce due to blocked Salesforce connector

This article helps you troubleshoot and resolve error in Sales Copilot when a user is unable to sign in to Salesforce due to blocked Salesforce connector.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | All users  |

## Symptom

When a user tries to sign in to Salesforce from Sales Copilot, the following error message is displayed: `Something went wrong` with the error code as `ConnectionApiPolicyViolation`.

:::image type="content" source="media/tsg-blocked-connector-sf.png" alt-text="Error about blocked Salesforce connector.":::

## Cause

The Salesforce connector is blocked on the default environment.

The Data Loss Prevention (DLP) policy is enabled on the default environment in the tenant thereby blocking the Salesforce connector.

## Solution

You must unblock the Salesforce connector in the DLP policy to resolve this issue.

1. Sign in to the Power Platform admin center with admin credentials.
1. In the left navigation pane, select **Policies** > **Data policies**.
1. Select the data policy blocking the Salesforce connector, and then select **Edit Policy**.
1. On the **Prebuilt connectors** step, move the **Salesforce** connector to either **Business** or **Non-business**.
1. Go through rest of the steps, and then select **Update policy**.

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.