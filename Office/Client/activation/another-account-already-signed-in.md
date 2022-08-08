---
title: Sorry, another account from your organization is already signed in on this computer
description: Troubleshooting steps for Microsoft 365 Apps activation error Sorry, another account from your organization is already signed in on this computer
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 157596
  - CI 159181
  - CI 159479
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 3/31/2022
---

# Microsoft 365 Apps activation error: “Sorry, another account from your organization is already signed in on this computer”

When trying to activate Microsoft 365 apps, you might encounter the error:

> Sorry, another account from your organization is already signed in on this computer

If this occurs on a Mac, see [Can't sign in to an Office 2016 for Mac app](/microsoft-365/troubleshoot/sign-in/sign-in-to-office-2016-for-mac-fail).

For Windows devices, try the following troubleshooting methods to solve the problem.

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
<summary><b>Update Microsoft 365</b></summary>

It is recommended that Microsoft 365 be configured to install updates automatically. To check for updates, open an Office app (such as Word), select **File**, and then select **Account**.
Select **Update options**, and then select **Update now**.
<br/><br/>
</details>

<details>
<summary><b>Run the Microsoft Support and Recovery Assistant (SaRA) Sign in troubleshooter</b></summary>

Run [the SaRA Office sign in issue troubleshooter](https://aka.ms/SaRA-OfficeSignInScenario).
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

Run the [Microsoft Support and Recovery Assistant (SaRA) to reset the Microsoft 365 activation state](https://aka.ms/SaRA-OfficeActivation-Reset).

For manual steps or more information, see [Reset Microsoft 365 Apps for enterprise activation state](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>

<details>
<summary><b>Sign out of Office and sign back in</b></summary>

1.	Open an Office app, such as Word.
1.	Select your name and profile picture or icon at the top.
1.	Select **Sign out**.
1.	Select **Sign in**.
1.	Make sure you are signed in with your **Work or School** account, not your personal Microsoft account.
1.	Try activating Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Disconnect Work or School credentials</b></summary>

1.	From Start, select **Settings** (the gear icon) > **Accounts** > **Access work or school**.
1.	If the account you use to sign in to office.com is listed there, but it isn’t the account you use to sign in to Windows, select it, and then select **Disconnect**.
1.	Restart the device and try to activate Microsoft 365 again.
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
1.	Download and run [the SaRA package for sign in issues](https://aka.ms/SaRA-OfficeSignInScenario).

For manual troubleshooting for step 7, or for more information, see [Fix authentication issues in Office applications when you try to connect to a Microsoft 365 service](/microsoft-365/troubleshoot/authentication/automatic-authentication-fails).
<br/><br/>
</details>

<details>
<summary><b>Add a second email account to Outlook</b></summary>

For instructions to do so, see [Add an email account to Outlook](https://support.office.com/article/add-an-email-account-to-outlook-e9da47c4-9b89-4b49-b945-a204aeea6726).

When prompted, select **Allow my organization to manage my device**. When the process is completed, restart the device and try activating Microsoft 365 again. You can remove the second email account from Outlook afterward.
<br/><br/>
</details>

<details>
<summary><b>Enable the device in the Microsoft 365 admin center</b></summary>

A Microsoft 365 admin can try the following steps to solve the problem.

1.	Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com).
1.	Navigate to **Azure Active Directory Admin Center** > **Azure Active Directory** > **Devices**.
1.	Check the disabled device list for the device, select it, and choose **Enable**.
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
