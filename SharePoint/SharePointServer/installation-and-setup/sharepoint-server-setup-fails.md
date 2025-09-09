---
title: Unable to install SharePoint Server 2019
description: Fixes an issue in which SharePoint Server 2019 Setup fails if the required version of Visual C++ Redistributable Package for Visual Studio 2017 isn't installed.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Setup, Upgrade, Migration and Patching
  - CI 114542
  - CSSTroubleshoot
ms.reviewer: troys
appliesto: 
  - SharePoint Server 2019
search.appverid: MET150
ms.date: 12/17/2023
---

# "This product requires Visual C++ Redistributable Package for Visual Studio 2017" error when installing SharePoint Server 2019

## Symptoms

The Microsoft SharePoint 2019 Products Preparation Tool successfully runs and finishes by having all prerequisites installed or enabled. But when you run Microsoft SharePoint Server 2019 Setup, you receive the following error message:

> Setup is unable to proceed due to the following error(s):
> - This product requires Visual C++ Redistributable Package for Visual Studio 2017.

## Cause

SharePoint 2019 Products Preparation Tool misidentifies the minimum version of Microsoft Visual C++ 2017 Redistributable (x64) that is required by SharePoint Server 2019 Setup. In this case, if Visual C++ 2017 Redistributable (x64) is installed, but is a version that's greater than or equal to 14.10.25017.0 and less than 14.13.26020.0, the tool won't install the minimum version that's required by SharePoint Server 2019 Setup.

## Resolution

To fix this issue, use one of the following methods.

### Method 1
1. Uninstall Microsoft Visual C++ 2017 Redistributable (x64) through Windows Control Panel.
2. Rerun Microsoft SharePoint 2019 Products Preparation Tool. The tool will now install the minimum required version of Visual C++ 2017 Redistributable (x64).
3. Run SharePoint Server 2019 Setup.

### Method 2
1. Download and install Microsoft Visual C++ 2017 Redistributable (x64) version 14.13.26020.0 (or a later version) from [https://go.microsoft.com/fwlink/?LinkId=848299](https://go.microsoft.com/fwlink/?LinkId=848299).
2. Run SharePoint Server 2019 Setup.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
