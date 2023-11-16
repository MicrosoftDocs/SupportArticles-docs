---
title: Rendering issue with SSRS report in Internet Explorer
description: This article describes an issue where reports are not rendering as expected in Internet Explorer 8 and later versions in standards mode.
ms.date: 07/22/2020
ms.custom: sap:Reporting Services
---
# Rendering issues with SQL Server Reporting Services reports in Internet Explorer

This article lists various issues where reports are not rendering as expected in Internet Explorer 8 and later versions in standards mode.

_Original product version:_ &nbsp; SQL Server 2012 Enterprise  
_Original KB number:_ &nbsp; 2967090

## Summary

You may encounter various issues with Microsoft SQL Server Reporting Services (SSRS) reports in which reports are not rendering as expected in Internet Explorer 8 and later versions in standards mode (also known as documents mode). The issues are as follows:

- Dynamics CRM dashboard reports and other reports are not rendering correctly. Specifically, the reports are shrunk and are displayed in a narrow column instead of in the whole browser page.
- Report alignment is skewed in Reporting Services SharePoint mode and native mode.
- Because SSRS fully supports Internet Explorer quirks mode, Dynamics CRM customers cannot perform customizations. Customizations are supported only in Internet Explorer standards mode.
- Because SSRS fully supports Internet Explorer quirks mode, customers who are using a custom application to integrate with SSRS cannot use Internet Explorer standards mode as a default.
- Export options disappear when a report is rendering in Internet Explorer standards mode.
- Drill-down performance decreases significantly in Internet Explorer standards mode.
- When you select the `WritingMode` property of Rotate270 (this specifies bottom up vertical text) in a text box and then render a report in SharePoint integrated mode (SharePoint Server 2010 or a later version), you experience a severe decrease in text clarity when the report is displayed in the browser. The text is much less clear in standards mode (this is the SharePoint default) in Internet Explorer 7 and later versions than it is in Internet Explorer 5 quirks mode.
- When you run System Center Configuration Manager reports on clients that are using Internet Explorer 11 browser, you experience a freeze. These reports are indeed render in accordance with the SSRS log. However, the client sees the green spinning wheel and the report never seems to render. This issue can be fixed by setting Internet Explorer 11 to quirks mode.
- In versions of Internet Explorer later than Internet Explorer 7, if we zoom in on Rotate270 text in a report, the text will spill outside the bounds of the text box that is meant to contain it. Therefore, the text becomes partly or completely obscured.

> [!NOTE]
> SSRS reports supports Internet Explorer only in quirks mode. This behavior is by design. For more information, see: [Planning for Reporting Services and Power View Browser Support](/previous-versions/sql/sql-server-2012/ms156511(v=sql.110))  

### Browser requirements for Report Manager

To run Report Manager and to use Report Manager to view reports, Windows Internet Explorer 7 or a later version is required, and scripting must be enabled. Report Manager supports only quirks mode and does not support standards mode. If you are using a browser in standards mode, you may experience window size issues and scroll bars that are not always visible.

## More information

Our product team is committed to up-to-date browser support. This includes Internet Explorer standards mode. However, because this mode is the basis for report rendering, the fix is fairly comprehensive and cannot be included in a cumulative update or service pack for Reporting Services. We will update this article when there is a change in support policy for standards mode.
