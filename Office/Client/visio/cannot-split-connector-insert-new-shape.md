---
title: You can't split a connector to insert a new shape
description: This article provides a workaround in Visio where you can't split a connector to insert a new shape.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Visio 2010
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 03/31/2022
---
# You can't split a connector to insert a new shape in a Visio 2010 diagram

## Symptoms

Consider the following scenario:

- You have a diagram in Visio.

- The diagram contains two shapes that are tied together by using a connector.

- You try to insert a new shape between the existing two shapes.

In this scenario, the connector doesn't split to enable you to insert the new shape between the existing shapes.

> [!NOTE]
> This behavior may occur with any connector or shape in Visio.

## Cause

This behavior may occur because one of the following:

- The **ShapeSplittable** property of the connector is set to **0**.
- The **ShapeSplit** property of the new shape is set to **0**.

## Workaround

To work around this behavior, change the **ShapeSplittable** property of the connector to **1**.

To do the following steps:

1. Select the connector between the shapes where you want to add a new shape.
2. Select the **Developer** tab, and then select **Show ShapeSheet**.

   If the **Developer** tab isn't displayed, select the **File** tab, select **Options**, select **Advanced**, scroll to the bottom, select to select the **Run in developer mode** check box, and then select **OK**.

3. Locate the **ShapeSplittable** property in the **Shape Layout** section, and then change the setting to **1**.
4. Close the ShapeSheet.

If the **ShapeSplittable** property of the connector is already set to **1**, or if the new shape still does not split the connector, change the **ShapeSplit** property of the new shape to **1**.

To do this only for the shape that you want to use to split the connector, follow these steps:

1. Select the shape.
2. Select the **Developer** tab, and then select **Show ShapeSheet**.
3. Locate the **ShapeSplit** property in the **Shape Layout** section, and then change the setting to **1**.
4. Close the ShapeSheet.

   To do this for all shapes of the same type as the shape that you want to use to split the connector, follow these steps:

   1. Make sure that at least one shape of the type exists in the diagram.
   2. Select the **Developer** tab, and then check **Document Stencil**.
   3. In the Shapes window of the document stencil, right-select the appropriate shape, select **Edit Master**, and then select **Edit Master Shape**.
   4. In the new window that opens (The new window only displays the master shape that is being edited), select the **Developer** tab, and then select **Show ShapeSheet**.

5. Locate the **ShapeSplit** property in the **Shape Layout** section, and then change the setting to **1**.
6. Close the ShapeSheet.
7. Close the new window that opened in step 4, and then save the changes.
8. Close the document stencil. Select the **Developer** tab, and then select **Document Stencil** to clear that selection.

## More information

The splitting of shapes and connectors can be disabled. Additionally, splitting of shapes and connectors can be disabled on a page or can be disabled in Visio.

Various built-in stencils have the **Shape Split** feature enabled. However, other stencils have the **Shape Split** feature disabled. Whether the feature is enabled depends on the typical usage of the template.

- Examples of shapes for which the splitting feature is disabled:

  - Server Shapes
  - UML Shapes
  - Database Modeling Shapes
  - Network Rack Shapes

- Examples of shapes for which the splitting feature is enabled:

  - Flowchart Shapes
  - Fault Tree Analysis Shapes
  - EPC Diagram Shapes
