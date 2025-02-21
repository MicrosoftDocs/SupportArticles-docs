---
title: Required fields are missing error in Copilot for Sales
description: Resolves the Required ields are missing error that occurs when creating a contact or record in the Microsoft Copilot for Sales panel in Outlook.
ms.date: 02/05/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# "Required fields are missing" error when creating a contact or record from Copilot for Sales in Outlook

This article provides a resolution for the “Required fields are missing” error that occurs in the Microsoft Copilot for Sales panel in Outlook.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users who don't have permission to view fields added in a Copilot for Sales form can't save, edit, or view the form  |

## Symptoms

When a user tries to [create a contact or record from the Copilot for Sales pane in Outlook](/microsoft-sales-copilot/create-contact-crm-sales-copilot), the following error message is displayed: 

> Required fields are missing

When you copy error details, you see the error code "SFRequiredFieldMissing".

:::image type="content" source="media/required-field-missing/required-field-missing.png" alt-text="Screenshot that shows the error that occurs when the required fields are missing.":::

## Cause

The Salesforce object configuration was updated with a required field, but it wasn't added to the Copilot for Sales form through the admin settings in Microsoft Teams. Therefore, the required field is missing from the form, and the user can't save the record. When the user tries to save the record, the "Required field are missing" error is displayed.

## Resolution 1: Update administrator settings in Microsoft Teams

1. [Access administrator settings in Microsoft Teams](/microsoft-sales-copilot/administrator-settings-for-viva-sales#access-administrator-settings).
2. Select **Forms**, and then select the object that displays the error.
3. Select **Refresh data**.
4. Select **Add fields**, find all the fields in the list that are marked as required in the CRM, and then add them to the form.
5. Publish the changes.

## Resolution 2: Change the required field property in Salesforce

1. Sign in to Salesforce CRM as an administrator.
2. Go to **Setup** > **Object Manager**, and select the object that displays the error.
3. In the left pane, select **Fields & Relationships**, and then select the field that's mentioned in the error message.
4. Select **Edit**, and then clear the **Required** checkbox under the **General Options** section.

     > [!NOTE]
     > If you don't see the **Required** checkbox, it means that the field isn't a custom field. In this case, use [Resolution 1: Update admin settings in Teams](#resolution-1-update-administrator-settings-in-microsoft-teams) to resolve the issue.

## Resolution 3: Delete the required field in Salesforce

1. Sign in to Salesforce CRM as an administrator.
2. Go to **Setup** > **Object Manager**, and then select the object that displays the error.
3. In the left pane, select **Fields & Relationships**, and then find the field that's mentioned in the error message.
4. If the field is a custom field, select the down arrow at the end of the row, and then select **Delete**. 

    If the field isn't a custom field, use [Resolution 1: Update admin settings in Teams](#resolution-1-update-administrator-settings-in-microsoft-teams) to resolve the issue.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
