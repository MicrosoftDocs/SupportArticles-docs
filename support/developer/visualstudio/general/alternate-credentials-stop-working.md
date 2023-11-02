---
title: Alternate credentials don't working
description: This article discusses a problem in which alternate credentials stop working for existing Visual Studio Online account users after you connect to Microsoft Entra ID.
ms.date: 04/22/2020
ms.reviewer: acabello, daleche
---
# Alternate credentials stop working for existing Visual Studio Online account users

This article helps you resolve a problem where alternate credentials don't work for existing Visual Studio Online account users that are connected to Microsoft Entra ID.

_Original product version:_ &nbsp; Azure DevOps Services Premium  
_Original KB number:_ &nbsp; 2991274

## Symptoms

Assume that you have applications or tools that work outside the browser (including Team Explorer Everywhere command-line client and the git-tf utility) that requires basic authentication credentials to connect to your Visual Studio Online accounts. When an existing Visual Studio Online account is connected to Microsoft Entra ID, alternate credentials stop working for that account.

For Microsoft accounts, the same alternate credentials can be used to access all your Visual Studio Online accounts.

For organizational accounts, alternate credentials are scoped to Microsoft Entra ID. And alternate credentials can be used to access Visual Studio Online accounts that are connected to that directory.

## Workaround

To work around the issue, reset your alternate credentials for that account to resume access for your applications or tools. Follow these steps:

1. By using a web browser; sign in to the Visual Studio Online account that was connected to Microsoft Entra ID, or the account for which your alternate credentials stop working by typing its address:  
    `https://<youraccountname>.visualstudio.com`

2. Open your profile.

    :::image type="content" source="./media/alternate-credentials-stop-working/my-profile.png" alt-text="Screenshot shows My profile menu under name.":::

3. Enable alternate credentials for this account.

    :::image type="content" source="./media/alternate-credentials-stop-working/enable-alternate-credentials.png" alt-text="Screenshot of the User profile page. Under credentials tab, there's an Enable alternate credentials link option.":::

4. Set a password and optionally a secondary user name that isn't an email account if @ is not supported by your application.

    :::image type="content" source="./media/alternate-credentials-stop-working/set-password.png" alt-text="In the User profile page, you can set password and a secondary user name.":::

> [!NOTE]
> If you are member of multiple Visual Studio Online accounts, you will have one set of alternate credentials that can be used to access all your Visual Studio Online accounts associated with your Microsoft Account, and another set for all the accounts connected to each Microsoft Entra directory.

## References

For more information, see [Visual Studio Online](https://www.visualstudio.com/).
