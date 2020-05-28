---
title: Total row of a table isn't displayed in waterfall charts
description: Provides workarounds for an issue in which waterfall charts ignore the total row of a table in Excel 2016.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.reviewer: anitao, lauraho
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Excel 2016
---

# "Total" row of a table isn't displayed in waterfall charts in Excel 2016

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

##  Symptoms

After you create a waterfall chart for a table that contains a "total" row and also contains a column of positive and negative numbers in Microsoft Excel 2016, the total isn't displayed in the waterfall chart.

##  Workaround

To work around this issue, use one of the following methods:

- Copy the table, paste the values of the table to a new location, and then create a new waterfall chart by using the copied data.   
- Convert the table back to a normal range by using the Convert to Range function, and then create a waterfall from the range.   


##  More Information

Waterfall charts are new in Excel 2016. They show the cumulative effect of sequentially introduced positive or negative values. Waterfall charts are also known as a flying brick charts, bridge charts, or Mario charts because of the apparent suspension of columns (bricks) in midair. Waterfall charts are mainly used in the financial industry but also in other industries where it's important to report and visualize resource consumption.

##  Status

Microsoft has confirmed this to be a problem in Excel 2016. We are researching this problem and will post new information in this Microsoft Knowledge Base article as soon as the information becomes available.