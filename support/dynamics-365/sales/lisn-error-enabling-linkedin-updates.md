---
title: Data validation fails when you enable LinkedIn updates
description: Resolves an issue with data validation that occurs when you enable LinkedIn updates in Microsoft Dynamics 365 Sales. 
author: udaykirang
ms.author: udag
ms.reviewer: sagarwwal
ms.date: 10/18/2024
ms.custom: sap:LinkedIn Sales Navigator\LinkedIn Sales Navigator integration errors
---
# Data validation fails when you enable LinkedIn updates

This article provides a resolution for data validation failure when you enable LinkedIn updates in Microsoft Dynamics 365 Sales.  

## Symptoms

When you turn on the **Enable LinkedIn updates** option in the **Sales Navigator Integration Settings** dialog during [data validation](/dynamics365/linkedin/data-validation), the data validation fails or generates an unexpected error, like the following one:

> Status: Disabled, An unexpected error occured.

:::image type="content" source="media/lisn-error-enabling-linkedin-updates/lisn-update-error.png" alt-text="Screenshot of the error in enabling LinkedIn updates.":::

The issue occurs for the following reasons and should be resolved accordingly.

## Cause 1: CRM sync is disabled in LinkedIn Sales Navigator

To solve this issue, verify the following settings:

- Ensure [CRM sync](https://business.linkedin.com/sales-solutions/sales-navigator-customer-hub/resources/crm-sync-dynamics-technical-guide) is enabled in LinkedIn Sales Navigator.

  1. Sign in to LinkedIn Sales Navigator.
  1. Select **Admin** > **Admin Settings** > **CRM Settings** > **Connect to CRM**.
  1. Follow the prompts to sign in to your CRM and authorize the connection between LinkedIn Sales Navigator and your CRM.
  1. Once connected, look for the option to enable Sales Navigator to sync data back to your CRM and enable it.
  1. Make sure to save any changes you make during the setup.

- Ensure the data validation setting is enabled in LinkedIn Sales Navigator. If not, you'll see the CRM sync disabled status even though CRM sync is enabled. If you can't see the data validation setting in LinkedIn Sales Navigator, ensure you have an appropriate Sales Navigator license. For more information, see [Sales Navigator Data Validation - Overview](https://www.linkedin.com/help/sales-navigator/answer/a120992).
- If both settings are enabled, ensure you enable the **Enable LinkedIn updates** setting at least once.
- If you encounter any issues, ensure your user account has the necessary permissions and that the CRM sync feature is included in your Sales Navigator contract.

## Cause 2: Issues other than CRM sync

To solve this issue, try restarting data validation by disabling it from the **Sales Navigator Integration Settings** dialog and then enabling it again.
