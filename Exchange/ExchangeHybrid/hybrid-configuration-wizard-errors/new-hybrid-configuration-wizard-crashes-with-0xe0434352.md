---
title: New Hybrid Configuration Wizard crashes error 0xe0434352
description: Provides methods to solve the error 0xe0434352 that occurs when the new Hybrid Configuration Wizard crashes.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, pramods, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# New Hybrid Configuration Wizard crashes with error code 0xe0434352

_Original KB number:_ &nbsp; 4014018

## Symptoms

When you run a new Hybrid Configuration Wizard, it crashes and returns exception code 0xe0434352. The detailed event log resembles the following:

> Log Name: Application  
Source: Application  
Error Date: *DateTime*  
Event ID: 1000  
Task Category: (100)  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: `Server.contoso.com`  
Description:  
Faulting application name: Microsoft.Online.CSE.Hybrid.App.exe, version: 16.0.1539.7, time stamp: 0x5849b79b  
Faulting module name: KERNELBASE.dll, version: 6.1.7601.23569, time stamp: 0x57f7c0b4  
Exception code: 0xe0434352  
Fault offset: 0x000000000001a06d  
Faulting process id: 0xc6c Faulting application start time: 0x01d254e36c3b2b79  
Faulting application path: C:\Users\server\AppData\Local\Apps\2.0\VZQBHRCH.9Y2\L5E826PT.VQO\micr..tion_c3bce3770c238a49_0010.0000_06b16895f88ffa1a\Microsoft.Online.CSE.Hybrid.App.exe  
Faulting module path: C:\Windows\system32\KERNELBASE.dll  
Report Id: 33604739-c0d7-11e6-a107-0050569c0d00

## Cause

This issue occurs if the external Exchange Web Services (EWS) URL is not set on any Exchange server.

## Resolution

To resolve this issue, set the external EWS URL. To do this, use one of the following methods.

> [!NOTE]
> In these methods, replace the `CAS_server_nameandcontoso.com` placeholders with the name of your CAS server and your domain, respectively.

### Method 1 - Use Exchange Management Shell

Run the following cmdlet in Exchange Management Shell:

```powershell
Set-WebServicesVirtualDirectory -Identity "CAS_server_name\EWS (Default Web Site)" -ExternalUrl https://mail.contoso.com/ews/exchange.asmx
```

### Method 2 - Use Exchange Admin Center

1. Sign in to Exchange Admin Center.
2. Locate **Servers** > **Virtual directories**, select your server by name, and then select type **EWS**.
3. In the **Default Web Site** dialog box, set **External URL** to `https://mail.contoso.com/ews/exchange.asmx`.

   :::image type="content" source="media/new-hybrid-configuration-wizard-crashes-with-0xe0434352/default-web-site-page.png" alt-text="Screenshot of the Default Web Site page.":::

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
