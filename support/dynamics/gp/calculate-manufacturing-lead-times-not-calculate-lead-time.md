---
title: Calculate Manufacturing Lead Times utility doesn't calculate the manufacturing lead time for some items in Microsoft Dynamics GP
description: Describes a problem in which the Calculate Manufacturing Lead Times utility doesn't calculate the manufacturing lead time for some items in Microsoft Dynamics. Provides a resolution.
ms.reviewer: theley, aeckman
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Manufacturing Series
---
# The "Calculate Manufacturing Lead Times" utility doesn't calculate the manufacturing lead time for some items in Microsoft Dynamics GP

This article provides a solution for the issue where the "Calculate Manufacturing Lead Times" utility doesn't calculate the manufacturing lead time.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 930054

## Symptoms

When you run the Calculate Manufacturing Lead Times utility, the utility doesn't calculate the manufacturing lead time for some items. This problem occurs if the following conditions are true:

- Microsoft Dynamics GP 9.0 or Microsoft Business Solutions - Great Plains 8.0 is installed.
- In the Item Engineering Data window, the **Treat as Either** check box is selected.
- In the **Treat Either Items as** area, the **Bought** option button is selected in the MRP Preference Defaults window.

## Resolution

To resolve this problem, follow these steps:

1. Perform one of the following steps:
    - On the **Cards** menu, point to **Manufacturing** > **Inventory**, and then click **Engineering Data**. Click to clear the **Treat as Either** check box.
    - On the **Tools** menu, point to **Setup** > **Manufacturing** > **System Defaults**, and then click **MRP**. In the **Treat Either Items as** area, click **Make**.
2. On the **Tools** menu, point to **Utilities** > **Manufacturing**, and then click **Calculate MFG Lead Times**.
3. Run the Calculate Manufacturing Lead Times utility for all items.

    > [!NOTE]
    > After you run the Calculate Manufacturing Lead Times utility, you can change the settings in step 1 to the original settings.
