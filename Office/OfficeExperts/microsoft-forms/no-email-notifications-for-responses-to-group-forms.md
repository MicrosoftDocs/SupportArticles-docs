---
title: No email notifications for responses to Group Forms
description: Describes the steps to edit group to receive email notifications.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
  - CI 125260
ms.topic: troubleshooting
ms.author: luche
ms.reviwer: zakirh
appliesto: 
  - Microsoft Forms
ms.date: 02/15/2023
---
# No email notifications for responses to Group Forms

This article was written by [Zakir Haveliwala](https://social.technet.microsoft.com/profile/Zakir+H+-+MSFT), Senior Support Escalation Engineer.

You might not receive email notifications for responses that you submit to a Group Form, such as a Form that you create in Microsoft Teams. To receive email notifications, do the following:

1. Sign in to Forms at [https://forms.office.com](https://forms.office.com).

2. Scroll down to **My groups**.

   :::image type="content" source="media/no-email-notifications-for-responses-to-group-forms/my-groups.png" alt-text="Select My groups after you sign in to Forms." border="false":::

3. Select the group for which you want to get email notifications.

   :::image type="content" source="media/no-email-notifications-for-responses-to-group-forms/select-group.png" alt-text="Select the group for which you want to get email notifications." border="false":::

4. On the right side, you see the number of members in the group. Select that number, and then it opens the group email page in Outlook on the web.

   :::image type="content" source="media/no-email-notifications-for-responses-to-group-forms/number-of-members.png" alt-text="Selecting the number of members in the top-right." border="false":::

5. In Outlook on the web, select the More options icon (...), and then select **Edit group**.

    :::image type="content" source="media/no-email-notifications-for-responses-to-group-forms/edit-group-option.png" alt-text="Select the ellipsis and then select the Edit group option.":::

   **Note:** If the **Edit group** option isn't available, it indicates that the group was created in Microsoft Teams. When a group is created in Teams, the Exchange Online setting `HiddenFromExchangeClientsEnabled` is set to **True** by default. When `HiddenFromExchangeClientsEnabled` is set to **True**, it removes the **Edit group** option from the group email settings, so you can't enable the settings that allow group email notifications to members.

   To view the current setting, run the following command in Exhange Online PowerShell, replace \<groupname\> with the name of the group:
   
    ```powershell
     Get-UnifiedGroup -Filter {displayname -eq "<groupname>"} | Format-List HiddenFromExchangeClientsEnabled
    ``` 

    If `HiddenFromExchangeClientsEnable` is set to **True**, use the following command to set it to **False**:

    ```powershell
     Set-UnifiedGroup -Identity "<groupname>" -HiddenFromExchangeClientsEnabled:$False
    ```
6. Select the **Let people outside the organization email the groups** and **Members will receive all group conversations and events ...** check boxes and then select **Save**.

    :::image type="content" source="media/no-email-notifications-for-responses-to-group-forms/select-two-checkboxes-in-edit-group-page.png" alt-text="Select the two checkboxes in the External email settings.":::

    The global administrator can use these steps instead:

    1. Sign in to [Microsoft 365 admin center](https://admin.microsoft.com) and go to **Groups** > **Active groups**.
    2. Select the appropriate group from the list, and then select the **Settings** tab.
    3. Select the **Allow external senders to email this group** and **Send copies of group conversations and events to group members** check boxes.

    :::image type="content" source="media/no-email-notifications-for-responses-to-group-forms/active-groups.png" alt-text="Enable settings for global administrators.":::

7. Open the Form, select the ellipsis button (...) on the upper-right corner of your screen, select **Settings**, and then select the **Get email notification of each response** check box.

    :::image type="content" source="media/no-email-notifications-for-responses-to-group-forms/get-email-notification-of-each-response.png" alt-text="Select the ellipsis button, then Settings, then select the Get email notification of each response option.":::

All the users in the group will receive email notifications when a response is submitted to the Form.
