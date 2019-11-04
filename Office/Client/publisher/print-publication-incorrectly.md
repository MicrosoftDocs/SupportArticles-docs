---
title: Publication is printed incorrectly
description: Provides a workaround for a problem in which a publication is printed incorrectly in Publisher 2010 or 2013 even though the print preview is displayed correctly.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: lisyu
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Publisher 2013
- Publisher 2010
---

# A publication is printed incorrectly in Publisher 2010 or 2013

## Symptoms

Consider the following scenario. In Microsoft Publisher, you select a sheet size that is larger than the maximum sheet size that is supported by the printer. For example, the maximum sheet size is A4, and the sheet size that you select is A3. You print the publication. In this scenario, the publication is not printed in the A3 sheet size. However, in print preview, the publication is displayed correctly.

## Cause

Publisher generates the print preview based on the information that the printer driver provides. However, there are three things that the printer driver may report incorrectly: the list of supported sheet sizes, duplex printing capabilities, and color printing capabilities. For example, the printer driver may exhibit the following behavior:  

- The printer driver lets you select a sheet size that is not supported by the printer itself.    
- The printer driver incorrectly reports that the printer has duplex printing capabilities.   
- The printer driver incorrectly reports that the printer has color printing capabilities.   

## Workaround

To work around this problem, you have to determine whether the printer supports the special needs of the document, such as printing on a larger sheet size, duplex printing, and printing in color.

> [!NOTE]
> Some printer drivers have the option to scale the content to the size of the sheet. To enable this setting in Publisher 2010, follow these steps:

1. Click the **File** tab, and then click **Print**.    
2. In the **Printer** section, click **Printer Properties**.    
3. Click the **Effects** tab.    
4. In the **Resize Options** section, click to select the **Print document on** option, and then click to select the **Scale to fit** check box.    
5. Click **OK**.
