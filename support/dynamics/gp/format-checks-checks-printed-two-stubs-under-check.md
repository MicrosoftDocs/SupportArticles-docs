---
title: Checks are printed with two stubs under the check
description: This article describes how to format checks so that the checks are printed with two stubs under the check in Payables Management for Microsoft Dynamics GP and for Microsoft Business Solutions - Great Plains.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Financial - Payables Management
---
# Format checks so that the checks are printed with two stubs under the check in Payables Management for Microsoft Dynamics GP

This article describes how to format checks so that the checks are printed with two stubs under the check in Payables Management for Microsoft Dynamics GP and for Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864284

## Introduction

This article describes how to format checks so that the checks are printed with two stubs under the check in Payables Management for Microsoft Dynamics GP and for Microsoft Business Solutions - Great Plains.

## More information

1. Use the appropriate method:

   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**.
   - In Microsoft Dynamics GP 9.0 and earlier versions, point to **Customize** on the **Tools** menu, and then click **Report Writer**.

2. Use the appropriate method:

   - In Microsoft Dynamics GP, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.
   - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Product** list, and then click **OK**.

3. Click **Reports**.
4. In the **Original Reports** area, click **Check with Stub on Top and Bottom - Graphical**, and then click **Insert**.
5. In the **Modified Reports** area, click **Check with Stub on Top and Bottom - Graphical**, and then click **Open**.
6. Click **Layout**.
7. Drag the **PH** section to make it larger. Make sure that the size of the page header is 324. The size is displayed in the lower-left corner of the Toolbox window when you click the page header.
8. Move the following fields from the **F2** section to the **PH** section:

   - **Vendor Check Name**  
   - **Vendor Address Line 1**  
   - **Vendor Address Line 2**  
   - **Vendor Address Line 3**  
   - **Calc Date**  
   - **Check Total**  
   - **Calc String 1**  
   - **Calc String 2**  
   - **Calc String 3**

9. Double-click each address field that you moved to the **PH** section, and then change the address data type from **Last Occurrence** to **Data**.
10. Move the following fields from the top of the **PH** section to the bottom of the **PH** section:

    - **Vendor ID**  
    - **Vendor Check Name**  
    - **Payment Number**  
    - **Document Date**

11. Make sure that the size of the **F2** section is 60. The size is displayed in the lower-left corner in the Toolbox window when you click the **F2** section. Make sure that the **F2** section contains the following fields:

    - **Vendor ID**  
    - **Vendor Check Name**  
    - **Payment Number**  
    - **Check Date**

    For more information, see [Payables Check field sizes in Report Writer for Microsoft Dynamics GP](https://support.microsoft.com/help/856504).

    > [!NOTE]
    > By default, when you change field sizes in the check, the size moves 12 pixels at a time. If you have to move 1 pixel at a time, click the **Layout** menu, and then make sure that there is no check mark next to **Grid**. This lets you move one pixel at a time.

12. Follow the appropriate step:

    - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** on the **File** menu.

    - In Microsoft Business Solutions - Great Plains 8.0, click **Microsoft Business Solutions - Great Plains** on the **File** menu.

13. When you are prompted to save the changes, click **Save**.
14. Assign security permissions to the modified report. To do this, use one of the following methods.

### Method 1: Use security in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.

2. In the **ID** box, type the Alternative/Modified Forms and Reports ID that is associated with the user ID that will print this modified report.

3. In the **Product** list, click **Microsoft Dynamics GP**.

4. In the **Type** list, click **Reports**.

5. Expand **Purchasing**.

6. Expand the folder for the report that you modified.

7. Click to select the **Microsoft Dynamics GP (Modified)** check box.

8. Click **Save**.

9. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**.

10. In the **User** list, click a user ID.

11. In the **Company** list, click a company.

12. In the **Alternate/Modified Forms and Reports ID** list, click the ID from step b.

### Method 2: Use the Advanced Security tool in a version that is earlier than Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.

2. If you are prompted, type the system password in the **Please Enter Password** box, and then click **OK**.

3. In the Advanced Security window, click **View**, and then click **By Alternate, Modified and Custom**.

4. Use one of the following steps, depending on which version is installed:

   - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.

   - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.

5. Expand **Reports**, expand **Purchasing**, and then expand the report that you modified.

6. Use one of the following steps, depending on which version is installed:

    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.

    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.

7. Click **Apply**, and then click **OK**.

   > [!NOTE]
   > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users in the **Users** area of the Advanced Security window. You can select additional companies in the **Company Name** area of the Advanced Security window.

### Method 3: Use the Standard Security tool in a version that is earlier than Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.

2. If you are prompted, type the system password in the **Please Enter Password** box, and then click **OK**.

3. In the **User ID** list, click the ID of the user who you want to have access to the modified report.

4. In the **Type** list, click **Modified Reports**.

5. In the **Series** list, click **Purchasing**.

6. In the **Access List** box, double-click the report that you modified, and then click **OK**.

    > [!NOTE]
    > An asterisk (*) appears next to the report name.
