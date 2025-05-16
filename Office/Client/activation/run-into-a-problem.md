---
title: We've Run Into a Problem With Your Microsoft 365 Subscription
description: Troubleshooting the Microsoft 365 Apps activation error We've run into a problem with your Office 365 subscription.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment, Activation
  - Activation\Errors\We've run into a problem with your Microsoft 365 subscription
  - CSSTroubleshoot
  - CI 157758
  - CI 159110
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/27/2025
---

# Microsoft 365 Apps activation error: "We've run into a problem with your Office 365 subscription"

When you activate Microsoft 365 Apps, you might receive the following error message:

> We've run into a problem with your Office 365 subscription and we need your help to fix it.

To solve the problem, try the following troubleshooting methods.

> [!NOTE]
>
> - If your Microsoft 365 license doesn't come from your work, school, or other organization, see [Office error "Account Notice: We've run into a problem with your Microsoft 365 subscription"](https://support.microsoft.com/office/office-error-account-notice-we-ve-run-into-a-problem-with-your-microsoft-365-subscription-17f71ecb-f53c-4f3d-ae18-7230ca1594c1).
> - Some of these troubleshooting methods can be performed only by a Microsoft 365 admin. If you aren't an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)

<details>
<summary><b>Run as administrator</b></summary>

1. Close all Microsoft 365 apps.
1. On the **Start** menu, right-click a Microsoft 365 app, and then select **Run as administrator**.
1. [Activate Microsoft 365 Apps](https://support.microsoft.com/office/activate-office-5bd38f38-db92-448b-a982-ad170b1e187e) if you're prompted to do this.

If you don't see a message that states that Microsoft 365 Apps was activated, try the next troubleshooting method.
<br/><br/>
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
<br/><br/>
</details>

<details>
<summary><b>Make sure that you have the correct version of Office installed</b></summary>

1. [Check which Microsoft 365 business product or license](https://support.microsoft.com/office/what-microsoft-365-business-product-or-license-do-i-have-f8ab5e25-bf3f-4a47-b264-174b1ee925fd) you have.
  
   If you're signed in by using your Work or School account, and you don't have a license assigned, [contact your Microsoft 365 administrator](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b) to get a license assigned.
  
   If you have Microsoft 365 for Business Basic, you don't have any Office applications to install. You can use [Microsoft 365 Online apps](https://www.microsoft365.com/apps) instead.
  
1. Make sure that the [bit version of Office](https://support.microsoft.com/office/about-office-what-version-of-office-am-i-using-932788b8-a3ce-44bf-bb09-e334518b8b19) (32-bit or 64-bit) matches your [version of Windows](https://windows.microsoft.com/windows/32-bit-and-64-bit-windows).
  
   If you have a different edition or version installed on your device, run the [Microsoft 365 Uninstall troubleshooter](https://aka.ms/SaRA-OfficeUninstall-sarahome) to uninstall Office. Then, restart the device, and [install the correct version](https://support.microsoft.com/office/download-install-or-reinstall-microsoft-365-or-office-2024-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658).
<br/><br/>
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
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>

<details>
<summary><b>Turn on Recurring billing and make sure that your subscription is active</b></summary>

1. In the [Microsoft 365 Admin Center](https://admin.microsoft.com), select **Billing** > **Your products**.
1. Select the subscription.
2. Check whether the subscription is active. If it isn't, select **Reactivate subscription**.
1. Under **Subscription and payment settings**, select **Edit recurring billing**.
1. Select **On** or **On, but renew once**.

If your subscription is a retail license, see [Office error Account Notice: We've run into a problem with your Microsoft 365 subscription](https://support.microsoft.com/office/office-error-account-notice-we-ve-run-into-a-problem-with-your-microsoft-365-subscription-17f71ecb-f53c-4f3d-ae18-7230ca1594c1).
<br/><br/>
</details>

<details>
<summary><b>Change your password</b></summary>

[Change your password](https://support.microsoft.com/account-billing/change-your-work-or-school-account-password-97fced88-e0e7-4d7b-a9d3-936a3dcbd569), then try again to activate Microsoft 365.
<br/><br/>
</details>

<details>
<summary><b>Make sure that user licenses are assigned</b></summary>

1. In the [Microsoft 365 Admin Center](https://admin.microsoft.com/), go to the **Users** > **[Active users](https://go.microsoft.com/fwlink/p/?linkid=834822)** page.
1. Select the user that you want to assign a license to.
1. In the right pane, select **Licenses and apps**.
1. Expand the **Licenses** section, select the checkboxes for the licenses that you want to assign, and then select **Save changes**.

   If a license is already assigned, clear the checkbox, select **Save changes**, reselect the checkbox for that license, and then select **Save changes** again.
</details>
