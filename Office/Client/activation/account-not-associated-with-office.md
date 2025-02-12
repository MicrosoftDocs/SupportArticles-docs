---
title: Microsoft 365 Apps activation error The account isn’t associated with this Office product
description: Troubleshooting the Microsoft 365 Apps activation error The account isn’t associated with this Office product.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\The account isn't associated with this office product
  - CSSTroubleshoot
  - CI 157755
  - CI 159112
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/11/2025
---

# Microsoft 365 Apps activation error “The account isn’t associated with this Office product”

When activating Microsoft 365 apps, you might encounter one of the following errors:  

The account doesn't have Office yet.

The account isn't associated with this office product.

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>

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
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>

<details>
<summary><b>Remove Office credentials</b></summary>

1.	From Start, type *credential manager*, and then select **Credential Manager** from the search results.
1.	Select **Windows credentials**.
1.	If there are any credentials for **MicrosoftOffice16**, select the arrow next to them and then select **Remove**.
1.	Close Credential Manager.
1.	From Start, select **Settings** (the gear icon) > **Accounts** > **Access work or school**.
1.	If the account you use to sign in to office.com is listed there, but it isn’t the account you use to sign in to Windows, select it, and then select **Disconnect**.
1.	Restart the device and try to activate Microsoft 365 again.
<br/><br/>

<details>
<summary><b>Reset your password</b></summary>

Go to https://portal.office.com/account and select **Security & privacy**. Reset your password, then try activating Microsoft 365 again.
<br/><br/>
</details>

### Additional troubleshooting

If the above steps don’t solve the problem, try the steps in the following article:

- [Microsoft 365 Apps activation limits](./activation-limits.md)
