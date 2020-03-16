---
title: Change default whitespace behavior in BizTalk
description: BizTalk 2006 R2 SP1 CU4, 2009 CU3, and 2010 CU1 all changed the default whitespace behavior in BizTalk due to the inclusion of hotfix 2492255. This article notifies users and provides instructions on how to revert back to the previous behavior if needed.
ms.date: 03/04/2020
ms.prod-support-area-path:
---
# Change in Default Whitespace Behavior in BizTalk

This article introduces the problem that the default whitespace behavior are changed in BizTalk due to the hotfix 2492255, and how to revert back to the previous behavior.

_Original product version:_ &nbsp; BizTalk Server 2009  
_Original KB number:_ &nbsp; 2786241

## Installing updates will change default behavior

Installing one of the following updates results in BizTalk changing default behavior to preserve whitespace within the XML during mapping:

- BizTalk 2010 CU1 or above
- BizTalk 2009 CU3 or above
- BizTalk 2006 R2 SP1 CU4 or above
- Hotfix [2492255](https://support.microsoft.com/help/2492255)

## Revert to changed behavior

In some environments, it may be preferred that the transform removes whitespace. In order to revert to this behavior, the following steps can be taken:

In BizTalk 2010, this is set at the host level:

1. Open **BizTalk Server Administration Console**.
2. Expand the **BizTalk Group** out to **Platform Settings** > **Hosts**.
3. Right-click on the host and choose **Settings**.
4. Check the checkbox next to Legacy whitespace behavior.
5. Click **OK**.
6. Restart the BizTalk Host Instances for this host.

In BizTalk 2009 and 2006 R2, this value is set at a per-machine level:

1. Open **Registry Editor**.
2. Locate and then click the following registry subkey on an x86-based computer:  
    `HKEY_LOCAL_MACHINE\Software\Microsoft\BizTalk Server\3.0\Administration`

    For an x64-based computer, click the following registry subkeys:

    - `HKEY_LOCAL_MACHINE\Software\Microsoft\BizTalk Server\3.0\Administration`

    - `HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\BizTalk Server\3.0\Administration`

3. Right-click and choose **DWORD** value.
4. Type **LegacyWhitespace** for the value name and then double-click on it and set the **Value data** to 1.
5. Exit **Registry Editor**.
6. Restart the BizTalk Host Instances on this machine.
