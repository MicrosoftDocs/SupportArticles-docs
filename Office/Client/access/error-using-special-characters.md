---
title: Errors using special characters in Access databases
description: Lists the special characters to avoid using when you work with the database object names or the field names in all versions of Access.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---

# Error message when you use special characters in Access databases

This article lists the special characters to avoid using when you work with the database object names or the field names in all versions of Access.

_Original KB number:_ &nbsp; 826763

> [!NOTE]
> This article applies to either a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file, and to a Microsoft Access project (.adp) file.

## Symptoms

When you use special characters in Access, you experience one of the following problems.

### Problem 1

You use one of the following special characters in the name of a table field:

- Accent grave (`)
- Exclamation mark (!)
- Period (.)
- bracket([])
- Leading space
- Non-printable characters

In this case, you receive the following error message:

> The field name is not valid.  
> Make sure that the name doesn't contain a period(.), exclamation point(!), bracket([]), leading space, or non-printable character such as a carriage return. If you have pasted the name from another application, try pressing ESC and typing the name again.

If you use these special characters in a table name, you receive the following error message:

> The object name '**TableName**' you entered doesn't follow Microsoft Office Access object-naming rules.

### Problem 2

You create a query expression. The query expression includes fields that contains special characters. Depending on the specific special characters, you receive one of the following error messages:

- If the field name contains a space character, a question mark (?), or an at sign (@), you receive the following error message:

  > The Expression you entered contains invalid syntax.  
  > You may have entered an operand without an operator

- If the field name contains a quotation mark(") or an apostrophe('), you receive the following error message:

  > The Expression you entered has an invalid string.  
  > A string can be up to 2048 characters long, including opening and closing quotation marks.

- If the field name contains a number sign (#), you receive the following error message:

  > The expression you entered has an invalid date value.

- If the field name contains a percent sign (%), a tilde (~), a semicolon (;), or a bracket ([]), you receive the following error message:

  > The Expression you entered contains invalid syntax.  
  > You omitted an operand or operator, you entered an invalid character or comma, or you entered text without surrounding it in quotation marks.

- If the field name contains a brace ({}), you receive the following error message:

  > Malformed GUID in query expression '**ObjectName**'

- If the field name contains a bracket ([]) or parenthesis (()), you receive the following error message:

  > The expression you entered is missing a closing parenthesis, bracket (]), or vertical bar(|).

### Problem 3

You have a query that contains query expressions. The query expressions include fields that contain special characters. When you run the query, you are promoted to enter a parameter value. Typically, this problem occurs when you use the following special characters:

- Greater than sign (>)
- Less than sign (<)
- Period (.)
- Asterisk (*)
- Colon (:)
- Caret (^)
- Plus sign (+)
- Backslash (\\)
- Equal sign (=)
- Ampersand (&)
- Slash mark (/)

## Workaround

To work around this problem, do not use special characters. If you must use special characters in query expressions, enclose the special characters in brackets ([]). For example, if you want to use the greater than sign (>), use [>].

## More Information

Microsoft Access does not restrict the use of special characters such as a number sign (#), a period (.), or a quotation mark (") in the database object names or in the database field names. However, if you do use the special characters, you may experience unexpected errors. Therefore, Microsoft recommends that you do not use the special characters in the database object names in the Access database or in the database project. This article discusses the special characters that you must avoid because of known issues with these special characters.

When you work with Access or with some other application such as a Microsoft Visual Basic application or an Active Server Pages (ASP) application, you must avoid the following special characters:

|Name|Symbol|
|---|---|
|Space||
|Apostrophe|'|
|Quotation mark|"|
|Apostrophe|'|
|At sign|@|
|Grave accent|`|
|Number sign|#|
|Percent|%|
|Greater than sign|>|
|Less than sign|<|
|Exclamation mark|!|
|Period|.|
|Brackets|[ ]|
|Asterisk|*|
|Dollar sign|$|
|Semicolon|;|
|Colon|:|
|Question mark|?|
|Caret|^|
|Braces|{ }|
|Plus sign|+|
|Hyphen|-|
|Equal sign|=|
|Tilde|~|
|Backslash|\|

### Access naming conventions

Microsoft recommends that you do not use a period (.), an exclamation mark (!), a grave accent (`), a bracket ([ ]), a space ( ), or a quotation mark (") inside the names of functions, the names of variables, the names of fields, or the names of database objects such as tables and forms.

There are known problems that occur if you use the following special characters in Access. The following scenarios describe when you must not use the special characters:

- When you export the database objects to other file formats such as a Microsoft Excel file format, an HTML file format, or a text file format, do not use a number sign (#) or a period (.) in the database object names or in the field names.
- When you use hyperlinks in Access, the hyperlinks are stored as modified Memo fields with a number sign (#) as a delimiter. Therefore, the number sign is regarded as a reserved word in Access. Do not use the number sign when you create hyperlinks.
- When you import a text file into Access and that text file contains tabs or other special characters, the special characters are converted, and then the special characters appear as boxes. Therefore, when you try to use the imported table, you receive unexpected errors. You must not use the special characters in the source table when you import into Access.
- When you use ASP forms to add or to modify data in an Access database, you must not use a percent sign (%), a plus sign (+), or a caret (^) in the form. These special characters may not translate correctly in the Access database.
- When you use Full-width languages, do not use Full-width characters in the name of database objects or in the name of controls. For example, you must not use Full-width parentheses when you use Full-width languages This may cause compile errors if there is code in an event procedure for the object or for the control.
