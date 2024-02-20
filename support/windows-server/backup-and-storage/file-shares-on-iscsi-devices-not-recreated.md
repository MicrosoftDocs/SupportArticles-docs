---
title: File shares on iSCSI devices aren't re-created
description: Provides a resolution for an issue that may prevent file shares from being re-created. This issue occurs when you restart the computer.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:iscsi, csstroubleshoot
---
# File shares on iSCSI devices may not be re-created when you restart the computer

This article provides a resolution to an issue that may prevent file shares from being re-created when you restart the computer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 870964

## Symptoms

You use the Microsoft iSCSI Initiator service to connect to an Internet SCSI (iSCSI) disk device. The file shares that you create for folders that are located on your iSCSI device may not be re-created when you restart the computer that the shares are created on.

## Cause

The issue may occur when the iSCSI Initiator service isn't initialized when the Server service initializes. The Server service creates file shares. However, because iSCSI disk devices aren't available, the Server service can't create file shares for iSCSI devices until the iSCSI service is initialized.

## Resolution

### iSCSI Initiator 2.x

To resolve the issue in iSCSI Initiator 2.x, follow these steps on the affected server:

1. Make the Server service dependent on the iSCSI Initiator service. For information about how to do this, see the "Make the Server service dependent on the iSCSI Initiator service" section.
2. Configure persistent logons to the target. To do this, use one of the following methods.

    > [!NOTE]
    > If you see the target on the **Persistent Target** tab, the following steps are not required.

    Method 1: Use the iSCSI Initiator in Control Panel  

      1. In Control Panel, double-click **iSCSI Initiator**.
      2. Select the **Targets** tab.
      3. Select a target in the **Select a target** list, and then select **Log On**.
      4. Select to select the **Automatically restore this connection when the system boots** check box, and then select **OK**.  
  
    Method 2: Use the Command Prompt window  

      1. Select **Start** > **Run**, type *cmd*, and then select **OK**.
      2. At the command prompt, type the following command, and then press Enter:
      `iscsicli persistentlogintarget **target_iqn** T * * * * * * * * * * * * * * * 0`  

    > [!NOTE]
    > `target_iqn` is the IQN name of the target.  

3. Configure the BindPersistentVolumes option for the iSCSI Initiator service. To do this, use one of the following methods.

    Method 1: Use the iSCSI Initiator in Control Panel  

      1. In Control Panel, double-click **iSCSI Initiator**.
      2. Select the **Bound Volumes/Devices** tab.
      3. Select **Bind All** to bind all the persistent targets. Or, select **Add**, and then enter a drive letter or mount point to bind a specific target.
      4. Select **OK**.  
  
    Method 2: Use the Command Prompt window  

      1. Select **Start** > **Run**, type *cmd*, and then press Enter.
      2. Type `iscsicli BindPersistentVolumes`, and then press Enter.

          > [!NOTE]
          > This is the same as selecting the **Bind All** option in Method 1.  

> [!NOTE]
> Use this resolution only if you experience this specific issue with version 2.x of the iSCSI Initiator service.

### Make the Server service dependent on the iSCSI Initiator service

Use one of the following methods to make the Server service dependent on the iSCSI Initiator service.

#### Method 1: Use the Microsoft Service Control utility (Sc.exe)

> [!NOTE]
> You do not have to modify the registry when you use this method. Therefore, this method is the preferred way to set the service dependency.

1. Select **Start** > **Run**, type *cmd*, and then press Enter.
2. Type `sc config LanManServer depend= Samss/Srv2/MSiSCSI`, and then press Enter.

    If you have administrative access to the server, you can run this command from a network computer. Type the following command, and then press Enter:

    ```console
     sc \\computer_name config LanManServer depend= Samss/Srv2/MSiSCSI
    ```  

#### Method 2: Use Registry Editor

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

Microsoft Windows 2000  

1. Start Registry Editor.
2. Locate and then select the following registry subkey:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer`  

3. On the **Edit** menu, select **Add Value**.
4. Type *DependOnService* in the **Value Name** box, select **REG_MULTI_SZ** in the **Data Type** box, and then press Enter.
5. In the **Multi-String Editor** window, type *MSiSCSI* in the **data** box, and then select **OK**.
6. Exit Registry Editor.

## More information

You can script the procedures that are described in the "Resolution" section by using the Sc.exe and Iscsicli.exe utilities. To do this, create a batch file that uses these commands, and then either run the batch file directly, or run the batch file in another way. For example, run the batch file by using Group Policy.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they won't modify these examples to provide added functionality or construct procedures to meet your specific requirements.  

To script the whole operation that is described in the "Resolution" section, create a batch file that contains the following text:  

```console
sc config LanManServer depend= Samss/Srv2/MSiSCSI  
iscsicli BindPersistentVolumes
```

The issue could also happen to non-iscsi storage if server service is started before the storage has been initialized. In that case, we can use the below workaround, assuming G is the drive letter we want to monitor:

1. Save the script as a `*.bat` file.

      ```console
       :Start  
        dir G: /AH  
        if %errorlevel% equ 0 goto :OK  
        ping 127.0.0.1 /n 5  
        goto :Start  
        :OK  
        net stop browser  
        net stop netlogon  
        net stop dfs  
        net stop lanmanserver /y  
        net start lanmanserver  
        net start dfs  
        net start netlogon  
        net start browser  
      ```

2. We can add the bat file to "Start Script":  

    1. Put the batch file into `%systemroot%\System32\GroupPolicy\Machine\Scripts\Startup`
    2. Run `gpedit` to open local computer policy
    3. Add the batch file into the startup script.  
