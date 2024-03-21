---
title: Error 2147944102 when you start BITS service
description: Provides a solution to an error 2147944102 that occurs when you start the Background Intelligent Transfer Service (BITS) Service.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Deployment, configuration, and management of Remote Desktop Services infrastructure, csstroubleshoot
---
# "Service-Specific Error Code -2147944102" error message if you try to start the BITS service

This article provides a solution to an error 2147944102 that occurs when you start the Background Intelligent Transfer Service (BITS) Service.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 326460

## Symptoms

If you try to start the BITS service on a Windows 2000-based computer on which Terminal Services is installed, you may experience the following symptoms:

- You receive one of the following error messages:

    > Windows could not start the Background Intelligent Transfer Service on Local Computer. For more information, review the System Event Log. If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code -2147023194.

    -or-

    > A service-specific error occurred: -2147944102.

- The following event is recorded in the System log of Windows NT Event Viewer:

    > Event Type: Error  
    Event Source: Service Control Manager  
    Event Category: None  
    Event ID: 7024  
    User: N/A  
    Description: The Background Intelligent Transfer Service service terminated with service-specific error 2147944102.

## Cause

This behavior may occur if the Terminal Services service is disabled.

By default, when the Terminal Services component is installed, the startup type for the Terminal Services service is set to Automatic. If an administrator changes the service's startup type to Disabled, the BITS service does not start.

## Resolution

To resolve this problem, obtain the latest service pack for Microsoft Windows 2000.

## Workaround

To work around this issue, use one of the following methods (as appropriate to your situation).

### Method 1: Configure the Terminal Services to Start Automatically

To configure the Terminal Services service to start automatically, follow these steps:

1. Click **Start**, point to **Settings**, and then click **Control Panel**.
2. Double-click **Administrative Tools**, and then double-click **Services**.
3. In the right pane, right-click **Terminal Services**, and then click **Properties**.
4. Click the **General** tab.
5. In the **Startup type** box, click **Automatic**, and then click **OK**.

### Method 2: Remove Terminal Services

If you do not need Terminal Services, or if it is not in use on the server, remove Terminal Services. To do this, follow these steps:

1. Click **Start**, point to **Settings**, and then click **Control Panel**.
2. Double-click **Add/Remove Programs**.
3. Click **Add/Remove Windows Components**.
4. In the **Windows Components Wizard**, click to clear the **Terminal Services** check box, and then click **Next**.
5. On the **Completing the Windows Components Wizard** page, click **Finish**.
6. In the **Add/Remove Programs** window, click **Close**.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article. This problem was first corrected in Microsoft Windows 2000 Service Pack 4.

## More information

The issue described in "Symptoms" section of this article may also occur after you install Microsoft Software Update Services (SUS) 1.0 or the Automatic Updates 2.2 client on a Windows 2000 Server-based computer with Terminal Services installed.
