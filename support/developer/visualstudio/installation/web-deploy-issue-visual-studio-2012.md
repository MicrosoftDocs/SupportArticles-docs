---
title: Error "Certificate warning or Unable to locate package source error"
description: This article helps you resolve an error when the  that is shown while installing Web Deploy 3.0.
ms.date: 05/11/2022
ms.custom: sap:Installation
ms.topic: troubleshooting
author: haiying
ms.author: v-jayaramanp
---

# Error while installing Web Deploy 3.0

 Web Deploy is installed while installing Visual Studio 2012. This article provides suitable workarounds to help you to install Web Deploy 3.0.

_Applies to:_&nbsp;Visual Studio 2012

## Symptoms

The "Certificate warning or unable to locate package source" error is displayed when you try to install Web Deploy 3.0. The error might cause either of the following problems:

- During the Visual Studio 2012 installation, you may experience an "Unable to locate package source" error that isn't resolved using the **Download packages from the Internet** option.
- After installation is complete, you see a message that indicates setup has completed but not all features have installed correctly, along with the following warning:

    > Microsoft Web Deploy 3.0  
    > A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file.

## Workarounds

To install Web Deploy 3.0, you can try any of the following methods:

- Obtain an updated installer that has been published at the distribution channel of your choice (such as [MSDN](https://msdn.microsoft.com/subscriptions/securedownloads)).
- Install the [latest Visual Studio Update](https://visualstudio.microsoft.com/).

## More Information

[Troubleshooting Common Problems with Web Deploy](/iis/publish/troubleshooting-web-deploy/troubleshooting-common-problems-with-web-deploy)
[Troubleshooting Web Deploy problems with Visual Studio](/iis/publish/troubleshooting-web-deploy/troubleshooting-web-deploy-problems-with-visual-studio)