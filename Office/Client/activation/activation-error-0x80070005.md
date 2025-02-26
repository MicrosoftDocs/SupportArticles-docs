---
title: Microsoft 365 Apps activation error 0x80070005
description: Troubleshooting steps for activation error 0x80070005.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Error Codes
  - CSSTroubleshoot
  - CI 157591
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/25/2025
---

# Microsoft 365 Apps activation error 0x80070005

When you try to activate Microsoft 365 apps, you might encounter the following error code:

> 0x80070005

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>

<details>
<summary><b>Update Windows</b></summary>

1.	From Start, type check for updates, and select **Check for updates** from the search results.
1.	Select **Check for updates**.
1.	Download and install available updates.
1.	Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

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
<summary><b>Rename tokens.dat file</b></summary>

1.	Open a Command Prompt window as an administrator. From Start, type *cmd.exe* in the search box, right-click **Command Prompt** in the list, and then select **Run as administrator**.  
1.	Type the following command, and then press Enter:
`net stop sppsvc`
1.	Open File Explorer, and put the following location in the address bar:
`%SystemDrive%\windows\System32\spp\store\2.0`
1.	Right-click the tokens.dat file and select **Rename**.
1.	Rename the file tokens.old.
1.	Go back to the Command Prompt window, type the following command, and then press Enter:
`net start sppsvc`
1.	Perform an [online repair of Office](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).
1.	Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Create a new Windows user account</b></summary>

1.	Perform a clean boot of Windows. For instructions, see [How to perform a clean boot in Windows](https://support.microsoft.com/topic/how-to-perform-a-clean-boot-in-windows-da2f9573-6eec-00ad-2f8a-a97a1807f3dd).
1.	Create a new user account, and then make that account an administrator. For instructions, see [Create a local user or administrator account in Windows]( https://support.microsoft.com/windows/create-a-local-user-or-administrator-account-in-windows-20de74e0-ac7f-3502-a866-32915af2a34d#WindowsVersion=Windows_10).
1.	Sign in to Windows with the new account.
1.	Download and install Office.
1.	Try to activate Microsoft 365 again.
<br/><br/>
</details>

## References

- [Office error code 0x80070005 when activating Office](https://support.microsoft.com/office/office-error-code-0x80070005-when-activating-office-7aa7600f-df57-4aef-81d2-25509c66f865)
