---
title: You cannot send email as the selected user
description: Fixes an issue in which you get the "You cannot send email as the selected user" error when you send an email as another user in Microsoft Dynamics CRM.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "You cannot send email as the selected user" error when attempting to send email as another user

This article helps you fix an issue in which you get the "You cannot send email as the selected user" error when you send an email as another user in Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2016  
_Original KB number:_ &nbsp; 3184980

## Symptoms

When you attempt to send an email in Microsoft Dynamics CRM and you set the **From** field to be another user, you encounter the following error:

> "You cannot send email as the selected user. The selected user has not allowed this or you do not have sufficient privileges to do so. Contact your system administrator for assistance."

## Cause

This error will occur if one of the following conditions exists:

- Your security role in Microsoft Dynamics CRM is missing the **Send Email as Another User** privilege.

  > [!NOTE]
  > If you're using a Workflow rule to send the email, the owner of the Workflow rule needs this privilege.

- The user you're trying to send as hasn't enabled the option which allows other users to send email as them.

## Resolution

Verify your CRM security role includes the **Send Email as Another User** privilege.

1. Sign in to Microsoft Dynamics CRM with a user that has the System Administrator role.
2. Navigate to **Settings** and then access **Security**.
3. Click **Security Roles**.
4. Open the security role assigned to the user who is encountering the error.
5. Click the **Business Management** tab.
6. Verify the user has the **Send Email as Another User** privilege.

    > [!NOTE]
    > The **Send Email as Another User** privilege has different levels of depth. A user needs sufficient depth in this privilege to match the user who they are trying to send as. For example: If you're trying to send as a user that is in a different Business Unit within CRM, having Business Unit level access for this privilege would not be sufficient as it would only allow you to send as other users in your same business unit.

7. Click **Save**.

Verify the user you are trying to send as has enabled the option that allows other users to send email as them.

1. Sign in to Microsoft Dynamics CRM as the user you are trying to send email as.
2. Click the gear icon in the upper-right corner and then click **Options**.
3. Click the **Email** tab.
4. Verify the **Allow other Microsoft Dynamics CRM users to send e-mail on your behalf** is selected.
5. Click **OK**.

## More information

When you click the **Download Log** button, the Message section includes the following info:

> \<Message>User does not have send-as privilege.\</Message>
