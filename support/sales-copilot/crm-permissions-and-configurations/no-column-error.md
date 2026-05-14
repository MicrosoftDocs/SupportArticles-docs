---
title: Salesforce CRM users can't see data in Sales agent
description: Resolves an issue where users are unable to see data in Sales agent.
ms.date: 05/14/2026
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
ms.reviewer: shjais, v-shaywood
---
# Salesforce CRM users unable to see data in Sales agent

This article helps you troubleshoot and resolve an issue where users can't see data in Sales agent.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales agent in Outlook        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | Users who don't have permission to view fields added in Sales agent forms   |

## Symptoms

When a user opens Sales agent in Outlook, the following error message is displayed:

> Something went wrong

:::image type="content" source="media/no-column-error/no-such-column-error.png" alt-text="Screenshot that shows the details of the Something went wrong error.":::

## Cause

The field-level security for the field is set to invisible in Salesforce CRM. As a result, Sales agent can't reference that field as expected in the configuration.

## Resolution 1: Fix field-level security in Salesforce CRM

1. Sign in to Salesforce CRM as an administrator and open **Setup**.

2. Open **Object Manager**.

3. Select the entity that is throwing the error.

4. In the navigation bar on the left, select **Fields & Relationships**.

5. Select the field that is throwing the error.

6. Select **Set Field-Level Security** at the top.

    :::image type="content" source="media/no-column-error/set-field-level-security-salesforce.png" alt-text="Screenshot that shows the Object Manager in Salesforce CRM." lightbox="media/no-column-error/set-field-level-security-salesforce.png":::

7. Ensure that **Visible** is set for the right profiles.

8. Validate the same for custom permissions sets.

For more information regarding field-level security in Salesforce CRM, see [Field-Level Security](https://help.salesforce.com/s/articleView?id=sf.admin_fls.htm&type=5).

## Resolution 2: Change settings in Sales agent to hide fields or remove edit capabilities

Change the admin settings from the Sales agent admin settings in Microsoft Teams to hide the fields or remove editing capabilities.

1. Sign in to Microsoft Teams with your administrator credentials.

2. In the navigation bar on the left, select **Sales**.

3. On the **Settings** tab, select **Forms**.

4. Select the entity for which you're seeing the error.

5. Under **Manage fields**, perform one of the following actions:

    - If the issue is related to editing a field, turn off **Allow editing** for the corresponding field.

        :::image type="content" source="media/no-column-error/turn-off-edit-fields.png" alt-text="Screenshot that shows how to turn off editing for a few fields on the Manage fields page." lightbox="media/no-column-error/turn-off-edit-fields.png":::
    - If the issue is related to viewing a field, hover over the field, and select **Remove field** (:::image type="icon" source="media/no-column-error/delete-icon.png ":::).

6. Select **Publish** to save your changes.

## Resolution 3: Refresh the data from CRM

If you don't know which field is causing the issue, you can [refresh the data](/microsoft-sales-copilot/customize-forms-and-fields#refresh-data-from-crm) from CRM. This action will sync the latest changes from CRM to Sales agent and remove any fields that were removed from CRM but are still available in Sales agent. After you refresh the data, you must close and reopen the Sales agent in Outlook.

## More information

If your issue is still unresolved, go to the [Sales agent - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
