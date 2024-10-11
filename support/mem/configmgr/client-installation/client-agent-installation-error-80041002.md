---
title: Client agent installation fails with error 80041002
description: Describes an issue in which the Configuration Manager client installation fails on a management point that has Cumulative Update 3 for Configuration Manager 2012 SP1 installed.
ms.date: 12/05/2023
ms.reviewer: kaushika, buzb
ms.custom: sap:Client Installation, Registration and Assignment\Client Installation
---
# Installation of the Configuration Manager client agent fails with error code 80041002

This article provides a solution for the 80041002 error when you try to install the Configuration Manager client agent.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2905359

## Symptoms

When you try to install the client agent on a System Center 2012 Configuration Manager management point that has [Cumulative Update 3 for System Center 2012 Configuration Manager Service Pack 1](https://support.microsoft.com/help/2882125) installed, the installation fails. Additionally, you see the following error in the Client.msi log when verbose logging is enabled:

> [**DateTime**] Registering Hosting Configuration.  
> MSI (s) (6C!A8) [*DateTime*]: Closing MSIHANDLE (22022) of type 790531 for thread 936  
> [*DateTime*] @@ERR:25150  
> MSI (s) (6C!A8) [*DateTime*]: Product: Configuration Manager Client -- Error 25150. Setup was unable to register the CCM_Service_HostingConfiguration endpoint  
> The error code is 80041002
>
> MSI (s) (6C!A8) [*DateTime*]: Closing MSIHANDLE (22020) of type 790531 for thread 936  
> Error 25150. Setup was unable to register the CCM_Service_HostingConfiguration endpoint  
> The error code is 80041002  
> MSI (s) (6C:7C) [*DateTime*]: Closing MSIHANDLE (22018) of type 790536 for thread 1252  
> CustomAction CcmRegisterHostingConfiguration returned actual error code 1603

## Resolution

To resolve this issue, follow these steps:

1. Uninstall the management point role.
2. Reinstall the client agent on the management point computer. To do this, perform the following steps:

    1. On the site server, open an elevated command prompt.
    2. Change the directory to the \<Configuration Manager 2012 install location>\client directory. For example, change the directory to D:\Program Files\Microsoft Configuration Manager\Client.

    3. Run the `Ccmsetup.exe /source: "D:\Program Files\Microsoft Configuration Manager\Client"` command (based on the example in the previous step).

3. Reinstall the management point role.
