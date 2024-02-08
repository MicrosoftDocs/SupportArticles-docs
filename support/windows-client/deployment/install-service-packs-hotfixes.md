---
title: Install Service Packs and Hotfixes
description: Describes how to best install and remove service packs and hotfix updates on Windows-based computers that are running in Safe mode.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
ms.subservice: deployment
---
# How to install Service Packs and Hotfixes when Windows is running in Safe mode

This article describes how to best install and remove service packs and hotfix updates on Windows-based computers that are running in Safe mode.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 818460

## Summary

Typically, the installation of service packs and hotfix updates is done when Windows is running normally. You can start your Windows-based computer in Safe mode to help you diagnose problems. Microsoft has the following recommendations for the installation of service packs and hotfixes when your computer doesn't function in normal mode:

## Installing Service Packs and Hotfixes

Microsoft recommends that you don't install Windows service packs or hotfix updates when Windows is running in Safe mode.

When you install a service pack or hotfix, the Setup program determines which devices are installed in the computer and which Windows components are enabled. Because certain drivers and components are unavailable when Windows runs in Safe mode, the service pack or update Setup program may incorrectly calculate the components that require updating. If you install a service pack or update while Windows runs in Safe mode, and then you restart Windows normally, you may experience intermittent file errors or registry errors. Additionally, when you try to install a service pack or hotfix update while Windows is running in Safe mode, you may receive an error message similar to the following example:

> ERROR_INSTALL_SERVICE_FAILURE  
1601 The Windows Installer service could not be accessed.  
Contact your support personnel to verify that the Windows  
Installer service is properly registered.

Because of it, Microsoft recommends that you don't install service packs or updates when Windows is running in Safe mode unless you can't start Windows normally.

> [!IMPORTANT]
> If you do install a service pack or update while Windows is running in Safe mode, immediately reinstall it after you start Windows normally.

## Removing Service Packs and Hotfixes

Microsoft recommends that you don't remove Windows service packs or hotfix updates when Windows is running in Safe mode.

Because the removal (uninstall) program for a service pack or hotfix update only restores settings (file replacements and registry changes) that it previously changed, and because the removal program maintains a record of these changes, no problems are expected to occur when you remove a service pack or hotfix when Windows is running in Safe mode. However, Microsoft recommends that you remove a service pack or hotfix while Windows is running in normal mode, where possible.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
