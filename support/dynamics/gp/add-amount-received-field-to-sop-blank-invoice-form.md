---
title: Add Amount Received field to SOP Blank Invoice Form and SOP Blank Order Form
description: How to add the Amount Received field to the SOP Blank Invoice Form and the SOP Blank Order Form in Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains.
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add the Amount Received field to the SOP Blank Invoice Form and the SOP Blank Order Form in Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains

This article describes how to perform the following actions in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains:

- Add the **Amount Received** field to the SOP Blank Invoice Form or the SOP Blank Order Form.
- Reduce the amount received amount from the document amount.

> [!NOTE]
> Invoices and orders must be printed in the functional currency when you follow the steps in this article.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 946281

To add the **Amount Received** field to the SOP Blank Invoice Form or the SOP Blank Order Form, and then reduce the amount received amount from the document amount, follow these steps.

## Add the Amount Received field to the SOP Blank Invoice Form or the SOP Blank Order Form

To do this, follow these steps:

1. Open Report Writer. To do this, follow the appropriate step:

    - **Microsoft Dynamics GP 2010 and GP 10.0**

        On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Customize**, and then click **Report Writer**.

2. Follow the appropriate step:

    In Microsoft Dynamics GP 2010 and in Microsoft Dynamics GP 10.0, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.

3. In Report Writer, click **Reports**.
4. In the **Original Reports** section, click to highlight **SOP Blank Invoice Form** or **SOP Blank Order Form**, and then click **Insert**.
5. Under **Modified Reports**, click to highlight **SOP Blank Invoice Form** or **SOP Blank Order Form**, and then click **Open**.
6. In the **Report Definition** window, click **Layout**.
7. Locate the **RF** section.
8. Hold down SHIFT and click to select the **Total** and **Trade Discount** text fields.
9. Move these two text fields down one line by hitting the DOWN ARROW key.
10. Hold down SHIFT and click to select the **F/O Trade Disc** and **F/O Document Amount** boxes.
11. Move these boxes down one line by hitting the DOWN ARROW key.
12. In the **Toolbox** window, click the **A** button to add a **Static Text** field.
13. Add a **Static Text** field under the **Freight** text field, and then type **Amount Received** as the name of the newly added field. To do this, follow these steps:

    1. Click the **Amount Received** static text field in the layout.
    2. On the **Tools** menu, click **Drawing Options**.
    3. Click to select the **Bold** check box in the **Font Style** area.
    4. In the **Font Size** list, click 9.
    5. Click **Clear** in the **Pattern** area, and then click **OK**.

14. Add the **Amount Received** field to the layout. To do this, follow the appropriate method:

    - Method 1: SOP Blank Order Form

        1. In the Toolbox window, click **Calculated Fields** in the list.
        2. Click **New**.
        3. Set the following values for the new calculated field:

            - **Name**: (C) Amount Received
            - **Result Type**: **Currency**
            - **Expression Type**: **Calculated**

        4. On the **Fields** tab, set the following values, and then click **Add**:

            - **Resources**: **Sales Transaction Work**
            - **Field**: **Payment Received**

        5. In the **Operators** section, click the plus sign (**+**).
        6. On the **Fields** tab, set the following values, and then click **Add**:

            - **Resources**: **Sales Transaction Work**
            - **Field**: **Deposit Received**

            The expression in the **Calculated** field should resemble the following:

            **SOP_HDR_WORK.Payment Received + SOP_HDR_WORK.Deposit Received**

        7. Click **OK**.
        8. In the Toolbox window, click **Calculated Fields** in the list.
        9. Click to select the **(C) Amount Received** field, drag it to the **RF** section of the layout, and then put it under the **Freight** field.
        10. Double-click **(C) Amount Received** in the layout to open the Report Field Options window.
        11. In the **Format Field** area, click **Sales Document Header Temp**. Continue to click until the **Calculated Fields** option is displayed.
        12. Click **(C) Curr Index** in the **Format Field** list, and then click **OK**.

    - Method 2: SOP Blank Invoice Form

        1. In the Toolbox window, click **Sales Transaction Work** in the list.
        2. Click to select the **Payment Received** field, drag it to the **RF** section of the layout, and then put it under the **Freight** field.
        3. Double-click **Payment Received** in the layout to open the Report Field Options window.
        4. In the **Format Field** area, click **Sales Document Header Temp**.
        5. Continue to click until the **Calculated Fields** option is displayed.
        6. Click **(C) Curr Index** in the **Format Field** list, and then click **OK**.

## Reduce the amount received amount from the document amount on the SOP Blank Invoice Form and the SOP Blank Order Form

1. Click to select the **F/O Document Amount** field in the **RF** section of the layout.
2. Press Delete.
3. In the **Toolbox** window, click **Calculated Fields** in the drop-down list.
4. Click **New**.
5. Set the following values for the new calculated field:

    - **Name**: (C) Document Amount
    - **Result Type**: **Currency**
    - **Expression Type**: **Calculated**

    1. On the **Fields** tab:
        - **Resources**: **Sales Transaction Work**
        - **Field**: **Document Amount**

        Then, click **Add**.

    2. In the **Operators** section, click the minus (-) sign.
    3. Follow the appropriate step:

        - For the SOP Blank Invoice Form, on the **Fields** tab:

          - **Field**: **Payment Received**  

            Then, click **Add**.

            The expression in the **Calculated** field should resemble the following:

            **SOP_HDR_WORK.Document Amount - SOP_HDR_WORK.Payment Received**  
        - For the SOP Blank Order Form, on the **Fields** tab:
          - **Field**: **(C) Amount Received**  

            Then, click **Add**.

            The expression in the **Calculated** field should resemble the following:

             **SOP_HDR_WORK.Document Amount - (C) Amount Received**  

    4. Click **OK**.

6. In the **Toolbox** window, click **Calculated Fields** in the drop-down list.
7. Click to select the **(C) Document Amount** calculated field, drag it to the **RF** section of the layout, and then put it under the **F/O Trade Disc** field.
8. Double-click **(C) Doucment Amount** in the layout to open the Report Field Options window.
9. In the **Format Field** area, click **Sales Document Header Temp**.
10. Continue to click until the **Calculated Fields** option is displayed.
11. Click **(C) Curr Index** in the **Format Field** list, and then click **OK**.
12. Close the Report Layout window.
13. Save your changes.
14. Click **OK** in the **Report Definition** window.
15. Return to Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains:

    Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 10.0:

    On the **File** menu, click **Microsoft Dynamics GP**.

## Give users access to the modified report using the security tool in Microsoft Dynamics GP 2010 and GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.
2. Select the user, select the company, select **Microsoft Dynamics GP** in the **Product** field, and then select **Report** in the **Type** field.
3. In the **Alternate/Modified Forms and Reports List** section, expand **Sales**, expand **SOP Blank Invoice Form**, and then click the **Microsoft Dynamics GP (Modified)** option.
4. Click **Save**.
5. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**.
6. In the **User** list, click a user ID.
7. In the **Company** list, click a company.
8. In the **Alternate/Modified Forms and Reports ID** list, click the ID from step b.

## References

The **Amount Received** field is the sum of the **Payment Received** and **Deposit Received** fields.
