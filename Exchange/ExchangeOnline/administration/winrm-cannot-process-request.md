---
title: WinRM client cannot process the request when connect to Exchange Online
description: Resolves an issue in which you receive a "WinRM client cannot process the request because the server name cannot be resolved" error when you try to connect Exchange Online through remote Windows PowerShell.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: troubleshooting
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---
# (WinRM client cannot process the request) error when you connect to Exchange Online through remote Windows PowerShell

## Problem

When you try to use remote Windows PowerShell to connect to Microsoft Exchange Online in Microsoft Office 365, you receive the following error message:

```asciidoc
[outlook.office365.com] Connecting to remote server failed with the following error message:
The "WinRM client cannot process the request because the server name cannot be resolved. For more information, see the about_Remote_Troubleshooting Help topic.

+ CategoryInfo : OpenError:
(System.Manageme....RemoteRunspace:RemoteRunspace) [].
PSRemotingTransportException

+ FullyQualifiedErrorId : PSSessionOpenedFailed
```

## Cause

This issue occurs if either an internal firewall or the Windows Remote Management service has not been started.

## Solution

To resolve this issue, check whether the Windows Remote Management service is installed and has started. To do this, follow these steps:

1. Do one of the following:
   - In Windows 8, press the Windows logo key+R to open the **Run** dialog box, type services.msc, and then press Enter.
   - In Windows 7 or Windows Vista, click **Start**, type `services.msc` in the **Start search** field, and then press Enter.
   - In Windows XP, click **Start**, click **Run**, type `services.msc`, and then press Enter.
2. In the Services window, double-click **Windows Remote Management**.
3. Set the startup type to **Manual**, and then click **OK**.
4. Right-click the service, and then click **Start**.
5. Let the service start.

    > [!NOTE]
    > If the service was already started but it's not responding, you may have to click **Restart**.
6. Try to connect to Exchange Online again.

## More information

For more information about how to connect to Exchange Online by using remote PowerShell, go to [Connect to Exchange Online using Remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).