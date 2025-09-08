---
title: Mailbox location not determined error when testing a mailbox
description: Provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Email and Exchange Synchronization
---
# "The mailbox location could not be determined" error when testing and enabling a mailbox in Dynamics 365

This article provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4513810

## Symptoms

When you try to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Dynamics 365, the test results section shows **Failure**, and one of the following alerts is logged:

- > The mailbox location could not be determined while sending the email message "Your mailbox is now connected to Dynamics 365". Mailbox \<Mailbox Name\> didn't synchronize. The owner of the associated email server profile \<Email Server Profile Name\> has been notified.
- > The location of the mailbox \<Mailbox Name\> could not be determined while receiving email. The owner of the associated email server profile \<Email Server Profile Name\> has been notified. The system will try to receive email again later.

## Cause

The alerts can occur when connecting to Exchange on-premises and the email server profile record in Dynamics 365 is configured with the **Auto Discover Server Location** setting set to **Yes**. When this option is enabled, you don't need to provide your Exchange Web Services (EWS) URL. Instead, Dynamics 365 tries to use [Autodiscover for Exchange](/exchange/client-developer/exchange-web-services/autodiscover-for-exchange) to retrieve the correct location. If there are issues with the Autodiscover service or it isn't configured correctly, the alerts might occur.

## Resolution

To resolve this issue, you can either fix the Autodiscover issue with Exchange or change the **Auto Discover Server Location** setting to **No** and provide the EWS URL.

Follow these steps to change the **Auto Discover Server Location** setting:

1. Sign in to the Dynamics 365 web application as a user with the "System Administrator" security role.
2. Navigate to **Settings** > **Email Configuration** > **Email Server Profiles**.
3. Open your email server profile record for your Exchange on-premises configuration.
4. Change the **Auto Discover Server Location** setting to **No**.

5. Enter your EWS URL in the **Incoming Server Location** and **Outgoing Server Location** fields. For example, `https://mail.yourdomain.com/EWS/Exchange.asmx`.

6. Select **Save**.
7. [Test and enable the mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) again.
