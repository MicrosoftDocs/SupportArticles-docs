---
title: Error "Couldn't complete the call" when calling from a contact card in Teams
description: You can't make a call from a contact card in Teams if you aren't enabled for Enterprise Voice. Provides a workaround.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Clients\Windows Desktop
  - CI 172429
  - CSSTroubleshoot
ms.reviewer: greganth
appliesto:
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# "Couldn't complete the call" error when you call from a contact card

## Symptoms

In the Microsoft Teams Windows desktop client, you try to call a user in your organization by selecting the **Call** icon:::image type="icon" source="media/error-call-from-contact-card/call-icon.png"::: from their contact card. However, you receive the following error message:

> Couldn't complete the call. With your calling license, you can only call people within your organization. Talk to your IT admin to change your license.

## Cause

This issue occurs because you aren't enabled to use the Enterprise Voice feature. To initiate a call by using a contact card, the caller must be enabled for Enterprise Voice.

## Workaround

To work around this issue, use one of the following methods to make the call:

- In a one-to-one chat with the target user, select the **Audio call** icon:::image type="icon" source="media/error-call-from-contact-card/call-icon.png":::.
- Select **Calls** on the vertical toolbar, enter the user's name, select the user from the results list, and then select **Call**.
