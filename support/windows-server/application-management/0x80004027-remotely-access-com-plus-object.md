---
title: Applications can't remotely access COM+ object
description: Discusses that you receive a 0x80004027-CO_E_CLASS_DISABLED error when you try to remotely access COM+ object after you upgrade to Windows Server 2016. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Application Technologies and Compatibility\DCOM service startup and permissions, csstroubleshoot
---
# 0x80004027 error when you try to remotely access COM+ object after you upgrade to Windows Server 2016 or later versions

This article provides a solution to the 0x80004027-CO_E_CLASS_DISABLED error that occurs when you remotely access COM+ object after you upgrade to Windows Server 2016 or later versions.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016, Windows Server 2019, Windows Server 2022  
_Original KB number:_ &nbsp; 3182294

## Symptoms

After you upgrade from an earlier release of Windows Server to Windows Server 2016 or later versions, applications cannot remotely access a COM+ object, and you receive the following error message:

> 0x80004027-CO_E_CLASS_DISABLED

## Cause

This problem occurs because support for the Application Server role was removed from Windows Server 2016 or later versions. This change blocks applications that rely on COM+ remote access.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this problem and enable COM+ remote access, follow these steps:

1. Enable COM+ Network Access in Windows Firewall. To do this, open **Control Panel**, click the **Windows Firewall** item, and then click **Allow an app or feature through Windows Firewall**.

2. In the **Allowed apps and features** list, select the **COM+ Network Access** check box, and then select the appropriate scope that's required for your application. For enterprises, this is typically Domain. However, your application may require additional settings, depending on the scenario.

    :::image type="content" source="media/0x80004027-remotely-access-com-plus-object/com-plus-network-access-option.png" alt-text="The COM+ Network Access check box in the Allowed apps and features list.":::

3. Set the registry value that allows COM+ remote access. To do this, follow these steps:

    1. In the **Start search** box, type regedit, and then click **regedit.exe** in the results list.
    2. Locate the following subkey:  
      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\COM3`
    3. Right-click the **RemoteAccessEnabled** DWORD.
    4. In the **Value data** box, enter 1.
    5. Click **OK**.
