---
title: Microsoft 365 Apps activation Subscription expired error
description: Troubleshooting steps for Microsoft 365 Apps activation Subscription expired error.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Subscription Expired
  - CSSTroubleshoot
  - CI 157754
  - CI 159067
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/11/2025
---

# Microsoft 365 Apps activation Subscription expired error

When you try to activate Microsoft 365 apps, you might encounter an error indicating that your subscription has expired.  

Try the following troubleshooting methods to solve the problem.  

**Notes:**

- If your Microsoft 365 license didn't come from your work, school, or other organization, see [A subscription notice appears when I open a Microsoft 365 application](https://support.microsoft.com/office/a-subscription-notice-appears-when-i-open-a-microsoft-365-application-4cabe32c-f594-4c0e-9191-3d3ade10cceb).

- Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>
<details>
<summary><b>Turn on Recurring billing and make sure your subscription is active</b></summary>

1. In the [Microsoft 365 Admin Center](https://admin.microsoft.com), select **Billing** > **Your products**.
1.	Select the subscription. Check if the subscription is active. If it isn’t, select **Reactivate subscription**. If it isn’t, select **Reactivate subscription**.
1.	Under **Subscription and payment settings**, select **Edit recurring billing**.
1.	Select **On** or **On, but renew once**.
If your subscription is a retail license, see [Office error Account Notice: We've run into a problem with your Microsoft 365 subscription](https://support.microsoft.com/office/office-error-account-notice-we-ve-run-into-a-problem-with-your-microsoft-365-subscription-17f71ecb-f53c-4f3d-ae18-7230ca1594c1).
<br/><br/>
</details>

<details>
<summary><b>Redeem a product key</b></summary>

If your purchase of Office or Microsoft 365 came with a product key, see [Where to enter your Office product key](https://support.microsoft.com/office/where-to-enter-your-office-product-key-0a82e5ae-739e-4b92-a6f4-2ec780c185db).
  
For more information, see [Using product keys with Office](https://support.microsoft.com/office/using-product-keys-with-office-12a5763a-d45c-4685-8c95-a44500213759).

<br/><br/>
</details>

<details>
<summary><b>Redeem a Partner product key</b></summary>

If your organization is a Microsoft Partner, locate your product key by following the instructions in [MPN Benefits – Software](/partner-center/mpn-benefits-software).

When you have your product key, go to https://signup.microsoft.com/productkeystart?ms.officeurl=setup365 and following the steps to redeem it.

If you are trying to set up a subscription for a customer, see [Partners: use a product key to set up a customer subscription](https://support.microsoft.com/topic/partners-use-a-product-key-to-set-up-a-customer-subscription-cf22c50f-95c9-4fa2-b959-c264de256d40).
<br/><br/>
</details>

<details>
<summary><b>Redeem an Action Pack product key</b></summary>

If you have an Action Pack subscription product key, go to https://portal.office.com/Commerce/ProductKeyStart.aspx, sign in and then enter the product key.

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
<summary><b>Remove Office credentials</b></summary>

1.	From Start, type *credential manager*, and then select **Credential Manager** from the search results.
1.	Select **Windows credentials**.
1.	If there are any credentials for **MicrosoftOffice16**, select the arrow next to them and then select **Remove**.
1.	Close Credential Manager.
1.	From Start, select **Settings** (the gear icon) > **Accounts** > **Access work or school**.
1.	If the account you use to sign in to office.com is listed there, but it isn’t the account you use to sign in to Windows, select it, and then select **Disconnect**.
1.	Restart the device and try to activate Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>
