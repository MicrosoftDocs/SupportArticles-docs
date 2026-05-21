---
title: Teams dialer isn't visible in Dynamics 365 Sales
description: Provides a resolution for an issue where a seller can't see the Microsoft Teams dialer in Dynamics 365 Sales due to cached browsing data or the Read privilege.
ms.date: 05/21/2026
ms.reviewer: ramakris
author: t-ronioded
ms.author: ramakris
ms.custom: sap:Teams Dialer
ai-usage:
  - ai-assisted
---
# Teams dialer isn't visible in Dynamics 365 Sales

This article provides resolutions for an issue where the [Microsoft Teams dialer](/dynamics365/sales/configure-microsoft-teams-dialer) isn't visible in Microsoft Dynamics 365 Sales.

## Symptoms

A seller can't see the Microsoft Teams dialer in Dynamics 365 Sales.

> [!NOTE]
> The Microsoft Teams dialer requires that the user has a Microsoft Teams license and a phone number assigned to their account. If either is missing, the dialer won't appear. Verify these prerequisites before proceeding with the troubleshooting steps below.

## Cause 1: Cached browsing data

#### Resolution

To resolve this issue, follow the [Microsoft Teams dialer basic troubleshooting steps](dialer-basic-troubleshooting.md).

## Cause 2: Missing the Read privilege assigned to the security roles

To see the Teams dialer, the security roles that are assigned to the user should have the Read privilege for the **Teams Dialer Admin settings** entity.

The Read privilege should be granted automatically to the "Sales Manager" and "Salesperson" security roles.

#### Resolution

To solve the issue with the Read privilege, follow the mitigation steps:

1. Sign in to the [Sales Hub app](/dynamics365/sales/intro-saleshub) with an administrator account.

2. Navigate to **Settings** > **Advanced Settings**.

   :::image type="content" source="media/dialer-not-visible-in-crm/sales-hub-advanced-settings.png" alt-text="Screenshot that shows the Advanced Settings option in the Sales Hub app." lightbox="media/dialer-not-visible-in-crm/sales-hub-advanced-settings.png":::

3. Navigate to **Security** > **Security Roles**.

   :::image type="content" source="media/dialer-not-visible-in-crm/sales-hub-security.png" alt-text="Screenshot that shows the Security Roles option in the Sales Hub app." lightbox="media/dialer-not-visible-in-crm/sales-hub-security.png":::

4. Select the "Sales Manager" and "Salesperson" security roles, and then enable the Read permission for the **Teams Dialer Admin settings** entity.

   :::image type="content" source="media/dialer-not-visible-in-crm/sales-hub-security-roles.png" alt-text="Screenshot that shows the Sales Manager and Salesperson security roles." lightbox="media/dialer-not-visible-in-crm/sales-hub-security-roles.png":::

   :::image type="content" source="media/dialer-not-visible-in-crm/teams-dialer-admin-settings-priviliges.png" alt-text="Screenshot that shows how to enable the read permission for the Teams Dialer Admin settings entity." lightbox="media/dialer-not-visible-in-crm/teams-dialer-admin-settings-priviliges.png":::

## See also

- [Teams dialer isn't visible in a custom app](dialer-not-available-in-custom-app.md)
- [Microsoft Teams dialer basic troubleshooting](dialer-basic-troubleshooting.md)
