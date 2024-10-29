---
title: LinkedInSalesNavigatorControlsForUnifiedClient isn't available in the organization
description: Resolves an issue where the LinkedInSalesNavigatorControlsForUnifiedClient solution isn't available in the organization to configure LinkedIn Sales Navigator.
author: udaykirang
ms.author: udag
ms.reviewer: sagarwwal
ms.date: 10/18/2024
ms.custom: sap:LinkedIn Sales Navigator\LinkedIn Sales Navigator integration errors
---
# LinkedInSalesNavigatorControlsForUnifiedClient isn't available in the organization

This article provides a resolution for an issue where the [LinkedInSalesNavigatorControlsForUnifiedClient](/dynamics365/linkedin/install-sales-navigator#validate-the-installation) solution isn't available in the organization to configure LinkedIn Sales Navigator.

## Cause

The **LinkedInSalesNavigatorControlsForUnifiedClient** solution is available only in an organization that has LinkedIn Sales Navigator solution version 2.2.0.1 or later installed. If the LinkedIn Sales Navigator solution version is earlier than 2.2.0.1, you should manually install the **LinkedInSalesNavigatorControlsForUnifiedClient** solution.

## Resolution

To resolve this issue, delete the solutions and reinstall them.  

> [!NOTE]
> To avoid data loss, export the data from the `li_inmails`, `li_message`, and `li_pointdrivepresentationviewed` entities before deleting the solution, and restore the data when you install the LinkedIn Sales Navigator solution.

Follow these steps:  

1. [Delete the LinkedIn Sales Navigator solution](/dynamics365/sales/linkedin/uninstall-sales-navigator). Verify the dependencies before deleting the solution. If dependencies exist, contact your system administrator to remove the solutions. To remove the dependencies, follow these steps:  

    1. Go to **Advanced settings** > **Settings** > **Customizations** > **Solutions**.
    1. Select the **LinkedIn** solution, and then select **Show Dependencies**.

        :::image type="content" source="media/lisn-solution-not-available-configure-lisn/ts-solution-dependencies.png" alt-text="Screenshot of LinkedIn solution dependencies." lightbox="media/lisn-solution-not-available-configure-lisn/ts-solution-dependencies.png":::

    1. Select the **Required by** entity name, and the dependent entity opens on a page.  
    1. Select **Form Properties** and under the **Events** tab, go to the **Event Handlers** section.  
    1. Select and remove the events.  
    1. Save and publish the customization.  

1. Delete the `msdyn_LinkedInSalesNavigatorAnchor` solution.
1. [Install the LinkedIn Sales Navigator solution](/dynamics365/sales/linkedin/install-sales-navigator) again and restore the data for the entities.
