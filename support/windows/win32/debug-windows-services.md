---
title: Debug Windows services
description: This article describes how to debug a Windows service by using the WinDbg debugger.
ms.date: 08/27/2020
ms.prod-support-area-path: System Services Development
ms.reviewer: sre.ash
ms.topic: how-to
---
# Debug Windows services

This article describes how to debug a Windows service by using the WinDbg debugger.

_Original product version:_ &nbsp; Microsoft Windows Server, Windows XP  
_Original KB number:_ &nbsp; 824344

## Summary

This step-by-step article describes how to debug a Windows service by using the WinDbg debugger (*windbg.exe*). To debug a Windows service, you can attach the WinDbg debugger to the process that hosts the service after the service starts, or you can configure the service to start with the WinDbg debugger attached so that you can troubleshoot service-startup-related problems. This article describes both these methods.

## Requirements

This article assumes that you are familiar with the following topics:  

- Windows Services
- WinDbg Debugger

## Attach the WinDbg debugger to a service after the service starts

This method is similar to the method that you can use to attach a debugger to a process and then debug a process.

## Use the process ID of the process that hosts the service that you want to debug

1. To determine the process ID (PID) of the process that hosts the service that you want to debug, use one of the following methods.

    - **Method 1: Use the Task Manager**

        1. Right-click the **taskbar**, and then click **Task Manager**. The **Windows Task Manager** dialog box appears.
        2. Click the **Processes** tab of the **Windows Task Manager** dialog box.
        3. Under **Image Name**, click the image name of the process that hosts the service that you want to debug.

            > [!NOTE]
            > The process ID of this process as specified by the value of the corresponding **PID** field.

    - **Method 2: Use the Task List Utility (tlist.exe)**

        1. Click **Start**, and then click **Run**. The **Run** dialog box appears.
        2. In the **Open** box, type *cmd*, and then click **OK**.
        3. At the command prompt, change the directory path to reflect the location of the *tlist.exe* file on your computer.

            > [!NOTE]
            > The *tlist.exe* file is typically located in the directory: `C:\Program Files\Debugging Tools for Windows`.

        4. At the command prompt, type *tlist* to list the image names and the process IDs of all processes that are currently running on your computer.

            > [!NOTE]
            > Make a note of the process ID of the process that hosts the service that you want to debug.

2. At a command prompt, change the directory path to reflect the location of the *windbg.exe* file on your computer.

    > [!NOTE]
    > If a command prompt is not open, follow steps a and b of Method 1. The *windbg.exe* file is typically located in the directory: `C:\Program Files\Debugging Tools for Windows`.

3. At the command prompt, type `windbg -p ProcessID /g` to attach the WinDbg debugger to the process that hosts the service that you want to debug.

    > [!NOTE]
    > `ProcessID` is a placeholder for the process ID of the process that hosts the service that you want to debug.

## Use the image name of the process that hosts the service that you want to debug

You can use this method only if there is exactly one running instance of the process that hosts the service that you want to run. To do this, follow these steps:

1. Click **Start**, and then click **Run**. The **Run** dialog box appears.
2. In the **Open** box, type *cmd*, and then click **OK** to open a command prompt.
3. At the command prompt, change the directory path to reflect the location of the *windbg.exe* file on your computer.

    > [!NOTE]
    > The *windbg.exe* file is typically located in the directory: `C:\Program Files\Debugging Tools for Windows`.

4. At the command prompt, type `windbg -pn ImageName /g` to attach the WinDbg debugger to the process that hosts the service that you want to debug.

    > [!NOTE]
    > `ImageName` is a placeholder for the image name of the process that hosts the service that you want to debug. The `-pn` command-line option specifies that the `ImageName` command-line argument is the image name of a process.

## Start the WinDbg debugger and attach to the process that hosts the service that you want to debug

1. Start Windows Explorer.
2. Locate the *windbg.exe* file on your computer.

    > [!NOTE]
    > The *windbg.exe* file is typically located in the directory: `C:\Program Files\Debugging Tools for Windows`.

3. Run the *windbg.exe* file together with the `/g` command-line switch to start the WinDbg debugger. The `/g` command-line switch allows the tracked process to continue after the break point is set.
4. On the **File** menu, click **Attach to a Process** to display the **Attach to Process** dialog box.
5. Click to select the node that corresponds to the process that hosts the service that you want to debug, and then click **OK**.
6. In the dialog box that appears, click **Yes** to save base workspace information.

    > [!NOTE]
    > You can now debug the disassembled code of your service.

## Configure a service to start with the WinDbg debugger attached

You can use this method to debug services if you want to troubleshoot service-startup-related problems.

1. Configure the **Image File Execution** options. To do this, use one of the following methods:

    - **Method 1: Use the Global Flags Editor (gflags.exe)**

        1. Start Windows Explorer.
        2. Locate the *gflags.exe* file on your computer.

            > [!NOTE]
            > The *gflags.exe* file is typically located in the directory: `C:\Program Files\Debugging Tools for Windows`.

        3. Run the *gflags.exe* file to start the **Global Flags Editor**.
        4. In the **Image File Name** text box, type the image name of the process that hosts the service that you want to debug. For example, if you want to debug a service that is hosted by a process that has *MyService.exe* as the image name, type *MyService.exe*.
        5. Under **Destination**, click to select the **Image File Options** option.
        6. Under **Image Debugger Options**, click to select the **Debugger** check box.
        7. In the **Debugger** text box, type the full path of the debugger that you want to use. For example, if you want to use the WinDbg debugger to debug a service, you can type a full path that is similar to the following: `C:\Program Files\Debugging Tools for Windows\windbg.exe`.
        8. Click **Apply**, and then click **OK** to quit the **Global Flags Editor**.

    - **Method 2: Use Registry Editor**

        1. Click **Start**, and then click **Run**. The **Run** dialog box appears.

        2. In the **Open** box, type *regedit*, and then click **OK** to start **Registry Editor**.

        3.
            > [!IMPORTANT]
            > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756)

            In Registry Editor, locate, and then right-click the following registry subkey:

           `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options`

        4. Point to **New**, and then click **Key**. In the left pane of **Registry Editor**, the **New Key #1** (the name of a new registry subkey) is selected for editing.

        5. Type *ImageName* to replace **New Key #1**, and then press **ENTER**.

            > [!NOTE]
            > *ImageName* is a placeholder for the image name of the process that hosts the service that you want to debug. For example, if you want to debug a service that is hosted by a process that has *MyService.exe* as the image name, type *MyService.exe*.

        6. Right-click the registry subkey that you created in step e.
        7. Point to **New**, and then click **String Value**. In the right pane of **Registry Editor**, the **New Value #1**, the name of a new registry entry, is selected for editing.
        8. Replace **New Value #1** with Debugger, and then press **ENTER**.
        9. Right-click the **Debugger** registry entry that you created in step h, and then click **Modify**. The **Edit String** dialog box appears.
        10. In the **Value data** text box, type *DebuggerPath*, and then click **OK**.

            > [!NOTE]
            > *DebuggerPath* is a placeholder for the full path of the debugger that you want to use. For example, if you want to use the WinDbg debugger to debug a service, you can type a full path that is similar to this one: `C:\Progra~1\Debugg~1\windbg.exe`.

2. For the debugger window to appear on your desktop, and to interact with the debugger, make your service interactive. If you do not make your service interactive, the debugger will start but you cannot see it and you cannot issue commands. To make your service interactive, use one of the following methods:

    - **Method 1: Use the Services console**

        1. Click **Start**, and then point to **Programs**.
        2. On the **Programs** menu, point to **Administrative Tools**, and then click **Services**. The **Services** console appears.
        3. In the right pane of the **Services** console, right-click **ServiceName**, and then click **Properties**.

            > [!NOTE]
            > **ServiceName** is a placeholder for the name of the service that you want to debug.

        4. On the **Log On** tab, click to select the **Allow service to interact with desktop** check box under **Local System account**, and then click **OK**.

    - **Method 2: Use Registry Editor**

        1. In Registry Editor, locate, and then click the following registry subkey:

            `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ServiceName`

            > [!NOTE]
            > Replace *ServiceName* with the name of the service that you want to debug. For example, if you want to debug a service named *MyService*, locate and then click the following registry key:
            >
            > `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MyService`.

        2. Under the **Name** field in the right pane of **Registry Editor**, right-click **Type**, and then click **Modify**. The **Edit DWORD Value** dialog box appears.

        3. Change the text in the **Value data** text box to the result of the binary OR operation with the binary value of the current text and the binary value, **0x00000100**, as the two operands. The binary value, **0x00000100**, corresponds to the `SERVICE_INTERACTIVE_PROCESS` constant that is defined in the *WinNT.h header* file on your computer. This constant specifies that a service is interactive in nature.

3. When a service starts, the service communicates to the Service Control Manager how long the service must have to start (the time-out period for the service). If the Service Control Manager does not receive a **service started** notice from the service within this time-out period, the Service Control Manager terminates the process that hosts the service. This time-out period is typically less than 30 seconds. If you do not adjust this time-out period, the Service Control Manager ends the process and the attached debugger while you are trying to debug. To adjust this time-out period, follow these steps:

    1. In Registry Editor, locate, and then right-click the following registry subkey:  

       `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control`

    2. Point to **New**, and then click **DWORD Value**. In the right pane of **Registry Editor**, the **New Value #1** (the name of a new registry entry) is selected for editing.

    3. Type *ServicesPipeTimeout* to replace **New Value #1**, and then press **ENTER**.

    4. Right-click the **ServicesPipeTimeout** registry entry that you created in step c, and then click **Modify**. The **Edit DWORD Value** dialog box appears.

    5. In the **Value data** text box, type *TimeoutPeriod*, and then click **OK**  

        > [!NOTE]
        > *TimeoutPeriod* is a placeholder for the value of the time-out period (in milliseconds) that you want to set for the service. For example, if you want to set the time-out period to 24 hours (86400000 milliseconds), type *86400000*.

    6. Restart the computer. You must restart the computer for Service Control Manager to apply this change.

4. Start your Windows service. To do this, follow these steps:

    1. Click **Start**, and then point to **Programs**.
    2. On the **Programs** menu, point to **Administrative Tools**, and then click **Services**. The **Services** console appears.
    3. In the right pane of the **Services** console, right-click **ServiceName**, and then click **Start**.

       > [!NOTE]
       > **ServiceName** is a placeholder for the name of the service that you want to debug.

## Troubleshooting

Before you try to debug a service across a network, make sure that the symbols and the source files that the service uses are accessible from the computer where the service will run. To do this, use one of the following methods:

- Grant at least read-access permissions to everyone for the folder on your computer that contains the symbols and the source files that the service uses.

- Copy these symbols and source files that the service uses to the computer where the service will run.

## References

[Services](/windows/win32/services/services)

## Applies to

- Windows Server 2003 Enterprise Edition (32-bit x86)
- Windows Server 2003 Standard Edition (32-bit x86)
- Windows Server 2003 Datacenter Edition (32-bit x86)
- Windows XP Home Edition
- Windows XP Professional
