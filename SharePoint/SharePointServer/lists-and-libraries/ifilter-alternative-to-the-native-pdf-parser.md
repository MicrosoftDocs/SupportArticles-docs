---
title:  Native SharePoint PDF parser iFilter alternatives
description: Describes how to use an iFilter as an alternative to the built-in PDF parser in SharePoint 2013 to make PDF files searchable.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft SharePoint Server 2019
- Microsoft SharePoint Server 2016
- Microsoft SharePoint Server 2013
---

# IFilter alternatives to the native PDF parser  

Microsoft SharePoint Search versions 2019, 2016, and 2013 use a built-in parser to process PDF files and make them searchable. This built-in PDF parser is coded to handle most PDF files, but not all of them.

To mitigate the possibility of a PDF parsing failure, SharePoint 2013 Search introduced a new feature in the July 2014 cumulative update that lets you bypass the built-in PDF parser and configure the use of an iFilter instead.

Using an IFilter for PDF parsing will eventually help you to improve the PDF Parsing quality in SharePoint Search.

## PDF iFilter tools

There are several PDF IFilter tools available, some free and some commercial. The following are among the most commonly used:  

- [Adobe PDF iFilter (free)](https://www.adobe.com/support/downloads/product.jsp?product=1&platform=windows)  
- [Foxit PDF IFilter (commercial)](https://www.foxitsoftware.com/products/pdf-ifilter/)

If you're experiencing PDF parsing issues when you use the SharePoint built-in PDF parser, we recommend that you try to use a PDF iFilter instead.

## Enabling support for installed PDF iFilter

Enabling third-party PDF iFilter tools can be done via SharePoint PowerShell once the iFilter has been installed on the search servers.

For example:

```
$ssa = Get-SPEnterpriseSearchServiceApplication -Identity "Search Service Application"
Set-SPEnterpriseSearchFileFormatState -SearchApplication $ssa -Identity PDF -Enable $true -UseIFilter $true
```

**Third-party information disclaimer**

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

## More information

For more information on the activation state of the parser that corresponds to the specified file format, see [Set-SPEnterpriseSearchFileFormatState](https://technet.microsoft.com/library/jj730455.aspx).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
