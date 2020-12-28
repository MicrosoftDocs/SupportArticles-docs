---
title: Visual Studio 2015 and 2013 features doesn't work
description: This article provides a resolution for the problem where some Visual Studio 2015 and Visual Studio 2013 features doesn't work as expected if Internet Explorer 10 or a later version is not installed.
ms.date: 10/27/2020
ms.prod-support-area-path: installation
---
# Visual Studio 2015 and 2013: Known issues if Internet Explorer 10 or a later version is not installed

This article helps you resolve the problem where some Visual Studio 2015 and Visual Studio 2013 features doesn't work as expected if Internet Explorer 10 or a later version is not installed.

_Original product version:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 2906882

## Symptoms

Some Microsoft Visual Studio 2015 and Visual Studio 2013 features do not work as expected when Internet Explorer 10 or a later version is not installed. This problem affects only Windows 7 users. Users of Windows 8 and later versions are not affected because the required dependencies for the browser are built into those operating systems.

The following features are known not to work as expected if Internet Explorer 10 or a later version is not installed:

Visual Studio 2013

## Visual Studio 2013

IntelliTrace: Performance Details page is not displayed as expected

When you use IntelliTrace to examine a log file that contains a performance violation event, you experience issues after you click to view more details about the violation. The **Performance Details** page contains information about the execution tree of a performance violation event. However, if Internet Explorer 10 or a later version is not installed, the **Execution Tree** section is blank and you receive an error message.

Debug Managed Memory feature displays a blank page and an error message

When you open a managed dump file that contains heap information, the summary page includes a **Debug Managed Memory** option. If Internet Explorer 10 or a later version is not installed when you click this option, the document window that opens is blank and you receive an error message. If this occurs, you can safely ignore the error and close the document window.

Load Testing by using Team Foundation Service: Load Test Runner results are not displayed as expected

You do the following:

- You run Load Testing by using Team Foundation Service.

- You select the **Load Test Manager**  and **Load Test Runner**  options. If Internet Explorer 10 or a later version is not installed when you take these actions, the page that shows information about the test results is not displayed correctly.

JavaScript Console and DOM Explorer windows are not displayed as expected

When you use Visual Studio 2013 for Web development and you do not have Internet Explorer 11 installed, the JavaScript Console and DOM Explorer windows are not displayed as expected. These features require Internet Explorer 11. If you are using Internet Explorer 10, you receive an error message that states that these features are unsupported by your current browser. If you are using Internet Explorer 9 or an earlier version, the browser window is blank but you do not receive the error message.

## Visual Studio 2015

Debugger and diagnostics tools

When you debug an application in Visual Studio 2015, several new debugging tool windows are not displayed as expected and may also generate an error message. These windows and tools include **Diagnostics**, **CPU Usage**, **Memory Usage**, and **Application Timeline**.

Cloud Explorer

If you install the Cloud Explorer for Visual Studio 2015, this new extension window to browse resources on Azure is not displayed correctly and may generate an error message.

## Cause

These problems occur because Visual Studio 2015 and Visual Studio 2013 have features that work best together with Internet Explorer 10 or later versions. If Internet Explorer 10 or a later version is not installed, these features do not work as expected.

## Resolution

To resolve these problems, [install Internet Explorer 10](https://support.microsoft.com/topic/internet-explorer-downloads-d49e1f0d-571c-9a7b-d97e-be248806ca70). For full support of JavaScript Console and DOM Explorer, [install Internet Explorer 11](https://support.microsoft.com/office/internet-explorer-help-23360e49-9cd3-4dda-ba52-705336cc0de2?ui=en-US&rs=en-US&ad=US).

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
