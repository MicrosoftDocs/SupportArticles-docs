---
title: Change the 1099 amount for a vendor
description: Describes how to change the 1099 amount for a vendor who wasn't marked as a 1099 vendor in the year that the transactions were posted in Payables Management in Microsoft Dynamics GP.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/31/2021
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

Follow the method for the appropriate version you're using:

### Microsoft Dynamics GP 2013 and *higher* versions

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
> *"XXXXXX is not a 1099 Vendor."*.  
> If the Vendor card is set up to not be a 1099 vendor, you would be unable to select the vendor in this window as they have no 1099 information to view.

### Microsoft Dynamics GP 2010 and *prior* versions

1. Have all users exit Microsoft Dynamics GP. (Only necessary to make sure nothing is being posted to the vendor you're working with.)
2. On the **Cards** menu, point to **Purchasing**, and select **Vendor**. Select the vendor ID you want to change. Select the **OPTIONS** button at the bottom, and select the appropriate Tax Type and 1099 Box number as needed. Select **OK** and Save the changes.
3. Next, on the **Cards** menu, point to **Purchasing**, and then select **Summary**.
4. In the **Vendor ID** list, select the appropriate vendor ID, and then select **Period**.
5. In the Vendor Period Summary window, select the right arrow button next to the **1099 Amount** field.
6. In the 1099 Details window, select **Month** or **Year** in the **Display** area.
7. In the **Year** field, type the appropriate year. If you selected **Month** in step 5, select the appropriate month in the **Month** list.
8. Type the 1099 amount in the **Amount** field for the appropriate **1099 Box**, and then select **Save**.
9. Repeat steps 6 and 7 to change the 1099 amounts for other periods or years.
10. Select **Save**, and then close the 1099 Details window.
11. In the Vendor Credit Summary window, select **Save**.

> [!NOTE]
> A tool is available that you can use to automatically update a vendor so that the vendor has the correct 1099 amounts. This tool is called the 1099 Modifier and is available as part of the Professional Services Tools Library (PSTL) package. This is a free tool, but can only be downloaded by a Partner on PartnerSource. *You must do step 2 above first to set the vendor up as a 1099 vendor, and then can use the 1099 Modifier tool* to modify records that have *already been paid* and should be 1099 records. It does not update records in work or open status. *This tool only works well if you update the vendor and then use this tool immediately*  to modify paid records. We have seen issues if you have already made the vendor be a 1099 vendor and have since processed records that are 1099 records now, so historical paid records are a mixture of some marked as 1099 records and some not.... So just be sure to verify the results if you use this tool.

For more information about the Professional Services Tools Library (PSTL), use one of the following options:

- Customers:  
    For more information about PSTL, contact your partner of record. If you don't have a partner of record, visit [Microsoft solution provider](https://www.microsoft.com/solution-providers/home) to identify a partner.

- Partners:  
    For more information about PSTL, visit [Partner Network](https://partner.microsoft.com/solutions/business-applications/dynamics-onprem).
