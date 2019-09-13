---
title: How to specify trusted sources for Digital Certificates in Office
description: Describes how to specify the trusted sources for Digital Certificates. You can turn on the "Trust all installed add-ins and templates" option to trust all add-ins and templates that are currently installed on the computer.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Microsoft Excel
- Microsoft PowerPoint
- Microsoft Word
---

# How to specify trusted sources for Digital Certificates in Excel, in PowerPoint, in and Word

## Summary

If you open a Microsoft Office document that contains a digitally signed macro, you are prompted to select whether to trust the source if the following conditions are true:

- The digital certificate has not previously been trusted.
- The security for your program is set to High or Medium.

You have the option to trust all currently installed add-ins and templates on your computer so that all files that are installed with Microsoft Office or added to the Office templates folder are trusted even though the files are not signed. This article describes how to specify the trusted sources for Digital Certificates.

### Specifying trusted sources

Using trusted sources is a means of cataloging and allowing signed executables to run on a computer. By enabling this feature, you can select whether to allow executable code or programs to run from sources that can be identified or trusted.

An Administrator can select to turn off the trusted sources feature or to enable a list of trusted sources as a default. If this feature is selected, any future installable code (such as, add-ins, applets, executables, and so on) is automatically copied to, or run from, the user's computer.

#### Microsoft Office 2002 and Microsoft Office 2003

To specify trusted sources in Microsoft Word, in Microsoft Excel, or in Microsoft PowerPoint, follow these steps:

1. On the **Tools** menu, point to **Macro**, and then click **Security**.
2. Office 2002

   Click the **Trusted Sources** tab.

   Office 2003
   
   Click the **Trusted Publishers** tab.
3. To trust all add-ins and templates currently installed on the computer, select the **Trust all installed add-ins and templates** check box.

You can add trusted sources by accepting the request to trust an applet or program the first time it tries to run. Macro security must be set at Medium or High to force this request.

> [!NOTE]
> The **Security** dialog box is available in Word, PowerPoint, and Excel. It is not available in Access.

#### 2007 Microsoft Office system

To specify trusted sources in Word, in Excel, or in PowerPoint, follow these steps:

1. Click the **Microsoft Office Button**, and then click one of the following:
  
   - **Word Options**
   - **Excel Options**
   - **PowerPoint Options**

2. Click **Trust Center**, click **Trust Center Settings**, and then click **Trusted Locations**.
3. Add the trusted locations that you want, and then click **OK** two times.