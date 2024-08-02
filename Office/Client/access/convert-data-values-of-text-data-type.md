---
title: Convert Text data type to proper case format
description: Decribes two step-by-step methods to convert data values of the Text data type to the proper case format in Microsoft Access.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 06/06/2024
---

# How to convert data values of the Text data type to the proper case format in Microsoft Access

Moderate: Requires basic macro, coding, and interoperability skills.

This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file.

## Summary

This article describes how to convert data values of the Text data type to the proper case format.

## More information

The data values of Text data type can be converted to the proper case format by using one of the following methods:

- Method 1: Use the Built-In String Conversion Function
- Method 2: Use a User-Defined Function

**Note** Before you use either of these methods, create a sample table that is named MyTestTextList. To do this, follow these steps:

1. Create a new blank database in Access.
2. Create a new table with the following fields:

   ```adoc
   Field Name: testText
   Data Type: Text
   ```

3. Save the table as MyTestTextList.
4. Add the following sample testText to the table:

   ```adoc
   the cOw jumped Over the MOON

   THE QUICK BROWN FOX jUmped over THE lazy DOG 

   ```

5. Save the database as MyTestDatabase.

### Method 1: Use the built-in string conversion function

1. Open the MyTestDatabase database in Access.
2. On the **Insert** menu, click **Query**.

   **Note** In Microsoft Office Access 2007 or a later version, click **Query Design** in the **Other** group on the **Create** tab.
3. In the **New Query** dialog box, click **Design view**.

   **Note** In Access 2007 or a later version, skip this step.
4. In the **Show Table** dialog box, click **Close**.
5. On the **View** menu, click **SQL View**.

   **Note** In Access 2007 or a later version, click **SQL** in the **Results** group on the **Design** tab.
6. Type the following code in the SQL view:

   ```sql
   SELECT testText, STRCONV(testText,3) as  TestText_in_Proper_Case FROM MyTestTextList
   ```

7. On the **Query** menu, click **Run**.

   **Note** In Access 2007 or a later version, click **Run** in the **Results** group on the **Design** tab.

   The output of the query follows:

   ```adoc
   TestTextTestText_in_Proper_Case
   the cOw jumped Over the MOONThe Cow Jumped Over The Moon
   THE QUICK BROWN FOX jUmped overTHE lazy DOG The Quick Brown Fox Jumped Over The Lazy Dog
   ```

**Note** The StrConv(\<Text\>,3) method converts the first letter of every word in the text to uppercase. This behavior occurs only when the words are separated by a space or a tab. StrConv doesn't treat the special characters, such as - or $, as a word separator.

### Method 2: Use a user-defined function

1. Open the MyTestDatabase database in Access.
2. On the **Insert** menu, click **Module**.

   **Note** In Access 2007 or a later version, click the drop-down arrow under **Macro** in the **Other** group on the **Create** tab.
3. Type the following code in the current module and save your changes.

   ```vb
   Function Proper(X)
   Capitalize first letter of every word in a field.

   Dim Temp$, C$, OldC$, i As Integer

   If IsNull(X) Then

   Exit Function

   Else

   Temp$ = CStr(LCase(X))

   ' Initialize OldC$ to a single space because first
           ' letter must be capitalized but has no preceding letter.

   OldC$ = " "

   For i = 1 To Len(Temp$)
                   C$ = Mid$(Temp$, i, 1)
                   If C$ >= "a" And C$ <= "z" And (OldC$ < "a" Or OldC$ > "z") Then
                         Mid$(Temp$, i, 1) = UCase$(C$)
                   End If
                   OldC$ = C$
            Next i

   Proper = Temp$

   End If

   End Function
   ```

   **Note** You must specify Option Compare Database in the "Declarations" section of this module for the function to work correctly.

4. On the **File** menu, click **Close and Return to Microsoft Access**.

   **Note** On the **File** menu, click **Close**for Access 97.
5. On the **Insert** menu, click **Query**.

   **Note** In Access 2007 or a later version, click **Query Design** in the **Other** group on the **Create** tab.
6. In the **New Query** dialog box, click **Design view**.

   **Note** In Access 2007 or a later version, skip this step.
7. In the **Show Table** dialog box, click **Close**.
8. On the **View** menu, click **SQL View**.

   **Note** In Access 2007 or a later version, click **SQL** in the **Results** group on the **Design** tab.
9. Type the following code in the SQL view:

   ```sql
   SELECT testText, proper(testText) as  testText_in_Proper_Case FROM MyTestTextList
   ```

   Notice that this query is similar to the query in Method 1. This is except for the function call.

10. On the **Query** menu, click **Run**.

    **Note** In Access 2007 or a later version, click **Run** in the **Results** group on the **Design** tab.

    The output of the query follows:

    ```adoc
    TestTextTestText_in_Proper_Case
    the cOw jumped Over the MOONThe Cow Jumped Over The Moon
    THE QUICK BROWN FOX jUmped overTHE lazy DOG The Quick Brown Fox Jumped Over The Lazy Dog
    ```

While the output of both methods is similar, Method 2 gives you the flexibility to select any case format. This includes a chosen word separator such as - or _. You can define the required case format, or you can define a word separator. You can do this if you modify the Proper function that is mentioned in step 3.
