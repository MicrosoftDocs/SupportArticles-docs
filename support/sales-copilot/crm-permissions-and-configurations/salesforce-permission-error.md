---
title: Salesforce permission error
description: Resolves the errors displayed in the record type cards in the Microsoft Copilot for Sales panel in Outlook.
ms.date: 03/04/2024
author: sbmjais
ms.author: shjais
---

# Salesforce permission error

This article helps you troubleshoot and resolve the errors displayed in the record type cards in the Microsoft Copilot for Sales panel in Outlook. 

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

When a user opens the Copilot for Sales pane, the error messages are displayed in the record type cards. 

`image`

## Cause

User does not have permissions for the objects to view, create, or edit them in Copilot for Sales. At least read permissions are required for the objects to view them in Copilot for Sales. For example, if a user does not have read permissions for the Contact entity, contacts are not displayed in Copilot for Sales.

## Resolution

To resolve this issue, you must update user profile permissions in Salesforce.

1. Sign in to Salesforce CRM as an administrator.
2. Go to **Setup** > **Administration** > **Users** > **Users**.
3. Find the user who is experiencing the issue and select the profile that the user is assigned to. Perform the following steps based on the profile type:
    - If the profile is not a custom profile, you must change the profile to the one that has correct permissions. 
    - If the profile is correct and is a custom profile, select **Edit**. In the **Standard Object Permissions** section, provide the required permissions.
1. Save the changes.

    > [!NOTE]
    > - Updating permissions in a profile can affect other users who are assigned to the same profile. 
    > - Users must have permissions to all the objects that are added to the Copilot for Sales from admin settings in Teams.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
