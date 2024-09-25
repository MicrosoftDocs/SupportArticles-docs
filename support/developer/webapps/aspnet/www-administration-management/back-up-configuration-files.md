---
title: Back up configuration files
description: This article introduces about how to back up ASP.NET configuration files under IIS 7.0 and later versions.
ms.date: 04/15/2020
ms.custom: sap:Configuration
ms.reviewer: saurabsi
ms.topic: how-to
---
# Back up ASP.NET configuration files

This article introduces about how to locate and back up ASP.NET configuration files under Microsoft Internet Information Services (IIS) 7.0 and later versions.

_Original product version:_ &nbsp; ASP.NET on .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 2434810

## Summary

ASP.NET applications running on IIS 7.0 and later versions use *web.config* files to store the various configuration settings for its functioning. After updating your ASP.NET web application, you may find that the application fails, and you'll need to revert back to the previous version of the configuration file. For this reason, it is important to ensure you back up the *web.config* files correctly and regularly so that backups are available to revert to.

## Locate and back up ASP.NET configuration files under IIS

Beginning in IIS 7.0, both ASP.NET configuration and IIS configuration can be stored in the same *web.config* files. The settings pertaining to ASP.NET will be located under the `<system.web>` section, and IIS settings will be located under `<system.webserver>`.

The main IIS configuration file, *applicationHost.config*, is stored under the `%systemroot%\System32\inetsrv\config` folder. The *web.config* files for specific web sites, directories, and applications contain settings for both IIS and ASP.NET and are located in the root of each.

You can run the following command to take a backup of the IIS configuration file using the following command:

```console
%systemroot%\system32\inetsrv\APPCMD add backup MyBackup
```

## More information

For more information about how to use AppCmd.exe, see [Getting Started with AppCmd.exe](/iis/get-started/getting-started-with-iis/getting-started-with-appcmdexe).

For *web.config* files, you can use the [Configuration Editor](https://www.iis.net/downloads/microsoft/administration-pack) to find where all of the *web.config* files are located as shown below, and accordingly make a backup for all of them.

:::image type="content" source="media/back-up-configuration-files/config-editor.png" alt-text="Configuration editor interface with Search Configuration item highlighted.":::

:::image type="content" source="media/back-up-configuration-files/webconfig-files-location-hierarchy-view.png" alt-text="Web.config files location in Hierarchy View..":::

:::image type="content" source="media/back-up-configuration-files/webconfig-files-location-flat-view.png" alt-text="Web.config files location in Flat View..":::
