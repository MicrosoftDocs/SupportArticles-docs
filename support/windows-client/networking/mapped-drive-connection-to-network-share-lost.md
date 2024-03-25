---
title: Mapped drive is disconnected
description: This article provides solutions to an issue where the mapped drive may be disconnected if you map a drive to a network share.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\Access to file shares (SMB), csstroubleshoot
---
# Mapped drive connection to network share may be lost

This article provides solutions to an issue where the mapped drive may be disconnected if you map a drive to a network share.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 297684

## Symptoms

On a computer that runs Windows 7 Service Pack 1, if you map a drive to a network share, the mapped drive may be disconnected after a regular interval of inactivity, and Windows Explorer may display a red X on the icon of the mapped drive. However, if you try to access or browse the mapped drive, it reconnects quickly.

## Cause

This behavior occurs because the systems can drop idle connections after a specified time-out period (by default, 15 minutes) to prevent wasting server resources on unused sessions. The connection can be re-established quickly, if necessary.

## Resolution

To resolve this behavior, change the default time-out period on the shared network computer. To do this, use one of the following methods.

### Method 1: Using Registry Editor

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

Use Registry Editor to increase the default time-out period. To do this, follow these steps, and then quit Registry Editor:

> [!NOTE]
> You can't use this method to turn off the **autodisconnect** feature of the Server service. You can only use this method to change the default time-out period for the **autodisconnect** feature.

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.

2. Locate and then click the following key in the registry:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters`

3. In the right pane, click the **autodisconnect** value, and then on the **Edit** menu, click **Modify**. If the **autodisconnect** value doesn't exist, follow these steps:
  
    1. On the **Edit** menu, point to **New**, and then click **REG_DWORD**.
    2. Type **autodisconnect**, and then press ENTER.

4. On the **Edit** menu, click **Modify**.
5. Click **Hexadecimal**.
6. In the **Value data** box, type *ffffffff*, and then click **OK**.

The client-side session is automatically disconnected when the idling time lasts more than the duration that is set in **KeepConn**. Therefore, the session is disconnected according to the shorter set duration value between **AutoDisConnect** and **KeepConn**. To change the time-out duration in the client-side during a UNC connection, specify the arbitrary time in **KeepConn**.
Locate and then click the following key in the registry:

- Location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lanmanworkstation\parameters`
- Value: **KeepConn**
- Data type: REG_DWORD
- Range: 1 to 65535 (sec)
- Default value: 600 sec = 10 mins

### Method 2: Using Command line

> [!NOTE]
> If you use this method, you may turn off the **autotuning** feature for the Server service.

To change the default time-out period for the **autodisconnect** feature of the Server service, open a command prompt, type the following line, and then press ENTER:

```console
net config server /autodisconnect: number
```

where *number* is the number of minutes that you want the server to wait before it disconnects a mapped network drive. The maximum value for this command is **65,535**.

> [!NOTE]
> If you set the **autodisconnect** value to **0** (zero), the **autodisconnect** feature is not turned off, and the Server service disconnects mapped network drives after only a few seconds of idle time.

To turn off the **autodisconnect** feature, open a command prompt, type the following line, and then press ENTER:

```console
net config server /autodisconnect:-1
```

### Did this fix the problem

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus/).

## More information

Some earlier programs may not save files or access data when the drive is disconnected. However, these programs function normally before the drive is disconnected.

For more information about how to increase the default time-out period, [Server service configuration and tuning](https://support.microsoft.com/help/128167)
