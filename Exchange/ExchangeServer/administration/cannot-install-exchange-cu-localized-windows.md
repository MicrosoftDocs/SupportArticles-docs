---
title: Can't install Exchange Cumulative Update on a localized version of Windows Server
description: Fixes an issue in which you are not able to install an Exchange CU on a localized version of Windows Server.
author: TobyTu
ms.author: yusenko
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 122535
ms.reviewer: yusenko
appliesto:
- Exchange Server 2019
- Exchange Server 2016
- Exchange Server 2013
search.appverid: MET150
---

# Can't install Exchange Cumulative Update on a localized version of Windows Server

## Symptoms

You receive one of these errors when trying to install an Exchange Cumulative Update (CU) on a localized version of Windows Server:

1. The installation fails with the `register-ContentFilter`. The error appears after exactly 1 minute in ExchangeSetupLog:

    > [mm/dd/yyyy 02:38:28.0817] [2] Beginning processing register-ContentFilter  
[mm/dd/yyyy 02:39:28.0889] [2] [ERROR] Couldn't register the content filter.

2. The installation fails or takes many hours to succeed, but the failure/hang occurs whenever this cmdlet is executed – when checking ExchangeSetupLog:

    ```powershell
    get-ExchangeServer $RoleNetBIOSName | add-ADPermission `
    -DomainController $RoleDomainController `
    -User "S-1-5-18" `
    -AccessRights GenericRead
    ```

## Cause

The calling server (Exchange server) uses an isolated username or security identifier (SID) to resolve names. When the server fails to resolve the name locally, it sends requests to domain controllers (DCs) in all trusted domains to perform the name resolution. For more information, read [this article](https://support.microsoft.com/help/818024).

## Resolution

Set **LsaLookupRestrictIsolatedNameLevel** to **1** on all the DCs the Exchange server communicates with:

> [!NOTE]
> Create this registry entry only on domain controllers.

> [!WARNING]
> Serious problems could occur if you modify the registry incorrectly. These problems could cause you to have to reinstall the operating system or even prevent your machine from booting. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.

1. Go to the **Start** menu and select **Run**.
2. In the **Open** box, type `regedit` and select **OK**.
3. Locate and select the following registry subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa`

4. On the **Edit** menu, point to **New** and select **DWORD Value**.
5. Type **LsaLookupRestrictIsolatedNameLevel** and press **Enter**.
6. On the **Edit** menu, select **Modify**.
7. To disable the lookup of isolated names in external trusted domains, type **1** in the Value data box.
8. Select **OK** and exit the Registry Editor.

A restart of services or reboot isn't required when the **LsaLookupRestrictIsolatedNameLevel** registry value is set on a DC.
