---
title: How to create a mailto hyperlink in a presentation in PowerPoint for Mac
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- PowerPoint for Mac
---

# How to create a mailto hyperlink in a presentation in PowerPoint for Mac

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

In a slide show presentation in Microsoft PowerPoint, you can create a hyperlink to a mailto Uniform Resource Locator (URL) to send mail to a specific recipient. The mailto URL uses the following syntax:

```adoc
mailto<email_address>
```

where mailto is the protocol, and *email_address* is the e-mail address of the recipient (for example mailto:example@microsoft.com).

This mailto link can be used in a presentation running in Kiosk mode; however, the Kiosk station must have a method, such as a keyboard, to write the message. Nevertheless, you can format the mailto URL to address a mail message to a specific recipient when you activate the link. This article describes how to create a mailto hyperlink.

## More Information

To create a mailto hyperlink, follow these steps:

1. Go to the slide on which you want to create the mailto hyperlink.
2. Draw a text frame (or shape) to use as the mailto hyperlink.
3. Enter some text in the frame. For example, type "Mail To" (without the quotation marks), to describe the function of the frame.

   > [!NOTE]
   > If you want to format the text frame to look like a button, add a color fill and a border around the frame.

4. Select the text frame, and then click Action Settings on the Slide Show menu.
5. Click the Mouse Click tab.
6. Click Hyperlink To. In the Hyperlink To list, click URL.
7. In the Hyperlink To URL dialog box, type the mailto URL you want. For example, type the following:

   **mailto:example@contoso.com**

8. Click OK.
9. Click OK again.

When you click the mailto link during the slide show, a new mail message that contains the recipient's e-mail address appears on your screen.

> [!NOTE]
> For this to work, you must have an e-mail client installed and it must be running correctly.