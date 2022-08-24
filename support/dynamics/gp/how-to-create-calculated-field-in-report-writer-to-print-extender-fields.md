---
title: How to create a calculated field to print Extender fields
description: This article describes how to use the rw_TableHeaderString user-defined function to print Extender fields in Microsoft Dynamics GP reports.
ms.reviewer: dlanglie, kvogel
ms.topic: how-to
ms.date: 04/22/2021
---
# How to create a calculated field in Report Writer to print Extender fields in Microsoft Dynamics GP reports

This article describes how to create a calculated field in Report Writer in Microsoft Dynamics GP so that you can print Extender Window fields in Microsoft Dynamics GP reports. The calculated field that you create will use the rw_TableHeaderString user-defined function to print the Extender fields on the Microsoft Dynamics GP reports.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 935385

> [!NOTE]
> Extender Detail Windows, Extender Forms, and Extender Detail Forms cannot be added to Report Writer reports.

In Report Writer, create a calculated field for the report that you want to modify. Use "string" as the result type. To add the **rw_TableHeaderString** function, follow these steps:

1. Select the **Functions** tab.
2. In the **Functions** list, select **User-Defined**.
3. In the **Core** list, select **System**.
4. In the **Function** list, select **rw_TableHeaderString**, and then select **Add**.

The **rw_TableHeaderString** function:

```console
function returns string sData;

in integer dict_id;{Dictionary ID}
in string report_name;{Report Name}
in string sNumber;{control field}
in integer sType;{control field}
in integer iControl;{which piece of data to return}
```

This function returns a string value for the selected Extender Window field to the calculated field. Specify the following values for the **rw_TableHeaderString** function.

- **Parameter 1**: 3107 for the Extender product

  This value is the dictionary ID of the third-party product. The third-party product should validate the `dict_id` parameter against its own dictionary ID. Then, the third-party product will close if the function does not correspond to this product

- **Parameter 2**: The Extender Window ID

  This value is the name of the report from which this function was called. This parameter may not be used in all situations. The report name is passed to the function if it is required.

  > [!NOTE]
  > This string value must be the same as the **Extender ID** value. Otherwise, the field will not print.

- **Parameter 3**: The key that you use in the Extender window

This value is a string that is part of the control field.

  > [!NOTE]
  > If the Extender window uses multiple keys, we recommend that you create a separate calculated field to perform the following actions:
  >
  > - Convert any keys that are not already strings to strings.
  > - Concatenate the values that are in the Extender key fields.

- **Parameter 4**: 0 (zero) for the Extender product

  This value is an integer that represents the field type of the control field. The value is always 0 for the Extender product

- **Parameter 5**: The field number of the Extender field that you want to print

  This value is an integer that is used to determine which piece of data to return.
  
  > [!NOTE]
  > If you want the third Extender field to print, this value must be 3.
  
For more information about how to create an Extender calculated field, see [How to modify the SOP Blank Order Form report from an Extender window](https://support.microsoft.com/topic/how-to-modify-the-sop-blank-order-form-report-from-an-extender-window-cb153f08-178b-0f5f-62b0-29daaddff9f5)

If you have to find the field type for parameter 4, follow these steps:

1. In Microsoft Dynamics GP, select **Tools**, select **Resource Descriptions**, and then select **Fields**.
2. In the **Product** list, select **Microsoft Dynamics GP**. In the **Series** list, select the series that you are using.
3. Select the field that you must have for the Extender key, and then select the **Field Info** button.
4. In the **Control Type** column, select the field type that you want to use.

   For example, the value for the **Line Item Sequence** field in the **Sales** series is a long integer. Therefore, you must use the **LNG_STR** function to convert this field to a string.

The new calculated field must not contain extra spaces. Use the **STRIP** function in the calculated field to remove any extra spaces. Use the CAT operator to concatenate the values that are in the fields.

To see what the output should be, view the **PT_UD_Key** column in the EXT00100 table. The EXT00100 table shows the values of the Extender key fields concatenated in alphabetical order.
