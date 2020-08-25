---
title: ConfigMgr 2007 setup fails with incorrect WebDAV settings
description: Fixes an issue in which System Center Configuration Manager 2007 setup on Windows Server 2008 fails because of incorrect WebDAV settings.
ms.date: 08/18/2020
ms.prod-support-area-path: 
---
# System Center Configuration Manager 2007 prerequisites checker reports WebDAV settings are incorrect

This article helps you fix an issue in which Microsoft System Center Configuration Manager 2007 (ConfigMgr 2007) setup on Windows Server 2008 fails because of incorrect WebDAV settings.

_Original product version:_ &nbsp; System Center Configuration Manager 2007  
_Original KB number:_ &nbsp; 2378924

## Symptoms

System Center Configuration Manager 2007 setup on Windows Server 2008 may fail to proceed with the following error message:

> Web-based Distributed Authoring and Versioning (WebDAV) is required for the management point and distribution point site system roles. If you have selected to install a site role requiring WebDAV, and it is not enabled, this rule will fail. Web-based Distributed Authoring and Versioning (WebDAV) is not enabled and/or IIS 6 WMI compatibility component for IIS7 is not installed on the computer specified for management point installation or setup was unable to verify remote IIS settings because IIS common components were not installed on the site server computer. ConfigMgr requires WebDAV to be installed and enabled in Internet Information Services (IIS) for management point site systems. Setup cannot continue.

It occurs even if the steps from [How to Configure Windows Server 2008 for Configuration Manager 2007 Site Systems](/previous-versions/system-center/configuration-manager-2007/cc431377(v=technet.10)) has been followed.

## Cause

It can occur if WebDAV has been configured at the global level rather than at the default web site level. Even if the settings are the same at both levels, setup requires that only the individual web site settings are configured. Configuring the same settings at both levels won't allow setup to proceed, since global settings in this case aren't written to the \<webdav> section of the default web site in ApplicationHost.config (since they're effectively the same, there's no reason to write them twice).

## Resolution

To resolve this issue and allow ConfigMgr 2007 setup to complete, follow the steps below:

1. Click **Start**, select **All Programs** > **Administrative Tools** > **Internet Information Services (IIS) Manager**.
2. Highlight the entry on the left-hand pane for your servername (SERVERNAME (DOMAIN\user)).
3. Double-click **WebDAV Authoring Rules**.
4. Delete any rules that appear.
5. Highlight your default web site (or ConfigMgr 2007 web site) and edit the WebDAV settings at that level as explained in [How to Configure Windows Server 2008 for Configuration Manager 2007 Site Systems](/previous-versions/system-center/configuration-manager-2007/cc431377(v=technet.10)).
