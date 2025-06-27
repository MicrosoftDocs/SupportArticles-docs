---
title: Formatting lost when editing HtmlBody
description: Provides a workaround for formatting that's lost when you edit the HtmlBody property of an Outlook item using the Outlook object model.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sending, Receiving, Synchronizing, or viewing email\Message format (HTML, Rich Text, Plain Text)
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: thomno, gbratton
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Formatting lost when editing the HtmlBody property of an Outlook item by using the Outlook object model

_Original KB number:_ &nbsp; 4020759

## Symptom

Assume that you create a new [MailItem](/office/vba/api/Outlook.MailItem), [AppointmentItem](/office/vba/api/Outlook.AppointmentItem), or [MeetingItem](/office/vba/api/Outlook.MeetingItem) object by using the [Outlook Object Model](/visualstudio/vsto/outlook-object-model-overview). You then set the [HtmlBody](/office/vba/api/Outlook.MailItem.HTMLBody) property of the item to some previously created well-formed HTML source that contains Cascading Style Sheet (CSS) styles. After you call the [Display](/office/vba/api/Outlook.MailItem.Display) method and the [Send](/office/vba/api/Outlook.MailItem.Send(method)) method to send the item, the formatting that's dictated by the configured CSS styles may disappear, or the paragraph styles may be replaced by the `MSONormal` class.

## Cause

Microsoft Outlook uses Microsoft Word as its editor. Loss of formatting may occur when the HTML  source is validated by the Word HTML engine when the item is sent.

## Workaround

We recommend that you use the underlying WordEditor object of the inspector to edit the HTML and Rich Text Format (RTF) bodies of Outlook items when you use the Outlook Object Model, instead of editing the `HtmlBody` property. See the following example.

> [!NOTE]
> See [Word Object Model](/visualstudio/vsto/word-object-model-overview) for more information.

```cs
using Outlook = Microsoft.Office.Interop.Outlook;
using Word = Microsoft.Office.Interop.Word;
namespace CreateAndEditMailItemUsingWord
{
    class Program
    {
        static void Main(string[] args)
        {
            Outlook.MailItem mailItem = (new Outlook.Application()).CreateItem(Microsoft.Office.Interop.Outlook.OlItemType.olMailItem);
            Word.Document wordDocument = mailItem.GetInspector.WordEditor as Word.Document;
            // Insert the text at the very beginning of the document
            // You can control fonts and formatting using the ParagraphFormat propety of the Word.Range object
            Word.Range wordRange = wordDocument.Range(0, 0);
            wordRange.Text = "Please insert your text here";
            mailItem.Display();
        }
    }
}
```
