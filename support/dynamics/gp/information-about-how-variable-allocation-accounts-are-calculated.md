---
title: How variable allocation accounts are calculated
description: This article contains the information about how variable allocation accounts are calculated in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# Information about how variable allocation accounts are calculated in Microsoft Dynamics GP

This article describes how variable allocation accounts are calculated in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0. Variable allocation accounts use the absolute value of the breakdown accounts in Microsoft Dynamics GP. Variable allocation accounts do not consider whether the breakdown accounts have a debit balance or a credit balance.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 922058

## More information

The following tables provide an example of how Microsoft Dynamics GP calculates the allocation by using the absolute value of the breakdown accounts.

### Variable allocation account 000-6180-00

|Distribution accounts|Breakdown accounts|Breakdown balance|
|---|---|---|
|100-6180-00|100-9010-00|$200 debit|
|200-6180-00|200-9010-00|$200 debit|
|300-6180-00|300-9010-00|$400 debit|
|400-6180-00|400-9010-00|$200 credit|
  
If you post a $10,000 debit to the variable allocation account, Microsoft Dynamics GP uses the absolute values of the breakdown accounts to determine the breakdown account balances. If you add the absolute values, the total of all the breakdown accounts is $1,000.

|Breakdown accounts|Total|
|---|---|
|100-9010-00|$200 ÷ $1,000 = 20%|
|200-9010-00|$200 ÷ $1,000 = 20%|
|300-9010-00|$400 ÷ $1,000 = 40%|
|400-9010-00|$200 ÷ $1,000 = 20%|
  
The following information is posted to the distribution accounts.

|Distribution accounts|Total|
|---|---|
|100-6180-00|$10,000 × 20% = $2,000|
|200-6180-00|$10,000 × 20% = $2,000|
|300-6180-00|$10,000 × 40% = $4,000|
|400-6180-00|$10,000 × 20% = $2,000|
|Total amount that is posted|$10,000|
