---
title: Required fields missing error
description: Resolve the required fields missing error in the Microsoft Copilot for Sales panel in Outlook.
ms.date: 03/04/2024
author: sbmjais
ms.author: shjais
---

# Required fields missing error

This article helps you troubleshoot and resolve the required fields missing error in the Microsoft Copilot for Sales panel in Outlook.


## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users who do not have permissions to view fields added in Copilot for Sales forms cannot save, edit, or view the form  |

## Symptoms

When a user tries to create a contact or another record from the Copilot for Sales pane in Outlook, the "Required fields are missing error" is displayed.

`image`

## Cause

Salesforce object configuration is updated with a required field but it is not added to the Copilot for Sales form through admin settings in Teams. Due to this, the required field is missing in the form and the user cannot save the record. When a user tries to save the record, the required field missing error is displayed. 

## Resolution 1: Update admin settings in Teams

1. [Access admin settings in Teams.](/microsoft-sales-copilot/administrator-settings-for-viva-sales#access-administrator-settings)
2. Select **Forms**, and then select the object for which the error is displayed.
3. Select **Refresh data**.
4. Select **Add fields**, find all the fields marked as required, and then add them to the form.
5. Publish the changes.

## Resolution 2: Change the required field property in Salesforce

1. Sign in to Salesforce CRM as an administrator.
2. Go to **Setup** > **Object Manager**, and select the object for which the error is displayed.
3. In the left pane, select **Fields & Relationships**, and then select the field that is mentioned in the error message.
4. Select Edit, and then clear the **Required** check box under the **General Options** section.
    > [!NOTE]
    > If you don't see the **Required** check box, it means that the field is not a custom field. You must follow [Resolution 1: Update admin settings in Teams](#resolution-1-update-admin-settings-in-teams) to resolve the issue.

## Resolution 3: Delete the required field in Salesforce

1. Sign in to Salesforce CRM as an administrator.
2. Go to **Setup** > **Object Manager**, and select the object for which the error is displayed.
3. In the left pane, select **Fields & Relationships**, and then find the field that is mentioned in the error message.
1. If the field is a custom field, select the down arrow at the end of the row, and then select **Delete**. 

    If the field is not a custom field. You must follow [Resolution 1: Update admin settings in Teams](#resolution-1-update-admin-settings-in-teams) to resolve the issue.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]