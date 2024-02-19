---
title: Change the 1099 amount for a vendor
description: Describes how to change the 1099 amount for a vendor who wasn't marked as a 1099 vendor in the year that the transactions were posted in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 02/19/2024
---
# How to change the 1099 amount for a vendor who wasn't marked as a 1099 vendor in the year that the transactions were posted in Payables Management in Microsoft Dynamics GP

This article describes how to change the 1099 amount for a vendor who wasn't previously marked as a 1099 vendor.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 918536

## Introduction

Consider the following scenarios:

Transactions are posted in Microsoft Dynamics GP for a vendor who isn't marked as a 1099 vendor. However, in the year after the transactions are posted, the vendor status changes to that of a 1099 vendor.

## More information

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

New functionality was added to Microsoft Dynamics GP 2013 and higher versions that will make changing the 1099 status for a vendor easy. You can use the steps below to change the 1099 settings on the vendor and their transaction history at the select of a button, whether you're making the vendor a 1099 vendor or reversing them from being a 1099 vendor. Follow these steps for either scenario:

1. Under Microsoft Dynamics GP, select **Tools**, point to **Utilities**, point to **Purchasing**, and select **Update 1099 Information**.

2. In the *Update 1099 Information* window, select the last radio button for Vendor and 1099 Transactions. (Only this selection will work.)

3. In the FROM and TO sections, select the appropriate Method:

    **Method 1** - To change a vendor *from currently being a 1099 vendortoNOTBE a 1099 vendor*, set up the sections as follows:

    FROM  
    > Tax Type = Miscellaneous (or appropriate 1099 type the vendor had)  
    1099 Box Number = 7 (or appropriate 1099 box number the vendor had)

    TO  
    > Tax Type = Not a 1099 Vendor*  
    1099 Box Number is grayed out

    **Method 2** - To change a vendor *from currently not being a 1099 vendor to BE a 1099 vendor*, set up the sections as follows:

    FROM  
    > Tax Type = Not a 1099 Vendor*  
    1099 Box Number is grayed out

    TO  
    > Tax Type = Miscellaneous (or appropriate 1099 type as needed)  
    1099 Box Number=7 (or appropriate 1099 box number as needed)

    > [!NOTE]
    > If **Not a 1099 Vendor** isn't an option in the pick list, then you need to revisit step 2.

4. In the RANGES section, restrict to the Vendor ID and INSERT  it into the range restriction section.

5. Select **PROCESS** at the top. (This process updates the 1099 tables and the Payables Transaction tables and the Vendor card.)

6. Print the *Update 1099 Information Audit Report* to the screen and/or printer and verify the **new** and **old** values used were correct.

7. Verify Vendor setup: Navigate to **Cards**, point to **Purchasing**, and select **Vendor**. Select the Vendor ID and select **OPTIONS** button. Verify the new values for the *Tax Type* and *1099 Box* now reflect the new values used and will be used going forward. (This process changed the 1099 setup on the vendor card for you.)

8. Verify transactions: If you did Method 2 above, now navigate to **Transactions**, point to **Purchasing** and select **Edit 1099 Transaction Information**. Enter the Vendor ID and tab off (or select **Redisplay**), the vendor's transaction history should populate the bottom section of the window. Review each transaction. You can edit the Tax Type, Box number and 1099 Amount for each individual transaction as needed. If you made any changes, select **Process** at the top when you're finished so your changes update the 1099 tables used to print the 1099 form.

> [!NOTE]
> If you set the vendor to **Not a 1099 Vendor** using Method 1, you will get the message in this window:  
> *"XXXXXX is not a 1099 Vendor."* 
> If the Vendor card is set up to not be a 1099 vendor, you would be unable to select the vendor in this window as they have no 1099 information to view.

Review the more information about the [Professional Services Tools Library](/dynamics/s-e/gp/noam_pstl_delta).
