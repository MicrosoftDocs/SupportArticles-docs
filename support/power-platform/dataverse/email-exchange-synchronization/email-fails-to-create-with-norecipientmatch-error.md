---
title: Email fails to create with NoRecipientMatch error
description: An email fails to be created with a NoRecipientMatch sync error in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Email and Exchange Synchronization
---
# An email fails to be created with a NoRecipientMatch sync error in Microsoft Dynamics 365

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4339830

This article provides a resolution for the issue where an email message fails to be created in Microsoft Dynamics 365 due to a **NoRecipientMatch** sync error.

## Symptoms

When reviewing email messages analyzed for automatic promotion by Microsoft Dynamics 365, you might receive an email message that fails to be created with a **NoRecipientMatch** sync error or error code **-2147218683**.

## Cause

When evaluating an email in your mailbox, Dynamics 365 checks multiple conditions to determine if the message should be automatically created as an [email activity](/power-apps/developer/data-platform/email-activity-entities). The **NoRecipientMatch** error can occur due to one of the following reasons:

1. None of the email addresses on the **To** or **Cc** lines of the email are users or queues in Dynamics 365.
   - Example A: You receive the email because it's sent to a distribution group and you're a member of that distribution group. Your email address stored in  Dynamics 365 isn't actually on the **To** or **Cc** lines of the email.
   - Example B: You have multiple email addresses (for example, `John@contoso.com` and `John.David@contoso.com`) for the same mailbox, but the email address on the **To** or **Cc** line of the email doesn't match any of the email addresses stored in your user record in Dynamics 365.

2. There's a user or queue on the **To** or **Cc** line of the email, but the following conditions exist:
   - The email address used by the user or queue exists on other records in Dynamics 365. For example, A user has the `John@contoso.com` email address, but that email address also exists on one of the email address fields of another email enabled entity such as a user, queue, contact, lead, or an account.
   - Your organization is configured to leave email address values as unresolved if multiple matches are found.

     The combination of the two conditions mentioned causes the email not to be resolved to a user or queue record.

3. The email address of the user or queue is on the **Bcc** line of the email.

   For example, you receive the email because your email address is on the **Bcc** line of the email. Unless your personal options in Dynamics 365 are configured to track **All email messages**, the email isn't tracked.

   Unless the email address on the **To** or **Cc** line of the email matches the email address stored in Dynamics 365 or your personal options in Dynamics 365 are configured to track **All email messages**, the email isn't tracked.

4. There isn't a row in the `EmailSearchBase` table for the user or queue mailbox that receives the email.

   When looking for matching user or queue records, Dynamics 365 queries a table called `EmailSearchBase`. This table should automatically have a row for the email address of every email enabled record including users and queues. On rare occasions, a row might be missing, which causes Dynamics 365 not to find a matching row when querying this table for users or queues that are on the email message.

   You can open a web browser and use the Dynamics 365 Web API to verify if a row exists for the user or queue email address that receives the email message. Use the following syntax:

   `https://<Your Organization URL>/api/data/v9.1/emailsearches?$filter=emailaddress eq '<email address of user or queue>'`

   For example, `https://contoso.crm.dynamics.com/api/data/v9.1/emailsearches?$filter=emailaddress eq 'John@contoso.com'`.

   If no record is returned, it indicates a row doesn't exist for that email address in the `EmailSearchBase` table.

## Resolution

Review the characteristics of the email and which option you configure in your personal options for email tracking.

> [!NOTE]
> To manage security roles and mailbox settings, you need to sign in to your Dynamics 365 organization as a user with the "System Administrator" role.

1. To verify the email address stored in Dynamics 365:

   1. Navigate to **Settings** > **Email Configuration**, and then select **Mailboxes**.
   2. Open your mailbox record and verify the email address on the **To** or **Cc** line of the email matches the email address found in your mailbox record.

      > [!NOTE]
      > If you have multiple email addresses for your mailbox, select the regarding lookup and add the other email address to one of the other email address fields on your user record.

2. If the email address of the user or queue exists on multiple records (for example, another user, queue, lead, account, and contact), either remove the email address from the other records or change the **Set To, cc, bcc fields as unresolved values if multiple matches are found in Incoming Emails** setting to **No**. You can find this setting by navigating to **Settings** > **Email Configuration** > **Email Configuration Settings**. Within the **Set Email form options** section, locate the setting named **Set To, cc, bcc fields as unresolved values if multiple matches are found in Incoming Emails**.

3. To view or change your email tracking setting:

    1. Access your personal options in Dynamics 365 by selecting settings (the gear icon in the upper-right corner) and then selecting **Options**.
    2. Select the **Email** tab.
    3. Under the **Select the email messages to track in Microsoft Dynamics 365 section**, locate the **Track** setting.
    4. Adjust the option as necessary to control which emails should be tracked in Dynamics 365 automatically.

       For example, if you want to automatically create email activities for received emails regardless of the sender in Dynamics 365, select the option **All email messages**.

   For more information about email correlation, see [Email message filtering and correlation](/previous-versions/dynamicscrm-2016/administering-dynamics-365/hh699705(v=crm.8)).

4. If no records are found when using the steps in cause 4, follow these steps:

    1. Open the user or queue record in Dynamics 365.
    2. Change the email address value to something else and select **Save**.
    3. Change the email address value back to the correct value and select **Save**. Then, the missing row is re-created.

## More information

[System Settings Email tab](/power-platform/admin/system-settings-dialog-box-email-tab)
