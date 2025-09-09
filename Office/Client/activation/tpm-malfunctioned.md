---
title: Microsoft 365 Apps activation error Trusted Platform Module malfunctioned
description: Troubleshooting methods for activation errors related to the TPM.
author: Cloud-Writer
ms.reviewer: vikkarti
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Trusted Platform Module malfunctioned
  - CSSTroubleshoot
  - CI 157590
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/27/2025
---

# Microsoft 365 Apps activation error: “Trusted Platform Module malfunctioned”

When you try to activate Microsoft 365 apps, you encounter the error:

> Trusted Platform Module malfunctioned

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)

<br/>
<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/>
<br/>
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
1.	Run the [Microsoft 365 sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome).

For manual troubleshooting for step 7, or for more information, see [Fix authentication issues in Microsoft 365 applications when you try to connect to a Microsoft 365 service](/microsoft-365/troubleshoot/authentication/automatic-authentication-fails).
<br/><br/>
</details>

<details>
<summary><b>Clear the Trusted Platform Module (TPM) </b></summary>

1. From Start, select **Settings** (the gear icon) > **Update & Security** > **Windows Security** > **Device Security**.  
1. Under **Security processor**, select **Security processor details** > **Security processor troubleshooting**.  
1. Select **Clear TPM**.
1. Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Troubleshoot Microsoft Entra hybrid join</b></summary>

1.	Open a Command Prompt window as an administrator. From Start, type *cmd.exe* in the search box, right-click **Command Prompt** in the list, and then select **Run as administrator**.  
1. Type the following command, and then press Enter:

   `dsregcmd /status`

If EventID 220 is present in User Device Registration event logs, see [Troubleshoot Microsoft Entra hybrid joined devices](/azure/active-directory/devices/troubleshoot-hybrid-join-windows-current).

If error code 0x801c001d is present, [configure a service connection point](/azure/active-directory/devices/hybrid-azuread-join-manual#configure-a-service-connection-point).
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
<summary><b>Disconnect from and then connect to Microsoft Entra ID</b></summary>

1.	From Start, select **Settings** (the gear icon) > **Accounts** > **Access work or school**.
1.	Select the Microsoft Entra ID connection.
1.	Select **Disconnect**.
1.	Restart the device.
1.	Return to the **Access work or school** page as described in step 1.
1.	Select **Join this device to Microsoft Entra ID**.
1.	Enter your credentials.
1.	Select **Let my organization manage my device**.
1.	Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Enable Memory integrity</b></summary>

1.	From Start, select **Settings** (the gear icon) > **Update & Security** > **Windows Security** > **Device Security**.  
1.	Under **Core isolation**, select **Core isolation details**.
1.	Turn **Memory integrity** on.
1.	Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Enable or add the device in Microsoft Entra ID</b></summary>

If the device was disabled in Microsoft Entra ID, an administrator who has sufficient privileges can re-enable it from the Microsoft Entra admin center, as follows:

1.	Sign in to the [Azure portal](https://portal.azure.com).
1.	Select **Microsoft Entra ID** > **Devices**.
1.	Examine the disabled devices list in **Devices**, by searching on the username or device name.
1.	Select the device, and then select **Enable**.

For more information, see [Manage device identities using the Azure portal](/azure/active-directory/devices/device-management-azure-portal#device-management-tasks). 

If the device was deleted in Microsoft Entra ID, you have to re-register it manually. For detailed steps to do this, see [Re-enable or re-register the device](/azure/active-directory/devices/faq#q-i-disabled-or-deleted-my-device-in-the-azure-portal-or-by-using-windows-powershell-but-the-local-state-on-the-device-says-its-still-registered-what-should-i-do).
<br/><br/>
</details>

<details>
<summary><b>Update your device’s BIOS</b></summary>

Update the BIOS for your device. If you need more information about doing so, contact the manufacturer of your device. If you are using a Microsoft Surface device, see [Download drivers and firmware for Surface](https://support.microsoft.com/surface/download-drivers-and-firmware-for-surface-09bb2e09-2a4b-cb69-0951-078a7739e120).
<br/><br/>
</details>

<details>
<summary><b>Make sure the TPM is set to Active</b></summary>

1.	Restart your device. Before Windows loads, press F1.
1.	Under the Security tab, check if **TPM 1.2** is selected.
1.	If **TPM 1.2** is selected, make sure that **Security Chip** is set to **Active**.
1.	Save and exit. When Windows starts, try to activate Microsoft 365 again.

**Note** Microsoft recommends using TPM 2.0 whenever possible.
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
