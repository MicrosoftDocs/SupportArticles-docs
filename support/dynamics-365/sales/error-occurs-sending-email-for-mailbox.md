---
title: Error occurs in sending email for mailbox
description: Provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# An error occurred in sending email for mailbox error appears when testing and enabling a mailbox in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4092737

## Symptoms

When you attempt to test and enable a mailbox in Microsoft Dynamics 365, you receive following error:

> "An error occurred in sending email for mailbox "Your mailbox is now connected to Dynamics 365" while connecting to the email server. The owner of the associated email server profile \<Mailbox Name> has been notified. The system will try to send email again later.  
**Email Server Error Code:**  Web server returned ConnectFailure exception."

## Cause

This error can occur if Dynamics 365 is unable to connect to your email server.

If you're using Dynamics 365 Online with Exchange on-premises, it can occur if your firewall doesn't allow communication from Dynamics 365 online.

If you're using an SMTP/POP3 provider such as Gmail, it can occur if the port values within the Advanced section of the email server profile aren't correct.

## Resolution

**Dynamics 365 Online with Exchange on-premises**  
Verify your firewall allows communication from Dynamics 365 online. For a list of the IP address ranges that may be used by Dynamics 365, see [Microsoft Dynamics CRM Online IP Address Ranges](https://support.microsoft.com/help/2728473).

**POP3/SMTP Providers such as Gmail**  
Verify the correct ports are specified:

1. Navigate to **Settings**, **Email Configuration**, and then select **Email Server Profiles**.
2. Open the Email Server Profile that is used by the mailbox meeting this error.

    > [!NOTE]
    > You can also select the name of the Email Server Profile within the error message. It appears as a hyperlink which will open the correct Email Server Profile record.

3. Select **Advanced**.
4. Verify the **Incoming Port** and **Outgoing Port** values, and then select **Save**.

    > [!NOTE]
    > Refer to the documentation from your email provider for the correct ports to use when connecting to the SMTP service. For [Gmail](https://support.google.com/mail/answer/7104828), the incoming POP3 port is 995 and outgoing SMTP port is 587.

5. Select **Mailboxes** and then select the mailbox that received the error.
6. Select the **Test & Enable Mailboxes** button.
7. After the tests complete, open the mailbox record and view the **Alerts** section if the results don't appear as Success.
