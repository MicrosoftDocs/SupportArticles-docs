---
title: The computer stops responding or the Applying computer settings screen appears for longer than you expect
description: Describes how to resolve an issue where the computer stops responding or the Applying computer settings screen appears for longer than you expect.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, cbutch, v-jomcc
ms.custom: sap:system-hang, csstroubleshoot
---
# When you restart a computer, the computer stops responding, or the "Applying computer settings" screen appears for longer than you expect

This article provides a solution to an issue where the computer stops responding or the "Applying computer settings" screen appears for longer than you expect.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 905716

## Symptoms

When you restart a Windows Server 2003-based computer or a Windows 2000 Server-based computer, you experience one of the following symptoms:

- During startup, the "Applying computer settings" screen appears, and the computer stops responding.
- During startup, the "Applying computer settings" screen appears and remains for longer than you expect.
- During startup, before the logon screen appears, a blue screen that has a blinking pointer appears, and the computer stops responding.
- The Network connections folder is empty.
- You cannot open the **Add or Remove Programs** item in Control Panel.
- The APC Agent stops responding while it is starting.
- You cannot start or stop services.
- The server responds slowly to graphical user interface (GUI) functions.
- When you try to open Disk Management, you receive one of the following messages:

    > Waiting to connect
  
    > Connecting to Logical Disk Manager service  
    Disk Management never opens.
- When applying security patches, whether from Windows Update or manually, the system stops at "Inspecting your configuration."

## Cause

This problem occurs because of a problem with version 6.*x* of APC PowerChute Business Edition Software.

APC has issued the following official statement about this issue:

The APC 6.x software uses Sun Microsystems Java Cryptography Extension(JCE) 1.2.1 Package. The digital certificate that was used to sign the JCE 1.2.1 jar files expired on July 27, 2005. Because of this, the system causes the above detailed symptoms.

## Resolution

To resolve this problem, follow these steps:

1. Restart the computer in Safe Mode:

    1. Restart the computer. When the "Please select the operating system to start" message appears, press F8.
    2. Under **Windows Advanced Options Menu**, use the arrow keys to select **Safe Mode**, and then press ENTER.

        > [!NOTE]
        > NUM LOCK must be off before the arrow keys on the numeric keypad will function.
    3. If you are running other operating systems on the computer, use the arrow keys to select the operating system that you want, and then press ENTER.

2. Log on to the computer as a local administrator.
3. Disable the APCPBEAgent service and the APCPBEServer service:
    1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Services**.
    2. In the right pane, right-click **APCPBEAgent**, and then click **Properties**.
    3. In the **Startup type** list, click to select **Disabled**, and then click **OK**.
    4. In the right pane, right-click **APCPBEServer**, and then click **Properties**.
    5. In the **Startup type** list, click to select **Disabled**, and then click **OK**.
4. Restart the computer.
5. Install the latest version of the APC PowerChute software. For more information about how to obtain an update for the PowerChute Business Edition version 6. x software, visit the [APC Web site](https://www.apc.com/).

## Workaround

To work around this problem, re-register Msiexec.exe. To do this, click **Start**, click **Run**, type `msiexec /regserver`, and then click **OK**.

## More information

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.  

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

APC PowerChute Business Edition v6 uses a Sun Java Run Time Engine that expired from service on July 27, 2005. APC now uses PowerChute Business Edition to communicate and to manage UPS (uninterruptible power supply and battery backup) systems.
