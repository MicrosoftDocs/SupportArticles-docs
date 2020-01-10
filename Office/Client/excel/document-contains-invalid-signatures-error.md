---
title: Document contains invalid signatures error if opening digitally signed in newer version Excel file
description: Describes a problem in which you receive an error message when you open an Excel 2007 digitally signed workbook in Excel 2010. Provides a workaround for this problem.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.reviewer: hgkim， gaberry
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Excel 2016
- Excel 2013Excel 2010
- Microsoft Office Excel 2007
---

# "This document contains invalid signatures" error when opening Excel files that are digitally signed in a newer version

##  Symptoms

You open an Excel workbook that has been digitally signed in a higher version of Excel than the one used to apply the digital signature. In this case the signature is no longer valid and a warning is displayed in the trust bar:

    This document contains invalid signatures. [View Signatures]

**Note** When you open the digitally signed workbook in same version it was created in, the workbook opens as usual and without an error message.

##  Cause

When Excel opens a workbook that was last recalculated in a different version (either a different product version or an update that introduces changes in the recalculation behavior), it updates the internal recalculation data to the actual version. As this data is part of the file content, the digital signature is then no longer valid because of this change in the content.

##  Workaround

Before signing the workbook, switch the calculation mode to Manual. To do this, switch to the "Formulas" ribbon tab and select the "Manual" option from the "Calculation Options" button drop down list.

Note that the calculation option is saved per workbook, but it can affect the setting for other workbooks that are opened in the same instance of Excel.

##  Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.