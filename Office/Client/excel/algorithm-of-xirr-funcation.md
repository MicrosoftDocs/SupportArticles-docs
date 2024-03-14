---
title: Description of the algorithm used by the XIRR function in Excel
description: Describes the algorithm used by the XIRR() function in Excel to compute the internal rate of return on a schedule of cash flows that are not necessarily periodic.
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
  - Excel 2000
  - Excel 2002
  - Excel 2003
  - Excel 2007
ms.date: 03/31/2022
---

# Description of the algorithm used by the XIRR() function in Excel

## Summary

The following information describes the algorithm used by the XIRR() function in Microsoft Excel to compute the internal rate of return on a schedule of cash flows that are not necessarily periodic. That is, payments may be made at different time intervals.

## More information

Excel includes a function that is called XIRR() . This function returns the internal rate of return for a schedule of cash flows that are not necessarily periodic. This function is similar to the IRR() function that returns the internal rate of return for a series of periodic cash flows.

> [!NOTE]
> If the XIRR() function is not available, you must install the Analysis ToolPak add-in.

With IRR(), all cash flows are discounted using an integer number of compounding periods. For example, the first payment is discounted one period, the second payment two periods, and so on.

The XIRR() function permits payments to occur at unequal time periods. With this function you associate a date with each payment and thereby permit fractional periods (raising or discounting with a fractional power).

The next step is to calculate the correct discounting rate. Basically, the larger the rate, the more the values are reduced.

The XIRR() function sets bounds on the discount rate above and below the correct rate by doubling guesses in each direction. With known upper and lower bounds, the function uses Newton's method to find the appropriate guess to the level of accuracy you want.

The discounting calculation is performed after each iteration.

> [!NOTE]
> Newton's method is a way to approach the root of an equation (y=f(x)) by using the tangent line to the equation's curve at successive x-values. The new x-value keeps getting closer and closer to the root of the equation until you reach some preset precision.
