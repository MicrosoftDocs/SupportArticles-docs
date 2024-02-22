---
title: Reconnect inactive or soft-deleted mailboxes to AD
description: Explains how to reconnect an on-premises AD account with an inactive mailbox when the account is brought back into the scope of Microsoft Entra Connect.
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
ms.reviewer: kellybos, Nino Bilic, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Inactive mailbox is not automatically reconnected to an on-premises Active Directory account

_Original KB number:_ &nbsp; 4337973

## Symptoms

When your on-premises Active Directory account is brought back into the scope of Microsoft Entra Connect, your inactive mailbox is not reconnected automatically in Exchange Online. Additionally, a newly provisioned mailbox is created in Exchange Online.

> [!NOTE]
> For Office 365 dedicated/ITAR customers, Microsoft Managed Services Service Provisioning Provider (MMSSPP) writes back the `msExchMailboxGUID` and `ExchangeGUID` attributes from the dedicated environment to a customer's on-premises Active Directory during the coexistence phase. Instead of a newly provisioned mailbox in Exchange Online, a mail-enabled user is created.

## Cause

After mailbox objects are removed from the scope of Microsoft Entra Connect, they remain in the Microsoft Entra ID Recycle Bin for 30 days. You have to take additional steps to reconnect an on-premises AD account with an inactive mailbox when the account is purged from the Recycle Bin.

## Resolution

To resolve this issue, use the following processes.

### Transfer the content from the original mailbox

Restore the content from the inactive mailbox to the newly provisioned mailbox by using the [New-MailboxRestoreRequest](/powershell/module/exchange/new-mailboxrestorerequest?view=exchange-ps&preserve-view=true) cmdlet. This lets you continue to use the new mailbox and copy the original content.

### Reconnect the original inactive mailbox

> [!NOTE]
> This process also works for soft-deleted mailboxes if they connect to a new on-premises AD account. The `SoftDeletedMailbox` parameter should be used to replace the `InactiveMailboxOnly` parameter.

1. Run the following command to obtain inactive mailbox attributes from Exchange Online PowerShell:

    ```powershell
    $InactiveMailbox = Get-Mailbox -InactiveMailboxOnly -Identity <identity of inactive mailbox>
    ```

2. Run the following command to temporarily associate the inactive mailbox with a cloud account:

   ```powershell
   New-Mailbox -InactiveMailbox $InactiveMailbox.DistinguishedName -Name "<name of inactive mailbox>" -DisplayName "<DisplayName of inactive mailbox>" -MicrosoftOnlineServicesID <alias@*.onmicrosoft.com> -Password (ConvertTo-SecureString -String <PasswordString> -AsPlainText -Force) -ResetPasswordOnNextLogon $true
   ```

3. Connect with the Azure Active Directory PowerShell Module, and then run the following command to get the `ObjectGUID` attribute:

    ```powershell
     Get-ADUser -Identity <ADUser> -Properties "ObjectGUID"
     ```

4. Obtain the **`ImmutableID`** parameter value, which is the on-premises `ObjectGUID` attribute by default. You can convert `ObjectGUID` to `ImmutableID` by using the following command in Windows PowerShell:

   ```powershell
   [system.convert]::ToBase64String(([GUID]"<ObjectGUID>").tobytearray())
   ```

5. Set the `ImmutableID` parameter in Microsoft Entra ID:

    ```powershell
    Set-MsolUser -UserPrincipalName <UPN> -ImmutableId <ImmutableId>
    ```

6. Run a Microsoft Entra Connect delta sync. This brings the original Microsoft Entra account into the scope of Microsoft Entra Connect.

8. Check the mailbox object, and verify that the primary SMTP address is updated from a temporary user principal name (UPN) value to the correct primary address.

    > [!NOTE]
    > The new mailbox is not enabled for Litigation Hold. Additionally, you receive the following warning message:  
    > WARNING: The inactive mailbox has been recovered. To preserve data until you obtain a valid license, we have enabled Single Item Recovery for 30 days. Additionally we have also enabled Retention Hold for 30 days. Once a valid license has been assigned for this mailbox, you can choose to disable these settings and use Litigation or In-Place Hold instead to preserve data.

9. Apply the Exchange Server license and appropriate hold settings to the new mailbox.

## More information

The steps in the Resolution section are adapted from the cloud mailbox instructions in [Restore an inactive mailbox in Microsoft 365](/microsoft-365/compliance/restore-an-inactive-mailbox).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
