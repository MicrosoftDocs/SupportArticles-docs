---
title: Reset activation state for Microsoft 365 Apps for enterprise
description: Four locations must be cleared to reset the activation or install to a clean state after Microsoft 365 users are activated.
author: helenclu
ms.author: luche
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
ms.reviewer: mattphil
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 05/10/2022
---

# Reset activation state for Microsoft 365 Apps for enterprise

This article is written and maintained by [Eric Splichal](https://social.technet.microsoft.com/profile/Splic-MSFT), Senior Support Escalation Engineer, [Matt Philipenko](https://social.technet.microsoft.com/profile/MattPhil+-+MSFT), Microsoft 365 Apps Ranger, and Tim Johnson, Customer Engineer.

You might need to perform tasks such as the following for your organization:

- Tenant to tenant migration
- Repurpose a device for a different user
- Change the [license mode](/deployoffice/overview-licensing-activation-microsoft-365-apps) for Microsoft 365 on a device

To complete these tasks, you need to clear prior activations of Microsoft 365 apps for enterprise to remove their related licenses and cached Office account information. This removal will reset the applications to a clean state. You can then activate them with a different Office account or change to a different license mode. To reset the activation state, close all Office applications and use one of the following methods.

> [!NOTE]
> - The steps below apply to Microsoft Project and Microsoft Visio also.
> - The steps and scripts in this article apply to Windows installations of Office apps. For Office for Mac installations, see [How to remove Office license files on a Mac](https://support.microsoft.com/office/how-to-remove-office-license-files-on-a-mac-b032c0f6-a431-4dad-83a9-6b727c03b193).

## Method: Use Microsoft Support and Recovery Assistant

The Assistant fully automates all the steps required to reset Office activation, and is available in two versions. Use the version that's appropriate for your requirement.

- **The Enterprise (command-line) version of the Assistant**<br/>
  The [Enterprise version of the Assistant](https://aka.ms/SaRA_EnterpriseVersion) is a command-line version that can be scripted and is recommended to reset Office activation on multiple devices and on devices that you can't access immediately.
  > [!div class="nextstepaction"]
  > [Download Enterprise version](https://aka.ms/SaRA_EnterpriseVersionFiles)
- **UI version**<br/>
  The [UI version of the Assistant](https://aka.ms/SaRA_Home) is recommended if you need to reset Office activation on a single device, or on a small number of individual devices. 
  > [!div class="nextstepaction"]
  > [Download UI version](https://aka.ms/SaRA-OfficeActivation-Reset)

<h2 id="method2">Method: Use scripts to automate the cleanup process</h2>

Run the following scripts that automate each section of the process. We recommend that you run the **OLicenseCleanup.vbs** and **signoutofwamaccounts.ps1** scripts listed below, while **WPJCleanUp.cmd** is required only if your device is Workplace Joined. For details about the specific steps that each script automates, select the associated **Details** link. Use the "Select if using automated scripts" link to navigate back to this method.

1. To remove previous licenses and cached account information: download the [OLicenseCleanup.zip](https://download.microsoft.com/download/e/1/b/e1bbdc16-fad4-4aa2-a309-2ba3cae8d424/OLicenseCleanup.zip) file, extract the **OLicenseCleanup.vbs** script, and run it using elevated permissions. <a href="#sectiona">Details</a>
1. To clear the WAM accounts on the device that are associated with Office: download the [signoutofwamaccounts.zip](https://download.microsoft.com/download/f/8/7/f8745d3b-49ad-4eac-b49a-2fa60b929e7d/signoutofwamaccounts.zip) file, extract, and run the **signoutofwamaccounts.ps1** script with elevated permissions.
If you save signoutofwamaccounts.ps1 in the same location as OLicenseCleanup.vbs, then it will be executed automatically when you run OLicenseCleanup.vbs. <a href="#sectionb">Details</a>
1. To remove Workplace Joined accounts: download [WPJCleanUp.zip](https://download.microsoft.com/download/8/e/f/8ef13ae0-6aa8-48a2-8697-5b1711134730/WPJCleanUp.zip), extract the WPJCleanUp folder, and run **WPJCleanUp.cmd**. <a href="#sectionc">Details</a>

## Method: Clear prior activation information manually

If you prefer to perform the steps for the cleanup process manually, use the information in this method. The process consists of the following sections.

<div id="sectiona">
<br>
<details>
<summary><b>Section A: Remove Office licenses & cached accounts</a></b></summary>

This section is subdivided into three parts. Some of the parts require editing registry entries.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

<div id="step1">
<br>
<details>
<summary><b>Part 1: Remove previous Office activations</a></b></summary>

Check for and remove existing licenses on the device. Make sure to check all the noted locations for potential license types, which include vNext, Shared Computer Activation, and legacy licenses.

1. Remove all license token files and folders if found in the following locations:
    - For vNext license type:
        - `%localappdata%\Microsoft\Office\Licenses` (Microsoft 365 Apps for enterprise version 1909 or later)
    - For Shared Computer Activation license type:
        - `%localappdata%\Microsoft\Office\16.0\Licensing`

1. Check for and remove legacy licensing by using the ospp.vbs script.
    - **IMPORTANT** Make sure that:
        - If you want to run the script on a remote computer, the Windows firewall allows Windows Management Instrumentation (WMI) traffic on the remote computer.
        - The user account you use is a member of the Administrators group on the computer on which you run the script.

    - Before you run the ospp.vbs script, you must set the correct directory. Run one of the following commands from an elevated command prompt, as appropriate for your Office installation:  
        - For a 64-bit Office installation on a 64-bit operating system:
            - `cd "C:\Program Files\Microsoft Office\Office16"`
        - For a 32-bit Office installation on a 64-bit operating system:
            - `cd "C:\Program Files (x86)\Microsoft Office\Office16"`

1. Run the following command to get a list of the licenses currently in use:
    - `cscript ospp.vbs /dstatus`

        The output is in this format:
        :::image type="content" source="media/reset-office-365-proplus-activation-state/capture1.png" alt-text="Output inclues Product ID, SKU ID, License Name, License Description, License Status, Error Code, and Last 5 characters of installed product key":::

        **NOTE** The output could include licenses for multiple applications. If it displays **No installed product keys detected**, skip steps 4 and 5 and go to step 6, "Delete the following registry entry", below.  

        If a partial product key is returned for the applications whose licenses you want to remove, note the value displayed for **Last 5 characters of the installed product key** to use in step 4, below.  

1. Run the following command to remove the license for an application by using the associated partial product key:
    - `cscript ospp.vbs /unpkey:<last 5 characters of product key>`
        - For example:
                `cscript ospp.vbs /unpkey:2WC00`

    - You should see the message "Product key uninstall successful" when the license is removed.
        :::image type="content" source="media/reset-office-365-proplus-activation-state/capture3.png" alt-text="Output shows Uninstalling product key for Office 16, and the message Product key uninstall successful":::

1. Repeat the `cscript ospp.vbs /unpkey` command as needed to remove the licenses for the applications listed in the output from step 3.

1. Delete the following registry entry:
    - `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Licensing`

</details>

<div id="step2">
<br>
<details>
<summary><b>Part 2: Remove cached Office account identities in HKCU registry</b></summary>

Delete the following registry entry:

- `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Identity`

If you have Shared Computer Activation enabled, remove the Identity registry key location from the `HKEY_USERS\<The user SID>\Software\Microsoft\Office\16.0\Common`registry key. To get the currently signed in user's SID, run the command `whoami /user` in a non-elevated command prompt.

</details>

<br>
<details>
<summary><b>Part 3: Remove Office credentials stored in Windows Credential Manager</b></summary>

1. Open **Control Panel** > **Credential Manager**.
1. Select **Windows Credentials**.
1. Remove all credentials listed for Office by selecting the drop-down arrow next to each one, and select **Remove**.

    :::image type="content" source="media/reset-office-365-proplus-activation-state/credmanager.png" alt-text="Credential Manager example shows two entries for Office":::

1. Check for and delete any values present under the following registry key:
    `HKEY_CURRENT_USER\Software\Microsoft\Protected Storage System`

</details>

<a href="#method2">Select if using automated scripts</a>
</details>

<div id="sectionb">
<br>
<details>
<summary><b>Section B: Clear cached Office credentials for managed devices</b></summary>

For managed devices, there are additional locations from which you need to remove cached Office credentials. Devices are considered managed if they're Microsoft Entra joined (AADJ), Microsoft Entra hybrid joined (HAADJ), or Workplace Joined (WPJ). These configurations use Web Account Management (WAM), which stores credentials in different locations.

There are no steps that you can run manually to clear WAM accounts associated with Office on the device for AADJ and HAADJ devices.

Download the [signoutofwamaccounts.zip](https://download.microsoft.com/download/f/8/7/f8745d3b-49ad-4eac-b49a-2fa60b929e7d/signoutofwamaccounts.zip) file, extract, and run the **signoutofwamaccounts.ps1** script as administrator.

The **signoutofwamaccounts.ps1** script will remove the tokens and accounts associated with Office and is safe to run. On AADJ and HAADJ devices, it will not affect the Single Sign-On (SSO) state of the applications and the device state.

The script can only be run on Windows 10 version 1803 and later. If your operating system isn't compatible, you'll see the notification "Unsupported Windows 10 version!".

To check whether your device is managed, run the `dsregcmd /status` command in an elevated command prompt.

In the output that displays, check the values for the **AzureAdJoined**, **EnterpriseJoined** and **DomainJoined** parameters in the **Device State** section. Then use the following table to determine whether your device is AADJ or HAADJ:

| AzureAdJoined | EnterpriseJoined | DomainJoined | Device state |
| ---------------- | ---------------- | ---------------- | ---------------- |
| YES | NO | NO | Microsoft Entra joined (AADJ) |
| NO | NO | YES | Domain Joined (DJ) |
| YES | NO | YES | Hybrid AD Joined (HAADJ) |

For more information, see [Troubleshoot devices by using the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd).

<a href="#method2">Select if using automated scripts</a>
</details>

<div id="sectionc">
<br>
<details>
<summary><b>Section C: Clear Workplace-Joined accounts</b></summary>

When you clear a WPJ account on a device, the Single Sign-On (SSO) behavior for the current Windows session will be removed as well. All applications in the current Windows session will lose their SSO state, and the device will be unenrolled from management tools and unregistered from the cloud. The next time you try to open an application, you'll be asked to sign-in.

Check whether your device is Workplace Joined if you're not sure. Run the `dsregcmd /status` command from an elevated command prompt as described in <a href="#sectionb">Section B</a>, above.

The state of Workplace Joined (WPJ) (Microsoft Entra registered) devices is displayed in the **User State** section of the output. If the value displayed for the WorkplaceJoined parameter is **YES**, it indicates that your device is Workplace Joined.

To clear WPJ accounts:

1. On the device, select the Start button and then choose **Settings**.
1. Select **Accounts** > **Access Work or School**.
1. Select the work or school account to be removed, and then select **Disconnect**.

<a href="#method2">Select if using automated scripts</a>
</details>

## References

- [Account or subscription verification errors activating Microsoft 365 Apps](../../Client/activation/account-or-subscription-errors.md)
- [Sign in issues when activating Microsoft 365 Apps](../../Client/activation/sign-in-issues.md)
- [Microsoft 365 Apps activation network connection issues](../../Client/activation/network-connection-issues.md)
- [Microsoft 365 Apps activation error: "Your organization has disabled this device"](../../Client/activation/your-organization-disabled-this-device.md)
- [Microsoft 365 Apps activation error "There's a problem with your account"](../../Client/activation/problem-with-your-account.md)
- ["We are unable to connect right now" error when users try to activate Microsoft 365 Apps for enterprise](../../Client/activation/issue-when-activate-office-365-proplus.md)
- [Troubleshoot issues with shared computer activation for Microsoft 365 Apps](../../Client/activation/shared-computer-activation.md)
- [Device identity and desktop virtualization](/azure/active-directory/devices/howto-device-identity-virtual-desktop-infrastructure#microsofts-guidance)
- [What is device identity in Microsoft Entra ID?](/azure/active-directory/devices/overview)
- [OneDrive for Business can't sync after tenant migration](/sharepoint/troubleshoot/sync/cant-sync-after-migration)
