---
title: Federated users in Azure AD are forced to sign in frequently
description: Discusses an issue in which federated users in Azure AD are forced to sign in frequently. Provides a resolution.
ms.date: 05/11/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: authentication
---
# Federated users in Azure AD are forced to sign in frequently

This article discusses an issue in which federated users in Azure AD are forced to sign in frequently.

_Original product version:_ &nbsp; Azure Active Directory  
_Original KB number:_ &nbsp; 4025960

## Symptoms

After federated users sign in to Azure Active Directory (Azure AD), they are forced to continually sign back in instead of being kept signed in.

## Cause

Federated users who do not have the **LastPasswordChangeTimestamp** attribute synced are issued session cookies and refresh tokens that have a **Max Age**  value of 12 hours. This means that the program can silently retrieve new tokens to keep the user's session alive only up to 12 hours. After that time, the users are returned to the original IdP to re-authenticate.

This occurs because Azure AD cannot determine when to revoke tokens that are related to an old credential (such as a password that has been changed). Therefore, Azure AD must check more frequently to make sure that the user and associated tokens are still in good standing.
For more information about token lifetimes and how they are managed, see the following Microsoft Azure article:

[Configurable token lifetimes in Azure Active Directory (Public Preview)](/azure/active-directory/active-directory-configurable-token-lifetimes)

## Resolution

To resolve this problem, tenant admins must make sure to sync the **LastPasswordChangeTimestamp**  attribute. Syncing this attribute improves the user experience and security status.

This setting can be made on the user object by using PowerShell or through Azure AD Connect.

### PowerShell

You can use the Azure AD PowerShell V1 (MSOnline) module to set the **StsRefreshTokensValidFrom** attribute for a user. This will inform the Azure Active Directory authentication flow to give the user a longer lasting Refresh Token or one based on your Azure Active Directory policies. To do this, follow these steps:

1. Download the latest Azure AD PowerShell V1 release.
2. Run the **Connect** command to sign in to your Azure AD admin account every time that you start a new session:

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
    > StsRefreshTokenValidFromwill appear to accept any date, but it will always set to the current date and time.

4. For more help, contact [Azure Support](https://azure.microsoft.com/support/options/).

### Azure AD Connect

Azure AD Connect syncs this attribute by default. However, Azure AD Connect can be configured to sync or not sync this attribute either by using the [attribute filtering feature](/azure/active-directory/connect/active-directory-aadconnect-get-started-custom#azure-ad-app-and-attribute-filtering) or by disabling the out-of-box synchronization rules.

#### Using the Azure AD app and attribute filtering feature

If you have previously disabled synchronization of the **PwdLastSet** attribute by using the Azure AD app and attribute filtering feature, follow these steps to re-enable the process:

#### Disabling the out-of-box synchronization rules

1. Log in to the Azure AD Connect server, and then start the Azure AD Connect wizard.
2. Click **Customize synchronization options task**.
3. Navigate to the **Optional Features** screen, and verify that the Azure AD app and attribute filtering feature is enabled. If it isn't, this means that the feature hasn't been used to disable synchronization of the **PwdLastSet** attribute.
4. Navigate to **Azure AD Attributes** screen, and enable the **PwdLastSet** attribute. If it's already enabled, this means that the feature hasn't been used to disable synchronization of the **PwdLastSet** attribute.
5. Complete the wizard, and then save the configuration.
6. Run a Full Synchronization cycle by running the following cmdlet in PowerShell:

    ```powershell
    Start-ADSyncSyncCycle -policyType initial
    ```

    > [!NOTE]
    > If the Azure AD app and attribute filtering feature is disabled (see step 3) or the **PwdLastSet** attribute is already enabled (see step 4), this means that the feature hasn't been used to disable the **PwdLastSet** attribute. In this situation, you can skip steps 5 and 6.

Azure AD Connect implements the synchronization of **PwdLastSet** attribute by using the following out-of-box synchronization rules.

| Out-of-box sync rule| Details|
|---|---|
|In from AD|User Common Imports on-premises AD **PwdLastSet** attribute to Metaverse **PwdLastSet** attribute.|
|Out of Azure AD|User Join Exports Metaverse PwdLastSet<br/>attribute to **Azure AD LastPasswordChangeTimestamp** attribute.|
  
In the following screen shot, you can see how the attribute flow is implemented in both synchronization rules by using the Azure AD Connect Synchronization Rules Editor.

:::image type="content" source="media/federated-users-forced-sign-in/synchronization-rules.png" alt-text="Screenshot of the Azure AD Connect Synchronization Rules Editor.":::

Customers may disable the synchronization of **PwdLastSet** attribute by disabling these out-of-box sync rules and replacing them with custom sync rules. To enable synchronization of the **PwdLastSet** attribute, consider re-enabling these out-of-box sync rules or implementing the same attribute flow in existing custom sync rules.

For more information about how to implement and verify sync rule changes, see  to article Azure AD Connect sync: How to make a change to the default configuration.

#### Password hash synchronization

If the Password Hash Synchronization feature is enabled on Azure AD Connect, the Password Synchronization Manager synchronizes the on-premises Active Directory **PwdLastSet** attribute with the Azure AD **LastPasswordChangeTimestamp** attribute. This is true even if the **PwdLastSet** attribute has been filtered by using the two methods in this section.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
