---
title: Microsoft Dynamics GP doesn't respond
description: Provides a solution to an issue where Microsoft Dynamics GP doesn't respond when you select Submit for Approval in the Purchase Order Processing Workflow History window.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Microsoft Dynamics GP doesn't respond when you select Submit for Approval in the Purchase Order Processing Workflow History window

This article provides a solution to an issue where Microsoft Dynamics GP doesn't respond when you select **Submit for Approval** in the Purchase Order Processing Workflow History window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952226

## Symptoms

When you select **Submit for Approval** in the PO Workflow window, Microsoft Dynamics GP doesn't respond. No documents are submitted for approval at the Workflow site.

## Cause

This problem can be caused if the Workflow History wrapper is missing on the Purchase Order Entry window. The Workflow History wrapper may be missing if a form is shared. By default, the Workflow History wrapper is located on the right side of the Purchase Order Entry window.

## Resolution

To resolve this problem, follow one of these methods:

### Method 1: Use the Microsoft Dynamics GP form

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Form and Reports**.
2. In the **ID** list, select **DEFAULTUSER**, and in the **Product** list, select the appropriate product.
3. In the **Type** list, select **Window**, and then in the **Alternate/Modified Forms and Report List** area, expand the **Purchasing** node.
4. Expand the appropriate form, and then select **Microsoft Dynamics GP**.
5. Select **Save**.

### Method 2: Edit the Dynamics.exe.config file to use the alternate Purchase Order Entry form

1. Locate the Dynamics.exe.config file on the computer. By default, the Dynamics.exe.config file is in the following location:</br></br>`C:\Program Files\Microsoft Dynamics\GP`
2. Make a backup of the Dynamics.exe.config file.
3. Right-click the Dynamics.exe.config file, select **Open With**, and then select **Notepad**.
4. Edit the **Product ID** and the **Form ID** in the appropriate line.</br></br>As an example, the following line of a Dynamics.exe.config file shows the placeholder 0 in the **productID=** area, and the placeholder *xxx* in the **formid=** area:</br></br> `Workflow-POP_PO_Entry/POP_PO_Entry" productId="0" formId="xxx" windowId="1" factoryType="Microsoft.Dynamics.GP.Workflow.WorkflowFormFactory,Microsoft.Dynamics.GP.Workflow.Client`

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
