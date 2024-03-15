---
title: Description of the variance account that is used in Bill
description: Description of the variance account that is used in Microsoft Dynamics GP Bill.
ms.reviewer: theley, lmuelle
ms.date: 03/13/2024
---
# Description of the variance account that is used in Microsoft Dynamics GP Bill

This article describes the variance account that is used in Great Plains 7.5 Bill of Materials and in Great Plains 8.0 Bill of Materials.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 890817

The variance account that appears in the Assembly Distribution Entry window is used whenever the sum of the costs of the components does not equal the cost of Finished Good. This cost comparison is made during posting.

To open the Assembly Distribution Entry window, follow these steps:

1. Select **Transactions**.
2. Point to **Inventory**, and then select **Assembly Entry**.
3. Select **Distributions**.

## More information

Because Perpetual FIFO and Perpetual LIFO always use the sum of the actual costs of the components, there is never a variance between the sum of the costs of the components and the cost of Finished Good. Therefore, the variance account that appears in the Assembly Distribution Entry window is not used.

However, there can be a variance between the sum of the costs of the components and the cost of Finished Good in the following cases:

- Periodic FIFO
- Periodic LIFO
- Average Perpetual

To test this information for the Periodic FIFO case, follow these steps:

1. Set up the following two items as Periodic FIFO in Item Maintenance:

   - Finished Good with a $10.00 standard cost
   - A component with a $12.00 standard cost
2. Open Item Maintenance. To do this, select **Cards**, point to **Inventory**, and then select **Item**.
3. Assemble one Finished Good in Assembly Entry. To open Assembly Entry, follow these steps:

   1. Select **Transactions**.

   2. Point to **Inventory**, and then select **Assembly Entry**. During posting, the following transactions occur:

      - The Finished Good inventory account is debited for $10.00.
      - The Finished Good variance account is debited for $2.00.
      - The Component Inventory account is credited for $12.00.
