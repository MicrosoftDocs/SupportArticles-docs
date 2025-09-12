---
title: WinRM client cannot process the request when connect to Exchange Online
description: The WinRM client cannot process the request because the server name cannot be resolved error occurs when you connect Exchange Online through remote Windows PowerShell.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# (WinRM client cannot process the request) error when you connect to Exchange Online through remote Windows PowerShell

## Problem

When you use remote Windows PowerShell to connect to Exchange Online in Microsoft 365, you receive the following error message:

> [outlook.office365.com] Connecting to remote server failed with the following error message:  
> The WinRM client cannot process the request because the server name cannot be resolved. For more information, see the about_Remote_Troubleshooting Help topic.
>
> \+ CategoryInfo : OpenError:  
> (System.Manageme....RemoteRunspace:RemoteRunspace) [].  
> PSRemotingTransportException
>  
> \+ FullyQualifiedErrorId : PSSessionOpenedFailed

## Cause

This issue occurs in one of the following situations:

- A firewall blocks necessary traffic.
- The Windows Remote Management service isn't started.
- The proxy server doesn't work correctly.

## Resolution

- Make sure that the firewall doesn't block necessary traffic.
- Check whether the Windows Remote Management service is installed and has started:

   1. Type *services.msc* in the **Run** dialog box, and then press Enter.
   1. In the Services MMC, double-click **Windows Remote Management**.
   1. Set the startup type to **Manual**, and then click **OK**.
   1. Right-click the service, and then select **Start**.
   1. Let the service start.

      > [!NOTE]
      > If the service was already started but it's not responding, you may have to click **Restart**.
   1. Try to connect to Exchange Online again.
- Check the proxy server setting

   1. Open an elevated Command Prompt.
   1. Run the following command to verify the current proxy configuration:

      ```console
      netsh winhttp show proxy
      ```

   1. Take one of the following actions:

      - To reset the WinHTTP proxy, run the following command:

        ```console
        netsh winhttp reset proxy
        ```

      - To configure a new proxy server, run the following command:

        ```console
        netsh winhttp set proxy <proxy>:<port>
        ```

        For example, run `netsh winhttp set proxy 10.0.0.6:8080`.

## More information

For more information about Microsoft 365 endpoints, see [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges).

For more information about how to connect to Exchange Online by using remote PowerShell, go to [Connect to Exchange Online using Remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
