---
title: Hash of the file does not match when running signed PowerShell script
description: This article provides resolutions for an issue where the execution of a signed PowerShell script fails with an error message.
ms.date: 05/16/2023
ms.reviewer: v-sidong
ms.author: milanmil
author: mrmilanmm
ms.custom: Fix, csstroubleshoot
audience: itpro
localization_priority: medium
---
# Hash of the file does not match when running signed PowerShell script

_Applies to:_ &nbsp; Windows PowerShell

## Symptoms

Consider the following scenario:

- You have a PowerShell script that contains special characters like ö, ä, or ü.

- You sign the script on a computer that uses a system locale (for example, en-US).

- You run the signed script on a computer that uses another system locale (for example, cs-CZ).

- The script is encoded with ASCII or UTF-8.

In this scenario, PowerShell displays the following error message:

```Output
The contents of file <FullPathForSignedPowerShellScript> might have been changed by an
unauthorized user or process because the hash of the file does not match the hash stored 
in the digital signature. The script cannot run on the specified system.
```

## Cause

When you sign the script on an en-US computer, the signing process creates the digital signature for umlaut and special characters by using the en-US code. If you run the signed script on a cs-CZ computer, the signature verification will fail because umlaut and special characters like ö, ä, and ü in ASCII or UTF-8 are encoded differently on en-US and cs-CZ computers.

The signature verification process creates a hash for PowerShell script content that doesn't include the signature. And the umlaut and special characters are interpreted differently on cs-CZ and en-US computers. In this situation, a hash mismatch will occur.

## Resolution

To make a signed PowerShell script run independently from locale settings, use one of the following methods:

- Replace or remove all umlaut and special characters like ö, ä, and ü before signing PowerShell scripts.

- Use UTF-16 LE BOM encoding for PowerShell scripts.

## More information

For an example (UTF-8 encoded script with special character "ä") that reproduces the issue, see the following steps:

1. You have a computer that has the following settings:

    ```powershell
    PS C:\Users> get-culture
    
    LCID             Name             DisplayName
    ----             ----             ----------- 
    1033             en-US            English (United States)
    
    PS C:\Users> Get-ExecutionPolicy
    
    AllSigned
    
    PS C:\Users> Get-WinSystemLocale
    
    LCID             Name             DisplayName  
    ----             ----             -----------  
    1033             en-US            English (United States)
    ```

1. On the same computer, create a PowerShell script *Install.ps1* that contains a special character "ä", and [sign the script](/powershell/module/microsoft.powershell.core/about/about_signing#sign-a-script).

    > [!NOTE]
    > When you run the signed script on the same computer, it works without problems.

1. Run the same signed script on a computer that uses another system locale. For example:

    ```powershell
    PS C:\tmp> Get-Culture
    
    LCID              Name             DisplayName
    ----              ----             -----------
    1033              en-US            English (United States)
    
    PS C:\tmp > Get-ExecutionPolicy
    
    AllSigned
    
    PS C:\tmp > Get-WinSystemLocale
    
    LCID              Name             DisplayName
    ----              ----             -----------
    1029              cs-CZ            Czech (Czech Republic)
    ```

    The script fails with the following messages:

    ```Output
    File C:\tmp\Install.ps1 cannot be loaded. The contents of file C:\tmp\Install.ps1 might have been
    changed by an unauthorized user or process, because the hash of the file does not match the hash stored in the digital
    signature. The script cannot run on the specified system. For more information, run Get-Help about_Signing..  
    At line:1 char:1  
    + .\Install.ps1  
            + ~~~~~~~~~~~~~  
            + CategoryInfo : SecurityError: (:) [], PSSecurityException  
            + FullyQualifiedErrorId : UnauthorizedAccess  
    ```

For more information about the PowerShell scripts that are encoded differently, see:

||ASCII encoded PowerShell script|UTF-8 encoded PowerShell script|UTF-16 BE BOM encoded PowerShell script|UTF-16 LE BOM encoded PowerShell script|
|-|-|-|-|-|
|**Windows 10**|Affected with HASH mismatch issue|Affected with HASH mismatch issue|n/a (Set-AuthenticodeSignature fails with UnknownError)|NOT affected with HASH mismatch issue|
|**Windows 11**|Affected with HASH mismatch issue|Affected with HASH mismatch issue|n/a (Set-AuthenticodeSignature fails with UnknownError)|NOT affected with HASH mismatch issue|
|**Windows Server 2019**|Affected with HASH mismatch issue|Affected with HASH mismatch issue|n/a (Set-AuthenticodeSignature fails with UnknownError)|NOT affected with HASH mismatch issue|
|**Windows Server 2022**|Affected with HASH mismatch issue|Affected with HASH mismatch issue|n/a (Set-AuthenticodeSignature fails with UnknownError)|NOT affected with HASH mismatch issue|

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#powershell).
