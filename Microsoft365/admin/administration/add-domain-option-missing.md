---
title: Add domain option is missing from the Microsoft 365 admin center
description: Describes an issue that prevents the "Add domain" option from being displayed on the "Manage domains" page of the Microsoft 365 admin center. Provides a resolution.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-administration
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-maqiu
appliesto:
- Office 365 User and Domain Management
---

# "Add domain" option is missing from the Microsoft 365 admin center

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## PROBLEM

The **Add domain** option is missing from the "Manage domains" page of the Microsoft 365 admin center. Therefore, you cannot add a domain to Office 365.

Additionally, if you click **Billing** and then click **Licenses**, the following message is displayed on the licenses page:

**You currently have no licenses. You can purchase a subscription or contact Support to review existing subscriptions.**

## CAUSE

This issue occurs if you don't have a subscription or license for Office 365. For example, this issue may occur if a previous attempt to purchase a subscription was canceled.

## SOLUTION

To resolve this issue, follow these steps:

1. Sign in to the Microsoft 365 admin center.
2. Click **Billing**, click **subscriptions**, select a plan, and then click **Trial** or click **Buy now**.

After you complete these steps, go back to the domains page in the Microsoft 365 admin center. The **Add domain** option should now be listed.

## MORE INFORMATION

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).