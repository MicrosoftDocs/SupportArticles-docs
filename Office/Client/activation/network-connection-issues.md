---
title: Microsoft 365 Apps activation network connection issues
description: Troubleshooting activation issues due to network connection problems.
author: Cloud-Writer
ms.reviewer: vikkarti, tfairman
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\We're having trouble activating Office
  - CSSTroubleshoot
  - CI 157765
  - CI 162387
  - CI 166312
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/25/2025
---

# Microsoft 365 Apps activation network connection issues

This article will help you troubleshoot network connection issues when activating Microsoft 365 apps. When you're having network connection issues, you might encounter an error such as the following example:

> We're having trouble activating Office.

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren't an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)

<details>
<summary><b>Activating Microsoft 365 on Windows 8.1 or earlier</b></summary>

To activate Microsoft 365 Apps, TLS 1.2 must be enabled on the operating system. Some older operating systems, such as Windows 7 SP1, Windows Server 2008 R2, and Windows Server 2012, require an update to enable TLS 1.2 by default.

**Important** Running Microsoft 365 Apps on these older operating systems isn't supported. For more information, see [End of support resources for Office](/deployoffice/endofsupport/resources).

1. If you are running Windows 7 or Windows Server 2008, make sure that [Service Pack 1]( https://support.microsoft.com/topic/information-about-service-pack-1-for-windows-7-and-for-windows-server-2008-r2-df044624-55b8-3a97-de80-5d99cb689063) is installed.
1. Enable TLS 1.2 as the default protocol by using [this easy fix]( https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi), and then restart the device.
1. From Start, select **Control Panel** > **Internet options** > **Advanced settings**.
1. If **TLS 1.2** isn't checked, check it, then select **Apply** and **OK**.
1. Restart the device, and then try activating Microsoft 365 again.

</details>

<details>
<summary><b>Update Windows</b></summary>

1. From Start, type check for updates, and select **Check for updates** from the search results.
1. Select **Check for updates**.
1. Download and install available updates.
1. Restart the device and try to activate Microsoft 365 again.

</details>

<details>
<summary><b>Check whether you're behind a proxy server</b></summary>

Are you behind a proxy server? If you're not sure, ask your administrator. If so, you (or your administrator) might have to change the proxy settings for Windows HTTP clients. To do this, follow these steps:
  
1. Open a Command Prompt window as an administrator. From Start, type *cmd.exe* in the search box, right-click **Command Prompt** in the list, and then select **Run as administrator**.
1. Type `netsh winhttp set proxy <Address of proxy server>`, and then press Enter.
  
You need to allow the URLs and IP addresses in [this list](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide&preserve-view=true#microsoft-365-common-and-office-online).
  
You can also allow Microsoft 365 to bypass the proxy server by creating a PAC file. For more information about creating a PAC file, see [Managing Microsoft 365 endpoints](/microsoft-365/enterprise/managing-office-365-endpoints).

</details>

<details>
<summary><b>Check whether you're behind a firewall</b></summary>

Are you behind a firewall? If you're not sure, ask your administrator. If you're behind a firewall, it might have to be configured to enable access to the following URLs:

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
  
For more information about Microsoft 365 Apps for enterprise URLs and IP addresses, see [Microsoft 365 URLs and IP address ranges](https://technet.microsoft.com/library/hh373144.aspx).

</details>

<details>
<summary><b>Check BrokerPlugin process</b></summary>

Some antivirus, proxy, or firewall software might block the following plug-in process:

`Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`

Temporarily disable your antivirus software. Contact your system administrator to find out if you are behind a proxy or firewall that is blocking this process. If so, you will also need to temporarily disable your proxy or firewall connection. If you connect through a Virtual Private Network (VPN), you might need to temporarily disable your VPN also.

If the process isn't blocked, but you still can't activate Microsoft 365, delete your BrokerPlugin data and then reinstall it using the following steps:

1. Open File Explorer, and put the following location in the address bar:  
`%LOCALAPPDATA%\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\AC\TokenBroker\Accounts`
1. Press CTRL + A to select all.
1. Right-click in the selected files and choose **Delete**.
1. Put the following location in the File Explorer address bar:  
`%LOCALAPPDATA%\Packages\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy\AC\TokenBroker\Accounts`
1. Select all files and delete them.
1. Restart the device.
1. Run the [Microsoft 365 sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome) in Get Help.

For manual troubleshooting for step 7, or for more information, see [Fix authentication issues in Office applications when you try to connect to a Microsoft 365 service](/microsoft-365/troubleshoot/authentication/automatic-authentication-fails).

</details>

<details>
<summary><b>Check external DNS for incorrect CNAME records</b></summary>

Check your external DNS for an MSOID CNAME record that points to `clientconfig.partner.microsoftonline-p.net.cn`.

This CNAME record is required only for customers who use Microsoft 365 that's operated by 21Vianet. 21Vianet is a service that's available in China. If this CNAME record is present, and your Microsoft 365 service is not operated by 21Vianet, users on your custom domain will receive a "custom domain isn't in our system" error message. Because of this error, users won't be able to activate their Microsoft 365 apps license. If you find this CNAME record, delete it, and wait for DNS replication to update the DNS record.

</details>

<details>
<summary><b>Disable IPv6</b></summary>

1. Right-click the network icon in the System Tray.
1. Select **Open Network & Internet Settings**.
1. Select **Change adapter options**.
1. Right-click your network connection, and then select **Properties**.
1. Uncheck **Internet Protocol version 6**.
1. Try to activate Microsoft 365 again.
1. Re-enable IPv6.

</details>

<details>
<summary><b>Make sure required services are running</b></summary>

1. From Start, type `services.msc`, and then select the **Services** app.
1. Make sure that the following services are all running:
    - Network Connected Devices Auto-Setup
    - Network List Service
    - Network Location Awareness
    - Windows Event Log
1. If any of these services is not running, right-click the service and select **Start**.
1. If you have a problem starting the service, run the System File Checker using the following steps:
    1. From Start, type **cmd**. Right-click **Command Prompt** in the search results and select **Run as administrator**.
    1. At the command prompt, type `sfc /scannow`
    1. When the scan completes, restart the device.
1. When all the services listed under step 2 are running, try activating Microsoft 365 again.

</details>

<details>
<summary><b>Check NCSI</b></summary>

The Network Connectivity Status Indicator (NCSI) is an OS feature that determines whether access to the Internet is available.

Check if NCSI is registering your internet connection using the following steps:

1. From Start, type *`powershell`*, and then select **Windows PowerShell** from the search results.
1. At the command prompt, type the following command, and then press Enter:  
`Get-NetConnectionProfile`
1. If **IPv4Connectivity** says **Internet**, it suggests NCSI is registering your internet connection correctly. If it says **NoTraffic** or **LocalNetwork**, it is not.
1. If you aren't behind a proxy, type the following command and then press Enter:  
`nslookup dns.msftncsi.com`.
1. If the address resolves, it suggests NCSI is registering your internet connection correctly.
1. Check HTTP Probe destinations by opening your browser and putting the following URLs in your address bar:
    - For Windows 10 version 1607 or later, `http://www.msftconnecttest.com/connecttest.txt` and `http://ipv6.msftconnecttest.com/connecttest.txt` should return **Microsoft Connect Test**.
    - For Windows 10 version 1511 or earlier, `http://www.msftncsi.com/ncsi.txt` and `http://ipv6.msftncsi.com/ncsi.txt` should return **Microsoft NCSI**.

If NCSI isn't registering your internet connection, try setting it to use GlobalDNS using the following steps:

1. From Start, type *regedit*, and then select **Registry Editor** from the results.
1. Navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows\NetworkConnectivityStatusIndicator`.
1. Right-click the registry value and select **New**, then select **DWORD**.
1. Name the DWORD `UseGlobalDNS`, and set the value to 1.
1. Try activating Microsoft 365 again.

</details>

<details>
<summary><b>Rename Connections registry value</b></summary>

**Important** Before editing the registry, it's strongly recommended that you back up the registry. For instructions, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

1. From Start, type *regedit*, and then select **Registry Editor** from the results.
1. Navigate to `HKEY_LOCAL_MACHINE/Software/Microsoft/Windows/ CurrentVersion/Internet Settings/Connections`.
1. Right-click **Connections**, and select **Rename**.
1. Rename **Connections** to *Connections.old*.
1. Restart the device and try activating Microsoft 365 again.

</details>

<details>
<summary><b>Check Network Services permissions</b></summary>

**Important** Before editing the registry, it's strongly recommended that you back up the registry. For instructions, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

1. From Start, type *regedit*, and then select **Registry Editor** from the results.
1. Navigate to `HKEY_USERS/S-1-5-20`.
1. Right-click the registry value and select **Permissions**.
1. If **NETWORK SERVICE** is listed, select it. Make sure that **Full Control** and **Read** are checked.
1. If **NETWORK SERVICE** isn't listed:
    1. Select **Add**.
    1. In the field labeled **Enter the object names to select**, type network service.
    1. Select **Check names**. When the service is found, select **OK**.
    1. Make sure that **Full Control** and **Read** are checked, and then select **Apply** and then **OK**.
1. Restart the device.
1. Try to activate Microsoft 365 again.

</details>

<details>
<summary><b>Reset Winsock</b></summary>

1. Open a Command Prompt window as an administrator. From Start, type *cmd.exe* in the search box, right-click **Command Prompt** in the list, and then select **Run as administrator**.
1. Type `netsh int ip reset`, and then press Enter.
1. Type `netsh winsock reset`, and then press Enter.
1. Restart the device.
1. Try to activate Microsoft 365 again.

</details>

<details>
<summary><b>Reset Microsoft Edge settings</b></summary>

**Important** Resetting Edge settings might cause certain webpages that rely on custom settings to not work properly.

1. Open Edge and select the three dots at the top.
1. Select **Settings**.
1. Select **Reset settings**, and then **Restore settings to their default values**.
1. After the process completes, close Edge and try to activate again.

</details>

<details>
<summary><b>Delete officeclient subfolders in the registry</b></summary>

1. From Start, type *regedit*, and then select **Registry Editor** from the results.
1. Navigate to `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Internet\WebServiceCache\AllUsers\officeclient.microsoft.com`.
1. Delete all subfolders of `officeclient.microsoft.com`.
1. Restart the device and try to activate again.

</details>

<details>
<summary><b>Turn off Default Security from portal.azure.com</b></summary>

To do so, follow the steps in [Disabling security defaults](/azure/active-directory/fundamentals/concept-fundamentals-security-defaults#disabling-security-defaults).

</details>
