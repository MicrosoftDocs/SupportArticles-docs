---
title: Microsoft 365 Apps activation error There’s a problem with your account
description: Troubleshooting the Microsoft 365 Apps activation error There’s a problem with your account.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 157757
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# Microsoft 365 Apps activation error “There’s a problem with your account”

When you try to activate Microsoft 365 Apps, you might encounter the error "We are unable to connect right now", followed by one of the following error codes:  

> There's a problem with your account, please try again later.  

> Account error There is a problem with your account. To fix this, sign in again to resolve the issue.

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>
Troubleshooting activation on a Mac:
<br/><br/>
<details>
<summary><b>Remove Office license files on a Mac</b></summary>

See [How to remove Office license files on a Mac](https://support.microsoft.com/office/how-to-remove-office-license-files-on-a-mac-b032c0f6-a431-4dad-83a9-6b727c03b193).  
<br/><br/>
</details>

Troubleshooting activation on Windows:
<br/><br/>
<details>
<summary><b>Make sure you have the correct Office installed</b></summary>

Go to https://portal.office.com/account to check which Office version and edition you have available.

If no Office version is shown, you don’t have an Office license assigned to the account you are signed in with. If you are signed in with your Work or School account, and don’t have a license assigned, contact your Microsoft 365 Administrator to get a license assigned. [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b) 

If you have Microsoft 365 for Business Basic, you won’t have any Office applications to install. You can use Office Online apps at https://office.com.

Make sure that the version listed (32-bit or 64-bit) matches your version of Windows. To check what version of Windows you have installed, go to **Start** > **Settings** (gear icon) > **System** > **About**, and check the **System type**.

If you have a different edition or version installed on your device, run the SaRA package to uninstall Office. Restart the device, and install from https://portal.office.com/account to get the correct version.
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

Download and run the Microsoft Support and Recovery Assistant to reset the Microsoft 365 activation state.

> [!div class="nextstepaction"]
> [Download the Assistant](https://aka.ms/SaRA-OfficeActivation-Reset)

For manual steps or more information, see [Reset Microsoft 365 Apps for enterprise activation state]( /office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>

<details>
<summary><b>Run the SaRA activation troubleshooter</b></summary>

Run the [SaRA activation troubleshooter](https://aka.ms/SARA-OfficeActivation-Alchemy), and select the **Office** option. When prompted, select the option that best describes your situation.
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
<summary><b>Make sure user licenses are assigned</b></summary>

1.	In the [Microsoft 365 Admin Center](https://admin.microsoft.com/), go to the **Users** > [Active users](https://go.microsoft.com/fwlink/p/?linkid=834822) page.
1.	Select the row of the user that you want to assign a license to.
1.	In the right pane, select **Licenses and Apps**.
1.	Expand the **Licenses** section, select the boxes for the licenses that you want to assign, then select **Save changes**.
1.	If the license is already assigned, uncheck it, select **Save changes**, then check it again and select **Save changes** again.
<br/><br/>
</details>

<details>
<summary><b>Remove unused devices</b></summary>

Go to https://myaccount.microsoft.com/device-list and sign in with the same account you’re using to activate Microsoft 365 Apps. Remove any unused devices.

With a single license, you can install Microsoft 365 Apps on up to 5 devices. For more information about licensing, see [Overview of licensing and activation in Microsoft 365 Apps](/deployoffice/overview-licensing-activation-microsoft-365-apps).
<br/><br/>
</details>
