---
title: Account or subscription verification errors activating Microsoft 365 Apps
description: Troubleshooting steps for account or subscription errors when activating Microsoft 365 Apps.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Couldn't verify account or subscription or license
  - CSSTroubleshoot
  - CI 157752
  - CI 159119
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/27/2025
---

# Account or subscription verification errors activating Microsoft 365 Apps

When you try to activate Microsoft 365 Apps, you encounter one of the following errors:

> We couldn't verify the subscription  

> Error: Unable to verify the account  

> Couldn't verify account. We are having trouble verifying your Microsoft 365 account on this computer. Most features will be turned off on (date).

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren't an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>

<details>
<summary><b>Activating Microsoft 365 on Windows 8.1 or earlier</b></summary>

To activate Microsoft 365 Apps, TLS 1.2 must be enabled on the operating system. Some older operating systems, such as Windows 7 SP1, Windows Server 2008 R2, and Windows Server 2012, require an update to enable TLS 1.2 by default.

**Important** Running Microsoft 365 Apps on these older operating systems isn't supported. For more information, see [End of support resources for Office](/deployoffice/endofsupport/resources).

1. If you're running Windows 7 or Windows Server 2008, make sure that [Service Pack 1]( https://support.microsoft.com/topic/information-about-service-pack-1-for-windows-7-and-for-windows-server-2008-r2-df044624-55b8-3a97-de80-5d99cb689063) is installed.
1. Enable TLS 1.2 as the default protocol by using [this easy fix]( https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi), and then restart the device.
1. From Start, select **Control Panel** > **Internet options** > **Advanced settings**.
1. If **TLS 1.2** isn't checked, check it, then select **Apply** and **OK**.
1. Restart the device, and then try activating Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Update Microsoft 365</b></summary>

It is recommended that Microsoft 365 be configured to install updates automatically. To check for updates, open a Microsoft 365 app (such as Word), select **File**, and then select **Account**.
Select **Update options**, and then select **Update now**.
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>

<details>
<summary><b>Reset your password</b></summary>

Go to https://portal.office.com/account and select **Security & privacy**. Reset your password, then try activating Microsoft 365 again.
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
<summary><b>Make sure you have the correct Office installed</b></summary>

Go to https://portal.office.com/account to check which Office version and edition you have available.  

If no Office version is shown, you don't have an Office license assigned to the account you are signed in with. If you are signed in with your Work or School account, and don't have a license assigned, contact your Microsoft 365 Administrator to get a license assigned. [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)  

If you have Microsoft 365 for Business Basic, you won't have any Office applications to install. You can use Office Online apps at https://office.com.

Make sure that the version listed (32-bit or 64-bit) matches your version of Windows. To check what version of Windows you have installed, go to **Start** > **Settings** (gear icon) > **System** > **About**, and check the **System type**.  

If you have a different edition or version installed on your device, run the [Microsoft 365 Uninstall troubleshooter](https://aka.ms/SaRA-OfficeUninstall-sarahome) to uninstall Microsoft 365 or Office. Restart the device, and install from https://portal.office.com/account to get the correct version.  
<br/><br/>
</details>

<details>
<summary><b>Make sure user licenses are assigned</b></summary>

1.	In the [Microsoft 365 Admin Center](https://admin.microsoft.com/), go to the **Users** > [Active users](https://go.microsoft.com/fwlink/p/?linkid=834822) page.
1.	Select the row of the user that you want to assign a license to.
1.	In the right pane, select **Licenses and Apps**.
1.	Expand the **Licenses** section, select the boxes for the licenses that you want to assign, then select **Save changes**.
1.	If the license is already assigned, uncheck it, select **Save changes**, then check it again and select **Save changes** again.
<br/><br/>
</details>

<details>
<summary><b>Repair Microsoft 365</b></summary>

Try the steps in the article [Repair an Office application](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).
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

Each firewall has a different method to enable access to these URIs. Check your software's documentation for instructions or ask your administrator to do this for you.

For more information about Microsoft 365 Apps for enterprise URLs and IP addresses, see [Microsoft 365 URLs and IP address ranges](https://technet.microsoft.com/library/hh373144.aspx).
<br/><br/>
</details>
