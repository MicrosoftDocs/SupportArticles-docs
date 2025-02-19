---
title: A Teams dialer call from a contact, account, or lead record fails
description: Provides a resolution for an issue where a Teams dialer call from a contact, account, or lead record fails in Microsoft Dynamics 365 Sales.
ms.date: 10/23/2023
ms.reviewer: asaftzuk, ilanak
author: t-ronioded
ms.author: ronihemed
---
# A Teams dialer call from a contact, account, or lead record fails

This article provides a resolution for an issue where a [Microsoft Teams dialer](/dynamics365/sales/configure-microsoft-teams-dialer) call from a contact, account, or lead record fails in Microsoft Dynamics 365 Sales.

## Symptoms

A Teams dialer call fails when you make the call by selecting the phone call icon next to a contact, account, or lead number. This issue occurs when the number doesn't have a country code in Dynamics 365 Sales.

:::image type="content" source="media/fail-to-call-through-contact-account-lead/phone-call-icon.png" alt-text="Screenshot that shows the phone call icon next to the contact, account, or lead number.":::

## Cause

This issue occurs because the **country/region code prefixing** is enabled.

## Resolution

To resolve this issue, disable the **country/region code prefixing**.

1. Select the Settings icon on the top toolbar.

   :::image type="content" source="media/fail-to-call-through-contact-account-lead/settings-icon.png" alt-text="Screenshot that shows the Settings icon.":::

2. Select **Personalization Settings**.

   :::image type="content" source="media/fail-to-call-through-contact-account-lead/personalization-settings.png" alt-text="Screenshot that shows the Personalization Settings option.":::

3. Clear the **Enable country/region code prefixing** checkbox.

   :::image type="content" source="media/fail-to-call-through-contact-account-lead/country-code-prefixing-on-settings.png" alt-text="Screenshot that shows the Enable country/region code prefixing checkbox.":::
