---
title: Mailbox recovery in Exchange Online
description: Help Tenant Administrator to recover a user and mailbox in Exchange online with PowerShell cmdlets.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
---
# Restore user mailboxes (mailbox recovery) in Exchange Online

_Original KB number:_ &nbsp; 20804

**Who is it for?**

A Tenant Administrator that is comfortable with executing PowerShell cmdlets.

**How does it work?**

We are going to ask you some specific questions to scope your situation. Then we take you through a series of steps tailored to your scenario.

**Estimated time of completion:**

30-45 minutes.

## Select the current state of the on-premises user account

If there is no [Directory Synchronization](/microsoft-365/enterprise/microsoft-365-integration?view=o365-worldwide&preserve-view=true) in the environment, then the **Managed Account** option should be selected.

If Directory Synchronization is in place, you can search within **Active Directory Users and Computers** to see if the on-premises account is **Present** or **Deleted**.

- [Managed Account (No DirSync)](#azure-active-directory-user-account-status-managed-account-no-dirsync)
- [User Account is present on-premises](#azure-active-directory-user-account-status-user-account-is-present-on-premises)
- [User Account deleted on-premises](#azure-active-directory-user-account-status-user-account-deleted-on-premises)

<a name='azure-active-directory-user-account-status-managed-account-no-dirsync'></a>

### Microsoft Entra user Account Status (Managed Account (No DirSync))

Connect to Azure Active Directory PowerShell and verify the Online Account Status.

[!INCLUDE [Azure AD PowerShell deprecation note](~/../Exchange/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

1. Install [Azure AD module](/previous-versions/azure/jj151815(v=azure.100)).
2. Open the Microsoft Online Services Module (shortcut from the desktop).
3. Run `$cred=Get-Credential`.

    > [!NOTE]
    > When prompted for credentials, type your Microsoft 365 administration account credentials.

4. Run `Connect-MsolService -Credential $cred`. This cmdlet connects you to Microsoft 365.
5. Run `Get-MSOLUser -UserPrincipalName <UPN>`.

    Example: UserPrincipalName: user@contoso.com  
    If the user information is returned the user is **PRESENT**. If the user information is not returned, proceed to step 6.

6. Run `Get-MSOLUser -UserPrincipalName <UPN>-ReturnDeletedUsers |SELECT-OBJECT`.  
   If the user information is returned, the user is **SOFT DELETED**.

7. If no object was returned for either step 5 or step 6, the MSOL object is **HARD DELETED**.

Based on the outcome in the previous steps, select one of the following options:

- [Present](#exchange-online-mailbox-status-on-premises-is-managed-account-no-dirsync-and-online-account-status-is-present)
- [Soft Deleted](#exchange-online-mailbox-status-on-premises-is-managed-account-no-dirsync-and-online-account-status-is-soft-deleted)
- [Hard Deleted](#exchange-online-mailbox-status-on-premises-is-managed-account-no-dirsync-and-online-account-status-is-hard-deleted)

### Exchange Online Mailbox Status (on-premises is Managed Account (No DirSync) and online account status is Present)

Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) and verify the status of the Exchange Online Mailbox using the following instructions:

1. Ensure the [Exchange Online PowerShell module](/powershell/exchange/exchange-online-powershell-v2) is [installed](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-modern-authentication-with-or-without-mfa).

2. Connect to Exchange Online by running the command:

   ```powershell
   Connect-ExchangeOnline
   ```

   When prompted, enter the credentials for your Microsoft 365 admin account. If the account has multifactor authentication (MFA) enabled, you also need to enter a security code.

3. Run `Get-Mailbox -Identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX PRESENT** option should be selected. If not, go to step 4.

4. Run `Get-Mailbox -SoftDeletedMailbox -identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX SOFT DELETED** option should be selected. If not, go to step 5.

5. If nothing is returned from steps 3 & 4, select the **MAILBOX NOT PRESENT** option.

- [Mailbox Present](#online-account-present-online-mailbox-present)
- [Mailbox Soft Deleted](#online-account-present-online-mailbox-soft-deleted)
- [Mailbox Not Present](#azure-ad-account-present-online-mailbox-not-present)

### Exchange Online Mailbox Status (on-premises is Managed Account (No DirSync) and online account status is Soft Deleted)

Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) and verify the status of the Exchange Online Mailbox using the following instructions:

1. Ensure the [Exchange Online PowerShell module](/powershell/exchange/exchange-online-powershell-v2) is [installed](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-modern-authentication-with-or-without-mfa).

2. Connect to Exchange Online by running the command:

   ```powershell
   Connect-ExchangeOnline
   ```

   When prompted, enter the credentials for your Microsoft 365 admin account. If the account has multifactor authentication (MFA) enabled, you also need to enter a security code.

3. Run `Get-Mailbox -Identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX PRESENT** option should be selected. If not, go to step 4.

4. Run `Get-Mailbox -SoftDeletedMailbox -identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX SOFT DELETED** option should be selected. If not, go to step 5.

5. If nothing is returned from steps 3 & 4, select the **MAILBOX NOT PRESENT** option.

- [Mailbox Present](#azure-ad-account-soft-deleted-online-mailbox-present)
- [Mailbox Soft Deleted](#azure-ad-account-soft-deleted-exchange-online-mailbox-soft-deleted)
- [Mailbox Not Present](#azure-ad-account-soft-deleted-exchange-online-mailbox-not-present)

### Exchange Online Mailbox Status (on-premises is Managed Account (No DirSync) and online account status is Hard Deleted)

Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) and verify the status of the Exchange Online Mailbox using the following instructions:

1. Ensure the [Exchange Online PowerShell module](/powershell/exchange/exchange-online-powershell-v2) is [installed](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-modern-authentication-with-or-without-mfa).

2. Connect to Exchange Online by running the command:

   ```powershell
   Connect-ExchangeOnline
   ```

   When prompted, enter the credentials for your Microsoft 365 admin account. If the account has multifactor authentication (MFA) enabled, you also need to enter a security code.

3. Run `Get-Mailbox -Identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX PRESENT** option should be selected. If not, go to step 4.

4. Run `Get-Mailbox -SoftDeletedMailbox -identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX SOFT DELETED** option should be selected. If not, go to step 5.

5. If nothing is returned from steps 3 & 4, select the **MAILBOX NOT PRESENT** option.

- [Mailbox Present](#azure-ad-account-hard-deleted-online-mailbox-present-hard-deleted)
- [Mailbox Soft Deleted](#online-account-hard-deleted-online-mailbox-soft-deleted)
- [Mailbox Not Present](#online-account-hard-deleted-online-mailbox-not-present)

### AD User Account Deleted, Online Account Present, Online Mailbox Present

**Solution:**  
Contact Microsoft Support

When an Active Directory User object is deleted from on-premises, the deletion is synchronized to Microsoft Entra ID. This synchronization process could take up to three hours. If the deletion has not synchronized yet, there may be an issue with the directory synchronization application.

For more Directory Synchronization troubleshooting tips, see [Troubleshoot Azure Active Directory Sync tool installation and Configuration Wizard errors](/troubleshoot/azure/active-directory/installation-configuration-wizard-errors).

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='ad-user-account-deleted-azure-ad-account-present-online-mailbox-not-present'></a>

### AD User Account Deleted, Microsoft Entra account Present, Online Mailbox not present

**Solution:**  
Contact Microsoft Support. Due to the way Microsoft Entra Connect and the Online Services work, it shouldn't be a possible scenario. Contact Microsoft Support to get assistance with your issue.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='ad-account-deleted-azure-ad-account-present-soft-deleted-online-mailbox-soft-deleted'></a>

### AD Account Deleted, Microsoft Entra account Present (Soft deleted), Online Mailbox Soft Deleted

**Solution**:  
Restore the AD user and run directory synchronization, which will "soft match" the AD user object and the Microsoft Entra object, including reconnecting the "soft deleted" mailbox.

1. Connect to [Azure AD PowerShell](/previous-versions/azure/jj151815(v=azure.100)). In the same PowerShell window, connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Restore the [onPremise AD User](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379509(v=ws.10)).
3. Run a Delta Directory Sync.
4. Apply a new exchange [online license](/microsoft-365/admin/add-users/add-users) to the newly created Microsoft Entra object.
5. Use the [New-MailboxRestoreRequest](/powershell/module/exchange/new-mailboxrestorerequest) to merge the content of the **soft deleted** mailbox to the active mailbox. See an example in the following screen capture:

   :::image type="content" source="media/mailbox-recovery-in-exchange-online/new-mailbox-restore-request.png" alt-text="Screenshot shows an example to use the New-MailboxRestoreRequest command." border="false" lightbox="media/mailbox-recovery-in-exchange-online/new-mailbox-restore-request.png":::

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='ad-user-account-deleted-azure-ad-account-hard-deleted-online-mailbox-present'></a>

### AD User Account Deleted, Microsoft Entra account Hard Deleted, Online Mailbox Present

**Solution:**  
Recreate the user and restore the data from the original mailbox.

1. Connect to [Azure AD PowerShell](/previous-versions/azure/jj151815(v=azure.100)). In the same PowerShell window, connect to [Exchange Online remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Attempt to delete mailbox using by using the [Remove-Mailbox](/powershell/module/exchange/remove-mailbox) cmdlet on the affected mailboxExample:  
   From the Exchange Online PowerShell, run: `Remove-Mailbox`.

3. If step 2 fails, skip to step 8.

4. Restore the [on-premises AD User](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379481(v=ws.10)).

5. Run a Delta Directory Sync.

6. Apply a new exchange [online license](/microsoft-365/admin/add-users/add-users) to the newly created Microsoft Entra object.

7. Use the [New-MailboxRestoreRequest](/powershell/module/exchange/new-mailboxrestorerequest) to merge the content of the soft deleted mailbox to the active mailbox. See an example in the following screen capture:

    :::image type="content" source="media/mailbox-recovery-in-exchange-online/new-mailbox-restore-request.png" alt-text="Screenshot shows an example of using the New-MailboxRestoreRequest command." border="false" lightbox="media/mailbox-recovery-in-exchange-online/new-mailbox-restore-request.png":::

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='ad-user-account-deleted-azure-ad-account-hard-deleted-online-mailbox-not-present'></a>

### AD User Account Deleted, Microsoft Entra account Hard Deleted, Online Mailbox Not present

**Solution:**  
By Design

This situation is expected behavior if the customer deleted the on-premises object 30+ days ago. The mailbox is not recoverable at this point.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='ad-user-account-deleted-azure-ad-account-hard-deleted-online-mailbox-soft-deleted'></a>

### AD User Account Deleted, Microsoft Entra account Hard Deleted, Online Mailbox Soft Deleted

**Solution:**  

Restore Inactive mailbox and perform a **soft match**.

1. Connect to Azure AD PowerShell. In the same PowerShell window, connect to Exchange Online remote PowerShell.

2. Connect the Soft Deleted Mailbox to a new Microsoft Entra account with the following steps:

   1. If the tenant IS NOT using SSO (Single Sign-On), run the cmdlet:  
      `New-Mailbox -Name "UserName" -InactiveMailbox -MicrosoftOnlineServicesID UserName@contoso.com -Password (ConvertTo-SecureString -String 'Pa$$word1' -AsPlainText –Force)`
   2. If the tenant IS using ADFS (Identity Federation), run the cmdlet:  
      `New-Mailbox -Name "UserName" -InactiveMailbox -MicrosoftOnlineServicesID UserName@contoso.onmicrosoft.com -Password (ConvertTo-SecureString -String 'Pa$$word1' -AsPlainText –Force)`

3. [Restore](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379481(v=ws.10)) or create a new On-premises AD user. Ensure that the on-premises account's Primary SMTP Address matches the Primary SMTP Address of the Microsoft 365 object. Change the on-premises object's address to match if it does not.

4. Using [Microsoft Entra Connect](/azure/active-directory/hybrid/whatis-hybrid-identity) to run a Directory synchronization will soft match the on-premises account with the new Microsoft Entra account.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='ad-user-account-deleted-azure-ad-account-soft-deleted-online-mailbox-present'></a>

### AD User Account Deleted, Microsoft Entra account Soft Deleted, Online Mailbox Present

**Solution:**  
If the Account is soft deleted the mailbox shouldn't be present. However, we take you through the steps to attempt to recreate the user and reconnect them to the original mailbox.

To identify duplicates, use the following steps:

1. Connect to [Azure AD PowerShell](/previous-versions/azure/jj151815(v=azure.100)). In the same PowerShell window, connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run `Get-msoluser -returndeletedusers -userprincipalname user@contoso.com |Select-Object ObjectID`.

3. Run `Get-mailbox user@contoso.com |Select-Object ExternalDirectoryObjectID, UserPrincipalName`.

    - If the Object IDs match from step 2 and 3, then follow continue to step 4.
    - If the Objects ID's do not match from step 2 and 3, contact Microsoft support.

4. Create a new On-premises AD user and ensure that the on-premises accounts Primary SMTP Address matches the Primary SMTP Address of the Microsoft 365 object.

5. Ensure the UPN of the AD user object matches what was returned in step 3.
6. Wait three hours for the account to replicate to the Online services.
7. If the Mailbox did not reconnect, contact Microsoft Support.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='ad-user-account-deleted-azure-ad-account-soft-deleted-online-mailbox-not-present'></a>

### AD User Account Deleted, Microsoft Entra account Soft Deleted, Online Mailbox Not Present

**Solution:**  
Contact Microsoft Support

Due to the way Microsoft Entra Connect and the Online Services work, this should not be a possible scenario. Contact Microsoft Support to get assistance with your issue.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

### AD Account Deleted, Online Account Soft Deleted, Online Mailbox Soft Deleted

**Solution:**  
Restore the on-premises Account.

This best way to address the issue you are facing is to restore the original on-premises Active Directory User Account. After the restore, the exchange online mailbox will be accessible again.

1. [Restore](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379481(v=ws.10)) or create a new On-premises AD user and ensure that the on-premises accounts **Primary SMTP Address** matches the **Primary SMTP Address** of the Microsoft 365 object.

2. Ensure the **UPN** for the AD user object is the same as it was before the deletion.
3. Wait three hours for the account to replicate to the Online services.
4. If the Mailbox did not reconnect, contact Microsoft Support.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='azure-active-directory-user-account-status-user-account-is-present-on-premises'></a>

### Microsoft Entra user Account Status (User Account is present on-premises)

Connect to Azure Active Directory PowerShell and verify the Online Account Status:

1. Install [Azure AD module](/previous-versions/azure/jj151815(v=azure.100)).
2. Open the Microsoft Online Services Module (shortcut from the desktop).
3. Run `$cred=Get-Credential`.

    > [!NOTE]
    > When prompted for credentials, type your Microsoft 365 administration account credentials.

4. Run `Connect-MsolService -Credential $cred`. This cmdlet connects you to Microsoft 365.
5. Run `Get-MSOLUser -UserPrincipalName <UPN>`.

    Example: UserPrincipalName: user@contoso.com  
    If the user information is returned the user is **PRESENT**. If the user information is not returned, proceed to step 6.

6. Run `Get-MSOLUser -UserPrincipalName <UPN>-ReturnDeletedUsers |SELECT-OBJECT`.  
   If the user information is returned, the user is **SOFT DELETED**.

7. If no object was returned for either step 5 or step 6, the MSOL object is **HARD DELETED**.

Based on the outcome in the previous steps, select one of the following options:

- [Present](#exchange-online-mailbox-status-on-premises-user-account-is-present-and-azure-active-directory-user-account-is-present)
- [Soft Deleted](#exchange-online-mailbox-status-on-premises-user-account-is-present-and-azure-active-directory-user-account-is-soft-deleted)
- [Hard Deleted](#exchange-online-mailbox-status-on-premises-user-account-is-present-and-azure-active-directory-user-account-is-hard-deleted)

<a name='exchange-online-mailbox-status-on-premises-user-account-is-present-and-azure-active-directory-user-account-is-present'></a>

### Exchange Online Mailbox Status (on-premises user account is Present and Microsoft Entra user account is Present)

Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) and verify the status of the Exchange Online Mailbox using the following instructions:

1. Ensure the [Exchange Online PowerShell module](/powershell/exchange/exchange-online-powershell-v2) is [installed](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-modern-authentication-with-or-without-mfa).

2. Connect to Exchange Online by running the command:

   ```powershell
   Connect-ExchangeOnline
   ```

   When prompted, enter the credentials for your Microsoft 365 admin account. If the account has multifactor authentication (MFA) enabled, you'll also need to enter a security code.

3. Run `Get-Mailbox -Identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX PRESENT** option should be selected. If not, go to step 4.

4. Run `Get-Mailbox -SoftDeletedMailbox -identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX SOFT DELETED** option should be selected. If not, go to step 5.

5. If nothing is returned from steps 3 & 4, select the **MAILBOX NOT PRESENT** option.

- [Mailbox Present](#azure-ad-account-present-exchange-online-mailbox-present)
- [Mailbox Soft Deleted](#azure-ad-account-present-exchange-online-mailbox-soft-deleted)
- [Mailbox Not Present](#azure-ad-account-present-exchange-online-mailbox-not-present-purged)

<a name='exchange-online-mailbox-status-on-premises-user-account-is-present-and-azure-active-directory-user-account-is-soft-deleted'></a>

### Exchange Online Mailbox Status (on-premises user account is Present and Microsoft Entra user account is Soft Deleted)

Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) and verify the status of the Exchange Online Mailbox using the following instructions:

1. Ensure the [Exchange Online PowerShell module](/powershell/exchange/exchange-online-powershell-v2) is [installed](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-modern-authentication-with-or-without-mfa).

2. Connect to Exchange Online by running the command:

   ```powershell
   Connect-ExchangeOnline
   ```

   When prompted, enter the credentials for your Microsoft 365 admin account. If the account has multifactor authentication (MFA) enabled, you'll also need to enter a security code.

3. Run `Get-Mailbox -Identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX PRESENT** option should be selected. If not, go to step 4.

4. Run `Get-Mailbox -SoftDeletedMailbox -identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX SOFT DELETED** option should be selected. If not, go to step 5.

5. If nothing is returned from steps 3 & 4, select the **MAILBOX NOT PRESENT** option.

- [Mailbox Present](#azure-ad-account-soft-deleted-exchange-online-mailbox-present)
- [Mailbox Soft Deleted](#online-account-soft-deleted-online-mailbox-soft-deleted)
- [Mailbox Not Present](#online-account-soft-deleted-online-mailbox-is-not-present-purged)

<a name='exchange-online-mailbox-status-on-premises-user-account-is-present-and-azure-active-directory-user-account-is-hard-deleted'></a>

### Exchange Online Mailbox Status (on-premises user account is Present and Microsoft Entra user account is Hard Deleted)

Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) and verify the status of the Exchange Online Mailbox using the following instructions:

1. Ensure the [Exchange Online PowerShell module](/powershell/exchange/exchange-online-powershell-v2) is [installed](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-modern-authentication-with-or-without-mfa).

2. Connect to Exchange Online by running the command:

   ```powershell
   Connect-ExchangeOnline
   ```

   When prompted, enter the credentials for your Microsoft 365 admin account. If the account has multifactor authentication (MFA) enabled, you'll also need to enter a security code.

3. Run `Get-Mailbox -Identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX PRESENT** option should be selected. If not, go to step 4.

4. Run `Get-Mailbox -SoftDeletedMailbox -identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX SOFT DELETED** option should be selected. If not, go to step 5.

5. If nothing is returned from steps 3 & 4, select the **MAILBOX NOT PRESENT** option.

- [Mailbox Present](#azure-ad-account-hard-deleted-online-mailbox-present)
- [Mailbox Soft Deleted](#azure-ad-account-hard-deleted-exchange-online-mailbox-soft-deleted)
- [Mailbox Not Present](#azure-ad-account-hard-deleted-exchange-online-mailbox-not-present-purged)

<a name='azure-ad-account-present-exchange-online-mailbox-present'></a>

### Microsoft Entra account Present, Exchange Online Mailbox Present

**Solution:**  
Service is functioning normally.

This is the expected behavior of the Exchange Online Services.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='azure-ad-account-present-exchange-online-mailbox-soft-deleted'></a>

### Microsoft Entra account Present, Exchange Online Mailbox Soft Deleted

**Solution:**  
Follow these steps to recover the mailbox.

1. Connect to [Azure AD PowerShell](/previous-versions/azure/jj151815(v=azure.100)). In the same PowerShell window, connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run `Get-Mailbox -Softdeletedmailbox user@contoso.com |Select-Object ExternalDirectoryObjectID`.
3. Run `Get-Msoluser -ObjectID`.
4. Check if the `ExternalDirectoryObjectID` values from step 2 and step 3 match.
5. If they do, soft-delete the Microsoft Entra user by running `Remove-Msoluser -Userprincipalname user@contoso.com`.

     - Run `$DelUser = Get-MsolUser -UserPrincipalName User@contoso.com -ReturnDeletedUsers`.
     - `Restore-MsolUser -ObjectId $DelUser.ObjectId`.
6. After 5 minutes, restore the Microsoft Entra user using the following steps.
7. If the `ExternalDirectoryObjectID` values from step 2 and step 3 don't match, it means there's a duplicate Microsoft Entra user. Contact support.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='azure-ad-account-present-exchange-online-mailbox-not-present-purged'></a>

### Microsoft Entra account Present, Exchange Online Mailbox Not present (Purged)

Solution:  
This issue is often caused by having an unlicensed user account.

1. Log in to the Microsoft 365 portal at [https://portal.office.com](https://portal.office.com/) and check the user's [license status](/microsoft-365/admin/add-users/add-users).
2. Check to see if the user has a valid license. If user doesn't have a valid license, [apply](/microsoft-365/admin/add-users/add-users) an Exchange Online License.
3. If the mailbox isn't recoverable, you may have a blank mailbox connected. While it is unlikely that we can recover your data you can call into support.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='azure-ad-account-soft-deleted-exchange-online-mailbox-present'></a>

### Microsoft Entra account Soft Deleted, Exchange Online Mailbox Present

**Solution:**  
This behavior is by design, if the Microsoft Entra user is deleted, the mailbox associated with it will get to a soft-deleted state. We need to confirm that the mailbox isn't orphaned or if there are no duplicate accounts and mailboxes.

1. Connect to [Azure AD PowerShell](/previous-versions/azure/jj151815(v=azure.100)). In the same PowerShell window, connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run `get-mailbox -identity User@contoso.com |Select-Object ExternalDirectoryObjectID`.
3. Run `get-msoluser -objectID < specify ExternalDirectoryObjectID from step 2> -returnDeletedUsers |select-object`.
4. Confirm that the MSOLUser is returned from step 3 and then, simply restore the deleted MSOL user back to an Active user using the following steps:
   - Run `$DelUser = Get-MsolUser -UserPrincipalName User@contoso.com -ReturnDeletedUsers`.
   - Run `Restore-MsolUser -ObjectId $DelUser.ObjectId`.
5. Log in to the mailbox using the `UserPrincipalName` and verify you are able to access the mailbox.

> [!NOTE]
> If step 2 & 3 don't yield any results, there may be a duplicate Microsoft Entra object or this mailbox is orphaned. Contact support to resolve the issue.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

### Online Account Soft Deleted, Online Mailbox Soft Deleted

**Solution:**  
Synchronize the user account to allow the mailbox to automatically reconnect to the user.

1. Using the on-premises Active Directory Users and Computers, move the user to an Organizational Unit that isn't filtered in directory synchronization.
2. Force delta synchronization.
3. After synchronization is complete, confirm that the user is present in Microsoft Entra ID (through **O365 admin center** > **Active users**). The mailbox gets reconnected to the Microsoft Entra user automatically.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

### Online Account Soft Deleted, Online Mailbox is not present (Purged)

**Solution:**  
Follow these steps to review the license status of the user. If the license property doesn't hold any value, the mailbox is disabled and isn't recoverable.

1. Connect to [Azure AD PowerShell](/previous-versions/azure/jj151815(v=azure.100)).
2. Check License on the object using:

   `get-msoluser -userprincipalname user@contoso.com |Select-object Licenses`
3. If license property doesn't hold any value, the mailbox isn't recoverable.
4. Using the on-premises Active Directory Users and Computers, move the user to an Organizational Unit that isn't filtered in directory synchronization.
5. Run a Delta Directory synchronization.
6. Once Microsoft Entra user (MSOL User) has been restored, [apply a license](/microsoft-365/admin/add-users/add-users) to provision new mailbox.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='azure-ad-account-hard-deleted-online-mailbox-present'></a>

### Microsoft Entra account Hard Deleted, Online Mailbox Present

**Solution:**  
Contact Microsoft Support

This scenario should not be possible because of the way Exchange Online Account provisioning in Microsoft 365 works. It would be best to contact Microsoft Support so we can help work out the best solution for this issue.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='azure-ad-account-hard-deleted-exchange-online-mailbox-soft-deleted'></a>

### Microsoft Entra account Hard Deleted, Exchange Online Mailbox Soft Deleted

**Solution:**  

1. Connect to [Azure AD PowerShell](/previous-versions/azure/jj151815(v=azure.100)). In the same PowerShell window, connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Next, determine the state of the soft-deleted mailbox.

   Run `Get-mailbox –softdeletedmailbox –identity "<UserPrincipalName of the user>" |select-object IsInactiveMailbox`.

3. Based on the value of `IsInactiveMailbox`, take the appropriate steps:

   If `IsInactiveMailbox` is **True**:

      1. Run `Get-Mailbox "<UserPrincipalName of the user>" -softdeletedmailbox| Select Name, DisplayName, MicrosoftOnlineServicesID, ExchangeGuid`.
      2. Run `New-Mailbox -Name "<Name from Step 2>" -inactivemailbox "<ExchangeGuid from Step 2>" -MicrosoftOnlineServicesID "<MicrosoftOnlineServicesID from Step 2>" -Password (ConvertTo-SecureString -String 'Pa##w0rd goes here' -AsPlainText -Force)`.
      3. Using the on-premises Active Directory Users and Computers, move the user to an Organizational Unit that isn't filtered in directory synchronization.

   If `IsInactiveMailbox` is **False**:

     1. Run `Undo-SoftDeletedMailbox user@contoso.com -WindowsLiveID user@contoso.com -Password (ConvertTo-SecureString -String 'Pa$$word1' -AsPlainText -Force)`.
     2. Connect to [Azure AD PowerShell](/previous-versions/azure/jj151815(v=azure.100)).
     3. Run `get-msoluser -userprincipalname user@contoso.com`.
     4. Once you verified that the **MSOLUser** is returned in the previous step to force a delta sync from on-premises Active Directory. It soft-matches to the user in Microsoft Entra ID.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

<a name='azure-ad-account-hard-deleted-exchange-online-mailbox-not-present-purged'></a>

### Microsoft Entra account Hard Deleted, Exchange Online Mailbox not present (Purged)

**Solution:**  
Mailbox might have been removed (outside the 30-day retention period) and hence can't be recovered.

Follow these steps to provision a new mailbox for the affected user:

1. Force a delta synchronization to sync the on-premises Active Directory user to Microsoft Entra ID.
2. If in an Exchange Hybrid environment
   1. Provision an Exchange Online mailbox for the user by running `Enable-RemoteMailbox "UserName" -RemoteRoutingAddress "User@contoso.mail.onmicrosoft.com"`.
   2. [Assign an Exchange online license](/microsoft-365/admin/add-users/add-users) to the user through the Microsoft 365 portal.

3. If not in an Exchange Hybrid environment, simply [assign the Exchange Online License](/microsoft-365/admin/add-users/add-users) for the user.

- If your issue is resolved, congratulations! Your scenario is complete.
- If your issue isn't resolved, see [Additional Resources](#additional-resources).

### Online Account Present, Online Mailbox Present

**Solution:**

Service is functioning normally.

This behavior is expected in the Exchange Online Services.

- If your issue is solved, congratulations! Your scenario is complete.
- If your issue wasn't solved, see [Additional Resources](#additional-resources).

### Online Account Present, Online Mailbox Soft-Deleted

**Solution:**  

1. Log in to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Recover the soft-deleted mailbox using the following command.

    Run `Undo- SoftDeletedMailbox user@contoso.com -WindowsLiveID user@contoso.com -Password (ConvertTo-SecureString -String 'Pa$$word1' -AsPlainText -Force)`.

    For more information, see [Undo-SoftDeletedMailbox](/powershell/module/exchange/undo-softdeletedmailbox).

3. Log in to the [Microsoft 365 portal](https://portal.office.com/) and check the user's [license status](/microsoft-365/admin/add-users/add-users). If user doesn't have a valid license, apply the Exchange online license.

- If your issue is solved, congratulations! Your scenario is complete.
- If your issue isn't solved, see [Additional Resources](#additional-resources).

<a name='azure-ad-account-present-online-mailbox-not-present'></a>

### Microsoft Entra account Present, Online Mailbox Not Present

**Solution:**

The original mailbox is not recoverable. Assign a license to the user to create a new mailbox.

1. Log in to the [Microsoft 365 portal](https://portal.office.com/) as the tenant Administrator.
2. [Assign the Exchange Online License](/microsoft-365/admin/add-users/add-users) for the user.

- If your issue is solved, congratulations! Your scenario is complete.
- If your issue isn't solved, see [Additional Resources](#additional-resources).

<a name='azure-ad-account-soft-deleted-online-mailbox-present'></a>

### Microsoft Entra account soft-deleted, Online Mailbox Present

**Solution:**  
Contact Microsoft Support

Because of the way Exchange Online Account provisioning in Microsoft 365 works, it shouldn't be possible. It would be best to contact Microsoft Support to assist in working out the best solution for this issue.

- If your issue is solved, congratulations! Your scenario is complete.
- If your issue isn't solved, see [Additional Resources](#additional-resources).

<a name='azure-ad-account-soft-deleted-exchange-online-mailbox-not-present'></a>

### Microsoft Entra account soft-deleted, Exchange Online Mailbox not present

**Solution**:  
Mailbox might have been completely purged (outside the 30-day period) and hence can't be recovered. Following these steps will ensure that a new user account and new mailbox are provisioned for the affected user.

1. Log in to [Microsoft 365 portal](https://portal.office.com/).
2. Create a new user account for the affected user.
3. [Assign the Exchange Online License](/microsoft-365/admin/add-users/add-users?) for the user.

> [!NOTE]
> Any old data will not be present in this new mailbox.

- If your issue is solved, congratulations! Your scenario is complete.
- If your issue isn't solved, see [Additional Resources](#additional-resources).

<a name='azure-ad-account-soft-deleted-exchange-online-mailbox-soft-deleted'></a>

### Microsoft Entra account soft-deleted, Exchange Online Mailbox Soft Deleted

**Solution**:  
Follow these steps to recover the mailbox.

1. Connect to [Azure AD PowerShell](/previous-versions/azure/jj151815(v=azure.100)).
2. Restore the Microsoft Entra user using the following steps:
   - Run `$DelUser = Get-MsolUser -UserPrincipalName User@contoso.com -ReturnDeletedUsers`.
   - `Restore-MsolUser -ObjectId $DelUser.ObjectId`

3. Log into [Microsoft 365 portal](https://portal.office.com/) and [assign the Exchange Online License](/microsoft-365/admin/add-users/add-users) for the user.

- If your issue is solved, congratulations! Your scenario is complete.
- If your issue isn't solved, see [Additional Resources](#additional-resources).

<a name='azure-ad-account-hard-deleted-online-mailbox-present-hard-deleted'></a>

### Microsoft Entra account Hard Deleted, Online Mailbox Present (Hard Deleted)

**Solution:**  
Contact Microsoft Support

Because of the way Exchange Online Account provisioning in Microsoft 365 works, it shouldn't be possible. It would be best to contact Microsoft Support to assist in working out the best solution for this issue.

- If your issue is solved, congratulations! Your scenario is complete.
- If your issue isn't solved, see [Additional Resources](#additional-resources).

### Online Account Hard Deleted, Online Mailbox soft-deleted

Solution:  
Follow these steps to recover the mailbox.

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. We need to determine the state of the soft-deleted mailbox.

   Run `Get-mailbox –softdeletedmailbox –identity "<UserPrincipalName of the user>" |select-object IsInactiveMailbox`.

3. Based on the value of `IsInactiveMailbox`, take the appropriate steps:

   If `IsInactiveMailbox` is **True**:

     1. Run `Get-Mailbox "<UserPrincipalName of the user>" -softdeletedmailbox| Select Name, DisplayName, MicrosoftOnlineServicesID, ExchangeGuid`.
     2. Run `New-Mailbox -Name "<Name from Step 2>" -inactivemailbox "<ExchangeGuid from Step 2>" -MicrosoftOnlineServicesID "<MicrosoftOnlineServicesID from Step 2>" -Password (ConvertTo-SecureString -String 'Pa##w0rd goes here' -AsPlainText -Force)`.
  
   If `IsInactiveMailbox` is **False**:

    1. Run `Undo-SoftDeletedMailbox user@contoso.com -WindowsLiveID user@contoso.com -Password (ConvertTo-SecureString -String 'Pa$$word1' -AsPlainText -Force)`.
    2. Connect to [Azure AD PowerShell](/previous-versions/azure/jj151815(v=azure.100)).
    3. Run `get-msoluser -userprincipalname user@contoso.com`.

4. Log into [Microsoft 365 portal](https://portal.office.com/) and [assign the Exchange Online License](/microsoft-365/admin/add-users/add-users) for the user.

- If your issue is solved, congratulations! Your scenario is complete.
- If your issue isn't solved, see [Additional Resources](#additional-resources).

### Online Account hard deleted, Online Mailbox Not Present

Solution:  
Mailbox is not recoverable. Following these steps will ensure that a new user account and new mailbox are provisioned for the affected user.

1. Log in to [Microsoft 365 portal](https://portal.office.com/).
2. Create a new user account for the affected user.
3. [Assign the Exchange Online License](/microsoft-365/admin/add-users/add-users) for the user.

> [!NOTE]
> Any old data will not be present in this new mailbox.

- If your issue is solved, congratulations! Your scenario is complete.
- If your issue isn't solved, see [Additional Resources](#additional-resources).

### Additional Resources

Sorry, we couldn't resolve your issue with this guide, use the following resources to continue troubleshooting. Visit the [Microsoft 365 Community](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1) for self-help support. Use one of the following ways:

- Use search to find a solution to your issue.
- Sign in with your Microsoft 365 admin credentials, and then post a question to the community.

<a name='azure-active-directory-user-account-status-user-account-deleted-on-premises'></a>

### Microsoft Entra user Account Status (User Account deleted on-premises)

Connect to Azure Active Directory PowerShell and verify the Online Account Status

1. Install [Azure AD module](/previous-versions/azure/jj151815(v=azure.100)).
2. Open the Microsoft Online Services Module (shortcut from the desktop).
3. Run `$cred=Get-Credential`.

    > [!NOTE]
    > When prompted for credentials, type your Microsoft 365 administration account credentials.

4. Run `Connect-MsolService -Credential $cred`. This cmdlet connects you to Microsoft 365.
5. Run `Get-MSOLUser -UserPrincipalName <UPN>`.

    Example: UserPrincipalName: user@contoso.com  
    If the user information is returned the user is **PRESENT**. If the user information is not returned, proceed to step 6.

6. Run `Get-MSOLUser -UserPrincipalName <UPN>-ReturnDeletedUsers |SELECT-OBJECT`.  
   If the user information is returned, the user is **SOFT DELETED**.

7. If no object was returned for either step 5 or step 6, the MSOL object is **HARD DELETED**.

Based on the outcome in the previous steps, select one of the following options:

- [Present](#exchange-online-mailbox-status-on-premises-user-account-is-deleted-and-azure-active-directory-user-account-is-present)
- [Soft Deleted](#exchange-online-mailbox-status-on-premises-user-account-is-deleted-and-azure-active-directory-user-account-is-soft-deleted)
- [Hard Deleted](#exchange-online-mailbox-status-on-premises-user-account-is-deleted-and-azure-active-directory-user-account-is-hard-deleted)

<a name='exchange-online-mailbox-status-on-premises-user-account-is-deleted-and-azure-active-directory-user-account-is-present'></a>

### Exchange Online Mailbox Status (on-premises user account is Deleted and Microsoft Entra user account is Present)

Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) and verify the status of the Exchange Online Mailbox using the following instructions:

1. Ensure the [Exchange Online PowerShell module](/powershell/exchange/exchange-online-powershell-v2) is [installed](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-modern-authentication-with-or-without-mfa).

2. Connect to Exchange Online by running the command:

   ```powershell
   Connect-ExchangeOnline
   ```

   When prompted, enter the credentials for your Microsoft 365 admin account. If the account has multifactor authentication (MFA) enabled, you'll also need to enter a security code.

3. Run `Get-Mailbox -Identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX PRESENT** option should be selected. If not, go to step 4.

4. Run `Get-Mailbox -SoftDeletedMailbox -identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX SOFT DELETED** option should be selected. If not, go to step 5.

5. If nothing is returned from steps 3 & 4, select the **MAILBOX NOT PRESENT** option.

- [Mailbox Present](#ad-user-account-deleted-online-account-present-online-mailbox-present)
- [Mailbox Soft Deleted](#ad-account-deleted-azure-ad-account-present-soft-deleted-online-mailbox-soft-deleted)
- [Mailbox Not Present](#ad-user-account-deleted-azure-ad-account-present-online-mailbox-not-present)

<a name='exchange-online-mailbox-status-on-premises-user-account-is-deleted-and-azure-active-directory-user-account-is-soft-deleted'></a>

### Exchange Online Mailbox Status (on-premises user account is Deleted and Microsoft Entra user account is Soft Deleted)

Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) and verify the status of the Exchange Online Mailbox using the following instructions:

1. Ensure the [Exchange Online PowerShell module](/powershell/exchange/exchange-online-powershell-v2) is [installed](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-modern-authentication-with-or-without-mfa).

2. Connect to Exchange Online by running the command:

   ```powershell
   Connect-ExchangeOnline
   ```

   When prompted, enter the credentials for your Microsoft 365 admin account. If the account has multifactor authentication (MFA) enabled, you'll also need to enter a security code.

3. Run `Get-Mailbox -Identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX PRESENT** option should be selected. If not, go to step 4.

4. Run `Get-Mailbox -SoftDeletedMailbox -identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX SOFT DELETED** option should be selected. If not, go to step 5.

5. If nothing is returned from steps 3 & 4, select the **MAILBOX NOT PRESENT** option.

- [Mailbox Present](#ad-user-account-deleted-azure-ad-account-soft-deleted-online-mailbox-present)
- [Mailbox Soft Deleted](#ad-account-deleted-online-account-soft-deleted-online-mailbox-soft-deleted)
- [Mailbox Not Present](#ad-user-account-deleted-azure-ad-account-soft-deleted-online-mailbox-not-present)

<a name='exchange-online-mailbox-status-on-premises-user-account-is-deleted-and-azure-active-directory-user-account-is-hard-deleted'></a>

### Exchange Online Mailbox Status (on-premises user account is Deleted and Microsoft Entra user account is Hard Deleted)

Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) and verify the status of the Exchange Online Mailbox using the following instructions:

1. Ensure the [Exchange Online PowerShell module](/powershell/exchange/exchange-online-powershell-v2) is [installed](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-modern-authentication-with-or-without-mfa).

2. Connect to Exchange Online by running the command:

   ```powershell
   Connect-ExchangeOnline
   ```

   When prompted, enter the credentials for your Microsoft 365 admin account. If the account has multifactor authentication (MFA) enabled, you'll also need to enter a security code.

3. Run `Get-Mailbox -Identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX PRESENT** option should be selected. If not, go to step 4.

4. Run `Get-Mailbox -SoftDeletedMailbox -identity <user Alias>`.  
   If the mailbox is returned, the **MAILBOX SOFT DELETED** option should be selected. If not, go to step 5.

5. If nothing is returned from steps 3 & 4, select the **MAILBOX NOT PRESENT** option.

- [Mailbox Present](#ad-user-account-deleted-azure-ad-account-hard-deleted-online-mailbox-present)
- [Mailbox Soft Deleted](#ad-user-account-deleted-azure-ad-account-hard-deleted-online-mailbox-soft-deleted)
- [Mailbox Not Present](#ad-user-account-deleted-azure-ad-account-hard-deleted-online-mailbox-not-present)
