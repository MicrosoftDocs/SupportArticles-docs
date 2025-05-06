---
title: Microsoft 365 Apps activation error Product deactivated
description: Troubleshooting for Microsoft 365 Apps activation error Product deactivated.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Product Deactivated
  - CSSTroubleshoot
  - CI 157753
  - CI 159131
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/11/2025
---

# Microsoft 365 Apps activation error: “Product deactivated"

When trying to activate Microsoft 365 Apps, you might encounter an error stating that your Microsoft 365 Apps installation was deactivated.

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>

<details>
<summary><b>Make sure you have the correct Office installed</b></summary>

Go to https://portal.office.com/account to check which Office version and edition you have available.  
  
If no Office version is shown, you don’t have an Office license assigned to the account you are signed in with. If you are signed in with your Work or School account, and don’t have a license assigned, contact your Microsoft 365 Administrator to get a license assigned. [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)  
  
If you have Microsoft 365 for Business Basic, you won’t have any Office applications to install. You can use Office Online apps at https://office.com.   
  
Make sure that the version listed (32-bit or 64-bit) matches your version of Windows. To check what version of Windows you have installed, go to **Start** > **Settings** (gear icon) > **System** > **About**, and check the **System type**.  
  
If you have a different edition or version installed on your device, run the [Microsoft 365 Uninstall troubleshooter](https://aka.ms/SaRA-OfficeUninstall-sarahome) to uninstall Microsoft 365 or Office. Restart the device, and install from https://portal.office.com/account to get the correct version.  
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
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>

<details>
<summary><b>Run the Microsoft 365 activation troubleshooter in Get Help</b></summary>

The [Microsoft 365 activation troubleshooter](https://aka.ms/SaRA-OfficeActivation-sarahome) helps you to resolve Microsoft 365 subscription activation issues.

> [!NOTE]
> To run the Microsoft 365 activation troubleshooter, make sure that you're using the same Windows device that Microsoft 365 is installed on. Additionally, make sure that your device is running Windows 10 or a later version.

To run the troubleshooter, follow these steps:

1. Select the following button to start the troubleshooter.

   > [!div class="nextstepaction"]
   > [Microsoft 365 activation troubleshooter](https://aka.ms/SaRA-OfficeActivation-sarahome)

   If you receive a pop-up window that displays "This site is trying to open Get Help.", select **Open**.
1. Follow the instructions in the Get Help app to run the troubleshooter.

After the troubleshooter finishes, it displays the results and provides additional information about how to resolve the issue.
<br/><br/>
</details>
