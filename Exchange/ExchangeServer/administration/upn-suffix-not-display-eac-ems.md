---
title: UPN suffix doesn't show up in EAC or EMS in Exchange Server 2013
description: Fixes an issue UPN suffix isn't showing in Exchange Admin Center or Exchange Management Shell.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Permissions\Need help with Mailbox permissions (Send As, Send on Behalf, Full Access)
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: charray, jupierr, junyli, a-rymats, erleixu, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# UPN suffix isn't displayed in EAC or EMS in an Exchange Server 2013 environment

_Original KB number:_ &nbsp;2909303

## Symptoms

Assume that you add a user principal name (UPN) suffix by using Active Directory Domains and Trusts on a domain controller that's running Microsoft Windows Server 2012 R2 in a Microsoft Exchange Server 2013 environment. When you check the UPN by using Exchange Admin Center (EAC) or by running the `Get-UserPrincipalNamesSuffix` cmdlet in Exchange Management Shell (EMS), the added UPN suffix isn't displayed.

## Cause

This issue occurs because the Exchange Trusted Subsystem security group doesn't have permissions to read the *CN=Partitions,CN=Configuration,DC= **YourDomain**,DC= **YourRootDomain*** entry.

## Workaround

To work around this issue, follow these steps to add the Read permission to the Exchange Trusted Subsystem security group:

1. Start the Active Directory Service Interfaces (ADSI) Edit tool.
1. On the **Action** menu, click **Connect to**.
1. In the **Connection Point** area, click **Select a well known Naming Context**, and then click **Configuration** in the list.
1. In the **Computer** area, click **Select or type a domain or Server**, and then type the fully qualified domain name (FQDN) of the server in the box. Or, click **Default (Domain or Server that you logged in to)** if it's suitable for your circumstances. Then, click **OK**.
1. Expand **CN=Configuration,DC=**YourDomain**,DC=**YourRootDomain****.
1. Right-click **CN=Partitions**, and then click **Properties**.
1. On the **Security** tab, add **Exchange Trusted Subsystem**, click **OK**.
1. Select the **Read** permission for the Exchange Trusted Subsystem security group, and then click **OK**.
1. Exit the tool.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More information

For more information about how to add UPN suffixes by using Active Directory Domains and Trusts, see [How to add UPN suffixes](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc772007(v=ws.11)).

For more information about the `Get-UserPrincipalNamesSuffix` cmdlet, see [General information about the Get-UserPrincipalNamesSuffix cmdlet](/powershell/module/exchange/get-userprincipalnamessuffix).

For more information about the ADSI Edit tool, see [ADSI Edit](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)).
