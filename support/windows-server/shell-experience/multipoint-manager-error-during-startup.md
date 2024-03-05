---
title: Multipoint Manager error during startup
description: Address an issue in which an error occurs when opening MultiPoint Manager or MultiPoint Dashboard crashes on Windows Server 2016.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:desktop-shell, csstroubleshoot
---
# Error when you start Multipoint Manager in Windows Server 2016

This article provides a solution to an error that occurs when you open MultiPoint Manager or MultiPoint Dashboard crashes in Windows Server 2016.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4051516

## Symptom

When you try to start Multipoint Manager in Windows Server 2016, you may receive the following error message:

> The MultiPoint service is not responding on this machine. To fix the issue try restarting the machine.

When this issue occurs, MultiPoint Dashboard doesn't load.

Additionally, you may notice the following text in Microsoft-Windows-WMS/Trace event logs, which are located in Event Viewer under Application and Service Logs\Microsoft\Windows\wms:

> SecurityNegotiationException

## Cause

MultiPoint uses a web service endpoint that has SSL secured by using a self-signed certificate. When the certificate is near expiration, MultiPoint generates a new certificate to replace the old certificate. When this happens, the endpoint encounters an issue, and security negotiation fails on the MultiPoint web service SSL endpoint.

## Resolution

To resolve this issue, run the following PowerShell command, or manually delete the certificate.

### Method 1: Run PowerShell command from an elevated command prompt

```powershell
net stop wms; $hostname = (Get-WmiObject -Class Win32_ComputerSystem -Property Name).Name; Get-ChildItem -Path 'Cert:\localmachine\MultiPoint Services Certificates\' | ForEach-Object {if ($_.Subject -like ('*'+$hostname+'*')) {Write-Host ('Removing '+$_.Thumbprint); Remove-Item -Path ('Cert:\localmachine\MultiPoint Services Certificates\'+$_.Thumbprint)}}; net start wms
```

### Method 2: Manually delete the certificate

1. Find the local host name. To do this, you can run the command **hostname** from a command prompt.
2. Open an elevated Command Prompt window and run **net stop wms**.
3. Run **mmc.exe**.
4. Press Ctrl+M to add a new snap-in.
5. From the list of available snap-ins on the left side, select **Certificates** to add it to the list. Choose **Computer account** from among the three options, and then choose **Local computer: (the computer this console is running on)**.
6. Find **MultiPoint Services Certificates** in the list of certificates for the local computer, and then delete all the certificates for which **Issued By** is the local host name.
7. Run **net start wms** in the Command Prompt window. When the MultiPoint service starts, it will create a new certificate.
