---
title: Create calculated fields
description: Describes how to create calculated fields so that you can filter Payables Management documents into aging buckets according to the document date.
ms.reviewer: theley, LMuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to create calculated fields so that you can filter Payables Management documents into aging buckets according to the document date in Microsoft Dynamics GP

This article describes how to create calculated fields so that you can filter Payables Management documents into aging buckets according to the document date.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 943032

## Introduction

In Microsoft Dynamics GP, you can create calculated fields to filter Payables Management documents into aging buckets according to the document date. This article describes how to do this procedure.

## More information

You may want to filter Payables Management documents into aging buckets by using the date on which the document was created. To do it, you can create calculated fields to filter documents into aging buckets according to the document date. To do this procedure, follow these steps:

1. Use the appropriate step:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **SmartList Builder**, and then select **SmartList Builder**.

    - In Microsoft Dynamics GP 9.0, point to **SmartList Builder** on the **Tools** menu, and then select **SmartList Builder**.

2. In the SmartList Builder window, type an ID in the **SmartList ID** field, type a name in the **SmartList Name** field, and then type an item name in the **Item Name** field.

    > [!NOTE]
    > The SmartList name and the item name will be displayed in the SmartList window when you open the SmartList window.

3. In Microsoft Dynamics GP 10.0, select **Purchasing** in the **Series** list.

    > [!NOTE]
    > This step isn't required in Microsoft Dynamics GP 9.0.
4. Select the plus sign in the **Tables** area, and then select **Microsoft Dynamics GP Table**.
5. In the Add Table window, specify the following settings:

    - **Product**: **Microsoft Dynamics GP**  
    - **Series**: **Purchasing**  
    - **Table**: **PM Transaction Open File**
6. Select **Save**, and then select **Calculations**.
7. In the Calculated Fields window, select the plus sign in the **Calculated Fields** area.

8. In the Add Calculated Field window, type the name of the calculated field in the **Fields Name** field. For example, type **Days Old**.

9. In the **Field Type** list, select **Integer**.
10. In the **Calculation** box, type the following statement. Or, copy the following statement, and then paste the statement into the **Calculation** box.

    ```vb
    DATEDIFF ( day , {PM Transaction OPEN File:Document Date} , GETDATE())
    ```

11. Select **Save**.

12. In the Calculated Fields window, select the plus sign in the **Calculated Fields** area.

13. In the Add Calculated Field window, type the name of the calculated field in the **Fields Name** field. For example, type **Aging Bucket**.

14. In the **Field Type** list, select **String**.
15. In the **Calculation** box, type the following statement. Or, copy the following statement, and then paste the statement in the **Calculation** box.

    ```vb
    CASE 
    WHEN DATEDIFF ( day , {PM Transaction OPEN File:Document Date} , GETDATE()) < '31' THEN 'CURRENT'
    WHEN DATEDIFF ( day , {PM Transaction OPEN File:Document Date} , GETDATE()) < '61' THEN '31 to 60'
    WHEN DATEDIFF ( day , {PM Transaction OPEN File:Document Date} , GETDATE()) < '91' THEN '61 to 90'
    WHEN DATEDIFF ( day , {PM Transaction OPEN File:Document Date} , GETDATE()) < '9999' THEN 'OVER 90 days'
    
    ELSE 'other'
    END 
    ```

    > [!NOTE]
    > Microsoft Dynamics GP uses this statement to filter the documents into the aging buckets according to the document date, as follows:
    >
    > - If the document was created in the last 30 days, the document is filtered into the Current aging bucket.
    > - If the document was created in the period from 31 days ago to 60 days ago, the document is filtered into the "31 to 60" aging bucket.
    > - If the document was created in the period from 61 days ago to 90 days ago, the document is filtered into the "61 to 90" aging bucket.
    > - If the document was created more than 90 days ago, the document is filtered into the "Over 90 days" aging bucket.

    If you want to use buckets that have different aging criteria, modify the statement correctly.
16. Select **Save**.

17. Select **OK**.

18. Select **Calculated Fields**, and then select the **Default** check box for each calculated field that you created in steps 7 through 16.

19. Select **PM Transaction Open File**, and then select the **Default** check box for each column that you want to be displayed in the default SmartList object.

20. Select **Save**.
21. To open the SmartList window, use the appropriate step:

    - In Microsoft Dynamics GP 10.0, select **SmartList** on the **Microsoft Dynamics GP** menu.
    - In Microsoft Dynamics GP 9.0, select **SmartList** on the **View** menu.

    When you're prompted to make changes, select **Yes**.

    > [!NOTE]
    > If another user wants to view the SmartList object that you created in Microsoft Dynamics GP 9.0, you must grant security permissions to the user. To do it, follow these steps:

      1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **SmartList Security**.

      2. Type a system password if you're prompted to type a system password.

      3. If you want to grant the security permissions to a user, select **User Security**. If you want to grant the security permissions to a user class, select **User Class Security**.

      4. Enter the values in the following fields:

         - **Company**  
         - **User ID**  
         - **User Name**  
      5. Select the check box for the SmartList object that you created.

      6. Select **OK**.

22. Use the appropriate step:

    - In Microsoft Dynamics GP 10.0, expand **Purchasing**, and then select the SmartList object that you created.
    - In Microsoft Dynamics GP 9.0, select the SmartList object that you created.

    You can now see the calculated fields that you created in the SmartList object.
