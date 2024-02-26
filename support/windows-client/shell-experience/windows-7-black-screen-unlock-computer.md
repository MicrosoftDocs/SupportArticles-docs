---
title: Windows 7 black screen on computer unlock
description: Describes an issue about Windows black screen when unlocking a computer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: robsmi, kaushika
ms.custom: sap:desktop-shell, csstroubleshoot
---
# Windows 7 black screen on computer unlock

This article provides a solution to an issue where Windows black screen when unlocking a computer.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2431700

## Symptoms

Consider the following scenario:

1. A Windows Vista or Windows 7 computer is running the "Aero" graphics mode.
2. The Windows Vista or Windows 7 computer is subject to additional security restrictions and security software, such as might be the case in the enterprise, or with mandated security settings and software such as DISA or DoD requirements.
3. The computer is locked and left undisturbed long enough for the screen to go black, which is 20 minutes with the default power policy of "Balanced".
4. A person unlocks the computer by entering their user credentials.

After the credential is entered, the screen goes black, and remains black for as much as 10 minutes or longer. The machine isn't "hard-locked", as periodic disk-drive activity may be noted from the disk-drive indicator light on the computer, if so equipped.

## Cause

A problem with some layer of security software causes the Desktop Window Manager to wait for an unspecified amount of time.

## Resolution

1. A temporary workaround is to Stop and Disable the "Desktop Window Manager Session Manager" service. Disabling this service will turn off the "Aero" graphics display feature, which will disable certain features such as Aero Peek, Aero Snap, Aero Shake, and so on. To disable this service:
    1. Click the **Start** button, type *services.msc* and then press the ENTER key, or click the icon that comes up under **Programs** in the Instant Search box.
    2. Locate and then double-click the Desktop Window Manager Session Manager service.
    3. Locate the **Startup type** dropdown and change the value to "disabled".
    4. Locate and click the button labeled "Stop".
    5. Click the **Apply** button, and then click the **OK** button.

    Alternatively, you can run the following commands from an elevated CMD prompt to set the service properties of the Desktop Window Manager Session Manager service to not running and disabled:

    ```console
    net stop UxSms
    sc config UxSms start= disabled
    ```

    To return the settings for the Desktop Window Manager Session Manager service to normal via the CMD line:

    ```console
    sc config UxSms start= auto
    net start UxSms
    ```

2. Updated display drivers may resolve this issue. You can determine the manufacturer of the display adapter by following these steps:

    1. Click **Start**, and in the **Search Programs and Folder** text box, type in *MSINFO32* (without quotation marks) and press ENTER.
        > [!NOTE]
        > The System Information tool should appear.
    2. On the left-hand section called **System Summary** locate Components, and under **Components** locate and click on **Display**.
    3. The right-hand section of **System Information** should now display information about the display system in the computer. The item called "Name" should indicate the type of display adapter.
    4. At this point you can go to the Internet web site of the vendor, or the vendor of your computer to locate updated drivers.
    5. In some cases, you may be offered updated video drivers by running Windows Update.
    6. If you are not sure of which drivers to install, contact the vendor of your computer hardware for assistance in locating an updated display driver package.

3. Another solution is to discover what layer of security software is causing the temporary blocking, which renders the screen black and therefore unusable. That layer of software would need to be uninstalled or updated to prevent the blocking condition in the Desktop Window Manager.

## More information

One symptom that has been noted if this condition is true is that the DWM, or Desktop Window Manager process will consume an ever increasing amount of memory, as displayed in Task Manager.
