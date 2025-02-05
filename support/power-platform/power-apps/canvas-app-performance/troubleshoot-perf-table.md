---
title: Troubleshoot Power Apps canvas app Performance Issues
description: Troubleshoot common performance issues in Power Apps canvas app.
author: lancedMicrosoft
ms.custom: sap:Canvas App Performance
ms.reviewer: lanced, aartigoyle
ms.date: 02/05/2025
ms.author: lanced
search.audienceType: 
  - maker 
search.app: 
  - PowerApps
contributors:
  - aartigoyle
---
# Troubleshoot Power Apps canvas app performance issues

> [!TIP]
> For performance issues, you can use profiling tools like [Monitor](/power-apps/maker/monitor-overview) and [Performance insights](/power-apps/maker/common/performance-insights-overview) to debug and diagnose problems.

The following table outlines common performance issues you might encounter while using a canvas app along with likely causes and recommendations. High-level issues are linked to more detailed documentation through their associated causes and recommendations. Some recommendations might appear multiple times, as the root cause can manifest in various symptoms.

| Problem / Symptom   | Likely cause  | Recommendations |
| ---|---|---|
| Slow app/page load times | - Overloaded OnStart<br> - Large data sets<br> - Many cross-screen references <br> - Heavy media files    | - [Move calculations out of OnStart](/power-apps/maker/canvas-apps/working-with-large-apps#use-appformulas-instead-of-apponstart) <br> - [Use small data payloads](/power-apps/maker/canvas-apps/small-data-payloads) <br>  - [Defer loading data](/power-apps/maker/canvas-apps/efficient-calculations#defer-significant-updates-to-a-nonblocking-ui-step) <br> - [Optimize resource usage – media, controls, references](/power-apps/maker/canvas-apps/fast-app-page-load#minimize-required-resources)  |
| Large data payloads    | - Retrieving unnecessary data<br> - Large data sets <br>    |- [Use small data payloads](/power-apps/maker/canvas-apps/small-data-payloads)<br>- [Use delegation](/power-apps/maker/canvas-apps/small-data-payloads#use-delegation) <br> - [Prefilter data at source](/power-apps/maker/canvas-apps/optimized-query-data-patterns#use-server-side-views) <br> - [Limit data retrieval](/power-apps/maker/canvas-apps/small-data-payloads#suggestions) |
| Inefficient data queries | - Nondelegable queries<br> - Complex data operations <br>    |- [Use delegation](/power-apps/maker/canvas-apps/small-data-payloads#use-delegation) <br> - [Optimize query patterns](/power-apps/maker/canvas-apps/optimized-query-data-patterns) |
| Inefficient calculations | - Complex formulas<br> - Repeated calculations <br>    |- [Optimize formulas](/power-apps/maker/canvas-apps/efficient-calculations#calculations) <br> - [Split up long formulas](/power-apps/maker/canvas-apps/working-with-large-apps#split-up-long-formulas)|
| Overall slow app performance | - Inefficient data retrieval<br> - Many cross-screen references<br> - Complex formulas<br>  - App is too large | - [Optimize data sources](/power-apps/maker/canvas-apps/optimized-query-data-patterns) <br> - [Optimize formulas](/power-apps/maker/canvas-apps/efficient-calculations#calculations) <br> - [Use collections for small, frequently used data](/power-apps/maker/canvas-apps/fast-app-page-load#avoid-directly-populating-a-collection-with-large-amounts-of-data) <br> - [Split up App](/power-apps/maker/canvas-apps/working-with-large-apps#partition-the-app) |

## More information

For an overview of how to create a performant canvas app, see the [Overview of creating performant apps](/power-apps/maker/canvas-apps/create-performant-apps-overview).

For more information and guidance on creating performant apps, see:

- [Small data payloads](/power-apps/maker/canvas-apps/small-data-payloads)
- [Optimized data query patterns](/power-apps/maker/canvas-apps/optimized-query-data-patterns)
- [Speed up app or page load](/power-apps/maker/canvas-apps/fast-app-page-load)
- [Fast calculations](/power-apps/maker/canvas-apps/efficient-calculations)

For more information on debugging canvas apps and performance issues, see:

- [Understand canvas app execution phases and performance monitoring](/power-apps/maker/canvas-apps/execution-phases-data-flow)
- [Creating performant apps](/power-apps/maker/canvas-apps/create-performant-apps-overview)
- [Common canvas app performance issues and resolutions](/power-apps/maker/canvas-apps/common-performance-issue-resolutions)
- [Debugging canvas apps with Monitor](/power-apps/maker/monitor-canvasapps)

For issues with functionality or performance issues with model-driven apps, see [Power Apps troubleshooting strategies](~/power-platform/power-apps/create-and-use-apps/isolate-common-issues.md).
