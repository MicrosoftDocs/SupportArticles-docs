---
title: Error when you use eConnect on a computer
description: This article provides a resolution for a problem that occurs when you receive a try to use Microsoft Business Solutions-Great Plains eConnect on a computer that is running Microsoft Windows XP Service Pack 2.
ms.reviewer: theley, kjohns
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# You receive a (New transaction cannot enlist in the specified transaction coordinator) error message when you use eConnect on a computer that is running Windows XP SP2

This article helps you resolve the problem that occurs when you receive a try to use Microsoft Business Solutions-Great Plains eConnect on a computer that is running Microsoft Windows XP Service Pack 2.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 887111

## Symptoms

When you try to use Microsoft Business Solutions-Great Plains eConnect on a computer that is running Microsoft Windows XP Service Pack 2 (SP2), you receive the following error message:

New transaction cannot enlist in the specified transaction coordinator

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](../../windows-server/performance/windows-registry-advanced-users.md).

## Cause

This problem occurs because of one or more of the following reasons:

1. Microsoft Distributed Transaction Coordinator (MSDTC) is disabled for network transactions.
2. Windows Firewall is enabled on the computer. By default, Windows Firewall blocks MSDTC.

    > [!NOTE]
    > This problem may occur even when Windows Firewall is turned off.

## Resolution

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

On the computer where Windows XP SP2 has been applied, follow these steps:

1. Make sure that the Log On As account for the MSDTC service is the Network Service account. To do this:

   1. Click **Start**, click **Run**, type *Services.msc*, and then click **OK**.
   2. In the Services window, in the **Name** column, find the Microsoft Distributed Transaction Coordinator service.
   3. Under the **Log On As** column, identify whether the Log On As account is Network Service or Local System. If the Log On As account is Network Service, go to step 4.
   4. In the **Run** dialog box, type *cmd*, and then click **OK**.

2. Stop and remove the MSDTC service. To do this:

   1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
   2. At the command prompt, type *Net stop msdtc*, and then press **ENTER** to stop the MSDTC service.
   3. At the command prompt, type *Msdtc -uninstall*, and then press **ENTER** to remove MSDTC.
   4.

3. Remove the MSDTC service from the registry and reinstall the service. To do this:

   1. At the command prompt, type *regedit*, and then press **ENTER** to open Registry Editor.
   2. In Registry Editor, find and then click the following registry key:

      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft|MSDTC`.
  
   3. Click **File**, click **Edit**, and then click **Delete**.
   4. Click **Yes** to confirm.
   5. Click **File**, and then click **Exit** to close Registry Editor.
   6. At the command prompt, type *Msdtc - install*, and then press **ENTER** to install MSDTC.
   7. At the command prompt, type *Net start msdtc*, and then press **ENTER** to start the MSDTC service.

   > [!NOTE]
   > The Log On As account for the MSDTC service is set to **Network Service Account**.

4. Allow MSDTC to allow the network transaction. To do this:

   1. Click **Start**, click **Run**, type *dcomcnfg.exe*, and then click **OK**.
   2. In the Component Services window, expand **Component Services**, expand **Computers**, and then expand **My Computer**.
   3. Right-click **My Computer**, and then click **Properties**.
   4. In the **My Computer Properties** dialog box, click the **MSDTC** tab, and then click **Security Configuration**.
   5. In the **Security Configuration** dialog box, click to select the **Network DTC Access** check box.
   6. To allow the distributed transaction to run on this computer from a remote computer, click to select the **Allow Inbound** check box.
   7. To allow the distributed transaction to run on a remote computer from this computer, click to select the **Allow Outbound** check box.
   8. In the **Transaction Manager Communication** section, click the **No Authentication Required** option, and then click **OK** four times.

5. Configure Windows Firewall to include the MSDTC program. To do this:

   1. Click **Start**, click **Run**, type *Firewall.cpl*, and then click **OK**.
   2. In the **Windows Firewall** dialog box, click the **Exceptions** tab.
   3. Click **Add Program**.
   4. In the **Add a Program** dialog box, click **Browse** to locate the Msdtc.exe file.

      > [!NOTE]
      > By default, the file is stored in the **Installation drive:** \Windows\System32 folder.

   5. In the **Add a Program** dialog box, click **OK**.
   6. In the **Windows Firewall** dialog box, in the **Programs and Services** list, click to select the **msdtc.exe** check box.

6. Include port 135 as an exception. To do this:

   1. Click the **Exceptions** tab, and then click **Add Port**.
   2. In the **Add a Port** dialog box, in the **Port number** box, type *135*, and then select **TCP**.
   3. In the **Name** text box, type a name for the exception and then click **OK**.
   4. In the **Windows Firewall** dialog box, in the **Programs and Services** list, click the name that you used for the exception in step 6c, and then click **OK**.
