---
title: You cannot send email as the selected user error
description: Fixes an issue in which you get the You cannot send email as the selected user error when you send an email as another user in Microsoft Dynamics CRM.
ms.reviewer: dmartens
ms.topic: troubleshooting
ms.date: 10/28/2022
ms.subservice: d365-sales-email-office-integration
---
# "You cannot send email as the selected user" error when sending an email as another user

This article helps you fix an issue in which you receive the "You cannot send email as the selected user" error when you send an email as another user in Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online, Microsoft Dynamics CRM 2016, Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 3184980

## Symptoms

When you try to send an email by setting the **From** field to another user in Microsoft Dynamics CRM, you receive the following error message:

> "You cannot send email as the selected user. The selected user has not allowed this or you do not have sufficient privileges to do so. Contact your system administrator for assistance."

## Cause

This issue occurs if one of the following conditions exists:

- Your security role in Microsoft Dynamics CRM is missing the **Send Email as Another User** privilege.

  > [!NOTE]
  > If you're using a Workflow rule to send the email, the owner of the Workflow rule needs this privilege.

- The user you're trying to send as hasn't enabled the option that allows other users to send an email as them.

## Resolution

To solve this issue, take the following steps to verify that your security role includes the **Send Email as Another User** privilege.

1. Sign in to Microsoft Dynamics CRM with a user who has the System Administrator role.
2. Navigate to **Settings**, and then select **Security** > **Security Roles**.
3. Open the security role assigned to the user who receives the error message.
4. Select the **Business Management** tab.
5. Verify that the user has the **Send Email as Another User** privilege.

    > [!NOTE]
    > The **Send Email as Another User** privilege has different levels of depth. A user needs sufficient depth in this privilege to match the user who they are trying to send as. For example, if you're trying to send as a user that is in a different Business Unit within Dynamics CRM, having Business Unit level access for this privilege would not be sufficient as it would only allow you to send as other users in your same business unit.

6. Select **Save**.

You also need to take the following steps to verify that the user you are trying to send as has enabled the option that allows other users to send emails as them.

1. Sign in to Microsoft Dynamics CRM as the user you are trying to send an email as.
2. Select the gear icon in the upper-right corner, and then select **Options**.
3. Select the **Email** tab.
4. Verify that the **Allow other Microsoft Dynamics CRM users to send e-mail on your behalf** option is selected.
5. Select **OK**.

## More information

When you select the **Download Log** button, the **Message** section shows the following information:

> \<Message>User does not have send-as privilege.\</Message>
