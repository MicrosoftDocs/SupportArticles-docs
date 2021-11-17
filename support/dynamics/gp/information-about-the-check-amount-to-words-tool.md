---
title: Information about Check Amount to Words tool
description: Provides information about the Check Amount to Words tool in Microsoft Dynamics GP.
ms.reviewer: kriszree
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Information about the "Check Amount to Words" tool in Microsoft Dynamics GP

This article contains information about the **Check Amount to Words** tool in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 961423

The **Check Amount to Words** tool is a feature that lets you print the decimal currency in words on a Payables Management check or a Payroll check.

Consider the following scenario:

You have more than two decimal places set up for the company currency in the Currency Setup window. You want to print a check with the value of $105.52. The **Check Amount to Words** tool will print the check amount in words to show only two decimals (per your currency ID setup). The check will display the value as One Hundred Five Dollars and 52 cents instead of One Hundred Five Dollars and 52000 cents in the wording.

The check printed like this:

One Hundred Five Dollars and 52000 cents  $105.52000

You want the check to print like this:

One Hundred Five Dollars and 52 cents  $105.52

## Resolution

- To fix the cents in the **wording**, you must mark the **Decimal Place Tool** in PSTL.  
- To fix the cents on the **check amount** field on the right side of the check, follow [Showing only two decimal places on checks in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-showing-only-two-decimal-places-on-checks-in-microsoft-dynamics-gp-f37cc89c-b6a6-eaa4-6db2-c7b2d575160f). This must be done in **report writer**.

### Steps for Microsoft Dynamics GP 2010 and higher versions

In Microsoft Dynamics GP 2010 and higher versions, the Check Amount to Words feature is now available in [Professional Tools Services Library](/dynamics-gp/installation/profservicestoolslibrary).

1. To change the **wording**, access PSTL, and find the **Decimal Place Tool** under the **Misc. Tools** section. You can activate it by marking the second/middle checkbox next to it (not the radio button on the right) and it will change the wording on the check for both Payables Management and Payroll checks. This will only change the wording on the check.
2. To change the actual **Check Amount** field on the right side of the check, you will need to modify the amount in Report Writer to only display two decimals. See [Showing only two decimal places on checks in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-showing-only-two-decimal-places-on-checks-in-microsoft-dynamics-gp-f37cc89c-b6a6-eaa4-6db2-c7b2d575160f).

3. For any rounding issues with the check amount, you must also use [How to round a calculated field in Report Writer in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-how-to-round-a-calculated-field-in-report-writer-in-microsoft-dynamics-gp-c91199a5-daeb-2185-600f-c8e7f38b7877).

> [!NOTE]
> You should use the Decimal Place Tool in PSTL on current Microsoft Dynamics GP versions. Do not install the cnk below, as that may cause conflict. The cnk is for Microsoft Dynamics GP 10.0 and prior versions ands should not be used in current versions.

### Steps for Microsoft Dynamics GP 10.0 and prior versions

To install the **Check Amount to Words** tool for older Microsoft Dynamics GP versions, you must use the cnk file. Follow these steps:

1. Have all users exit Microsoft Dynamics GP.
2. Download the [chkkwords.zip](https://mbs2.microsoft.com/fileexchange/?fileID=339b354a-d206-4d1d-80e4-9396498874f3) file.  
3. Extrace the chkwords.cnk file to a temporary location.
4. Copy the chkworkds.cnk to the Microsoft Dynamics GP code folder. By default, the Microsoft Dynamics GP code folder in the following location:  
   `C:\\Program Files (x86)\Microsoft Dynamics \GP`

5. Start Microsoft Dynamics GP.
6. Select **Yes** when prompted to include new code.
7. Repeat step 5 and 6 on each computer on which Microsoft Dynamics GP is installed.
8. To change the actual amount field on the right side of the check, you will need to modify the amount in Report Writer to only display two decimals. For more information,see [Showing only two decimal places on checks in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-showing-only-two-decimal-places-on-checks-in-microsoft-dynamics-gp-f37cc89c-b6a6-eaa4-6db2-c7b2d575160f).

## More information

For any rounding issues with the amount, you must use the following article as well:

[How to round a calculated field in Report Writer in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-how-to-round-a-calculated-field-in-report-writer-in-microsoft-dynamics-gp-c91199a5-daeb-2185-600f-c8e7f38b7877).
