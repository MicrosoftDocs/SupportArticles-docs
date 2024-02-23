---
title: Test-OwaConnectivity and Test-EcpConnectivity fail
description: Describes a problem in which the external mode of the Test-OwaConnectivity and Test-EcpConnectivity cmdlet tests fails when an Exchange Server 2013 server acts as a front door for Exchange Server 2010 servers.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: dkling, vidhyab, serdars, jarrettr, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Test-OwaConnectivity and Test-EcpConnectivity cmdlet tests fail in external mode

_Original KB number:_ &nbsp; 2814954

## Symptoms

When you have an Exchange Server 2013 server that is running a Client Access server, the server functions much like a front door. It admits all client requests and routs them to the correct active Mailbox database in a group of Client Access servers that are running Exchange Server 2010.

When you run the `Test-OwaConnectivity` and `Test-EcpConnectivity` cmdlets in external mode on the Exchange Server 2010 Client Access server, the cmdlets try to test the Exchange Server 2013 server first. However, the cmdlet tests fail.

## Cause

This problem occurs because the `Test-OwaConnectivity` and `Test-EcpConnectivity` cmdlets in external mode cannot sign in successfully to the Exchange Server 2013 server.

## Workaround

To work around this problem, run the `Test-OwaConnectivity` and `Test-EcpConnectivity` cmdlets in internal mode on the Exchange Server 2010 Client Access server.
