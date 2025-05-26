---
title: Excel statistical functions GROWTH
description: Explains changes to the GROWTH statistical function in Excel.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - Editing\Functions
  - CSSTroubleshoot
appliesto: 
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
  - Excel 2004 for Mac
ms.date: 05/26/2025
---

# Excel statistical functions: GROWTH

## Summary

This article describes the GROWTH function in Excel, illustrates how the function is used, and compares results of the function for Excel 2003 and for later versions of Excel with results of GROWTH in earlier versions of Excel. GROWTH is evaluated by calling the related function, LINEST. Extensive changes to LINEST for Excel 2003 and for later versions of Excel are summarized, and their implications for GROWTH are noted.

#### Microsoft Excel 2004 for Macintosh information

The statistical functions in Excel 2004 for Mac were updated by using the same algorithms that were used to update the statistical functions in Excel 2003 and in later versions of Excel. Any information in this article that describes how a function works or how a function was modified for Excel 2003 or for later versions of Excel also applies to Excel 2004 for Mac.

## More Information

The GROWTH(known_y's, known_x's, new_x's, constant) function is used to perform a regression analysis where an exponential curve is fitted. A least squares criterion is used, and GROWTH tries to find the best fit under that criterion. Known_y's represent data on the "dependent variable" and known_x's represent data on one or more "independent variables". The GROWTH Help file discusses rare cases where the second or third argument may be omitted.

Assuming that there are p predictor variables, GROWTH essentially calls LOGEST. LOGEST fits an equation of the form:

```excel
y = b * (m1^x1) * (m2^x2) * ... * (mp^xp)
```

Values of the coefficients, b, m1, m2, ..., mp are determined that give the best fit to the y data.

If the last argument "constant" is set to TRUE, you want the regression model to include the multiplicative coefficient b in the regression model. If set to FALSE, b is excluded by essentially setting it to 1. The last argument is optional; if the argument is omitted it's interpreted as TRUE.

For ease of exposition in the remainder of this article, assume that data is arranged in columns so that known_y's is a column of y data and known_x's is one or more columns of x data. The dimensions (lengths) of each of these columns must be equal. New_x's will also be assumed to be arranged in columns and there must be the same number of columns for new_x's as for known_x's. All our observations below are equally true if the data isn't arranged in columns, but it's easier to discuss the single (most frequently used) case.

After you compute the best fit regression model (by essentially calling Excel's LOGEST function), GROWTH returns predicted values that are associated with new_x's.

This article uses examples to show how GROWTH relates to LOGEST and to point out problems with LOGEST in versions of Excel that are earlier than Excel 2003 that translate to problems with GROWTH. GROWTH effectively calls LOGEST, executes LOGEST, uses regression coefficients in LOGEST output in its calculation of predicted y values that are associated with each row of new_x's, and presents this column of predicted y values to you. Therefore, you must know about problems in the execution of LOGEST. When LOGEST is called, it in turn effectively calls LINEST. While code for GROWTH and LOGEST hasn't been rewritten for Excel 2003 and for later versions of Excel, extensive changes (and improvements) in LINEST code have been made.

As supplements to this article, the following article about LINEST is highly recommended. It contains several examples and documents problems with LINEST in versions of Excel that are earlier than Excel 2003.

For more information about LINEST, select the following article number to view the article in the Microsoft Knowledge Base:

[828533](https://support.microsoft.com/help/828533) Description of the LINEST function in Excel 2003 and in Excel 2004 for Mac

The LINEST Help file, as revised for Excel 2003, is also recommended.

The following article about LOGEST explains how LOGEST interacts with LINEST. These details are omitted here.

For more information, see [Excel statistical functions: LOGEST](https://support.microsoft.com/help/828528).

Because the focus in this article is on numeric problems in versions of Excel that are earlier than Excel 2003, this article doesn't have many practical examples of the use of GROWTH. The Help file in GROWTH contains useful examples.

### Syntax

```excel
GROWTH(known_y's, known_x's, new_x's, constant)
```

The arguments, known_y's, known_x's, and new_x's must be arrays or cell ranges that have related dimensions. If known_y's is one column by m rows, then known_x's is c columns by m rows where c is greater than or equal to one. C is the number of predictor variables; m is the number of data points. New_x's must then be c columns by r rows where r is greater than or equal to one. (Similar relationships in dimensions must hold if data is laid out in rows instead of columns.) Constant is a logical argument that must be set to TRUE or FALSE (or 0 or 1 that Excel interprets as FALSE or TRUE, respectively). The last three arguments to GROWTH are all optional; see the GROWTH Help file for options of omitting the second argument, third argument, or both; omitting the fourth argument is interpreted as TRUE.

The most common usage of GROWTH includes two ranges of cells that contain the data, such as GROWTH(A1:A100, B1:F100, B101:F108, TRUE). Because there is typically more than one predictor variable, the second argument in this example contains multiple columns. In this example, there are 100 subjects, one dependent variable value (known_y) for each subject, and five dependent variable values (known_x's) for each subject. There are eight more hypothetical subjects where you want to use GROWTH to compute predicted y values.

### Example of usage

An Excel worksheet example is provided to illustrate the following key concepts:

- How GROWTH interacts with LOGEST
- Problems that occur with GROWTH (or LOGEST and LINEST) because of collinear known_x's in versions of Excel that are earlier than Excel 2003

> [!NOTE]
> An extensive discussion of the second bulleted item in the context of LINEST is provided in the article about LINEST.

To illustrate the GROWTH function, create a blank Excel worksheet, copy the following table, select cell A1 in your blank Excel worksheet and then paste the entries so that the table following fills cells A1:K35 in your worksheet.

|A|B|C|D|E|F|G|H|I|J|K|
|---|---|---|---|---|---|---|---|---|---|---|
|y:|x's:||||||||||
|=EXP(F2)|1|2|1||1||||||
|=EXP(F3)|3|4|1||2||||||
|=EXP(F4)|4|5|1||3||||||
|=EXP(F5)|6|7|1||4||||||
|=EXP(F6)|7|8|1||5||||||
|new x's:|9|11|||||||||
||12|14|||||||||
||||||||||||
|GROWTH using columns B,C:||||Values for Excel 2002 and for earlier versions of Excel:
||||Values for Excel 2003 and for later versions of Excel:|||
|=GROWTH(A2:A6,B2:C6,B7:C8,TRUE)||||#NUM!||||472.432432563203|||
|=GROWTH(A2:A6,B2:C6,B7:C8,TRUE)||||#NUM!||||3400.16400895377|||
||||||||||||
|GROWTH using col B only|||||||||||
|=GROWTH(A2:A6,B2:B6,B7:B8,TRUE)||||472.432432563203||||472.432432563203|||
|=GROWTH(A2:A6,B2:B6,B7:B8,TRUE)||||3400.16400895377||||3400.16400895377|||
||||||||||||
|Fitted values from the LOGEST results in Excel 2003 and in later versions of Excel|||||||||||
|Using cols B, C||Using Col B|||||||||
|=EXP(LN(K24)*1 + LN(J24)*B7 + LN(I24)*C7)||=EXP(LN(J31)*1 + LN(I31)*B7)|||||||||
|=EXP(LN(K24)*1 + LN(J24)*B8 + LN(I24)*C8)||=EXP(LN(J31)*1 + LN(I31)*B8)|||||||||
||||||||||||
|LOGEST using columns B,C:||||Values for Excel 2002 and for earlier versions of Excel:||||Values for Excel 2003 and for later versions of Excel:|||
|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||1|1.9307233720034|1.26724101129183|
|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||0|0.043859649122807|0.206652964726136|
|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||0.986842105263158|0.209426954145848|#N/A|
|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||225|3|#N/A|
|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||9.86842105263158|0.131578947368421|#N/A|
||||||||||||
|LOGEST using col B only|||||||||||
|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|||1.9307233720034|1.26724101129183|||1.9307233720034|1.26724101129183||
|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|||0.0438596491228071|0.206652964726136|||0.043859649122807|0.206652964726136||
|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|||0.986842105263158|0.209426954145848|||0.986842105263158|0.209426954145848||
|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|||224.999999999999|3|||225|3||
|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|||9.86842105263158|0.131578947368421|||9.86842105263158|0.131578947368421||

> [!NOTE]
> After you paste this table in your new Excel worksheet, select the **Paste Options** button, and then select **Match Destination Formatting**. With the pasted range still selected, use one of the following procedures, as appropriate for the version of Excel that you're running:

> - In Microsoft Office Excel 2007, select the **Home** tab, select **Format** in the **Cells** group and then select **AutoFit Column Width**.
> - In Excel 2003, point to **Column** on the **Format** menu, and then select **AutoFit Selection**.

Data for GROWTH are in cells A1:C8. (Entries in cells D2:D6 are not part of the data, but are used for illustration below.) Results of GROWTH for two different models for both earlier versions of Excel and for later versions of Excel are presented in cells E10:E16 and I10:116, respectively. Results in cells A10:A16 will correspond to the version of Excel that you are using. For now, focus on the results for Excel 2003 and for later versions of Excel when you investigate how GROWTH calls LOGEST and how GROWTH uses LOGEST results.

GROWTH and LOGEST can be viewed as interacting in the following steps:

1. You call GROWTH(known_y's, known_x's, new_x's, constant)
2. GROWTH calls LOGEST(known_y's, known_x's, constant, TRUE)
3. Regression coefficients from this call to LOGEST are obtained. These coefficients appear in the first row of LOGEST's output table.
4. For each new_x's row, the predicted y-value is calculated based on these LOGEST coefficients and the new_x's values in that row.
5. The calculated value in step 4 is returned in the appropriate cell for GROWTH output that corresponds to that new_x's row.

If GROWTH is to return appropriate results, then LOGEST must generate appropriate results in step 3. Because the evaluation of LOGEST in step 3 requires a call to LINEST, it is essential that LINEST be well behaved. Problems with LINEST in versions of Excel that are earlier than Excel 2003 come from collinear predictor columns. (There are other problems with LINEST and LOGEST in the earlier versions of Excel that occur when the last argument to GROWTH is set to FALSE. However, those problems do not affect the results of GROWTH, and are not discussed here.)

Predictor columns (known_x's) are collinear if at least one column, c, can be expressed as a sum of multiples of others, c1, c2, and other columns. Column c is frequently called redundant because the information that it contains can be constructed from the columns c1, c2, and other columns. The fundamental principle in the existence of collinearity is that results should be unaffected by whether a redundant column is included in the original data or removed from the original data. Because LINEST in versions of Excel that are earlier than Excel 2003 did not look for collinearity, this principle was easily violated. Predictor columns are almost collinear if at least one column, c, can be expressed as almost equal to a sum of multiples of others, c1, c2, and other columns. In this case "almost equal" means a small sum of squared deviations of entries in c from corresponding entries in the weighted sum of c1, c2, and other columns. "Very small" might be less than 10^(-12), for example.

The first model, in rows 10 to 12, uses columns B and C as predictors and requests Excel to model the constant (last argument set to TRUE). Excel then effectively inserts an additional predictor column that looks just like cells D2:D6. It is easy to notice that entries in column C in rows 2 to 6 are exactly equal to the sum of corresponding entries in columns B and D. Therefore, there is collinearity present because column C is a sum of multiples of the following items:

- Column B
- Excel's additional column of 1s that is inserted because the third argument to LOGEST was omitted or TRUE (the "normal" case)

This causes such numeric problems that versions of Excel that are earlier than Excel 2003 cannot compute results. Therefore, the GROWTH output table is filled with #NUM!.

The second model, in rows 14 to 16, is one that any version of Excel can handle successfully. There is no collinearity, and the user again requests Excel to model the constant. This model is included here for the following reasons:

- First, it's most typical of practical cases: that there's no collinearity present. These cases are handled sufficiently in all versions of Excel. It should be reassuring to know that numeric problems aren't likely to occur in the most common practical case if you have an earlier version of Excel.
- Second, this example is used to compare the behavior of Excel 2003 and of later versions of Excel in the two models. Most major statistical packages analyze collinearity, remove a column that is a sum of multiples of others from the model, and alert the user with a message such as "column C is linearly dependent on other predictor columns and has been removed from the analysis."

In Excel 2003 and in later versions of Excel, such a message is conveyed not in an alert or in a text string, but in the LOGEST output table. GROWTH has no mechanism for delivering such a message to the user. In the LOGEST output table, a regression coefficient that is one, and whose standard error is zero, corresponds to a coefficient for a column that has been removed from the model. LOGEST output tables are included in rows 23 to 35 corresponding to the GROWTH output in rows 10 to 16. The entries in cells I24:I25 show an eliminated redundant predictor column. In this case, LOGEST chose to remove column C (coefficients in cells I24, J24, K24 correspond to columns C, B, and Excel's constant column, respectively). When there's collinearity present, any one of the columns involved can be removed and the choice is arbitrary.

In the second model in rows 30 to 35, there's no collinearity and no column removed. You can see that the predicted y values are the same in both models. This issue occurs because removing a redundant column that is a sum of multiples of others doesn't reduce the goodness of fit of the resulting model. Such columns are removed precisely because they represent no value added in trying to find the best least squares fit. Also, if you examine the LOGEST output in cells I23:K35 in Excel 2003 and in later versions of Excel, you notice that the last three rows of the output tables are the same. Additionally, the entries in cells I31:J32 and cells J24:K25 coincide. It demonstrates that the same results are obtained when column C is included in the model, but found to be redundant (output in cells I24:K28) as when column C was eliminated before LOGEST was run (output in cells I31:J35). This satisfies the fundamental principle in the existence of collinearity.

In cells A18:C21, Microsoft uses data from Excel 2003 and from later versions of Excel to illustrate how GROWTH takes LOGEST output and computes the relevant predicted y-values. By examining the formulas in cells A20:A21 and cells C20:C21, you can see how LOGEST coefficients are combined with new_x's data in cells B7:C8 for each of the two models (using columns B, C as predictors; using only column B as a predictor).

Collinearity is identified in LOGEST in Excel 2003 and in later versions of Excel because LOGEST calls LINEST. LINEST uses a different approach to solving for the regression coefficients. This approach is QR Decomposition. The LINEST article contains a walkthrough of the QR Decomposition algorithm for a small example.

### Summary of results in earlier versions of Excel

GROWTH results are adversely affected in versions of Excel that are earlier than Excel 2003 because of inaccurate results in LOGEST that, in turn, stem from inaccurate results in LINEST.

LINEST was calculated using an approach that paid no attention to collinearity issues. The existence of collinearity caused round off errors, inappropriate standard errors of regression coefficients, and inappropriate degrees of freedom. Sometimes round off problems are sufficiently severe that LINEST filled its output table with #NUM!. If, as in most cases in practice, you can be confident that there weren't collinear (or almost collinear) predictor columns, then LINEST would generally provide acceptable results. Therefore, users of GROWTH can be similarly reassured if they can see the absence of collinear (or almost collinear) predictor columns.

### Summary of results in Excel 2003 and in later versions of Excel

Improvements in LINEST include switching to the QR Decomposition method of determining regression coefficients. QR Decomposition has the following advantages:

- Better numeric stability (generally, smaller round off errors)
- Analysis of collinearity issues

All problems with versions of Excel that are earlier than Excel 2003 that are illustrated in this article have been corrected for Excel 2003 and for later versions of Excel. These improvements in LINEST translate to improvements in LOGEST and GROWTH.

### Conclusions

GROWTH's performance has been improved because LINEST has been greatly improved for Excel 2003 and for later versions of Excel. Improvements in LINEST also affect LOGEST, because LOGEST is called by GROWTH. Users of earlier versions of Excel should verify that predictor columns aren't collinear before they use GROWTH.

Much of the material presented in this article and in the LINEST article might at first appear to alarm to users of versions of Excel that are earlier than Excel 2003. However, it should be noted that collinearity is a problem in only a small percentage of cases. Earlier versions of Excel give acceptable GROWTH results when there's no collinearity.

Fortunately, improvements in LINEST also affect the Analysis ToolPak's linear regression tool (this tool calls LINEST) and two other related Excel functions: LOGEST and TREND.
