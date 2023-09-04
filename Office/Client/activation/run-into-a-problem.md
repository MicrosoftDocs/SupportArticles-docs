---
title: We’ve run into a problem with your Microsoft 365 subscription
description: Troubleshooting the Microsoft 365 Apps activation error We’ve run into a problem with your Microsoft 365 subscription.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 157758
  - CI 159110
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# Microsoft 365 Apps activation error: “We’ve run into a problem with your Office 365 subscription”

When activating Microsoft 365 apps, you might encounter the following error:

> We've run into a problem with your Office 365 subscription and we need your help to fix it.

Try the following troubleshooting methods to solve the problem.

**Notes:**
- If your Microsoft 365 license didn't come from your work, school, or other organization, see [Office error "Account Notice: We've run into a problem with your Microsoft 365 subscription"](https://support.microsoft.com/office/office-error-account-notice-we-ve-run-into-a-problem-with-your-microsoft-365-subscription-17f71ecb-f53c-4f3d-ae18-7230ca1594c1)
- Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>

<details>
<summary><b>Run as administrator</b></summary>

1.	Close all Microsoft 365 Apps.
1.	From Start, right-click on a Microsoft 365 App, and select **Run as administrator**.
1.	If you’re prompted, activate Microsoft 365 Apps.
1.	If you don’t see a message that Microsoft 365 Apps was activated, try the next troubleshooting method.
<br/><br/>
</details>

<details>
<summary><b>Run the SaRA activation troubleshooter</b></summary>

Run the [SaRA activation troubleshooter](https://aka.ms/SARA-OfficeActivation-Alchemy), and select the **Office** option. When prompted, select the option that best describes your situation.
<br/><br/>
</details>

<details>
<summary><b>Make sure you have the correct Office installed</b></summary>

Go to https://portal.office.com/account to check which Office version and edition you have available.
  
If no Office version is shown, you don’t have an Office license assigned to the account you are signed in with. If you are signed in with your Work or School account, and don’t have a license assigned, contact your Microsoft 365 Administrator to get a license assigned. [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
  
If you have Microsoft 365 for Business Basic, you won’t have any Office applications to install. You can use Office Online apps at https://office.com.
  
Make sure that the version listed (32-bit or 64-bit) matches your version of Windows. To check what version of Windows you have installed, go to **Start** > **Settings** (gear icon) > **System** > **About**, and check the **System type**.
  
If you have a different edition or version installed on your device, run the [SaRA package to uninstall Office](https://aka.ms/SaRA-officeUninstallFromPC). Restart the device, and install from https://portal.office.com/account to get the correct version.
<br/><br/>
</details>

<details>
<summary><b>Uninstall Office apps and then reinstall</b></summary>

[Run the SaRA package to uninstall Office](https://aka.ms/SaRA-OfficeUninstallFromPC). Restart the device, and install from https://portal.office.com/account to get the correct version.
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

Run the [Microsoft Support and Recovery Assistant (SaRA) to reset the Microsoft 365 activation state](https://aka.ms/SaRA-OfficeActivation-Reset).

For manual steps or more information, see [Reset Microsoft 365 Apps for enterprise activation state]( /office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>

<details>
<summary><b>Turn on Recurring billing and make sure your subscription is active</b></summary>

1.	In the [Microsoft 365 Admin Center](https://admin.microsoft.com), select **Billing** > **Your products**.
1.	Select the subscription. Check if the subscription is active. If it isn’t, select **Reactivate subscription**. If it isn’t, select **Reactivate subscription**.
1.	Under **Subscription and payment settings**, select **Edit recurring billing**.
1.	Select **On** or **On, but renew once**.

If your subscription is a retail license, see [Office error Account Notice: We've run into a problem with your Microsoft 365 subscription](https://support.microsoft.com/office/office-error-account-notice-we-ve-run-into-a-problem-with-your-microsoft-365-subscription-17f71ecb-f53c-4f3d-ae18-7230ca1594c1).
<br/><br/>
</details>

<details>
<summary><b>Reset your password</b></summary>

Go to https://portal.office.com/account and select **Security & privacy**. Reset your password, then try activating Microsoft 365 again.
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
