---
title: Cannot Resize the Chart Area of a chart
description: Describe an issue where you can't resize the Chart Area of a chart located on a Chartsheet. This is designed.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
search.appverid: 
- MET150
appliesto:
- Excel 2010
- Excel 2013
- Excel 2016
---

# Cannot Resize the Chart Area of a chart located on a Chartsheet

## Symptoms

Starting from Excel 2010,  you cannot adjust the size of the chart area when the chart is located on a chart sheet. Excel 2007 would allow you to resize the chart area.

Consider this scenario:

1. When you try to resize charts on a chart sheet, Excel displays the resize handle, but it won't let you resize the chart.
2. After upgrading a file created in Excel 2007 if the chart is positioned to be small on the chart sheet, it will snap to maximum size on the chart sheet. 

## More Information

This behavior was changed in Excel 2010 and later versions, which is the intended design. 

Alternatives to resizing the chart area on the chart sheet include:

- Resize the plot area and position other elements to match.
- Embed the chart in the worksheet instead of a chart sheet. To do this, follow these steps: 

    1. Highlight the chart.   
    2. On the Chart Toolsribbon choose Design   
    3. Click on Move Chart   
    4. Choose where you want the chart to be placed: Object in: Choose the worksheet tab you want to place it.    
    5. Click OK.   
