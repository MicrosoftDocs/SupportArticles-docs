---
title: Fails to clear the Embed Linguistic Data check box
description: This article describes an issue where the Embed Linguistic Data check box is still selected after you click to clear the check box in the Word Options dialog box and then restart Word.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Languages
  - CSSTroubleshoot
appliesto: 
- Word 2013
- Word 2016
- Word 2019
- Word 2021
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 06/06/2024
---
# The "Embed Linguistic Data" setting in the "Word Options" dialog box isn't saved in Word

## Symptoms

You click to clear the **Embed Linguistic Data** check box for all documents in the **Preserve fidelity when sharing this document** section of the **Advanced** tab in the **Word Options** dialog box. However, when you then restart Microsoft Office Word, the **Embed Linguistic Data** check box is selected.

> [!NOTE]
> The **Embed Linguistic Data** check box remains cleared as long as Word is running.

## More information

The Embed Linguistic Data feature determines whether handwriting recognition correction information is stored in the Word document when you save the document in a Word 97 - 2003 format. Word doesn't support the embedding of handwriting recognition correction information when you save the document in the Word (*.docx) format.
