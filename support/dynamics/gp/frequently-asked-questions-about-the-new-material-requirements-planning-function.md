---
title: FAQ about the new Material Requirements Planning functionality
description: Lists answers to frequently asked questions about the new Material Requirements Planning functionality in Manufacturing in Microsoft Dynamics GP 10.0.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Manufacturing Series
---
# Frequently asked questions about the new Material Requirements Planning functionality in Manufacturing in Microsoft Dynamics GP

This article contains answers to frequently asked questions about the new Material Requirements Planning (MRP) functionality in Manufacturing in Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950696

**Q1:** After I upgrade to Microsoft Dynamics GP 10.0, I have many suggestions to move out or to cancel existing manufacturing orders (MOs) and purchase orders (POs). Additionally, the suggestions that are behind the MOs and POs that are being moved out are new MOs and new POs. These new MOs and new POs have dates that are earlier than the old MOs and old POs that are being moved out. Why do I have these suggestions?

**A1:** If an oversupply exists at an item/site combination, the new suggestions for moving out and for canceling manufacturing orders and purchase orders are triggered. To determine whether an oversupply situation exists, Microsoft Dynamics GP compares the Projected Available Balance (PAB) value to the Order-Up-To Level value. If the PAB value is larger than the Order-Up-To Level value, the item/site record has an oversupply. Therefore, the suggestions are triggered. To resolve this situation, increase the Order-Up-To Level quantity.

**Q2:** Why do the PAB quantities for some planned items drop below the Order Point quantity that I defined in the item/site combination?

**A2:** To maintain on-hand inventory levels for an item, MRP suggests a new order if the PAB quantity is less than the Order Point quantity and less than the Order-Up-To Level quantity. If a planned item has an Order-Up-To Level quantity that is equal to zero, and the PAB quantities of the item are more than zero, suggestions for new orders of the item may be incorrect. To resolve this situation, you can increase the Order-Up-To Level quantity.

**Q3:** Why are no orders suggested when the PAB quantities for some planned items drop to a negative quantity even though the Order-Up-To Level quantity for the item/site combination is populated?

**A3:** To resolve this problem, you can make sure that the **Multiple** field in the **Order Quantity Modifiers** section of the Item Resource Planning window is populated. Also, if the item is a buy item, and a default vendor is assigned to the site in question, you can make sure that the **Order Multiple** field in the Item Vendors Maintenance window is populated for both the item and the vendor. Additionally, you can verify that the item in question has the correct low-level code assigned. To verify this, review the manufacturing bill of materials (MFG BOM) structures of which the item is a part. Also, you can reset the low-level codes by using the MRP Low-Level Codes window.

**Q4:** What value should I assign to the Order-Up-To Level field in the Item Resource Planning Maintenance window?

**A4:** Your internal order policies determine the appropriate quantity to use for the **Order-Up-To Level** field. However, the Order-Up-To Level quantity should be as large as the total that is defined by the following formula:

Total = the Order Point quantity + (the larger quantity: A or B or C or D) + a buffer quantity

The following table describes the variables in the formula:

|Variable|The value that the variable represents|
|---|---|
|A|The Period Order quantity|
|B|The quantity in the **Minimum** field in the Item Resource Planning Maintenance window|
|C|The quantity in the **Economic Order** field in the Item Vendors Maintenance window|
|D|The quantity in the **Minimum Order** field in the Item Vendors Maintenance window|
  
> [!NOTE]
> The buffer quantity is added when a new order is placed.

**Q5:** Why do I receive the following error message when I regenerate MRP?

> [Microsoft][ODBC SQL Server Driver][SQL Server]Cannot insert the value NULL into column 'PLNNDPRCHSORDERS', table 'COMPANYID.dbo.MRP4030'; column does not allow nulls.

**A5:** This error message occurs when the **Order Multiple** field in the Item Vendors Maintenance window for a default vendor contains zero instead of a nonzero number. You only see the zero value if you query the IV00103 table. To resolve this problem, you can make sure that the **Multiple** field is populated in the **Order Quantity Modifiers** section of the Item Resource Planning window. Also, if the item is a buy item, and a default vendor is assigned to the site in question, you can make sure that the **Order Multiple** field in the Item Vendors Maintenance window is populated for both the item and the vendor.

**Q6:** I have scheduled a net change or a full MRP regeneration. However, the regeneration does not complete when the automatic regeneration is run. Why does the regeneration not finish?

**A6:** To check the cause of this issue, you can run the regeneration manually in Microsoft Dynamics GP. The automatic regeneration stops if any error messages are received. If you can complete a manual regeneration without any error messages, make sure that the SQL Server Agent service is running. The automated regeneration is an SQL job that is run by the SQL Server Agent service. If the SQL Server Agent service is not running, you cannot run the scheduled regeneration.

**Q7:** After I upgrade to Microsoft Dynamics GP 10.0, why do some nondefault sites plan differently?

**A7:** In Microsoft Dynamics GP 9.0 and in earlier versions, some planning information is read from different sources. If the item has a default site selected, some planning information is read from the Item Resource Planning record on the default site. If the item does not have a default site selected, some planning information is read from the Initial Values record. However, in Microsoft Dynamics GP 10.0, MRP relies only on replenishment method information and on the Order Policy information from each item/site record in the Item Resource Planning window. If you experience this problem, you can open the Item Resource Planning window, and then verify that each item/site record that is used to calculate MRP quantities has the correct values.

**Q8:** When should I use the new MRP Quantities Query window?

**A8:** If you used the MRP Quantity Pegging window to review certain quantities in Microsoft Dynamics GP 9.0 or earlier versions, you should use the MRP Quantities Query window in Microsoft Dynamics GP 10.0. You can save quantity queries by using the **Save\Delete Query** tab to reuse those queries later.

**Q9:** When should I use the new Pegging Inquiry window?

**A9:** In Microsoft Dynamics GP 9.0 or in earlier versions, you can use the MRP Quantity Pegging window to select a suggested order, and then to peg up to view the parent requirements or to peg down to view the effects of the order on components. In Microsoft Dynamics GP 10.0, you can use the Pegging Inquiry window for these purposes.

**Q10:** When should I use the MRP Projected Available Balance Inquiry window?

**A10:** You use the MRP Projected Available Balance window when you want detailed views of the suggestions that MRP makes. These suggestions refer to creating new orders, to moving in orders, to moving out orders, or to canceling existing orders. You can use this window to provide a what-if analysis of the projected available balance of the item. This analysis is based on accepting or rejecting the suggestions, on editing quantities, on editing dates, or on adding transactions.

**Q11:** In the MRP Projected Available Balance Inquiry window, I see a yellow triangle next to the Projected Available Balance quantity for some transactions. What does this yellow triangle mean?

**A11:** For a particular day, the yellow triangle visual cue marks the last order for which the PAB quantity is larger than the Order-Up-To Level quantity.

**Q12:** Can I save changes in the MRP Projected Available Balance Inquiry window?

**A12:** You cannot save the changes or the plan information that appears in the MRP Projected Available Balance Inquiry window.

**Q13:** Can I print the plan information that appears in the MRP Projected Available Balance Inquiry window?

**A13:** No report is available for printing the plan information. However, you can take a screenshot of the window. Then, you can print the screenshot.

**Q14:** How can I open the MRP Order Detail window?

**A14:** To open the MRP Order Detail window, use one of the following methods:

- In the MRP Quantities Query window, select any line in the scrolling part of the window, and then select the expansion button next to **Document Number**.
- In the Pegging Inquiry window, select any line in the top scrolling part of the window, and then select the expansion button next to **Document Number**. Or, select any line on the **Sources of Demand** tab or on the **Generates Demand for** tab, and then select the expansion button next to the tab labels.
- In the MRP Projected Available Balance window, select any line in the scrolling part of the window, and then select the expansion button next to **Document Number**.

**Q15:** How can I open the MRP Move Order Inquiry window?

**A15:** You can open the MRP Move Order Inquiry window from the MRP Projected Available Balance Inquiry window. In the scrolling window, the line item information icon in the **Document Number** area becomes available when you select a line for an existing manufacturing order that has a type of MOP, of MVI, of MVO, or of CAN. Then, you can select the line item information icon to open the MRP Move Order Inquiry window.
