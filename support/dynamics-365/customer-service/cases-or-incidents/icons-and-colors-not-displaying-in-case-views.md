---
title: Icons and Colors Aren't Visible in Dynamics 365 Case Views
description: Resolves an issue where icons and colors aren't displayed in Dynamics 365 case views.
ms.reviewer: agarwalneha
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/18/2025
ms.custom: sap:Cases or Incidents, DFM
---
# Icons and colors aren't displayed in Dynamics 365 case views

This article addresses an issue where the default color-coded icons for options like **Priority** and **Status** aren't visible in case views after recent updates in Dynamics 365 Customer Service.

## Symptoms

When you view cases or incidents in Dynamics 365 Customer Service, you can't see the default color-coded icons for fields such as **Priority** and **Status**. This issue may occur after recent updates or modifications to the system.

## Cause

This issue could be caused due to incorrect or incomplete configuration settings related to the [Power Apps grid control and option set colors](/dynamics365/customer-service/administer/enable-case-grids).

## Resolution

To restore the missing icons and colors in Dynamics 365 case views, follow these steps:

1. Navigate to **Settings** > **Advanced Settings** within the application.
2. Select **Solutions**. The **Solutions** page appears.
3. On the **Solutions** page, select **Default Solution**.
4. Select **Switch to classic** to access the classic interface.
5. In the classic interface, go to **Entities** > **Case**.
6. On the **Case** page, find and open the **Controls** section.
7. Ensure that you are using the **Power Apps grid control** for the Case entity.
8. Verify that the **Customizer Control** field is set to the following value:

   - **MscrmControls.CustomCellControl.CustomCellControl**

   If the field isn't set to the value, update it accordingly.

9. Ensure that the **Enable OptionSet Colors** property is set to **Yes**.

### Modifying option set colors

If you need to adjust option set colors, follow these steps:

1. Select the desired option set from the field list.
2. Scroll down to the **Options** section in the pop-up window.
3. Select the option you want to modify and change the corresponding color.
4. Save your changes.

### Additional steps for active solution layers

If the issue persists, check if the **Case** entity has an active layer in its solution:

1. Navigate to **Settings** > **Customizations**, select the **Solution Layers** button for the **Case** entity.
2. Verify if an active layer is present. If an active layer exists, additional investigation or adjustments may be required.
