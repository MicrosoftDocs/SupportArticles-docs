---
title: No cs-username data in Advanced Logging
description: This article provides resolutions for the problem where no data is logged in the cs-username field in the logs file when you use the Advanced Logging feature of IIS.
ms.date: 04/07/2020
ms.custom: sap:IIS extensions, tools, and Add-ons
ms.reviewer: Mike
ms.technology: iis-iis-extensions-tools
---
# No data is logged in the cs-username field when using the Advanced Logging feature of IIS

This article helps you resolve the problem where no data is logged in the cs-username field in the logs file when you use the Advanced Logging feature of Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2529915

## Symptoms

Consider the following scenario:

- You're running an IIS 7.0 or 7.5 web server.
- You've installed the Advanced Logging feature and have it configured to include cs-username data in the log files.

In this case, no cs-username entries are logged.

## Cause

Microsoft has confirmed that this is a problem in the Advanced Logging feature of IIS.

## Resolution 1: Change applicationHost.config directly

> [!IMPORTANT]
> The following steps involve directly editing the *applicationHost.config* file. Always back up your configuration files before making any changes.

To work around this issue, edit the *applicationHost.config* file for the Advanced Logging feature using the following steps:

1. Open the `C:\Windows\System32\inetsrv\config\applicationHost.config` file in a text editor.
2. Locate the `<advancedLogging>` section.
3. In `advancedLogging`, locate the `<field id='UserName'...>` entry. By default, the entry is as follows:

    ```xml
    <field id="UserName" sourceName="UserName" sourceType="
     RequestHeader " logHeaderName="cs-username" category="Default" loggingDataType="TypeLPCSTR" />
    ```

4. Modify the `sourceType` field to be `BuiltIn`, as follows:

    ```xml
    <field id="UserName" sourceName="UserName" sourceType="
     BuiltIn " logHeaderName="cs-username" category="Default" loggingDataType="TypeLPCSTR" />
    ```

5. Save the changes and close the text editor.

The `cs-username` column of the Advanced Logging logs should now be populated. You don't need to restart the IIS services to make this change take effect.

## Resolution 2: Change applicationHost.config by Appcmd.exe

You can use the `Appcmd.exe` tool to make the configuration change, instead of editing the config file directly. To do so, run the following command from a command prompt inside the `Inetsrv` directory:

```console
appcmd.exe set config -section:system.webServer/advancedLogging/server
/fields.[id='UserName'].sourceType:"BuiltIn" /commit:apphost
```
