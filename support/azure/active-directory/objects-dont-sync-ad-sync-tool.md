---
title: One or more objects don't sync when the Azure Active Directory Sync tool is used
description: Describes an issue in which one or more AD DS object attributes don't sync to Microsoft Entra ID through the Azure Active Directory Sync tool. Provides resolutions.
ms.date: 03/12/2024
ms.reviewer: 
ms.service: entra-id
ms.subservice: users
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---
# One or more objects don't sync when using Azure Active Directory Sync tool

This article resolves an issue that one or more Active Directory Domain Services (AD DS) object attributes don't sync to Microsoft Entra ID through the Azure Active Directory Sync tool.

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2643629

[!INCLUDE [Feedback](../../includes/feedback.md)]

## Symptoms

One or more AD DS objects or attributes don't sync to Microsoft Entra ID as expected. When Active Directory synchronization runs, an object doesn't sync, and you experience one of the following symptoms:

- You receive an error message that states that an attribute has a duplicate value.
- You receive an error message that states that one or more attributes violate formatting requirements such as character set or character length.
- You don't receive an error message, and directory synchronization seems to be completed. However, some objects or attributes aren't updated as expected.

Some examples of the error message that you may receive:
> A synchronized object with the same proxy address already exists in your Microsoft Online Services directory.

> Unable to update this object because the user ID is not found.

> Unable to update this object in Microsoft Online Services because the following attributes associated with this object have values that may already be associated with another object in your local directory.

## Cause

This issue occurs for one of the following reasons:

- The domain value that's used by AD DS attributes hasn't been verified.
- One or more object attributes that require a unique value have a duplicate attribute value (such as the proxyAddresses attribute or the U serPrincipalName attribute) in an existing user account.
- One or more object attributes violate formatting requirements that restrict the characters and the character length of attribute values.
- One or more object attributes match exclusion rules for directory synchronization.

    The following table shows the default sync scoping rules:

    |Object type|Attribute name|Condition of attribute when synchronization fails|
    |---|---|---|
    |Contact|DisplayName|Contains "MSOL"|
    ||msExchHideFromAddressLists|Is set to "True"|
    |Security-enabled group|isCriticalSystemObject|Is set to "True"|
    |Mail-enabled groups<br/>(security group or distribution list)|proxyAddresses<br/><br/>and<br/><br/>mail|Has no "SMTP:" address entry<br/><br/>and<br/><br/>is not present|
    |Mail-enabled contacts|proxyAddresses<br/><br/>and<br/><br/>mail|Has no "SMTP:" address entry<br/><br/>and<br/><br/>is not present|
    |iNetOrgPerson|sAMAccountName|Is not present|
    ||isCriticalSystemObject|Is present|
    |User|mailNickName|Starts with "SystemMailbox"|
    ||mailNickName|Starts with "CAS_"<br/><br/>and<br/><br/>contains "}"|
    ||sAMAccountName|Starts with "CAS_"<br/><br/>and<br/><br/>contains "}"|
    ||sAMAccountName|Equals "SUPPORT_388945a0"|
    ||sAMAccountName|Equals "MSOL_AD_Sync"|
    ||sAMAccountName|Is not present|
    ||isCriticalSystemObject|Is set to "True"|

- The user principal name (UPN) was changed after the initial synchronization and must be updated manually.
- Exchange Online Simple Mail Transfer Protocol (SMTP) addresses of synced users aren't populated appropriately in the on-premises Active Directory schema.

## Resolution

To resolve this issue, use one of the following methods, as appropriate for your situation.

### Run IdFix to check for duplicates, missing attributes, and rule violations

Use the [IdFix DirSync Error Remediation Tool](https://github.com/microsoft/idfix) to find objects and errors that prevent synchronization to Microsoft Entra ID.

- If you see "Blank" in the **ERROR** column after you run IdFix, the displayName attribute of the object isn't defined. To resolve this issue, specify a value for the displayName attribute of the object using these steps:

1. In the UPDATE column for the object, type the name of its displayName attribute.
2. In the ACTION column, click EDIT, and then click Apply.
3. Repeat steps 1 and 2 for each object that has a "blank" entry in the ERROR column.
4. Run IdFix again to look for more object errors.

- If you see "Duplicate" in the **ERROR** column after you run IdFix, two or more objects have the same email address. To resolve this problem, specify a unique email address for the object using these steps:

1. In the UPDATE column for the object, type an email address that isn't already used.
2. In the ACTION column, click EDIT, and then click Apply.
3. Run IdFix again to look for more object errors.

<a name='determine-attribute-conflicts-that-are-caused-by-objects-that-werent-created-in-azure-ad-through-directory-synchronization'></a>

### Determine attribute conflicts that are caused by objects that weren't created in Microsoft Entra ID through directory synchronization

To determine attribute conflicts caused by user objects that were created by using management tools (and that weren't created in Microsoft Entra ID through directory synchronization), follow these steps:

1. Determine the unique attributes of the on-premises AD DS user account. To do it, on a computer that has Windows Support Tools installed, follow these steps:

   1. Select **Start**, select **Run**, type ldp.exe, and then select **OK**.
   2. Select **Connection**, select **Connect**, type the computer name of an AD DS domain controller, and then select **OK**.
   3. Select **Connection**, select **Bind**, and then select **OK**.
   4. Select **View**, select **Tree View**, select the AD DS domain in the **BaseDN** drop-down list, and then select **OK**.
   5. In the navigation pane, locate and then double-click the object that isn't syncing correctly. The Details pane on the right side of the window lists all object attributes. The following example shows the object attributes:

        :::image type="content" source="media/objects-dont-sync-ad-sync-tool/object-attributes.png" alt-text="Screenshot of navigation and details pane of the Windows Support Tools that listed all object attributes.":::

   6. Record the values of the userPrincipalName attribute and each SMTP address in the multivalue proxyAddresses attribute. You'll need these values later.

        |Attribute name|Example|Notes|
        |---|---|---|
        |proxyAddresses|proxyAddresses (3): x500:/o=Exchange/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Recipients/cn=1ae75fca0d3a4303802cea9ca50fcd4f-7628376; smtp:`7628376@service.contoso.com`; SMTP:`7628376@contoso.com`;|<br/> 1. The number that's displayed in parentheses next to the attribute label indicates the number of proxy address values in the multivalue attribute.<br/><br/> 2. Each distinct proxy address value is indicated by a semicolon (;).<br/><br/>3. The primary SMTP proxy address value is indicated by uppercase "SMTP:"|
        |userPrincipalName|`7628376@contoso.com`||

        > [!NOTE]
        > Ldp.exe is included in Windows Server 2008 and in the Windows Server 2003 Support Tools. The Windows Server 2003 Support Tools are included in the Windows Server 2003 installation media. Or, to obtain the Support Tools, go to the following Microsoft website: [Windows Server 2003 Service Pack 2 32-bit Support Tools](https://go.microsoft.com/fwlink/?linkid=100114)

2. Connect to Microsoft Entra ID by using the Azure Active Directory module for Windows PowerShell. For more info, go to [Manage Microsoft Entra ID using Windows PowerShell](/previous-versions/azure/jj151815(v=azure.100)?redirectedfrom=MSDN).

    Leave the console window open. You'll need to use it in the next step.
3. Check for the duplicate userPrincipalName attributes.

    In the console connection that you opened in step 2, type the following commands in the order in which they are presented. Press Enter after each command:

    ```powershell
    $userUPN = "<search UPN>"
    ```

    > [!NOTE]
    > In this command, the placeholder "\<search UPN>" represents the UserPrincipalName attribute that you recorded in step 1f.

    ```powershell
    Get-MSOLUser -UserPrincipalName $userUPN | where {$_.LastDirSyncTime -eq $null}
    ```

    [!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

    Leave the console window open. You'll use it again in the next step.
4. Check for duplicate proxyAddresses attributes. In the console connection that you opened in step 2, run the following command:

    ```powershell
    Import-Module ExchangeOnlineManagement
    ```

5. For each proxy address entry that you recorded in step 1f, type the following commands in the order in which they are presented. Press Enter after each command:

    ```powershell
    $proxyAddress = "<search proxyAddress>"
    ```

    > [!NOTE]
    > In this command, the placeholder "\<search proxyAddress>" represents the value of a proxyAddresses attribute that you recorded in step 1f.

    ```powershell
    Get-EXOMailbox | where {[string] $str = ($_.EmailAddresses); $str.tolower().Contains($proxyAddress.tolower()) -eq $true} | foreach {get-MSOLUser -UserPrincipalName $_.MicrosoftOnlineServicesID | where {($_.LastDirSyncTime -eq $null)}}
    ```

Items that are returned after you run the commands in step 3 and 4 represent user objects that weren't created through directory synchronization and that have attributes that conflict with the object that isn't syncing correctly.

### Update AD DS attributes to remove duplicates, rules violations, and scoping exclusions

Identify the specific attributes that are preventing synchronization based on the following information:

- Administrative email messages
- The report from the output of the Office 365 Deployment Readiness Tool
- Default directory synchronization scoping rules and custom rules

After a specific attribute value is identified, edit the attribute value using one of these methods:

- Use the Active Directory Users and Computers tool to edit the attribute value.

1. Open Active Directory Users and Computers, and then select the root node of the AD DS domain.
2. Select **View,** and then make sure that the **Advanced Features** option is selected.
3. In the left navigation pane, locate the user object, right-click it, and then select **Properties**.
4. On the **Object Editor** tab, locate the attribute that you want. Select **Edit**, and then edit the attribute value to the value that you want.
5. Select **OK** two times.

- Use Active Directory Service Interfaces (ADSI) Edit to update object attributes in AD DS.
You can download and install ADSI Edit as a part of the Windows Server Toolkit. To use ADSI Edit to edit attributes, follow these steps.

> [!WARNING]
> This procedure requires ADSI Edit. Using ADSI Edit incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems that result from the incorrect use of ADSI Edit can be resolved. Use ADSI Edit at your own risk.

1. Select **Start**, select **Run**, type ADSIEdit.msc, and then select **OK**.
2. Right-click **ADSI Edit** in the navigation pane, select **Connect to**, and then select **OK** to load the domain partition.
3. Locate the user object, right-click it, and then select **Properties**.
4. In the **Attributes** list, locate the attribute that you want. Select **Edit**, and then edit the attribute value to the value that you want.
5. Select **OK** two times, and then exit ADSI Edit.

### Create a new group and add it to the built-in group that's not being synced

To resolve the issue in the scenario that some built-in groups (such as the Domain Users group) aren't synced, create a new group that contains all the applicable members and appropriate permissions of the built-in group. Then, add that group as a member to the built-in group that's not synced. Use the new group instead of the built-in group to manage members. By using this method, you still manage only one group.

You don't want to change the attributes of the built-in group or change the scoping rules of the identity sync appliance to allow critical system objects to be synced. It may trigger other unexpected behavior.

### Use SMTP matching to cause an on-premises user object to sync to an existing user object

For more information, see [How to use SMTP matching to match on-premises user accounts to Office 365 user accounts for directory synchronization](https://support.microsoft.com/help/2641663).

### Manually update a user account UPN

To update a user account UPN that was licensed after initial directory synchronization has occurred, follow these steps:

1. Install Azure Active Directory v2 PowerShell Module. For more information, see [Azure Active Directory v2 PowerShell Module](https://www.powershellgallery.com/packages/AzureAD/2.0.0.71).
2. Run the following cmdlets at the Azure Active Directory v2 PowerShell prompt:

    ```powershell
    $cred = get-credential
    ```

    > [!NOTE]
    > When you're prompted, enter your admin credentials.

    ```powershell
    Connect-AzureAD
    ```

    ```powershell
    Set-AzureADUser -ObjectId [CurrentUPN] -UserPrincipalName [NewUPN]
    ```

### Update user SMTP addresses by using on-premises Active Directory attributes

When SMTP attributes aren't synced to Exchange Online in an expected way, you may have to update the on-premises Active Directory attributes. To update on-premises Active Directory attributes so that the correct email address displays in Exchange Online, use Resolution 2 to manipulate the attributes in the following table.

|On-premises Active Directory attribute name|Example On-premises Active Directory attribute value|Example Exchange Online email addresses|
|---|---|---|
|proxyAddresses|SMTP:`user1@contoso.com`|Primary SMTP: `user1@contoso.com`<br/>Secondary SMTP: `user1@contoso.onmicrosoft.com`|
|proxyAddresses|smtp:`user1@contoso.com`|Primary SMTP: `user1@contoso.onmicrosoft.com` Secondary SMTP: `user1@contoso.com`|
|proxyAddresses|SMTP:`user1@contoso.com`<br/>smtp:`user1@sub.contoso.com`|Primary SMTP: `user1@contoso.com`<br/>Secondary SMTP: `user1@sub.contoso.com`<br/>Secondary SMTP: `user1@contoso.onmicrosoft.com`|
|mail|`User1@contoso.com`|Primary SMTP: `user1@contoso.com`<br/>Secondary SMTP: `user1@contoso.onmicrosoft.com`|
|UserPrincipalName|`User1@contoso.com`|Primary SMTP: `user1@contoso.com`<br/>Secondary SMTP: `user1@contoso.onmicrosoft.com`|
  
  The Microsoft Online Email Routing Address (MOERA) entry that's associated with the default domain (such as `user1@contoso.onmicrosoft.com`) is an interpreted value that's based on a user account's alias. This specialty email address is inextricably linked to each Exchange Online recipient. You can't manage, delete, or create additional MOERA addresses for any recipient. However, the MOERA address can be over-ridden as the primary SMTP address by using the attributes in the on-premises Active Directory user object.

> [!NOTE]
> The presence of data in the proxyAddresses attribute completely masks data in the mail attribute for Exchange Online email address population.

> [!NOTE]
> The presence of data in the proxyAddresses attribute, the mail attribute, or both attributes completely mask UserPrincipalName data for Exchange Online email address population. The UPN can be used to manage email addresses. However, an admin can decide to manage the email address and UPN separately by populating proxyAddresses or mail attributes.

We highly recommend that one of these attributes is used consistently to manage Exchange Online email addresses for synced users.

## More information

The Windows PowerShell commands that are mentioned in this article require the Azure Active Directory module for Windows PowerShell. For more information about the Azure Active Directory module for Windows PowerShell, see the following article:  
[Manage Microsoft Entra ID using Windows PowerShell](/previous-versions/azure/jj151815(v=azure.100)?redirectedfrom=MSDN).

For more information about filtering directory synchronization by attributes, see the following Microsoft TechNet wiki article:  
[List of Attributes that are Synced by the Azure Active Directory Sync Tool](/archive/technet-wiki/19901.dirsync-list-of-attributes-that-are-synced-by-the-azure-active-directory-sync-tool)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
