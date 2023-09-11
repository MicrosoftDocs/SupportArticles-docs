---
title: Activation error That Microsoft account doesn’t exist
description: Troubleshooting the Microsoft 365 activation error That Microsoft account doesn’t exist. Enter a different account or get a new one.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 157598
  - CI 159117
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# Microsoft 365 Apps activation error: “That Microsoft account doesn’t exist. Enter a different account or get a new one.”

When you try to activate Microsoft 365 apps, you might encounter the following error:

> That Microsoft account doesn’t exist. Enter a different account or get a new one.

If you are trying to activate on a Mac, see [How to remove Office license files on a Mac](https://support.microsoft.com/office/how-to-remove-office-license-files-on-a-mac-b032c0f6-a431-4dad-83a9-6b727c03b193).

For Windows devices, try the following troubleshooting methods.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>

<details>
<summary><b>If you are prompted for a product key</b></summary>

If you are prompted for a product key, see [Where to enter your Office product key](https://support.microsoft.com/office/where-to-enter-your-office-product-key-0a82e5ae-739e-4b92-a6f4-2ec780c185db).
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
<summary><b>Make sure you have the correct Office installed</b></summary>

Go to https://portal.office.com/account to check which Office version and edition you have available.  

If no Office version is shown, you don’t have an Office license assigned to the account you are signed in with. If you are signed in with your Work or School account, and don’t have a license assigned, contact your Microsoft 365 Administrator to get a license assigned. [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)  

If you have Microsoft 365 for Business Basic, you won’t have any Office applications to install. You can use Office Online apps at https://office.com.   

Make sure that the version listed (32-bit or 64-bit) matches your version of Windows. To check what version of Windows you have installed, go to **Start** > **Settings** (gear icon) > **System** > **About**, and check the **System type**.  

If you have a different edition or version installed on your device, run the SaRA package to uninstall Office. Restart the device, and install from https://portal.office.com/account to get the correct version.  
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
