---
title: Windows couldn't connect to the printer
description: Describes an issue in Windows Server 2008 R2 and in Windows 7 in which you cannot connect to a printer by using an alias CNAME resource record for a print server or a client that hosts a printer.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jokay
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
---
# Error message when you try to connect to a printer by using an alias (CNAME) resource record: Windows couldn't connect to the printer

This article provides a solution to an error that occurs when you try to connect to a printer by using an alias (CNAME) resource record.

_Applies to:_ &nbsp; Windows 10 - all editions,  Windows Server 2012 R2  
_Original KB number:_ &nbsp; 979602

## Symptoms

When you try to connect to a printer by using an alias (CNAME) resource record for a print server that is running Windows Server 2008 R2 or for a client computer that is running Windows 7 and that hosts a printer, you receive the following error message:

> Windows couldn't connect to the printer. Check the printer name and try again. If this is a network printer, make sure that the printer is turned on, and that the printer address is correct.

Additionally, the following will be seen in a Network Monitor trace:

> [client request]
34 4.421875 {MSRPC:9, SMB2:8, TCP:2, IPv4:1} IP address IP address Winspool Winspool:RpcOpenPrinterEx Request, Printer = \\\\printsvr\Microsoft XPS Document Writer  
[server response]
37 4.843750 {MSRPC:9, SMB2:8, TCP:2, IPv4:1} IP address IP address Winspool Winspool:RpcOpenPrinterEx Response, Status = ERROR_INVALID_PRINTER_NAME

## Cause

This issue can occur because of optimization changes to the spooler code for non-clustered computers. When the operating system loads, the Print Spooler service loads the local name of the computer and the other local names that are in the DNS cache. The Print Spooler service uses the local names to service requests. So the service must gain access to the network and then query for names such as an alias (CNAME) resource record. This behavior decreases the performance of the service.

## Workaround

To work around this issue, use the following command to add a registry key on the print server that is running Windows 2008 Server R2 and that is being accessed by an alias (CNAME) resource record:

`reg add HKLM\SYSTEM\CurrentControlSet\Control\Print /v DnsOnWire /t REG_DWORD /d 1`

> [!NOTE]
>
> - Some 3rd party DNS Providers require the use of QWord. Please remove the DWord if it exists.
> - This registry key decreases performance. SO we recommend that you add this registry key on only the print servers that must be accessed by an alias (CNAME) resource record. After modifying the registry entry, please restart the Print Spooler service for the entry to take effect.

## More information

Load-balancing printers by using a Network Load Balancing (NLB) technology or the Domain Name System (DNS) round robin feature isn't supported. The workaround that is mentioned in this article is only for the scenario where one print server that is running Windows Server 2008 R2 is accessed by an alias (CNAME) resource record that refers to only that one server.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
