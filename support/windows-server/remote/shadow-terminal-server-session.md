---
title: Shadow a Terminal Server session
description: Describes how to shadow a Terminal Server session without a prompt for approval.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, SPAT, ELDENC
ms.custom: sap:Remote Desktop Services and Terminal Services\Deployment, configuration, and management of Remote Desktop Services infrastructure, csstroubleshoot
---
# How to shadow a Terminal Server session without a prompt for approval

This article describes how to shadow a Terminal Server session without a prompt for approval.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 292190

## Summary

If you would like to shadow the Terminal Server console (session 0) in a Terminal Server session, and you don't want to be prompted for permission, set the local Group Policy on the server that is running Terminal Services.

## More information

To shadow other sessions, on the **RDP-TCP Properties** dialog box, on the **Remote Control** tab, click to clear the **require users permission** check box. It doesn't affect the console session.

To remote control the console with no prompt for approval:

1. Open Group Policy Editor (Gpedit.msc) on the server that is running Terminal services.
2. Under **Computer Configuration**, expand **Administrative templates**, expand **Windows Components**, and then select **Terminal Services**.
3. Right-click **Sets rules for remote control of Terminal Services user sessions**, and then select **Properties**.
4. Select the **Enabled** option.
5. Under **Options**, select **Full Control without user's permission**.
6. Select **OK**, and then quit Group Policy Editor. To update the local policy immediately afterward, go to a command prompt and run the following command:

    ```console
    gpupdate /force
    ```

Now, if you establish a Remote Desktop session, you can connect to the console and remote control it by going to a command prompt and using the following command:

```console
Shadow 0
```

You shouldn't be prompted on the console for permission.
