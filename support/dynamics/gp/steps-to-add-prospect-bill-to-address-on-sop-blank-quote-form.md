---
title: Steps to add Prospect BILL TO address on SOP Blank Quote
description: Introduces the steps to add Prospect BILL TO address on the SOP Blank Quote form in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.date: 04/17/2025
ms.custom: sap:Distribution - Sales Order Processing
---
# Steps to add Prospect BILL TO address on the SOP Blank Quote form in Microsoft Dynamics GP

This article introduces the steps to add Prospect BILL TO address on the SOP Blank Quote form in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3091374

Prospects do not have multiple Address ID information as a regular Customer does. If you look at the Customer card, you will notice that separate fields are provided for Ship To, Bill To, and Statement To addresses. Prospects only have one main address.

Regular Customer's Bill To Addresses are pulled in from the Customer Address MSTR table. Prospects do not have records stored in this table. As such, separate calculated fields were created to make the Bill To Address 1 and Bill To Address fields print on Quote Forms. See the following calculated fields in Report Writer:

(C) Bill To Address 1  
(C) Bill To Address 2

We will need to create the following fields to make the City, State, and Zip print on the SOP Blank Quote Form:

(C) Bill To City  
(C) Bill To State  
(C) Bill To Zip

Here are steps you can try:

1. Go to Report Writer (**Tools** > **Customize** > **Report Writer**).
2. Choose Microsoft Great Plains as the product.
3. Select **Reports** on the Toolbar.
4. See if SOP Blank Quote Form is listed under the Modified Reports pane. If not, insert it from the **Original Reports** pane.
5. Select on SOP Blank Quote Form and select **Open**.
6. Select Layout in the Report Definition window.
7. Under **Toolbox**, select **Calculated fields**. You will see (C) Bill To Address 1 and (C) Bill To Address 2 listed as the first two fields.
8. Select **New**.
9. Create the following field for the City.

    Name: (C) Bill To City  
    Result Type: String  
    Expression Type: Conditional

    1. Select the Conditional Field to activate it.
    2. Select the Fields tab.

        Resources: Sales Transaction Work  
        Field: Prospect  
        - Select **Add**.

    3. Under Operators, select equals (=).

    4. Select the **Constants** tab.

        Type: Integer  
        Constant: 0  
        - Select **Add**.

    5. Select the True Case field to activate it.
    6. Select the **Fields** Tab.

        Resources: Customer Master Address File  
        Field: City  
        - Select **Add**.

    7. Select the False Case field to activate it.

    8. Select the **Fields** Tab.

        Resources: Sales Transaction Work  
        Field: City  
        - Select **Add**.

    9. Select **OK** to save the calculated field.

10. Create the following field for the State

    Name: (C) Bill To State  
    Result Type: String  
    Expression Type: Conditional

    1. Select the **Conditional** Field to activate it.
    2. Select the **Fields** tab.

        Resources: Sales Transaction Work  
        Field: Prospect  
        - Select **Add**.

    3. Under Operators, select equals (=).

    4. Select the **Constants** tab.

        Type: Integer  
        Constant: 0  
        - Select **Add**.

    5. Select the True Case field to activate it.

    6. Select the **Fields** Tab.

        Resources: Customer Master Address File  
        Field: State  
        - Select **Add**.

    7. Select the False Case field to activate it.

    8. Select the **Fields** Tab.

        Resources: Sales Transaction Work  
        Field: State  
        - Select **Add**.

    9. Select **OK** to save the calculated field.

11. Create the following field for the Zip Code

    Name: (C) Bill To State  
    Result Type: String  
    Expression Type: Conditional

    1. Select the Conditional Field to activate it.

    2. Select the **Fields** tab.

        Resources: Sales Transaction Work  
        Field: Prospect
        - Select Add.

    3. Under Operators, select equals (=).

    4. Select the **Constants** tab.

        Type: Integer  
        Constant: 0
        - Select **Add**.

    5. Select the True Case field to activate it.
    6. Select the **Fields** Tab.

        Resources: Customer Master Address File  
        Field: Zip
        - Select **Add**.

    7. Select the False Case field to activate it.

    8. Select the **Fields** Tab.

        Resources: Sales Transaction Work  
        Field: Zip Code
        - Select **Add**.

    9. Select **OK** to save the calculated field.

12. Modify the following fields:

    Bill To Address Line 1  
    Bill To Address Line 2  
    Bill To Address Line 3

    1. Under **Toolbox**, select Calculated fields.
    2. Select on Bill To Address Line 1 and select **Open**.
    3. Scroll to the left of the Calculated field until to see **RM_Customer_MSTR_ADDR.City**.
    4. Select on RM_Customer_MSTR_ADDR.City and select **Remove**.
    5. Select on RM_Customer_MSTR_ADDR.State and select **Remove**.
    6. Select on RM_Customer_MSTR_ADDR.Zip and select **Remove**.
    7. Select the **Fields** tab.

        Resources: Calculated Fields  
        Field: (C) Bill To City
        - Select **Add**.

        Resources: Calculated Fields  
        Field: (C) Bill To State
        - Select **Add**.

        Resources: Calculated Fields  
        Field: (C) Bill To Zip
        - Select **Add**.

       The Calculated Field should read as follows:

       > FUNCTION_SCRIPT(rw_SelectAddrLine1""(C) Bill To Address 1(C) Bill To Address 2""""(C) Bill To City(C) Bill To State(C) Bill To Zip"" )

    8. Select **OK** to save the changes on the field.

        Repeat Step 12 for the following fields:

        Bill To Address Line 2  
        Bill To Address Line 3

13. Close the Layout window by select the **X** button at the upper right hand corner.
14. Choose to Save the Changes.
15. Select **OK** in the Report Definition window.
16. Log back to Dynamics GP (**File** > **Microsoft Dynamics GP**).
17. Make sure that you have access to print the modified report:

    1. Open the User Security Setup window by pointing to the Microsoft Dynamics GP menu, then point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
    2. Enter the User Id you are looking to grant access to the modified form/report to.
    3. Enter the company this security needs to be granted in.
    4. Take down the **Alternate/Modified Forms and Reports ID** that appears at the bottom of the window.
    5. Open the **Alternate/Modified Forms and Reports** window by pointing to the Microsoft Dynamics GP menu, then point to **Tools**, point to **Setup**, point to **System**, then select **Alternate/Modified Forms and Reports**.
    6. Enter in the Id obtained in step D
    7. Select Microsoft Dynamics GP as the product.
    8. Select Reports as the Type.
    9. Expand the Sales Folder.
    10. Find the SOP Blank Quote form report you are looking to grant access to in the list that populates and expand it. Make sure it is set to the one labeled (modified)

18. Print the SOP Blank Quote Form for Prospects. This should show the City, State, Zip line.
