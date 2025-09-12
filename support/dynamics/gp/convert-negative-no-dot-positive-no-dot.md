---
title: Convert a negative No. to a positive No.
description: Discusses how to add a script to an integration to convert negative numbers to positive numbers in Integration Manager for Microsoft Dynamics GP or for Microsoft Business Solutions - Great Plains.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# VBScript to convert a negative number to a positive number by using Integration Manager for Microsoft Dynamics GP

This article discusses how to add a script to an integration to convert negative numbers to positive numbers in Integration Manager for Microsoft Dynamics GP or for Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 859750

## Summary

This article discusses how to add a VBScript to a field item to convert a negative number to a positive number.

## More information

When you import data through Integration Manager for Microsoft Dynamics GP or for Microsoft Business Solutions - Great Plains, you may have to convert a number from a negative value or amount to a positive value or amount. To do it, follow these steps:

1. Start Integration Manager. To do it, follow the steps for your version of the program.

    Integration Manager for Microsoft Dynamics GP

      1. Select **Start**.
      2. Select **All Programs**.
      3. Select **Microsoft Dynamics**.
      4. Select **Integration Manager**.
      5. Select **Integration Manager**.
  
    Integration Manager for Microsoft Business Solutions - Great Plains 8.0

      1. Select **Start**.
      2. Select **All Programs**.
      3. Select **Microsoft Business Solution 8.0**.
      4. Select **Integration Manager** (the folder).
      5. Select **Integration Manager** (the shortcut).

2. Open the integration to which you want to add the script. To do it, follow these steps:

    1. Select **Open Integration** on the toolbar.
    2. On the list, select the integration that you want.
    3. Select **Open**.

3. Add the script to the **Integration** field. To do it, follow these steps:
    1. Select **Mapping** on the toolbar.
    2. Select the folder or the cube that has the field that you want to add the script.
    3. Locate the field that you want to add the script.
    4. In the **Rule** column, select the list, and then select **Use Script**.
    5. Open the Script Editor window. To do it, locate the **Value** column in the lower-left corner of the **Integration Mapping** window. Then, select the ellipsis button.
    6. Copy the following script into the Script Editor window.

        ```vb
        'Converts a value from a negative to positive
        DIM Variable
        Variable = Abs(SourceFields("Queryname.Columnname"))
        CurrentField.Value = Variable
        ```

        > [!NOTE]
        >
        > - **Variable** can be defined as anything. However, it must be consistent throughout the script.
        > - Replace **Queryname** with the name of the Integration Manager Source Name from which this field is mapped.
        > - Replace **Columnname** with the name of the column that is displayed when you preview the source in Integration Manager.

    7. On the **File** menu, select **Save and Close**.
