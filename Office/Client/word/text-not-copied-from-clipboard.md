---
title: Text is not copied from the Clipboard as expected in Word
description: Explains that the advanced Word options for Cut, Copy and Paste settings do not apply to the Clipboard.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: wdonebre, gquintin, larryt
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Word 2010
- Word 2007
---

# Text is not copied from the Clipboard as expected in Microsoft Office Word 2007 - 2010

## Symptoms

Text is not copied from the Clipboard as expected in Microsoft Office Word 2007 or Microsoft Office Word 2010. This behavior occurs in the following scenario. You configure Microsoft Office Word 2007 or 2010 to use the following default behavior when you paste items: 

- Keep the source formatting when you paste items from the same document.   
- Keep only the text when you paste items from another program.   

You copy formatted text from a document to the Clipboard. Then, you copy this text from the clipboard and paste it to the document from which you copied this text. In this scenario, the text that you pasted to the document does not include the source formatting.

**Note** To view the Clipboard, click the **Clipboard** Dialog Box Launcher on the **Home** tab. 

## Cause

This issue occurs because the default Paste settings do not apply to the 2007 or 2010 Office Clipboard. The default Paste settings apply only when you use the **Paste** command or the CTRL+V keyboard shortcut. 

## More Information

The 2007 or 2010 Office clipboard is a unique data source. None of the default Cut, Copy, or Paste settings apply to the Clipboard. 

To configure the Cut, Copy, and Paste settings in Word 2007 or 2010, follow these steps: 

1. Click the **Microsoft Office Button**, click **Word Options**, and then click **Advanced**.   
2. Under **Cut, copy, and paste**, configure the settings that you want to use as the default behavior.
