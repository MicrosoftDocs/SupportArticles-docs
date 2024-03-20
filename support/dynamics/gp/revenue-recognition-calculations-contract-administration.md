---
title: Revenue Recognition calculations for Contract Administration
description: This article explains that the revenue that is recognized each month is based upon the liability type that you select for the contract in Great Plains.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Field Service Series
---
# Revenue Recognition calculations for Contract Administration are based on the liability type that is in Great Plains Field Service Series

This article explains that the revenue that is recognized each month is based upon the liability type that you select for the contract in Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 889755

## Summary

Explains that the revenue that is recognized each month in Microsoft Great Plains is based on the liability type that you select for the contract. Discusses the five different liability types with examples of their use.

## Introduction

In the Microsoft Great Plains Field Service Series, Revenue Recognition Entries are created in the **Contract Revenue Recognition** window. To open this window, point to **Contract Admin** on the **Transactions** menu, and then click **Revenue Recognition**. Contract Administration uses various calculations to create the contract revenue recognition entries. The calculations that are used depend upon the liability type of the contract.

Contracts can have the following different liability types:

- Straight-Line
- Block Time
- Retainage
- Based on Calls
- MeteredEnter the liability types in the **Contract Entry/Update** window.

To open this window, point to **Contract Admin** on the **Transactions** menu, and then click **Contract Entry/Update**. The **Liability Type** field becomes available when the Billing Frequency setting is set to something that is different from Monthly.

## Straight-Line

The Straight-Line liability type recognizes the contract line extended amount evenly over the length of the contract line.

For example, an extended price of $2400.00 for a 12-month contract will recognize $200 for each month ($2400/12 = $200) if the contract is billed on the first of the month. If the contract is billed any other day of the month, the revenue recognition will use 13 recognition periods and recognize 1/13 a month for 13 months.

## Block Time

The Block Time liability type is used for contracts where the coverage is for the number of hours that is specified on each contract line. In the **Contract Entry/Update** window, after you have entered the contract line, you can click the expansion button that is next to **Item Number** to open the **Contract Line** window. You can enter the number of hours that are covered for that contract line in the **Blocked Time** field. As service calls that are taken against the contract line are billed, the **Value of Time** field is updated with the cumulative hours of the service calls that are for that contract line. The following formula is used to determine the amount of revenue to be recognized on that contract line during the next process run of Revenue Recognition:

(Value of Time / Block Time) x Extended price

For example, you have an extended price of $2400.00 for a 12-month contract for 20 hours of service. Four service calls with a total of nine hours were billed against the contract line. The amount of revenue that will be recognized is $1080.00:

(9 hrs / 20 hrs) x $2400 = $1080

## Retainage

The Retainage liability type is used for contracts where the coverage is for a specified amount of money. In the **Contract Entry/Update** window, after you have entered the contract line, you can click the expansion button that is next to **Item Number** to open the **Contract Line** window. You can enter the value of service calls that are covered for that contract line in the **Retainage Amount** field. As service calls that are taken against the contract line are billed, the **Retainage Billed** field is updated with the total value of the service calls that are for that contract line. The following formula is used to determine the amount of revenue to be recognized on that contract line during the next process run of Revenue Recognition:

(Retainage Billed / Retainage Amount) x Extended price

For example, you have an extended price of $2400.00 for a 12-month contract for $3000.00 of service. Four service calls with a total value of $900.00 were billed against the contract line. The amount of revenue that will be recognized is $720.00:

($900 / $3000) x $2400 = $720

## Based on Calls

The Based on Calls liability type is used for contracts where the coverage is for the number of calls that is specified on each contract line. In the **Contract Entry/Update** window, after you have entered the contract line, you can click the expansion button that is next to **Item Number** to open the **Contract Line** window. You can enter the number of calls that are covered for that contract line in the **Max Calls** field. As service calls that are taken against the contract line are billed, the Actual Calls field is updated with the cumulative number of service calls that are for that contract line. The following formula is used to determine the amount of revenue to be recognized on that contract line during the next process run of Revenue Recognition:

(Actual Calls / Max Calls) x Extended price. For example, you have an extended price of $2400.00 for a 12-month contract for 10 service calls. Four service calls are billed against the contract line. The amount of revenue that will be recognized is $960.00:

(4 calls / 10 calls) x $2400 = $960

## Metered

The Metered liability type is used for contracts where the coverage is for the base metered value that is specified on each contract line. After you have entered the contract line, click **Meters** to enter the base meter reading that is covered for that contract line in the **Contract Line Meter Maintenance** window. As meter readings are posted against the serial master, the system records the entry into the **Serial Maintenance Readings** window and then recalculates the daily usage for the meter or meters that were entered. This calculation is based on the previous meter reading to determine the number of days and amount that is used. The current usage divided by the number of days will produce a daily usage during that time period. Then, this value is added to the previous daily usage, and then this value is divided by 2. The result will be a smoothed running daily usage. The following formula is used to determine the amount of revenue to be recognized on that contract line during the next process run of Revenue Recognition:

(Accumulated Usage / Base Meters) x Extended price. For example, you have an extended price of $2400.00 for a 12-month contract for a base meter reading of 40,000. The accumulated usage is 7890. The amount of revenue that will be recognized is $473.40:

(7890 / 40000) x $2400 = $473.40
