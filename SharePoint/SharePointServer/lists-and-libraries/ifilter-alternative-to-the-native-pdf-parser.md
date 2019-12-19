---
title: IFilter alternative to the native SharePoint 2013 PDF parser
description: Describes how to use an IFilter as an alternative to the built-in PDF parser in SharePoint 2013 to make PDF files searchable.
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
- Microsoft SharePoint Server 2013
---

# IFilter alternative to the native PDF parser  

Microsoft SharePoint 2013 Search uses a built-in parser to process PDF files and make them searchable. This built-in PDF parser is coded to handle most PDF files. However, it might be unable to handle some.   

To mitigate the possibility of a PDF parsing failure, SharePoint 2013 Search introduced a new feature in the July 2014 cumulative update that lets you bypass the built-in PDF parser and configure the use of an IFilter instead.   

The following TechNet topic describes how to override the built-in PDF parser to use an IFilter: [Set-SPEnterpriseSearchFileFormatState](https://technet.microsoft.com/library/jj730455.aspx).

Using an IFilter for PDF parsing will eventually help you to improve the PDF Parsing quality in SharePoint 2013 Search.   

There are several PDF IFilter tools available, some free and some commercial. The following are among the most commonly used:  

- [Adobe PDF Ifilter (free)](https://www.adobe.com/support/downloads/product.jsp?product=1&platform=windows)  
- [Foxit PDF IFilter (commercial)](https://www.foxitsoftware.com/products/pdf-ifilter/)

If you're experiencing PDF parsing issues when you use the SharePoint 2013 built-in PDF parser, we recommend that you try to use a PDF IFilter instead.  

Third-party information disclaimer The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
