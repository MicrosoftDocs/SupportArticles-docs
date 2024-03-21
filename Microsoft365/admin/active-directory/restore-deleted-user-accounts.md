---
title: How to restore deleted user accounts in Microsoft 365, Azure, and Intune
description: Describes how to restore deleted user accounts in Microsoft 365, Azure, and Intune.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
ms.author: luche
ms.reviewer: v-lanac
appliesto: 
  - Microsoft 365
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft 365 User and Domain Management
ms.date: 03/31/2022
---
# How to restore deleted user accounts in Microsoft 365, Azure, and Intune

_Original KB number:_ &nbsp; 2619308

## Symptoms

A user account that was accidentally deleted from Microsoft 365, Microsoft Azure, or Microsoft Intune has to be restored.

## Resolution

#### Before you start  

When users are deleted from Microsoft Entra ID, they are moved to a "deleted" state and no longer appear in the user list. However, they are not completely removed, and they can be recovered within 30 days. 

Use Microsoft 365 and the Azure Active Directory module for PowerShell as follows to determine whether a user is eligible to be recovered from "deleted" status:

1. In the **Microsoft 365** portal, look up user accounts that were deleted through the portal. To do this, follow these steps:
   1. Sign in to the Microsoft 365 portal ([https://portal.office.com](https://portal.office.com/)) by using administrative credentials.
   1. Select **Users**, and then select **Deleted Users**.
   1. Locate the user that you want to recover.
1. In the Azure Active Directory module for Windows PowerShell, follow these steps:
   1. Select **Start** > **All Programs** > **Windows Azure Active Directory** > **Windows Azure Active Directory module for Windows PowerShell**.
   1. Type the following commands in the order in which they are presented, and press Enter after each command:
      - `$cred = get-credential`

        > [!NOTE]
        > When you're prompted, enter your Microsoft 365 credentials.
      - `Connect-MSOLService -credential:$cred`
      - `Get-MsolUser -ReturnDeletedUsers`

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

### Resolution 1: Recover manually deleted accounts by using Microsoft 365 portal or the Azure Active Directory module  

To recover a user account that was deleted manually, use one of the following methods:

- Use the Microsoft 365 portal to recover the user account. For more information about how to do this, [Restore a user](/microsoft-365/admin/add-users/restore-user).
- Use the Azure Active Directory module for Windows PowerShell to recover the user account. To do this, type the following command, and then press Enter:

    `Restore-MsolUser -ObjectId <Guid> -AutoReconcileProxyConflicts -NewUserPrincipalName <string>`

    If this command doesn't work, try the following command:

    `Restore-MsolUser -UserPrincipalName <string> -AutoReconcileProxyConflicts -NewUserPrincipalName <string>`

    > [!NOTE]
    > In these commands, the following conventions are used:
    > - The `UserPrincipalName` and `ObjectID` parameters uniquely identify the user object to be restored.
    > - The `AutoReconcileProxyConflicts` parameter is optional and is used in scenarios in which another user object is granted the target user object's proxy address after that address is deleted.
    > - The `NewUserPrincipalName` parameter is optionally used in scenarios in which another user object is granted by using the target user object's user principal name (UPN) after that UPN was deleted.

### Resolution 2: Recover accounts deleted because scoping changes exclude the on-premises Active Directory user object

To recover deleted user accounts, make sure that directory synchronization filtering (scoping) is set in such a way that the scope includes the objects that you want to recover.

For more information, see [Microsoft Entra Connect Sync: Configure filtering](/azure/active-directory/hybrid/how-to-connect-sync-configure-filtering).

### Resolution 3: Recover accounts deleted because the on-premises user object was deleted from the on-premises Active Directory schema

To recover an item that was deleted from the on-premises Active Directory schema, try the following methods:

- Try to restore the deleted item from the Active Directory recycle bin. To do this, see [Active Directory Recycle Bin Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd392261(v=ws.10)).

    > [!NOTE]
    > - The Active Directory recycle bin is available only by having the functional level of Windows 2008 R2 or later versions.
    > - For the Active Directory recycle bin to be useful in recovering an item, it must be enabled before the item is deleted.

- If the Active Directory recycle bin is unavailable, or if the object in question is no longer in the recycle bin, try to recover the deleted item by using the AdRestore tool. To do this, follow these steps:

   1. Install the [AdRestore](/sysinternals/downloads/adrestore) tool.
   2. Use AdRestore together with a search filter to locate the deleted on-premises user object. The following examples use a "UserA" string to search for usernames that match.

        1. Use AdRestore to enumerate all user objects that have a "UserA" string in their name:

            ```console
            C:\>adrestore.exe UserA
            AdRestore v1.1 by Mark Russinovich
            Sysinternals - www.sysinternals.com

            Enumerating domain deleted objects:
            cn: MailboxA
            DEL:3c45a0ae-ebc5-490d-a4b4-4b20d3e34a3f
            distinguishedName: CN=UserA\0ADEL:3c45a0ae-ebc5-490d-a4b4-4b20d3e34a3f,CN=Deleted Objects,DC=Domain,DC=com
            lastKnownParent: OU=OnPremises,DC=Domain,DC=com

            Found 1 item matching search criteria.
            ```

        2. Use AdRestore together with the **-r** switch to restore the user object.

            ```console
            C:\>adrestore.exe Usera -r
            AdRestore v1.1 by Mark Russinovich
            Sysinternals - www.sysinternals.com

            Enumerating domain deleted objects:
            cn: UserA
            DEL:3c45a0ae-ebc5-490d-a4b4-4b20d3e34a3f
            distinguishedName: CN=MailboxA\0ADEL:3c45a0ae-ebc5-490d-a4b4-4b20d3e34a3f,CN=Deleted Objects,DC=Domain,DC=com
            lastKnownParent: OU=OnPremises,DC=Domain,DC=com

            Do you want to restore this object (y/n)? y
            Restore succeeded.

            Found 1 item matching search criteria.
            ```

- **Enable the user** object in Active Directory. When the object is restored, it's disabled at first. Therefore, you have to enable it. We recommend that you first reset the user password. To enable the user, follow these steps:

    1. In Active Directory Users and Computers, right-click the user, and then select **Reset Password.**  
    1. In the **New password** and **Confirm password** boxes, enter a new password, and then select **OK**.
    1. Right-click the user, select **Enable Account**, and then select **OK**.

       :::image type="content" source="./media/restore-deleted-user-accounts/enable-account.png" alt-text="Screenshot about how to enable the account in Active Directory." border="true":::

       You receive the following error message (expected):

       > Windows cannot enable object \<MailboxName> because:
        Unable to update the password. The value provided for the new password does not meet the length, complexity, or history requirements of the domain.

       After you receive this error message, reset the user's password in Active Directory Users and Computers.

- **Configure the user logon name**

   The user logon name (also known as the user principal name, or UPN) isn't set from the restored user object. You have to update the user logon name, especially if the user is a federated account.

   To configure the user logon name, follow these steps:

   1. In Active Directory Users and Computers, right-click the user, and then select **Properties**.  
   2. Select **Account**, enter a name in the User logon name box, and then select **OK**.

   Finally, if you can't recover the deleted user account through the Active Directory recycle bin or by using the AdRestore tool, run an authoritative restore of the deleted user objects in Active Directory.

### Warnings and cautions

- Make sure that only the user objects that you want to restore are marked as authoritative. Active Directory objects that are marked as authoritative in the restore process may cause many Active Directory service issues.

    For more information about how to run an authoritative restore of Active Directory objects, see [Performing an Authoritative Restore of Active Directory Objects](/previous-versions/windows/it-pro/windows-server-2003/cc779573(v=ws.10)).

- After you restore the object by using any Resolution 3 method, the object may not have all service attributes (such as Exchange Online and Skype for Business Online) automatically restored.

    For example, for a user that was formerly mail-enabled in Exchange Online, you can use Windows PowerShell cmdlets to repopulate the Exchange Online attributes.

    In the following example, the User1 object is repopulated by using Exchange Online attributes for the *contoso.onmicrosoft.com* tenant:

    `Enable-RemoteMailbox -Identity User1 -RemoteRoutingAddress user1@contoso.mail.onmicrosoft.com`

- If the following conditions are true, Resolution 3 won't work:

    - Restoring the object by using the Active Directory recycle bin isn't an available option.
    - Restoring the object by using the AdRestore tool isn't an available option.
    - Active Directory authoritative restoring isn't an available option.

In this situation, contact Microsoft 365 Support for help.

## More information

After user deletion and before user recovery, the following events may occur and may present conflicts that can alter the user experience:

- A new user has a unique user ID value that was formerly assigned to the deleted user.
- A new user has a unique email address value that was formerly assigned to the deleted user.

If these conflicts occur, conflicting attributes must be updated to remove the conflict before user recovery can be completed. If a conflict occurs during user recovery, Windows PowerShell returns one of the following errors messages:

**Error 1**

> Restore-MsolUser : The specified user account cannot be restored because of the following error: Error Type UserPrincipalName

**Error 2**

> Restore-MsolUser : The specified user account cannot be restored because of the following error: Error Type proxyAddress

To restore users who are in this state, you can correct the conflict by using the following parameters when you run the **Restore-MSOLUser** cmdlet:

- `AutoReconcileProxyConflicts`
- `NewUserPrincipalName`

> [!NOTE]
> When you use the `AutoReconcileProxyConflicts` parameter, any conflicting email addresses are removed from the deleted user so that you can continue the recovery process.

The Microsoft 365 portal shows the equivalent error messages in the form of the Windows PowerShell "error states" that were mentioned earlier. For example, you receive the following message:

> User name conflict
> The user you want to restore has the same user name.

:::image type="content" source="./media/restore-deleted-user-accounts/user-name-conflict.png" alt-text="Screenshot that shows the user name is conflict." border="true":::

To restore users who are in this state, complete the information that is requested in the form.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](/answers/products/?WT.mc_id=msdnredirect-web-msdn) website.
