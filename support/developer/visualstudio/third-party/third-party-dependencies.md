---
title: Third-party dependencies in Visual Studio 2015
description: This article provides a table that summarizes the third-party apps that are required when you install Cross Platform Mobile Development tools from Visual Studio 2015.
ms.date: 04/24/2020
ms.custom: sap:Third Party Tools installed with Visual Studio\Other
---
# Visual Studio 2015 setup: Third-party dependencies

This article summarizes the third-party applications that are required when you install Cross Platform Mobile Development tools from Microsoft Visual Studio 2015.

_Original product version:_ &nbsp; Visual Studio 2015  
_Original KB number:_ &nbsp; 3060693

## Dependencies between Visual Studio tools and third-party applications

If you installed Cross Platform Mobile Development features, you must use additional third-party software to work with those projects. For the dependencies between Visual Studio tools and third-party applications, see the following table.

|Third-party software|Lets you ...| Required by Cross Platform Mobile Development for C#/.NET (Xamarin)| Required by Cross Platform Mobile Development for HTML/JavaScript (Apache Cordova)| Required by Cross Platform Mobile Development for Visual C++ Mobile Development|
|---|---|---|---|---|
|Android NDK|Develop native dynamic shared libraries, static libraries, and native-activity applications for the Android platform.|Yes|No|Yes|
|Android SDK|Build and create packages for the Android platform.|Yes|Yes|Yes|
|Apache Ant|Create deployment packages for different platforms.|No|Yes|Yes|
|Git CLI|Download and use custom plug-ins.|No|Yes|No|
|Joyent Node.js|Download and manage dependent packages.|No|Yes|No|
|Oracle Java Development Kit|Perform the build steps for Android.|No|Yes|No|
|Websocket4Net|Enable debugging on Windows 7 computers.|No|Yes|No|

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

## Applies to

- Visual Studio Enterprise 2015
- Visual Studio Express 2015 for Windows Desktop
- Visual Studio Express 2015 for Web
- Visual Studio Express 2015 for Windows 10
- Visual Studio Professional 2015
- Visual Studio Community 2015
