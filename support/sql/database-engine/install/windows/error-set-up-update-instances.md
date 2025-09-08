---
title: Attempted to perform an unauthorized operation error
description: This article provides a resolution for the problem where setting up or updating SQL Server instances fails and returns an error message.
ms.date: 04/08/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: jopilov
---
# Attempted to perform an unauthorized operation error when you set up or update SQL Server instances

This article helps you resolve the problem where setting up or updating SQL Server instances fails and returns an error message.

_Applies to:_ &nbsp; SQL Server 2019 on Windows, SQL Server 2017 on Windows, SQL Server 2016, SQL Server 2014, SQL Server 2012  
_Original KB number:_ &nbsp; 4594205

## Symptoms

Consider the following scenario:

- You have a computer that's running [Windows 10, version 20H2](/windows/release-information/status-windows-10-20h2) and the Microsoft Edge browser of any version from 84.0.522.52 through 86.0.622.55.

- You try to update an existing instance of Microsoft SQL Server 2012 through 2019, or install a new SQL Server instance together with an update (slipstream).

In this scenario, a failure occurs during the update process, and you receive the following error message:

> Attempted to perform an unauthorized operation.

Additionally, an entry is logged in the SQL Server Setup log file, *Detail.txt*, that indicates that the failure occurred while **Attempting to open registry subkey Microsoft Edge**.

## Cause

The SQL Server Setup process can't enumerate the following registry subkey:

`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge`

## Resolution

To resolve this problem, use one of the following methods, as appropriate:

- **Method 1**

    If you're running 64-bit Windows 10, version 20H2 (19042.xxx), you must install the Edge browser version 86.0.622.56 or a later version that includes the fix for this problem. To see the version number in Edge, select **Settings** > **About Edge**.
  
    To manually update the Edge browser, follow these steps:
  
    1. Start **Microsoft Edge**.
    1. Select the **Settings** (ellipsis) button in the top-right corner.
    1. On the **Settings** menu, select **Help and feedback** > **About Microsoft Edge**.
  
       > [!NOTE]
       > Edge automatically checks for updates.
  
    1. To complete the Edge update installation, select **Restart**.

- **Method 2**  

    > [!IMPORTANT]
    > Follow the steps in this method carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

  Add the Full Control permission to the Administrators account. To do this, follow these steps:

  1. Start Registry Editor. To do this, select **Start**, type **regedit**, and then select **Registry Editor** in the Search results.
  1. In Registry Editor, right-click the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge`
subkey, and then select **Permissions**.
  1. In the **Permissions** window that opens, select **Advanced**.
  1. At the top of the **Advanced Security Settings** window, select **Change** next to the listed owner.
  1. In the **Select User, Computer, Service Account, or Group** window, type the name of your Windows user account (or your email address if you have a Microsoft account) in the **Enter the object name to select** box, and then select **Check Names** to validate the account name.
  1. Select **OK** two times.
  1. In the **Permissions** window, select the **Users** group, and then select the **Allow** check box for the **Full Control** permissions.

     > [!NOTE]
     > To grant permissions to only your user account instead of the **Users** group, select **Add**, follow the steps in the Add wizard, and then grant the **Full Control** permissions to that account.

  1. Select **OK** to return to the main Registry Editor window.

## More information

SQL Server Setup expects administrators to have read/write access permissions on all subkeys that are under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall`, where Setup looks for installed SQL Server updates. However, in some cases, the system provides administrators only read permissions on subkeys-as it does, for example, on Microsoft Edge.

A future SQL Server servicing update will change the access requirement so that Setup will need only read permissions on all subkeys that are under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall`.
