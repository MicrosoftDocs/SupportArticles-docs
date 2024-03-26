---
title: Unable to open the Office Customization Tool
description: Describes an issue that may occur if you do not have a volume-license version of the 2007 Office system.
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
  - Office 2007
ms.date: 03/31/2022
---

# "Files necessary to run the Office Customization Tool were not found" when you open the tool

## Symptoms

You use the Office Customization Tool to customize an installation of the 2007 Microsoft Office system. You try to open the Office Customization Tool by typing the following command at a command prompt:

**setup.exe /admin**

When you do this, you may receive the following error message:

```asciidoc
Files necessary to run the Office Customization Tool were not found. Run Setup from the installation point of a qualifying product.
```

## Cause

This issue may occur if you do not have a volume-license version of the 2007 Office system. The Office Customization Tool is available only with volume-license versions of the 2007 Office system. This tool requires an Admin folder in the 2007 Office system source image. If the Admin folder does not exist, you will receive this error message.

## More Information

For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[931401](https://support.microsoft.com/help/931401) How to determine whether you have a retail edition or a volume license edition of a 2007 or a 2010 Microsoft Office suite

For more information about the Office Customization Tool, visit the following Microsoft Web site:

[Office Customization Tool (OCT) reference for Office 2013](https://technet.microsoft.com/library/cc179097.aspx)