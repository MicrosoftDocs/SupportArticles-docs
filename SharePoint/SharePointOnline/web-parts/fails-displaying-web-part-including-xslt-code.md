---
title: Unable to display a SharePoint Online Web Part containing custom XSLT code
description: You cannot display a SharePoint Online Web Part with custom XSLT code.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# A SharePoint Online Web Part that contains custom XSLT code doesn't display, or you receive an error message

## Problem

In Microsoft SharePoint Online, you import custom XSLT code into an out-of-the-box Web Part and then configure the Web Part to run the XSLT code. When you try to display the Web Part, you receive the following error message: 

```asciidoc
Unable to display this Web Part. To troubleshoot the problem, open this Web page in a Microsoft SharePoint Foundation-compatible HTML editor such as Microsoft SharePoint Designer. If the problem persists, contact your Web server administrator.
```

Additionally, a member of the DataFormWebPart class may intermittently not display.

## Solution

To work around this issue, take one or more of the following actions in Microsoft SharePoint Designer 2013 to decrease the probability that the Web Part will reach the throttling limit:

- Reduce the size of the code by replacing the existing value of **ddwrt:EscapeDelims(string(\@ID))** with the new value **\@ID**.
- Remove all <**SharePoint:FieldDescription**> strings.
- For an edit form page, break the XSL template for <**xsl:template name="dvt_1.rowedit"**> into multiple XSL templates by dividing the table rows into multiple XSL templates. You can do this by using SharePoint Designer 2013 to edit and add the strings.

## More information

This issue occurs when the XSLT code is throttled by SharePoint Online. In order to maintain optimal performance and reliability of the SharePoint Online service, throttling limits can be exceeded for custom XSLT execution if one or both of the following conditions are true:

- The custom XSLT causes a stack overflow.
- The XSLT execution time exceeds one second.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
