---
title: Account or Subscription Verification Errors Activating Microsoft 365 Apps
description: Troubleshooting steps for account or subscription errors when you activate Microsoft 365 Apps.
ms.reviewer: vikkarti
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Couldn't verify account or subscription or license
  - CSSTroubleshoot
  - CI 157752
  - CI 159119
  - CI 5838
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 05/19/2025
---

# Account or subscription verification errors activating Microsoft 365 Apps

When you try to activate Microsoft 365 Apps, you receive one of the following error messages:

> We couldn't verify the subscription  

> Error: Unable to verify the account  

> Couldn't verify account. We are having trouble verifying your Microsoft 365 account on this computer. Most features will be turned off on (date).

To solve the problem, try the following troubleshooting methods.

> [!NOTE]
> Some of these troubleshooting methods can be performed only by a Microsoft 365 admin. If you aren't an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)

<details>
<summary><b>Update Microsoft 365</b></summary>

It's recommended that you configure Microsoft 365 to install updates automatically. To check for updates, open a Microsoft 365 app (such as Word), select **File** > **Account**. Select **Update options** > **Update now**.

</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).

</details>

<details>
<summary><b>Change your password</b></summary>

[Change your password](https://support.microsoft.com/account-billing/change-your-work-or-school-account-password-97fced88-e0e7-4d7b-a9d3-936a3dcbd569), then try again to activate Microsoft 365.

</details>

<details>
<summary><b>Sign out of Microsoft 365 and sign back in</b></summary>

1. Open a Microsoft 365 app, such as Word.
1. Select your name and profile picture or icon at the top.
1. Select **Sign out**.
1. Select **Sign in**.
1. Make sure that you're signed in by using your **Work or School** account, not your personal Microsoft account.
1. Try to activate Microsoft 365 again.

</details>

<details>
<summary><b>Make sure that you have the correct version of Office installed</b></summary>

1. [Check which Microsoft 365 business product or license](https://support.microsoft.com/office/what-microsoft-365-business-product-or-license-do-i-have-f8ab5e25-bf3f-4a47-b264-174b1ee925fd) you have.
  
   If you're signed in by using your Work or School account, and you don't have a license assigned, [contact your Microsoft 365 administrator](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b) to get a license assigned.
  
   If you have Microsoft 365 for Business Basic, you don't have any Office applications to install. You can use [Microsoft 365 Online apps](https://www.microsoft365.com/apps) instead.
  
1. Make sure that the [bit version of Office](https://support.microsoft.com/office/about-office-what-version-of-office-am-i-using-932788b8-a3ce-44bf-bb09-e334518b8b19) (32-bit or 64-bit) matches your [version of Windows](https://windows.microsoft.com/windows/32-bit-and-64-bit-windows).
  
If you have a different edition or version installed on your device, run the [Microsoft 365 Uninstall troubleshooter](https://aka.ms/SaRA-OfficeUninstall-sarahome) to uninstall Office. Then, restart the device, and [install the correct version](https://support.microsoft.com/office/download-install-or-reinstall-microsoft-365-or-office-2024-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658).

</details>

<details>
<summary><b>Make sure that user licenses are assigned</b></summary>

1. In the [Microsoft 365 Admin Center](https://admin.microsoft.com/), go to the **Users** > **[Active users](https://go.microsoft.com/fwlink/p/?linkid=834822)** page.
1. Select the user that you want to assign a license to.
1. In the right pane, select **Licenses and apps**.
1. Expand the **Licenses** section, select the checkboxes for the licenses that you want to assign, and then select **Save changes**.

   If a license is already assigned, clear the checkbox, select **Save changes**, reselect the checkbox for that license, and then select **Save changes** again.

</details>

<details>
<summary><b>Repair Microsoft 365</b></summary>

Try the steps in [Repair an Office application](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).
<br/><br/>
</details>

<details>
<summary><b>Check whether you're behind a proxy server</b></summary>

If you aren't sure whether you're behind a proxy server, ask your administrator. If so, you (or your administrator) might have to change the proxy settings for Windows HTTP clients. To do so, follow these steps:

1. Open a Command Prompt window as an administrator. From Start, type *cmd.exe* in the search box, right-click **Command Prompt** in the list, and then select **Run as administrator**.
1. Type the following command, and then press Enter:

   `netsh winhttp set proxy <Address of your proxy server>`

You need to allow the [URLs and IP addresses](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide&preserve-view=true#microsoft-365-common-and-office-online).

You can also allow Microsoft 365 to bypass the proxy server by creating a PAC file. For more information about how to create a PAC file, see [Managing Microsoft 365 endpoints](/microsoft-365/enterprise/managing-office-365-endpoints).

</details>

<details>
<summary><b>Check whether you're behind a firewall</b></summary>

If you aren't sure whether you're behind a firewall, ask your administrator. If you're behind a firewall, it must be configured to enable access to the following URLs:

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

Each firewall has a different method to enable access to these URIs. Check your software's documentation for instructions or ask your administrator to do it for you.

For more information about Microsoft 365 Apps for enterprise URLs and IP addresses, see [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide&preserve-view=true).

</details>
