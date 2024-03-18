---
title: Fix NDR error 5.7.57 in Exchange Online
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six
audience: Admin
ms.topic: troubleshooting
ms.localizationpriority: medium
f1.keywords:
- CSH
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
search.appverid:
- BCS160
- MOE150
- MET150
ms.assetid: 
description: Learn how to fix email issues for error code 5.7.57 in Exchange Online (client was not authenticated to send anonymous mail during MAIL FROM).
---

# Fix NDR error "550 5.7.57" in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see error code 550 5.7.57 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How can I fix this?](#im-an-email-admin-how-do-i-fix-this)|

## Why did I get this bounce message?

When you connect to the smtp.office365.com endpoint to submit (relay) messages through Microsoft 365 or Office 365, you need to authenticate with the credentials of a user who has an Exchange Online mailbox. This bounce message indicates a problem in the configuration of the connecting application or device.

## I got this bounce message. How do I fix it?

- In the configuration of the connecting application or device, verify that the specified credentials are correct.

- Verify that the application or device is able to negotiate TLS, as TLS is required in order to authenticate. For more information, see [How to set up a multifunction device or application to send email](/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365).

## I'm an email admin. How do I fix this?

The distinction between an end user and an admin is blurred for this bounce message, as the problem lies within the configuration of the application or device.

## Still need help with error code 550 5.7.57?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
