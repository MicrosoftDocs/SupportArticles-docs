---
title: Excel statistical functions LOGEST
description: This article describes changes to the LOGEST statistical function in Excel.
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

# Excel statistical functions: LOGEST

## Summary

This article describes the LOGEST function in Microsoft Office Excel 2003 and in later versions of Excel. It illustrates how the function is used, and it compares the results of the function in Excel 2003 and in later versions of Excel with the results of the function in earlier versions of Excel.

LOGEST is evaluated by calling the related function, LINEST. Extensive changes to LINEST for Excel 2003 and for later versions of Excel are summarized, and their implications for LOGEST are noted.

#### Microsoft Excel 2004 for Macintosh Information

The statistical functions in Microsoft Excel 2004 for Macintosh were updated by using the same algorithms as Excel 2003 and later versions of Excel. Any information in this article that describes how a function works or that describes how a function was modified for Excel 2003 and for later versions of Excel also applies to Excel 2004 for Macintosh.

## More Information

The LOGEST(known_y's, known_x's, constant, statistics) function is used to perform regression where an exponential curve is fitted. A least squares criterion is used, and LOGEST tries to find the best fit under that criterion. Known_y's represent data on the dependent variable, and known_x's represents data on one or more independent variables. The second argument is optional. If it is omitted, it is assumed to be an array of the same size as known_y's that contain the values (1, 2, 3, ...).

Assuming that there are p predictor variables, LOGEST fits an equation of the following form:

```excel
y = b * (m1^x1) * (m2^x2) * … * (mp^xp)
```

Values of the coefficients, b, m1, m2, ..., mp that give the best fit to the y data are determined.

The last argument to LOGEST is set to TRUE if you want additional statistics, including various sums of squares, r-squared, f-statistic, and standard errors of the regression coefficients. In this case, LOGEST must be entered as an array formula. The last argument is optional. If it is omitted, it is interpreted as FALSE. The dimensions of the array are five rows by a number of columns equal to the number of independent variables plus one if the third argument is set to TRUE (plus 0 if the third argument is not set to TRUE).

If the third argument "constant" is set to TRUE, you want the regression model to include the constant b in the previous equation in its model. If it is set to FALSE, the multiplicative constant b is excluded from the regression model by forcing it equal to one. The third argument is optional. If it is omitted, it is interpreted as TRUE.

In this article, assume that data is arranged in columns so that known_y's is a column of y data and known_x's is one or more columns of x data. The dimensions or lengths of each of these columns must be equal. All the following observations are equally true if the data is not arranged in columns, but it is easier to discuss the most frequently used case. Also, assume that the last argument to LOGEST is always TRUE and that you are always interested in detailed output. This supposition helps to reveal numeric problems in earlier versions of Excel. Some numeric problems are still present if you use FALSE for this argument.

This article uses the following examples to show how LOGEST relates to LINEST and to point out problems with LINEST in earlier versions of Excel that translate into problems with LOGEST. While the code for LOGEST has not been rewritten for Excel 2003 and for later versions of Excel, extensive changes and improvements in the code for LINEST have been made. LOGEST effectively calls LINEST, executes LINEST, modifies LINEST output, and presents it to you. Therefore, you should know about problems in the execution of LINEST.For additional information about LINEST, click the following article number to view the article in the Microsoft Knowledge Base:

[828533](https://support.microsoft.com/help/828533) Description of the LINEST function in Excel 2003 and in later versions of Excel

The LINEST Help file has also been revised for Excel 2003 and for later versions of Excel, and is useful for more information.Because the focus of this article is on numeric problems in earlier versions of Microsoft Excel, this article does not include many practical examples of LOGEST. The LOGEST Help file contains two useful examples.

### Syntax

```excel
LOGEST(known_y's, known_x's, constant, statistics)
```

The arguments, known_y's and known_x's, must be arrays or cell ranges that have related dimensions. If known_y's is one column by m rows, known_x's should be c columns by m rows where c is greater than or equal to one. C is the number of predictor variables; m is the number of data points. Similar relationships must hold if known_y's is laid out in a single row; in that case, known_x's should be in r rows. (R must be greater than or equal to 1.) Constant and statistics are logical arguments that must be set to TRUE or FALSE. In Excel, these arguments must be set to 0 or 1 and are interpreted by Excel as FALSE or TRUE, respectively. The last three arguments to LOGEST are all optional. If you omit the second argument, LOGEST assumes a single predictor that contains the entries {1, 2, 3, ...}. If you omit the third argument, it is interpreted as TRUE. If you omit the fourth argument, it is interpreted as FALSE.

The most common use of LOGEST includes two ranges of cells that contain the data, such as LOGEST(A1:A100, B1:F100, TRUE, TRUE). Because there is typically more than one predictor variable, the second argument in this example contains multiple columns. In this example, there are 100 subjects, one dependent variable value, known_y's, for each subject, and five dependent variable values, known_x's, for each subject.

### Example of usage

Two separate Excel worksheet examples are provided to illustrate the following key concepts:

- How LOGEST interacts with LINEST
- Problems in Microsoft Excel 2002 and in earlier versions of Excel when the third argument to LOGEST or LINEST is set to FALSE or is omitted.
- Problems because of collinear known_x's in LOGEST or LINEST in Excel 2002 and earlier.

For additional information about the second and third concepts in this list, click the following article number to view the article in the Microsoft Knowledge Base:

[828533](https://support.microsoft.com/help/828533) Description of the LINEST function in Excel 2003 and in later versions of Excel

To illustrate LOGEST with the third argument set to FALSE, follow these steps:

1. Create a blank Excel worksheet, and then copy the table later in this section.
2. Click cell A1 in your blank Excel worksheet. Then, paste the entries so that the table fills cells A1:H17 in your worksheet.
3. After you paste the table into your new Excel worksheet, click **Paste Options**, and then click **Match Destination Formatting**.
4. While the pasted range is still selected, use one of the following procedures, as appropriate for the version of Excel that you are running: 

   - In Microsoft Office Excel 2007, click the **Home** tab, click **Format** in the **Cells** group, and then click **AutoFit Column Width**.
   - In Excel 2003 and in earlier versions of Excel, point to **Column** on the **Format** menu, and then click **AutoFit Selection**.

|Third argument set to FALSE|B|C|D|E|F|G|H|
|---|---|---|---|---|---|---|---|
||||Excel 2002 and earlier versions of Excel
|||Excel 2003 and later versions of Excel||
|Y's|X's||LOGEST:|||LOGEST:||
|=EXP(A11)|1||197.495201079493|1||197.495201079493|1|
|=EXP(A12)|2||1.23717914826348|#N/A||1.23717914826348|#N/A|
|=EXP(A13)|3||-20.4285714285714|4.62910049886276||0.901250822909809|4.62910049886276|
||||-1.90666666666667|2||18.2533333333333|2|
||||-40.8571428571429|42.8571428571429||391.142857142857|42.8571428571429|
|||||||||
|LN(Y's)|X's||LINEST:|||LINEST:||
|11|=B4||5.28571428571429|0||5.28571428571429|0|
|12|=B5||1.23717914826348|#N/A||1.23717914826348|#N/A|
|13|=B6||-20.4285714285714|4.62910049886276||0.901250822909809|4.62910049886276|
||||-1.90666666666667|2||18.2533333333333|2|
||||-40.8571428571429|42.8571428571429||391.142857142857|42.8571428571429|
|||||||||
||||||using EXP:|=EXP(G11)|=EXP(H11)|

Data for LOGEST are in cells A4:B6. Detailed results for Excel 2002 and for earlier versions of Excel and for Excel 2003 and for later versions of Excel are presented in cells D4:E8 and cells G4:H8, respectively. Cells A11:B13 show the same known_x's, but the known_y's in cells A4:A6 have been transformed by taking their natural logarithm by using the Excel LN function. LINEST is then called on this transformed data, and the results are displayed in cells G11:H15. Notice that the results in cells G12:H15 are the same as the LOGEST results in cells G5:H8. The LINEST coefficients in cells G11:H11 are transformed by exponentiation. That is, the LINEST coefficients in the cells are transformed by essentially using the Excel EXP function to calculate the LOGEST coefficients in cells G4:H4. You can verify this relationship by using the EXP function in cells G17:H17. To summarize how LOGEST and LINEST interact, observe the following sequence of steps:

1. You call LOGEST(known_y's, known_x's, constant, TRUE).
2. LOGEST calls LINEST(LN of known_y's, known_x's, constant, TRUE).
3. LOGEST receives the results table from this call to LINEST.
4. LOGEST modifies LINEST coefficients in the first row of LINEST result table by exponentiation. For example, replace each LINEST coefficient, m, by EXP(m).
5. LOGEST returns this modified LINEST result table to you as the LOGEST result table.

If LOGEST is to return appropriate results, LINEST must generate appropriate results in step 3. Examine cells D13:D15. Cell D13 contains an r-squared value, cell D14 contains an f statistic, and cell D15 contains the LINEST regression sum of squares.

In Excel 2002 and in earlier versions of Excel, when LINEST is called with its third argument set to FALSE, it always computes a regression sum of squares that is not correct because it uses a formula that is not correct. This problem has been corrected in Excel 2003 and in later versions of Excel. Notice that the values in the first two rows of the output table are not affected by this problem. In Excel 2002 and in earlier versions of Excel, the LINEST article describes a workaround to generate the appropriate values in the last three rows of the LINEST output table. If you are using an earlier version of Excel and you want to set the third argument to LOGEST to FALSE, we recommend that you explicitly execute steps 2 and 3 of the previous procedure, and then use the workaround in the LINEST article to modify the last three rows of the LINEST output table.

Problems occur because of collinear known_x's in LOGEST or LINEST in Excel 2002 and in earlier versions of Excel. Predictor columns, known_x's are collinear if at least one column, c, can be expressed as a sum of multiples of others (c1, c2, and other values). Column c is called redundant because the information that it contains can be constructed from the columns (c1, c2, and other values). The fundamental principle in the presence of collinearity is that results should not be affected by whether a redundant column is included in the original data or removed from the original data. Because the version of LINEST in Excel 2002 and in earlier versions of Excel did not look for collinearity, this principle was easily violated. Predictor columns are nearly collinear if at least one column, c, can be expressed as almost equal to a sum of multiples of others (c1, c2, and other values). In this case, "almost equal" means a very small sum of squared deviations of entries in c from corresponding entries in the weighted sum of c1, c2, and other values. For example, "very small" might be less than 10^(-12).

To illustrate LOGEST collinearity, follow these steps:

1. Create a blank Excel worksheet, and then copy the following table.
2. Click cell A1 in your blank Excel worksheet. Then, paste the entries so that the table fills cells A1:N27 in your worksheet.
3. After you paste the table into your new Excel worksheet, click **Paste Options**, and then click **Match Destination Formatting**.
4. While the pasted range is still selected, use one of the following procedures, as appropriate for the version of Excel that you are running:

   - In Excel 2007, click the **Home** tab, click **Format** in the **Cells** group, and then click **AutoFit Column Width**.
   - In Excel 2003 and in earlier versions of Excel, point to **Column** on the **Format** menu, and then click **AutoFit Selection**.

|A|B|C|D|E|F|G|H|I|J|K|
|---|---|---|---|---|---|---|---|---|---|---|
|Y's|X's||||||||||
|=EXP(A23)|1|2|1||||||||
|=EXP(A24)|3|4|1||||||||
|=EXP(A25)|4|5|1||||||||
|=EXP(A26)|6|7|1||||||||
|=EXP(A27)|7|8|1||||||||
||||||||||||
|LOGEST using columns B,C:||||Values for Excel 2002 and for earlier versions of Excel:||||Values for Excel 2003 and for later versions of Excel:|||
|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||1|1.9307233720034|1.26724101129183|
|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||0|0.043859649122807|0.206652964726136|
|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||0.986842105263158|0.209426954145848|#N/A|
|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||225|3|#N/A|
|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)|=LOGEST(A2:A6,B2:C6,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||9.86842105263158|0.131578947368421|#N/A|
||||||||||||
|LOGEST using column B only|||||||||||
|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|||1.9307233720034|1.26724101129183|||1.9307233720034|1.26724101129183||
|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|||0.0438596491228071|0.206652964726136|||0.043859649122807|0.206652964726136||
|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|||0.986842105263158|0.209426954145848|||0.986842105263158|0.209426954145848||
|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|||224.999999999999|3|||225|3||
|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|=LOGEST(A2:A6,B2:B6,TRUE,TRUE)|||9.86842105263158|0.131578947368421|||9.86842105263158|0.131578947368421||
||||||||||||
|Y's|X's||||||||||
|1|1|2|||||||||
|2|3|4|||||||||
|3|4|5|||||||||
|4|6|7|||||||||
|5|7|8|||||||||
||||||||||||
|LINEST using columns B,C:||||Values for Excel 2002 and for earlier versions of Excel:||||Values for Excel 2003 and for later versions of Excel:|||
|=LINEST(A23:A27,B23:C27,TRUE,TRUE)|=LINEST(A23:A27,B23:C27,TRUE,TRUE)|=LINEST(A23:A27,B23:C27,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||0|0.657894736842105|0.236842105263158|
|=LINEST(A23:A27,B23:C27,TRUE,TRUE)|=LINEST(A23:A27,B23:C27,TRUE,TRUE)|=LINEST(A23:A27,B23:C27,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||0|0.043859649122807|0.206652964726136|
|=LINEST(A23:A27,B23:C27,TRUE,TRUE)|=LINEST(A23:A27,B23:C27,TRUE,TRUE)|=LINEST(A23:A27,B23:C27,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||0.986842105263158|0.209426954145848|#N/A|
|=LINEST(A23:A27,B23:C27,TRUE,TRUE)|=LINEST(A23:A27,B23:C27,TRUE,TRUE)|=LINEST(A23:A27,B23:C27,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||225|3|#N/A|
|=LINEST(A23:A27,B23:C27,TRUE,TRUE)|=LINEST(A23:A27,B23:C27,TRUE,TRUE)|=LINEST(A23:A27,B23:C27,TRUE,TRUE)||#NUM!|#NUM!|#NUM!||9.86842105263158|0.131578947368421|#N/A|
||||||||||||
|LINEST using column B only|||||||||||
|=LINEST(A23:A27,B23:B27,TRUE,TRUE)|=LINEST(A23:A27,B23:B27,TRUE,TRUE)|||0.657894736842105|0.236842105263159|||0.657894736842105|0.236842105263158||
|=LINEST(A23:A27,B23:B27,TRUE,TRUE)|=LINEST(A23:A27,B23:B27,TRUE,TRUE)|||0.0438596491228071|0.206652964726136|||0.043859649122807|0.206652964726136||
|=LINEST(A23:A27,B23:B27,TRUE,TRUE)|=LINEST(A23:A27,B23:B27,TRUE,TRUE)|||0.986842105263158|0.209426954145848|||0.986842105263158|0.209426954145848||
|=LINEST(A23:A27,B23:B27,TRUE,TRUE)|=LINEST(A23:A27,B23:B27,TRUE,TRUE)|||224.999999999999|3|||225|3||
|=LINEST(A23:A27,B23:B27,TRUE,TRUE)|=LINEST(A23:A27,B23:B27,TRUE,TRUE)|||9.86842105263158|0.131578947368421|||9.86842105263158|0.131578947368421||

Data is included in cells A1:C6. Entries in cells D2:D6 are not part of the data. These entries are used for illustration in the next paragraph. Results of two different calls to LOGEST are shown for Excel 2002 and for earlier versions of Excel in cells E8:G20, and for Excel 2003 and for later versions of Excel in cells I8:K20.

The first model, in rows 8 to 13, uses columns B and C as predictors and requests Excel to model the constant where the third argument set to TRUE. Excel then effectively inserts an additional predictor column that looks just like cells D2:D6. Notice that entries in column C in rows 2 through 6 are exactly equal to the sum of corresponding entries in columns B and D. Therefore, collinearity occurs because column C is a sum of multiples of column B, and the Excel additional column of 1 is inserted because the third argument to LOGEST was omitted or TRUE that is the "normal" case. This collinearity causes numeric problems, and Excel 2002 and earlier versions of Excel cannot compute results and the LOGEST output table is filled with #NUM!. 

Any version of Excel can handle the second model in rows 15 through 20. Collinearity does not occur with this model, and the user requests Excel to model the constant. This example is included here for the following two reasons:

- This example is the most typical of practical cases: no collinearity is present and the third argument to LOGEST is either TRUE or omitted. If you have an earlier version of Excel, numerical problems are not likely to occur in the most common practical case.
- Second, this example is used to compare the behavior of Excel 2003 and of later versions of Excel in the two models. Most major statistical packages analyze collinearity, remove a column that is a sum of multiples of others from the model, and alert you with a message like "Column C is linearly dependent on other predictor columns and has been removed from the analysis."

In Excel 2003 and in later versions of Excel, you receive the information in the LOGEST output table, not in a message or in a text string. A regression coefficient that is one and whose standard error is "zero" corresponds to a coefficient for a column that has been removed from the model. (See the entries in cells I9:I10 for an example.) In this case, LOGEST removes column C (coefficients in cells I9, J9, K9 correspond to columns C, B, and in the Excel constant column, respectively). When collinearity occurs, any one of the columns involved may be removed.

In the second model in rows 16 to 20, collinearity does not occur, and none of the columns are removed. The predicted y values are the same in both models because removing a redundant column that is a sum of multiples of others (the first and second models) does not reduce the goodness of fit of the resulting model. Such columns are removed precisely because they represent no value added in trying to find the best least squares fit. Also, in the output of Excel 2003 and of later versions of Excel in cells I8:K20, the last three rows of the output tables are the same, and the entries in cells I16:J17 and cells J9:K10 coincide. This demonstrates that the same results are obtained when column C is included in the model but found to be redundant (output in I9:K13) as when column C was eliminated before LOGEST was run (output in I16:J20). This output satisfies the fundamental principle in the presence of collinearity.

Collinearity is identified in LINEST in Excel 2003 and in later versions of Excel by using a completely different approach, QR Decomposition, to solve for the regression coefficients. The LINEST article describes a walkthrough of the QR Decomposition algorithm for a small example.

### Summary of results in earlier versions of Excel

LOGEST results are adversely affected in Excel 2002 and in earlier versions of Excel by results in LINEST that are not accurate.

LINEST used a formula that is not correct for the total sum of squares when the third argument in LINEST is set to FALSE. This formula resulted in values of the regression sum of squares that are not correct. Also, the values that depend on the regression sum of squares, r squared and the f statistic, are not correct. (See the workaround in the LINEST article if you are using an earlier version of Excel.) Therefore, users of LOGEST must use this workaround when they call LOGEST with the third argument set to FALSE.

Regardless of the value of the third argument, LINEST was calculated by using an approach that did not address collinearity issues. Collinearity caused round off errors, standard errors of regression coefficients that were not appropriate, and degrees of freedom that were not appropriate. In some cases, round off errors were sufficiently severe that the LINEST output table was filled with #NUM!. LINEST generally provides acceptable results if the following conditions are true:

- Users are confident that the predictor columns are not collinear (or nearly collinear).
- The third argument to LINEST is TRUE or is omitted.

Therefore, LOGEST generally provides acceptable results if the predictor columns are not collinear (or nearly collinear) and if the third argument to LOGEST is TRUE or is omitted.

### Summary of results in Excel 2003 and in later versions of Excel

The following improvements in LINEST have been made:

- The formula for the total sum of squares where the third argument to LINEST is set to FALSE was corrected.
- The QR Decomposition method is used to determine the regression coefficients.

QR Decomposition has two advantages:

- Better numeric stability (or generally smaller round off errors).
- Analysis of collinearity issues.

All the problems with Excel 2002 and with earlier versions of Excel that are discussed in this article have been corrected in Excel 2003 and in later versions of Excel.

### Conclusions

The performance of LOGEST has been improved because LINEST has been greatly improved in Excel 2003 and in later versions of Excel. If you use an earlier version of Excel, verify that the predictor columns are not collinear before you use LOGEST. Also, be careful to use the workaround that is presented in the LINEST article when the third argument to LOGEST is set to FALSE. Although this information in this article and in the LINEST article may seem alarming to users of Excel 2002 and of earlier versions of Excel, collinearity is a problem in a small percentage of cases. Calls to LOGEST with the third argument set to FALSE are probably also relatively rare in practice. Earlier versions of Excel give acceptable LOGEST results when there is no collinearity and when LOGEST's third argument is TRUE or omitted.

> [!NOTE]
> The improvements in LINEST also affect the Analysis ToolPak's linear regression tool (which calls LINEST) and two other related Excel functions: TREND and GROWTH.