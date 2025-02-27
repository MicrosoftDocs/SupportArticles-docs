---
title: Track and Set Regarding options miss
description: Provides a solution to an issue where the Track and Set Regarding options are missing.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# Track and Set Regarding options are missing in Microsoft Dynamics 365 App for Outlook

This article provides a solution to an issue where the **Track and Set Regarding** options are missing when you're viewing an email and opening Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4462486

## Symptoms

When you're viewing an email and opening Dynamics 365 App for Outlook, the **Track and Set Regarding** options are missing.

> [!NOTE]
> If the **Track and Set Regarding** options appear but only the button icons are missing, see [Buttons such as Track and Set Regarding are missing in Dynamics 365 App for Outlook](https://support.microsoft.com/help/4464349).

## Cause

**Cause 1:** Your Dynamics 365 security role doesn't have access to the App for Outlook Dashboard.

**Cause 2:** The sitemap of the App for Outlook app module was customized and the dashboards area is no longer configured to use the App for Outlook Dashboard.

## Resolution

**Resolution 1:**

1. Access the Dynamics 365 web application as a user with the System Administrator security role.
2. Navigate to **Settings**, select **Customizations**, and then select **Customize the System**.
3. Select **Dashboard** and then select the **App for Outlook Dashboard**.
4. Select **Enable Security Roles.**  
5. Verify the option is set to **Display to everyone** and select **OK**.
6. If the option **Display to everyone** wasn't selected previously and you've now corrected it, select **Publish All Customizations.** Clear your browser cache and then close and reopen Outlook.

**Resolution 2:**

Verify the default dashboard of the App for Outlook app module is configured to use the App for Outlook Dashboard. See the [Limitations when customizing Dynamics 365 App for Outlook](/dynamics365/outlook-app/limitations-when-customizing-app-for-outlook) section of the [Deploy Dynamics 365 App for Outlook](/dynamics365/outlook-app/deploy-dynamics-365-app-for-outlook).
