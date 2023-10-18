---
title: Fail to call through a contact, account, or lead record
description: Provides a resolution for an issue where a Teams dialer call fails when you make the call by using a contact, account, or lead record in Microsoft Dynamics 365 Sales.
ms.date: 10/18/2023
ms.reviewer: asaftzuk, ilanak
author: t-ronioded
ms.author: t-ronioded
---
# Can't make a Teams dialer call through a contact, account, or lead record

This article provides a resolution for an issue where you can't make a call through a contact, account or lead record by using [Microsoft Teams dialer](/dynamics365/sales/configure-microsoft-teams-dialer) in Microsoft Dynamics 365 Sales.

## Symptoms

You can't make a call by selecting the phone call icon next to the contact, account, or lead's number when the number doesn't have a country code in Dynamics 365 Sales.

:::image type="content" source="media/fail-to-call-through-contact-account-lead/phone-call-icon.png" alt-text="Screenshot that shows the phone call icon next to the contact, account, or lead's number.":::

## Cause

This issue occurs because the **country/region code prefixing** is enabled.

## Resolution

To resolve this issue, disable the **country/region code prefixing**.

1. Select the Settings icon on the top toolbar.
  
   :::image type="content" source="media/fail-to-call-through-contact-account-lead/settings-icon.png" alt-text="Screenshot that shows the Settings icon." border="false":::

2. Select **Personalization Settings**.

   :::image type="content" source="media/fail-to-call-through-contact-account-lead/personalization-settings.png" alt-text="Screenshot that shows the Personalization Settings option.":::

3. Clear the **country/region code prefixing** checkbox.

   :::image type="content" source="media/fail-to-call-through-contact-account-lead/country-code-prefixing-on-settings.png" alt-text="Screenshot that shows the country/region code prefixing checkbox.":::
