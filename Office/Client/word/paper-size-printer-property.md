---
title: The paper size for a document does not match paper size in Printer Properties
description: Describes the problem where the paper size for a document in Word 2010 does not match the paper size in printer properties.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: azhiruta, tonyca
search.appverid: 
- MET150
appliesto:
- Word 2010
- Word 2013
---

# The paper size for a document in Word 2010 does not match the paper size in the Printer Properties dialog box

## Symptoms

Consider the following scenario:

- You have a computer that has Microsoft Word 2010 installed.   
- You create a new Word document.    
- On the **File** tab, you click **Print**.   
- You have the **Paper size** set to either **Letter** (for the English language) or **A4** (for Japanese or other East Asian languages).   
- Under the listed printer, you click **Printer Properties**.   
In this scenario, the paper size is listed as **A3** instead of **Letter** or **A4** in the **Printer Properties** dialog box. 

**Note** This issue occurs only for specific printer drivers.

## Cause

This problem occurs because Word 2010 specifies an invalid value for the paper size when it communicates with the printer driver. This problem does not occur for most printer drivers, because most printer drivers ignore this invalid value when it is sent.

## Workaround

To work around this problem, set the paper size to a size other than Letter or A4, and then set the paper size back again. This updates the cached value for the paper size, and the correct value for the paper size is sent to the printer driver.

Consider the following example: 

A Word 2010 document that uses the A4 paper size is experiencing this problem. To work around this problem, follow these steps:

1. On the **File** tab, click **Print**.   
2. Change the **Paper size** from **A4** to **Legal**.   
3. Change the **Paper size** from **Legal** back to **A4**.   
4. Click **Printer Properties**. The paper size is now set to **A4**.   

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
