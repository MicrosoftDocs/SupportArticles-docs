---
title: Solution for configuring LinkedIn Sales Navigator is not available in the organization
description: Learn how to resolve the issue where the LinkedInSalesNavigatorControlsForUnifiedClient solution is not available in the organization to configure LinkedIn Sales Navigator.
author: udaykirang
ms.author: udag
ms.reviewer: udag
ms.topic: troubleshooting
ms.collection: 
ms.date: 10/03/2024
ms.custom: bap-template 
---

# Solution for configuring LinkedIn Sales Navigator is not available in the organization
<a name="solution-missing-configure-lsn"></a>

This article provides a resolution for the issue where the **LinkedInSalesNavigatorControlsForUnifiedClient** solution is not available in the organization to configure LinkedIn Sales Navigator.

## Symptoms

The **LinkedInSalesNavigatorControlsForUnifiedClient** solution will be available only in organizations with LinkedIn Sales Navigator solution version 2.2.0.1 and above. If LinkedIn solution version is less than 2.2.0.1, then install the **LinkedInSalesNavigatorControlsForUnifiedClient** solution manually.

## Resolution

To resolve this issue, delete the solutions and reinstall them again.  

>[!NOTE]
>Deleting and installing the solution can result in loss of data for **li_inmails**, **li_message**, and **li_pointdrivepresentationviewed** entities. Export data from these entities and restore when installed.  

Follow these steps:  

1. Delete the LinkedIn Sales Navigator solution. Before deleting the solution verify the dependencies, if exists, contact your System administrator to remove the solutions. To remove the dependencies, follow these steps:  
    1. Go to **Advanced settings** > **Customization** > **Solutions**.  
    1. Select the LinkedIn solution and then **Show Dependency**.  

        :::image type="content" source="media/ts-solution-dependencies.png" alt-text="Screenshot of LinkedIn solution dependencies.":::

    1. Select **Required by** entity name and the dependent entity opens in a page.  
    1. Select **Form Properties** and under the **Events** tab go to the **Event Handlers** section.  
    1. Select and remove the events.  
    1. Save and publish the customization.  

1. Delete the **msdyn_LinkedInSalesNavigatorAnchor** solution.
1. Install the **LinkedIn Sales Navigator** solution again and restore the data for the entities.