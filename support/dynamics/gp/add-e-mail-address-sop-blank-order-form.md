---
title: Add e-mail address to SOP Blank Order Form
description: Describes how to add the customer e-mail address to the SOP Blank Order Form report or to the SOP Blank Invoice Form report in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add the customer e-mail address to the SOP Blank Order Form report or to the SOP Blank Invoice Form report in Microsoft Dynamics GP

This article describes how to add the customer e-mail address to the SOP Blank Order Form report or to the SOP Blank Invoice Form report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 874101

## Introduction

***Update**

New information: Use the **RW_GetInternetText** function in Report Writer instead. This function will pull directly from the **TO** field. The calculated field should look something like this below, pulling the Customer ID and **Statement To** address ID, with integers 30, 1 and 10 behind it. The calc field should be set to a STRING result type.  
**FUNCTION_SCRIPT(RW_GetInternetText"CUS"RM_Customer_MSTR.Customer IDRM_Customer_MSTR.Customer Address Code - Statement To30110 )**

## Prior article information: (alternate option)

To add the customer e-mail address to the SOP Blank Order Form report or to the SOP Blank Invoice Form report in Microsoft Dynamics GP, use the **RW_GetInternetInfo** Report Writer function to pull the EMAIL field from the same Internet information window as the email address is in.

- The email address used with Word Templates is stored in the **EmailToAddress** field in the Internet Addresses (SY01200) table, and you can't directly link this field to the SOP blank order form. Use the alternative solution described below.
- Use the **RW_GetInternetInfo** function that pulls the email address from the **INET1** field in the same Internet Addresses (SY01200) table.

    > [!NOTE]
    > You can copy the **EmailToAddress** field to the **INET1** field all within the same SY01200 table.
- In Dynamics GP, the email address needs to be in the **E-MAIL** field under the **INTERNET** **INFORMATION** section on the address ID (that is, middle section of the same window).  Instruct users to key the email address in the **E-MAIL** field in both sections going forward.

To add the customer e-mail address to the SOP Blank Order Form report, follow these steps.

> [!NOTE]
> These steps also apply to the SOP Blank Invoice Form report.

### Step 1: Back up the Reports.dic file

If you have modified reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:

1. Follow the appropriate step:

   In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **Edit Launch File.**

2. If you're prompted for the password, type the system password.
3. Follow the appropriate step:

    In Microsoft Dynamics GP, select **Microsoft Dynamics GP** in the Edit Launch File window.

4. Note the path that appears in the **Reports** box.
5. To close the Edit Launch File window, select **OK**.

### Step 2: Open the report

1. Follow the appropriate step:

    In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then select **Report Writer**.

1. In the **Product** list, select **Microsoft Dynamics GP**.
1. Select **Reports**.
1. In the **Original Reports** list, select **SOP Blank Order Form**, and then select **Insert**.
1. In the **Modified Reports** list, select **SOP Blank Order Form**, and then select **Open**.
1. In the Report Definition window, select **Tables**, and select the **Customer Master Address File** and select **New**. The **RM Customer MSTR** table should be listed, so select **Done** to add it. Now select **Layout**.

### Step 3: Create a calculated field

1. In the Toolbox window, select **Calculated Fields** in the list that appears on the **Layout** tab.
2. Select **New**.
3. In the Calculated Field Definition window, type email in the **Name** box.
4. In the **Result Type** list, select **String**, and then select **Calculated** in the **Expression Type** box.
5. Select the **Functions** tab, and then select **User-Defined**.
6. In the **Core** list, select **System**.
7. In the **Function** list, select **RW_GetInternetInfo**, and then select **Add**.
8. Select the **Constants** tab, and then select **String** in the **Type** list.
9. In the **Constant** field, type **CUS**, and then select **Add**.
10. Select the **Fields** tab, and then select **RM Customer MSTR** in the **Resources** list.|
11. In the **Field** list, select **Customer Number**, and then select **Add**.
12. In the **Resources** list, select **RM** **Customer MSTR** again **** in the **Field** list, select **Address Code**, and then select **Add**.
13. Select the **Constants** tab, and then select **Integer** in the **Type** list.
14. In the **Constant** field, type **1**, and then select **Add**. The Calculated Expression displays the following. Add the ending parenthesis as well.

    FUNCTION_SCRIPT(RW_GetInternetInfo"CUS"RM_Customer_MSTR.Customer NumberRM_Customer_MSTR.Address Code1)`

15. Select **OK**.

### Step 4: Add the calculated field to the report

1. In the **Toolbar** list, select **Calculated Fields**.
2. Drag **email** to the **PH** section and to the **RH** section.

### Step 5: Save the modified report

1. On the **File** menu, select **Microsoft Dynamics GP**.
2. Select **Save** when you're prompted to save the changes to the report layout.
3. Select **Save** when you're prompted to save the changes to the modified report.

### Step 6: Grant security to the report

Use security in Microsoft Dynamics GP 10.0 and greater

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the Alternate/Modified Forms and Reports ID that is associated with the user ID that will print this modified report.
3. In the **Product** list, select **Microsoft Dynamics GP**.
4. In the **Type** list, select **Reports**.
5. Expand **Sales**.
6. Expand the folder for the report that you modified.
7. Select **Microsoft Dynamics GP (Modified)**.
8. Select **Save**.
9. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
10. In the **User** list, select a user ID.
11. In the **Company** list, select a company.
12. In the **Alternate/Modified Forms and Reports ID** list, select the ID from step 2.
