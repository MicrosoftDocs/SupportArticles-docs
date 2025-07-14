---
title: Removing sensitivity label does not remove headers and footers in Word for Microsoft 365
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 06/06/2024
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Word for Microsoft 365
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Privacy\AIP
  - CI 122599
  - CSSTroubleshoot
ms.reviewer: amdey
description: Describes a resolution an issue where header and footer artifacts remain after changing the sensitivity label in a Word for Microsoft 365 document.
---

# Headers and footers remain after removing sensitivity label in Word for Microsoft 365

## Symptoms

After removing a sensitivity label from a Word for Microsoft 365 document,  the **Sensitivity** dropdown displays the correct sensitivity level, but the headers, footers, and other artifacts of the previous level remain. 

## Resolution

Microsoft has released an update for Word to correct this issue. Any documents created after August 12, 2020, will not be affected. Any documents created between May 21, 2020, and August 12, 2020, may still be affected by this issue. 

To resolve this issue on any affected document, perform the following steps: 

1.	Open the impacted document.
2.	Select the **Sensitivity** drop-down to apply a non-protected label.
3.	Wait five seconds.
4.	Use the **Sensitivity** drop-down to deselect the previously applied label.
5.	Close the document.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
