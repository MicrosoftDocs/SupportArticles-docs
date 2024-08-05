---
title: Install OpsMgr and Service Manager consoles on the same server
description: Describes how to install the System Center 2016 Operations Manager console and System Center 2016 Service Manager console on the same server.
ms.date: 04/15/2024
---
# Install the Operations Manager console and the Service Manager console on the same server

This article describes how to install the System Center 2016 Operations Manager console and System Center 2016 Service Manager console on the same server.

_Original product version:_ &nbsp; System Center 2016 Operations Manager, System Center 2016 Service Manager  
_Original KB number:_ &nbsp; 4464214

## Installation steps

Follow these steps to have both the System Center 2016 Operations Manager console and System Center 2016 Service Manager console coexist on the same server.

1. Install the System Center 2016 Operations Manager console, and then install System Center 2016 Service Manager console on the same server.
1. Add system environment variable `DEVPATH` that contains folder path of the Microsoft.EnterpriseManagement.Core.dll with the value `C:\Program Files\Microsoft System Center 2016\Operations Manager\Console\SDK Binaries`.
1. Add the following entry in the config file (`C:\Program Files\Microsoft System Center 2016\Operations Manager\Console\Microsoft.EnterpriseManagement.Monitoring.Console.exe.config`)

    ```xml
    <configuration>

                    ….

                    <runtime>

                    <developmentMode developerInstallation="true" />

                    </runtime>

                     ….

                    </configuration>
    ```
