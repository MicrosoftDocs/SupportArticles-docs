---
title: Trouble shoot performance issues
description: A table of common performance symptoms and solutions.
author: Lance Delano
ms.custom: sap:App Creation (Canvas App)
ms.reviewer: lanced, aartigoyle
ms.date: 04/04/2024
ms.author: lanced
search.audienceType: 
  - maker 
search.app: 
  - PowerApps
contributors:
  - aartigoyle
---
# Power Apps canvas app troubleshooting performance table

This table shows common issues you might encounter while using a Power Apps canvas app with likely causes and recommendations. High level issues are associated with likely causes and recommendations that link to more detailed documentation. Note that some recommendations occur multiple times because the root cause manifests multiple symptoms.



| Problem / Symptom       | Likely cause    | Recommendations |
| ---|---|---|
| Slow app/page load times | •	 Overloaded OnStart<br> •	 Large data sets<br> •	 Many controls <br> •	 Heavy media files    | •	 [Move calculations out of OnStart](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/working-with-large-apps#use-appformulas-instead-of-apponstart) <br> •	[Use small data payloads]( https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/small-data-payloads) <br>  •	[Defer loading data](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/efficient-calculations#defer-significant-updates-to-a-nonblocking-ui-step) <br> •	[Optimize resource usage – media, controls, references](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/fast-app-page-load#minimize-required-resources)  |
| Large data payloads    | •	 Retrieving unnecessary data<br> •	 Large data sets <br>    |•	[Use small data payloads]( https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/small-data-payloads)<br>•	[Use delegation](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/small-data-payloads#use-delegation) <br> •	[Pre-filter data at source](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/optimized-query-data-patterns#use-server-side-views) <br> •	[Limit data retrieval](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/small-data-payloads#suggestions) |
| Inefficient data queries | •	 Non-delegable queries<br> •	 Complex data operations <br>    |•	[Use delegation](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/small-data-payloads#use-delegation) <br> •	[Optimize query patterns](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/optimized-query-data-patterns) |
| Inefficient calculations | •	 Complex formulas<br> •	 Repeated calculations <br>    |•	[Optimize formulas](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/efficient-calculations#calculations) <br> •	[Split up long formulas](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/working-with-large-apps#split-up-long-formulas)|
| Overall slow app performance | •	 Ineffcient data retrieval<br> •	 Excessive controls<br> •	 Complex formulas<br>  •	 App is too large | •	[Optimize data sources]( https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/optimized-query-data-patterns) <br>  •	Reduce control count <br> •	[Optimize formulas](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/fast-app-page-load#avoid-directly-populating-a-collection-with-large-amounts-of-data) <br> •	[Use collections for small, frequently used data]( https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/fast-app-page-load#avoid-directly-populating-a-collection-with-large-amounts-of-data) <br> •	[Split up App](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/working-with-large-apps#partition-the-app) |

