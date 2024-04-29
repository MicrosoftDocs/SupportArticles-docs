---
title: Visual Studio 2015 is stuck while installing KB2999226
description: An installation of Visual Studio 2015 gets stuck if you cannot automatically install KB2999226 correctly because of the computer configuration.
ms.date: 04/15/2024
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee, jagbal
ms.custom: sap:Installation\Servicing updates and service packs
---

# Visual Studio 2015 is stuck while installing KB2999226

This article provides a resolution if an installation of Microsoft Visual Studio 2015 (update for Microsoft Windows KB2999226) gets stuck and stops responding. This occurs if the installer cannot automatically install KB2999226 because of the computer configuration.

_Applies to:_&nbsp;Visual Studio 2015

## Symptoms

A Visual Studio installation stops responding if Visual Studio cannot automatically install KB2999226 ("Update for Universal C Runtime in Windows") because of the computer configuration.

## Resolution

Install the KB update manually, and then restart the Visual Studio installation:

1. Stop the Visual Studio installation.
2. Download [KB2999226](https://www.microsoft.com/download/details.aspx?id=49077) from the Microsoft Download Center.
   > [!NOTE]
   > Check the options carefully to make sure that the KB update is appropriate for your system.
3. After the KB update is installed, restart the Visual Studio installation.
