---
title: Microsoft 365 Apps activation Unlicensed product error
description: Troubleshooting unlicensed product errors when activating Microsoft 365 Apps.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Unlicensed Product
  - CSSTroubleshoot
  - CI 157602
  - CI 159069
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/11/2025
---

# Microsoft 365 Apps activation Unlicensed product error

When you try to activate Microsoft 365 Apps, you might encounter an error that says you have an unlicensed product.

Try the following troubleshooting methods to solve the problem.

**Notes:**
- If your Microsoft 365 license didn't come from your work, school, or other organization, see [Unlicensed Product and activation errors in Office](https://support.microsoft.com/office/unlicensed-product-and-activation-errors-in-office-0d23d3c0-c19c-4b2f-9845-5344fedc4380)
- Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)

<br/>
<details>
<summary><b>Remove Office credentials</b></summary>

1.	From Start, type credential manager, and then select **Credential Manager** from the search results.
1.	Select **Windows credentials**.
1.	If there are any credentials for **MicrosoftOffice16**, select the arrow next to them and then select **Remove**.
1.	Close Credential Manager.
1.	From Start, select **Settings** (the gear icon) > **Accounts** > **Access work or school**.
1.	If the account you use to sign in to office.com is listed there, but it isn’t the account you use to sign in to Windows, select it, and then select **Disconnect**.
1.	Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Edit the Identity registry value</b></summary>

1.	From Start, type regedit, and then select **Registry Editor** from the results.  
1.	Use the arrows to expand selections and navigate to:
`HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Identity`
1.	Right-click the **Identities** folder and select **Delete**.
1.	Restart the device and try activating Microsoft 365 Apps again.
1.	If you still get the same error, open Registry Editor again, and navigate to the same location.
1.	Right-click **Identity** and select **New**.
1.	Select **DWORD**.
1.	Name the DWORD `NoDomainUser` and set the Value to 1.
1.	Restart the device and try to activate Microsoft 365 again.  
<br/><br/>
</details>

<details>
<summary><b>Temporarily turn off User Account Control (UAC)</b></summary>

1.	From Start, type uac, and select **Change User Account Control settings** from the search results.
1.	Change the setting to **Never notify**, the lowest setting.
1.	Restart the device and try to activate Microsoft 365 again.  
1.	After completing these steps, return UAC to its previous setting.
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>
