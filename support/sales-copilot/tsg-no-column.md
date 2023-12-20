---
title: Salesforce CRM users unable to see data in Sales Copilot
description: Troubleshoot and resolve  issues when users are unable to see data in Sales Copilot.
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Salesforce CRM users unable to see data in Sales Copilot

This article helps you troubleshoot and resolve issues when users are unable to see data in Sales Copilot. 

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | Users who don't have permissions to view fields added in Sales Copilot forms   |


## Symptom

When a user opens Sales Copilot in Outlook, the following error message is displayed: **Something went wrong**. 

:::image type="content" source="media/tsg-field-error.png" alt-text="Error to delete fields.":::

## Cause

Field level security on field has been set to invisible in Salesforce CRM.

When field level security is set to invisible, Sales Copilot can't reference that field as expected in configuration.

## Solution 1: Fix field level security in Salesforce CRM

1. Sign in to Salesforce CRM as administrator and open **Setup**.

2. Open **Object Manager**.

3. Select the entity that is throwing an error.

4. In the navigation bar on the left, select **Fields & Relationships**.

5. Select the field that is throwing the error.

6. Select **Set Field-Level Security** at the top.

    :::image type="content" source="media/tsg-field-error-sf.png" alt-text="Object manager in Salesforce CRM":::

7. Ensure that **Visible** is set for the right profiles.

8. Validate the same for custom permissions sets.

For more information regarding field level security in Salesforce CRM, see [Field-Level Security](https://help.salesforce.com/s/articleView?id=sf.admin_fls.htm&type=5).

## Solution 2: Change settings in Sales Copilot to hide fields or remove edit capabilities

Change the admin settings from the Sales Copilot admin settings in Microsoft Teams to hide the fields or remove edit capabilities.

1. Sign in to Microsoft Teams with your administrator credentials.

2. In the navigation bar on the left, select **Sales Copilot**.

3. On the **Settings** tab, select Forms.

4. Select the entity for which you're seeing the error.

5. Under **Manage fields**, perform one of the following actions:

    - If the issue is related to editing of a field, turn off **Allow editing** for the corresponding field.

        :::image type="content" source="media/tsg-allow-edit.png" alt-text="Turn off editing for a few fields":::

    - If the issue is related to viewing the field, hover over the field, and select **Remove field** (![Delete icon.](media/delete-icon.png "Delete icon")).

6. Select **Publish** to save your changes.

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
