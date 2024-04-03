---
title: Users in a federated domain see a yellow exclamation mark in Office 2013 apps
description: Describes an issue in which users in a federated domain who aren't synced to Microsoft Entra ID see a yellow exclamation mark in Office 2013 apps. Provides solutions.
ms.date: 05/28/2020
ms.reviewer: adrianp, willfid
ms.service: entra-id
ms.subservice: users
---
# Users in a federated domain see a yellow exclamation mark in Office 2013 applications

This article describes an issue in which users in a federated domain who aren't synced to Microsoft Entra ID see a yellow exclamation mark in Office 2013 applications.

_Original product version:_ &nbsp; Microsoft Entra ID, Office Professional 2013, Office Standard 2013  
_Original KB number:_ &nbsp; 3158020

## Symptoms

When a user who is in a federated domain but isn't synchronized to Microsoft Entra ID opens an Office 2013 application, they see a yellow exclamation mark.

## Cause

By default, Office 2013 uses the Microsoft Online Services Sign-in Assistant (also known as IDCRL). IDCRL detects that the user's domain is federated and therefore tries to authenticate the user to Microsoft Entra ID. Because the user isn't synced to Microsoft Entra ID, the user doesn't exist in Microsoft Entra ID, and this triggers the yellow exclamation mark in the Office 2013 application.

## Resolution

Do one of the following.

### Set the SignInOptions registry key value to 3

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

> [!NOTE]
> Use this procedure for only those users who aren't synced to Microsoft Entra ID. Using this procedure for synced users may cause those users to experience sign-in failures.

To resolve this issue for only those users who aren't synced to Microsoft Entra ID, follow these steps:

1. Select **Start**, select **Run**, type **regedit**, and then select **OK**.
2. Locate the following registry subkey: `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\SignIn\`.
3. Right-click the **SignInOptions** registry key, select **Modify**, type **3** in the **Value data** box, and then select **OK**.
4. Exit Registry Editor. Set the **SignInOptions** registry key to **3** forces Office 2013 to authenticate only against the user's local Active Directory service instead of trying to sign the user in to Microsoft Entra ID.

### Use Office 2016

The yellow exclamation mark isn't displayed in Office 2016 applications.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
