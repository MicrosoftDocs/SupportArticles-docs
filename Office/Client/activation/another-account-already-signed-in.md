---
title: Another account from your organization is already signed in on this computer
description: Troubleshooting steps for Microsoft 365 apps activation error Sorry, another account from your organization is already signed in on this computer.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 157596
  - CI 159181
  - CI 159479
  - CI 175165
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/25/2025
---

# Microsoft 365 apps activation error "Another account from your organization is already signed in on this computer"

When you try to activate Microsoft 365 apps, you receive the following error message even though no other account is in use:

> Sorry, another account from your organization is already signed in on this computer

**Note:** This error is expected if you're already signed in by using another Microsoft 365 account from the same tenant.

If this error occurs when only one account is used, follow the steps that are appropriate for your device:

- For Mac devices, follow these steps:

  1. Close all Microsoft 365 apps.
  1. Open Terminal, and then run the following command:
  
     ```bash
     defaults write com.microsoft.Word ResetOneAuthCreds -bool YES
     ```

  1. Open the Microsoft Word app and continue with the activation steps.
  1. If the issue persists, try the steps in [Can't sign in to an Office 2016 for Mac app](/microsoft-365/troubleshoot/sign-in/sign-in-to-office-2016-for-mac-fail).
- For Windows devices, follow these steps:

  1. Sign out of all Microsoft 365 apps, and then sign in again.
  1. If the issue still occurs, modify the OneAuth account store on the device:

     1. Navigate to the `%localappdata%\Microsoft\OneAuth\accounts` folder. You'll see one \<GUID\> file, or multiple files that have different GUIDs if there are multiple accounts.
     1. Open the files by using Notepad, examine the **account_hints** value, and identify the files that aren't associated with the account that you want to use to sign in.
     1. In each file that's identified in step b, locate the **association_status** entry, change the association status of `com.microsoft.Office` to **disassociated**, and then save the file.  For example, change  
     *"association_status": "{\\"**com.microsoft.Office**\\":\\"**associated**\\",\\"com.microsoft.Outlook\\":\\"associated\\"}"*  
     to  
     *"association_status": "{\\"**com.microsoft.Office**\\":\\"**disassociated**\\",\\"com.microsoft.Outlook\\":\\"associated\\"}"*.
     1. Try to sign in again.
  1. If the issue persists, sign out of all Microsoft 365 apps, remove all folders in the following locations, and then sign in again:

     - `%localappdata%/Microsoft/OneAuth`
     - `%localappdata%/Microsoft/IdentityCache`
  1. If the issue persists, try the [additional troubleshooting methods](#additional-troubleshooting-methods).

## Additional troubleshooting methods

**Note:** Some of these troubleshooting methods can be performed only by a Microsoft 365 admin. If you aren't an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b).

<details>
<summary><b>Update Windows</b></summary>

1. From Start, type check for updates, and select **Check for updates** from the search results.
1. Select **Check for updates**.
1. Download and install available updates.
1. Restart the device and try to activate Microsoft 365 again.

</details>

<details>
<summary><b>Update Microsoft 365</b></summary>

It's recommended that Microsoft 365 be configured to install updates automatically. To check for updates, open a Microsoft 365 app (such as Word), select **File**, and then select **Account**.
Select **Update options**, and then select **Update now**.

</details>

<details>
<summary><b>Run the Microsoft 365 sign-in troubleshooter in Get Help</b></summary>

The [Microsoft 365 sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome) helps you to resolve Microsoft 365 sign-in issues.

To run the troubleshooter, follow these steps:

1. Select the following button to start the troubleshooter.

   > [!div class="nextstepaction"]
   > [Microsoft 365 sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome)

   If you receive a pop-up window that displays "This site is trying to open Get Help", select **Open**.
1. Follow the instructions in the Get Help app to run the troubleshooter.

After the troubleshooter finishes, it displays the results and provides additional information about how to resolve the issue.
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
</details>

<details>
<summary><b>Disconnect Work or School credentials</b></summary>

1. From Start, select **Settings** (the gear icon) > **Accounts** > **Access work or school**.
1. If the account you use to sign in to office.com is listed there, but it isn't the account you use to sign in to Windows, select it, and then select **Disconnect**.
1. Restart the device and try to activate Microsoft 365 again.

</details>

<details>
<summary><b>Make sure user licenses are assigned</b></summary>

1. In the [Microsoft 365 Admin Center](https://admin.microsoft.com/), go to the **Users** > [Active users](https://go.microsoft.com/fwlink/p/?linkid=834822) page.
1. Select the row of the user that you want to assign a license to.
1. In the right pane, select **Licenses and Apps**.
1. Expand the **Licenses** section, select the boxes for the licenses that you want to assign, then select **Save changes**.
1. If the license is already assigned, uncheck it, select **Save changes**, then check it again and select **Save changes** again.

</details>

<details>
<summary><b>Check BrokerPlugin process</b></summary>

Some antivirus, proxy, or firewall software might block the following plug-in process:

`Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`

Temporarily disable your antivirus software. Contact your system administrator to find out if you are behind a proxy or firewall that is blocking this process. If so, you will also need to temporarily disable your proxy or firewall connection. If you connect through a Virtual Private Network (VPN), you might need to temporarily disable your VPN also.

If the process isn't blocked, but you still can't activate Microsoft 365, delete your BrokerPlugin data and then reinstall it using the following steps:

1. Open File Explorer, and put the following location in the address bar:
`%LOCALAPPDATA%\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\AC\TokenBroker\Accounts`
1. Press CTRL + A to select all.
1. Right-click in the selected files and choose **Delete**.
1. Put the following location in the File Explorer address bar:
`%LOCALAPPDATA%\Packages\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy\AC\TokenBroker\Accounts`
1. Select all files and delete them.
1. Restart the device.
1. Run the [Microsoft 365 sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome) in Get Help.

For manual troubleshooting for step 7, or for more information, see [Fix authentication issues in Office applications when you try to connect to a Microsoft 365 service](/microsoft-365/troubleshoot/authentication/automatic-authentication-fails).

</details>

<details>
<summary><b>Add a second email account to Outlook</b></summary>

For instructions to do so, see [Add an email account to Outlook](https://support.office.com/article/add-an-email-account-to-outlook-e9da47c4-9b89-4b49-b945-a204aeea6726).

When prompted, select **Allow my organization to manage my device**. When the process is completed, restart the device and try activating Microsoft 365 again. You can remove the second email account from Outlook afterward.

</details>

<details>
<summary><b>Enable the device in the Microsoft 365 admin center</b></summary>

A Microsoft 365 admin can try the following steps to solve the problem.

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com).
1. Navigate to **Microsoft Entra Admin Center** > **Microsoft Entra ID** > **Devices**.
1. Check the disabled device list for the device, select it, and choose **Enable**.

</details>

<details>
<summary><b>Create a new Windows user account</b></summary>

1. Perform a clean boot of Windows. For instructions, see [How to perform a clean boot in Windows](https://support.microsoft.com/topic/how-to-perform-a-clean-boot-in-windows-da2f9573-6eec-00ad-2f8a-a97a1807f3dd).
1. Create a new user account, and then make that account an administrator. For instructions, see [Create a local user or administrator account in Windows]( https://support.microsoft.com/windows/create-a-local-user-or-administrator-account-in-windows-20de74e0-ac7f-3502-a866-32915af2a34d#WindowsVersion=Windows_10).
1. Sign in to Windows with the new account.
1. Download and install Office.
1. Try to activate Microsoft 365 again.

</details>
