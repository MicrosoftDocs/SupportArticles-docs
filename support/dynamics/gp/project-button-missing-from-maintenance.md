---
title: The Project button is missing from Maintenance window
description: This article provides a resolution for the problem where the Project button is missing from the Employee Maintenance window, the Vendor Maintenance window, and the Customer Maintenance window in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The Project button is missing from the Employee Maintenance window, the Vendor Maintenance window, and the Customer Maintenance window in Microsoft Dynamics GP

This article provides a resolution for the problem where the Project button is missing from the Employee Maintenance window, the Vendor Maintenance window, and the Customer Maintenance window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 946301  

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]

## Symptoms

The **Project** button is missing from the following windows:

- Employee Maintenance
- Vendor Maintenance
- Customer Maintenance

## Resolution

To add the **Project** button to windows listed in the [Symptoms](#symptoms) section, follow one of these methods:

### By using security in Microsoft Dynamics GP 10.0

1. Set security to the windows. To do this, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, point to **User Security**, and then click **Alternate/Modified Forms and Reports**.
    2. In the **ID** list, click **DEFAULTUSER**  
    3. In the **Product** list, click **Project Accounting**.
    4. In the **Type** list, click **Windows**.
    5. Expand the following nodes:

       - **Payroll**  
       - **Employee Maintenance**  

    6. Click to select **Project Accounting**.

    7. Expand the following nodes:

       - **Purchasing**  
       - **Vendor Maintenance**  

    8. Click to select **Project Accounting**.
    9. Expand the following nodes:

       - **Sales**  
       - **Customer Maintenance**  

    10. Click to select **Project Accounting**.
    11. In the Alternate/Modified Forms and Reports window, click **Save**.

2. Associate the modified forms with an existing user ID. To do this, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**.

    2. In the User Security Setup window, click a user in the Userlist.

    3. In the **Company** list, click a company.

    4. In the **Alternate/Modified Forms and Reports ID** list, click **DEFAULTUSER ID**.

    5. Click **Save**.

    6. Close the User Security Setup window.

### By using standard security in Microsoft Dynamics GP 9.0 and Microsoft Business Solutions-Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. In the **User ID** list, click a user.
3. In the **Company** list, click a company.
4. In the **Product** list, click **Project Accounting**.
5. In the **Type** list, click **Alternate Dynamics GP Windows**.
6. In the **Series** list, click **Payroll**.
7. In the **Access** list, double-click **Employee Maintenance** to mark it with an asterisk.
8. In the **Series** list, click **Purchasing**.
9. In the **Access** list, double-click **Vendor Maintenance** to mark it with an asterisk.
10. In the **Series** list, click **Sales**.
11. In the **Access** list double-click **Customer Maintenance** to mark it with an asterisk.
12. Click **OK**.

### By using Advanced Security in Microsoft Dynamics GP 9.0 and Microsoft Business Solutions-Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.

2. Verify that the following check boxes are correctly marked:

   - User
   - Company

3. Expand the following nodes:

   - **Great Plains** or **Microsoft Dynamics GP**  
   - **Forms**  
   - **Payroll**  
   - **Employee Maintenance**  

4. Click to select **Project Accounting**.

5. Expand the following nodes:

     - **Great Plains** or **Microsoft Dynamics GP**  
     - **Forms**  
     - **Sales**  
     - **Customer Maintenance**  

6. Click to select **Project Accounting**.

7. Expand the following nodes:

    - **Great Plains** or **Microsoft Dynamics GP**  
    - **Forms**  
    - **Purchasing**  
    - **Vendor Maintenance**  

8. Click to select **Project Accounting**.
9. Click **Apply**, and then click **OK**.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
