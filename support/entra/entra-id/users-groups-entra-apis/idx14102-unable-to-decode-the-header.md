---
title: IDX14102 Error When Using Microsoft Graph PowerShell
description: Describes an error that occurs when you run the Microsoft Graph PowerShell Connect-MgGraph cmdlet and provides solutions to it.
ms.date: 06/18/2025
ms.service: entra-id
ms.custom: sap:Problem with using the Graph SDK - libraries
ms.reviewer: adoyle, willfid, nualex, v-weizhu
---

# Microsoft Graph PowerShell throws error "IDX14102: Unable to decode the header"

This article provides solutions to an error "IDX14102: Unable to decode the header" that occurs when you use Microsoft Graph PowerShell.

## Symptoms

When running the Microsoft Graph PowerShell command `Connect-MgGraph -AccessToken $token`, you receive the following error:

> IDX14102: Unable to decode the header

## Cause

This error occurs because an invalid access token is passed to the `AccessToken` parameter of the `Connect-MgGraph` cmdlet. This problem often occurs when the token is acquired via Azure PowerShell's `Get-AzAccessToken` cmdlet and passed as a `SecureString`. This behavior is observed starting with version 5.0.0 of the `Az.Accounts` module. Starting from Microsoft Graph PowerShell version 2.28.0, the `Connect-MgGraph` command only accepts a plaint string for the `AccessToken` parameter.

## Solution

Here are two solutions for resolving this issue:

- Make sure the access token passed to the `AccessToken` parameter of the `Connect-MgGraph` cmdlet is valid.

    For more information about access tokens, see [Access tokens in the Microsoft identity platform](/entra/identity-platform/access-tokens).

- If you use the `Get-AzAccessToken` cmdlet to acquire the access token, use one of the following methods:

  - Downgrade `Az.Accounts` to version 4.2.0, to avoid the token being returned as a `SecureString`.
  - Convert the token from `SecureString` to `String`:

    ```azurepowershell
    $microsoftGraphToken = Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com"
    
    Connect-MgGraph -AccessToken (ConvertFrom-SecureString -SecureString $microsoftGraphToken.Token -AsPlainText)
    ```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]