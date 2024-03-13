---
title: Standard Cost isn't rolling up
description: Provides a solution to an issue where Standard Cost isn't rolling up in Manufacturing for the Rollup and Revalue process in Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Standard Cost isn't rolling up in Manufacturing for the Rollup and Revalue process in Microsoft Dynamics GP

This article provides a solution to an issue where Standard Cost isn't rolling up in Manufacturing for the Rollup and Revalue process in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4032192

## Issue

Standard Cost isn't rolling up in Manufacturing for the Rollup and Revalue process in Microsoft Dynamics GP.

## Resolution

Below are some common reasons as to why this issue may occur.

> [!NOTE]
> Before you run any scripts in this blog, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. **Missing data in the main costing tables**

    It's a large one and many times is the culprit. There are scripts you can run against your company database to populate the tables. They'll only populate if the data is missing. Click [here](https://mbs2.microsoft.com/fileexchange/?fileID=81f534d0-d6e5-46a5-926b-9e2f393fdc2f) to see the scripts.

2. **Quantity is missing**

    For the component on the Bill of Materials entry window (**Manufacturing >> Cards >> Bill of Materials**)
3. **Primary routing is missing.**

    Make sure you have a primary routing setup for the top level finished good and/or subassembly. (**Manufacturing >> Cards >> Routings >> Routing Entry**)

4. Check if the **item is set to Floor stock** by accident.

    It will cause the cost not rollup to the top level as the value will be posted to the Floor stock expense account instead of being included in the cost of the finished good.

5. **In/Out dates**

    On your item on the Bill Of Material Entry window are populated. Check to see if the item that isn't rolling up has an in/out date on the Bill Of material Entry window that is outside the rollup dates. Example. Let's say today is 4/12/2017. If you have an 'In Date' of 4/20/2017 for your component, the cost won't be included because the system won't include it until 4/20/2017.

6. **Make/Buy code** on an upper level finished good may be wrong.

    Below is an example of a finished good. Let's say you make a change to Component 1 and rollup, but nothing changes. Check the Make/Buy codes on the subassembly and the finished good to make sure it's accurate. If the make/buy field is wrong, it won't roll up. For this situation, you may need to look in the IVR10015 table (MAKEBUYCODE_I field)

    For Example:  
    Finished Good Chair item (If it's set to Buy, which is incorrect, the system won't roll up the cost of the component up into the finished good)  
    +Subassembly SEAT (Make)  
       -Component 1 - Change it, but it's not rolling up. (Buy)

7. **Setting cost to Zero**.

    If you're trying to change an item's value to $0.00, make sure the checkbox **Set to Zero** is marked in the standard cost changes window. (**Manufacturing >> Cards >> Inventory >> Standard Cost Changes**)

8. **Low-level codes** are incorrect or you've Recursive BOMS

    **The low-level codes are set incorrectly**  
    The Item Engineering Data window holds a low-level code for each component. The low-level code is the deepest level of the item in any BOM. You must run the MRP Low-Level Codes utility to determine whether the low-level codes are correct. You can run the MRP Low-Level Codes utility one of the following ways:

    - In Microsoft Dynamics GP
    - Manually by using SQL Query Analyzer or by using SQL Server Management Studio

    1. **How to run the Low-Level Codes utility in Microsoft GP**  
        1. In Microsoft Dynamics GP point to Tools on the Microsoft Dynamics GP menu, point to Utilities, point to Manufacturing, and then select MRP Low-Level Codes.
        1. In the Maximum Number of Levels for any BOM field, enter 110.
        1. Click Generate.
    1. **How to run the Low-Level Code utility in SQL Query Analyzer or in SQL Server Management Studio**

    - Run the following script against the company database in SQL Query Analyzer or in SQL Server Management Studio.
        > [!NOTE]
        > 110 represents the lowest level on your BOM. If your BOMs go deeper feel free to increase this number.

        ```sql
        execute mbomLLCUtility 110
        ```

**Recursive BOM**  
A recursive BOM is a component of itself. It can be assigned directly as a component, or it can be assigned to a subassembly that is assigned to the BOM.

1. **How to determine whether there's a recursive BOM**  

    1. Run the following statement against the company database in SQL Query Analyzer or in SQL Server Management Studio.

        ```sql
        Select * from BM010115 where CPN_I=PPN_I**  
        ```

    2. If results are returned, you have to remove the component from the BOM.
    3. To remove the recursive BOM, run the following statement against the company database in SQL Query Analyzer or in SQL Server Management Studio.

        ```sql
        Delete BM010115 where PPN_I = CPN_I
        ```

1. **How to determine whether the BOM is assigned to a subassembly that is assigned to the BOM**  
    1. Verify that the Low-Level Code utility was run.
    1. Run the following statement against the company database in SQL Query Analyzer or in SQL Server Management Studio.

        ```sql
        Select * from IVR10015 where LLC=110
        ```

    1. If records are returned, the item listed is a parent. However, somewhere in its BOM structure, the same part number exists as a component.
    1. Remove the subassembly that contains the item that is in question.
        1. On the **Cards** menu, point to **Manufacturing**, and then select **Bill of Materials**.
        1. Enter the BOM number that is returned from the script in the Item Number field.
        1. In the Tree View, expand each subassembly, and then determine what components are underneath each subassembly.
        1. Remove the subassembly that contains the item that is in question.

## More information

To see the above information with screen prints, see [Standard Costing Rollup/Revalue issues](https://community.dynamics.com/blogs/post/?postid=3004d6a9-014d-4c64-a93c-1747bebdb7fa).
