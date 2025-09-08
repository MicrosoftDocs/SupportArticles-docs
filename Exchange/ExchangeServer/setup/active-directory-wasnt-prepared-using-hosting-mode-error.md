---
title: (Active Directory wasn't prepared using hosting mode) error during installation
description: Fixes a problem in which you receive an Active Directory wasn't prepared using hosting mode error when trying to install Exchange Server 2010 SP1 from an unattended installation.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: anfowler, gugavaro, v-six
appliesto: 
  - Exchange Server 2010 Service Pack 1
search.appverid: MET150
---
# Active Directory wasn't prepared using hosting mode error when installing Exchange Server 2010 SP1

_Original KB number:_ &nbsp; 2384868

## Symptoms

Consider the following scenario:

- You run the `Setup /PrepareAD` cmdlet without the `hosting` parameter to install Exchange Server 2010 SP1 from an unattended installation.
- You run the `setup.com` cmdlet with the `hosting` parameter to install the first Exchange Server 2010 (SP1) server. The installation fails.
- You try to install Exchange Server 2010 SP1 in non-hosting mode.

In this scenario, you receive the following error message:

> Active Directory wasn't prepared using hosting mode. To install server roles for hosting mode, you need to clean up Active Directory and prepare it again for hosting mode.

## Cause

This problem occurs because the `PARTNERHOSTEDMODE` registry key that is created at the beginning of the installation is not removed. When the first Exchange Server 2010 SP1 server installation fails, you cannot uninstall the installation. When you try to install the Exchange Server 2010 SP1 server in non-hosting mode, the Exchange Best Practices Analyzer (EXBPA) detects that the `PARTNERHOSTEDMODE` registry key is present.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this problem, follow these steps:

1. Select **Start**, and then select **Run**.
2. Type *Regedit*, and then select **OK** to start Registry Editor.
3. Locate and then select the following subkey in the registry:  
   `HKEY_LOCAL_MACHINE\Software\Microsoft\ExchangeServer\V14`
4. Delete the `PARTNERHOSTEDMODE` registry key.
5. Install Exchange Server 2010 SP1 in non-hosting mode.

## More information

There is another article that also resolves the problem of the Exchange Server 2010 SP1 installation failure. For more information, see [You cannot install an Exchange Server 2010 SP1 server from an unattended installation](cannot-install-exchange-server-from-unattended-installation.md).
