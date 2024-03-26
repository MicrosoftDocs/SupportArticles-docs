---
title: Error code 6031 when buying licenses in Microsoft 365 portal
description: Fixes an issue in which you receive an error that we can't process your request when you try to buy licenses in the Microsoft 365 portal.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: v-six
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# "Sorry! We can't process your request right now" error code 6031 message when you buy licenses

## Symptoms

When you try to buy licenses in the Microsoft 365 portal, you receive the following error message:

> Sorry! We can't process your request right now Support Information error code 6031

## Cause

This issue occurs if you enter an invalid value-added tax identification number (VAT ID).

## Resolution

To resolve this issue, make sure that there are no spaces in the VAT ID as follows:

1. Sign in to the [Microsoft 365 portal](https://www.office.com) or the [Microsoft Intune account portal](https://go.microsoft.com/fwlink/?linkid=2090973) as a Billing or Global administrator.
1. On the **Admin Overview** page, select **Manage** in the left navigation pane.
1. On the **Billing and Subscription Management** page, select the subscription to view the VAT ID.
1. Make sure that there are no spaces in the VAT ID.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
