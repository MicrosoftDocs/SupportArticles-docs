---
title: Netlogon service doesn't start
description: Describes an issue where the Netlogon service doesn't start and event IDs 2114 and 7024 are logged. Provides a resolution for this issue.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# The Netlogon service doesn't start and event IDs 2114 and 7024 are logged

This article provides a solution to an issue where the Netlogon service doesn't start when you start a Windows-based computer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 269375

## Symptoms

When you start your Windows 2000-based computer, the Netlogon service doesn't start, even though the Startup type is set to automatic.

Event Viewer logs the following errors:

- Message 1

    ```output
    Event Type: Error
    Event Source: NETLOGON
    Event Category: None
    Event ID: 2114
    Description: The Server service is not started.
    ```

- Message 2

    ```output
    Event Type: Error
    Event Source: Service Control Manager
    Event Category:None
    Event ID: 7024
    Description: The Netlogon service terminated with service-specific error 2114.
    ```

After your computer starts, you can manually start the Netlogon service.

## Cause

This issue can occur if either of the following conditions exist:

- The dependent services of the Netlogon service have been changed from the default values and are not properly configured. You may be unable to access some network resources on the computer because the Netlogon service is not started.

- You removed Client for Microsoft Networks, and then reinstalled it. The dependencies are not reset correctly if the Client for Microsoft Networks component is removed and then reinstalled.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this issue, follow these steps:

1. Start Registry Editor (Regedt32.exe).
2. Locate the registry key: `HKEY_LOCAL_MACHINE/System/CurrentControlSet/Services/Netlogon/`.
3. In the right pane, double-click the **DependOnService** value.
4. In the **Multi-String Editor** dialog box, type the following strings on separate lines, and then click **OK**:

    - LanmanServer
    - LanmanWorkstation

5. Quit Registry Editor, and then restart the computer.

The Netlogon service starts as expected.
