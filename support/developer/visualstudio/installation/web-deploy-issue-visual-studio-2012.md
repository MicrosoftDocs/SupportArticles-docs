---
title: Web Deploy 3.0 installation fails with a warning
description: This article helps you resolve a warning that is shown while installing the Web Deploy 3.0.
ms.date: 05/09/2022
ms.custom: sap:Installation
ms.author: v-jayaramanp
---

# Introduction

This article helps you resolve a warning that is displayed when you try to install Web Deploy 3.0.

## Web Deploy 3.0 - Certificate warning or unable to locate package source error

A warning related to Web Deploy 3.0 may cause two types of problems:

- During the Visual Studio 2012 installation, you may experience an "Unable to locate package source" error that isn't resolved using the Download packages from the Internet option.
- After installation is complete, you see a message that indicates setup has completed but not all features have installed correctly, along with the following warning:

    > Microsoft Web Deploy 3.0  
    > A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file.

To work around these issues and successfully install Web Deploy 3.0, you can try any of the following approaches:

- Obtain an updated installer that has been published at the distribution channel of your choice (such as [MSDN](https://msdn.microsoft.com/subscriptions/securedownloads)).
- Install the [latest Visual Studio Update](https://visualstudio.microsoft.com/).

## Applies to

Visual Studio 2012