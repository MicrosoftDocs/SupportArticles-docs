---
title: Add the Additional Information field 
description: Describes how to add the Additional Information field from the Internet Information window to the SOP Blank Invoice Form report.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# How to add the Additional Information field from the Internet Information window to the SOP Blank Invoice Form report

This article describes how to add the Additional Information field from the Internet Information window to the SOP Blank Invoice Form report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4035483

## Question

How do you add the Additional Information field from the Internet Information window to the SOP Blank Invoice Form in Report Writer for Microsoft Dynamics GP?

## Answer

> [!NOTE]
> The steps below can be applied to other Sales documents like the Picking ticket or Sales Order form as well.

A. Open Report Writer

1. Open **Report Writer** - **Microsoft Dynamics GP** > **Tools** > **Customize** > **Report Writer**
2. If asked for a Product, select **Microsoft Dynamics GP**.
3. Select Reports
4. On the **Original Reports** side, highlight **SOP Blank Invoice Form** and Insert to the right.
5. Then on the **Modified Reports** side, highlight the same report and choose **Open**.

B. Link the RM Customer MSTR table to the Sales Transaction Work table

1. In the Report Definition window, choose the **Tables** Button.
2. In the Report Table Relationships window, select **Sales Transaction Work**, and then select **New**.
3. In the Related Tables window, select **RM Customer MSTR**, and then select **OK**.
4. Select **Close**.
5. In the Report Definition window, select **Layout**.

C. Create the calculated field for the first line of the Additional Information field

1. In the Toolbox window, select **Calculated Fields**, and then select **New**.
2. In the Name field, type **Additional Information Field Line 1**.
3. In the Result Type list, select **String**, and then select **Calculated** in the Expression Type area.
4. Select the **Functions** tab, and then select **User-Defined**.
5. In the Core list, select **System**, select **RW_GetInternetText** in the Function list, and then select **Add**.
6. Select the **Constants** tab, select **String** in the Type list, type **CUS** in the Constant field, and then select **Add**.
    > [!NOTE]
    > This function also works for other fields in GP:  
    > CMP = COMPANY  
    > VEN = VENDOR  
    > CUS = CUSTOMER  
    > EMP = EMPLOYEE  
    > ITM = ITEM  
    > SLP = SALESPERSON
7. Select the **Fields** tab, select **RM Customer MSTR** under the Resources list, select **Customer Number** in the Fields list, and then select **Add**.
8. From the **Fields** tab again, select **RM Customer MSTR** under the Resources list, select **Address Code** in the Fields list, and then select **Add**.
9. Select the **Constants** tab.
10. Select **Integer** in the Type list, type **80** in the Constant field, and then select **Add**.
11. Type **1** in the Constant field, and then select **Add**.
12. Type **9** in the Constant field, and then select **Add**.

    > [!NOTE]
    > The values 80,1 and 9 refer to the following:  
    > The 80 refers to the character length of the string.  
    > The 1 refers to the first line of text  
    > The 9 refers to the field on the window  
    > 1 = Email  
    > 2 = Home Page  
    > 3 = FTP Site  
    > 4 = Image  
    > 5 = Login  
    > 6 = Password  
    > 7 = User Defined 1  
    > 8 = User Defined 2  
    > 9 = Addl Info  
    > 10 = TO address  
    > 11 = CC address  
    > 12 = BCC address

    The Calculated field should display as follows:
    **FUNCTION_SCRIPT(RW_GetInternetText"CUS"RM_Customer_MSTR.Customer NumberRM_Customer_MSTR.Address Code5019 )**
13. Select **OK**
14. Repeat steps 1 through step 13 in this section if you want to print more lines from the Additional Information field. In step 11, replace 1 with the number of another line that you want to print. For example, if you want to print the second line of the Additional Information field, type 2.

D. Add fields to the layout of the report

1. In the Toolbox window, select **Calculated Fields**, and then select **Internet Window Additional Information Field Line 1**.
2. Drag the field to the H2 section
3. Double-click **Additional Information Field Line 1**
4. In the Display Type list, select **Data**.
5. Select **OK**.

Save the modified report and set security to the modified report. (**Administration** >> **Setup** >> **System** >> **Alternate/Modified Forms and Reports**)

## More information

The above steps were taken from [How to add the "Additional Information" field from the Internet Information window to the SOP Blank Invoice Form report](https://community.dynamics.com/blogs/post/?postid=96668567-a74d-4e8e-81d4-a9fd44416446).
