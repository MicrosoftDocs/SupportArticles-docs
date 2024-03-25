---
title: How to speed up a Windows 8.1 computer
description: Describes ways to help speed up your computers when it tend to slow down after time, without upgrading your hardware.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, meerak
ms.custom: sap:System Performance\System Performance (slow, unresponsive, high CPU, resource leak), csstroubleshoot
---
# Speed up a Windows 8.1 computer

No matter how good you are about keeping your computer clean and up-to-date, they tend to slow down after time. Fortunately, there are a lot of ways to help speed them up― without upgrading your hardware.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 3064207

> [!NOTE]
> If you are an advanced user, you can download [a free tool](/sysinternals/downloads/autoruns) from the Microsoft website that shows you all of the programs and processes that run when you start Windows, including the ones that Windows requires to operate successfully. Use this tool only if you are comfortable restoring Windows after an error occurs.

## Uninstall extra antivirus programs

If you use more than one antivirus or antispyware program at the same time, your device may experience decreased performance, become unstable, or restart unexpectedly. To remedy the issue, you should select one Internet security program to run on your device. You should then uninstall the other programs.

> [!CAUTION]
> Make sure you have an Internet security program running on your device before you uninstall other security programs.

Some Internet security applications do not uninstall completely. You may need to download and run a cleanup utility for your previous security application to completely remove it.

If you use another antispyware program together with Microsoft Security Essentials, we recommend that you turn off real-time scanning in the other program. For more information, see the documentation supplied by that antispyware program.

To remove an antivirus or antispyware program, follow these instructions:

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or select **Search**.
3. Type *appwiz.cpl* in the **Search** box.
4. Tap or select **Appwiz.cpl** below the **Search** box.
5. In the list of installed programs, uninstall the Internet security programs you don't need.
6. Restart your device.

## Close programs in the notification area running with startup

If your device takes a long time to start up, one of the causes could be having a large number of startup apps or a few apps that have a high impact on startup time.

Some of these programs add an icon to the notification area on the taskbar to show that they are running with startup.

To stop a program that has one of these icons from automatically running on startup, follow these instructions:

1. Point to each icon in the icon tray to see the program name.
2. To ensure that you can see icons for all running programs, swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down), and tap or select **Search**.
3. Type *show hidden icons* in the **Search** box.
4. Tap or select **Show or hide inactive icons on the taskbar**.
5. Check **Always show all icons and notifications on the taskbar**.

> [!NOTE]
> You must open any program that you do not want to run on startup and change the setting.

## View Startup items

To see what programs run at startup and disable any, follow these instructions:

1. Press and hold or right-click in the blank area on Taskbar and select **Task Manager**.
2. Tap or select **More details** in the lower-left corner of **Task Manager**.
3. Under the **Startup** tab in **Task Manager**, you can view a list of applications that start automatically every time you turn on your device and sign in to Windows.
4. If you see any programs in this list that you do not want to run when Windows starts, tap or select the application and then tap or select **Disable**.

> [!NOTE]
> Disabling a program from running at startup doesn't stop the program from running if you need it. If you tap or select the program after startup, it will start and run normally.

## Change a program

Sometimes, by adding or removing certain program options, you can prevent a program from running at startup.

If you can't stop the program from running on startup and the program does not have the option to change the configuration, you must talk to the program manufacturer for a solution.

To change the configuration of a program, follow these instructions:

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or select **Search**.
3. Type *appwiz.cpl* in the **Search** box.
4. Tap or select **Appwiz.cpl** below the **Search** box.
5. Tap or select a program, and then tap or select **Uninstall**, **Change**, or **Repair**.

If prompted, type an administrator password or confirmation.

## Clean up disk errors

Over time, your device may create errors on its hard drive. These errors can slow your device. The Check Disk program identifies and cleans any errors.

To run Check Disk, follow these instructions:

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or select **Search**.
3. Type *computer* in the **Search** box.
4. Tap or select **This PC** below the **Search** box.
5. Press and hold or right-click the drive you want to repair, and then tap or select **Properties**.
6. Tap or select the **Tools** tab.

7. Under **Error checking**, tap or select **Check**. Depending upon the size of your hard disk, this may take several minutes. For best results, don't use your device for any other tasks while it's checking for errors. If prompted, type an administrator password or confirmation.

8. You may need to restart your device after error checking is complete.

## Defragment your hard disk

One of the best ways to help improve your device's performance is by optimizing the hard drive. Optimize Drives, previously known as Disk Defragmenter, is a Windows feature that helps optimize different types of drives. The feature runs automatically on a weekly schedule, but you can also run Optimize Drives manually.

To run Optimize Drives manually, follow these instructions:

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or select **Search**.
3. Type *computer* in the **Search** box.
4. Tap or select **This PC** below the **Search** box.
5. Press and hold or right-click the drive you want to repair, and then tap or select **Properties**.
6. Tap or select the **Tools** tab.
7. Tap or select **Optimize** under **Optimize and defragment drive**.
8. Under **Status**, tap or select the drive you want to optimize. (The **Media type** column tells you what type of drive you're optimizing.)
9. To determine if the drive needs to be optimized, tap or select **Analyze**.
    > [!Note]
    > If prompted, type an administrator password or confirmation.
10. After Windows finishes analyzing the drive, check the **Current status** column to see whether you need to optimize the drive. If the drive is more than 10 percent fragmented, you should optimize it.
11. Tap or select **Optimize**.

> [!NOTE]
>
> - Optimizing a drive can take anywhere from several minutes to several hours to finish, depending on the size of the drive and degree of optimization required. You can still use your device during the optimization process.
> - If the drive is being used by another program or is formatted using a file system other than NTFS, FAT, or FAT32, it can't be optimized.
> - Network drives can't be optimized.
> - If a drive doesn't appear in Optimize Drives, it might be because it contains an error. Try to repair the drive first, then return to Optimize Drives to try again.

To change the optimization schedule, follow these instructions:

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or select **Search**.
3. Type *computer* in the **Search** box.
4. Tap or select **This PC** below the **Search** box.
5. Press and hold or right-click the drive you want to repair, and then tap or select **Properties**.
6. Tap or select the **Tools** tab.
7. Tap or select **Optimize** under **Optimize and defragment drive**.
8. Tap or select **Change settings**. If prompted, type an administrator password or confirmation.
9. Select one of the following:

    - To turn off scheduled optimization, clear the **Run on a schedule** check box.
    - To change the frequency of scheduled optimization, tap or select the drop-down list next to **Frequency**, and then tap or select **Daily**, **Weekly**, or **Monthly**. The default schedule for optimization is weekly and runs during Automatic Maintenance.
    - To select the drives you want to include or exclude in scheduled optimization, tap or select **Choose** next to Drives. Select or clear the check boxes next to the drives and then tap or select OK. You can also clear the **Automatically optimize new drives** check box if you don't want new drives added to scheduled optimization. If Windows can't optimize a drive, it won't offer the drive as an option for Automatic Maintenance.

10. Tap or select **OK**.

## Clean your hard disk

Disk Cleanup reduces the number of unnecessary files on your drives by deleting temporary files and system files, emptying the Recycle Bin, and removing a variety of other items that you may no longer need.

To clean your hard disk, follow these instructions:

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or select **Search**.
3. Type *free up disk space* in the **Search** box.
4. Tap or select **Free up disk space by deleting unnecessary files** below the **Search** box.
5. In the **Drives** list, tap or select the drive that you want to clean up.
6. Tap or select **OK**.
7. In the message that appears, tap or select **Delete files**.

To clean up system files associated with your account, follow these instructions:

1. In the **Drives** list, tap or select the drive that you want to clean up and then tap or select **OK**.
2. In the Disk Cleanup dialog box, tap or select **Clean up system files**.
    > [!NOTE]
    > If prompted, type an administrator password or confirmation.
3. The **More Options** tab is available when you opt to clean up system files from your device. This tab includes two additional options for freeing up space:
   - **Programs and Features**. This option opens **Programs and Features** in **Control Panel**, where you can uninstall programs that you no longer use. The **Size** column in **Programs and Features** shows how much space each program uses.
   - **System Restore and Shadow Copies**. System Restore uses restore points to return your system files to an earlier point in time. If your device is running normally, you can save space by deleting earlier restore points.

## Turn off visual effects

If Windows is running slowly, you can speed it up by disabling certain visual effects. You can select which visual effects to turn off one by one or you can let Windows select for you.

To turn off visual effects, follow these instructions:

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or select **Search**.
3. Type *Performance Information and Tools* in the **Search** box.
4. Tap or select **Adjust the appearance and performance of Windows** below the **Search** box.
5. Under **Visual Effects** tab, check on **Adjust for best performance**, and then tap or select **OK**. (For a less drastic option, select **Let Windows choose what's best for my computer**.

## Run fewer programs at the same time

Sometimes you can improve system performance by changing your computing behavior. Running four or more programs while leaving multiple browser windows and email messages open may be more than your device can handle.

If you find your device slowing down, decide whether you really need to keep all of your programs and windows open at the same time. Also, find a way to remind yourself to reply to email messages later instead of keeping them open until you reply.

## Use ReadyBoost

ReadyBoost can speed up your device by using storage space on flash memory cards and USB flash drives. If you have a storage device that will work with ReadyBoost, you'll see an option to use ReadyBoost when you plug it into your device. If you select this option, you can select how much memory to use.

## Adjust indexing options

Windows uses an index to perform very fast searches of the most common files on your device. If it's taking too long to search for things on your device, you can narrow your search to focus on the files and folders that you most commonly use.

## Adjust power plan

A power plan is a collection of hardware and system settings (such as display, sleep, and so on) that manages how your device uses power. The power plans you can use depend on the kind of device you have.
