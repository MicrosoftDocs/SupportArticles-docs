---
title: Fix Visual Studio DIA SDK install location
description: Describes a workaround for a DIA SDK install location problem. Specifically the DIA SDK folder for the pre-existing Visual Studio 2012 installation is overwritten with files that are supposed to be installed in a separate Visual Studio 2013 DIA SDK folder.
ms.date: 04/27/2020
ms.custom: sap:Installation\Servicing updates and service packs
ms.reviewer: aasthana
---
# Fix the Visual Studio 2013 DIA SDK install location when Visual Studio 2012 is already installed

This article helps you fix the Visual Studio 2013 Debug Interface Access Software Development Kit (DIA SDK) install location.

_Original product version:_ &nbsp; Visual Studio 2013 SDK  
_Original KB number:_ &nbsp; 3035999

## Symptoms

You successfully install Visual Studio 2013 on a computer that already has Visual Studio 2012 installed. However, you discover that the `C:\Program Files\Microsoft Visual Studio 12.0\DIA SDK\` folder is missing. You also discover that the pre-existing DIA SDK folder that was created during the Visual Studio 2012 installation process has been overwritten.

## Cause

The DIA SDK was originally designed to update any pre-existing installation of the product. Therefore, a pre-existing installation is discovered and its files are overwritten during installation of a later version of the product.

When you install Visual Studio 2012, the DIA SDK is installed in the `C:\Program Files\Microsoft Visual Studio 11.0\DIA SDK\` folder. When Visual Studio 2013 is installed on a computer that already has Visual Studio 2012 installed, the DIA SDK folder (`C:\Program Files\Microsoft Visual Studio 11.0\DIA SDK\`) is overwritten.

## Workaround

To work around this issue, copy the `C:\Program Files\Microsoft Visual Studio 11.0\DIA SDK\` folder to `C:\Program Files\Microsoft Visual Studio 12.0\DIA SDK\`. Do this after the Visual Studio 2013 installation process is completed. Then, you can access and use the DIA SDK.
