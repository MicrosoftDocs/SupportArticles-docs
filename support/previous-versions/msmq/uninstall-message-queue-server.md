---
title: Uninstall Message Queue Server
description: This article demonstrates how to manually remove the necessary Microsoft Message Queue (MSMQ) components to allow a clean reinstallation of MSMQ Server without any conflicts with a previous installation.
ms.date: 07/24/2020
ms.prod-support-area-path: 
---
# Manually uninstall Microsoft Message Queue Server

This article demonstrates how to manually remove the necessary Microsoft Message Queue (MSMQ) components to allow a clean reinstallation of MSMQ Server without any conflicts with a previous installation.

_Original product version:_ &nbsp; Microsoft Message Queue  
_Original KB number:_ &nbsp; 202124

## Introduction

Depending on the type of MSMQ installation, the following information will demonstrate the necessary steps to remove MSMQ. It is important to backup the system prior to performing these steps. Failure to do so may result in the loss of critical files.

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986/windows-registry-information-for-advanced-users).

## Remove MSMQ for Windows NT PEC, PSC, BSC, RS, or IC

1. Stop the MSMQ and the Distributed Transaction Coordinator (MSDTC) services in the Control Panel **Services** applet.

2. Stop the Message Queuing Data Access (MQAC) driver. Open a new command prompt window and execute the command:

    ```console
    net stop mqac
    ```

3. For a site controller (a Primary Enterprise Controller (PEC), Primary Site Controller (PSC), or Backup Site Controller (BSC)), use SQL enterprise manager to delete the Message Queue Information Service (MQIS) database and both MQIS devices (MQISData and MQISLog).

    To ensure that the device has been dropped from the sysdevices table, do the follows:

    1. Run ISQL or SQL Query Analyzer.
    2. Select **Master** database (default).
    3. Type `sp_helpdevice`, and then press CTRL+E to execute the query.
    4. In the results, verify if the MQIS devices are present.
    5. If they are present, then type `sp_dropdevice MQISData, MQISLog` and then execute the query to drop the MQIS devices from the sysdevices table.

4. Delete the folder where MSMQ is installed. For example:

    `C:\Program Files\MSMQ`

5. Delete the following MQ DLLs and files from the `C:\Winnt\System32 directory`.

    > [!NOTE]
    > Not all of the files in the following list will appear in every type of MSMQ installation, these shown are for a PEC.

    - *Mqcertui.dll*
    - *Mqdbmgr.dll*
    - *Mqdscli.dll*
    - *Mqdssrv.dll*
    - *Mqis.dll*
    - *Mqkey.dll*
    - *Mqkeyhlp.dll*
    - *Mqlogmgr.dll*
    - *Mqmailoa.dll* (This DLL is only installed with the Exchange connector.)
    - *mqmailvb.dll* (This DLL is only installed with the Exchange connector.)
    - *Mqoa.dll*
    - *Mqperf.dll*
    - *Mqqm.dll*
    - *Mqrt.dll*
    - *Mqsrvkey.exe*
    - *Mqsvc.exe*
    - *Mqutil.dll*
    - *Mqxp32.dll*

6. Delete *MQAC.sys* from `C:\Winnt\System32\Drivers`.

7. Delete the MSMQ shortcut folder. Depending on where MSMQ was installed from, the shortcut folder may be in a different location. For example:

    `C:\WinNT\Profiles\All Users\Start Menu\Programs\`

    or for the Option Pack version:

    `C:\WinNT\Profiles\All Users\Start Menu\Programs\Windows NT 4.0 Option Pack`

8. Use regedit.exe or regedit32.exe to delete the following MSMQ entries: (Select the MSMQ folder then click **Delete** from the **Edit** menu).

    - `HKEY_LOCAL_MACHINE\Software\Microsoft\MSMQ`
    - `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MSMQ`
    - `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MQAC`
    - `HKEY_LOCAL_MACHINE\System\ControlSet###\ControlSets\Services\MSMQ`

    > [!NOTE]
    > The `###` represents different number values. Not all `ControlSet###` entries will have an MSMQ entry, but remove all that do.

9. For a PSC, BSC, Routing Server (RS), or Independent Client (IC) installation, delete the computer from Message Queue Explorer on a different computer in the Enterprise. To remove the computer from the Enterprise:

    1. Launch **Message Queue Explorer** and browse the computer to be removed.
    2. Right-click on the computer and select **Properties**.
    3. On the **Security** tab, click **Ownership** then click **Take Ownership**.
    4. Click **Permissions** and add the currently logged on user with **Full Control(All)** and click **OK**.
    5. Right-click the computer and select **Delete**.

## Remove MSMQ for Windows NT MSMQ Dependent Client

1. Delete the folder where MSMQ is installed. For example:

    `C:\Program Files\MSMQ`

2. Delete the MSMQ shortcut folder. Depending on where MSMQ was installed from, the shortcut folder may be in a different location. For example:

    `C:\WinNT\Profiles\All Users\Start Menu\Programs\`

    or for Option Pack version:

    `C:\WinNT\Profiles\All Users\Start Menu\Programs\Windows NT 4.0 Option Pack`

3. Use regedit.exe or regedit32.exe to delete the following MSMQ entries. (Select the MSMQ folder then click **Delete** from the **Edit** menu.)

    `HKEY_LOCAL_MACHINE\Software\Microsoft\MSMQ`

4. Delete the following MQ DLLs and files from the `C:\Winnt\System32 directory`.

    > [!NOTE]
    > Not all of the following files listed will appear in every type of MSMQ installation.

    - *Mqcertui.dll*
    - *Mqdbmgr.dll*
    - *Mqdscli.dll*
    - *Mqdssrv.dll*
    - *Mqis.dll*
    - *Mqkey.dll*
    - *Mqkeyhlp.dll*
    - *Mqlogmgr.dll*
    - *Mqmailoa.dll*
    - *Mqmailvb.dll*
    - *Mqoa.dll*
    - *Mqperf.dll*
    - *Mqqm.dll*
    - *Mqrt.dll*
    - *Mqsrvkey.exe*
    - *Mqsvc.exe*
    - *Mqutil.dll*
    - *Mqxp32.dll*

## Remove MSMQ for Windows 95 Independent or Dependent Client

1. Delete the folder where MSMQ is installed. For example:

    `C:\Program Files\MSMQ`

2. Delete the Microsoft Message Queue shortcut folder. For example:

    `C:\Win95\Start Menu\Programs\`

3. Use regedit.exe or regedit32.exe to delete the following MSMQ entries: (Select the MSMQ folder then click **Delete** from the **Edit** menu).

    `HKEY_LOCAL_MACHINE\Software\Microsoft\MSMQ`

4. If the computer is an Independent Client, delete the computer from the Message Queue Explorer on a different computer in the Enterprise. To remove the computer from the Enterprise:

    1. Launch **Message Queue Explorer** and browse the computer to be removed.
    2. Right-click on the computer and select **Properties**.
    3. On the **Security** tab, click **Ownership** then click **Take Ownership**.
    4. Click **Permissions** and add the currently logged on user with **Full Control(All)** and click **OK**.
    5. Right-click the computer and select **Delete**.

5. Delete the following MQ DLLs and files from the `C:\Windows\System directory`

    > [!NOTE]
    > Not all of the following files listed will appear in every type of MSMQ installation.

    - *Mqac.dll*
    - *Mqcertui.dll*
    - *Mqdscli.dll*
    - *Mqkey.dll*
    - *Mqkeyhlp.dll*
    - *Mqlogmgr.dll*
    - *Mqmailoa.dll*
    - *Mqmailvb.dll*
    - *Mqoa.dll*
    - *Mqpostbt.exe*
    - *Mqqm.dll*
    - *Mqrt.dll*
    - *Mqsetup.dll*
    - *Mqsvc.exe*
    - *Mqutil.dll*
    - *Mqxp32.dl*

After the steps earlier have been implemented, restarting the computer will complete the removal of MSMQ.

> [!NOTE]
> For PEC, PSC, BSC, RS, or IC installations, upon restart the MSDTC service will be started, and the MSMQ service will no longer appear in the Control Panel **Services** applet.
