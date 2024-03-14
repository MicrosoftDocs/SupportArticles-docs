---
title: Domain shows a status of Setup in progress in the Microsoft 365 portal
description: Describes a scenario in which a new domain that you add to Microsoft 365 shows a Setup in progress status. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# Domain shows a status of "Setup in progress" in the Microsoft 365 portal

## Problem

You experience one of the following problems in the Microsoft 365 portal:

- When you add a new domain to Microsoft 365, you see a status of **Setup in progress** or **Fix Issues**.   
- The status of your primary domain changes from **Active** to **Setup in progress** or **Fix Issues**.    

## Solution 

To resolve this problem, do one of the following, as appropriate for your situation.

### Standard deployment

Click **Setup in progress**, and then complete the remaining steps in the "Add a domain" wizard. This includes adding all the Domain Name System (DNS) records at your DNS hosting provider or domain registrar that are provided in step 3 of the wizard.

After step 1 of the wizard is complete, you can use the new domain in Microsoft 365. Any DNS records that you add for Microsoft 365 work correctly even if the status is displayed as Setup in progress. Consider that it may take as long as 72 hours for the DNS changes that you made to propagate across the Internet.

### Hybrid deployment

If you chose to implement a hybrid deployment for your organization, select the **Don't check this domain for incorrect DNS records** check box, as shown in the following screen shot.

:::image type="content" source="media/setup-in-progress-office-365-portal/hybrid-depolyment.png" alt-text="Screenshot to select the Don't check this domain for incorrect DNS records check box.":::

Doing this prevents the warning messages from being displayed for this domain. If you later choose not to implement a hybrid deployment, clear the **Don't check this domain for incorrect DNS records** check box.

## More information

This problem occurs if you haven't completed all the steps in the "Add a domain" wizard, if you have DNS configuration errors, or you haven't waited up to 72 hours for the DNS records to propagate.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
