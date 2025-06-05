---
title: Can't see list of users/groups to add permissions in IAM in Azure portal
description: Resolves an issue in which you can't see list of users or groups when adding permissions in Access Control (IAM) in the Azure portal.
ms.date: 06/05/2025
ms.service: azure-common-issues-support
ms.custom: no-azure-ad-ps-ref
ms.author: genli
author: genlin
ms.reviewer: 
---
# Can't see list of users or groups when adding permissions in Access Control in the Azure portal

This article provides information to an issue in which you can't see list of users or groups when adding permissions in Access Control (IAM) in the Azure portal.

_Original product version:_ &nbsp; Azure  
_Original KB number:_ &nbsp; 4229970

## Symptoms

When you try to add permissions in IAM in the [Azure portal](https://portal.azure.com), you cannot see the list of users or groups.

## Cause

This issue occurs because the account that you used to sign in to Azure portal does not have enumeration permission. This account might be a guest user who has been invited to the directory that you are trying to give access to other Azure resources. Even if this guest user is a global administrator, they still will not have enumeration permission.

## Resolution

To resolve this issue, use one of the following methods:

### Method 1: To allow all guest users enumeration privileges

1. Sign in to the Azure portal by using Global Administrator.
2. If applicable, switch to the directory where the guest user was added.
3. Go to **Microsoft Entra ID**.
4. Go to **User Settings**.
5. Change the **Guest users permissions are limited**  setting to **No**, and then select **Save**.

### Method 2: To allow only the one guest user or configure on a per user basis

1. Make sure that the [Microsoft Graph PowerShell is installed](/powershell/microsoftgraph/installation).
1. Use the `Connect-MgGraph` command to sign in with the required scopes. For more information, see [Get started with the Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/get-started).
1. Run the [Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser) cmdlet:

    ```powershell
   Update-MgUser -UserId '0ba17ca9-0000-0000-0000-a5e34bc4803b' -UserType Member
    ```
    You can get the users Object ID by looking at the Users Profile page within the Azure portal.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
