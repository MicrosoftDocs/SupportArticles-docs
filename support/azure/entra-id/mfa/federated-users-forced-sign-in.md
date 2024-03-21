---
title: Federated users in Microsoft Entra ID are forced to sign in frequently
description: Discusses an issue in which federated users in Microsoft Entra ID are forced to sign in frequently. Provides a resolution.
ms.date: 05/11/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: authentication
ms.custom: has-azure-ad-ps-ref
---
# Federated users in Microsoft Entra ID are forced to sign in frequently

This article discusses an issue in which federated users in Microsoft Entra ID are forced to sign in frequently.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 4025960

## Symptoms

After federated users sign in to Microsoft Entra ID, they are forced to continually sign back in instead of being kept signed in.

## Cause

Federated users who do not have the **LastPasswordChangeTimestamp** attribute synced are issued session cookies and refresh tokens that have a **Max Age** value of 12 hours. This means that the program can silently retrieve new tokens to keep the user's session alive only up to 12 hours. After that time, the users are returned to the original IdP to re-authenticate.

This occurs because Microsoft Entra ID cannot determine when to revoke tokens that are related to an old credential (such as a password that has been changed). Therefore, Microsoft Entra ID must check more frequently to make sure that the user and associated tokens are still in good standing.
For more information about token lifetimes and how they are managed, see the following Microsoft Azure article:

[Configurable token lifetimes in Microsoft Entra ID (Public Preview)](/azure/active-directory/active-directory-configurable-token-lifetimes)

## Resolution

To resolve this problem, tenant admins must make sure to sync the **LastPasswordChangeTimestamp** attribute. Syncing this attribute improves the user experience and security status.

This setting can be made on the user object by using PowerShell or through Microsoft Entra Connect.

### PowerShell

You can use the Azure AD PowerShell V1 (MSOnline) module to set the **StsRefreshTokensValidFrom** attribute for a user. This will inform the Microsoft Entra authentication flow to give the user a longer lasting Refresh Token or one based on your Microsoft Entra policies. To do this, follow these steps:

1. Download the latest Azure AD PowerShell V1 release.
2. Run the **Connect** command to sign in to your Microsoft Entra admin account every time that you start a new session:

    ```powershell
    Connect-msolservice
    ```

3. Set the **StsRefreshTokensValidFrom** attribute by using the following commands:

    ```powershell
    $RefreshTokensValidFrom = Get-Date
    Set-MsolUser -UserPrincipalName<UPN of user>-StsRefreshTokensValidFrom $RefreshTokensValidFrom
    ```

    For example:

    ```powershell
    $RefreshTokensValidFrom = Get-Date
    Set-MsolUser -UserPrincipalName john@contoso.com -StsRefreshTokensValidFrom $RefreshTokensValidFrom
    ```

    > [!NOTE]
    > StsRefreshTokenValidFromwill appear to accept any date, but it will always set to the current date and time.

4. For more help, contact [Azure Support](https://azure.microsoft.com/support/options/).

<a name='azure-ad-connect'></a>

### Microsoft Entra Connect

Microsoft Entra Connect syncs this attribute by default. However, Microsoft Entra Connect can be configured to sync or not sync this attribute either by using the [attribute filtering feature](/azure/active-directory/connect/active-directory-aadconnect-get-started-custom#azure-ad-app-and-attribute-filtering) or by disabling the out-of-box synchronization rules.

<a name='using-the-azure-ad-app-and-attribute-filtering-feature'></a>

#### Using the Microsoft Entra app and attribute filtering feature

If you have previously disabled synchronization of the **PwdLastSet** attribute by using the Microsoft Entra app and attribute filtering feature, follow these steps to re-enable the process:

#### Disabling the out-of-box synchronization rules

1. Log in to the Microsoft Entra Connect server, and then start the Microsoft Entra Connect wizard.
2. Click **Customize synchronization options task**.
3. Navigate to the **Optional Features** screen, and verify that the Microsoft Entra app and attribute filtering feature is enabled. If it isn't, this means that the feature hasn't been used to disable synchronization of the **PwdLastSet** attribute.
4. Navigate to **Microsoft Entra Attributes** screen, and enable the **PwdLastSet** attribute. If it's already enabled, this means that the feature hasn't been used to disable synchronization of the **PwdLastSet** attribute.
5. Complete the wizard, and then save the configuration.
6. Run a Full Synchronization cycle by running the following cmdlet in PowerShell:

    ```powershell
    Start-ADSyncSyncCycle -policyType initial
    ```

    > [!NOTE]
    > If the Microsoft Entra app and attribute filtering feature is disabled (see step 3) or the **PwdLastSet** attribute is already enabled (see step 4), this means that the feature hasn't been used to disable the **PwdLastSet** attribute. In this situation, you can skip steps 5 and 6.

Microsoft Entra Connect implements the synchronization of **PwdLastSet** attribute by using the following out-of-box synchronization rules.

| Out-of-box sync rule| Details|
|---|---|
|In from AD|User Common Imports on-premises AD **PwdLastSet** attribute to Metaverse **PwdLastSet** attribute.|
|Out of Microsoft Entra ID|User Join Exports Metaverse PwdLastSet<br/>attribute to the Microsoft Entra ID **LastPasswordChangeTimestamp** attribute.|
  
In the following screen shot, you can see how the attribute flow is implemented in both synchronization rules by using the Microsoft Entra Connect Synchronization Rules Editor.

:::image type="content" source="media/federated-users-forced-sign-in/synchronization-rules.png" alt-text="Screenshot of the Microsoft Entra Connect Synchronization Rules Editor.":::

Customers may disable the synchronization of **PwdLastSet** attribute by disabling these out-of-box sync rules and replacing them with custom sync rules. To enable synchronization of the **PwdLastSet** attribute, consider re-enabling these out-of-box sync rules or implementing the same attribute flow in existing custom sync rules.

For more information about how to implement and verify sync rule changes, see to article [Microsoft Entra Connect Sync: How to make a change to the default configuration](/entra/identity/hybrid/connect/how-to-connect-sync-change-the-configuration).

#### Password hash synchronization

If the Password Hash Synchronization feature is enabled on Microsoft Entra Connect, the Password Synchronization Manager synchronizes the on-premises Active Directory **PwdLastSet** attribute with the Microsoft Entra ID **LastPasswordChangeTimestamp** attribute. This is true even if the **PwdLastSet** attribute has been filtered by using the two methods in this section.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
