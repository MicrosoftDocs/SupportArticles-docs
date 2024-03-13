---
title: Determine when asset begins to depreciate or when asset is considered discontinued
description: How to determine when an asset begins to depreciate or when an asset is considered discontinued in Fixed Asset Management in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 03/13/2024
---
# How to determine when an asset begins to depreciate or when an asset is considered discontinued in Fixed Asset Management

This article describes the following:

- How to determine when an asset begins to depreciate in Fixed Asset Management in Microsoft Dynamics GP.
- How to determine when an asset is considered discontinued in Fixed Asset Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858658

## More information

The value in the **Averaging Convention** field in the Asset Book window determines when the asset begins to depreciate and when the asset is considered discontinued. To open the Asset Book window, point to **Fixed Assets** on the **Cards** menu, and then select **Book**.

The following are the definitions of the available averaging conventions:

- Full Month
- Next Month
- Full Period
- Next Period
- Full Year
- Next Year
- Full Year All Year
- Half Year Convention
- Modified Half Year Convention
- Mid-Quarter
- Mid-Month (1st)
- Mid-Month (15th)
- None

> [!NOTE]
> The fields that are listed in the definitions are in the following windows:
>
> - The **Place in Service Date** field is in the Asset Book window.
> - The **Averaging Convention** field is in the Asset Book window.
> - The **Retirement Date** field is in the Retirement Display window.
>
> To open the Retirement Display window, point to **Fixed Assets** in the Inquiry window, select **Retirement**, and then double-click the appropriate line.

### Full Month

Assets that use the Full Month value in the **Averaging Convention** field and a value in the **Place in Service Date** field during the month begins to depreciate on the first day of the month.

Assets that are discontinued during the month are considered discontinued on the last day of the month earlier than the date in the **Retirement Date** field.

> [!NOTE]
> The Full Month averaging convention works with the calendar year in the Fixed Assets calendar.

### Next Month

Assets that use the Next Month value in the **Averaging Convention** field and a value in the **Place in Service Date** field during the month begin to depreciate on the first day of the next month.

Assets that are discontinued during the month are considered discontinued on the last day of the month of the date in the **Retirement Date** field.

> [!NOTE]
> The Next Month averaging convention works with the calendar year in the Fixed Assets calendar.

### Full Period

Assets that use the Full Period value in the **Averaging Convention** field and a value in the **Place in Service Date** field during the period begin to depreciate on the first day of the period.

Assets that are discontinued during the period are considered discontinued on the last day of the period earlier than the date in the **Retirement Date** field.

> [!NOTE]
> The Full Period averaging convention works with the fiscal year in the Fixed Assets calendar.

### Next Period

Assets that use the Next Period value in the **Averaging Convention** field and a value in the **Place in Service Date** field during the period begin to depreciate on the first day of the next period.

Assets that are discontinued during the period are considered discontinued on the last day of the period of the date in the **Retirement Date** field.

> [!NOTE]
> The Next Period averaging convention works with the fiscal year in the Fixed Assets calendar.

### Full Year

Assets that use the Full Year value in the **Averaging Convention** field and a value in the **Place in Service Date** field in the first half of the year receive the full yearly amount of depreciation beginning from the value in the **Place in Service Date** field. Assets that use a value in the **Place in Service Date** field in the second half of the year receive half of the yearly amount of depreciation beginning from the value in the **Place in Service Date** field.

Assets that use a date in the **Retirement Date** field during the first half of the year are considered discontinued on the last day of the earlier year. Assets that use a date in the **Retirement Date** field during the second half of the year are considered discontinued on the last day of the first half of the year.

### Next Year

Assets that use the Next Year value in the **Averaging Convention** field and a value in the **Place in Service Date** field during the year begin to depreciate on the first day of the next year.

Assets that are discontinued during the year are considered discontinued on the last day of the year in the **Retirement Date** field.

### Full Year All Year

Assets that use the Full Year All Year value in the **Averaging Convention** field begin to depreciate on the first day of the year.

Assets that use a date in the **Retirement Date** field during the year are considered discontinued on the last day of the earlier year.

### Half Year Convention

An asset that uses the Half Year Convention value in the **Averaging Convention** field begins to depreciate on the date in the **Place in Service Date** field. However, in the first year of the asset's life and in the last year of the asset's life, only half of the yearly depreciation rate is considered. The asset does not depreciate after the first half of its final year. For example, an asset that uses the Half Year Convention has a yearly depreciation rate of $800. $400 is calculated the first year whether the date in the **Place in Service Date** field is 1/1 or is 12/15.

The asset also is considered discontinued on the last day of the first half of the year of retirement. Depreciation is considered or is backed out accordingly. If an asset is discontinued in the first year of its life, no depreciation is considered.

### Modified Half Year Convention

An asset that uses the Modified Half Year Convention value in the **Averaging Convention** field and a value in the **Place in Service Date** field in the first half of the year begins to depreciate on the first day of the year. If the value in the **Place in Service Date** field is in the second half of the year, the asset begins to depreciate on the first day of the next year.

If the date in the **Retirement Date** field is in the first half of the year, the asset is considered discontinued on the last day of the earlier year. If the date in the **Retirement Date** field is in the second half of the year, the asset is considered discontinued on the last day of the year.

### Mid-Quarter

An asset that uses the Mid-Quarter value in the **Averaging Convention** field and a value in the **Place in Service Date** field at any time in the quarter begins to depreciate on the middle day of the second month of the quarter in the **Place in Service Date** field.

Assets that are discontinued during the quarter are considered discontinued on the middle day of the second month of the quarter in the **Retirement Date** field.

### Mid-Month (1st)

An asset that uses the Mid-Month (1st) value in the **Averaging Convention** field and a value in the **Place in Service Date** field in the first half of the month (day 1 through day 15) begins to depreciate on the first day of the month of the value in the **Place in Service Date** field. If the value in the **Place in Service Date** field is in the second half of the month (day 16 through the end of the month), the asset begins to depreciate on the first day of the next month.

If the date in the **Retirement Date** field is in the first half of the month (day 1 through day 15), the asset is considered discontinued on the last day of the earlier month. If the date in the **Retirement Date** field is in the second half of the month (day 16 through the end of the month), the asset is considered discontinued on the last day of the month.

> [!NOTE]
> The Mid-Month (1st) averaging convention works with the calendar year in the Fixed Assets calendar.

### Mid-Month (15th)

An asset that uses the Mid-Month (15th) value in the **Averaging Convention** field and a value in the **Place in Service Date** field at any time in the month begins to depreciate on the 15th of the month of the value that is displayed in the **Place in Service Date** field. Assets that have a value in the **Place in Service Date** field in February begin to depreciate on the 14th of the month.

Assets that are discontinued at any time in the month are considered discontinued on the 15th of the month in the **Retirement Date** field. Assets that are discontinued in February are considered discontinued on the 14th of the month.

> [!NOTE]
> The Mid-Month (15th) averaging convention works with the calendar year in the Fixed Assets calendar.

### None

Assets that use the None value in the **Averaging Convention** field begin to depreciate on the date that is displayed in the **Place in Service Date** field.

Assets are considered discontinued on the date in the **Retirement Date** field.
