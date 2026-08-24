---
title: Windows Installer source list update fails because of HTTPS distribution points
description: Resolve error 0x87D00226 when Configuration Manager can't update the Windows Installer source list for content by using HTTPS distribution points.
ms.date: 08/21/2026
ms.reviewer: kaushika
ai-usage: ai-assisted
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Content Management\Distribution Point Installation, Upgrade or Configuration

#customer intent: As a Configuration Manager administrator, I want to resolve Windows Installer source list update error 0x87D00226 so that clients can locate application sources.
---
# Windows Installer source list update fails because of HTTPS distribution points

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager, Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 2905510

## Summary

This article helps you resolve error `0x87D00226`, which occurs when a Configuration Manager client can't automatically update the Windows Installer source list because its distribution points are configured for HTTPS. It describes the cause of the error and provides two solutions: using a package share, or manually adding the source location to the Windows Installer source list.

## Symptoms

On an affected client, the Windows Installer source list update fails. The following entries appear in **SrcUpdateMgr.log**:

```output
UpdateURLWithTransportSettings(): HTTP requested but client settings prohibit it.
Failed source list update for product <product-code>, error 87d00226
DoUpdateSourceListAll task failed, error code 87d00226
Source list update task failed, will be retried after 3600 seconds
```

## Cause

The Configuration Manager source update manager requests an HTTP transport when it adds a distribution point URL to the Windows Installer source list. If client settings prohibit HTTP because the distribution points are configured for HTTPS, Configuration Manager rejects the request and returns `CCM_E_INVALIDPROTOCOL` (`0x87D00226`). Automatic source list updates in this configuration aren't supported.

> [!NOTE]
> [Windows Installer source list management](/windows/win32/msi/managing-installation-sources) and the Configuration Manager source update setting for Windows Installer deployment types remain available. This issue is limited to automatic source list updates when the client receives an HTTPS distribution point location.

> [!IMPORTANT]
> Don't configure a site to allow plain HTTP client communication to work around this issue. Sites that allow HTTP client communication are [no longer supported](/intune/configmgr/core/plan-design/changes/deprecated/removed-and-deprecated-cmfeatures#unsupported-and-removed-features). Microsoft recommends HTTPS for Configuration Manager communication paths. If PKI-based HTTPS isn't suitable for your environment, configure [enhanced HTTP](/intune/configmgr/core/plan-design/hierarchy/enhanced-http).

## Solution 1: Use a package share for a package

For a package, make its content available through a package share:

1. In the Configuration Manager console, go to the **Software Library** workspace, expand **Application Management**, and select **Packages**.
1. Select the package, and then select **Properties**.
1. On the **Data Access** tab, select **Copy the content in this package to a package share on distribution points**.

For more information about this option, see [Packages and programs in Configuration Manager](/intune/configmgr/apps/deploy-use/packages-and-programs#deploy-packages-and-programs).

## Solution 2: Add the application source to the Windows Installer source list

> [!IMPORTANT]
> This section contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Follow these steps carefully, and back up the registry before you modify it so that you can restore it if a problem occurs.

For an application, add the application source location to the Windows Installer source list under the subkey that corresponds to the installation context:

- Per-machine installation:

  `HKEY_CLASSES_ROOT\Installer\Products\<product-code>\SourceList\Net`

- Per-user installation for the current user:

  `HKEY_CURRENT_USER\Software\Microsoft\Installer\Products\<product-code>\SourceList\Net`

For information about supported Windows Installer APIs for managing network and URL sources, see [Managing installation sources](/windows/win32/msi/managing-installation-sources#managing-network-and-url-sources-for-products-and-patches).
