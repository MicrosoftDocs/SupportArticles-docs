---
title: Exclude documents that have a status of Hold from the Vendor Cash Requirements report 
description: Describes how to exclude documents that have a status of Hold from the Vendor Cash Requirements report.
ms.topic: how-to
ms.reviewer: theley, v-kennh, lmueller
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# How to exclude documents that have a status of Hold from the "Vendor Cash Requirements" report by using Report Writer in Microsoft Dynamics GP

This article describes how to exclude documents that have a status of **Hold** from the "Vendor Cash Requirements" report by using Report Writer in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 925657

## Step 1: Back up and then open the report

1. Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To locate the Reports.dic file, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.
    2. If you are prompted for the password, type the system password.
    3. Use the appropriate step:
        - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the Edit Launch File window.

        - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the Edit Launch File window.
    4. Note the path that appears in the **Reports** box.
    5. Click **OK** to close the Edit Launch File window.

2. On the **Tools** menu, point to **Customize**, and then click **Report Writer**.

3. Use the appropriate step:

   - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.
   - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Product** list, and then click **OK**.

4. In Report Writer, click **Reports**.

5. In the **Original Reports** column, click **Vendor Cash Requirements**, and then click **Insert**.

6. In the **Modified Reports** list, click **Vendor Cash Requirements**, and then click **Open**.

## Step 2: Create a new restriction

1. In the **Report Definition** window, click **Restrictions**, and then click **New**.
2. In the **Report Restriction Definition** window, type *Hold* in the **Restriction Name** field.
3. In the **Report Table** list, click **PM Transaction OPEN File**.
4. In the **Table Fields** list, click **Hold**.
5. Click **Add Field**.
6. In the **Operators** area, click the **Equality** operator button (**=**).
7. In the **Type** list, click **Integer**.
8. In the **Constant** field, type *0*.
9. Click **Add Constant**.
10. Click **OK**.
11. Close the **Report Restrictions** window.

## Step 3: Save the report

1. In the **Report Definition** window, click **OK**.

2. Use the appropriate step:

   - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** on the **File** menu.
   - In Microsoft Business Solutions - Great Plains 8.0, click **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 4: Grant security to the modified report

- Method 1: By using Advanced Security

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**. Type the system password if you are prompted.

    2. Click **View**, and then click **by Alternate, Modified and Custom**.

    3. Use the appropriate step:
       - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
       - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.

    4. Expand the following nodes:
       - **Reports**  
       - **Purchasing**  
       - **Vendor Cash Requirements**

    5. Use the appropriate step:
       - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
       - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.

    6. Click **Apply**, and then click **OK**.

        > [!NOTE]
        > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users and companies in the **Company** area and in the **User** area of the Advanced Security window.

- Method 2: By using standard Microsoft Dynamics GP security

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**. If you are prompted, type the system password.
    2. In the **User ID** list, click the user ID for the user to whom you want to grant access.
    3. In the **Type** list, click **Modified Reports**.
    4. In the **Series** list, click **Purchasing**.
    5. In the **Access List** box, double-click **Vendor Cash Requirements**, and then click **OK**.

        > [!NOTE]
        > An asterisk appears next to the report name.
