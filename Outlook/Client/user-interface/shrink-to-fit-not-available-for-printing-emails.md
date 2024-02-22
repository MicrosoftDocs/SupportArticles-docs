---
title: Shrink to Fit not available for email print
description: This article provides workarounds for the issue that Outlook 2007 and Outlook 2010 do not have the Shrink to Fit functionality that is available in earlier Outlook versions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, lpen
appliesto: 
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# Shrink to Fit is not available when you print an email message in Outlook

_Original KB number:_ &nbsp; 2739063

## Summary

Consider the following scenario. In Microsoft Office Outlook 2007 or in Microsoft Outlook 2010, you open an email message that contains a large inline graphic or picture. When you attempt to print the email message, you notice the image is cropped. Outlook 2007 and Outlook 2010 do not offer a **Shrink to Fit** option, as in earlier versions.

## More information

In earlier versions of Outlook, Windows Internet Explorer is used for reading email messages. Internet Explorer has the **Shrink To Fit** print option.

Because multiple rendering engines are used in earlier versions of Outlook, email messages sometimes display differently between the sender and the recipient.

Internet Explorer was not intended to be used an editing tool. Therefore, Microsoft decided to use Microsoft Word to read and to author content in Outlook. Outlook 2010 uses Word 2010 for both the rendering engine and the composition engine. Similarly, Outlook 2007 uses Word 2007 for both rendering and composition. This symmetry provides a uniform experience between the sender and the recipient. Additionally, the Word 2010 and Word 2007 rendering engines represent improvements over the rendering engines in earlier versions of Word. These improvements include improved support for HTML and cascading style sheets (CSS) standards.

Microsoft Word does not have a **Shrink to Fit print** option. Therefore, Outlook 2007 and Outlook 2010 do not have the Shrink to Fit functionality that is available in earlier Outlook versions.

Use one of the following workarounds to print the full image:

- Open the email message in Outlook, select the **Actions** button, and then select **Edit Message**. Resize the large image before you print it.
- Copy the contents of the email message to a new Microsoft Word document and resize the image in Word.
- Request the sender to send you the picture or graphic as an attachment. Open the file using a program that supports resizing or shrinking the image.
- Right-click on the large image and save it to disk. Open the file using a program that supports resizing or shrinking the image.
