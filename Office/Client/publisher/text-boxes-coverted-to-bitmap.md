---
title: Text boxes in an email message are converted to bitmap images
description: Describes the issue in which text boxes in a Publisher 2010 and 2013-created email message are converted to bitmap images when the email is sent.
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
ms.reviewer: lisyu, RichPo, ARykhus, debbiery
appliesto: 
  - Publisher 2010
  - Publisher 2013
ms.date: 03/31/2022
---

# Text boxes in a Publisher 2010 and 2013-created email message are converted to bitmap images when the email is sent

## Symptoms

Consider the following scenario:

- In Microsoft Publisher, you create a new publication.    
- On the **File** tab, you click **Save & Send**.   
- You click **Send Using Email** and then click either **Send Current Page** or **Send All Pages**.   
- You add the necessary information to the email fields, such as recipients and a subject, and then click **Send**.   

In this scenario, recipients of the email message cannot select some individual words in the body of the email message because several text boxes are converted to bitmap images. 

## Cause

This issue occurs when some text boxes contain text that is formatted to use one of the ClearType fonts in the Microsoft ClearType Font Collection. These fonts are as follows:

- Constantia    
- Corbel   
- Calibri   
- Cambria   
- Candara   
- Consolas   

This issue occurs because ClearType fonts are not web-ready. When Publisher 2010 sends an email message that contains ClearType fonts, any text boxes that contain ClearType fonts are converted to bitmap images.

## Workaround

To work around this issue, change any text that is formatted to use a ClearType font to another font, such as Arial, before you send the publication as an email message. To do this, use one of the following methods.

### Method 1: Use Design Checker

1. On the **File** tab, click **Info**, and then click **Run Design Checker**. 
2. In the **Design Checker** pane, click to select the **Run e-mail checks (current page only)** check box.   
3. In the **Select an item to fix** section of the pane, click the first item in the list that has the following message: 

    Text is in a non-web-ready font. Text will be exported as an image. 
    
    Notice that a text box that contains a ClearType font is selected.   
4. Under **Text Box Tools**, click **Format**.   
5. Select the text that uses the ClearType font, and then in the **Font** group, select another font to use from the **Font** drop-down list. When the font issue is fixed for the text box, the Design Checker item closes.   
6. Repeat steps 3 through 5 for each text box that contains a ClearType font.  

### Method 2: Change the font scheme

If you are using a template, you can change the font scheme that is used in the publication. To do this, follow these steps.

**Note** This method changes all the fonts in the publication to the fonts that are used in the font scheme.

1. On the **Page Design** tab, in the **Schemes** group, click **Fonts**.   
2. Select a font scheme that does not use a ClearType font.   

## More Information

For more information about how to use ClearType fonts, see [ClearType Font Collection](https://www.microsoft.com/typography/cleartypefonts.mspx).

