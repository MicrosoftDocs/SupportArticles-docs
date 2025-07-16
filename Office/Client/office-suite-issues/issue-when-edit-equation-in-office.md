---
title: Error when editing an equation in Office
description: Microsoft Equation is not available when you edit an equation that was inserted using Equation Editor 3.0 in an Office application.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Functions
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Microsoft Office
ms.date: 06/06/2024
---

# Error when editing an equation in Office

## Symptoms

When you try to edit an equation that was inserted using Equation Editor 3.0 in an Office application (such as Word), you see the following error: 

> Microsoft Equation is not available.

:::image type="content" source="media/issue-when-edit-equation-in-office/equation-editor-error.png" alt-text="Screenshot of the error after editing an equation that is inserted using Equation Editor 3.0 in an Office application." border="false":::

## Cause

Equation Editor 3.0 was a third-party component built by Design Science that was included in many versions of Office, but due to security issues with its implementation has been removed. Office now includes a newer equation editor.

For more information about the security issue, see [CVE-2017-11882 | Microsoft Office Memory Corruption Vulnerability](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2017-11882).

## Resolution

While the new equation editor won't edit existing equations that were created by Equation Editor 3.0, it allows you to insert new equations, common equations, or ink equations written by hand. The equation function can be found in Word, Excel, or PowerPoint under the **Insert** tab.

For more information about inserting and editing equations, including a short video tutorial, see [Write an equation or formula](https://support.office.com/article/Write-insert-or-change-an-equation-1D01CABC-CEB1-458D-BC70-7F9737722702#ID0EACAAA=Insert_built-in_equation).

Alternatively, the third-party app MathType enables you to edit Equation Editor 3.0 equations without security issues. MathType is now part of the Wiris Suite. You can download a free MathType 30-day trial at: [Welcome Microsoft Equation Editor 3.0 users](https://www.wiris.com/equation_editor/microsoft)

## More information

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information
