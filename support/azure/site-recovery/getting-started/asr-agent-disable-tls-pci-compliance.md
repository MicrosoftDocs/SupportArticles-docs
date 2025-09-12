---
title: How to resolve Azure Site Recovery agent issues after disabling TLS 1.0 for PCI compliance
description: Describes how to resolve issues that you may encounter when you use Azure Site Recovery if the TLS 1.0 security protocol is disabled and only TLS 1.1 and TLS 1.2 are enabled to achieve security hardening for PCI compliance.
ms.date: 08/14/2020
ms.service: azure-site-recovery
ms.author: jarrettr
author: JarrettRenshaw
ms.reviewer: manayar, anoopkv
ms.custom: sap:I need help getting started with Site Recovery
---
# How to resolve Azure Site Recovery agent issues after disabling TLS 1.0 for PCI compliance

_Original product version:_ &nbsp; Azure Backup  
_Original KB number:_ &nbsp; 4033999

This article describes how to resolve issues that you may experience when you use Azure Site Recovery in situations in which the following security protocol settings are made to achieve security hardening for Peripheral Component Interconnect (PCI) compliance:

- Transport Layer Security (TLS) 1.0 is disabled
- TLS 1.1 and TLS 1.2 are enabled

To update TLS settings, refer to [this article](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn786418(v=ws.11)?redirectedfrom=MSDN).  

## Symptoms

After you disable TLS 1.0, you may experience one or more of the following issues:

- Ongoing protection starts to fail.
- Scale-out Process Server (PS) registrations fail.
- Mobility service installations fail.
- Services that are related to the Azure Site Recovery agents do not stop or start as usual.

## Cause

These issues can occur for the following reasons:

- The .NET Framework version 4.6 or a later version is not available.
- The .NET Framework version 4.6 or a later version is available but strong cryptography (SchUseStrongCrypto) is disabled.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry](https://support.microsoft.com/kb/322756) for restoration in case problems occur.

To fix these issues, make sure that the .NET Framework 4.6 or a later version is installed and TLS 1.2 is enabled as the default protocol. To enable TLS 1.2, follow these steps:

1. Open a Command Prompt window as an administrator.
2. At the elevated command prompt, run the following command:

    ```console
    net stop obengine
    ```

3. Start Registry Editor, and then navigate to the following registry subkeys:

    `HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\.NETFramework`

    `HKEY_LOCAL_MACHINE \Software\Microsoft\.NETFramework`

4. Under each of these registry keys, locate the subkeys that indicate a version.

    > [!NOTE]
    > These subkeys appear in the "v\<VersionNumber>" format.

    :::image type="content" source="media/asr-agent-disable-tls-pci-compliance/registry-key.png" alt-text="Screenshot of subkeys in Registry Editor.":::

5. For each of these subkeys, add a **DWORD Value** that is named **SchUseStrongCrypto**, and set its value to **1**.

    :::image type="content" source="media/asr-agent-disable-tls-pci-compliance/dword-value.png" alt-text="Screenshot of adding a DWORD Value that is named SchUseStrongCrypto.":::

6. Repeat step 5 for all the subkeys that have the "v\<VersionNumber>" format.
7. Exit Registry Editor.
8. At an elevated command prompt, run the following command:

    ```console
    net start obengine
    ```

After you complete these steps, you should be able to install and use Azure Site Recovery as expected.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
