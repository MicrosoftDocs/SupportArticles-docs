---
title: Error when testing and enabling a mailbox
description: Provides a solution to an error that occurs when you try to test and enable a mailbox.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# The mailbox location could not be determined error appears when testing and enabling a mailbox in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4513810

## Symptoms

When attempting to test and enable a mailbox in Dynamics 365, the results show as failure and the following error alerts appear:

> "The mailbox location could not be determined while sending the email message "Your mailbox is now connected to Dynamics 365". Mailbox [Mailbox Name] didn't synchronize. The owner of the associated email server profile [Email Server Profile Name] has been notified."

> "The location of the mailbox [Mailbox Name] could not be determined while receiving email. The owner of the associated email server profile [Email Server Profile Name] has been notified. The system will try to receive email again later."

## Cause

This error can occur when you're connecting to Exchange on-premises and the Email Server Profile record in Dynamics 365 is configured with the **Auto Discover Server Location** setting set to **Yes**. When this option is selected, you don't provide your Exchange Web Services URL. Instead, Dynamics 365 tries to use the [Autodiscover for Exchange](/exchange/client-developer/exchange-web-services/autodiscover-for-exchange) to retrieve the correct location. If there are issues with the autodiscover service or it isn't configured correctly, this error can occur.

## Resolution

Either fix the autodiscover issue with Exchange or change the **Auto Discover Server Location** setting to **No**, and provide the Exchange Web Service URL. Use the steps below to change the Auto Discover Server Location setting.

1. Access the Dynamics 365 web application as a user with the System Administrator security role.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Email Server Profiles**.
4. Open your email server profile record for your Exchange on-premises configuration.
5. Change the **Auto Discover Server Location** setting to **No.**  
6. Set the **Incoming Server Location** and **Outgoing Server Location** settings to your Exchange Web Services URL.  
    For example: `https://mail.yourdomain.com/EWS/Exchange.asmx`
7. Select **Save**.
8. Try to test and enable the mailboxes again.
