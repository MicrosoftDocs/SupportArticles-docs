---
title: Can't dismiss developer license notifications
description: This article discusses that you can't dismiss developer license notifications in Visual Studio 2013 Update 4 and provides an update to resolve the problem.
ms.date: 04/27/2020
ms.custom: sap:Integrated Development Environment (IDE)\Other
ms.reviewer: pchapman
---
# You can't dismiss developer license notifications in Visual Studio 2013 Update 4

This update helps you resolve the problem where you can't dismiss developer license notifications in Microsoft Visual Studio 2013 Update 4.

_Original product version:_ &nbsp; Visual Studio 2013  
_Original KB number:_ &nbsp; 3018885

## Symptoms

After you install Visual Studio 2013 Update 4, a critical notification in the Notification Hub indicates you must obtain or renew a developer license. If you dismiss this notice and then open another project, the critical notification appears again.

You may also receive one of the following Visual Studio critical notifications:

- Notification 1

    > Get a developer license. You need a developer license to develop Windows Store and Windows Phone apps. Click here to install a developer license. (Requires an internet connection.)

- Notification 2

    > Renew your developer license. The developer license on your machine expired on \<date>. Click here to renew your developer license now. (Requires an internet connection.)

> [!NOTE]
> In these notifications, internet is spelled all lowercase.

## Cause

This problem occurs because the process that detects whether a Windows Store Developer License is required incorrectly notifies users in certain cases, such as when you open a project that isn't a Windows Store or Windows Phone project.

## Resolution

An update to resolve this problem is available for manual download and installation from the Microsoft Download Center.

- [Download for Update to Microsoft Visual Studio 2013 Update 4](https://www.microsoft.com/download/details.aspx?id=44998)

[!INCLUDE [Virus-scan claim](../../../includes/virus-scan-claim.md)]

## Prerequisites

To apply this update, you must be running Visual Studio 2013 Update 4.

## Registry information

To use this update, you don't have to make any changes to the registry.

## Restart requirement

You may have to restart the computer after you apply this update.

## Update replacement information

This update doesn't replace a previously released update.

## File information

|File name|File version|File size|Date|Time|
|---|---|---|---|---|
|Microsoft.VisualStudio.TailoredProjectServices.dll|12.0.31112.0|287,520|19-Nov-2014|18:06|

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the following products:

- Visual Studio Ultimate 2013
- Visual Studio Professional 2013
- Visual Studio Premium 2013
- Visual Studio Express 2013 for Web
- Visual Studio Express 2013 for Windows
