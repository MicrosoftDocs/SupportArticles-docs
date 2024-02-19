---
title: How to disable the lookup of isolated names
description: Provides a resolution to the poor performance when calling lookup functions to resolve names. Gives a method to disable the lookup of isolated names in trusted domain.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, v-lianna
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# Poor performance when calling lookup functions to resolve names

_Original KB number:_ &nbsp; 818024

When calling the **LookupAccountName** or **LsaLookupNames** function to resolve isolated names (ambiguous or non-domain-qualified user accounts) to security identifiers (SIDs), you may notice an increased usage of memory and CPU on the domain controller and decreased performance.

For example, poor performance might occur when using scripts or tools (such as *Cacls.exe*, *Xcacls.exe*, *icacls.exe*, *Dsacls.exe*, and *Subinacl.exe*) to call the functions to edit security settings.

The problem may show up when you have many trusted domains or forests (applies to both external and forest trusts), and/or some of these domains or forests are offline or slow to respond.

When the functions are called for an isolated name (the format is AccountName in contrast to domain\AccountName), a remote procedure call (RPC) is made to domain controllers on all trusted domains/forests. This issue might occur if the primary domain has many trust relationships with other domains/forests or if it's doing many lookups at a same time. For example, a script is configured to run at the startup of many clients, or many trusted domains/forests use the same script simultaneously.

## Disable the lookup of isolated names in trusted domains/forests

> [!NOTE]
> Create this registry entry only on domain controllers.

Here's how to create a registry entry to disable the lookup of isolated names in trusted domains/forests:

> [!IMPORTANT]
> This article contains instructions to modify the registry. Severe issues might occur if the registry is modified incorrectly. As a precaution, back up the registry before you modify it. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

1. Open **Registry Editor**.
2. Go to `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa`.
3. On the **Edit** menu, select **New** > **DWORD Value**.
4. Type *LsaLookupRestrictIsolatedNameLevel*, and press Enter.
5. Right-click **LsaLookupRestrictIsolatedNameLevel** and select **Modify**. Type *1* in the **Value data** box.

    > [!NOTE]
    > By default, the **LsaLookupRestrictIsolatedNameLevel** entry is either set to *0* or doesn't exist. That means that the lookup for isolated names in trusted domains/forests is enabled.

6. Select **OK** and close **Registry Editor**.

## More information

The lookup functions can directly target a domain controller on an appropriate domain for the following name formats that contain an authoritative domain of a security principal:

- NetBIOSDomainName\AccountName
- DnsDomainName\AccountName
- AccountName@DnsDomainName

For more information, see [Network access validation algorithms and examples for Windows](../windows-security/network-access-validation-algorithms.md).
