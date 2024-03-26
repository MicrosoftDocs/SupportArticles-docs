---
title: Activation error Sorry, we are having some temporary server issues
description: Troubleshooting methods if you're continuing to see the error Sorry, we are having some temporary server issues.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 157597
  - CI 159115
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# Microsoft 365 Apps activation error: "Sorry, we are having some temporary server issues"

When trying to activate Microsoft 365 apps, you might encounter the following error:

> Sorry, we are having some temporary server issues

It's possible the issue might be temporary. If you continue seeing the error, try the following troubleshooting steps to solve the problem.

**Note:** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren't an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>

<details>
<summary><b>Activating Microsoft 365 on Windows 8.1 or earlier</b></summary>

To activate Microsoft 365 Apps, TLS 1.2 must be enabled on the operating system. Some older operating systems, such as Windows 7 SP1, Windows Server 2008 R2, and Windows Server 2012, require an update to enable TLS 1.2 by default.

**Important** Running Microsoft 365 Apps on these older operating systems isn't supported. For more information, see [End of support resources for Office](/deployoffice/endofsupport/resources).

1. If you are running Windows 7 or Windows Server 2008, make sure that [Service Pack 1]( https://support.microsoft.com/topic/information-about-service-pack-1-for-windows-7-and-for-windows-server-2008-r2-df044624-55b8-3a97-de80-5d99cb689063) is installed.
1. Enable TLS 1.2 as the default protocol by using [this easy fix]( https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi), and then restart the device.
1. From Start, select **Control Panel** > **Internet options** > **Advanced settings**.
1. If **TLS 1.2** isn’t checked, check it, then select **Apply** and **OK**.
1. Restart the device, and then try activating Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Sign out of Office and sign back in</b></summary>

1. Open an Office app, such as Word.
1. Select your name and profile picture or icon at the top.
1. Select **Sign out**.
1. Select **Sign in**.
1. Make sure you are signed in with your **Work or School** account, not your personal Microsoft account.
1. Try activating Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Disconnect Work or School credentials</b></summary>

1. From Start, select **Settings** (the gear icon) > **Accounts** > **Access work or school**.
1. If the account you use to sign in to office.com is listed there, but it isn’t the account you use to sign in to Windows, select it, and then select **Disconnect**.
1. Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

Run the [Microsoft Support and Recovery Assistant (SaRA) to reset the Microsoft 365 activation state](https://aka.ms/SaRA-OfficeActivation-Reset).

For manual steps or more information, see [Reset Microsoft 365 Apps for enterprise activation state]( /office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>

<details>
<summary><b>Temporarily disable or uninstall third-party antivirus</b></summary>

If you have a third-party antivirus app installed, temporarily disable it or uninstall it, and then try activating Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Check whether you're behind a proxy server</b></summary>

Are you behind a proxy server? If you're not sure, ask your administrator. If so, you (or your administrator) might have to change the proxy settings for Windows HTTP clients. To do this, follow these steps:

1. Open a Command Prompt window as an administrator. From Start, type *cmd.exe* in the search box, right-click **Command Prompt** in the list, and then select **Run as administrator**.
1. Type the following command, and then press Enter:

   `netsh winhttp set proxy < Address of proxy server >`
  
You need to allow the URLs and IP addresses in [this list](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide&preserve-view=true#microsoft-365-common-and-office-online).
  
You can also allow Microsoft 365 to bypass the proxy server by creating a PAC file. For more information about creating a PAC file, see [Managing Microsoft 365 endpoints](/microsoft-365/enterprise/managing-office-365-endpoints).
<br/><br/>
</details>

<details>
<summary><b>Check whether you're behind a firewall</b></summary>

Are you behind a firewall? If you're not sure, ask your administrator. If you're behind a firewall, it might have to be configured to enable access to the following:

- `officecdn.microsoft.com`
- `ols.officeapps.live.com/olsc`
- `activation.sls.microsoft.com`
- `odc.officeapps.live.com`
- `crl.microsoft.com/pki/crl/products/MicrosoftProductSecureServer.crl`
- `crl.microsoft.com/pki/crl/products/MicrosoftRootAuthority.crl`
- `crl.microsoft.com/pki/crl/products/MicrosoftProductSecureCommunicationsPCA.crl`
- `www.microsoft.com/pki/crl/products/MicrosoftProductSecureCommunicationsPCA.crl`
- `go.microsoft.com`
- `Office15client.microsoft.com`
- `login.windows.net`
- `login.microsoft.com`
- `login.microsoftonline.com`
- `crl.microsoft.com`
- `cdn.odc.officeapps.live.com`
- `ajax.aspnetcdn.com`
- `officeclient.microsoft.com`
- `aadcdn.msauth.net`
- `aadcdn.msauthimages.net`
- `enterpriseregistration.windows.net`
  
Each firewall will have a different method to enable access to these URIs. Check your software's documentation for instructions or ask your administrator to do this for you.
  
For more information about Microsoft 365 Apps for enterprise URLs and IP addresses, see the following Microsoft article: [Microsoft 365 URLs and IP address ranges](https://technet.microsoft.com/library/hh373144.aspx).
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft Edge settings</b></summary>

**Important**
  
Resetting Edge settings might cause certain webpages that rely on custom settings to not work properly.
  
To restore Edge’s default settings, use the following steps:
  
1. Open Edge and select the three dots at the top.
1. Select **Settings**.
1. Select **Reset settings**, and then **Restore settings to their default values**.
1. After the process completes, close Edge and try to activate again.
<br/><br/>
</details>

<details>
<summary><b>Uninstall Office apps and then reinstall</b></summary>

[Run the SaRA package to uninstall Office](https://aka.ms/SaRA-OfficeUninstallFromPC). Restart the device, and install from https://portal.office.com/account to get the correct version.
<br/><br/>
</details>

## Additional troubleshooting

If the above steps don’t solve the problem, try the steps in the following article:  

- [Microsoft 365 activation network connection issues](./network-connection-issues.md)