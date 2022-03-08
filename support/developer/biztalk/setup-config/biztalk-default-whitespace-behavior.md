---
title: Change in default whitespace behavior in BizTalk Server
description: BizTalk Server 2006 R2 SP1 CU4, 2009 CU3, and 2010 CU1 changed default whitespace behavior. This article describes how to revert to the previous behavior if needed.
ms.date: 03/04/2020
ms.custom: sap:BizTalk Server Setup and Configuration
---
# Change in default whitespace behavior in BizTalk Server

This article describes the change in default whitespace behavior in BizTalk Server due to hotfix 2492255, and how to revert to the previous behavior.

_Original product version:_ &nbsp; BizTalk Server 2009  
_Original KB number:_ &nbsp; 2786241

## Installing updates will change default behavior

Installing one of the following updates results in BizTalk Server changing default behavior to preserve whitespace within the XML during mapping:

- BizTalk Server 2010 CU1 or later
- BizTalk Server 2009 CU3 or later
- BizTalk Server 2006 R2 SP1 CU4 or later
- Hotfix [2492255](https://support.microsoft.com/help/2492255)

## Revert to changed behavior

In some environments, the transform's removal of whitespace might be preferred. To revert to this behavior, take the following steps.

In BizTalk Server 2010, this value is set at the host level:

1. Open **BizTalk Server Administration Console**.
2. Expand **BizTalk Group** to **Platform Settings** > **Hosts**.
3. Right-click the host and select **Settings**.
4. Select the **Legacy whitespace behavior** check box.
5. Select **OK**.
6. Restart the BizTalk Server host instances for this host.

In BizTalk Server 2009 and 2006 R2, this value is set at a per-machine level:

1. Open **Registry Editor**.
2. Find and then select the following registry subkey on an x86-based computer:  
    `HKEY_LOCAL_MACHINE\Software\Microsoft\BizTalk Server\3.0\Administration`

    On an x64-based computer, select the following registry subkeys:

    - `HKEY_LOCAL_MACHINE\Software\Microsoft\BizTalk Server\3.0\Administration`

    - `HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\BizTalk Server\3.0\Administration`

3. Right-click and select the **DWORD** value.
4. Enter **LegacyWhitespace** for the value name, and then double-click it and set **Value data** to **1**.
5. Close **Registry Editor**.
6. Restart the BizTalk Server host instances on this machine.
