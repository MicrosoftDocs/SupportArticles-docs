---
title: Reset Microsoft 365 Apps for enterprise activation state
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

# Reset Microsoft 365 Apps for enterprise activation state

In some circumstances, previous activations for Microsoft 365 apps for enterprise must be cleared to remove previous licenses and cached Office account information to reset the application to a clean un-activated state. After that is done, you can then activate with a different Office account or move to a different license mode. Common changes that require this are if users switch devices, an enterprise adds or changes Microsoft 365 tenants, or you are switching an Office desktop client [license mode](/deployoffice/overview-licensing-activation-microsoft-365-apps) on a device, such as moving to use Shared Computer Activation for a shared device.

>[!NOTE]
>To automatically perform all of the checks listed below and run the appropriate scripts needed to reset the activation state, you can download and run the [Microsoft Support and Recovery Assistant](https://aka.ms/SaRA-OfficeActivation-Reset).

In addition to the manual steps, there are also three scripts provided in this article to automate these steps. To get the best results we recommend that you run all three scripts included in this article. If you aren't able to run the scripts, perform the manual steps for each section.

> [!NOTE]
> - The steps below apply to Microsoft Project and Microsoft Visio as well.
> - The steps and scripts in this article apply to Windows installations of Office apps. For Office for Mac installations, see [How to remove Office license files on a Mac](https://support.microsoft.com/office/how-to-remove-office-license-files-on-a-mac-b032c0f6-a431-4dad-83a9-6b727c03b193).
> - Close all Office applications prior to taking any of the following actions.
> - We also recommend restarting the device after completing these steps or running the related scripts.

<h2 id="removeexisting">Remove existing Office activations and cached Office account information</h2>

To reset Office desktop client activations, make sure that previous activations, their related licenses, and cached Office account information are removed from the device. For example, with subscription versions of Office apps, activation is based on an Office user account that has been assigned a license for the desktop client. You must be able to successfully sign in with that licensed Office account.

To automate the steps in this section, download the [OLicenseCleanup.zip](https://download.microsoft.com/download/e/1/b/e1bbdc16-fad4-4aa2-a309-2ba3cae8d424/OLicenseCleanup.zip) file, extract the OLicenseCleanup.vbs file, and run OLicenseCleanup.vbs with elevated permissions.

If you're unable to run the script, manually remove existing Office activations and cached Office account information use the following four steps in this section.
<br>
<br>
<details>
<summary><b>Step 1: Remove previous Office activations</b></summary>

Check for and remove existing licenses on the device. Make sure to check all the noted locations for potential license types, which include vNext, Shared Computer Activation, and Legacy licenses.

1. Remove all license token files and folders if found in the following locations:
      - For vNext license type:
      `%localappdata%\Microsoft\Office\Licenses`
      - For Shared Computer Activation license type:
      `%localappdata%\Microsoft\Office\16.0\Licensing`

1. Use the ospp.vbs script to check for and remove possible Legacy licensing.

   > [!IMPORTANT]
   > Before you run the ospp.vbs script, make sure that:
   > - If you want to run the script on a remote computer, the Windows firewall allows Windows Management Instrumentation (WMI) traffic on the remote computer.
   > - The user account you use is a member of the Administrators group on the computer on which you run the script.
   > - You run the ospp.vbs script from an elevated command prompt.

1. In an elevated command prompt, set the correct directory by using one of these commands based on your Office installation type:
   - For a 64-bit Office installation on a 64-bit operating system:
      `cd "C:\Program Files\Microsoft Office\Office16"`
   - For a 32-bit Office installation on a 64-bit operating system.
      `cd "C:\Program Files (x86)\Microsoft Office\Office16"`

1. Run the following command to get the licenses currently in use:
    `cscript ospp.vbs /dstatus`

    The ospp.vbs command displays license information for installed product keys. The output is in this format:
    :::image type="content" source="media/reset-office-365-proplus-activation-state/capture1.png" alt-text="Output inclues Product ID, SKU ID, License Name, License Description, License Status, Error Code, and Last 5 characters of installed product key":::

   >[!Note]
   > The results of the command could include multiple licenses. If the output contains a "No installed product keys detected" message after you run `ospp.vbs /dstatus`, skip the `/unpkey` step below and go to <u><a href="#step2">Step 2: Remove cached Office account identities in HKCU registry</a></u>.

    If a partial product key is returned for the applications licenses you want to remove, take note of the **Last 5 characters of the installed product key** because you'll use it in the next step.

1. Run the following command to remove the license for the applicable application:
    `cscript ospp.vbs /unpkey:<last 5 characters of product key>`
    For example:
    `cscript ospp.vbs /unpkey:2WC00`
    
    You should see the message “Product key uninstall successful” when the license is removed.
    :::image type="content" source="media/reset-office-365-proplus-activation-state/capture3.png" alt-text="Output shows Uninstalling product key for Office 16, and the message Product key uninstall successful":::

1. Repeat the `cscript ospp.vbs /dstatus` and `/unpkey` commands as needed to remove all keys for the applications for which you need to remove previous activations. When you have removed all the necessary product keys, close the Command Prompt window and continue to Step 2, below.

</details>

<div id="step2">
<br>
<details>
<summary><b>Step 2: Remove cached Office account identities in HKCU registry</b></summary>

> [!WARNING]
> Follow this section's steps carefully. Incorrect registry entries can cause serious system issues. As a precaution, [back up the registry for restoration](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows).

1. In Registry Editor, locate the following registry entry:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common`

1. Delete the **Identity** registry value found under **Common**.

> [!NOTE]
> If you have Shared Computer Activation enabled, remove the Identity registry key location from registry `HKEY_USERS\<The user's SID>\Software\Microsoft\Office\16.0\Common`. One way to get the currently signed in user’s SID is use the command `whoami /user` in a non-elevated command prompt.

</details>

<br>
<details>
<summary><b>Step 3: Remove stored Office credentials in Windows Credential Manager</b></summary>

1. Open **Control Panel** > **Credential Manager**.
1. Select **Windows Credentials**.
1. Remove all credentials listed for Office by selecting the drop-down arrow next to each one, and select **Remove**.

    :::image type="content" source="media/reset-office-365-proplus-activation-state/credmanager.png" alt-text="Credential Manager example shows two entries for Office":::

</details>

<br>
<details>
<summary><b>Step 4: Verify the following locations are cleared</b></summary>

> [!WARNING]
> Follow this section's steps carefully. Incorrect registry entries can cause serious system issues. As a precaution, [back up the registry for restoration](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows).

If files or values are found underneath the following locations, remove those items:

**Credential Manager**

- `%appdata%\Microsoft\Credentials`
- `%localappdata%\Microsoft\Credentials`
- `%appdata%\Microsoft\Protect`
- `HKEY_CURRENT_USER\Software\Microsoft\Protected Storage System Provider`

**Office  365 activation tokens and identities**

- `%localappdata%\Microsoft\Office\16.0\Licensing`
- `%localappdata%\Microsoft\Office\Licenses (Microsoft 365 Apps for enterprise version 1909 or later)`
- `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Identity`
- `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Licensing`
- `HKEY_USERS\<The user's SID>\Software\Microsoft\Office\16.0\Common\Identity`

> [!NOTE]
> If you have roaming data, for example non-persistent VDIs, do not roam the Identity registry locations noted above. For Microsoft’s guidance around device identity and non-persistent VDIs, see [Device identity and desktop virtualization](/azure/active-directory/devices/howto-device-identity-virtual-desktop-infrastructure#microsofts-guidance).

</details>

## Clear cached Office credentials for managed devices

For managed devices, there are additional locations to remove cached Office credentials. Devices are considered managed if they are Azure AD Joined (AADJ), Hybrid Azure AD Joined (HAADJ), or Workplace Joined (WPJ). These configurations use Web Account Management (WAM), which stores credentials in different locations.

If you wish to learn a device’s managed state, see the section <a href="#checkmanaged">Check a device managed state</a>.

To clear WAM accounts associated with Office on the device for AADJ and HAADJ, download the [signoutofwamaccounts.zip](https://download.microsoft.com/download/f/8/7/f8745d3b-49ad-4eac-b49a-2fa60b929e7d/signoutofwamaccounts.zip) file, extract, and run the **signoutofwamaccounts.ps1** script as administrator. To clear Workplace Joined accounts, see the following section <a href="#clearwpj">Clear Workplace Joined accounts</a>.

> [!NOTE]
> - This script will remove tokens and accounts associated with Office; this is a safe operation. Single sign-on (SSO) of other applications will remain untouched, as well as the device state.
> - It is recommended that you run Signoutofwamaccounts.ps1 in addition to the OLicenseCleanup.vbs script mentioned in <a href="#removeexisting"><u>Remove existing Office activations and cached Office account information</u></a>. Signoutofwamaccounts.ps1 can be run separately or in conjunction with OLicenseCleanup.vbs. If you place signoutofwamaccounts.ps1 in the same location as OLicenseCleanup.vbs, running OLicenseCleanup.vbs will also execute Signoutofwamaccounts.ps1.
> - This script is only compatible with Windows 10 version 1803 and later. If the operating system isn't compatible, you'll receive a message saying the tool is not supported on that version of Windows.

<h2 id="clearwpj">Clear Workplace-Joined accounts</h2>

To clear existing Workplace Joined (WPJ) accounts use the automated WPJCleanUp tool or the manual steps below. Removing WPJ accounts will remove Single Sign-On (SSO) behavior in the current Windows logon session. After this operation, all applications in the current logon session will lose SSO state, and the device will be unenrolled from management tools (MDM) and unregistered from the cloud. The next time an application tries to sign in, users will be asked to add the account again.

To automate Workplace Joined accounts removal, download [WPJCleanUp.zip](https://download.microsoft.com/download/8/e/f/8ef13ae0-6aa8-48a2-8697-5b1711134730/WPJCleanUp.zip), extract the **WPJCleanUp** folder, and run **WPJCleanUp.cmd**.

If you can't run the script, manually clear Workplace Joined accounts by going to Windows Settings on the device, selecting **Access Work or School**, selecting the Work or school account to be removed, and then selecting **Disconnect**.

### Prevent Workplace Join on your device if needed

After Office successfully authenticates and activates, the **Stay signed in to all your apps** dialog pops up. By default, the **Allow my organization to manage the devices** checkbox is selected. This registers your device in Azure AD while adding your account to Workplace Join.

If you find there's a need to keep the device from being Azure AD registered, clear **Allow my organization to manage my device**, and then select **No, sign in to this app only**.

:::image type="content" source="media/reset-office-365-proplus-activation-state/prevent-azure-join.png" alt-text="Clear the Allow my organization to manage my device option to prevent Azure AD registration." border="false":::

If there is a need to block the Workplace Join in the future, such as if Office is installed on a non-persistent VDI, add the following registry value to `HKLM\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin`:

`"BlockAADWorkplaceJoin"=dword:00000001`

For more information, see the following articles:

- [Plan your hybrid Azure Active Directory join implementation](/azure/active-directory/devices/hybrid-azuread-join-plan)
- [Device identity and desktop virtualization](/azure/active-directory/devices/howto-device-identity-virtual-desktop-infrastructure#non-persistent-vdi)

<h2 id="checkmanaged">Check a device managed state</h2>

Though not necessary as part of the process to reset Office activation, you can check if a device is Azure AD Joined (AADJ), Hybrid Azure AD Joined (HAADJ), or Workplace Joined (WPJ) by running the following command in an elevated command prompt:
    `dsregcmd /status`

For additional information on dsregcmd see [Troubleshoot devices by using the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd).

Look for the following under the “Device State” section in the `dsregcmd /status` output:

| AzureAdJoined | EnterpriseJoined | DomainJoined | Device state |
| ---------------- | ---------------- | ---------------- | ---------------- |
| YES | NO | NO | Azure AD Joined (AADJ) |
| NO | NO | YES | Domain Joined (DJ) |
| YES | NO | YES | Hybrid AD Joined (HAADJ) |

For more information, see [What is device identity in Azure Active Directory (AD)?](/azure/active-directory/devices/overview)

Workplace Joined (WPJ) (Azure AD registered) state is displayed in the **User state** section of the status output. If it states **YES**, the device is Workplace Joined.

## References

- [Account or subscription verification errors activating Microsoft 365 Apps](../../Client/activation/account-or-subscription-errors.md)
- [Sign in issues when activating Microsoft 365 Apps](../../Client/activation/sign-in-issues.md)
- [Microsoft 365 Apps activation network connection issues](../../Client/activation/network-connection-issues.md)
- [Microsoft 365 Apps activation error: “Your organization has disabled this device”](../../Client/activation/your-organization-disabled-this-device.md)
- [Microsoft 365 Apps activation error “There’s a problem with your account”](../../Client/activation/problem-with-your-account.md)
- ["We are unable to connect right now" error when users try to activate Microsoft 365 Apps for enterprise](../../Client/activation/issue-when-activate-office-365-proplus.md)
- [Troubleshoot issues with shared computer activation for Microsoft 365 Apps](../../Client/activation/shared-computer-activation.md)