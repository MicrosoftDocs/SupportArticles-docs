---
title: Salesforce CRM users can't see data in Copilot for Sales
description: Resolves an issue where users are unable to see data in Microsoft Copilot for Sales.
ms.date: 12/27/2023
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# Salesforce CRM users unable to see data in Copilot for Sales

This article helps you troubleshoot and resolve an issue where users can't see data in Microsoft Copilot for Sales.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshots in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | Users who don't have permissions to view fields added in Copilot for Sales forms   |

## Symptoms

When a user opens Copilot for Sales in Outlook, the following error message is displayed:

> Something went wrong

:::image type="content" source="media/no-column-error/no-such-column-error.png" alt-text="Screenshot that shows the details of the Something went wrong error.":::

## Cause

The field-level security on field is set to invisible in Salesforce CRM. As a result, Copilot for Sales can't reference that field as expected in configuration.

## Resolution 1: Fix field-level security in Salesforce CRM

1. Sign in to Salesforce CRM as administrator and open **Setup**.

2. Open **Object Manager**.

3. Select the entity that is throwing an error.

4. In the navigation bar on the left, select **Fields & Relationships**.

5. Select the field that is throwing the error.

6. Select **Set Field-Level Security** at the top.

    :::image type="content" source="media/no-column-error/set-field-level-security-salesforce.png" alt-text="Screenshot that shows the Object Manager in Salesforce CRM.":::

7. Ensure that **Visible** is set for the right profiles.

8. Validate the same for custom permissions sets.

For more information regarding field-level security in Salesforce CRM, see [Field-Level Security](https://help.salesforce.com/s/articleView?id=sf.admin_fls.htm&type=5).

## Resolution 2: Change settings in Copilot for Sales to hide fields or remove edit capabilities

Change the admin settings from the Copilot for Sales admin settings in Microsoft Teams to hide the fields or remove edit capabilities.

1. Sign in to Microsoft Teams with your administrator credentials.

2. In the navigation bar on the left, select **Copilot for Sales**.

3. On the **Settings** tab, select **Forms**.

4. Select the entity for which you're seeing the error.

5. Under **Manage fields**, perform one of the following actions:

    - If the issue is related to editing of a field, turn off **Allow editing** for the corresponding field.

        :::image type="content" source="media/no-column-error/turn-off-edit-fields.png" alt-text="Screenshot that shows how to turn off editing for a few fields on the Manage fields page.":::

    - If the issue is related to viewing the field, hover over the field, and select **Remove field** (![Delete icon.](media/no-column-error/delete-icon.png "Delete icon")).

6. Select **Publish** to save your changes.

## More information

If your issue is still not resolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]