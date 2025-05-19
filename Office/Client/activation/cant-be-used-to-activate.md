---
title: The Products We Found in Your Account Can't Be Used to Activate
description: Troubleshooting the Microsoft 365 activation error The products we found in your account can't be used to activate.
ms.reviewer: vikkarti
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\The products we found in your account can't be used to activate
  - CSSTroubleshoot
  - CI 157756
  - CI 159132
  - CI 5837
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 05/19/2025
---

# Microsoft 365 Apps activation error: "The products we found in your account can't be used to activate"

When you activate Microsoft 365 Apps, you might receive the following error message:

> The products we found in your account can't be used to activate.

To solve the problem, try the following troubleshooting methods.

> [!NOTE]
>
> - If your Microsoft 365 license doesn't come from your work, school, or other organization, see [Office error "Account Notice: We've run into a problem with your Microsoft 365 subscription"](https://support.microsoft.com/office/office-error-account-notice-we-ve-run-into-a-problem-with-your-microsoft-365-subscription-17f71ecb-f53c-4f3d-ae18-7230ca1594c1).
> - Some of these troubleshooting methods can be performed only by a Microsoft 365 admin. If you aren't an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)

<details>
<summary><b>Update Microsoft 365</b></summary>

It's recommended that you configure Microsoft 365 to install updates automatically. To check for updates, open a Microsoft 365 app (such as Word), select **File** > **Account**. Select **Update options** > **Update now**.

</details>

<details>
<summary><b>Run the Microsoft 365 sign-in troubleshooter in Get Help</b></summary>

The [Microsoft 365 sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome) helps you resolve Microsoft 365 sign-in issues.

To run the troubleshooter, follow these steps:

1. To start the troubleshooter, select the following button.

   > [!div class="nextstepaction"]
   > [Microsoft 365 sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome)

   If you receive a pop-up window that displays "This site is trying to open Get Help", select **Open**.
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
<summary><b>Make sure that you have the correct version of Office installed</b></summary>

1. [Check which Microsoft 365 business product or license](https://support.microsoft.com/office/what-microsoft-365-business-product-or-license-do-i-have-f8ab5e25-bf3f-4a47-b264-174b1ee925fd) you have.
  
   If you're signed in by using your Work or School account, and you don't have a license assigned, [contact your Microsoft 365 administrator](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b) to get a license assigned.
  
   If you have Microsoft 365 for Business Basic, you don't have any Office applications to install. You can use [Microsoft 365 Online apps](https://www.microsoft365.com/apps) instead.
  
1. Make sure that the [bit version of Office](https://support.microsoft.com/office/about-office-what-version-of-office-am-i-using-932788b8-a3ce-44bf-bb09-e334518b8b19) (32-bit or 64-bit) matches your [version of Windows](https://windows.microsoft.com/windows/32-bit-and-64-bit-windows).
  
If you have a different edition or version installed on your device, run the [Microsoft 365 Uninstall troubleshooter](https://aka.ms/SaRA-OfficeUninstall-sarahome) to uninstall Office. Then, restart the device, and [install the correct version](https://support.microsoft.com/office/download-install-or-reinstall-microsoft-365-or-office-2024-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658).

</details>

<details>
<summary><b>Uninstall and reinstall Microsoft 365 apps</b></summary>

1. Run the Microsoft 365 Uninstall troubleshooter to uninstall Microsoft 365 or Office.

   > [!NOTE]
   > To run the troubleshooter, make sure that you're using the same Windows device on which Microsoft 365 or the Office product is installed. Additionally, make sure that your device is running Windows 10 or a later version.

   1. To start the troubleshooter, select the following button.

      > [!div class="nextstepaction"]
      > [Microsoft 365 Uninstall troubleshooter](https://aka.ms/SaRA-OfficeUninstall-sarahome)

      If you receive a pop-up window that displays "This site is trying to open Get Help," select **Open**.
   1. To run the troubleshooter, follow the instructions in the Get Help app.
1. Restart the device.
1. [Install the correct version](https://support.microsoft.com/office/download-install-or-reinstall-microsoft-365-or-office-2024-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658).

</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).

</details>

<details>
<summary><b>Check Shared Computer Activation</b></summary>

If you're using Shared Computer Activation (SCA), see [Microsoft 365 Apps Shared Computer Activation issues](./shared-computer-activation.md).

</details>
