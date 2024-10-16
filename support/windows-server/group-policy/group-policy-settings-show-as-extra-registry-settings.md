---
title: Group Policy settings show as Extra Registry Settings
description: Describes a registry setting that can be configured to allow the Group Policy Editor to use local Administrative Template files (ADMX/ADML) instead of the Central Store.
ms.date: 10/16/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm
ms.custom: sap:Group Policy\Group Policy management (GPMC or GPedit), csstroubleshoot
---
# Group Policy settings show as Extra Registry Settings and can't be configured

_Applies to:_ &nbsp; Supported versions of Windows Server and Windows Client

This article describes a registry setting that allows you to configure the Group Policy Editor to use local Administrative Template files (ADMX/ADML) instead of the Central Store.

You use updated ADMX/ADML files in the Central Store under the *SYSVOL* folder for Group Policy tools on a domain controller. The Group Policy Management Console (GPMC) on clients uses the ADMX/ADML files in the Central Store instead of the local store.

In this situation, some Group Policy settings can't be configured for computers that using the previous versions of the ADMX/ADML files. The settings appear as **Extra Registry Settings** in the Group Policy editor. The updated ADMX/ADML files in the domain Central Store (SYSVOL) don't contain the editor metadata for these settings.

> [!NOTE]
> Settings that are made prior to the upgrade of the Central Store apply to the clients, but can't be edited anymore.

## The updated ADMX/ADML files might not contain some settings

This issue occurs because the updated ADMX/ADML files might not contain some settings for computers that using the previous versions of the ADMX/ADML files.

## Use local ADMX/ADML files instead of the Central Store

There's a registry setting for the computers running the Group Policy editor that allows to use the local ADMX/ADML files instead of the Central Store.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

You can manually enable the use of local ADMX/ADML files. You need to configure on the computer executing the Group Policy editor, which is either a domain controller or a client that has Remote Server Administration Tools (RSAT) installed.

To use the ADMX/ADML files from the local store instead of the Central Store, set the following registry value to `1`:

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Group Policy`

|Value name|Value type|Value data|
|---------|---------|---------|
|`EnableLocalStoreOverride`|`REG_DWORD`|`0` - Use the *PolicyDefinitions* folder in the *SYSVOL* folder if present (default).</br></br>`1` - Use the local *PolicyDefinitions* folder always.|

For more information, see [How to create and manage the Central Store for Group Policy Administrative Templates in Windows](../../windows-client/group-policy/create-and-manage-central-store.md)
