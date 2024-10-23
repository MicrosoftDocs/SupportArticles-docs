---
title: Group Policy settings show as Extra Registry Settings
description: Describes a registry setting that can be configured to allow the Group Policy Editor to use local Administrative Template files (ADMX/ADML) instead of the Central Store.
ms.date: 10/23/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-lianna
ms.custom: sap:Group Policy\Group Policy management (GPMC or GPedit), csstroubleshoot
---
# Group Policy settings show as Extra Registry Settings and can't be edited

_Applies to:_ &nbsp; Supported versions of Windows Server and Windows Client

This article describes a registry setting that allows you to configure the Group Policy Editor to use local Administrative Template files (ADMX/ADML) instead of the Central Store.

## ADMX/ADML file versions

You use updated ADMX/ADML files in the Central Store under the *SYSVOL* folder for Group Policy tools on a domain controller. The Group Policy Management Console (GPMC) on clients uses the ADMX/ADML files in the Central Store instead of the local folder *C:\\Windows\\PolicyDefinitions*.

In this situation, some Group Policy settings can't be configured on computers (either domain controllers or clients with Remote Server Administration Tools (RSAT) installed) that use the different versions of the ADMX/ADML files which you use for different OS versions or applications. The settings appear as **Extra Registry Settings** in the Group Policy Editor when the *PolicyDefinitions* folder doesn't have the correct versions of ADMX/ADML files. The updated ADMX/ADML files in the domain Central Store (SYSVOL) don't contain the editor data for these settings.

> [!NOTE]
> You can still update or remove the settings using the PowerShell cmdlet `Set-GPRegistryValue` or `Remove-GPRegistryValue`.

## ADMX/ADML files might not contain some settings

This issue occurs because the updated ADMX/ADML files might not contain some settings for computers that use the different versions of the ADMX/ADML files.

But you can't merge the ADMX/ADML files, because the different versions use the same file names.

## Use local ADMX/ADML files instead of the Central Store

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

There's a registry setting that allows the use of local ADMX/ADML files at *C:\\Windows\\PolicyDefinitions* instead of the Central Store for computers running the Group Policy Editor.

To use the ADMX/ADML files in the local store, manually set the following registry value to `1` under `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Group Policy`:

|Value name|Value type|Value data|
|---------|---------|---------|
|`EnableLocalStoreOverride`|`REG_DWORD`|`0` - Use the *PolicyDefinitions* folder in the *SYSVOL* folder if present (default).</br></br>`1` - Always use the local *PolicyDefinitions* folder.|

For more information, see [How to create and manage the Central Store for Group Policy Administrative Templates in Windows](../../windows-client/group-policy/create-and-manage-central-store.md).
