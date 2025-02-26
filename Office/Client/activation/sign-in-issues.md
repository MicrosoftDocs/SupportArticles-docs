---
title: Sign in issues when activating Microsoft 365 Apps
description: This article will help you troubleshoot network connection issues when activating Microsoft 365 Apps.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\SignIn\Password Prompts
  - CSSTroubleshoot
  - CI 157601
  - CI 159070
  - CI 162419
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/25/2025
---

# Sign in issues when activating Microsoft 365 Apps

This article will help you troubleshoot sign in issues when activating Microsoft 365 Apps.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)

Troubleshooting activation on a Mac:
<br/>
<details>
<summary><b>Office for Mac repeatedly requesting keychain access</b></summary>

If you see repeated prompts to grant access to the keychain when starting an Office for Mac app, Office may have been moved to a location other than the default /Applications folder. For troubleshooting steps, see [Office for Mac repeatedly requesting keychain access](https://support.microsoft.com/office/office-for-mac-repeatedly-requesting-keychain-access-ced5a09c-3099-47cb-9190-e961bf63e240).
<br/><br/>
</details>

 Troubleshooting activation on Windows:
<br/><br/>

<details>
<summary><b>Activating Microsoft 365 on Windows 8.1 or earlier</b></summary>

To activate Microsoft 365 Apps, TLS 1.2 must be enabled on the operating system. Some older operating systems, such as Windows 7 SP1, Windows Server 2008 R2, and Windows Server 2012, require an update to enable TLS 1.2 by default.

**Important** Running Microsoft 365 Apps on these older operating systems isn't supported. For more information, see [End of support resources for Office](/deployoffice/endofsupport/resources).

1.	If you are running Windows 7 or Windows Server 2008, make sure that [Service Pack 1]( https://support.microsoft.com/topic/information-about-service-pack-1-for-windows-7-and-for-windows-server-2008-r2-df044624-55b8-3a97-de80-5d99cb689063) is installed.
1.	Enable TLS 1.2 as the default protocol by using [this easy fix]( https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi), and then restart the device.
1.	From Start, select **Control Panel** > **Internet options** > **Advanced settings**.
1.	If **TLS 1.2** isn’t checked, check it, then select **Apply** and **OK**.
1.	Restart the device, and then try activating Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Citrix Server issues</b></summary>

Microsoft 365 Apps fails to activate when opened from published apps on a Citrix server. This is a known issue with Citrix. For more information, see [Known issues (Citrix product documentation)](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/whats-new/known-issues.html).
<br/><br/>
</details>

<details>
<summary><b>Sign out of Microsoft 365 and sign back in</b></summary>

1.	Open a Microsoft 365 app, such as Word.
1.	Select your name and profile picture or icon at the top.
1.	Select **Sign out**.
1.	Select **Sign in**.
1.	Make sure you are signed in with your **Work or School** account, not your personal Microsoft account.
1.	Try activating Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Make sure Azure Active Directory Authentication Library (ADAL) and Web Account Manager (WAM) are enabled</b></summary>

For more information, see [Disabling ADAL or WAM not recommended for fixing Microsoft 365 sign-in or activation issues](/microsoft-365/troubleshoot/administration/disabling-adal-wam-not-recommended).
<br/><br/>
</details>

<details>
<summary><b>Check whether you're behind a proxy server</b></summary>

Are you behind a proxy server? If you're not sure, ask your administrator. If so, you (or your administrator) might have to change the proxy settings for Windows HTTP clients. To do this, follow these steps:
  
1.	Open a Command Prompt window as an administrator. From Start, type *cmd.exe* in the search box, right-click **Command Prompt** in the list, and then select **Run as administrator**.
1.	Type the following command, and then press Enter:
`netsh winhttp set proxy < Address of proxy server >`
  
You need to allow the URLs and IP addresses in [this list](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide&preserve-view=true#microsoft-365-common-and-office-online).
  
You can also allow Microsoft 365 to bypass the proxy server by creating a PAC file. For more information about creating a PAC file, see [Managing Microsoft 365 endpoints](/microsoft-365/enterprise/managing-office-365-endpoints).
<br/><br/>
</details>

<details>
<summary><b>Check whether you're behind a firewall</b></summary>

Are you behind a firewall? If you're not sure, ask your administrator. If you're behind a firewall, it might have to be configured to enable access to the following:

-	`officecdn.microsoft.com`
-	`ols.officeapps.live.com/olsc`
-	`activation.sls.microsoft.com`
-	`odc.officeapps.live.com`
-	`crl.microsoft.com/pki/crl/products/MicrosoftProductSecureServer.crl`
-	`crl.microsoft.com/pki/crl/products/MicrosoftRootAuthority.crl`
-	`crl.microsoft.com/pki/crl/products/MicrosoftProductSecureCommunicationsPCA.crl`
-	`www.microsoft.com/pki/crl/products/MicrosoftProductSecureCommunicationsPCA.crl`
-	`go.microsoft.com`
-	`Office15client.microsoft.com`
-	`login.windows.net`
-	`login.microsoft.com`
-	`login.microsoftonline.com`
-	`crl.microsoft.com`
-	`cdn.odc.officeapps.live.com`
-	`ajax.aspnetcdn.com`
-	`officeclient.microsoft.com`
-	`aadcdn.msauth.net`
-	`aadcdn.msauthimages.net`
-	`enterpriseregistration.windows.net`
  
Each firewall will have a different method to enable access to these URIs. Check your software's documentation for instructions or ask your administrator to do this for you.
  
For more information about Microsoft 365 Apps for enterprise URLs and IP addresses, see the following Microsoft article: [Microsoft 365 URLs and IP address ranges](https://technet.microsoft.com/library/hh373144.aspx).
<br/><br/>
</details>

<details>
<summary><b>Check external DNS for incorrect CNAME records</b></summary>

Check your external DNS for an MSOID CNAME record that points to `clientconfig.partner.microsoftonline-p.net.cn`.

This CNAME record is required only for customers who use Microsoft 365 that's operated by 21Vianet. 21Vianet is a service that's available in China. If this CNAME record is present, and your Microsoft 365 service is not operated by 21Vianet, users on your custom domain will receive a "custom domain isn't in our system" error message. Because of this error, users won't be able to activate their Microsoft 365 apps license. If you find this CNAME record, delete it, and wait for DNS replication to update the DNS record.

</details>

<details>
<summary><b>Check BrokerPlugin process</b></summary>

Some antivirus, proxy, or firewall software might block the following plug-in process:

`Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`

Temporarily disable your antivirus software. Contact your system administrator to find out if you are behind a proxy or firewall that is blocking this process. If so, you will also need to temporarily disable your proxy or firewall connection. If you connect through a Virtual Private Network (VPN), you might need to temporarily disable your VPN also.

If the process isn’t blocked, but you still can’t activate Microsoft 365, delete your BrokerPlugin data and then reinstall it using the following steps:

1.	Open File Explorer, and put the following location in the address bar:
`%LOCALAPPDATA%\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\AC\TokenBroker\Accounts`
1.	Press CTRL + A to select all.
1.	Right-click in the selected files and choose **Delete**.
1.	Put the following location in the File Explorer address bar:
`%LOCALAPPDATA%\Packages\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy\AC\TokenBroker\Accounts`
1.	Select all files and delete them.
1.	Restart the device.
1.	Run the [Microsoft 365 sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome).

For manual troubleshooting for step 7, or for more information, see [Fix authentication issues in Microsoft 365 applications when you try to connect to a Microsoft 365 service](/microsoft-365/troubleshoot/authentication/automatic-authentication-fails).
<br/><br/>
</details>

<details>
<summary><b>Add Microsoft 365 Apps to the Windows Information Protection (WIP) allowed apps list</b></summary>

If WIP is configured, you might encounter error code 0x80070164 when trying to activate. For more information about adding apps to the allowed list, see [List of enlightened Microsoft apps for use with Windows Information Protection (WIP)](/windows/security/information-protection/windows-information-protection/enlightened-microsoft-apps-and-wip).
<br/><br/>
</details>

<details>
<summary><b>Make sure Virtual Desktop Infrastructure (VDI) is configured correctly</b></summary>

If you are using VDI, make sure your Microsoft 365 credentials are not roamed. 
If you are using non-persistent VDI, set up Seamless Single Sign On (SSO). For more information, see [Microsoft Entra seamless single sign-on](/azure/active-directory/hybrid/how-to-connect-sso).
<br/><br/>
</details>

<details>
<summary><b>Remove Office credentials</b></summary>

1.	From Start, type credential manager, and then select **Credential Manager** from the search results.
1.	Select **Windows credentials**.
1.	If there are any credentials for **MicrosoftOffice16**, select the arrow next to them and then select **Remove**.
1.	Close Credential Manager.
1.	From Start, select **Settings** (the gear icon) > **Accounts** > **Access work or school**.
1.	If the account you use to sign in to office.com is listed there, but it isn’t the account you use to sign in to Windows, select it, and then select **Disconnect**.
1.	Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Enable Office Protection Policy</b></summary>

1.	Open a Microsoft 365 app, such as Word.
1.	Select your name and profile picture at the top, then select **Sign out**.
1.	Close the app.
1.	From Start, select **Settings** (the gear icon) > **Accounts** > **Access work or school**.
1.	Select the account you use to sign in to office.com is listed there, and then select **Disconnect**.
1.	From Start, type *regedit*, and then select **Registry Editor** from the search results.
1.	Use the arrows to expand selections and navigate to:
`HKEY_LOCAL_MACHINE\Software\Microsoft\Cryptography\Protect\Providers\df9d8cd0-1501-11d1-8c7a-00c04fc297eb`
1.	Right-click the registry value and select **New**, then select **DWORD**.
1.	Name the DWORD `ProtectionPolicy` and set the value to 1.
1.	Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Disable Mobile Device Management (MDM) and Mobile Application Management (MAM) in Microsoft Intune</b></summary>

Using the [Microsoft Endpoint Manager admin center](/azure/active-directory/hybrid/how-to-connect-sso), set MDM and MAM to **None**.
For more information, see [Device management overview](/mem/intune/fundamentals/what-is-device-management).
<br/><br/>
</details>

<details>
<summary><b>Activate with federated organization credentials</b></summary>

1.	From Start, type regedit, and then select **Registry Editor** from the search results.  
1.	Use the arrows to expand selections and navigate to:
`HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common`
1.	Right-click the registry value and select **New**, then select **DWORD**.
1.	Name the DWORD `Autoorgidgetkey` and set the value to 1.
1.	Restart the device and try to activate Microsoft 365 again.

<br/><br/>
</details>

## Additional troubleshooting

If the above steps don’t solve the problem, try the steps in the following article:

- [Microsoft 365 Apps activation error: “Trusted Platform Module malfunctioned”](./tpm-malfunctioned.md)
