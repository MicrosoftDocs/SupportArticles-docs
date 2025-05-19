---
title: Microsoft 365 Apps Activation Error There's a Problem with Your Account
description: Troubleshooting the Microsoft 365 Apps activation error There's a problem with your account.
ms.reviewer: vikkarti
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\SignIn\Account Error
  - CSSTroubleshoot
  - CI 157757
  - CI 5839
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 05/19/2025
---

# Microsoft 365 Apps activation error: "There's a problem with your account"

When you try to activate Microsoft 365 Apps, you might receive the error message "We are unable to connect right now", followed by one of the following error codes:  

> There's a problem with your account, please try again later.  

> Account error There is a problem with your account. To fix this, sign in again to resolve the issue.

To solve the problem, try the following troubleshooting methods.

> [!NOTE]
> Some of these troubleshooting methods can be performed only by a Microsoft 365 admin. If you aren't an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)

## Troubleshooting activation on a Mac

<details>
<summary><b>Remove Office license files on a Mac</b></summary>

See [How to remove Office license files on a Mac](https://support.microsoft.com/office/how-to-remove-office-license-files-on-a-mac-b032c0f6-a431-4dad-83a9-6b727c03b193).  

</details>

## Troubleshooting activation on Windows

<details>
<summary><b>Make sure that you have the correct version of Office installed</b></summary>

1. [Check which Microsoft 365 business product or license](https://support.microsoft.com/office/what-microsoft-365-business-product-or-license-do-i-have-f8ab5e25-bf3f-4a47-b264-174b1ee925fd) you have.
  
   If you're signed in by using your Work or School account, and you don't have a license assigned, [contact your Microsoft 365 administrator](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b) to get a license assigned.
  
   If you have Microsoft 365 for Business Basic, you don't have any Office applications to install. You can use [Microsoft 365 Online apps](https://www.microsoft365.com/apps) instead.
  
1. Make sure that the [bit version of Office](https://support.microsoft.com/office/about-office-what-version-of-office-am-i-using-932788b8-a3ce-44bf-bb09-e334518b8b19) (32-bit or 64-bit) matches your [version of Windows](https://windows.microsoft.com/windows/32-bit-and-64-bit-windows).
  
If you have a different edition or version installed on your device, run the [Microsoft 365 Uninstall troubleshooter](https://aka.ms/SaRA-OfficeUninstall-sarahome) to uninstall Office. Then, restart the device, and [install the correct version](https://support.microsoft.com/office/download-install-or-reinstall-microsoft-365-or-office-2024-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658).

</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).

</details>

<details>
<summary><b>Run the Microsoft 365 activation troubleshooter in Get Help</b></summary>

The Microsoft 365 activation troubleshooter helps you resolve Microsoft 365 subscription activation issues.

> [!NOTE]
> To run the troubleshooter, make sure that you're using the same Windows device on which Microsoft 365 is installed. Additionally, make sure that your device is running Windows 10 or a later version.

Follow these steps:

1. To start the troubleshooter, select the following button.

   > [!div class="nextstepaction"]
   > [Microsoft 365 activation troubleshooter](https://aka.ms/SaRA-OfficeActivation-sarahome)

   If you receive a pop-up window that displays a "This site is trying to open Get Help" message, select **Open**.
1. To run the troubleshooter, follow the instructions in the Get Help app.

After the troubleshooter finishes, it displays the results and provides additional information about how to resolve the problem.

</details>

<details>
<summary><b>Sign out of Office and sign back in</b></summary>

1. Open a Microsoft 365 app, such as Word.
1. Select your name and profile picture or icon at the top.
1. Select **Sign out**.
1. Select **Sign in**.
1. Make sure that you're signed in by using your **Work or School** account, not your personal Microsoft account.
1. Try to activate Microsoft 365 again.

</details>

<details>
<summary><b>Make sure that user licenses are assigned</b></summary>

1. In the [Microsoft 365 Admin Center](https://admin.microsoft.com/), go to the **Users** > **[Active users](https://go.microsoft.com/fwlink/p/?linkid=834822)** page.
1. Select the user that you want to assign a license to.
1. In the right pane, select **Licenses and apps**.
1. Expand the **Licenses** section, select the checkboxes for the licenses that you want to assign, and then select **Save changes**.

   If a license is already assigned, clear the checkbox, select **Save changes**, reselect the checkbox for that license, and then select **Save changes** again.

</details>

<details>
<summary><b>Remove unused devices</b></summary>

Go to https://myaccount.microsoft.com/device-list and sign in with the same account that you use to activate Microsoft 365 Apps. Remove any unused devices.

With a single license, you can install Microsoft 365 Apps on up to 5 devices. For more information about licensing, see [Overview of licensing and activation in Microsoft 365 Apps](/deployoffice/overview-licensing-activation-microsoft-365-apps).

</details>
