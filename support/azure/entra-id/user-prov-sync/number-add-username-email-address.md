---
title: Number added to user names and email addresses when users are synced to Microsoft Entra ID
description: Provides information about troubleshooting an issue in which a number is added to user names and email addresses when users are synced to Microsoft Entra ID.
ms.date: 05/11/2020
ms.reviewer: willfid
ms.service: entra-id
ms.subservice: users
---
# Number added to user names and email addresses when users are synced to Microsoft Entra ID

This article provides information about troubleshooting an issue in which a number is added to user names and email addresses when users are synced to Microsoft Entra ID. This issue occurs if there are duplicate user principal names (UPN).

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 3166795

## Symptoms

When users are synced to Microsoft Entra ID, a number is added to their UPN and SMTP proxy address. For example: `john1234@contoso.onmicrosoft.com`.

> [!NOTE]
> When users are created in Microsoft Entra ID, their user principal name (UPN) will also be used as one of the SMTP proxy addresses. Therefore, the SMTP proxy address will also contain the number.

Additionally, you may see one of the following messages:

In the Office 365 portal:

> There is an error on one or more user accounts. To see which users are affected and the detailed error message, select the "users with errors" view, and then click the user's display name.

> [DIRSYNC ERROR]: This User has been synced to your Microsoft Entra ID, but we had to modify the UserPrincipalName property from `john@contoso.com` to `john1234@contoso.onmicrosoft`.com because an existing user, `john@contoso.com`, was already created with this value.`john@contoso.com` to `john1234@contoso.onmicrosoft.com` because an existing user, `john@contoso.com`, was already created with this value.

From an email report:

> This object has been updated in your Microsoft Entra ID, but with some modified properties, because the following attributes are associated with another object [ProxyAddresses SMTP:`john@contoso.com`;].

> This object has been updated in your Microsoft Entra ID, but with some modified properties, because the following attributes are associated with another object [UserPrincipalName `john@contoso.com`;].

This issue occurs if another object has the same UPN.

## Resolution

To resolve this issue, find the users who have duplicate UPNs, and then change the UPNs so that they are unique. To do this, follow these steps.

### Step 1: Check your local directory

Use the IdFix DirSync Error Remediation Tool to identify duplicate or invalid attributes.

To resolve duplicate attributes by using the IdFix Tool, see ["Duplicate" is displayed in the ERROR column](https://support.microsoft.com/help/2857385).

For more information about the IdFix tool, go to [IdFix DirSync Error Remediation Tool](https://github.com/microsoft/idfix).

<a name='step-2-check-azure-ad'></a>

### Step 2: Check Microsoft Entra ID

You can use the Office 365 portal or the Azure Active Directory module for Windows PowerShell to check Microsoft Entra ID for duplicate attributes.

#### Method 1: Use the Office 365 portal

1. Sign in to the Office 365 [portal](https://portal.office.com) as an administrator.
2. In the Microsoft 365 admin center, go to **Users**, and then select **Active users**.

    A warning at the top of the page is displayed if there are duplicate attribute conflicts on any object in your organization.

3. Select an object to view details about the conflict. This information is displayed in the lower-right corner of the page.
4. Change the user name so that it's unique.

#### Method 2: Use the Azure AD module for Windows PowerShell

To learn more about how to use the Azure AD module for Windows PowerShell to identify objects that have duplicate values, see [Identity synchronization and duplicate attribute resiliency](/azure/active-directory/hybrid/how-to-connect-syncservice-duplicate-attribute-resiliency).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
