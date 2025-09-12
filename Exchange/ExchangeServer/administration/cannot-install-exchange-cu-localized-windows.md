---
title: Can't install Exchange Cumulative Update on a localized version of Windows Server
description: Fixes an issue in which you can't install an Exchange CU on a localized version of Windows Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
  - CI 122535
ms.reviewer: yusenko, v-six
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
search.appverid: MET150
ms.date: 01/24/2024
---

# Can't install Exchange Cumulative Update on a localized version of Windows Server

## Symptoms

One of the following errors occurs when you try to install an Exchange Cumulative Update (CU) on a localized version of Windows Server:

- The installation fails and returns `register-ContentFilter`. Exactly one minute later, the following error entry appears in ExchangeSetupLog:

    > [mm/dd/yyyy 02:38:28.0817] [2] Beginning processing register-ContentFilter  
[mm/dd/yyyy 02:39:28.0889] [2] [ERROR] Couldn't register the content filter.

- The installation fails or takes many hours to finish. However, the failure occurs whenever the following cmdlet is run when you check ExchangeSetupLog:

    ```powershell
    [mm/dd/yyyy 14:47:00.0736] [1] Executing:
    get-ExchangeServer $RoleNetBIOSName | add-ADPermission `
    -DomainController $RoleDomainController `
    -User "S-1-5-18" `
    -AccessRights GenericRead
    ```

## Cause

The calling server (Exchange server) uses an isolated username or security identifier (SID) to resolve names. If the server does not resolve the name locally, it sends requests to domain controllers (DCs) in all trusted domains to do the name resolution.

## Resolution

To resolve this problem, set **LsaLookupRestrictIsolatedNameLevel** to **1** on all DCs that communicate with the server that's running Exchange Server.

> [!NOTE]
> Create this registry entry only on DCs.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly. These problems could cause you to have to reinstall the operating system or even prevent your machine from starting. Microsoft can't guarantee that these problems can be solved. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur. Modify the registry at your own risk.

1. Select **Start** > **Run**.
2. In the **Open** box, type `regedit`, and then select **OK**.
3. In Registry Editor, locate and select the following registry subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa`

4. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
5. Type **LsaLookupRestrictIsolatedNameLevel**, and press Enter.
6. On the **Edit** menu, select **Modify**.
7. To disable the lookup of isolated names in external trusted domains, type **1** in the **Value data** box.
8. Select **OK**, and exit Registry Editor.

If the **LsaLookupRestrictIsolatedNameLevel** registry value is set on a DC, you don't have to restart the services or the computer.
