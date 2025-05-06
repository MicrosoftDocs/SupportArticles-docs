---
title: You currently have not been assigned an office license that includes the Office desktop apps
description: Troubleshoot Microsoft 365 Apps activation error You currently have not been assigned an office license that includes the Office desktop apps.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\You currently have not been assigned an office license that includes the Office desktop apps
  - CSSTroubleshoot
  - CI 157759
  - CI 159113
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 06/06/2024
---

# Microsoft 365 Apps activation error: "You currently have not been assigned an office license that includes the Office desktop apps"

When you try to activate Microsoft 365 apps, you encounter the error message:  

> You currently have not been assigned an office license that includes the Office desktop apps.

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren't an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>

<details>
<summary><b>Check your Microsoft 365 license</b></summary>

1.    Go to the Microsoft 365 portal: https://portal.office.com/account/?ref=MeControl#installs
1.    If you see the message "You currently have not been assigned an Office license that includes the Office desktop apps" this means that you aren't eligible to install Microsoft 365 Apps.
1.    If you see "Office" listed with an "Install Office" button, you're eligible for Microsoft 365 Apps.
<br/><br/>
</details>

<details>
<summary><b>Make sure you have the correct Office installed</b></summary>

Go to https://portal.office.com/account to check which Office version and edition you have available.
  
If no Office version is shown, you don't have an Office license assigned to the account you're signed in with. If you're signed in with your Work or School account, and don't have a license assigned, contact your Microsoft 365 Administrator to get a license assigned. [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b) 
  
If you have Microsoft 365 for Business Basic, you won't have any Office applications to install. You can use Office Online apps at https://office.com.
  
Make sure that the version listed (32-bit or 64-bit) matches your version of Windows. To check what version of Windows you have installed, go to **Start** > **Settings** (gear icon) > **System** > **About**, and check the **System type**.
  
If you have a different edition or version installed on your device, run the [Microsoft 365 Uninstall troubleshooter](https://aka.ms/SaRA-OfficeUninstall-sarahome) to uninstall Microsoft 365 or Office. Restart the device, and install from https://portal.office.com/account to get the correct version.
<br/><br/>
</details>

<details>
<summary><b>Sign out of Office and sign back in</b></summary>

1.    Open an Office app, such as Word.
1.    Select your name and profile picture or icon at the top.
1.    Select **Sign out**.
1.    Select **Sign in**.
1.    Make sure you're signed in with your **Work or School** account, not your personal Microsoft account.
1.    Try activating Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Make sure user licenses are assigned</b></summary>

1.    In the [Microsoft 365 Admin Center](https://admin.microsoft.com/), go to the **Users** > [Active users](https://go.microsoft.com/fwlink/p/?linkid=834822) page.
1.    Select the row of the user that you want to assign a license to.
1.    In the right pane, select **Licenses and Apps**.
1.    Expand the **Licenses** section, select the boxes for the licenses that you want to assign, then select **Save changes**.
1.    If the license is already assigned, uncheck it, select **Save changes**, then check it again and select **Save changes** again.
<br/><br/>
</details>

<details>
<summary><b>Check sublicenses</b></summary>

1.    A Microsoft 365 admin needs to go to https://admin.microsoft.com/Adminportal/Home?source=applauncher#/users
1.    Make sure necessary sublicenses are checked. For example, if **Microsoft 365 Apps for Enterprise** is checked, make sure the **Office 365** sublicense is checked.
<br/><br/>
</details>

<details>
<summary><b>Try InPrivate or Incognito mode</b></summary>

1.    Open a browser in InPrivate mode (Microsoft Edge) or Incognito mode (Google Chrome) and go to https://office.com.
1.    Install Microsoft 365 Apps and try to activate.
<br/><br/>
</details>

### References

- [Try or buy a Microsoft 365 for business subscription](/microsoft-365/commerce/try-or-buy-microsoft-365)
- [Assign licenses to users](/microsoft-365/admin/manage/assign-licenses-to-users)
- [Add users and assign licenses at the same time](/microsoft-365/admin/add-users/add-users)
