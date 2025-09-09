---
title: Microsoft 365 Apps activation error 0xCAA50021
description: Troubleshooting steps for Microsoft 365 Apps activation error 0xCAA50021
author: Cloud-Writer
ms.reviewer: vikkarti
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Error Codes
  - CSSTroubleshoot
  - CI 157595
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/25/2025
---

# Microsoft 365 Apps activation error 0xCAA50021

When activating Microsoft 365 apps, you might encounter the following error:

> ERROR: 0xCAA50021

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
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
<summary><b>Perform a manual recovery</b></summary>

See the ["Manual recovery" section of Connection issues in sign-in after update to Office 2016 build 16.0.7967 on Windows 10](/microsoft-365/troubleshoot/authentication/connection-issue-when-sign-in-office-2016#manualrecovery).

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

For manual troubleshooting for step 7, or for more information, see [Fix authentication issues in Office applications when you try to connect to a Microsoft 365 service](/microsoft-365/troubleshoot/authentication/automatic-authentication-fails).
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
<summary><b>Check if user device registration is enabled in Microsoft Entra ID</b></summary>

1.	Sign in to the [Microsoft 365 Admin Center](https://admin.microsoft.com/).  
1.	Select **Identity** from the **Admin centers** section of the menu. If **Admin centers** isn't displayed in the menu, select **Show All**.  
1.	Expand **Identity** in the menu of the Microsoft Entra admin center.  
1.	Select **Device** > **All devices**, then select **Device settings** under the **Manage** section.
1.	Make sure that **Users may join devices to Microsoft Entra ID** is set to **All**.  
1.	Make sure that **Users may register their devices with Microsoft Entra ID** is set to **All**.
<br/><br/>
</details>

<details>
<summary><b>Leave and rejoin Microsoft Entra ID</b></summary>

1.	Open a Command Prompt window as an administrator. From Start, type *cmd.exe* in the search box, right-click **Command Prompt** in the list, and then select **Run as administrator**.
1.	Type the following command, and then press Enter:
`dsregcmd /status`
1.	Check if the device is joined to Microsoft Entra ID. For more details, see [Troubleshoot devices by using the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd).
1.	If the **AzureAdjoined** value is **YES**, continue to step 5. If it’s **NO**, skip to step 11.
1.	Type the following command, and then press Enter:
`dsregcmd /leave`
1.	Type the command `dsregcmd /status` again and press Enter.
1.	Verify that the **AzureAdjoined** value is **NO**.
1.	Restart the device.
1.	Open a Command Prompt as administrator, and type the `dsregcmd /status` command again.
1.	If the **AzureAdjoined** value is **YES**, try to activate Microsoft 365 Apps again. If it’s **NO**, continue to the next step.
1.	Download [PsExec](/sysinternals/downloads/psexec).
1.	Return to the Command Prompt and type the following command:
`psexec -i -s cmd.exe`
1.	In the new Command Prompt window that opens, type the following command:
`dsregcmd /join`
1.	Type the dsregcmd /status command again, and verify that the **AzureAdjoined** value is **YES**.
1.	Try to activate Microsoft 365 Apps again.
<br/><br/>
</details>

### Additional troubleshooting

If the above steps don’t solve the problem, try the steps in the following articles:

- [Microsoft 365 activation network connection issues](./network-connection-issues.md)

- [Microsoft 365 activation sign in errors](./sign-in-issues.md)
