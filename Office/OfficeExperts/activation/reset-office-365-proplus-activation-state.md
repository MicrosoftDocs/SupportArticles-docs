---
title: RReset activation state for Microsoft 365 Apps for enterprise
description: Four locations must be cleared to reset the activation or install to a clean state after Office 365 users are activated.
author: MJP-MSFT
manager: dcscontentpm
localization_priority: Normal
search.appverid: MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
- sap:office-experts
- CSSTroubleshoot
- CI 114181
- CI 115742
- CI 162124
ms.author: mattphil
appliesto: 
  - Microsoft 365 Apps for enterprise
---

# Reset activation state for Microsoft 365 Apps for enterprise

This article is written and maintained by [Eric Splichal](https://social.technet.microsoft.com/profile/Splic-MSFT), Senior Support Escalation Engineer, [Matt Philipenko](https://social.technet.microsoft.com/profile/MattPhil+-+MSFT), Microsoft 365 Apps Ranger, and Tim Johnson, Support Escalation Engineer.

You might need to perform tasks such as the following for your organization:

- Tenant to tenant migration
- Repurpose a device for a different user
- Switch the license mode on a device

To complete these tasks, you need to clear prior activations of Microsoft 365 apps for enterprise to remove their related licenses and cached Office account information. This removal will reset the applications to a clean state. You can then activate them with a different Office account or change to a different license mode.
To reset the activation state, close all Office applications and use one of the following methods.

> [!NOTE]
> - The steps below apply to Microsoft Project and Microsoft Visio also.
> - The steps and scripts in this article apply to Windows installations of Office apps. For Office for Mac installations, see [How to remove Office license files on a Mac](https://support.microsoft.com/office/how-to-remove-office-license-files-on-a-mac-b032c0f6-a431-4dad-83a9-6b727c03b193).

## Method 1: Use the Microsoft Support and Recovery Assistant

For an automated solution to reset the activation state, download and run the Assistant. Select the button below to begin.

> [!div class="nextstepaction"]
> [Download the Assistant](https://aka.ms/SaRA-OfficeActivation-Reset)

## Method 2: Use scripts to automate the process

Run the following scripts that automate each section of the process:

1. To remove previous licenses and cached account information: download the [OLicenseCleanup.zip](https://download.microsoft.com/download/e/1/b/e1bbdc16-fad4-4aa2-a309-2ba3cae8d424/OLicenseCleanup.zip) file, extract the **OLicenseCleanup.vbs** script, and run it using elevated permissions.
1. To clear the WAM accounts on the device that are associated with Office: download the [signoutofwamaccounts.zip](https://download.microsoft.com/download/f/8/7/f8745d3b-49ad-4eac-b49a-2fa60b929e7d/signoutofwamaccounts.zip) file, extract, and run the **signoutofwamaccounts.ps1** script with elevated permissions.
If you save signoutofwamaccounts.ps1 in the same location as OLicenseCleanup.vbs, then it will be executed automatically when you run OLicenseCleanup.vbs.
c.	To remove Workplace Joined accounts: download [WPJCleanUp.zip](https://download.microsoft.com/download/8/e/f/8ef13ae0-6aa8-48a2-8697-5b1711134730/WPJCleanUp.zip), extract the WPJCleanUp folder, and run **WPJCleanUp.cmd**.

## Method 3: Manually reset activation state

The first phase of the process involves the following steps:

<br>
<details>
<summary><b>Step 1: Remove previous Office activations</b></summary>

Check for and remove existing licenses on the device. Make sure to check all the noted locations for potential license types, which include vNext, Shared Computer Activation, and Legacy licenses.

1. Remove all license token files and folders if found in the following locations:
      - For vNext license type:
      `%localappdata%\Microsoft\Office\Licenses` (Microsoft 365 Apps for enterprise version 1909 or later)
      - For Shared Computer Activation license type:
      `%localappdata%\Microsoft\Office\16.0\Licensing`

1. Run the ospp.vbs script from an elevated command prompt to check for and remove possible Legacy licensing.

   > [!IMPORTANT]
   > Before you run the ospp.vbs script:
   > - If you're running the script on a remote computer, make sure that the remote computer's Windows firewall allows Windows Management Instrumentation (WMI) traffic.
   > - Make sure the user account you use is a member of the Administrators group on the computer on which you run the script.

1. To set the correct directory, run one of the following commands from an elevated command prompt, as appropriate for your Office installation:
   - For a 64-bit Office installation on a 64-bit operating system:
      `cd "C:\Program Files\Microsoft Office\Office16"`
   - For a 32-bit Office installation on a 64-bit operating system.
      `cd "C:\Program Files (x86)\Microsoft Office\Office16"`

1. Run the following command to get a list of the licenses currently in use:
    `cscript ospp.vbs /dstatus`

    The ospp.vbs command displays license information for installed product keys. The output is in this format:
    :::image type="content" source="media/reset-office-365-proplus-activation-state/capture1.png" alt-text="Output inclues Product ID, SKU ID, License Name, License Description, License Status, Error Code, and Last 5 characters of installed product key":::

   >[!Note]
   > The results of the command could include multiple licenses. If the output displays "No installed product keys detected" after you run `ospp.vbs /dstatus`, skip 5 and 6 below and go to <u><a href="#step2">Step 2: Remove cached Office account identities in HKCU registry</a></u>.

    If a partial product key is returned for the applications licenses you want to remove, take note of the **Last 5 characters of the installed product key** because you'll use it in the next instruction.

1. Run the following command to remove the license for the applicable application:
    `cscript ospp.vbs /unpkey:<last 5 characters of product key>`
    For example:
    `cscript ospp.vbs /unpkey:2WC00`
    
    You should see the message “Product key uninstall successful” when the license is removed.
    :::image type="content" source="media/reset-office-365-proplus-activation-state/capture3.png" alt-text="Output shows Uninstalling product key for Office 16, and the message Product key uninstall successful":::

1. Repeat the `cscript ospp.vbs /dstatus` and `/unpkey` commands as needed to remove all keys for the applications for which you need to remove previous activations. When you've removed all the necessary product keys, close the Command Prompt window.

</details>

<div id="step2">
<br>
<details>
<summary><b>Step 2: Remove cached Office account identities in HKCU registry</b></summary>

> [!WARNING]
> Follow this section's steps carefully. Incorrect registry entries can cause serious system issues. As a precaution, [back up the registry for restoration](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows).

Delete the following registry entries:

- `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common`
- `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Licensing`

> [!NOTE]
> If you have Shared Computer Activation enabled, remove the Identity registry key location from the `HKEY_USERS\<The user's SID>\Software\Microsoft\Office\16.0\Common`registry key. To get the currently signed in user’s SID, use the command `whoami /user` in a non-elevated command prompt.

</details>

<br>
<details>
<summary><b>Step 3: Remove Office credentials stored in Windows Credential Manager</b></summary>

1. Open **Control Panel** > **Credential Manager**.
1. Select **Windows Credentials**.
1. Remove all credentials listed for Office by selecting the drop-down arrow next to each one, and select **Remove**.

    :::image type="content" source="media/reset-office-365-proplus-activation-state/credmanager.png" alt-text="Credential Manager example shows two entries for Office":::

1. Delete the files or values under the following registry entry:
    `HKEY_CURRENT_USER\Software\Microsoft\Protected Storage System`

</details>

Continue to <a href="#clearcached">Clear cached Office credentials for managed devices</a>.

<h3 id="clearcached">Clear cached Office credentials for managed devices</h3>

For managed devices, there are additional locations from which you need to remove cached Office credentials. Devices are considered managed if they are Azure AD Joined (AADJ), Hybrid Azure AD Joined (HAADJ), or Workplace Joined (WPJ). These configurations use Web Account Management (WAM), which stores credentials in different locations.

To check whether your device is managed, see <a href="#checkmanaged">Check whether a device is managed</a>.

There are no steps that you can run manually to clear WAM accounts associated with Office on the device for AADJ and HAADJ devices. The only option is to use a script that automates the steps.

Download the [signoutofwamaccounts.zip](https://download.microsoft.com/download/f/8/7/f8745d3b-49ad-4eac-b49a-2fa60b929e7d/signoutofwamaccounts.zip) file, extract, and run the **signoutofwamaccounts.ps1** script as administrator. 

The **signoutofwamaccounts.ps1** script will remove the tokens and accounts associated with Office and is safe to run. It will not affect the Single Sign-On (SSO) state of the applications and the device state.

The **signoutofwamaccounts.ps1** script can be run only on Windows 10 version 1803 and later. If your operating system isn't compatible, you'll see a notification that the script is not supported on your version of Windows.

Continue to <a href="#clearwpj">Clear Workplace-Joined accounts</a>.

<h3 id="clearwpj">Clear Workplace-Joined accounts</h3>

When you clear WAM accounts associated with Office on  WPJ devices, the Single Sign-On (SSO) behavior for the current Windows session will be removed as well. All applications in the current Windows session will lose their SSO state and, the device will be unenrolled from management tools (MDM) and unregistered from the cloud. The next time users try to sign in to an application, they will be asked to add their account to all the services again.

To clear Workplace Joined accounts manually:

1.	Navigate to Windows Settings on the device.
1.	Select **Access Work or School**.
1.	Select the work or school account to be removed, and then select **Disconnect**.

<h3 id="checkmanaged">Check whether a device is managed</h3>

Run the [dsregcmd](/azure/active-directory/devices/troubleshoot-device-dsregcmd) command in an elevated command prompt:
    `dsregcmd /status`

In the output that displays, check the information in the “Device State” column:

| AzureAdJoined | EnterpriseJoined | DomainJoined | Device state |
| ---------------- | ---------------- | ---------------- | ---------------- |
| YES | NO | NO | Azure AD Joined (AADJ) |
| NO | NO | YES | Domain Joined (DJ) |
| YES | NO | YES | Hybrid AD Joined (HAADJ) |

The state of Workplace Joined (WPJ) (Azure AD registered) devices is displayed in the **User state** section of the output. If it states **YES**, the device is Workplace joined.

For more information, see [What is device identity in Azure Active Directory (AD)?](/azure/active-directory/devices/overview)

## References

- [Account or subscription verification errors activating Microsoft 365 Apps](../../Client/activation/account-or-subscription-errors.md)
- [Sign in issues when activating Microsoft 365 Apps](../../Client/activation/sign-in-issues.md)
- [Microsoft 365 Apps activation network connection issues](../../Client/activation/network-connection-issues.md)
- [Microsoft 365 Apps activation error: “Your organization has disabled this device”](../../Client/activation/your-organization-disabled-this-device.md)
- [Microsoft 365 Apps activation error “There’s a problem with your account”](../../Client/activation/problem-with-your-account.md)
- ["We are unable to connect right now" error when users try to activate Microsoft 365 Apps for enterprise](../../Client/activation/issue-when-activate-office-365-proplus.md)
- [Troubleshoot issues with shared computer activation for Microsoft 365 Apps](../../Client/activation/shared-computer-activation.md)