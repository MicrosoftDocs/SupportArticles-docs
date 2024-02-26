---
title: Error code 80080005 when you start many COM+ applications
description: Explains that you may receive an error message when you start lots of COM+ applications manually from a Component Services MMC snap-in. Provides a resolution to change the value of a registry key that allows more COM+ applications to run.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:com+-administration-configuration-and-security, csstroubleshoot
---
# Error when you start many COM+ applications: Error code 80080005 -- server execution failed

This article provides a workaround for an issue where you receive error code 80080005 when you start many Microsoft COM+ applications manually from a Component Services Microsoft Management Console (MMC) snap-in.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 870655

## Symptoms

When you start many Microsoft COM+ applications manually from the Component Services Microsoft Management Console (MMC) snap-in where each COM+ application is running under a different user account, you may receive the following error message:

> Catalog Error: An error occurred while processing the last operation. Error code 80080005 -- server execution failed. The event log may contain additional troubleshooting information.

You will receive an error message that is similar to the following in the application log of Event Viewer:

```output
Type: Error
Source: DCOM

Category: None
Event ID: 10010

Date: 31/03/2004

Time: 15:13:30

User: NT AUTHORITY\SYSTEM

Computer: MSHSRMSWEBP0007

Description: The server {F1673109-CF44-468D-9E23-FE4116F84CFA} did not register with DCOM within the required timeout.
```

## Cause

If many COM+ applications run under different user accounts that are specified in the **This User** property, the computer cannot allocate memory to create a new desktop heap for the new user. Therefore, the process cannot start.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around this problem, modify the value of the following registry subkey:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\SubSystems\Windows`

To do this, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. In Registry Editor, locate the following registry subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\SubSystems`

    By default, the **Windows** entry in the subkey has a value that is similar to the following (all on one line):

    %SystemRoot%\\system32\\csrss.exe ObjectDirectory=\\Windows SharedSection=1024,3072 Windows=On SubSystemType=Windows ServerDll=basesrv,1 ServerDll=winsrv:UserServerDllInitialization,3 ServerDll=winsrv:ConServerDllInitialization,2 ProfileControl=Off MaxRequestThreads=16

3. Right-click the **Windows** entry, and then click **Modify**. The **Edit String** dialog box appears.
4. In the **Value data** box, locate SharedSection, add 512 to SharedSection, and then click **OK**.

    The newly changed **Windows** entry reads as follows:

    %SystemRoot%\\system32\\csrss.exe ObjectDirectory=\\Windows SharedSection=1024,3072,512 Windows=On SubSystemType=Windows ServerDll=basesrv,1 ServerDll=winsrv:UserServerDllInitialization,3 ServerDll=winsrv:ConServerDllInitialization,2 ProfileControl=Off MaxRequestThreads=16

## Steps to reproduce the behavior

1. Create 100 different local user accounts on your computer.

2. Open the Component Services MMC snap-in. To do this, follow these steps:
    1. Click **Start**, point to **Settings**, and then click **Control Panel**.
    2. In Control Panel, double-click **Administrative Tools**, and then double-click **Component Services**. The **Component Services** MMC snap-in appears.
    3. In the left pane, expand **Component Services**, expand **Computers**, and then expand **My Computer**.

3. Create a COM+ application, and then set the application identity of the COM+ application. To do this, follow these steps:
    1. Right-click **COM+ Applications**, point to **New**, and then click **Application**. The **Welcome to the COM Application Install Wizard** dialog box appears.
    2. In the **Welcome to the COM Application Install Wizard** dialog box, click **Next**. The **Install or Create a New Application** dialog box appears.
    3. Click **Create an empty application**. The **Create Empty Application** dialog box appears.
    4. In the **Enter a name for the new application** box, type *MyCOM1*, and then click **Next**. The **Set Application Identity** dialog box appears.
    5. Click **This user**, and then type a user name that you created in step 1 in the **User** box.
    6. In the **Set Application Identity** dialog box, type your password in the **Password** box and in the **Confirm Password** box, and then click **Next**. The **Thank you for using the COM Application Install Wizard** dialog box appears.
    7. Click **Finish**.

4. Add a component to the COM+ application. To do this, follow these steps:
    1. In the left pane of the **Component Services** MMC snap-in, expand **MyCom1**.
    2. Right-click **Components**, point to **New**, and then click **Component**. The **Welcome to the COM Component Install Wizard** dialog box appears.
    3. Click **Next**. The **Import or Install a Component** dialog box appears.
    4. Click **Import component(s) that are already registered**. The **Choose Components to Import** dialog box appears.
    5. In the **Components on: My Computer** list, click a component, and then click **Next**. The **Thank you for using the COM Application Install Wizard** dialog box appears.
    6. Click **Finish**.

5. Repeat step 3 to create 100 COM+ applications that run under different local user accounts.

6. Repeat step 4 to add components to the 100 COM+ applications that you created in step 5.

7. In the left pane of the **Component Services** MMC snap-in, right-click each COM+ application that you created, and then click **Start**. After you start some COM+ applications, you receive the error message that is described in the [Symptoms](#symptoms) section.

## References

[Creating a New COM+ Application](/windows/win32/cossdk/creating-a-new-com--application)
