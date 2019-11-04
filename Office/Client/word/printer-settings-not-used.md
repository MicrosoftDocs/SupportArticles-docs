---
title: The printer settings are ignored when you print a document
description: Discusses an issue in which the Page Setup settings in a Word document override the printer settings when you print a Word document.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: v-jomcc
search.appverid: 
- MET150
appliesto:
- Word 2010
---

# The printer settings are ignored when you print a Word document

## Symptoms

When you print a Microsoft Word document, the printer settings are ignored. These printer settings include the paper size, the page orientation, and the page margins.

Consider the following scenario. You change the properties of the printer driver to specify paper size, page orientation, or page margins. However, when you print a Word document, its paper size, page orientation, or page margins differ from what you specified in the printer driver properties. 

## Cause

This issue occurs because the Page Setup settings that you specify in your Word document override the settings that you specify in the printer driver properties. 

## Workaround

To work around this issue, do not specify the paper size, page orientation, or page margins in the printer driver properties. Instead, specify these settings in your Word document. If there are multiple sections in your document, you must specify the settings for each section of the document.

To specify these settings, follow these steps:

1. Start Word, and then open the document you want to change.   
2. In Microsoft Office Word 2003 and in earlier versions of Word, click the page or the section that you want to print, and then click **Page Setup** on the **File** menu. 

   In Microsoft Office Word 2007 and Word 2010, click the page or the section that you want to print, and then click the **Page Layout** tab. In the **Page Setup** group, click **Page Setup** to open the **Page Setup** dialog box.   
3. Click the **Paper** tab.   
4. Under **Paper size**, click the paper size that you want.    
5. In the **Paper source** area, perform one of the following steps:

   - If the printer can automatically select the correct paper tray to use, click **Default tray** in the **First page** list, and then click **Default tray** in the **Other pages** list. **Default tray** is the default setting in both of these lists. 
  
  - If the printer cannot automatically select the correct paper tray to use, you may have to select the paper tray that contains the paper size that you selected in step 4. To do this, click the appropriate paper tray in the **First page** list and in the **Other pages** list.   
   
6. If you want to change the document's page orientation or its page margins, click the **Margins** tab.   
7. Select the options that you want.   
8. Perform one of the following steps in the **Apply to** box:

   - To use the paper size that you specified in step 4 for only the current section of the document, click **Selected text**.   
   - To use the paper size that you specified in step 4 for the current section of the document and for all remaining sections in the document, click **This point forward**.    
   - To use the paper size that you specified in step 4 for the whole document, click **Whole document**.   
   
9. Click **OK**.   
10. Repeat steps 2 to 9 for each section of your document for which you want to specify settings.   

## More Information

For more information about how to print documents from Word, view the following topics in Microsoft Word Help:
- Printing   
- Margins and Page Setup   
