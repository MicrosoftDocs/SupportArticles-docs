---
title: Salesforce CRM users can't view, edit, or save data in Sales app
description: Resolves an issue where users are unable to view, edit, or save data in Sales app.
ms.date: 05/07/2024
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# Salesforce CRM users can't view, edit, or save data in Sales app

This article helps you resolve an issue where users can't view, edit, or save data in Sales app.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales app in Outlook        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users who don't have permission to view fields added in a Sales app form can't save, edit, or view the form  |

## Symptoms

When a user opens Sales app in Outlook, the following error message is displayed:

> Something went wrong.

When you select **Show details**, you see "SFTypeNotSupported" or "SFInvalidField" error code.

:::image type="content" source="media/salesforce-permission-error/sf-perm-error.png" alt-text="Screenshot that shows the error that occurs when users don't have permission in CRM to view, create, or edit objects.":::

## Cause

The user has no permission to view, create, or edit objects in Salesforce CRM. As a result, Sales app can't reference that object as expected in the configuration.

Objects must have at least read permissions to be displayed in Sales app. For example, if a user doesn't have read permissions for the Contact entity, the contacts won't be displayed in Sales app.

## Resolution

To resolve this issue, update the user profile permissions in Salesforce.

1. Sign in to Salesforce CRM as an administrator.
2. Go to **Setup** > **Administration** > **Users** > **Users**.
3. Find the user who is experiencing the issue and select the profile that's assigned to the user. Perform the following steps based on the profile type:

   - If the profile isn't a custom profile, change it to one that has the correct permissions. 
   - If the profile is correct and is a custom profile, select **Edit**. Then, in the **Standard Object Permissions** section, provide the required permissions.

4. Save the changes.

    > [!NOTE]
    >
    > - Updating permissions in a profile can affect other users who are assigned to the same profile. 
    > - Users must have permission to access all the objects that are added to Sales app from the admin settings in Microsoft Teams.

## More information

If your issue is still unresolved, go to the [Sales solution in Microsoft 365 Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
