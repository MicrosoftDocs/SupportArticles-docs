---
title: Issues with shared computer activation for Microsoft 365 Apps
description: Troubleshooting steps for issues with shared computer activation for Microsoft 365 Apps.
author: Cloud-Writer
ms.reviewer: vikkarti
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Deploying Office using Shared Computer Activation
  - CSSTroubleshoot
  - CI 157761
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/25/2025
---

# Troubleshoot issues with shared computer activation for Microsoft 365 Apps

If you're having problems getting shared computer activation to work when you deploy Microsoft 365 Apps to shared computers in your organization, try the following to fix the problem.

If you're encountering a specific error message, or you're using RDS, VDI, Citrix, or FSLogix, go directly to the appropriate section:

- <a href="#errors">Specific error messages</a>

- <a href="#rds">Share computer activation on RDS, VDI, or Citrix</a>

- <a href="#fslogix">FSLogix issues with shared computer activation</a>

Otherwise, start with the <a href=#general>General troubleshooting section</a>.

**Tip**

You can use the [Microsoft 365 shared computer activation (SCA) troubleshooter](https://aka.ms/SaRA-OfficeSCA-sarahome) to enable shared computer activation for Microsoft 365 applications.

<h2 id="general"> General troubleshooting</h2>
<br/>
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
<summary><b>Update Windows</b></summary>

1.	From Start, type check for updates, and select **Check for updates** from the search results.
1.	Select **Check for updates**.
1.	Download and install available updates.
1.	Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Check that your Microsoft 365 plan supports shared computer activation</b></summary>

To use shared computer activation, you must have a Microsoft 365 plan that includes Microsoft 365 Apps and that supports shared computer activation. For more information, see [How to enable shared computer activation for Microsoft 365 Apps](/DeployOffice/overview-shared-computer-activation#how-to-enable-shared-computer-activation-for-microsoft-365-apps)

**Note** You also can use shared computer activation with the subscription versions of the Project and Visio desktop apps. You just need a subscription plan that includes those products.
<br/><br/>
</details>

<details>
<summary><b>Verify that shared computer activation is enabled for Microsoft 365 Apps</b></summary>

Here are two ways that you can check whether shared computer activation is enabled on the computer that has Microsoft 365 Apps installed.

- Open any Microsoft 365 application, such as Word. Go to **File** > **Account** > **About Word** (or "About" whichever app you opened). On the second line from the top, underneath the MSO version number, you should see **Shared Computer Activation**, instead of a Product ID, like in the following screenshot.

- Use Registry Editor, and go to `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration`. There should be a value for **SharedComputerLicensing** with a setting of 1.
<br/><br/>
</details>

<details>
<summary><b>Make sure Device-based licensing and robotic process automation (RPA) are disabled</b></summary>

For more information, see the following articles:

- [Device-based licensing for Microsoft 365 Apps for enterprise](/deployoffice/device-based-licensing)

- [Overview of the unattended robotic process automation with Microsoft 365 Apps for enterprise](/deployoffice/overview-unattended)
<br/><br/>
</details>

<details>
<summary><b>Verify that activation for Microsoft 365 Apps succeeded</b></summary>

On the shared computer, after you open any Microsoft 365 application, go to the following folder:

`%localappdata%\Microsoft\Office\16.0\Licensing`

If activation succeeded, there are some text files in the folder, like in the following screenshot. Don't make any changes to these files.

If you've configured the licensing token to roam, these text files will appear in the folder that you've specified.
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>

<details>
<summary><b>Enable licensing token roaming</b></summary>

For instructions, see [Overview of shared computer activation for Microsoft 365 Apps](/DeployOffice/overview-shared-computer-activation).
<br/><br/>
</details>

<details>
<summary><b>Edit the Identity registry value</b></summary>

1.	From Start, type regedit, and then select **Registry Editor** from the results.  
1.	Use the arrows to expand selections and navigate to:
`HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Identity`
1.	Right-click the **Identities** folder and select **Delete**.
1.	Restart the device and try activating Microsoft 365 Apps again.
1.	If you still get the same error, open Registry Editor again, and navigate to the same location.
1.	Right-click **Identity** and select **New**.
1.	Select **DWORD**.
1.	Name the DWORD `NoDomainUser` and set the Value to 1.
1.	Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Delete SignedOutADUser value</b></summary>

1. From Start, type *regedit*, and then select **Registry Editor** from the results.
1. Use the arrows to expand selections and navigate to:
    `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Identity`
1. Right-click **SignedOutADUser** and select **Delete**.  
1. Restart the device and try activating Microsoft 365 Apps again.
<br/><br/>
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
1.	Run the [Microsoft 365 sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome) in Get Help.

For manual troubleshooting for step 7, or for more information, see [Fix authentication issues in Microsoft 365 applications when you try to connect to a Microsoft 365 service](/microsoft-365/troubleshoot/authentication/automatic-authentication-fails).
<br/><br/>
</details>

<details>
<summary><b>Change proxy, firewall, or Group Policy settings</b></summary>

An IT administrator might be able to solve this problem.

First check your firewall or proxy setting. Add an explicit "allow" rule that contains "MSOIDCRL" in your firewall or proxy for agents. For example, set up the rules to first allow MSOIDCRL and to then deny Internet Explorer 6. For more information about how to configure firewall rules, see your firewall documentation.

If the issue persists, check if NCSI active probe is disabled. In this case, enable NCSI active probe by using the registry or Group Policy Objects (GPOs).

To use the registry to enable NCSI active probe, configure one of the following registry keys:

**Important**

Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur. 

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet\EnableActiveProbing`
-	Type: DWORD
-	Value: Decimal 1
`HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator\NoActiveProbe`
-	Type: DWORD
-	Value: Decimal 0

To use Group Policy to enable NCSI active probe, configure the following GPO: 
**Computer Configuration\Administrative Templates\System\Internet Communication Management\Internet Communication settings\Turn off Windows Network Connectivity Status** <br/>**Indicator active tests**
<br/>**Value: Disabled**
<br/><br/>
</details>

<h2 id=errors>Specific error messages</h2>
<br/>
If you're having problems using shared computer activation, you might get one of the following error messages.
<br/><br/>
<details>
<summary><b>The products we found in your account cannot be used to activate Office in shared computer scenarios.</b></summary>

This error means that you don't have a Microsoft 365 plan that includes Microsoft 365 Apps and that supports shared computer activation. Therefore, you can't use shared computer activation.
<br/><br/>
</details>

<details>
<summary><b>UNLICENSED PRODUCT Most features are turned off because a shared computer license isn't available.</b></summary>

This error means that a licensing token wasn't obtained from the Office Licensing Service on the internet. Office is now in reduced functionality mode. The users can view and print Office documents, but can't create or edit documents.

You can try these steps to fix this problem:

- [Check that the users are assigned a license](/microsoft-365/admin/manage/assign-licenses-to-users) for Microsoft 365 Apps.

- Check that the users sign in with their user account for Microsoft 365 if the **Activate Office** dialog box appears when they open a Microsoft 365 application.

- Check that there is connectivity between the shared computer and the internet.
<br/><br/>
</details>

<details>
<summary><b>Sorry, we cannot verify the license currently installed for this product.</b></summary>

This error means that Office has a problem with the users' licensing token on the shared computer. The users should make sure to sign in to Office with their user account for Microsoft 365 so that Office can obtain a new licensing token from the Office Licensing Service on the internet.
<br/><br/>
</details>

<details>
<summary><b>PRODUCT NOTICE Your shared computer license expires on (date) and we're having trouble renewing it.</b></summary>

This error means that Office tried to renew the licensing token automatically, but there was a problem. One possible cause for this is that the shared computer wasn't connected to the internet when Office tried to renew the licensing token with the Office Licensing Service.

The licensing token is valid until the date listed in the error message. The user can continue to use Microsoft 365 apps to create, edit, and print documents. The user can choose **Renew** to try to renew the license before the license token expires.
<br/><br/>
</details>

<details>
<summary><b>Sorry, this Microsoft 365 account has recently been used to activate too many computers.</b></summary>

Microsoft places a limit on the number of shared computers that a user can activate Microsoft 365 on in a given time period. This error means that the user exceeded that limit.
<br/><br/>
</details>

<h2 id=rds>Shared computer activation on RDS, VDI, or Citrix</h2>
<br/>
<details>
<summary><b>Citrix issues</b></summary>

If you are having trouble with shared computer activation using Citrix, see the following Citrix articles:

- [Password Field Not Displayed When Publishing Any Microsoft 365 Application Such As Excel or Word On Server 2019 or Windows 10](https://support.citrix.com/article/CTX267071)

- [Microsoft 365 Apps (Office 365) is Randomly Asking Users to Reactivate](https://support.citrix.com/article/CTX227286)

- [Microsoft 365 activation issue with Windows 10 VDI's](https://support.citrix.com/article/CTX289614)
<br/><br/>
</details>

<details>
<summary><b>Make sure RDS servers are joined to Microsoft Entra ID</b></summary>

Use Microsoft Entra Connect Sync to set up password hash synchronization and Seamless Single Sign-on (Seamless SSO). For instructions, see the following articles:

- [Implement password hash synchronization with Microsoft Entra Connect Sync](/azure/active-directory/hybrid/how-to-connect-password-hash-synchronization)

- [Microsoft Entra seamless single sign-on](/azure/active-directory/hybrid/how-to-connect-sso)
<br/><br/>
</details>

<details>
<summary><b>Users continually prompted to activate</b></summary>

If individuals using RDS or VDI are repeatedly prompted to activate, try enabling licensing token roaming. For instructions, see [Overview of shared computer activation for Microsoft 365 Apps](/DeployOffice/overview-shared-computer-activation).

If you don’t enable licensing token roaming, a workaround is to set the Session Collection settings to **Store all user settings and data on the user profile disk**. For more information about these settings, see [Remote Desktop Services - Secure data storage with UPDs](/windows-server/remote/remote-desktop-services/rds-plan-secure-data-storage).
<br/><br/>
</details>

<details>
<summary><b>Make sure ADAL is enabled</b></summary>

1. From Start, type *regedit*, and then select **Registry Editor** from the search results.
1. Use the arrows to expand selections and navigate to:
    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\Common\Identity\EnableADAL`
1. Set the value to 1.
1. Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>
  
<h2 id=fslogix>FSLogix issues with shared computer activation</h2>
<br/>
<details>
<summary><b>SSO configuration</b></summary>

If you’re using FSLogix and SSO:

1. From Start, type *regedit*, and then select **Registry Editor** from the search results.
1. Use the arrows to expand selections and navigate to:
    `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\FSLogix\ODFC`
1. Select the DWORD `IncludeOfficeActivation` and set the value to 0.
1. Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Microsoft 365 Container Exclusions</b></summary>

When the FSLogix Microsoft 365 container is used with any other profile solution (except local Windows profiles) the following folders need to be excluded from handling by the profile solution:

- OneDrive
- SharePoint
- Outlook
- OneNote
- Teams
- Search
- Skype for Business
- Licensing
- Office file cache

Additionally, configure UPD to use the setting **Store only the following folders on the user profile disk**, and select only the options not managed by FSLogix.
<br/><br/>
</details>
  
<details>
<summary><b>Activate with federated organization credentials</b></summary>

1. From Start, type *regedit*, and then select **Registry Editor** from the search results.
1. Use the arrows to expand selections and navigate to:
    `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common`
1. Right-click the registry value and select New, then select **DWORD**.
1. Name the DWORD `Autoorgidgetkey` and set the value to 1.
1. Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Further Troubleshooting for FSLogix</b></summary>

If the above methods don’t solve the issue, see [Trouble Shooting Guide for FSLogix products](/fslogix/fslogix-trouble-shooting-ht).
<br/><br/>
</details>

## References

- [Overview of shared computer activation for Microsoft 365 Apps](/DeployOffice/overview-shared-computer-activation)

- [Deploy Microsoft 365 Apps by using Remote Desktop Services](/DeployOffice/deploy-microsoft-365-apps-remote-desktop-services)
