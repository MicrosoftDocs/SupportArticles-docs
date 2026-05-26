---
title: Microsoft Teams Dialer Not Visible in Dynamics 365 Sales
description: Learn how to troubleshoot the Microsoft Teams dialer not appearing in Dynamics 365 Sales due to cached browsing data or missing Read privileges on security roles.
ms.date: 05/21/2026
ms.reviewer: ramakris, v-shaywood
ms.custom: sap:Teams Dialer
ai-usage: ai-assisted
---
# Microsoft Teams dialer isn't visible in Dynamics 365 Sales

## Summary

This article provides resolutions for an issue where the [Microsoft Teams dialer](/dynamics365/sales/configure-microsoft-teams-dialer) isn't visible in Microsoft Dynamics 365 Sales. Cached browsing data or missing Read privileges on the security roles assigned to the seller can cause the dialer to be hidden.

## Prerequisites

The Microsoft Teams dialer requires that the user has a Microsoft Teams license and a phone number assigned to their account. If either prerequisite is missing, the dialer doesn't appear. Verify these prerequisites before you continue.

## Symptoms

A seller can't see the Microsoft Teams dialer in Dynamics 365 Sales.

## Cause

### Cached browsing data

Stale or corrupted data in the browser cache can prevent the dialer control from loading correctly, even after the dialer is configured and the user has the required licenses and security roles.

#### Solution

Follow the [Microsoft Teams dialer basic troubleshooting steps](dialer-basic-troubleshooting.md).

### Missing Read privilege on the security roles

To see the Teams dialer, the security roles that you assign to the user must have the Read privilege for the **Teams Dialer Admin settings** entity. The **Sales Manager** and **Salesperson** security roles automatically grant this privilege.

#### Solution

1. Sign in to the [Sales Hub app](/dynamics365/sales/intro-saleshub) with an administrator account.
1. Go to **Settings** > **Advanced Settings**.

   :::image type="content" source="media/dialer-not-visible-in-crm/sales-hub-advanced-settings.png" alt-text="Screenshot that shows the Advanced Settings option in the Sales Hub app." lightbox="media/dialer-not-visible-in-crm/sales-hub-advanced-settings.png":::

1. Go to **Security** > **Security Roles**.

   :::image type="content" source="media/dialer-not-visible-in-crm/sales-hub-security.png" alt-text="Screenshot that shows the Security Roles option in the Sales Hub app." lightbox="media/dialer-not-visible-in-crm/sales-hub-security.png":::

1. Select the **Sales Manager** and **Salesperson** security roles.

   :::image type="content" source="media/dialer-not-visible-in-crm/sales-hub-security-roles.png" alt-text="Screenshot that shows the Sales Manager and Salesperson security roles." lightbox="media/dialer-not-visible-in-crm/sales-hub-security-roles.png":::

1. Enable the Read permission for the **Teams Dialer Admin settings** entity.

   :::image type="content" source="media/dialer-not-visible-in-crm/teams-dialer-admin-settings-priviliges.png" alt-text="Screenshot that shows how to enable the Read permission for the Teams Dialer Admin settings entity.":::

## Related content

- [Teams dialer isn't visible in a custom app](dialer-not-available-in-custom-app.md)
- [Microsoft Teams calls with conversation intelligence](/dynamics365/sales/digital-selling-microsoft-teams-calls)
- [Security roles and privileges](/power-platform/admin/security-roles-privileges)
