---
title: Error occurred in sending email for mailbox while connecting to the email server
description: Provides a solution to an email server error code ConnectFailure that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 12/09/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "An error occurred in sending email for the mailbox" when you test and enable a mailbox in Dynamics 365

This article provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4092737

## Symptoms

When you try to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Dynamics 365, you receive the following error:

> An error occurred in sending email for the mailbox \<Mailbox Name> "Your mailbox is now connected to Dynamics 365" while connecting to the email server. The owner of the associated email server profile \<Mailbox Name> has been notified. The system will try to send email again later.  
> **Email Server Error Code:**  Web server returned ConnectFailure exception.

## Cause

This error can occur if Dynamics 365 can't connect to your email server.

### Cause 1: Firewall doesn't allow communication from Dynamics 365 online

If you use Dynamics 365 online with Exchange on-premises, it can occur if your firewall doesn't allow communication from Dynamics 365 online.

To solve this issue, verify your firewall allows communication from Dynamics 365 online. For a list of the IP address ranges that might be used by Dynamics 365, see [Microsoft Dynamics 365 online IP Address Ranges](https://support.microsoft.com/topic/microsoft-dynamics-crm-online-ip-address-ranges-0b22a844-e61d-443b-482f-945de79f764d).

### Cause 2: Port values are incorrect

If you use an SMTP/POP3 provider such as Gmail, it can occur if the port values within the **Advanced** section of the email server profile aren't correct.

To solve this issue, verify the correct ports are specified:

> [!NOTE]
> To manage security roles and mailbox settings, you need to sign in to your Dynamics 365 organization as a user with the "System Administrator" role.

1. In Dynamics 365, navigate to **Settings** > **Email Configuration** > **Email Server Profiles**.
2. Open the email server profile used by the mailbox that received the error.

    > [!NOTE]
    > You can also select the name of the email server profile within the error message. It appears as a hyperlink that will open the correct email server profile record.

3. Select **Advanced**.
4. Verify the **Incoming Port** and **Outgoing Port** values, and then select **Save**.

    > [!NOTE]
    > Refer to the documentation from your email provider for the correct ports to use when connecting to the SMTP service. For [Gmail](https://support.google.com/mail/answer/7104828), the incoming POP3 port is 995, and the outgoing SMTP port is 587.

5. Select **Mailboxes**, and then select the mailbox that received the error.
6. Select the **Test & Enable Mailboxes** button to test again.
7. After the test completes, open the mailbox record and [view the Alerts](/power-platform/admin/monitor-email-processing-errors#view-alerts) if the results don't appear as **Success**.
