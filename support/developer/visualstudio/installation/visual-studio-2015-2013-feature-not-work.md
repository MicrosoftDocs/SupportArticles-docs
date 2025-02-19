---
title: Visual Studio 2013 and 2015 features don't work
description: Provides a resolution for an issue where some Visual Studio 2013 and 2015 features don't work as expected if Internet Explorer 10 or a later version isn't installed.
ms.date: 10/27/2020
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---
# Visual Studio 2013 and 2015 features don't work as expected if Internet Explorer 10 or a later version isn't installed

This article helps you resolve an issue where some Visual Studio 2013 and 2015 features don't work as expected if Internet Explorer 10 or a later version isn't installed.

_Original product version:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 2906882

## Symptoms

In Visual Studio 2013 and Visual Studio 2015, the following features don't work as expected when Internet Explorer 10 or a later version isn't installed:

> [!NOTE]
> This issue affects only Windows 7 users. Users of Windows 8 and later versions aren't affected because the required dependencies for the browser are built into those operating systems.

### IntelliTrace: Performance Details page isn't displayed as expected in Visual Studio 2013

When you use [IntelliTrace](/visualstudio/debugger/intellitrace) to examine a log file that contains a performance violation event, you experience issues after you select **View Details** to view more details about the violation. The **Performance Details** page contains information about the execution tree of a performance violation event. However, if Internet Explorer 10 or a later version isn't installed, the **Execution Tree** section is blank and you receive an error message.

### Debug Managed Memory feature displays a blank page in Visual Studio 2013

When you open a managed dump file that contains heap information, the summary page includes a **Debug Managed Memory** option. If Internet Explorer 10 or a later version isn't installed when you select this option, the document window that is opened is blank and you receive an error message. If this issue occurs, you can safely ignore the error and close the document window.

### Load Test Runner results aren't displayed as expected in Visual Studio 2013

Consider the following scenario:

- You run Load Testing by using Team Foundation Service.

- You select the **Load Test Manager**  and **Load Test Runner**  options.

In this scenario, if Internet Explorer 10 or a later version isn't installed, the page that shows information about the test results isn't displayed correctly.

### JavaScript Console and DOM Explorer windows aren't display as expected in Visual Studio 2013

When you use Visual Studio 2013 for Web development, and you don't have Internet Explorer 11 installed, the JavaScript Console and DOM Explorer windows don't display as expected. These features require Internet Explorer 11. If you're using Internet Explorer 10, you receive an error message that states that these features are unsupported by your current browser. If you're using Internet Explorer 9 or an earlier version, the browser window is blank but you don't receive the error message.

### Debugging tool windows aren't displayed in Visual Studio 2015

When you debug an application in Visual Studio 2015, several new debugging tool windows aren't displayed as expected and may also generate an error message. These windows and tools include **Diagnostics**, **CPU Usage**, **Memory Usage**, and **Application Timeline**.

### Cloud Explorer extension window isn't displayed in Visual Studio 2015

If you install the Cloud Explorer for Visual Studio 2015, this new extension window to browse resources on Azure isn't displayed correctly and may generate an error message.

## Cause

These issues occur because Visual Studio 2013 and Visual Studio 2015 have features that work best together with Internet Explorer 10 or later versions. If Internet Explorer 10 or a later version isn't installed, these features don't work as expected.

## Resolution

To resolve these issues, install [Internet Explorer 10](https://support.microsoft.com/topic/internet-explorer-downloads-d49e1f0d-571c-9a7b-d97e-be248806ca70). For full support of JavaScript Console and DOM Explorer, install [Internet Explorer 11](https://support.microsoft.com/office/internet-explorer-help-23360e49-9cd3-4dda-ba52-705336cc0de2?ui=en-US&rs=en-US&ad=US).

## Applies to

This article also applies to:

- Visual Studio Enterprise 2015
- Visual Studio Professional 2015
- Visual Studio Community 2015
- Visual Studio Express 2015 for Web
- Visual Studio Ultimate 2013
- Visual Studio Premium 2013
- Visual Studio Professional 2013
- Visual Studio Express 2013 for Web
