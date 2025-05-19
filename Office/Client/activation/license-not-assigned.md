---
title: You Currently Have Not Been Assigned an Office License that Includes the Office Desktop Apps
description: Troubleshoot Microsoft 365 Apps activation error You currently have not been assigned an office license that includes the Office desktop apps.
ms.reviewer: vikkarti
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\You currently have not been assigned an office license that includes the Office desktop apps
  - CSSTroubleshoot
  - CI 157759
  - CI 159113
  - CI 5841
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 05/19/2025
---

# Microsoft 365 Apps activation error: "You currently have not been assigned an office license that includes the Office desktop apps"

When you activate Microsoft 365 Apps, you receive the following error message:

> You currently have not been assigned an office license that includes the Office desktop apps.

To solve the problem, try the following troubleshooting methods.

> [!NOTE]
> Some of these troubleshooting methods can be performed only by a Microsoft 365 admin. If you aren't an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)

<details>
<summary><b>Make sure that you have the correct version of Office installed</b></summary>

1. [Check which Microsoft 365 business product or license](https://support.microsoft.com/office/what-microsoft-365-business-product-or-license-do-i-have-f8ab5e25-bf3f-4a47-b264-174b1ee925fd) you have.
  
   If you're signed in by using your Work or School account, and you don't have a license assigned, [contact your Microsoft 365 administrator](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b) to get a license assigned.
  
   If you have Microsoft 365 for Business Basic, you don't have any Office applications to install. You can use [Microsoft 365 Online apps](https://www.microsoft365.com/apps) instead.
  
1. Make sure that the [bit version of Office](https://support.microsoft.com/office/about-office-what-version-of-office-am-i-using-932788b8-a3ce-44bf-bb09-e334518b8b19) (32-bit or 64-bit) matches your [version of Windows](https://windows.microsoft.com/windows/32-bit-and-64-bit-windows).
  
If you have a different edition or version installed on your device, run the [Microsoft 365 Uninstall troubleshooter](https://aka.ms/SaRA-OfficeUninstall-sarahome) to uninstall Office. Then, restart the device, and [install the correct version](https://support.microsoft.com/office/download-install-or-reinstall-microsoft-365-or-office-2024-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658).

</details>

<details>
<summary><b>Sign out of Microsoft 365 and sign back in</b></summary>

1. Open a Microsoft 365 app, such as Word.
1. Select your name and profile picture or icon at the top.
1. Select **Sign out**.
1. Select **Sign in**.
1. Make sure that you're signed in with your **Work or School** account, not your personal Microsoft account.
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
<summary><b>Check sublicenses</b></summary>

1. In the [Microsoft 365 Admin Center](https://admin.microsoft.com/), go to the **Users** > **[Active users](https://go.microsoft.com/fwlink/p/?linkid=834822)** page.
1. Select the affected user.
1. In the right pane, select **Licenses and apps**.
1. Expand the **Licenses** section, make sure that necessary sublicenses are checked. For example, if **Microsoft 365 Apps for Enterprise** is checked, make sure the **Office 365** sublicense is checked.

</details>

<details>
<summary><b>Try InPrivate or Incognito mode</b></summary>

1. Open a browser in InPrivate mode (Microsoft Edge) or Incognito mode (Google Chrome).
1. [Install Microsoft 365 Apps](https://support.microsoft.com/office/download-install-or-reinstall-microsoft-365-or-office-2024-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658) and try to activate.

</details>

## References

- [Try or buy a Microsoft 365 for business subscription](/microsoft-365/commerce/try-or-buy-microsoft-365)
- [Assign licenses to users](/microsoft-365/admin/manage/assign-licenses-to-users)
- [Add users and assign licenses at the same time](/microsoft-365/admin/add-users/add-users)
