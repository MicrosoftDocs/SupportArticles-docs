---
title: Network Mapped Drive Hyperlinks resolve as UNC in Office Products
description: Fixes an issue that occurs after a user inserts a hyperlink to a file residing on a network mapped drive within an Office product.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Excel 2013
- Microsoft Office Excel 2007
- Microsoft Office Excel 2007 (Home and Student version)
- Excel 2010
- Microsoft Word 2010
- Word 2013OneNote 2013
- Microsoft Office Outlook 2007
- Microsoft Outlook 2010
- Outlook 2013
- Excel 2016
- Outlook 2016
- Word 2016
---

# Network Mapped Drive Hyperlinks resolve as UNC in Office Products

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

##  Symptoms

After a user inserts a hyperlink to a file residing on a network mapped drive within an Office product, the hyperlink's text displays the network mapped drive path, however the link is resolved as the UNC path. 

For example, in Excel if you go to Insert, and then click on Hyperlink the user is prompted to select the file. If the user navigates to a file residing on a Network Mapped Drive, and inserts a hyperlink to that file, the hyperlink will be created to the file via its UNC path instead of its network mapped drive path. After the link has been inserted, the user can then hover over the link and see that the full UNC path has been used when creating the link to the file.

##  Cause

The cause is due to the way Office creates hyperlinks to files. Office products will create links to files using the UNC path and will not use the network mapped drive location, even if it displays it in the hyperlink text.

##  Resolution

There is no resolution for this. Microsoft recommends that users insert hyperlinks using the UNC path to prevent confusion in cases where opening a file via UNC or network mapped drive might make a difference in the expected behavior in the file.

##  More Information

An example of where how a file is opened can be found listed in this KB article under the section "Scenarios that may cause links to not work as expected."

 [328440](https://support.microsoft.com/help/328440) Description of link management and storage in Excel