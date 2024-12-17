---
title: Some SIDs don't resolve into friendly names
description: Some security identifiers that you see in access control lists or Security Audit reports don't resolve into friendly names. These might be Capability SIDs.
ms.date: 11/11/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tea, v-jesits, johnbay, jessev
ms.custom: sap:Windows Security Technologies\AD Object Permissions, access control, delegation, AdminSDHolder and auditing, csstroubleshoot
searchScope:
- Troubleshoot
- Windows Server
- Windows
---
# Some SIDs don't resolve into friendly names

This article provides some information about the issue where some security identifiers (SIDS) don't resolve into friendly names.

_Original KB number:_ &nbsp; 4502539

## Symptoms

In some places in the Windows User Interface, you might see Windows account Security Identifiers (SIDs) that don't resolve to friendly names. These places include the following:

- File Explorer
- Security Audit reports
- The access control list (ACL) editor in Registry Editor, as shown in the following examples:

    :::image type="content" source="media/sids-not-resolve-into-friendly-names/permissions-for-classes.png" alt-text="Screenshot of the Permissions for Classes window which shows that the SID doesn't resolve to a friendly name.":::
    :::image type="content" source="media/sids-not-resolve-into-friendly-names/advanced-security-settings-for-classes.png" alt-text="Screenshot of the Advanced Security Settings for Classes window which shows that the SID doesn't resolve to a friendly name.":::

## Cause

Windows Server 2012 and Windows 8 introduced a type of SID that is known as a Capability SID. By design, a Capability SID doesn't resolve to a friendly name.

Capability SIDs uniquely and immutably identify capabilities. In this context, a capability is an unforgeable token of authority that grants a Windows component or a Universal Windows Application access to a resource such as documents, cameras, locations, and so forth. An application that "has" a capability is granted access to the resource that is associated with the capability. An application that "does not have" a capability is denied access to the associated resource.

The most commonly used Capability SID is:  
S-1-15-3-1024-1065365936-1281604716-3511738428-1654721687-432734479-3232135806-4053264122-3456934681

Windows 10, version 1809 uses more than 300 Capability SIDs.

## More information

> [!Important]
> Don't delete Capability SIDS from either the registry or file system permissions. Removing a Capability SID from file system permissions or registry permissions might cause a feature or application to function incorrectly. After you remove a Capability SID, you cannot use the UI to add it back.

When you're troubleshooting an unresolved SID, make sure that it isn't a Capability SID. To get a list of all of the Capability SIDs, follow these steps:

1. Select **Start** > **Run**, and then enter *regedt32.exe*.
2. Navigate to the following registry entry: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SecurityManager\CapabilityClasses\AllCachedCapabilities`.

3. Copy the value data and paste it into a text file (or a similar location where you can search the data).

   > [!Note]
   > This value might not include all Capability SIDs that third-party applications use.

4. Search the data for the SID that you're troubleshooting.

   - If you find the SID in the registry data from the preceding step, then it's a Capability SID. By design, it will not resolve into a friendly name.
   - If you don't find the SID in the registry data, then it isn't a known Capability SID. You can continue to troubleshoot it as a normal unresolved SID. Keep in mind that there's a small chance that the SID could be a third-party Capability SID, in which case it will not resolve into a friendly name.
