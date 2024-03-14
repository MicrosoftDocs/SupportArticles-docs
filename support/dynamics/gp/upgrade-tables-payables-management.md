---
title: Upgrade tables for Payables Management
description: Contains table conversions for Electronic Funds Transfer (EFT) for Payables Management and for EFT for Receivables Management in Microsoft Dynamics 10.0.
ms.reviewer: theley, lmuelle, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Upgrading tables for EFT for Payables Management and EFT for Receivables Management between versions of Microsoft Dynamics GP

This article provides a solution to an issue where the table structure for Electronic Funds Transfer (EFT) for Payables Management and EFT for Receivables Management was redesigned.

_Applies to:_ &nbsp; Microsoft Dynamics GP 2013  
_Original KB number:_ &nbsp; 944889

## Symptoms

The table structure for Electronic Funds Transfer (EFT) for Payables Management and EFT for Receivables Management was redesigned between Microsoft Dynamics GP 9.0 and Microsoft Dynamics GP 10.0. This article describes the table mapping changes between these versions.

## Cause

In Microsoft Dynamics GP 10.0, the EFT for Payables Management program code was merged with the Microsoft Dynamics GP core dictionary. Because of it, the EFT tables for Payables Management were restructured. Some EFT tables for Receivables Management were merged with the Microsoft Dynamics GP core dictionary. However, the processing is still done in the EFT for Receivables Management dictionary in Microsoft Dynamics GP 10.0 but was moved to the GP core dictionary in Microsoft Dynamics GP 2010.

## Resolution

The following tables list the EFT for Payables Management table mapping and the EFT for Receivables Management table mapping.

### Financials

|Dictionary|Table name|Table in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0|Database|Conversion information for Microsoft Dynamics GP 10.0, GP 2010, and GP 2013|
|---|---|---|---|---|
|Core|cmCheckbookEFT|ME27605, ME147204, and ME147215|Company|CM00101|
|Core|cmEFTOptionalHeader|ME147204|Company|CM00102|
|Core|cmTransactionEFTBatch|ME234603|Company|CM20203|
|Core|cmEFTLog|ME234604|Company|CM90001|
|Core|AddressEFT|ME27606 and ME147214|Company|SY06000|
|Core|VAT Country Code MSTR|ME27622|Company|VAT10001|

### EFT for Payables Management

|Dictionary|Table name|Table in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0|Database|Conversion information for Microsoft Dynamics GP 10.0, GP 2010, and GP 2013|
|---|---|---|---|---|
|Core|ME_Direct_Deposit_SETP|ME27605|Company|CM00101|
|Core|ME_Direct_Deposit_MSTR|ME27606|Company|SY06000|
|Core|ME_EFT_Countries|ME27622|System|VAT10001|
|Core|ME_EFT_Log_DTL|ME234602|Company|Updated PM Elec flag in PM20000 and in PM30200|
|Core|ME_EFT_Log_HDR|ME234603|Company|CM20203|
|Core|ME_EFT_Log_Sent|ME234604|Company|CM90001|

### EFT for Receivables Management

|Dictionary|Table name|Table in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0|Database|Conversion information for Microsoft Dynamics GP 10.0, GP 2010, and GP 2013|
|---|---|---|---|---|
|Core|ME_EFT_SETP|ME147204|Company|CM00101 and CM00102|
|Core|ME_RM_EFT_MSTR|ME147214|Company|SY06000|
|Core|ME_RM_EFT_SETP|ME147215|Company|CM00101|
|Core|ME_EFT_Countries|ME27622|System|VAT10001|

> [!NOTE]
> The table mapping only displays EFT tables that were converted between versions. Any additional EFT tables for Microsoft Dynamics GP 9.0 and earlier versions that are not listed in these table mapping were not converted.
