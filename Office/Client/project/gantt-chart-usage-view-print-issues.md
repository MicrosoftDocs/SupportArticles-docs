---
title: Gantt Chart view or Usage view print on too many pages
description: Describes an issue where Gantt Chart view or Usage views print on too many pages in Project. Provides a solution.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: timj
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Project Professional 2003
  - Microsoft Office Project Standard 2003
  - Project Professional 2010
  - Project Standard 2010
  - Project Professional 2013
  - Project 2013 Standard
ms.date: 05/26/2025
---

# Gantt Chart view or Usage view print on too many pages in Project

## Symptoms

In Microsoft Project, when you print or print preview a Gantt Chart view or a Usage view, task bars or columns of data may be printed on more pages than necessary, or you may see an additional timescale beyond the end of your project.

## Workaround

To work around this behavior in Project 2010 & 2013, use any of the following methods.

### Method 1: Manually Adjust the Timescale

If the Fit Timescale to End of Page option is selected, turn off this option, and manually change the timescale. To do this, follow these steps:

1. On the File tab, click Print, and then click Page Setup.   
2. Click the View tab.   
3. Click to clear the Fit timescale to end of page check box.   
4. Click OK. If you do not get the result you want, continue to the next step. 
5. Click the View tab.   
6. Back in the Project plan click View. On the Timescale drop-down list, click Timescale.   
7. In the Size box, reduce the percentage to reduce the width of the timescale, Increase the percentage to increase the width of the timescale.   
8. Click OK.   

### Method 2: Fit Timescale to End of Page

The Fit Timescale to End of Page option enlarges or reduces the width of the timescale to match the end of a page. This prevents a page from being printed with bars or data on only a small fraction of the pages, which would result in an additional blank timescale beyond the last bar or column of data.

To turn on the Fit Timescale to End of Page option, follow these steps:

1. On the File tab, click Print, and then click Page Setup.   
2. Click the View tab.   
3. Click to select the Fit Timescale to End of Page check box.   
4. Click OK   

### Method 3: Scale the Entire Project

If you want to scale the entire project (not just the timescale portion as in method 1), scale the entire project to fit the number of pages you want. To do this, follow these steps:

1. On the File tab, click Print, and then click Page Setup.   
2. Click the Page tab.   
3. Choose the scaling option you want to use.   
4. Print your project.   

> [!NOTE]
> When you scale your project for printing, the project information is scaled proportionally for height and width.

To work around this behavior in Project 2007 and earlier versions, use any of the following methods.

### Method 1: Manually Adjust the Timescale

If the **Fit Timescale to End of Page** option is selected, turn off this option, and manually change the timescale. To do this, follow these steps:

1. On the File menu, click Page Setup.   
2. Click the View tab.   
3. Click to clear the **Fit timescale to end of page** check box.   
4. Click Print Preview. If you do not get the result you want, continue to the next step.   
5. Click the Close button on the toolbar in print preview.   
6. On the Format menu, click Timescale.   
7. In the Size box, reduce the percentage to reduce the width of the timescale. Increase the percentage to increase the width of the timescale.   
8. Click OK.   

### Method 2: Fit Timescale to End of Page

The **Fit Timescale to End of Page** option enlarges or reduces the width of the timescale to match the end of a page. This prevents a page from being printed with bars or data on only a small fraction of the pages, which would result in an additional blank timescale beyond the last bar or column of data.

To turn on the **Fit Timescale to End of Page** option, follow these steps:

1. On the File menu, click Page Setup.   
2. Click the View tab.   
3. Click to select the **Fit Timescale to End of Page** check box.   
4. Click OK.

### Method 3: Scale the Entire Project

If you want to scale the entire project (not just the timescale portion as in method 1), scale the entire project to fit the number of pages you want. To do this, follow these steps:

1. On the File menu, click Page Setup.   
2. Click the Page tab.   
3. Choose the scaling option you want to use.   
4. Print your project.

> [!NOTE]
> When you scale your project for printing, the project information is scaled proportionally for height and width.
