---
title: Duplicate phone calls are created when using Sales accelerator in Dynamics 365 Sales
description: Provides a resolution for an issue where duplicate phone calls are created when you use the Sales accelerator in Microsoft Dynamics 365 Sales.
ms.date: 08/22/2023
ms.reviewer: asaftzuk, ilanak
author: t-ronioded
ms.author: ronihemed
ms.custom: sap:Teams Dialer
---
# Duplicate phone calls are created when you use Sales accelerator

This article provides a resolution for an issue where duplicate phone calls are created when you use the [Sales accelerator](/dynamics365/sales/sales-accelerator-intro) in Microsoft Dynamics 365 Sales.

## Symptoms

When you make a call from the Sales accelerator in Dynamics 365, multiple phone calls are created for the same call.

## Cause

This issue occurs because both the Sales accelerator and [Microsoft Teams dialer](/dynamics365/sales/configure-microsoft-teams-dialer) create a phone call.

## Resolution

To resolve this issue, select the **Exclude phone call activities** checkbox on the [Sequence activities](/dynamics365/sales/customize-sales-accelerator-sellers#sequence-activities) page to avoid creating a duplicate phone call activity.

:::image type="content" source="media/duplicate-phonecalls/exclude-phone-call-activities.png" alt-text="Screenshot that shows the Exclude phone call activities checkbox on the Sequence activities page of Sales accelerator settings.":::
