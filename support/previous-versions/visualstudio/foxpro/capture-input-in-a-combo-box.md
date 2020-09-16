---
title: Capture input in a combo box
description: This article describes how to input data that may not be contained in the ComboBox control drop-down list and then change a field value in a table with the value that was entered in the combo box.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: article 
ms.prod: visual-studio-family
---
# Capture input in a combo box in Visual FoxPro

This article describes how to input data that may not be contained in the ComboBox control drop-down list and then change a field value in a table with the value that was entered in the combo box.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 140652

## Summary

Visual FoxPro lets you use combo boxes in forms to select or input data within the form. Combo boxes let data be derived from the following sources:

- Value
- Alias
- SQL statements
- Queries
- Arrays
- Fields
- Files
- Structures
- Popups

This article describes how to input information that may not be contained in the ComboBox control drop-down list and then change a field value in a table with the value that is entered in the combo box.

## More information

To input data into a ComboBox control and then store it to a field in a table if the value has changed, follow these steps:

1. Create a new form, and place the following code in its Load event procedure:

    ```console
    PUBLIC ARRAY aTitle(1)
    SELECT DISTINCT(customer.contact) FROM customer ;
    INTO ARRAY aTitle
    ```  

2. Add the customer table from the `\Data` directory to the Data Environment of the form. You can find the `\Data` directory in one of the following locations:

    ```console
    Visual FoxPro 3.x: VFP\Samples\Mainsamp
    Visual FoxPro 5.x: VFP\Samples
    Visual FoxPro 6.0: \MSDN98\98VS\1033\Samples
    Visual FoxPro 7.0,8.0,9.0: \Samples\Data
    ```  

3. Place a text box on the form, and set its `ControlSource` property to:

    ```console
    Customer.Contact
    ```  

4. Place a combo box on the form. Set its `RowSource` property to **aTitle** and its `RowSourceType` property to **5-Array**.

5. In the `InteractiveChange` procedure, type the following lines of code:

    ```console
    IF Customer.Contact != Thisform.combo1.DisplayValue
        REPLACE Customer.Contact WITH Thisform.combo1.DisplayValue
        Thisform.Text1.Refresh
        SELECT DISTINCT(customer.contact) FROM customer ;
        INTO ARRAY aTitle
    ENDIF
    ```  

6. In the `LostFocus` procedure, type the following lines of code:

    ```console
    IF Customer.Contact != Thisform.combo1.DisplayValue
        REPLACE Customer.Contact WITH Thisform.combo1.DisplayValue
        Thisform.Text1.Refresh
        SELECT DISTINCT(customer.contact) FROM customer ;
        INTO ARRAY aTitle
    ENDIF
    thisform.combo1.displayvalue=""
    ```  

7. Add a command button to the form, and type the following code into its `Click` event procedure:

    ```console
    SKIP
    ThisForm.Combo1.DisplayValue=Customer.Contact
    ThisForm.Refresh
    ```  

8. Add another command button to the form, and place the following code in its `Click` event procedure:

    ```console
    SKIP -1
    ThisForm.Combo1.DisplayValue=Customer.Contact
    ThisForm.Refresh
    ```  

9. Save and run the form. Change the value in the combo box, and skip through the table using the command buttons. Close the form, and browse the **Customer** table. Look at the **Contact** field. The changes entered in the combo box will be reflected in the field.
