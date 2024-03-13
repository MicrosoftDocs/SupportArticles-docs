---
title: Changing depreciation-sensitive field in Asset Book
description: This article contains information about changing a depreciation-sensitive field in the Asset Book window in Fixed Asset Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.
ms.reviewer: dbader
ms.date: 03/13/2024
---
# Information about changing a depreciation-sensitive field in the Asset Book window in Fixed Asset Management in Microsoft Dynamics GP

This article contains information about changing a depreciation-sensitive field in the Asset Book window in Fixed Asset Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855314

## More information

When you change a depreciation-sensitive field in the Asset Book window in Microsoft Dynamics GP, you receive the following message:

> You have changed a depreciation sensitive field. This will result in depreciation values being recalculated. Do you wish to continue?

You receive this message because depreciation amounts must be recalculated when a depreciation-sensitive field is changed for an asset. When you select **Yes**, the following options are available:

- Life
- Year
- Recalculate

### Option information about Life

The **Life** option recalculates depreciation beginning with the **Place in Service** date through the dates that the asset has already been depreciated. If depreciation amount adjustments are needed for any period, the adjustments will update the Financial Detail file. Prior year depreciation amounts are posted to the current fiscal year to the prior year depreciation account. Prior year deprecation amounts do not post to the prior year.

> [!NOTE]
> Selecting the **Life** option may not be the best option for the following reasons:

- The **Life** option will significantly increase the size of the Financial Detail (FA00902) table. This will create more data for the posting routine to process.
- If the **LTD Depreciation** field or the **YTD Depreciation** field is ever manually changed by a user, the depreciation amounts will be recalculated.

### Option information about Year

The **Year** option recalculates depreciation from the beginning of the Fixed Asset calendar year through the dates that the asset has already been depreciated. If depreciation amount adjustments are needed for any period, the adjustments will update the Financial Detail file.

### Option information about Recalculate

The **Recalculate** option calculates a new rate of depreciation by using the new cost basis. The **Recalculate** option does not make adjusting entries for depreciation amounts already taken. The system will use the new rate of depreciation the next time that the depreciation routine is run.

## Field information

The following fields are depreciation-sensitive fields:

- Amortization Code
- Amortization Amt/Pct
- Averaging Convention
- Cost Basis
- Depreciation Method
- Luxury Automobile
- Original Life Year, Days
- Place in Service Date
- Salvage Value
- Special Depr Allowance
- Switchover

The following fields are automatically recalculated. You will not receive a message that you have changed a depreciation-sensitive field:

- Depreciated To Date
- LTD Depreciation
- YTD Depreciation
