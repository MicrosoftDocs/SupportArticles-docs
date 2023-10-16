---
title: Call to number without country code failed
description: Provides a resolution for an issue where call via Teams dialer failed when the number is without country code in Microsoft Dynamics 365 Sales.
ms.date: 10/16/2023
ms.reviewer: asaftzuk, ilanak
author: t-ronioded
ms.author: t-ronioded
---
# Teams dialer calling through Contact/Account/Lead fails

This article provides a resolution for an issue where call via [Microsoft Teams dialer](/dynamics365/sales/configure-microsoft-teams-dialer) fails when calling through Contact/Account/Lead in Microsoft Dynamics 365 Sales.

## Symptoms

Call via the phone call icon next to the Contact/Account/Lead's number (see the photo below) failed when the number is without country code.  
![Phone call icon](media/call-to-number-without-country-code-failed/phone-call-icon.png)

## Cause

Country/region code prefixing is enabled on the CRM platform.

## Resolution

To resolve this issue, you should disable country/region code prefixing.

1. Click the settings icon in the top toolbar ![Crm settings icon](media/call-to-number-without-country-code-failed/crm-settings-icon.png).   
2. Click on Personalization Settings:  
![Personalization Settings](media/call-to-number-without-country-code-failed/personalization-settings.png).
3. Uncheck country/region code prefixing.  ![Country code prefixing on settings](media/call-to-number-without-country-code-failed/country-code-prefixing-on-settings.png)
