---
title: Fail to install Web Deploy 3.0
description: This article helps you resolve a warning or error that is shown while installing Web Deploy 3.0.
ms.date: 05/17/2022
ms.custom: sap:Installation
ms.reviewer: v-jayaramanp
---

# "Unable to locate package source" error or certificate warning when installing Web Deploy 3.0

Web Deploy is a tool for simplifying migration, management, and deployment of web applications, sites, and servers. It's installed along with Visual Studio 2012. This article helps you to work around an issue where you receive an error or a warning related to Web Deploy 3.0 when you install Visual Studio 2012.

_Applies to:_&nbsp;Visual Studio 2012

## Symptoms

When you try to install Visual Studio 2012, you may experience the following problems:

- During the installation, you may see the "Unable to locate package source" error that isn't resolved using the **Download packages from the Internet** option.
- After the installation, you may see a warning, which indicates setup has completed but not all features have installed correctly, along with the following error message:

  > Microsoft Web Deploy 3.0  
  > A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file.

## Workarounds

To work around these issues and successfully install Web Deploy 3.0, you can try any of the following approaches:

- Obtain an updated installer that has been published at the distribution channel of your choice (such as [MSDN](https://msdn.microsoft.com/subscriptions/securedownloads)).
- Install the [latest Visual Studio Update](https://visualstudio.microsoft.com/).
