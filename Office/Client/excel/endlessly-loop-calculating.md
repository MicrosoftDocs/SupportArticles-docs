---
title: Excel endlessly loop calculating cells when inserting subtotals
description: Describes an issue in which Excel may appear to be in an endless loop calculating cells when you insert several subtotals in a workbook.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Excel 2007
- Excel 2003
---

# Excel may appear to endlessly loop calculating cells when inserting subtotals in a workbook

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you insert several subtotals in a Microsoft Excel workbook, Excel may appear to endlessly loop calculating cells.

## Cause

This behavior may occur because Excel recalculates once for each subtotal that is inserted in a workbook.

## Workaround

To work around this behavior, follow these steps, as appropriate for the version of Excel that you are running.

### Microsoft Office Excel 2007

1. Click the **Formulas** tab.
2. Click **Calculation Options** in the **Calculation** group, and then click **Manual**.
3. Select the cell in which you want the subtotal to appear.
4. Click **Math & Trig** in the **Function Library** group, and then click **SUBTOTAL**.
5. In the **Function Arguments** dialog box, make the changes that you want, and then click **OK**.
6. After you have inserted all the subtotals that you want into the workbook, click **Calculation Options** in the **Calculation** group, and then click **Automatic**.

### Microsoft Office Excel 2003

1. On the **Tools** menu, click **Options**.
2. On the **Calculation** tab, click **Manual**.
3. Click **OK**.
4. Select the cell in which you want the subtotal to appear.
5. On the **Data** menu, click **Subtotals**.
6. In the **Subtotal** dialog box, make the changes that you want, and then click **OK**.
7. After you have inserted all the subtotals that you want into your workbook, click **Options** on the **Tools**menu.
8. On the **Calculation** tab, click **Automatic**.
9. Click **OK**.