---
title: Error "Couldn't complete the call" when calling from a contact card
description: You can't make a call from a contact card in Teams if you aren't enabled for Enterprise Voice. Provides a workaround.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 172429
  - CSSTroubleshoot
ms.reviewer: greganth
appliesto:
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 2/16/2023
---
# Error "Couldn't complete the call" when you call a user from the contact card

## Symptoms

In the Microsoft Teams Windows desktop client, you try to call a user in your organization by selecting the **Call** icon:::image type="icon" source="media/error-call-from-contact-card/call-icon.png"::: from their contact card. However, you receive the following error message:

> Couldn't complete the call. With your calling license, you can only call people within your organization. Talk to your IT admin to change your license.

## Cause

This issue occurs because you aren't enabled to use the Enterprise Voice feature. To initiate a call from a contact card, the caller must be enabled for Enterprise Voice.

## Workaround

To work around this issue, use one of the following ways to call the user:

- In a 1:1 chat with the user, select the **Audio call** icon:::image type="icon" source="media/error-call-from-contact-card/call-icon.png":::.
- Select **Calls** from the vertical toolbar, enter the user's name, select the user from the results displayed, and then select **Call**.
