---
title: Activation Error The Account isn't Associated with this Office Product
description: Troubleshooting the Microsoft 365 Apps activation error The account isn't associated with this Office product.
ms.reviewer: vikkarti
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\The account isn't associated with this office product
  - CSSTroubleshoot
  - CI 157755
  - CI 159112
  - CI 5844
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 05/19/2025
---

# Microsoft 365 Apps activation error: "The account isn't associated with this Office product"

When you activate Microsoft 365 Apps, you might receive one of the following error messages:  

> The account doesn't have Office yet.

> The account isn't associated with this office product.

To solve the problem, try the following troubleshooting methods.

> [!NOTE]
> Some of these troubleshooting methods can be performed only by a Microsoft 365 admin. If you aren't an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)

<details>
<summary><b>Sign out of Microsoft 365 and sign back in</b></summary>

1. Open a Microsoft 365 app, such as Word.
1. Select your name and profile picture or icon at the top.
1. Select **Sign out**.
1. Select **Sign in**.
1. Make sure that you're signed in by using your **Work or School** account, not your personal Microsoft account.
1. Try to activate Microsoft 365 again.

</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).

</details>

<details>
<summary><b>Remove Office credentials</b></summary>

1. From Start, type *credential manager*, and then select **Credential Manager** from the search results.
1. Select **Windows credentials**.
1. If there are any credentials for **MicrosoftOffice16**, select the arrow next to them, and then select **Remove**.
1. Close Credential Manager.
1. From Start, select **Settings** (the gear icon) > **Accounts** > **Access work or school**.
1. If the account that you use to sign in to Microsoft 365 is listed there, but it isn't the account you use to sign in to Windows, select it, and then select **Disconnect**.
1. Restart the device and try again to activate Microsoft 365.

</details>

<details>
<summary><b>Change your password</b></summary>

[Change your password](https://support.microsoft.com/account-billing/change-your-work-or-school-account-password-97fced88-e0e7-4d7b-a9d3-936a3dcbd569), then try again to activate Microsoft 365.

</details>

If the previous steps don't solve the problem, try the steps in [Microsoft 365 Apps activation limits](./activation-limits.md).
