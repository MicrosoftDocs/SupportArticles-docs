---
title: You cannot send email as the selected user error
description: Resolves the You cannot send email as the selected user error that occurs when you send an email on behalf of another user in Microsoft Dynamics 365.
ms.reviewer: dmartens
ms.date: 11/25/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "You cannot send email as the selected user" error when sending an email as another user

This article presents possible causes and a resolution for the "You cannot send email as the selected user" error that occurs when you send an email on behalf of another user in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3184980

## Symptoms

When you try to send an email by setting the **From** field to another user in Dynamics 365, you receive the following error message:

> You cannot send email as the selected user. The selected user has not allowed this or you do not have sufficient privileges to do so. Contact your system administrator for assistance.

When you select the **Download Log** button, the **Message** section shows the following information:

> \<Message>User does not have send-as privilege.\</Message>

## Cause

This issue occurs if one of the following conditions exists:

- Your security role in Dynamics 365 doesn't have the **Send Email as Another User** privilege.

  > [!NOTE]
  > If you use a Workflow rule to send the email, the owner of the Workflow rule needs this privilege.

- The user you try to send as hasn't enabled the option that allows other users to send an email on their behalf.

## Resolution

To solve this issue:

- An administrator should verify that the user has a role in Dynamics 365 that includes the **Send Email as Another User** privilege.

  1. Sign in to Microsoft Dynamics 365.
  1. Select **Settings** > **Advanced settings** > **Settings** > **Security** > **Security Roles**.
  1. Open the security role assigned to the user who receives the error message.
  1. Select **Business Management** > **Miscellaneous Privileges**.
  1. Verify that the user has the **Send Email as Another User** privilege. If the user doesn't have the privilege, assign it, and then select **Save**.

      > [!NOTE]
      > The **Send Email as Another User** privilege has different levels of depth. A user needs sufficient depth in this privilege to match the user who they're trying to send as. For example, if you try to send as a user that's in a different business unit within Dynamics 365, having business unit level access for this privilege wouldn't be sufficient as it would only allow you to send as other users in your same business unit.

- The other user being set as the sender on the email needs to select the **Allow other Microsoft Dynamics 365 users to send email on your behalf** checkbox in their personal options.

  1. Sign in to Dynamics 365 as the user you try to send an email as.
  1. Select the gear icon in the upper-right corner, and then select **Options** > **Settings** > **Personalization Settings** > **Email**.
  1. Verify that the **Allow other Microsoft Dynamics 365 users to send email on your behalf** option is selected. If not, select the option, and then select **OK**.

## More information

- [Optional: Send outgoing email as another user with Exchange mailbox delegation](/power-platform/admin/send-email-on-behalf#optional-send-outgoing-email-as-another-user-with-exchange-mailbox-delegation)
- [Security roles and privileges](/power-platform/admin/security-roles-privileges)
