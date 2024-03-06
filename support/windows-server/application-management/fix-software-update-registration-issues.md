---
title: Fix software update registration issues
description: Provides a solution to an issue that repairs or uninstalls for certain products may fail after you install software updates.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:msi, csstroubleshoot
---
# How to fix MSI software update registration corruption issues

This article provides a solution to an issue that repairs or uninstalls for certain products may fail after you install software updates.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 971187

## Symptoms

After you install software updates, repairs or uninstalls for certain products may fail. If you have MSI logging enabled, the following lines are found in the log:

> Couldn't find local patch ''. Looking for it at its source.  
...  
MainEngineThread is returning 1612

When you look in the registry, you may find that the software update cache registration is missing from the following registry subkey:
    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\<SID>\Patches\<SQUID>`

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs.

To fix this problem, follow these steps:

1. Confirm that the product is affected.

    To do it, follow these steps:
      1. Find the software update registration of the product by opening the following registry subkey:
        `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\<SID>\Products\<ProductSQUID>\Patches`  
        Under this subkey, there will be a subkey for every software update that was applied to the product.
      2. For each subkey that is in the following format, perform the following step:
        `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\<SID>\Products\<ProductSQUID>\Patches\<PatchSQUID>`

         Verify that the following subkey exists:

         `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\<SID>\Patches\<PatchSQUID>`

         If the subkey is missing, the product is affected. Continue to step 2.

         If the subkey exists, verify that the LocalPackage string value is set correctly, and that the package referenced by the LocalPackage string value also exists.

         1. If the LocalPackage string value or referenced package is missing, the product is affected. Continue to step 2.
         2. If the referenced package exists and no additional action is required.
2. Re-create software update cache registry details. To do this, follow these steps:

    1. Search the %windir%\installer\\*.msp for the software update that you tried to install. Verify that the software update has the correct Patch Globally Unique Identifier (GUID) in the Summary Information Stream and targets the correct product GUIDs.
        > [!NOTE]
        > Because this directory serves as the cache for per-user installations and per-machine installations, you can simulate a software update in this directory by using a per-user installation.

    2. Create the following subkey:
        `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\<SID>\Patches\<PatchSQUID>`

        > [!NOTE]
        > It's a security risk to re-create the software update cache registry. However, this is the only way to repair the corruption. You can reduce the security risk by making sure that the software update is the correct software update. To do this, verify the checksum of the software update.

    3. Create a LocalPackage string value in the registry subkey that you created step 2. Make sure that the LocalPackage string value is set to the path of the software update.

3. Delete remaining software update references. To do it, follow these steps:

    1. Open the following subkey, and then remove `<PatchSQUID>` from the "AllPatches" multi-sz value:
        `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\<SID>\Products\<ProductSQUID>\Patches`

    2. Delete the following registry subkey:
        `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\<SID>\Products\<ProductSQUID>\Patches\<PatchSQUID>`

    3. Delete the following registry subkey:
        `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\<SID>\Patches\<PatchSQUID>`

        > [!NOTE]
        > If this subkey is missing, skip this step.
    4. If the product was installed per-machine, follow these steps:
        1. Open the following subkey:
            `HKEY_LOCAL_MACHINE\Software\Classes\Installer\Products\<ProductSQUID>\Patches`

            1. If the `<PatchSQUID>` string value is present, delete it.
            2. If the `<PatchSQUID>` string value is present in the "Patches" Multi-sz value, delete the `<PatchSQUID>` string value.
        2. If following registry subkey is present, delete it:
            `HKEY_LOCAL_MACHINE\Software\Classes\Installer\Patches\<PatchSQUID>`

    5. If the product was installed per-user unmanaged:

        1. Open the following registry subkey:
            `HKEY_CURRENT_USER\Software\Microsoft\Installer\Products\<ProductSQUID>\Patches`

            1. If the `<PatchSQUID>` string value is present, delete it.
            2. If the `<PatchSQUID>` from the "Patches" Multi-sz value is present, remove it.
        2. If following registry subkey is present, delete it:
            `HKEY_CURRENT_USER\Software\Microsoft\Installer\Patches\<PatchSQUID>`

    6. If the product was installed per-user managed:

        1. Open the following registry subkey:
            `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer\Managed\<SID>\Installer\Products\<ProductSQUID>\Patches`

            1. If the `<PatchSQUID>` string value is present, delete it.
            2. If the `<PatchSQUID>` from the "Patches" Multi-sz value is present, remove it.
        2. If the following registry subkey is present, delete it:
            `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer\Managed\<SID>\Installer\Patches\<PatchSQUID>`

## References

This article isn't specific for issues occurred by Windows Update or Microsoft Update.
