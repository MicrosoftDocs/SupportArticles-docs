---
title: Errors when you connect to a shared printer by using a CNAME record
description: This article describes two issues that occur when you connect to a shared printer by using a CNAME record
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration:-general-issues, csstroubleshoot
---
# Errors when you connect to a shared printer by using a CNAME record

This article provides a resolution for fixing the errors when you connect to a shared printer by using a CNAME record.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2965564

## Summary

This article describes two error messages that occur when you connect to a shared printer by using a CNAME record.

## Symptoms

### Error 1

You provide an alternative Universal Naming Convention UNC (UNC) path for a Windows Server 2008 R2-based printer server. The UNC path uses a CNAME DNS record. The following error message is received when clients try to connect to the printer:  
>Operation could not be completed (error 0x00000709). Double-check the printer name and make sure that the printer is connected to the network.  

 For more information about this issue, click the following article number to view the article in the Microsoft Knowledge Base:  
> [2546625](https://support.microsoft.com/help/2546625)"Operation could not be completed (error 0x00000709)" error when you use a CNAME record for a print server in Windows Server 2008 R2  

### Error 2

Clients receive the following error message when you use a CNAME DNS record to connect to a printer server that is running Windows Server 2008 R2 or Windows 7:  
>Windows couldn't connect to the printer. Check the printer name and try again. If this is a network printer, make sure that the printer is turned on, and that the printer address is correct.  

 For more information about this issue, click the following article number to view the article in the Microsoft Knowledge Base:  
>[979602](https://support.microsoft.com/help/979602) Error message when you try to connect to a printer by using an alias (CNAME) resource record: "Windows couldn't connect to the printer"  

## Resolution

To resolve these issues, use the following commands:
```
reg add hklm\system\currentcontrolset\control\print /v DnsOnWire /t REG_DWORD /d 1
reg add hklm\system\currentcontrolset\services\lanmanserver\parameters /v DisableStrictNameChecking /t REG_DWORD /d 1
reg add hklm\system\currentcontrolset\services\lanmanserver\parameters /v OptionalNames /t REG_SZ /d " aliasname "
```

> [!NOTE]
>  For third-party DNS providers, you may have to use QWord instead of DWord . Therefore, you should use QWord instead of DWord for these commands.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
