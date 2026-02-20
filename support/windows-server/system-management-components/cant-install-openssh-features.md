---
title: Can't install OpenSSH Features
description: Resolves various issues that occur when you try to install OpenSSH Server and OpenSSH Client on different versions of Windows Server and Windows Client.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-appelgatet
ms.custom:
- sap:system management components\openssh (including sftp)
- pcy:WinComm User Experience
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Can't install OpenSSH features

The OpenSSH Server and OpenSSH Client features of Windows are installed by default on Windows Server 2025. However, this situation isn't true for older versions of Windows Server or for Windows 11 or Windows 10. On those systems, the OpenSSH features are available as optional Windows features (also known as Features on Demand, or FoD).

For more information about how to use OpenSSH features in Windows Server 2025, see [Get started with OpenSSH for Windows](/windows-server/administration/openssh/openssh_install_firstuse?tabs=powershell&pivots=windows-server-2025).

## Symptoms

You try to install the OpenSSH features on a computer that's affected by any of the following conditions:

- The computer is isolated from the internet.
- You use Group Policy to manage how the computer gets updates.
- You use a centralized network store or an intranet update management system such as Windows Server Update Service (WSUS) to manage updates.

For example, when you run `Add-Capability` in Windows PowerShell, the installation fails, and you receive one of the following error messages:

- 0x800F0954 (CBS_E_NO_OPTIONAL_CONTENT_FOUND_ON_UPDATE_SERVERS)
- 0x800F0950 (COMException)
- 0x8024402C (WU_E_PT_WINHTTP_NAME_NOT_RESOLVED)
- 0x80240438 (WU_E_PT_ENDPOINT_UNREACHABLE)
- 0x8024500C

Additionally, if you do successfully install the OpenSSH features, you can't use them right away.

## Cause

If your computer gets automatic updates from Windows Update, or if your installation media is available locally, the process to install the OpenSSH features is straightforward: You install these features by using the user interface or the Deployment Image Servicing and Management (DISM) `Add-Capability` command.

However, any of the following conditions can complicate this operation:

- The computer is isolated from the internet.
- You use Group Policy to manage how the computer gets updates.
- You use a centralized network store or an intranet update management system such as Windows Server Update Service (WSUS) to manage updates.

In these situations, Windows can't locate the .cab files that it must have in order to install the features. The reasons for this outcome can vary. For example:

- The installation media doesn't contain the .cab files for the OpenSSH feature. This issue was observed in Windows Server 2019, version 1809.

- The computer uses WSUS to manage updates, and it runs a version of Windows Server that's older than Windows Server 2025 or Windows 11, version 22H2. These older versions of Windows can't install the OpenSSH features by using WSUS. For more information about this behavior, see the following articles:

  - [Use Windows Update client policies and WSUS together](/windows/deployment/update/wufb-wsus)
  - The [High-level changes affecting Features on Demand and language pack content](/windows/deployment/update/fod-and-lang-packs#high-level-changes-affecting-features-on-demand-and-language-pack-content) section of "How to make Features on Demand and language packs available when you're using WSUS or Configuration Manager"

- Group Policy settings block the installation. These settings vary depending on the Windows version. In some cases, multiple settings can contradict one another and cause the installation to fail.

## Resolution

Before you start the procedures in this section, check the following requirements:

- The computer that you want to install the OpenSHH features on runs Windows Server 2019 (build 1809) or a later version, or Windows 10 (build 1809) or a later version. To check the version details of your Windows-based computer, open a Command Prompt window, and then enter `winver.exe`.

- You use Windows PowerShell 5.1 or a later version. To check the PowerShell version, open a PowerShell Command Prompt window, and then run `$PSVersionTable.PSVersion`. Verify that the major version is at least **5**, and the minor version is at least **1**. For more information, see [installing PowerShell on Windows](/powershell/scripting/install/installing-powershell-on-windows).

- You use an account that's a member of the built-in Administrators group.

The specific steps to install the OpenSSH features vary depending on the environment that you work in.

| Environment | Start at this section |
| - | - |
| Target computer can connect to Windows Update as necessary | [Install the OpenSSH features by using Windows Update](#install-the-openssh-features-by-using-windows-update) |
| Target computer can't connect to Windows Update | [Install the OpenSSH features from a network location](#install-the-openssh-features-from-a-network-location) |
| WSUS* manages updates for the environment<br /><br />AND<br /><br />The computer runs the following Windows versions: <ul><li>Windows Server 2022</li><li>Windows Server 2019</li><li>Windows 11, version 21H2</li><li>Windows 10</li></ul> | [Install the OpenSSH features from a network location](#install-the-openssh-features-from-a-network-location) |

\* This condition applies to any intranet update management system.

If the installation still fails, see [Configure Group Policy to allow OpenSSH installation](#configure-group-policy-to-allow-openssh-installation).

> [!IMPORTANT]  
> Although the OpenSSH features are installed by default in Windows Server 2025, you must start and configure the features before you can use them. (This procedure is the same for all supported versions of Windows.) For more information, see [Configure the OpenSSH service and firewall settings](#configure-the-openssh-service-and-firewall-settings).

### Install the OpenSSH features by using Windows Update

To install OpenSSH by using PowerShell:

1. Open an administrative PowerShell Command Prompt window.
1. To check the status of the OpenSSH features, run the following cmdlet:

   ```powershell
   Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
   ```

   If the features aren't already installed, the command returns output that resembles the following excerpt:

   ```output
   Name  : OpenSSH.Client~~~~0.0.1.0
   State : NotPresent
   Name  : OpenSSH.Server~~~~0.0.1.0
   State : NotPresent
   ```

1. To install the necessary server or client components, run the following cmdlets:

   ```powershell
   # Install the OpenSSH Client
   Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
   # Install the OpenSSH Server
   Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
   ```

   Both commands should return output that resembles the following excerpt:

   ```output
   Path          :
   Online        : True
   RestartNeeded : False
   ```

> [!IMPORTANT]  
> After you install the OpenSSH features, you must start and configure the features before you can use them. (This procedure is the same for all supported versions of Windows.) For more information, see [Configure the OpenSSH service and firewall settings](#configure-the-openssh-service-and-firewall-settings).

### Install the OpenSSH features from a network location

To check the status of the OpenSSH features, open an administrative PowerShell Command Prompt window, and then run the following cmdlet:

```powershell
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
```

If the features aren't already installed, the command returns output that resembles the following excerpt:

```output
Name : OpenSSH.Client~~~~0.0.1.0
State : NotPresent
Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
```

#### Download the FoD ISO images

Check the version details of your Windows computer. Open a Command Prompt window, and then enter `winver.exe`. Note the full version number of Windows, including the build number.

You can download FoD ISO packages from any of the following locations.

| Source | Details or requirements |
| - | - |
| [Microsoft 365 Admin Portal](https://admin.microsoft.com/adminportal) | You must have an administrative Microsoft 365 account. This portal has replaced the Volume Licensing Service Center (VLSC) |
| Original Equipment Manufacturer (OEM) | Typically, you must have a support agreement from the OEM. |
| [Microsoft Evaluation Center](https://www.microsoft.com/evalcenter) | This site might not include packages for older versions of Windows. |
| [MSDN-Platforms](https://visualstudio.microsoft.com/msdn-platforms/) | You must have a Visual Studio (previously MSDN) subscription. |
| GitHub ([PowerShell/openssh-portable](https://github.com/PowerShell/openssh-portable) or [Win32-OpenSSH GitHub Releases](https://github.com/PowerShell/Win32-OpenSSH/releases)). | If you use the GitHub packages, install them by following the instructions that are available in the relevant repository.<br />Notice that if you manually install OpenSSH by using GitHub, you're responsible for configuration and for all future updates. For more information, see [Get started with OpenSSH for Windows](/windows-server/administration/openssh/openssh_install_firstuse). |

> [!IMPORTANT]  
>
> - The FoD ISO package should match your Windows version. For example, if you want to install OpenSSH features on a computer that runs Windows 11, version 21H2, download the package that's specific to Windows 11, version 21H2.
> - If you want to install the OpenSSH features on Windows Server 2019, download a package for the matching Windows 10 version and the package for the matching Windows Server 2019 version (for example, Windows 10, version 1809 for Windows Server 2019, version 1809).
> - Store the downloaded files on a drive or network share that's accessible from the computer that you want to install the features on.

#### Install the OpenSSH features

**Windows Server 2019**

To prepare to install the features on Windows Server 2019, follow these steps:

1. Create a folder that the target computer can access (for example, C:\FOD).
1. Extract the contents of the Windows Server 2019 package to C:\FOD folder.
1. Mount the Windows 10 package as a drive on the target computer (right-click the package, and then select **Mount**).
1. In the Windows 10 package, locate files that resemble the following and copy them to the C:\FOD folder.

   - OpenSSH-Client-Package~31bf3856ad364e35~amd64~~.cab
   - OpenSSH-Server-Package~31bf3856ad364e35~amd64~~.cab

1. Continue to the next procedure to install the OpenSSH features.

**All other Windows Versions**

To install the OpenSSH features, follow these steps.

1. Mount the Features on Demand package (for Windows Server 2019, use the folder that contains the .CAB files) as a drive on the target computer (right-click the package, and then select **Mount**).
1. Open an administrative Command Prompt window, and then run the following commands:

   ```console
   dism /online /add-capability /capabilityname:OpenSSH.Client~~~~0.0.1.0 /source:<Drive>
   dism /online /add-capability /capabilityname:OpenSSH.Server~~~~0.0.1.0 /source:<Drive>
   ```

   > [!NOTE]  
   > In these commands, \<Drive> represents the drive letter of the mounted drive (for example, `E:\`)

   Both commands should return output that resembles the following excerpt:

   ```output
   Path          :
   Online        : True
   RestartNeeded : False
   ```

> [!IMPORTANT]  
> After you install the OpenSSH features, you must start and configure them before you can use them (this procedure is the same for all supported versions of Windows). For more information, go to the next section.

### Configure the OpenSSH service and firewall settings

To start and configure OpenSSH Server for initial use, open an administrative PowerShell window, then run the following cmdlets:

```powershell
# Start the sshd service
Start-Service sshd
# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'
# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify:
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue)) {
   Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
   New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
   } else {
   Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
   }
```

For more information, see [Get started with OpenSSH for Windows](/windows-server/administration/openssh/openssh_install_firstuse).

### Configure Group Policy to allow OpenSSH installation

If you use Group Policy to manage your environment, your Group Policy settings might prevent you from installing the OpenSSH features. Also, the available policies have changed over time. Policies in some versions of Windows that control how Windows installs these features either don't exist or have no effect in other versions of Windows. Additionally, you might not be able to install the features if specific policy settings conflict with one another.

> [!NOTE]  
> This article focuses on Group Policy settings as presented by the Group Policy Editor. The same settings (or their equivalent) are also available in configuration service provider (CSP) policies. For more information, see the following articles:
>
> - [Policy CSP - ADMX_Servicing](/windows/client-management/mdm/policy-csp-admx-servicing)
> - [Policy CSP - Update](/windows/client-management/mdm/policy-csp-update)

#### Policy settings for Windows 11, version 24H2 and later versions, and Windows Server 2025 and later versions

**Group Policy setting: Specify settings for optional component installation and component repair**

This setting is located in the following path:

> Computer Configuration\Administrative Templates\System\

If you enable this setting, the default source for updates is Windows Update. If Windows can't connect to Windows Update, Windows searches for an intranet service such as WSUS, or for a local network share.

If you disable or don't configure this policy setting, Windows still downloads the files from Windows Update, if the computer policy settings allow it. This condition is also true if the required files aren't available at the locations that are specified in this policy setting.

For more information, see [Policy CSP - ADMX_Servicing](/windows/client-management/mdm/policy-csp-admx-servicing).

| Policy/Option | Settings if Windows Update is available\* | Settings if Windows Update isn't available |
| - | - | - |
| **Specify settings for optional component installation and component repair** | **Windows Update** (default)<br />or not configured | **Network folder location** or intranet service |
| Option: **Alternate file location**<br />(if the policy is set to **Network folder location**) | Disabled | UNC path to packages |

\* Regarding OpenSSH feature installation, "available" means that the computer that you install OpenSSH on can contact Windows Update directly. If the computer gets all its updates from network shares or an intranet service, the effect is the same as if the computer can't connect to the internet.

> [!NOTE]  
> In previous versions of Windows and Windows Server, this policy had additional options. The default behavior of the policy was changed. The additional options are no longer relevant.

**Other relevant Group Policy settings**

The settings that are listed in this section are located in the following path:

> Computer Configuration\Administrative Templates\Windows Components\Windows Update\Manage updates offered from Windows Server Update Service

To receive any updates from an intranet update service, you must configure the **Specify intranet Microsoft update service location** policy setting correctly.

When you use an intranet service, you can specify different source locations for different classes of updates (configured in the options of the **Specify source service for specific classes of Windows Updates** policy setting). In previous versions of Windows, these settings could conflict with the default behavior of the **Specify settings for optional component installation and component repair** setting. However, changes to the default behavior of the "optional component installation" setting should prevent this issue from occurring.

For more information about these settings, see the following articles:

- [Use Windows Update client policies and WSUS together](/windows/deployment/update/wufb-wsus#configure-the-scan-sources)
- The [Specify intranet Microsoft update service location](/windows-server/administration/windows-server-update-services/deploy/4-configure-group-policy-settings-for-automatic-updates#specify-intranet-microsoft-update-service-location) section in "Step 4: Configure Group Policy settings for automatic updates"
- The [Default scan behavior](/windows/deployment/update/wufb-wsus#default-scan-behavior) section in "Use Windows Update client policies and WSUS together"
- The [Features on Demand Considerations](/windows-server/administration/windows-server-update-services/plan/plan-your-wsus-deployment?source=recommendations#features-on-demand-considerations) section in "Plan your WSUS deployment"

#### Policy settings for Windows 11, version 22H2 - Windows 11, version 23H2

**Group Policy setting: Specify settings for optional component installation and component repair**

This setting is located in the following path:

> Computer Configuration\Administrative Templates\System\

If you enable this setting, the default source for updates is WSUS. If the requested feature option isn't there, Windows searches Windows Update (if it's connected to the internet), and then it looks for a local network share.

| Policy/Option | Settings if Windows Update is available\* | Settings if Windows Update isn't available |
| - | - | - |
| **Specify settings for optional component installation and component repair** | **Windows Update** | **Network folder location** or intranet service |
| Option: **Alternate file location**<br />(if the policy is set to **Network folder location**) | Disabled | UNC path to packages |
| Option: **Never attempt to download payload from Windows Update** | Not selected | Not selected |
| Option: **Download repair content and optional features directly from Windows Update instead of Windows Server Update Services** | Selected or not selected | Selected (only used if the files aren't found in the network folder) or not selected |

\* Regarding OpenSSH feature installation, "available" means that the computer that you install OpenSSH on can contact Windows Update directly. If the computer gets all its updates from network shares or an intranet service, the effect is the same as if the computer can't connect to the internet.

The options **Never attempt to download payload from Windows Update** and **Download repair content and optional features directly from Windows Update instead of Windows Server Update Services** typically aren't needed in Windows 11, version 22H2 and later versions. These options were more important in previous versions of Windows. They were removed in Windows 11, version 24H2.

**Other relevant Group Policy settings**

The settings that are listed in this section are located in the following path:

> Computer Configuration\Administrative Templates\Windows Components\Windows Update\Manage updates offered from Windows Server Update Service

To receive any updates from an intranet update service, you must configure the **Specify intranet Microsoft update service location** policy setting correctly.

If you use an intranet service for updates, and if **Specify settings for optional component installation and component repair** is set to **Windows Update**, use one of the following configurations for **Specify source service for specific classes of Windows Updates**:

- Disable **Specify source service for specific classes of Windows Updates** (or leave it unconfigured). In this configuration, Windows relies on its default behavior to locate OpenSSH installation packages.
- Set both the **Feature Updates** and **Quality Updates** options to **Windows Update**. These settings avoid conflict with **Specify settings for optional component installation and component repair**.

For more information about these settings, see the following articles:

- [How to make Features on Demand and language packs available when you're using WSUS or Configuration Manager](/windows/deployment/update/fod-and-lang-packs)
- The [Features on Demand Considerations](/windows-server/administration/windows-server-update-services/plan/plan-your-wsus-deployment?source=recommendations#features-on-demand-considerations) section in "Plan your WSUS deployment"
- [Get started with OpenSSH for Windows](/windows-server/administration/openssh/openssh_install_firstuse?tabs=powershell&pivots=windows-11#install-openssh-server--client)
- [Use Windows Update client policies and WSUS together](/windows/deployment/update/wufb-wsus#configure-the-scan-sources)
- The [Specify intranet Microsoft update service location](/windows-server/administration/windows-server-update-services/deploy/4-configure-group-policy-settings-for-automatic-updates#specify-intranet-microsoft-update-service-location) section in "Step 4: Configure Group Policy settings for automatic updates"

#### Policy settings for Windows Server 2022, Windows 11, version 21H2, and Windows 10, version 2004 - Windows 10, version 22H2

**Group Policy setting: Specify settings for optional component installation and component repair**

This setting is located in the following path:

> Computer Configuration\Administrative Templates\System\

If you enable this setting, the default source for updates is WSUS. If the requested feature option isn't there, Windows searches Windows Update (if it's connected to the internet), and then it looks for a local network share.

| Policy/Option | Settings if Windows Update is available/* | Settings if Windows Update isn't available |
| - | - | - |
| **Specify settings for optional component installation and component repair** | **Windows Update** | **Network folder location** |
| Option: **Alternate file location**<br />(if the policy is set to **Network folder location**) | Disabled | UNC path to packages |
| Option: **Never attempt to download payload from Windows Update** | Not selected | Not selected |
| Option: **Download repair content and optional features directly from Windows Update instead of Windows Server Update Services** | Selected | Selected (only used if the files aren't found in the network folder) |

\* Regarding OpenSSH feature installation, "available" means that the computer that you install OpenSSH on can contact Windows Update directly. If the computer gets all its updates from network shares or an intranet service, the effect is the same as if the computer can't connect to the internet.

**Other relevant Group Policy settings**

The settings that are listed in this section are located in the following path:

> Computer Configuration\Administrative Templates\Windows Components\Windows Update\Manage updates offered from Windows Server Update Service

To receive any updates from an intranet update service, you must configure the **Specify intranet Microsoft update service location** policy setting correctly.

If you use an intranet service for updates, and if **Specify settings for optional component installation and component repair** is set to **Windows Update**, use one of the following configurations for **Specify source service for specific classes of Windows Updates**:

- Disable **Specify source service for specific classes of Windows Updates** (or leave it unconfigured). In this configuration, Windows relies on its default behavior to locate OpenSSH installation packages.
- Set both the **Feature Updates** and **Quality Updates** options to **Windows Update**. These settings avoid conflict with **Specify settings for optional component installation and component repair**.

For more information about these settings, see the following articles:

- [How to make Features on Demand and language packs available when you're using WSUS or Configuration Manager](/windows/deployment/update/fod-and-lang-packs)
- The [Features on Demand Considerations](/windows-server/administration/windows-server-update-services/plan/plan-your-wsus-deployment?source=recommendations#features-on-demand-considerations) section in "Plan your WSUS deployment")
- [Configure the scan sources](/windows/deployment/update/wufb-wsus#configure-the-scan-sources) (see "Use Windows Update client policies and WSUS together")
- The [Specify intranet Microsoft update service location](/windows-server/administration/windows-server-update-services/deploy/4-configure-group-policy-settings-for-automatic-updates#specify-intranet-microsoft-update-service-location) section in "Step 4: Configure Group Policy settings for automatic updates"

#### Policy settings for Windows Server 2019 and Windows 10, version 1709 - Windows 10, version 1809

**Group Policy setting: Specify settings for optional component installation and component repair**

This setting is located in the following path:

> Computer Configuration\Administrative Templates\System\

If you enable this setting, the default source for updates is WSUS. If the requested feature option isn't there, Windows searches Windows Update (if it's connected to the internet), and then it looks for a local network share.

| Policy/Option | Settings if Windows Update is available/* | Settings if Windows Update isn't available |
| - | - | - |
| **Specify settings for optional component installation and component repair** | **Windows Update** | **Network folder location** |
| Option: **Alternate file location**<br />(if the policy is set to **Network folder location**) | Disabled | UNC path to packages |
| Option: **Never attempt to download payload from Windows Update** | Not selected | Not selected |
| Option: **Download repair content and optional features directly from Windows Update instead of Windows Server Update Services** | Selected | Selected (only used if the files aren't found in the network folder) |

\* Regarding OpenSSH feature installation, "available" means that the computer that you install OpenSSH on can contact Windows Update directly. If the computer gets all its updates from network shares or an intranet service, the effect is the same as if the computer can't connect to the internet.

For more information about these settings, see the following articles:

- [How to make Features on Demand and language packs available when you're using WSUS or Configuration Manager](/windows/deployment/update/fod-and-lang-packs)
- The [Features on Demand Considerations](/windows-server/administration/windows-server-update-services/plan/plan-your-wsus-deployment?source=recommendations#features-on-demand-considerations) section in "Plan your WSUS deployment"

## References

- The [Features on Demand Considerations](/windows-server/administration/windows-server-update-services/plan/plan-your-wsus-deployment?source=recommendations#features-on-demand-considerations) section in "Plan your WSUS deployment"
- [Get started with OpenSSH for Windows](/windows-server/administration/OpenSSH/openssh_install_firstuse)
- [How to make Features on Demand and language packs available when you're using WSUS or Configuration Manager](/windows/deployment/update/fod-and-lang-packs)
- [Manage additional Windows Update settings](/windows/deployment/update/waas-wu-settings)
- [Migrating and acquiring optional Windows content during updates](/windows/deployment/update/optional-content)
- [OpenSSH for Windows overview](/windows-server/administration/openssh/openssh_overview)
- [Policy CSP - ADMX_Servicing](/windows/client-management/mdm/policy-csp-admx-servicing)
- [Policy CSP - Update](/windows/client-management/mdm/policy-csp-update)
- The [Specify intranet Microsoft update service location](/windows-server/administration/windows-server-update-services/deploy/4-configure-group-policy-settings-for-automatic-updates#specify-intranet-microsoft-update-service-location) section in "Step 4: Configure Group Policy settings for automatic updates"
- [Use Windows Update client policies and WSUS together](/windows/deployment/update/wufb-wsus)
- [Win32-OpenSSH GitHub Releases](https://github.com/PowerShell/Win32-OpenSSH/releases)
