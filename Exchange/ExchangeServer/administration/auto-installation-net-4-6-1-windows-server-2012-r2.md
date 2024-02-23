---
title: Auto-installation of .NET 4.6.1
description: Describes the effects and functionality of the announced .NET Framework 4.6.1 for Windows Server 2012 R2 server in an Exchange Server 2013 or Exchange Server 2016 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: marcn, nasira, brettan, v-six
ms.custom: 
  - Exchange Server
  - CI 119623
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
ms.date: 01/24/2024
---
# Auto-installation of .NET Framework 4.6.1 for Windows Server 2012 R2 in Exchange Server 2013 or 2016

_Original KB number:_ &nbsp; 3142512

## Summary

The .NET Framework 4.6.1 was announced by the .NET team on the [.NET Blog](https://devblogs.microsoft.com/dotnet/). This version is a recommended update for Windows Server 2012 R2. This means that anyone who's running Exchange Server 2013 or Exchange Server 2016 on a Windows Server 2012 R2-based server that has automatic updates enabled can receive the update automatically.

However, after the 4.6.1 update is installed, [Mailboxes are quarantined and databases fail over unexpectedly](https://support.microsoft.com/help/3095369) in Exchange Server because .NET Framework 4.6.1 isn't currently supported by any versions of Exchange. For more information about the required component for supported versions, see [Exchange Server supportability matrix](/Exchange/plan-and-deploy/supportability-matrix).

For up-to-date information about .NET Framework 4.6.1 and Exchange Server, see [On .NET Framework 4.6.1 and Exchange compatibility](https://techcommunity.microsoft.com/t5/exchange-team-blog/on-net-framework-4-6-1-and-exchange-compatibility/ba-p/604561).

However, if you have already installed this update or aren't sure, see the following information about how you can verify your version of .NET Framework and what you can do to roll back to .NET Framework 4.5.2.

## Verify the version of .NET Framework that's currently installed

The easiest way is to run the [HealthChecker.ps1 script](https://gallery.technet.microsoft.com/exchange-2013-performance-23bcca58) from TechNet gallery. This script reports the version of the .NET Framework that's currently installed. You can also check the registry for this information. The subkey in question can be found in the following location:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\Release`

If the number is greater than 394271, .NET Framework 4.5.2 or a later version is installed. .NET Framework 4.5.2 will have a value between 379893 and 393297.

## Roll back to .NET Framework 4.5.2

.NET Framework 4.5.2 is the recommended version for Exchange Server 2013 and Exchange Server 2016. If you have the 4.6.1 update installed, you can follow these steps to remove it:

1. If the server has already automatically updated to 4.6.1 and has not restarted yet, restart it now to allow the installation to complete.

2. Stop all running services that are related to Exchange. To do this, run the `(Test-ServiceHealth).ServicesRunning | %{Stop-Service $_ -Force}`  cmdlet from Exchange Management Shell.

3. Go to **Add or Remove Programs**, select **View installed updates**, and find the entry for **KB3102467**. Uninstall this update. Restart when you are prompted to do so.

4. Check the version of the .NET Framework, and verify that it's 4.5.2. If it's earlier than version 4.5.2, go to Windows Update, check for updates, and install .NET 4.5.2 through the KB2934520 update. Don't select **4.6.1 (KB3102467)**. Restart when you are prompted. If 4.5.2 is still shown as the installed version, go to step 5.

5. Stop services by using the command from step 2. Run a repair of .NET 4.5.2 by downloading the [offline installer](https://www.microsoft.com/download/details.aspx?id=42642), running setup, and selecting the repair option. Restart when setup is complete.

6. Apply the February security updates for .NET 4.5.2 by going to Windows Update, checking for updates, and installing **KB3122654** and **KB3127226**. Don't select **KB3102467**. Restart after installation.

7. After restarting, verify that the .NET Framework version is 4.5.2 and that security updates KB3122654 and KB3127226 are installed.
8. Follow steps in [How to temporarily block the installation of the .NET Framework 4.6.1](https://support.microsoft.com/help/3133990) to block future automatic installations of .NET 4.6.1.

## Other operating system versions

The automatic update functionality affects only Windows 2012 R2.