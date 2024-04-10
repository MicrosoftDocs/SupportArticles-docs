---
title: All Intranet options enabled automatically
description: Provides the steps to solve the issue that all the three Intranet Options automatically will be enabled if Automatically Detect Intranet Network is enabled on a domain member computer.
ms.date: 03/16/2020
ms.reviewer: wuth
---
# Automatically Detect Intranet Network enables all Intranet options on a domain member computer

[!INCLUDE [](../../../includes/browsers-important.md)]

Enabling **Automatically Detect Intranet Network** on a domain member computer will enable all the three Intranet options automatically in Internet Explorer. This article introduces the steps to disable the **Automatically Detect Intranet Network** settings on a computer that is a member of a domain.

_Original product version:_ &nbsp; Internet Explorer
_Original KB number:_ &nbsp; 2028170

## Symptoms

By default in Internet Explorer, the **Automatically Detect Intranet Network** settings will be enabled to automatically control the following three options of Intranet detection:

1. Include all local (intranet) sites not listed in other zones
2. Include all sites that bypass the proxy server
3. Include all network paths (UNCs)

If **Automatically Detect Intranet Network** is enabled on a computer that is a member of a domain, all three of these options will be enabled regardless of what is configured through domain policy.

## Resolution

To solve this problem, you can disable the **Automatically Detect Intranet Network** settings on a computer that is a member of a domain by taking the following steps:

1. Click **Start**, click **Run**, type *gpedit.msc* in the **Open** box, and then click **OK**.

2. Expand **Computer Configuration**, expand **Administrative Templates**, expand **Windows Components**, expand **Internet Explorer**, and then expand **Internet Control Panel**.

3. Click **Security Page**, right-click **Intranet Sites: Include all local (intranet) sites not listed in other zones**, and then click **Properties**.

4. Click **Enabled**, and then click **OK**.

5. Right-click **Turn on automatic detection of the intranet**, and then click **Properties**.

6. Click **Disabled**, and then click **OK**.

7. Exit the **Group Policy Object Editor**.
