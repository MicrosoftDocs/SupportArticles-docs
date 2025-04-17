---
title: Modify the IV Item Transaction Inquiry
description: Describes how to modify the IV Item Transaction Inquiry report to improve the system performance when you print a report that is sorted by the date.
ms.reviewer: theley, marianv, Lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Distribution - Inventory
---
# How to modify the IV Item Transaction Inquiry report to improve the system performance when you print a report that is sorted by the date in Microsoft Dynamics GP

This article describes how to modify the IV Item Transaction Inquiry report to improve the system performance when you print a report that is sorted by the date in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 944103

## Introduction

To modify the IV Item Transaction Inquiry report to improve the system performance, follow these steps:

## More information

1. Start Report Writer in Microsoft Dynamics GP. To do it, follow these steps.

    1. Use the appropriate method:
        - In Microsoft Dynamics GP 10.0, select **Microsoft Dynamics GP**, point to **Tools**, point to **Customize**, and then select **Report Writer**.
        - In Microsoft Dynamics GP 9.0 or in earlier versions, select **Tools**, point to **Customize**, and then select **Report Writer**.
    1. Use the appropriate method:
        - In Microsoft Dynamics GP 10.0 or in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the **Product** list, and then select **OK**.
        - In Microsoft Business Solutions - Great Plains 8.0 or in Microsoft Business Solutions - Great Plains 7.5, select **Great Plains** in the **Product** list, and then select **OK**.

2. Open the IV Item Transaction Inquiry report. To do thitis, follow these steps:

    1. Select **Reports**.
    1. In the **Original Reports** area, select **IV Item Transaction Inquiry**, and then select **Insert**.
    1. In the **Modified Reports** area, select **IV Item Transaction Inquiry**, and then select **Open**.

3. Remove the Item Quantity Master table from the IV Item Transaction Inquiry report. To do it, follow these steps:

    1. In the Report Definition window, select **Tables**.
    1. In the Report Table Relationships window, select **Item Quantity Master**, and then select **Remove**.
    1. Select **Close**.

4. On the **File** menu, select the appropriate item:

    - In Microsoft Dynamics GP 10.0 or in Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0 or in Microsoft Business Solutions - Great Plains 7.5, select **Microsoft Business Solutions - Great Plains**.

5. Grant access to the report. To do it, use one of the following methods:

    - **Method 1: Use the Security tool in Microsoft Dynamics GP 10.0**  

        1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
        1. In the **ID** box, type the user ID of the user who will print this modified report.
        1. In the **Product** list, select **Microsoft Dynamics GP**.
        1. In the **Type** list, select **Reports**.
        1. Expand the **Inventory** folder.
        1. Expand the folder for the report that you modified.
        1. Select **Microsoft Dynamics GP (Modified)**.
        1. Select **Save**.
        1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
        1. In the **User** list, select a user ID.
        1. In the **Company** list, select a company.
        1. In the **Alternate/Modified Forms and Reports ID** list, select the ID that you used in step 5b.

    - **Method 2: Use the Advanced Security tool in Microsoft Dynamics GP 9.0 or in earlier versions**  

        1. Select **Tools**, point to **Setup**, point to **System**, and then select **Advanced Security**.
        1. If you're prompted to enter the password, type the password in the **Please Enter Password** box, and then select **OK**.
        1. Select **View**, and then select **by Alternate, Modified and Custom**.
        1. Use the appropriate step:
            - In Microsoft Business Solutions - Great Plains 8.0 or in Microsoft Business Solutions - Great Plains 7.5, expand **Great Plains**.
        1. Expand **Reports**, expand **Inventory**, and then expand **IV Item Transaction Inquiry**.
        1. Use the appropriate method:
            - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
            - In Microsoft Business Solutions - Great Plains 8.0 or in Microsoft Business Solutions - Great Plains 7.5, select **Great Plains (Modified)**.
        1. Select **Apply**, and then select **OK**.

        > [!NOTE]
        > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **User** area of the Advanced Security window. And, you can select additional companies in the **Company** area of the Advanced Security window.

    - **Method 3: Use the Standard Security tool in Microsoft Dynamics GP 9.0 or in earlier versions**  

        1. Select **Tools**, point to **Setup**, point to **System**, and then select **Security**.
        1. If you're prompted to enter the password, type the password in the **Please Enter Password** box, and then select **OK**.
        1. In the **User ID** list, select the user ID of the user to whom you want to grant access to the report.
        1. In the **Type** list, select **Modified Reports**.
        1. In the **Series** list, select **Inventory**.
        1. In the **Access List** area, double-click **IV Item Transaction Inquiry Report**, and then select **OK**. Then, an asterisk (*) appears next to the report name.

To view an example of the IV Item Transaction Inquiry report, follow these steps:

1. Download the package file to the computer that is running Microsoft Dynamics GP. The following file is available for download from the Microsoft Dynamics File Exchange Server:
    - [IVItemTransactionInquiry.zip](https://mbs2.microsoft.com/fileexchange/?fileID=0a94a53b-c233-4fe6-9280-23c600ee9cfa)

    Release Date: October 18, 2007  
    Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.

2. Use the appropriate method:
    - In Microsoft Dynamics GP 10.0, select **Microsoft Dynamics GP**, point to **Tools**, point to **Customize**, and then select **Customization Maintenance**.
    - In Microsoft Dynamics GP 9.0 or in earlier versions, select **Tools**, point to **Customize**, and then select **Customization Maintenance**.
3. In the Customization Maintenance window, select **Import**.
4. In the Import Package File window, select **Browse**.
5. In the **Please select a package file** window, select the package file that you downloaded in step 1 earlier in this section, and then select **Open**.
6. Select **OK**.
7. If you're prompted to overwrite the existing file, select **Yes**.
    > [!NOTE]
    > Make a backup of the existing report before you overwrite the existing report.

## Status

A fix is scheduled to be included with Service Pack 1 for Microsoft Dynamics GP 10.0.
