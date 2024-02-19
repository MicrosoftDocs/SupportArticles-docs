---
title: Errors when you run WinRM commands
description: Describes the errors that are triggered when you run various WinRM commands to verify local computer functionality in a Windows Remote Management environment.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:winrm, csstroubleshoot
---
# Errors when you run WinRM commands to check local functionality in a Windows Server 2008 environment

This article provides a solution to errors that occur when you run WinRM commands to check local functionality in a Windows Server 2008 environment.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2269634

## Symptoms

When you run WinRM commands to check the local functionality on a server in a Windows Server 2008 environment, you may receive error messages that resemble the following ones:

> winrm e winrm/config/listener  
WSManFault Message = The client cannot connect to the destination specified in the requests. Verify that the service on the destination is running and is accepting request. Consult the logs and documentation for the WS-Management service running on the destination, most commonly IIS or WinRM. If the destination is the WinRM service, run the following command on the destination to analyze and configure the WinRM service: "winrm quickconfig"  
Error number:  
-2144108526 0x80338012

> winrm id  
WSMan Fault  
Message = The WinRM client received an HTTP bad request status (400), but the remote service did not include any other information about the cause of the failure. Error number:  
-2144108175 0x80338171

> winrm quickconfig  
WinRM is not set up to receive requests on this machine.
The following changes must be made:  
Start the WinRM service.  
Make these changes [y/n]? y  
WinRM has been updated to receive requests.  
WinRM service started.

> WSManFault Message = The client cannot connect to the destination specified in the requests. Verify that the service on the destination is running and is accepting requests. Consult the logs and documentation for the WS-Management service running on the destination, most commonly IIS or WinRM. If the destination is the WinRM Service, run the following command on the destination to analyze and configure the WinRM Service: 'winrm quickconfig'.  
Error number: -2144108526 0x80338012

## Cause

This problem may occur if the Window Remote Management service and its listener functionality are broken.

## Resolution

To resolve this problem, follow these steps:

1. Install the latest Windows Remote Management update.

2. Run the following command to restore the listener configuration:

    ```console
    winrm invoke Restore winrm/Config
    ```

3. Run the following command to perform a default configuration of the Windows Remote Management service and its listener:

    ```console
    winrm quickconfig
    ```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#winrm).
