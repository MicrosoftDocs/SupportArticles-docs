---
title: Print Bill to Address on a historical form
description: Provides a solution to an issue where the address that was on the original invoice form will print and not the current Customer's Bill to Address assigned to the Customer Maintenance window.
ms.reviewer: Cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Printing Bill to Address assigned to Customer Maintenance on the Historical SOP Invoice form for Microsoft Dynamics GP 2016

This article provides a solution to an issue where the address that was on the original invoice form will print and not the current Customer's Bill to Address assigned to the Customer Maintenance window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4020124

## Introduction

A customer's address may change from time to time. However, by default, when you print a historical SOP invoice in Microsoft Dynamics GP, the address that was on the original invoice form will print and not the current Customer's Bill to Address assigned to the Customer Maintenance window. The steps below will force GP to look at the Bill to address assigned to the Customer Maintenance's Bill To Address field instead of what was on the original invoice.

## Resolution

Instructions to pull the Bill to Address off the Customer Maintenance window.

1. Open Report Writer
    1. Microsoft Dynamics GP > Tools > Customize > Report Writer
    2. If asked for a Product, select Microsoft Dynamics GP
2. Select **Reports**  
3. On the Original Reports side, highlight **SOP Blank History Invoice Form** and **Insert** to the right.
4. Under **Modified Reports**, highlight **SOP Blank History Invoice Form** and select **Open**.
5. From the Report Definition window, select **Tables**.
6. In the Report Table Relationship window, highlight the **Customer Master Address File**. Select **Remove**.
7. Select **OK** to the message "Are you sure you want to remove this table and its related tables? Remove all Corresponding tables?"
8. In the Report Table Relationship window, select **Close**.
9. In the Report Definition window, select **OK**.

We'll now build a relationship between the Sales Transaction History table and the RM Customer Address table.

1. Select **Tables > Tables** at the top of the main Report Writer window.
2. Select **SOP_HDR_HIST** and select **Open**  
3. Select **Relationships** and select **New**  
4. Select **RM Customer Master** for the secondary table (click ... to select) and **OK**.
5. Select **Key 1** and match up the lines under the Relationship section and select **OK**.
    1. Customer Number = Customer Number
6. Select **OK** on the Table Relationship Definition window.
7. Select the **X** on the Table Relationship window.
8. Select **OK** on the Table Definition window.
9. Select **X** on the Tables window
10. At the Report Writer window, select the **SOP Blank History Invoice form** again and select **Open**.
11. Select **Tables** on the Report Definition window.
12. Highlight **Sales Transaction History** and select **New**  
13. Select **RM Customer Master** file and select **OK**.
14. In the Report Table Relationship window, select **Close**.
15. In the Report Definition window, select **OK**.

Next we'll create another relationship between the RM Customer Master and the Customer Master Address table.

1. Select **Tables > Tables** at the top of the main Report Writer window.
2. Select **RM_Customer_MSTR file** and select **Open**  
3. Select **Relationships** and select **New**  
4. Select **Customer Master Address** File for the secondary table
5. Select **Key 1** and match up the lines under the Relationship section:
    1. Customer Number = Customer Number
    2. Primary Bill to Address Code = Address Code
6. Select **OK** on the Table Relationship Definition window.
7. Select the **X** on the Table Relationship window.
8. Select **OK** on the Table Definition window.
9. Select **X** on the Tables window
10. At the Report Writer window, select the **SOP Blank History Invoice form** again and select **Open**.
11. Select **Tables** on the Report Definition window.
12. Select **RM Customer Master** and select **New**  
13. Select **Customer Master Address File** and select **OK**.
14. Close all the windows.
15. Select **Close and File > Microsoft Dynamics GP**  
16. Give access to the modified Report.

## More information

See [Printing Bill to Address assigned to Customer Maintenance on the Historical SOP Invoice form for Microsoft Dynamics GP 2016](https://community.dynamics.com/blogs/post/?postid=a245936f-7aac-487c-91bd-091f480996d9) for this topic.
