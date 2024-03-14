---
title: Access ADODB code errors when you use the adBigInt data type
description: The value you entered isn't valid, Too few parameters and Not enough memory resources are available errors when using ADODB code that refers to the adBigInt data type in Access.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Access for Microsoft 365
  - Access 2019
ms.date: 03/31/2022
---

# Access ADODB code errors when you use the adBigInt data type

## Symptoms

In Microsoft Access for Microsoft 365 and Microsoft Access 2019, you may encounter the following error messages in the Visual Basic for Applications (VBA) ADODB code that refers to the adBigInt data type:

- The value you entered isn't valid for this field.
- Too few parameters. Expected *x*.
- Not enough memory resources are available to complete the operation.

## Cause

This issue occurs because Access for Microsoft 365 and Access 2019 introduced the **Large Number** data type support.

In earlier versions of Access, adBigInt values were converted to strings. Now, with the **Large Number** data type support, Access maps adBigInt to a binary value.

Within various ADODB methods, you must specify the data type that you use. In earlier versions of Access, the code may run successfully even though you don't use compatible data types because they are converted to strings. However, you might now see one of the error messages that are described in the Symptoms section with the **Large Number** data type support.

**Example 1:**

Assume that you have two ADODB **Recordset** objects where RS!MyID is defined as adInteger and RS2!MyID is defined as adBigInt. If you try to set RS!MyID = RS2!MyID, you will encounter an error message because of the **Large Number** data type support.

**Example 2:**

Assume that you try to run an ADODB command object. If you create a parameter that uses adBigInt but then use that parameter against a field of a smaller data type, you will encounter an error message.

## Resolution

To resolve this issue, change the ADODB code to use the data type that best matches the data type of the underlying object. To do this, use the following guide to select the appropriate data type within ADODB.

|Access data type|ADODB data type|
|----------|----------|
|Number|adInteger|
|Large Number|adBigInt|

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).