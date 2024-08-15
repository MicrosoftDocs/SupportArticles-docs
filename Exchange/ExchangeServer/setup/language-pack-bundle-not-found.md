---
title: The installation in RecoverServer mode fails
description: Describes an issue that causes an Exchange Server 2013 installation attempt to fail. This issue is language pack-related, and it occurs when you're using RecoverServer mode. The resolution involves changing a registry setting.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Error when you try to install Exchange Server 2013 in RecoverServer mode

_Original KB number:_ &nbsp; 3069005

## Symptoms

When you try to install Exchange Server 2013 in RecoverServer mode, the operation fails with the following error during Prerequisite Analysis:

> The language pack bundle could not be found or is corrupt.

## Cause

This behavior occurs if an earlier setup attempt has failed.

## Resolution

> [!NOTE]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this issue, remove the `Language Packs` registry key, and then run Setup again:

1. Click **Start**, click **Run**, type *regedit* in the **Open** box, and then click **OK**.
2. Expand the registry, and then select the following subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ExchangeServer\v15\Lanaguage Packs`
3. Right-click `Language Packs`, and then click **Delete**.
4. Click **Yes** to confirm the deletion of the `Language Packs` subkey.
5. On the **File** menu, click **Exit** to close Registry Editor.

## More information

The Exchange Setup log shows the following error data in this situation:

> [01/03/2015 01:08:36.0915] [1] Failed [Rule:LangPackBundleCheck] [Message:The language pack bundle could not be found or is corrupt.]  
> [01/03/2015 01:08:37.0008] [1] [REQUIRED] The language pack bundle could not be found or is corrupt.  
> [01/03/2015 01:08:37.0008] [1] Help URL: [ms.exch.setupreadiness.LangPackBundleCheck](/previous-versions/exchange-server/exchange-160/jj126675(v=exchg.160))
> [01/03/2015 01:08:37.0039] [1] Ending processing test-SetupPrerequisites
