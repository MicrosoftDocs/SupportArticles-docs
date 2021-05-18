---
title: You can't open any Access wizard
description: Describes a problem in which you receive and error message when you try to open a wizard in Access 2007. This problem occurs when you have the Disable Trusted Locations and Disable all macros except digitally signed macros options enabled.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
- CI 111294
- CSSTroubleshoot
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: luche
ms.reviewer: mattbum
appliesto:
- Access 2007
---

# "This feature isn't installed, or has been disabled" when you open a wizard in Access

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

You enable the **Disable all macros except digitally signed macros** option in the **Macro Settings** pane of the **Trust Center Settings** and the **Disable all Trusted Locations** option in the **Trusted Locations** pane in Microsoft Access. When you try to open any wizard, you receive the following error message:

```adoc
This feature isn't installed, or has been disabled.

To install this feature, rerun the Microsoft Office Access or Microsoft Office Setup program or, if you're using a third-party add-in, reinstall the add-in. To reenable this wizard, click About Microsoft Office Access on the Help menu, and then click the Disabled Items button to view a list of addins which you can enable.
```

**Note** The **Help** menu no longer exists in Access 2007 or a later version.

## Cause

This problem occurs because the **Trust Center** security settings disable the wizards in Access.

## Workaround

To work around this problem, do not use the **Disable all Trusted Locations** option together with the **Disable all macros except digitally signed macros** option in the **Trust Center Settings**. To do this, follow these steps:

1. Click the **File** icon, and then click **Access Options**.   
2. Click **Trust Center** in the left pane, and then click **Trust Center Settings**.   
3. Click **Trusted Locations** in the left pane, click to clear the **Disable all Trusted Locations, only files signed by Trusted Publishers will be trusted** check box, and then click **OK** two times.   

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

### Steps to reproduce the problem

1. Create a new database in Access.   
2. Click the **File** icon, and then click **Access Options**.   
3. Click **Trust Center** in the left pane, and then click **Trust Center Settings**.   
4. Click **Macro Settings** in the left pane, and then enable the **Disable all macros except digitally signed macros** option.   
5. Click **Trusted Locations** in the left pane, click to select the **Disable all Trusted Locations, only files signed by Trusted Publishers will be trusted** check box, and then click **OK** two times.   
6. On the **Create** tab, click **Report Wizard**.   
