---
title: Extra Access report page prints
description: Printing report results in extra page when Group Footer Force New Page property set to After Section.
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
  - Access 2010
ms.date: 03/31/2022
---

# ACCESS 2010: Extra report page prints when Group Footer set to After Section

## Symptom 

When printing a Microsoft Access 2010 report that has a Group Footer, you may see an extra page print at the end of the report. 

## Cause 

The issue occurs when the Force New Page property of a Group Footer on a report is set to "After Section". 

Microsoft is aware of this problem in Microsoft Access 2010. 

## Resolution 

To work around this problem, you can accomplish the same results by forcing a new page before the group header instead of after the group footer.

In the report's Group Header set the Force New Page property to "Before Section"
In the report's Group Footer set the Force New Page property to "None"

To do so:

1. In report Design View, select the horizontal bar for the Group Header   
2. Click the Property Sheet icon in the Ribbon   
3. On the Format tab click in the section to the right of Force New Page, click the dropdown arrow and select "Before Section"   
4. Select the horizontal bar for the Group Footer   
5. On the Property Sheet's Format tab click in the section to the right of Force New Page, click the dropdown arrow and select "None"   


## More Information 

This problem does not reproduce in previous versions of Microsoft Access.

Steps to Reproduce:

1. Open Microsoft Access 2010
2. On the File menu select Sample templates under Available Templates
3. Select the Northwind template and click Create
4. Click the double arrows above the Navigation Pane bar to expand
5. Select Reports
6. Right click the Employee Phone Book and select Design View
7. Select the File As Header bar 
8. In the Group, Sort, And Total section at the bottom, click More

    You may need to right click on the File as Header bar and select Sorting and Grouping to see the Group, Sort, and Total section)
9. Click the dropdown to the right of "without a footer section"
10. Select "with a footer section"
11. Select the File As Footer bar and click the Propert Sheet icon on the Ribbon
12. On the Format tab, click on None in the Force New Page line
13. Click the dropdown and select "After Section"
14. Select Print Preview
15. Navigate to the last page. Notice that the last page has no data on it.