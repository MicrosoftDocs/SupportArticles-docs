---
title: Error while installing Web Deploy 3.0
description: This article helps you resolve a warning or error that is shown while installing Web Deploy 3.0.
ms.date: 05/12/2022
ms.custom: sap:Installation
ms.topic: troubleshooting
author: haiying
ms.author: v-jayaramanp
---

# Error while installing Web Deploy 3.0

Web Deploy is a tool for simplifying migration, management, and deployment of web applications, sites, and servers. It is installed along with Visual Studio 2012. This article helps you to resolve a warning or an error displayed when you try to install Web Deploy 3.0.

_Applies to:_&nbsp;Visual Studio 2012

## Symptoms

During the Visual Studio 2012 installation, you may be presented with two scenarios. In the first scenario, you may see an "Unable to locate package source" error that isn't resolved using the **Download packages from the Internet** option. In the second scenario, you might also see a warning post installation that indicates setup has completed but not all features have installed correctly, along with the following error message:

  > Microsoft Web Deploy 3.0  
  > A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file.

## Workarounds

To resolve the warning or error and install Web Deploy 3.0 successfully, you can try any of the following workarounds:

- Obtain an updated installer that has been published at the distribution channel of your choice (such as [MSDN](https://msdn.microsoft.com/subscriptions/securedownloads)).
- Install the [latest Visual Studio Update](https://visualstudio.microsoft.com/).