---
title: Windows Installer may display inaccurate progress
description: This article describes that the percentage, progress bar, and time remaining during an install or uninstall is not always accurate.
ms.date: 01/04/2021
ms.custom: sap:Installation
ms.reviewer: 
ms.topic: article
ms.technology: vs-installation-install
---

# Web Deploy 3.0 - Certificate warning or unable to locate package source error

A warning related to WebDeploy 3.0 may cause two types of problems:

1. During installation, you may experience an **Unable to locate package source** error that isn't resolved via the Download packages from the Internet option.
2. After installation is complete, you see a message that indicates setup has completed but not all features have installed correctly, along with the following warning:

    > Microsoft Web Deploy 3.0  
    > A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file.

To work around these issues and successfully install Web Deploy 3.0, you can try any of the following approaches:

- Obtain an updated installer that has been published at the distribution channel of your choice (such as [MSDN](https://msdn.microsoft.com/subscriptions/securedownloads)).
- Install the [latest Visual Studio Update](https://visualstudio.microsoft.com/).

## Applies to

Visual Studio 2012