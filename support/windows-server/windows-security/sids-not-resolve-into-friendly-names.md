---
title: Some SIDs do not resolve into friendly names
description: Some security identifiers that you see in access control lists or Security Audit reports do not resolve into friendly names. These may be capability SIDs.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tea, v-jesits, johnbay
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---
# Some SIDs do not resolve into friendly names

This article provides some information about the issue where some security identifiers (SIDS) do not resolve into friendly names.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 4502539

## Symptoms

In some places in the Windows UI, you see Windows account security identifiers (SIDS) that do not resolve to friendly names. These places include the following:

- File Explorer
- Security Audit reports
- The access control list (ACL) editor in Registry Editor, as shown in the following examples:

    :::image type="content" source="media/sids-not-resolve-into-friendly-names/permissions-for-classes.png" alt-text="Screenshot of the Permissions for Classes window which shows that the SID dose not resolve to a friendly name.":::
    :::image type="content" source="media/sids-not-resolve-into-friendly-names/advanced-security-settings-for-classes.png" alt-text="Screenshot of the Advanced Security Settings for Classes window which shows that the SID dose not resolve to a friendly name.":::

## Cause

Windows Server 2012 and Windows 8 introduced a type of SID that is known as a capability SID. By design, a capability SID does not resolve to a friendly name.

Capability SIDs uniquely and immutably identify capabilities. In this context, a capability is an unforgeable token of authority that grants a Windows component or a Universal Windows Application access to resources such as documents, cameras, locations, and so forth. An application that "has" a capability is granted access to the resource that is associated with the capability. An application that "does not have" a capability is denied access to the associated resource.

The most commonly used capability SID is the following:  
S-1-15-3-1024-1065365936-1281604716-3511738428-1654721687-432734479-3232135806-4053264122-3456934681

Windows 10, version 1809 uses more than 300 capability SIDs.

## More information

> [!Important]
> DO NOT DELETE capability SIDS from either the Registry or file system permissions. Removing a capability SID from file system permissions or registry permissions may cause a feature or application to function incorrectly. After you remove a capability SID, you cannot use the UI to add it back.

When you are troubleshooting an unresolved SID, make sure that it is not a capability SID. To get a list of all of the capability SIDs that Windows has a record of, follow these steps:

1. Select **Start** > **Run**, and then enter *regedt32.exe*.
2. Navigate to the following registry entry: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SecurityManager\CapabilityClasses\AllCachedCapabilities`.

3. Copy the value data and paste it into a text file (or a similar location where you can search the data).
    > [!Note]
    > This value may not include all capability SIDs that third-party applications use.

4. Search the data for the SID that you are troubleshooting.

   - If you find the SID in the registry data, then it is a capability SID. By design, it will not resolve into a friendly name.
   - If you do not find the SID in the registry data, then it is not a known capability SID. You can continue to troubleshoot it as a normal unresolved SID. Keep in mind that there is a small chance that the SID could be a third-party capability SID, in which case it will not resolve into a friendly name.
