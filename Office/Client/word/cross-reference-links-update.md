---
title: Cross-reference links do not update to correct heading number
description: Describes the problem where cross-reference links in Word do not update to the correct heading number after you insert a new heading.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Word for Microsoft 365
  - Word 2019
  - Word 2016
  - Word 2013
  - Word 2010
  - Word Home and Student 2010
ms.date: 03/31/2022
---

# Cross-reference links do not update to the correct heading number after you insert a new heading

## Symptoms

Consider the following scenario:

- You create a Microsoft Word document that uses outline numbering for all headings.    
- You create a cross-reference link to a heading.   
- You create a new heading. To do this, you position the pointer at the beginning of the cross-referenced heading, and then you press Enter.   
- After you create the new heading, you update all field codes.   

In this scenario, the cross-reference link is not updated to reference the original heading. Instead, the cross-reference link references the new heading.

## Cause

This problem occurs because, when you create a cross-reference link, a hidden bookmark is created at the beginning of the heading. When you split the heading, the bookmark does not move. When you update the cross-reference link, the link is not updated.

## Workaround

To work around this problem, follow these steps:

1. Select the broken cross-reference, and then press Alt+F9. The field code is displayed for the REF field for the cross-reference. Note the bookmark name for the cross-reference. The bookmark name begins with the following string:

   _Ref

1. Locate and select the outline numbered heading to which the cross-reference should point.    
1. On the **Insert** tab, in the **Links** group, click **Bookmark**.   
1. In the **Bookmark** dialog box, click to select the **Hidden bookmarks** check box.
1. Locate and then select the bookmark name that matches the bookmark name that you noted in step 1.   
1. Click **Add**. The **Bookmark** dialog box closes.   
1. Press Alt+F9 to hide field codes.   
1. Locate the broken cross-reference.    
1. Right-click the cross-reference link, and then click **Update Field**.    

The cross-reference will correctly update the heading number to match the outline-numbered heading that the cross-reference references.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
