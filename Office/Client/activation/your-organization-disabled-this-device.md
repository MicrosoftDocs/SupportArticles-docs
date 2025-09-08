---
title: Microsoft 365 Apps activation error Your organization has disabled this device
description: Troubleshooting steps for the error Your organization has disabled this device
author: Cloud-Writer
ms.reviewer: vikkarti
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Your organization has disabled this device
  - CSSTroubleshoot
  - CI 157589
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/27/2025
---

# Microsoft 365 Apps activation error: “Your organization has disabled this device”

When trying to activate Microsoft 365 apps, you might encounter the following error:

> Your organization has disabled this device

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>

<details>
<summary><b>Enable the device in Microsoft Entra ID</b></summary>

1.	Sign in to the [Azure portal](https://portal.azure.com).
1.	Select **Microsoft Entra ID** > **Devices**.
1.	Check the disabled devices list in **Devices**, by searching on the user name or device name.
1.	Select the device, and then select **Enable**.
  
If the device has been deleted in Microsoft Entra ID, you need to re-register it.

1.	Go to **Settings** > **Accounts** > **Access Work or School**.
1.	Select the account and select **Disconnect**.
1.	Select **Connect** and register the device again by going through the sign in process.
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>

<details>
<summary><b>Check for a duplicate device</b></summary>

An admin can check for duplicate devices that might be blocking activation, and remove them. For instructions, see [How To: Manage stale devices in Microsoft Entra ID](/azure/active-directory/devices/manage-stale-devices).

After the duplicate device is removed , delete your BrokerPlugin data and then reinstall it using the following steps:
  
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
<summary><b>Make sure the device is enrolled in Mobile Device Management (MDM) </b></summary>

Check whether the device is enrolled in MDM using the information in the [Tenant Details section of Troubleshoot devices by using the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd#tenant-details).

If it isn’t, an admin can configure MDM enrollment in Microsoft Entra ID using the information in [Set up enrollment for Windows devices](/mem/intune/enrollment/windows-enroll#configure-automatic-mdm-enrollment).

After that, enroll the device in MDM. For instructions, see [MDM enrollment of Windows 10-based devices](/windows/client-management/mdm/mdm-enrollment-of-windows-devices).
<br/><br/>
</details>

<details>
<summary><b>Sign in to Microsoft Entra ID</b></summary>

1.	Open a Command Prompt window as an administrator. From Start, type *cmd.exe* in the search box, right-click **Command Prompt** in the list, and then select **Run as administrator**.
1.	Type the following command, and then press Enter:
`dsregcmd /forcerecovery`
1.	Select **Sign in** in the dialog box that appears, and complete sign in.
1.	From Start, select your profile, and then select **Sign out**.
1.	Sign in to Windows again and try to activate Microsoft 365 Apps.
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

If the above methods don’t solve the problem, try the troubleshooting methods in [Microsoft 365 Apps activation error: “Sorry, another account from your organization is already signed in on this computer”](./another-account-already-signed-in.md)
