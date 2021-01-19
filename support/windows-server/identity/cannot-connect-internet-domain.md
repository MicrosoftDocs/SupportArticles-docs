---
title: Cannot connect to Internet or domain
description: Resolves an issue in Windows Server 2003 where clients cannot join or log on to the domain.
ms.date: 09/10/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: v-jomcc, kaushika, michvar
ms.prod-support-area-path: Domain join issues
ms.technology: windows-server-active-directory
---
# You cannot connect to the Internet, and you cannot join or log on to the domain if Windows Server 2003 SP1 is installed on the authenticating domain controller

This article provides a solution to an issue where clients cannot join or log on to the domain.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 912023

## Symptoms

Consider the following scenario. A Microsoft Windows XP-based client computer is joined to a Microsoft Windows Server 2003 domain. Additionally, Windows Server 2003 Service Pack 1 (SP1) is installed on the authenticating domain controller. In this scenario, you experience the following symptoms:

- You cannot connect to the Internet.
- You cannot join or log on to the domain. Therefore, the domain controller is in IPsec Block mode.

When you start the IPSEC Services component on the domain controller, you may receive an error message that is similar to the following:
> The system cannot find the file specified.

Additionally, the following events may be logged in the server's System log:

## Cause

This problem can occur if the IPSec\Policy\Local registry key is deleted or when there is a corrupted file in the policy store. The file may become corrupted if an interruption occurs when the policy is being written to the disk.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this issue, follow these steps:

1. Delete the local policy registry subkey. To do this, follow these steps:

    1. Click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.
    2. In Registry Editor, locate and then click the following subkey:  
        `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\IPSec\Policy\Local`  
    3. On the **Edit** menu, click **Delete**.
    4. Click **Yes** to confirm that you want to delete the subkey.
    5. Quit Registry Editor

1. Rebuild a new local policy store. To do this, Click **Start**, click **Run**, type regsvr32 polstore.dll in the **Open** box, and then click **OK**.
1. Verify that the IPSEC Services component is set to automatic, and then restart the domain controller.

## Workaround

To temporarily work around this problem, disable the IPSEC Services component, and then restart the domain controller.

