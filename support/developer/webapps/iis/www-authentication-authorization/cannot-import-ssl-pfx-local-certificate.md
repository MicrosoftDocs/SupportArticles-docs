---
title: Can't import SSL private key certificate
description: An error may occur when you try to import an SSL private key certificate (.pfx) file into the local computer personal certificate store by using Internet Information Services (IIS) Manager.
ms.date: 03/26/2020
ms.custom: sap:WWW authentication and authorization
ms.reviewer: v-jomcc
ms.technology: www-authentication-authorization
---
# Error when you import an SSL .pfx file into the local computer personal certificate store by using IIS Manager

This article helps you resolve an error that occurs when you try to import a Secure Sockets Layer (SSL) private key certificate (.pfx) file into the local computer personal certificate store by using Microsoft Internet Information Services (IIS) Manager.

_Original product version:_ &nbsp;  Internet Information Services  
_Original KB number:_ &nbsp; 919074

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

## Symptoms

You try to import an SSL .pfx file into the local computer personal certificate store. In this situation, you may experience one of the following symptoms, depending on how you try to import the .pfx file:

- If you try to import the .pfx file by using IIS Manager, you receive the following error message:

    > Cannot import pfx file. Either you entered wrong password for this file or the certificate has expired.

- If you try to import the .pfx file by using the Certificates Microsoft Management Console (MMC) snap-in, you receive the following error message:

    > An internal error occurred. This can be either the user profile is not accessible or the private key that you are importing might require a cryptographic service provider that is not installed on your system.

## Cause

This behavior occurs when one or more of the following conditions are true:

- You have insufficient permissions to access the `DriveLetter:\Documents and Settings\All Users\Application Data\Microsoft\Crypto\RSA\MachineKeys` folder on the computer.
- A third-party registry sub key exists that prevents IIS from accessing the cryptographic service provider.
- You're logged on to the computer remotely through a Terminal Services session. And the user profile isn't stored locally on the server that has Terminal Services enabled.

To resolve this behavior, use one of the following resolutions, as appropriate for your situation.

## Resolution 1: Set correct permissions for the MachineKeys folder

If you have insufficient permissions to access the `DriveLetter:\Documents and Settings\All Users\Application Data\Microsoft\Crypto\RSA\MachineKeys` folder on the computer, set the correct permissions for the folder.

For more information about how to set the permissions for the MachineKeys folder, see [Default permissions for the MachineKeys folders](https://support.microsoft.com/help/278381).

## Resolution 2: Delete the third-party registry sub key

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

If the following registry subkey exists, delete it:  
`HKEY_USERS\Default\Software\Microsoft\Cryptography\Providers\Type 001`

After you delete this registry sub key, IIS can access the cryptographic service provider.

## Resolution 3: Store the user profile for Terminal Services session locally

If the user profile for the Terminal Services session isn't stored locally on the server that has Terminal Services enabled, move the user profile to the server that has Terminal Services enabled. Alternatively, use roaming profiles.

## Status

This behavior is by design.
