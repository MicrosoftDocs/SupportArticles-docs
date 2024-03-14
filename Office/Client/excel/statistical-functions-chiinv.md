---
title: Excel statistical functions CHIINV
description: Describes the CHIINV function in  Excel 2003 and in later versions of Excel, and discusses an improvement in later versions of Excel that can affect results in extreme cases when compared with earlier versions of Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.date: 03/31/2022
---

# Excel statistical functions CHIINV

## Summary

This article describes the CHIINV function in Microsoft Office Excel 2003 and in later versions of Excel and discusses an improvement in Excel 2003 and in later versions of Excel that can affect results in extreme cases when compared with earlier versions of Excel.

## More Information

CHIINV(p, df) is the inverse function for CHIDIST(x, df). For any particular x, CHIDIST(x, df) returns the probability that a Chi-Square-distributed random variable with df degrees of freedom is greater than or equal to x.

The CHIINV(p, df) function returns the value x where CHIDIST(x, df) returns p. Therefore, CHIINV is evaluated by a search process that returns the appropriate value of x by evaluating CHIDIST for various candidate values of x until it finds a value of x where CHIDIST(x, df) is "acceptably close" to p.

### Syntax

```excel
CHIINV(p, df)
```

> [!NOTE]
> In this example, p is a probability with 0 < p < 1 and df >= 1 is the number of degrees of freedom. Because in practice df is an integer; if a non-integer value is used, Excel will truncate it (round it down) to an integer value.

### Example of usage

To illustrate the CHIINV function, create a blank Excel worksheet, copy the following table, select cell A1 in your blank Excel worksheet, and then paste the entries so that the table fills cells A1:F21 in your worksheet.

|A|B|C|D|E|F|
|---|---|---|---|---|---|
|||actual|sales|||
||0|1|2|3 or more||
|before|13|8|5|4|=SUM(B3:E3)|
|during|8|10|6|6|=SUM(B4:E4)|
||=SUM(B3:B4)|=SUM(C3:C4)|=SUM(D3:D4)|=SUM(E3:E4)|=SUM(B5:E5)|
|||||||
|||expected|sales|||
||0|1|2|3 or more||
|before|=$F$3*B5/$F$5|=$F$3*C5/$F$5|=$F$3*D5/$F$5|=$F$3*E5/$F$5||
|during|=$F$4*B5/$F$5|=$F$4*C5/$F$5|=$F$4*D5/$F$5|=$F$4*E5/$F$5||
|||||||
|||(actual - expected)^2|/ expected|||
||0|1|2|3 or more||
|before|=((B3-B9)^2)/B9|=((C3-C9)^2)/C9|=((D3-D9)^2)/D9|=((E3-E9)^2)/E9||
|during|=((B4-B10)^2)/B10|=((C4-C10)^2)/C10|=((D4-D10)^2)/D10|=((E4-E10)^2)/E10||
|||||||
|=SUM(B14:E15)||||||
|=CHIDIST(A17,3)||||||
|=CHITEST(B3:E4,B9:E10)||||||
|=CHIINV(A18,3)||||||
|=CHIINV(0.05,3)||||||
 
After you paste this table into your new Excel worksheet, click the **Paste Options** button, and then click **Match Destination Formatting**. With the pasted range still selected, use one of the following procedures, as appropriate for the version of Excel that you are running:

- In Microsoft Office Excel 2007, click the **Home** tab, click **Format** in the **Cells** group, and then click **AutoFit Column Widths**.
- In Excel 2003, point to **Column** on the **Format** menu, and then click **AutoFit Selection**.

To test the effectiveness of a sale, a store records the number of deluxe freezers sold per day for 30 days before the sale and for 30 days during the sale (see note 1). The data is in cells B3:E4. The Chi-Square statistic is calculated by first finding the expected numbers in each of these cells. These expected sales numbers are in cells B9:E10. Cells B14:E15 show the quantities that must be summed to calculate the Chi-Square statistic that is shown in cell A17. With r = 2 rows and c = 4 columns in the data table, the number of degrees of freedom is (r – 1) * (c – 1) = 3. The CHIDIST value in cell A18 shows the probability of a Chi-Square value higher than that in A17 under the null hypothesis that actual sales and before or during are independent. CHITEST semi-automates the process by requiring only B3:E4 and B9:E10 as inputs. It essentially deduces the number of degrees of freedom and calculates the Chi-Square statistic and then returns CHIDIST for that statistic and number of degrees of freedom. A20 shows the inverse relationship between CHIDIST and CHIINV. Finally, A21 uses CHIINV to find the cutoff value for the Chi-Square statistic assuming a significance level of 0.05. In this example, with this significance level, you would not reject the null hypothesis of independence between actual sales and before or during because the Chi-Square statistic value was 1.90, well below the cutoff of 7.81.

> [!NOTE]
> This example comes from the long out of print text: Bell, C.E., Quantitative Methods for Administration, Irwin, 1977.

### Results in earlier versions of Excel

CHIINV(p, df) is found through an iterative process that repeatedly evaluates CHIDIST(x, df) and returns a value of x such that CHIDIST(x, df) is "acceptably close" to p. Therefore accuracy of CHIINV depends on the following factors:

- The accuracy of CHIDIST
- The design of the search process and definition of "acceptably close"

In rare cases, "acceptably close" in earlier versions of Excel might not be close enough. This is unlikely to affect most users. Basically, if you request CHIINV(p, df) the search continues until a value of x is found where CHIDIST(x, df) differs from p by less than 0.0000003.

### Results in Excel 2003 and in later versions of Excel

No changes were made to CHIDIST in Excel 2003 and in later versions of Excel. The only change that affects CHIINV was to redefine "acceptably close" in the search process to be much closer. The search now continues until the closest possible value of x is found (in the limits of Excel's finite precision arithmetic). The resulting x should have a CHIDIST(x, df) value that differs from p by about 10^(-15).

### Conclusions

Many inverse functions have been improved for Excel 2003 and for later versions of Excel. Some have been improved for Excel 2003 and for later versions of Excel only by continuing the search process to gain a higher level of refinement. This set of inverse functions includes the following functions: BETAINV, CHIINV, FINV, GAMMAINV, and TINV.

No modifications were made to the respective functions that are called by the following inverse functions: BETADIST, CHIDIST, FDIST, GAMMADIST, and TDIST.

Additionally, this same improvement in the search process was made for NORMSINV in Microsoft Excel 2002. For Excel 2003 and for later versions of Excel, accuracy of NORMSDIST (called by NORMSINV) was improved also. These changes also affect NORMINV and LOGINV (these call NORMSINV) and NORMDIST and LOGNORMDIST (these call NORMSDIST).