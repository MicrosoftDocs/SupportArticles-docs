---
title: How to record metered contracts in Contract Administration
description: Describes the steps that you must follow to record metered contracts in Contract Administration in Microsoft Dynamics GP and in Microsoft Great Plains.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Receivables Management
---
# How to record metered contracts in Contract Administration in Microsoft Dynamics GP and Microsoft Great Plains

The article describes how to record metered contracts in Contract Administration in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 916998

To record metered contracts in Contract Administration, follow these steps:

1. Create a metered contract type. To do this, follow these steps:

   1. On the **Cards** menu, point to **Contract Administration**, and then select **Contract Types**.
   2. In the **Contract Type Maintenance** dialog box, type a name in the **Contract Type** box, and then select **Meters**.
   3. In the **Base** column in the **Contract Type Meters** dialog box, type a value in the box that corresponds to meter 1.

        > [!NOTE]
        > You can also type values in the boxes that correspond to meters 2 through 5. If overages apply to one or more of the five meters, type meter information in the respective boxes in the **Overage** columns, together with overage amounts in the respective boxes in the **Amount** columns.
   4. Select **Save**.

2. Select the item for which you want to calculate meter overages. To do this, follow these steps:

   1. On the **Cards** menu, point to **Service Call Management**, point to **Extensions**, and then select **Item**.
   2. In the **Item Extensions** dialog box, select the item for which you want to calculate meter overages, select the **Metered** check box, and then select **Save**.

3. Select an equipment record. To do this, follow these steps:

      1. On the **Cards** menu, point **Service Call Management**, and then select **Equipment**.
      2. In the **Equipment Maintenance** dialog box, select an equipment record for the metered item that you selected in step 2, and then select **Meter Readings**.

      3. In the **Current** column in the **Equipment Maintenance - Readings** dialog box, type a meter reading in the **Meter 1** box.

          > [!NOTE]
          > You can also type meter readings in the following boxes:
            - **Meter 2**
            - **Meter 3**
            - **Meter 4**
            - **Meter 5**
      4. Select **Post**.
      5. In the **Equipment Maintenance** dialog box, select **Save**.

4. Create a contract by using the metered contract type that you created in step 1. To do this, follow these steps:

   1. On the **Transactions** menu, point to **Contract Administration**, and then select **Contract Entry/Update**.
   2. In the **Contract Entry/Update** dialog box, type information in the following required boxes:

      - **Customer ID**
      - **Address ID**
      - **Contract Type**
   3. In the **Contract** area of the **Contract Entry/Update** dialog box, type information in the following required boxes:

      - **Length**
      - **Start**
      - **Price Book**
      - **Currency ID**
   4. In the **Billing** area of the **Contract Entry/Update** dialog box, type information in the following required boxes:

      - **Length**
      - **Bill Day**
      - **Bill To Customer**
      - **Bill To Address**
   5. In the **Contract Entry/Update** dialog box, select **New**, select the frequency in the **Frequency** list in the **Billing** area, select **Metered** in the **Liability Type** list, and then select **Contract Lines**.

      > [!NOTE]
      > Do not select **Monthly** in the **Frequency** list.

   6. When you are prompted to save your changes, select **Save**.
   7. In the **Contract Maintenance - Lines** dialog box, create a contract line for the equipment record that you selected in step 3.

      > [!NOTE]
      > Make sure that there are records in the **Monthly Price** field and in the **Extended Price** field on the contract line.

   8. Highlight the contract line, select **Meters**, and then select **Default**.

   9. Select **Save**.
   10. Close all open dialog boxes.

5. Process a meter posting. To do this, follow these steps:

   1. On the **Transactions** menu, point to **Contract Administration**, and then select **Meter Posting**.

   2. In the **Meter Posting** dialog box, enter meter readings in the following boxes for the contract that you created in step 4, and then select **Post**:
      - **Meter 1**
      - **Meter 2**
      - **Meter 3**
      - **Meter 4**
      - **Meter 5**
6. Bill the contract. To do this, follow these steps:

   1. On the **Transactions** menu, point to **Contract Administration**, and then select **Contract Billing**.

   2. In the **Contract Billing** dialog box, select the contract that you created in step 4, and then select **OK**.

      > [!NOTE]
      > Bill only the contract line price. Meter overage billing does not occur now.

7. Create a service call for the metered contract item. To do this, follow these steps:

    1. On the **Transactions** menu, point to **Service Call Management**, and then select **Service Calls**.

    2. In the **Service Call Entry/Update** dialog box, select **New**, select the equipment record that you selected in step 3, and then select **Meters**.
    3. In the **Current** column in the **Meters** dialog box, type information in the boxes that correspond to meters 1 through 5, and then select **OK**.
    4. Select **Save**, and then select **Ready Inv.** in the **Service Call Entry/Update** dialog box.

8. Bill the service call. To do this, follow these steps:

   1. On the **Transactions** menu, point to **Service Call Management**, and then select **Service Call Billing**.
   2. In the **Service Call Billing** dialog box, select the service call that you created in step 7, and then select **OK**.

      > [!NOTE]
      > The amount that is billed on the service call is for meter overages.

9. Create an invoice for the contract. To do this, follow these steps:

   1. On the **Transactions** menu, point to **Contract Administration**, and then select **Contract Billing**.
   2. In the **Contract Billing** dialog box, select the contract that you created in step 4, and then select **Invoice**.
