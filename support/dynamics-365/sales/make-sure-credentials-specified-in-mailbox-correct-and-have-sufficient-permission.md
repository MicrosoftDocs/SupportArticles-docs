---
title: Make sure that the credentials specified in the mailbox are correct error when you test and enable a mailbox
description: When you test and enable a mailbox in Microsoft Dynamics 365, you may receive an error that states make sure that the credentials specified in the mailbox are correct and have sufficient permissions. Provides a resolution.
ms.reviewer:  
ms.topic: troubleshooting
ms.date: 
---
# "Make sure that the credentials specified in the mailbox are correct and have sufficient permissions" error when you test and enable a mailbox in Dynamics 365

This article provides a resolution for the error **Make sure that the credentials specified in the mailbox are correct and have sufficient permissions** that may occur when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4092797

## Symptoms

When you attempt to test and enable a mailbox in Microsoft Dynamics 365, you encounter one of the following errors:

> The email message "Your mailbox is now connected to Dynamics 365" cannot be sent. Make sure that the credentials specified in the mailbox \<Mailbox Name> are correct and have sufficient permissions for sending email. Then, enable the mailbox for email processing.  
Email Server Error Code:**  InvalidOutgoingMailboxCredentials"

> Email cannot be received for the mailbox \<Mailbox Name>. Make sure that the credentials specified in the mailbox are correct and have sufficient permissions for receiving email. Then, enable the mailbox for email processing.  
Email Server Error Code:  InvalidIncomingMailboxCredentials

## Cause

This error can occur if credentials are not provided in the mailbox record or if the credentials are not sufficient to access the corresponding mailbox.

## Resolution

1. Navigate to **Settings**, **Email Configuration**, and then select **Mailboxes**.
2. Change the view to **Active Mailboxes**.
3. Select the mailbox encountering this error and then select **Edit**.

    > [!NOTE]
    > You can also click the name of the mailbox within the error message. This appears as a hyperlink which will open the correct mailbox record.

4. Within the **Credentials** section, verify the **Allow to Use Credentials for Email Processing** is set to **Yes** and the correct **User Name** and **Password** to access the corresponding mailbox are provided.

5. Select **Save** and then select **Test & Enable Mailbox**.
6. After the tests complete, view the **Alerts** section if the results do not appear as Success.
