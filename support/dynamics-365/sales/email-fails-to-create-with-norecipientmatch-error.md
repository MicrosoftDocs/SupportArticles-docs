---
title: Email fails to create with NoRecipientMatch error
description: An email fails to be created in Microsoft Dynamics 365 with a NoRecipientMatch sync error.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# An email fails to be created in Microsoft Dynamics 365 with a NoRecipientMatch sync error

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4339830

## Symptoms

When reviewing email messages that were analyzed for automatic promotion by Microsoft Dynamics 365, you see an email message that failed to be created in Microsoft Dynamics 365 with a **NoRecipientMatch** sync error or error code **-2147218683**.

## Cause

When Microsoft Dynamics 365 evaluates an email in your mailbox, multiple conditions are evaluated to determine if the message should automatically be created as an email activity in Microsoft Dynamics 365. If the evaluation results in a **NoRecipientMatch** error, this indicates one of the following conditions:

1. None of the email addresses on the To or Cc lines of the email are users or queues in Microsoft Dynamics 365.
   - Example A: You received the email because it was sent to a distribution group and you are a member of that distribution group. Your email address stored in Microsoft Dynamics 365 is not actually on the To or Cc lines of the email.
   - Example B: You have multiple email addresses (for example, `John@contoso.com` and `John.David@contoso.com`) for the same mailbox but the email addresses on the To or Cc line of the email does not match any of the email addresses stored in your user record in Microsoft Dynamics 365.

2. There is a user or queue on the To or Cc line of the email but the following conditions exist:
   - The email address used by the User or Queue exists on other records in Microsoft Dynamics 365. For example: A User has the email address `John@contoso.com` but that email address also exists on one of the email address fields of another email enabled entity such as a user, queue, contact, lead, or account.
   - Your organization is configured to leave email address values as unresolved if multiple matches are found.

     The combination of the two conditions mentioned above would cause the email to not be resolved to a user or queue record.

3. The email address of the user or queue is on the Bcc of the email.

   Example: You received the email because your email address was on the Bcc line of the email. Unless your personal options in Microsoft Dynamics 365 are configured to track **All email messages**, the email will not be tracked.

   Unless the email address on the To or Cc line of the email matches the email address stored in Microsoft Dynamics 365 or your personal options in Microsoft Dynamics 365 are configured to track **All email messages**, the email will not be tracked.

4. There is not a row in the EmailSearchBase table for the User or Queue mailbox that received the email.

   When looking for matching User or Queue records, Microsoft Dynamics 365 queries a table called EmailSearchBase. This table should automatically have a row for the email address of every email enabled record including Users and Queues. On rare occasions this table may be missing a row, which can then cause Microsoft Dynamics 365 to not find a matching row when querying this table for Users or Queues that are on the email message.

   You can open a web browser and use the Microsoft Dynamics 365 Web API to verify if a row exists for the user or queue email address that received the email message. Use the following syntax:

   `https://<Your Organization URL>/api/data/v9.1/emailsearches?$filter=emailaddress eq '<email address of user or queue>'`

   Example: `https://contoso.crm.dynamics.com/api/data/v9.1/emailsearches?$filter=emailaddress eq 'John@contoso.com'`

   If no record is returned, this would indicate a row does not exist for that email address in the EmailSearchBase table.

## Resolution

Review the characteristics of the email and which option you have configured in your personal options for email tracking.

1. To verify the email address stored in Microsoft Dynamics 365:

   1. Navigate to **Settings** and then select **Email Configuration**.
   2. Select **Mailboxes**.
   3. Open your mailbox record and verify the email address on the To or Cc line of the email matches the email address found in your mailbox record.

      > [!NOTE]
      > If you have multiple email addresses for your mailbox, you can select the Regarding lookup and add the other email address to one of the other email address fields on your user record.

2. If the email address of the user or queue exists on multiple records (for example, another user, queue, lead, account, contact, and so on), either remove the email address from the other records or change the setting **Set To, cc, bcc fields as unresolved values if multiple matches are found in Incoming Emails** to **No**. You can find this setting by navigating to **Settings**, **Email Configuration**, and then selecting **Email Configuration Settings**. Within the **Set Email form options** section, locate the setting named **Set To, cc, bcc fields as unresolved values if multiple matches are found in Incoming Emails.**

3. To view or change your email tracking setting:

    1. Access your personal options in Microsoft Dynamics 365 by selecting settings (the gear icon in upper-right corner) and then selecting **Options**.
    2. Select the **Email** tab.
    3. Under the **Select the email messages to track in Microsoft Dynamics 365 section**, locate the **Track** setting.
    4. Adjust the option as necessary to control which emails should be tracked in Microsoft Dynamics 365 automatically.

       For example: If you want every email you receive, regardless of the sender, to automatically be created as an email activity in Microsoft Dynamics 365, select the option **All email messages**.

   For more information about email correlation, see [Email message filtering and correlation](/previous-versions/dynamicscrm-2016/administering-dynamics-365/hh699705(v=crm.8)).

4. If no records are found when using the steps in cause 4, follow these steps:

    1. Open the User or Queue record in Microsoft Dynamics 365.
    2. Change the email address value to something else and select **Save**.
    3. Then change the email address value back to the correct value and select **Save**. This will normally recreate the missing row.
