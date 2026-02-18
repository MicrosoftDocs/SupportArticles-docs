---
title: Error Code 0x8024402C When You Try to Install a Windows Update or a Feature on Demand
description: Provides methods to resolve error code 0x8024402C when you install a Windows update or a Feature on Demand.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---

# Error code 0x8024402C when you try to install a Windows update or a Feature on Demand

## Symptoms

When you try to manually install a Windows update, or you try to install a Feature on Demand (FoD) package, you receive a message that resembles the following text:

> Windows couldn't complete the requested changes
> The changes couldn't be completed. Please reboot your computer and try again
> Error code 0x8024402C

## Cause

The [Microsoft Error Lookup Tool (err.exe)](https://www.microsoft.com/download/details.aspx?id=100432&msockid=36aa9a75ec446e9e33dd8ee0ed136f37) provides the following definition of error code 0x8024402C:

   ```output
   "WU_E_PT_WINHTTP_NAME_NOT_RESOLVED"
   # Same as ERROR_WINHTTP_NAME_NOT_RESOLVED - the proxy server
   # or target server name cannot be resolved.
   ```

If you work on a computer that connects directly to the Windows Update service, this error code indicates that the issue might occur in the local network or the internet connection. If you work on a computer that uses an intranet service such as Windows Server Update Service (WSUS) to manage updates, this error code indicates that the issue might occur in the local network. In this case, the computer can't connect to the WSUS server.

> [!IMPORTANT]  
> To get an FoD package from WSUS, the computer must run Windows 11, version 22H2 or a later version, or Windows Server 2025 or a later version. To install an FoD feature on any other version of Windows that runs on a computer that can't access Windows Update directly, you have to use a network repository, local media, or a network-mounted ISO image.

## Resolution

> [!NOTE]  
> If you want to install the OpenSSH Server feature or the OpenSSH Client feature, see [Can't install OpenSSH features](../../windows-server/system-management-components/cant-install-openssh-features.md).

To fix this issue, follow these steps:

1. Verify that the computer can connect to the local network. For example, use the `ping` or `nslookup` commands to make sure that the computer can connect to other devices on the network and can resolve DNS addresses correctly. If necessary, check the [Windows Update logs](#windows-update-logs) to help identify the source of the issue.

1. If your computer connects directly to Windows Update, follow these steps:

   1. Verify that the computer can connect to the internet. If the computer can't connect, check any proxy or firewall configurations, and make sure that the DNS infrastructure is working correctly.
   1. Verify that Windows is correctly configured to access Windows Update. For more information about the settings that control such access, see [Manage connection endpoints for Windows 11 Enterprise](/windows/privacy/manage-windows-11-endpoints) and the ["Delivery Optimization"](/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services#28-delivery-optimization) section in "Manage connections from Windows 10 and Windows 11 operating system components to Microsoft services."

1. If your computer uses an intranet update management service such as WSUS, and you want to install an FoD feature instead of an update, check the computer's version of Windows or Windows Server. For example, in the **Search** bar, enter **winver**. Based on the Windows version, take one of the following actions:

- **Windows Server 2025 or a later version, or Windows 11 22H2 or a later version**: Go to the next step.
- **Windows Server 2022 or Windows Server 2019, Windows 11 21H2 or an earlier version, or Windows 10**: See [Information about using ISO images or FoD repositories to install FoD](#information-about-using-iso-images-or-fod-repositories-to-install-fod) for instructions.

1. If your computer uses an intranet update service, and you want to manually install an update, verify that the computer can connect to the WSUS server. This step also applies to manually installing an FoD feature on a supported version of Windows or Windows Server. If the computer can't connect, check any proxy or firewall configurations, and make sure that the DNS infrastructure is working correctly.

1. Make sure that no settings are blocking updates. To do this, check your Group Policy or policy configuration service provider (CSP) settings. For more information about policy settings that affect Windows Update and intranet update management services, see the following articles:

   - [Policy CSP - ADMX_Servicing](/windows/client-management/mdm/policy-csp-admx-servicing)
   - [Policy CSP - Update](/windows/client-management/mdm/policy-csp-update)
   - The [Specify intranet Microsoft update service location](/windows-server/administration/windows-server-update-services/deploy/4-configure-group-policy-settings-for-automatic-updates#specify-intranet-microsoft-update-service-location) section in "Step 4: Configure Group Policy settings for automatic updates"
   - [Use Windows Update client policies and WSUS together](/windows/deployment/update/wufb-wsus)
   - [Manage additional Windows Update settings](/windows/deployment/update/waas-wu-settings)

## More information

### Windows Update logs

Windows update logs might contain entries that resemble the following excerpt. You can use this information to help identify when the update process failed.

   ```output
   2010-01-05 18:52:06:747 808 aac Misc WARNING: WinHttp: SendRequestUsingProxy failed for <http://servername/selfupdate/wuident.cab>. error 0x8024402c
   2010-01-05 18:52:06:747 808 aac Misc WARNING: WinHttp: SendRequestToServerForFileInformation MakeRequest failed. error 0x8024402c
   2010-01-05 18:52:06:747 808 aac Misc WARNING: WinHttp: SendRequestToServerForFileInformation failed with 0x8024402c
   2010-01-05 18:52:06:747 808 aac Misc WARNING: WinHttp: ShouldFileBeDownloaded failed with 0x8024402c
   2010-01-05 18:52:06:747 808 aac Misc WARNING: DownloadFileInternal failed for http://servername/selfupdate/wuident.cab: error 0x8024402c
   2010-01-05 18:52:06:747 808 aac Setup FATAL: IsUpdateRequired failed with error 0x8024402c
   2010-01-05 18:52:06:747 808 aac Setup WARNING: SelfUpdate: Default Service: IsUpdateRequired failed: 0x8024402c
   2010-01-05 18:52:06:747 808 aac Setup WARNING: SelfUpdate: Default Service: IsUpdateRequired failed, error = 0x8024402C
   2010-01-05 18:52:06:747 808 aac Agent * WARNING: Skipping scan, self-update check returned 0x8024402C
   2010-01-05 18:52:06:762 808 aac Agent * WARNING: Exit code = 0x8024402C
   ```

For more information about how to collect and review Windows Update logs, see [Windows Update log files](/windows/deployment/update/windows-update-logs).

### Information about using ISO images or FoD repositories to install FoD

You might have to install FoD packages from a repository or mounted ISO image within your network. This condition applies if the affected computers can't connect to Windows Update directly, and you're using any of the following Windows versions:

- Windows Server 2022 or Windows Server 2019
- Windows 11 21H2 or an earlier version
- Windows 10

You can download FoD ISO packages from any location that's listed in the following table.

| Source | Details or requirements |
| - | - |
| [Microsoft 365 Admin Portal](https://admin.microsoft.com/adminportal) | You must have an administrative Microsoft 365 account. This portal replaced the Volume Licensing Service Center (VLSC) |
| Original Equipment Manufacturer (OEM) | Typically, you must have a support agreement from the OEM. |
| [Microsoft Evaluation Center](https://www.microsoft.com/evalcenter) | This site might not include packages for older versions of Windows. |
| [MSDN-Platforms](https://visualstudio.microsoft.com/msdn-platforms/) | You must have a Visual Studio (previously MSDN) subscription. |
| GitHub ([PowerShell/openssh-portable](https://github.com/PowerShell/openssh-portable) or [Win32-OpenSSH GitHub Releases](https://github.com/PowerShell/Win32-OpenSSH/releases)). | If you use the GitHub packages, install them by following the instructions that are available in the relevant repository.<br />Notice that if you manually install OpenSSH by using GitHub, you're responsible for configuration and for all future updates. For more information, see [Get started with OpenSSH for Windows](/windows-server/administration/openssh/openssh_install_firstuse). |

> [!IMPORTANT]  
>
> - The FoD ISO package should match your Windows version. For example, if you want to install OpenSSH features on a computer that runs Windows 11, version 21H2, download the package that's specific to Windows 11, version 21H2.
> - Store the downloaded files on a drive or network share that's accessible from the computer that you want to install the features on.

For more information about how to create and use a repository for language packs and other FoD features, see the following articles:

- [FoD repositories](/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities#FoD-repositories) in Features on Demand
- [Build a custom FoD and language pack repository](/windows-hardware/manufacture/desktop/languages-overview?view=windows-11&preserve-view=true#build-a-custom-FoD-and-language-pack-repository) in "Languages overview"
- [Features on Demand media](/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities#features-on-demand-media) in Features on Demand

For more general information about FoD, see [Available features on demand](/windows-hardware/manufacture/desktop/features-on-demand-non-language-FoD).
