---
title: Skype for Business 2016 isn't installed in Microsoft 365 Business Premium
description: Describes an issue in which the Skype for Business client isn't installed when you switch from Microsoft 365 Small Business Premium to Microsoft 365 Business Standard. Provides a solution.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business 2016
  - Skype for Business Online
ms.date: 03/31/2022
---

# Skype for Business 2016 isn't installed when you switch from Microsoft 365 Small Business Premium to Microsoft 365 Business Standard

## Problem 

Consider the following scenario:  
 
- You had a subscription to the Microsoft 365 Business Premium (P2) plan.    
- You switch to the current Microsoft 365 Business Standard subscription and then install Microsoft Office 2016.    
 
In this scenario, Skype for Business 2016 isn't installed on your computer.  

## Solution 

To fix this issue, manually install Skype for Business 2016. To do this, follow these steps: 
 
1. Install a different version of Office. For more information about how to do this, go to the following Microsoft website:

    [Install a different version of Office on a PC after you switch Microsoft 365 plans](https://support.office.com/article/switch-office-365-plans-using-the-switch-plans-wizard-2e5ad347-a6ab-4e7a-a9df-4663fb0a09dc#bkmk_updateyourofficeinstallation)
1. Upgrade to Office 2016. For more information, see [How do I upgrade Office?](https://support.microsoft.com/office/how-do-i-upgrade-office-ee68f6cf-422f-464a-82ec-385f65391350).
1. Sign in to the Microsoft 365 admin center, and then, on the Home page, click the **Install Skype for Business** link in the **Get Skype for Business** section.

    :::image type="content" source="./media/sfb-is-not-installed-office-365/admin-center.png" alt-text="Screenshot that shows the Get Skype for Business section in the admin center.":::
  

## More information

Skype for Business 2016 must be installed separately from Office 2016 for customers who switch to Microsoft 365 Business Standard.

For more information, go to the following Microsoft website: [Get the most from Office with Microsoft 365](https://products.office.com/compare-all-microsoft-office-products?&activetab=tab:primaryr2)  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
