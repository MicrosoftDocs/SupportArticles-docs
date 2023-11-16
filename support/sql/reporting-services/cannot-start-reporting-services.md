---
title: You cannot start SQL Server Reporting Services
description: This article provides workarounds for the problem that a time-out error and an issue in which event IDs 7000, 7009, and 1530 are logged when you start SSRS.
ms.date: 07/22/2020
ms.custom: sap:Reporting Services
ms.reviewer: joshger, aparnavi, ramakoni
---
# You cannot start SQL Server Reporting Services after you apply the update that is discussed in KB 2677070

This article helps you resolve a time-out error and a problem in which event IDs 7000, 7009, and 1530 are logged when you start SQL Server Reporting Services (SSRS).

_Original product version:_ &nbsp;  SQL Server  
_Original KB number:_ &nbsp; 2745448

## Symptoms

Assume that you apply the update that is described in [Microsoft Knowledge Base (KB) article 2677070](https://support.microsoft.com/help/2677070) on a computer that is running SSRS. When you try to start SSRS, you receive a time-out error, and event ID 7000 and event ID 7009 are logged in the Application log.

Additionally, event ID 1530 is logged, and information that resembles the following is logged in the Application log:

> [!NOTE]
> The placeholder < **Event Time** > represents the time when the event happens. The placeholder < **SSRS Server Name** > represents the SSRS server name.

## Cause

This issue occurs because of an inability to retrieve trusted and untrusted certificate trust lists (CTLs). If the system does not have access to Windows Update, either because the system is not connected to the Internet or because Windows Update is blocked by firewall rules, the network retrieval times out before the service can continue its startup procedure. In some cases, this network retrieval time-out may exceed the service startup time-out of 30 seconds. If a service cannot report that startup completed after 30 seconds, the service control manager (SCM) stops the service.

The URLs to update the CTL changed with this update. Therefore, if previous URLs were hard-coded as exceptions in the firewall or proxy, or if there is no Internet access on the computer, the CTL cannot be updated.

To download the latest CTLs, use the following updated URLs:

- [disallowedcertstl.cab](http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/disallowedcertstl.cab)
- [authrootstl.cab](http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootstl.cab)  

## Workaround

To work around this problem, configure the computer so that the network does not retrieve trusted and untrusted CTLs. To do this, use one of the following methods:

- Method 1

    Validate that boundary firewalls, router access rules, or downstream proxy servers allow systems that have update 2677070 installed to contact Microsoft Update. For more information about this requirement, see：[An automatic updater of revoked certificates is available for Windows Vista, Windows Server 2008, Windows 7, and Windows Server 2008 R2](https://support.microsoft.com/help/2677070) (This includes the URLs that the CTL update accesses).

- Method 2

    Change the Group Policy settings. To do this, follow these steps:

    1. Under the **Computer Configuration** node in the Local Group Policy Editor, double-click **Policies**.
    2. Double-click **Windows Settings**, double-click **Security Settings**, and then double-click **Public Key Policies**.
    3. In the details pane, double-click **Certificate Path Validation Settings**.
    4. Select the **Network Retrieval**  tab, click to select the **Define these policy settings** check box, and then click to clear the **Automatically update certificates in the Microsoft Root Certificate Program (recommended)** check box.
    5. Select **OK**, and then close the Local Group Policy Editor.

- Method 3

    Modify the registry. To do this, follow these steps.

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see: [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

    1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then click **OK**.
    2. Locate and then select the following registry subkey:

        `HKLM\Software\Policies\Microsoft\SystemCertificates`.

    3. Right-click AuthRoot, select **New**, and then click **DWORD**.
    4. Type *DisableRootAutoUpdate*, and then press Enter.
    5. Right-click **DisableRootAutoUpdate**, and then click **Modify**.
    6. In the **Value** data box, type *1*, and then click **OK**.
    7. On the **File** menu, click **Exit**.

- Method 4

    Increase the default service time-out.

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see: [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

    To increase the default service time-out, follow these steps:

    1. Click **Start**, click **Run**, type *regedit* in the **Open** box, and then click **OK**.
    2. Locate and then select the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control`.

    3. Right-click **Control**, point to **New**, and then click **DWORD**.
    4. In the **New Value** box, type *ServicesPipeTimeout*, and then press Enter.
    5. Right-click **ServicesPipeTimeout**, and then click **Modify**.
    6. Click **Decimal**, type the number of milliseconds that you want to wait until the service times out, and then click **OK**.
    For example, to wait 60 seconds before the service times out, type 60000.
    7. On the **File** menu, click **Exit**, and then restart the computer.

## More information

For more information about the Windows root certificate program, certificates, certificate trust, and the certificate trust list, see the **More Information** section of the article in the Microsoft Knowledge Base: [An-automatic-updater-of-untrusted-certificates-is-available-for-window](https://support.microsoft.com/help/2677070).
