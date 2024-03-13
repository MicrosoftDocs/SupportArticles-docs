---
title: Use Table Import to import data into Microsoft Dynamics GP
description: Provides guidelines to perform a successful data import in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains by using the Table Import tool.
ms.reviewer:
ms.topic: how-to
ms.date: 03/13/2024
---
# How to use Table Import to import data into Microsoft Dynamics GP

This article describes how to use the Table Import tool to import data into Microsoft Dynamics GP and into Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856667

## Use the Table Import feature to import data

To use the Table Import feature to import data, follow these steps:

1. Determine what data will be imported and which tables will be accessed. To do this, follow these steps:

    1. Use the Software Development Kit (SDK) Master document and the Transaction Work Flow document to determine what data will be imported and which tables will be accessed. Run the SDK.msi file from the Tools folder on the Microsoft Dynamics GP CD2 disc (or click on the link at the end of this article). The SDK documents explain the tables and the fields that are involved in importing data into the Microsoft Dynamics GP modules. Additionally, the documents include a flow chart diagram for the Transaction Entry process in the appropriate module.

    2. Use the online table and field descriptions to view the table description and the field information for any table in the selected product. To do this, click **Tools**, click **Resource Descriptions**, and then click **Tables**.

    3. View the existing data in the "Fabrikam, Inc." sample company. To do this, create a custom report in **Report Writer** that lists all the fields in a table. Connect to a table through ODBC in Microsoft Access, in Microsoft Query, or in Microsoft Excel. Use SmartList to export specific data to Microsoft Excel. Or, use SQL Query Analyzer to select records from a specific table. Additionally, you can use the **Select A Table** window that opens when you access the **Table Import Utility** when a Microsoft Dynamics GP form is open. The **Select A Table** window shows the tables that are used for that window. You can also use the **Show Required Fields** option in Microsoft Dynamics GP.

2. Use the following guidelines to determine both the field structures and the data types of the fields that are to be imported:
   - String: The length of data should be equal to or less than the keyable length of the field.
   - Text: You can store up to 32,000 characters. The note field is a text storage type.
   - Integer: List boxes and radio group fields are stored as integers, not as strings. These items are stored in the order in which they appear in the Static Text Values window in Report Writer or in Modifier. An integer's maximum value is 32767. If the imported data exceeds this value, the value will automatically be converted to 32767.
   - Long Integer: The valid range of the value is -2147483648 to 2147483648. The stored value always has a length of 4 bytes. This field is used for information that can exceed the maximum range of an integer, such as sequence numbers. The Account Index has this data type.

      > [!NOTE]
      > The Account Index is frequently stored in Microsoft Dynamics GP tables instead of the account number field.

   - Currency: Currency is stored in a 14.5 format, where 14 character positions are reserved to the left of the decimal point, and no more than five characters can appear to the right side of the decimal point.

        > [!NOTE]
        > Indices have a currency data type.
   - Boolean: The value is stored as a 0 or 1 to indicate whether the field is selected. This data type is used for check boxes.
   - Date: Make sure that the format matches what has been set up in Control Panel for the operating system of the computer.
   - Time: Time is stored in 24-hour format.
   - Multi-select list boxes: These boxes include lists from which you can make more than one selection up to a maximum of 32 items. Selections are stored in a series of 32 characters that are Ts or Fs (true or false values). These characters indicate whether the item has been selected. For example, to set the **Include in Lookup** list in the Account Maintenance window to Sales and Purchasing, you would import the following value:

        TFTFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

    > [!NOTE]
    > Account Numbers are stored as a composite of each segment. When you import account numbers, each segment must be separated by a tab or by a comma so that the Table Import tool treats each segment as a separate field.

3. Determine which fields are required for import. To do this, use the Software Development Transaction document and the Master Flow document. Some required field information is also listed in the Table Descriptions window.

4. Always test the import definitions in the Fabrikam, Inc. sample company before you run the import in the live company.

5. Manipulate the data within the Fabrikam sample company. To do this, you can print reports, post transactions, run check links, and so on.

6. Make a backup of the live company before you perform the import procedure.

7. Review the required fields, and then check for duplicate records in the source file. A record is considered a duplicate if the key values are the same as the key values of another record that already exists in the system or in the source file. Duplicate records will not be imported.

8. Define the import. Then, perform the import.

9. After the import is finished, perform file maintenance on the tables that are imported into Microsoft Dynamics GP. Print any relevant setup lists or edit lists. Then, perform the necessary reconcile procedures.
