---
title: Target-Mailbox-Doesn't-Have-an-SMTP-Proxy-Matching Error During a Mailbox Migration
description: Resolves an issue in which you receive a target-mailbox-doesn't-have-an-smtp-proxy-matching error when moving on-premises mailboxes to Exchange Online in a hybrid environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
  - CI 3938
  - no-azure-ad-ps-ref
ms.reviewer: apascual, meerak, v-shorestris
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 04/24/2025
---

# "Target mailbox doesn't have an SMTP proxy matching" error during a mailbox migration

## Symptoms

When you try to migrate on-premises mailboxes to Microsoft Exchange Online in a hybrid environment, you receive the following error message:

> The target mailbox doesn't have an smtp proxy matching '\<domain\>.mail.onmicrosoft.com'

## Cause 1

The on-premises mailbox doesn't have an SMTP address that matches `<user>@<domain>.mail.onmicrosoft.com`.

To check the SMTP addresses for an on-premises mailbox, run the following cmdlet in Exchange Management Shell (EMS):

```PowerShell
Get-Mailbox -Identity <user ID> | FL EmailAddresses
```

## Cause 2

The source mailbox has an SMTP address that matches `<user>@<domain>.mail.onmicrosoft.com`. However, the SMTP address isn't synced to the corresponding mail-user object in Exchange Online.

To check the SMTP addresses for the mail-user object in Exchange Online, run the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

```PowerShell
Get-MailUser -Identity <user ID> | Select -ExpandProperty EmailAddresses
```

## Resolution for Cause 1

Use the following steps to add a secondary SMTP address that matches`<user>@<domain>.mail.onmicrosoft.com` to the on-premises mailbox:

1. Run the following PowerShell cmdlet in EMS to check whether the on-premises mailbox has an [email address policy](/exchange/email-addresses-and-address-books/email-address-policies/email-address-policies):

   ```PowerShell
   Get-Mailbox <user ID> | FL EmailAddressPolicyEnabled
   ```

   If the on-premises mailbox has an email address policy, the value of the **EmailAddressPolicyEnabled** parameter is `True`. 

   You can also use the Exchange admin center (EAC) to check whether an on-premises mailbox has an email address policy. A policy exists if the option **Automatically update email addresses based on the email address policy applied to this recipient** is selected for the user.

   > [!NOTE]
   > To check the email address templates for the policy, run the following PowerShell cmdlet in EMS:
   > `Get-EmailAddressPolicy | FL Identity, EnabledEmailAddressTemplates`

2. If the on-premises mailbox has an email address policy, follow these steps:

   - In the EAC for Exchange Server, select **Mail flow**, and then select **Email address policies**.
   - Select the email address policy that you want to change, and then click **Edit**.
   - In **Email address format**, add the `<domain>.mail.onmicrosoft.com` domain to the policy, select **Save**, and then select **Apply** to apply the change to the recipients.
   - Run the following PowerShell cmdlet in EMS to verify that the on-premises mailbox now has an SMTP address that matches`<user>@<domain>.mail.onmicrosoft.com`:

      ```PowerShell
      Get-Mailbox <user ID> | FL EmailAddresses
      ```

   > [!NOTE]
   > For more information, see [Email address policies in Exchange Server](/exchange/email-addresses-and-address-books/email-address-policies/email-address-policies).

3. If the on-premises mailbox doesn't have an email address policy, or step 2 fails, follow these steps:

   - In the EAC for Exchange Server, select **Recipients**, and then select **Mailboxes**.
   
   - Select and double-click the on-premises mailbox that you want to change.
   
   - In **Email addresses**, select the add icon, and then add an SMTP address that matches`<user>@<domain>.mail.onmicrosoft.com`.
   
   - Select **OK**, and then select **Save**.
   
   - Run the following PowerShell cmdlet in EMS to verify that the on-premises mailbox now has an SMTP address that matches`<user>@<domain>.mail.onmicrosoft.com`:

      ```PowerShell
      Get-Mailbox <user ID> | FL EmailAddresses, EmailAddressPolicyEnabled
      ```

4. Wait for directory sync to run, or [force a delta directory sync](/azure/active-directory/hybrid/how-to-connect-sync-feature-scheduler#start-the-scheduler), to push the change to Microsoft Entra ID.

## Resolution for Cause 2

Check for directory sync errors in Microsoft Entra Connect or the Microsoft 365 admin center. For information about how to identify and fix directory sync errors, see [Monitor Microsoft Entra Connect Sync with Microsoft Entra Connect Health](/entra/identity/hybrid/connect/how-to-connect-health-sync) and [View directory synchronization errors in Microsoft 365](/microsoft-365/enterprise/identify-directory-synchronization-errors).

If you don't find directory sync errors, perform the following checks:

1. Run the following PowerShell cmdlet to check whether the user object in Microsoft Entra ID has a validation error:

   ```PowerShell
   Install-Module -Name Microsoft.Entra 
   Connect-Entra -Scopes 'User.Read.All'
   (Get-EntraUser -Filter "startsWith(DisplayName, '<user display name>')").serviceProvisioningErrors.errorDetail
   ```

   [Identify and resolve any user validation errors](https://support.microsoft.com/help/2741233/you-see-validation-errors-for-users-in-the-office-365-portal-or-in-the).

2. Run the following PowerShell cmdlet to check whether the user object in Microsoft Entra ID has an SMTP address that matches`<user>@<domain>.mail.onmicrosoft.com`:

   ```PowerShell
   (Get-EntraUser -Filter "startsWith(DisplayName, '<user display name>')").ProxyAddresses
   ```

3. Run the following PowerShell cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to check whether the user object in Exchange Online has an SMTP address that matches`<user>@<domain>.mail.onmicrosoft.com`:

   ```PowerShell
   Get-MailUser -Identity <user ID> | Select -ExpandProperty EmailAddresses
   ```

4. If you find that the user object in Exchange Online doesn't have a SMTP address that matches`<user>@<domain>.mail.onmicrosoft.com` but the user object in Microsoft Entra ID does, there might be a sync issue between Microsoft Entra ID and Exchange Online.

5. Verify that the `<domain>.mail.onmicrosoft.com` domain is an [accepted domain](/exchange/mail-flow-best-practices/manage-accepted-domains/manage-accepted-domains#view-accepted-domains) in Exchange Online. For more information about the coexistence domain that's added by the Hybrid Configuration Wizard, see [Hybrid configuration options](/exchange/hybrid-configuration-wizard#hybrid-configuration-options).

If you're still unable to fix the issue, contact [Microsoft Support](https://support.microsoft.com/contactus/) for assistance.
