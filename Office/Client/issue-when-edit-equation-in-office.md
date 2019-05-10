---
title: Error when editing an equation in Office
description: Microsoft Equation is not available when you edit an equation that was inserted using Equation Editor 3.0 in an Office application.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# Error when editing an equation in Office

## Symptoms

If you try to edit an equation that was inserted using Equation Editor 3.0 in an Office application (such as Word), you will get an error: 

**Microsoft Equation is not available**

![Equation editor error](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4057881_en_1) 

## Cause

Equation Editor 3.0 is a third-party component built by Design Science ([https://www.dessci.com](https://www.dessci.com/)) that was included in many versions of Office, but due to security issues with its implementation, it has been removed. For more information about the security issue, see [CVE-2017-11882 | Microsoft Office Memory Corruption Vulnerability](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2017-11882). 

## Resolution

You can insert and edit new equations using the editor built into Office version 2007 or later. For more information about inserting and editing equations, see [Write, insert, or change an equation](https://support.office.com/article/Write-insert-or-change-an-equation-1D01CABC-CEB1-458D-BC70-7F9737722702#ID0EACAAA=Insert_built-in_equation). However, you will not be able to edit existing equations that were inserted using Equation Editor 3.0 in that manner. 

Alternatively, the third-party app MathType enables you to edit Equation Editor 3.0 equations without security issues. MathType is now part of the Wiris Suite. You can download a free MathType 30-day trial at: [Welcome Microsoft Equation Editor 3.0 users](https://www.wiris.com/equation_editor/microsoft) 

## More information

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products. 

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.