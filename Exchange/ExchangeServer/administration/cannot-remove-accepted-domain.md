---
title: Can't remove an accepted domain
description: Resolves a problem in which you can't delete an accepted domain in Exchange Server 2007 or Exchange Server 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010
  - Exchange Server 2007
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Error (Cannot remove the domain) when you remove an accepted domain in Exchange Server 2007 or in Exchange Server 2010

_Original KB number:_ &nbsp; 2741195

## Symptoms

Consider the following scenario:

- Exchange Server 2007 or Exchange Server 2010 coexists with an earlier version of Exchange Server in an environment.

- You use the Exchange System Manager to add and enable a new Simple Mail Transfer Protocol (SMTP) email address policy by using recipient policies.

- You use the Exchange Management Console to create an accepted domain for the new SMTP email address.

- You try to delete the accepted domain by using the Exchange Management Console or the Exchange Management Shell.

In this scenario, you can't remove the domain and you receive an error message that resembles the following message:

> Cannot remove the domain <Domain.com> because it is referenced by the proxy address template `smtp:@alternativedomain.com`.

> [!NOTE]
> The Exchange System Manager is the management tool for Exchange 2000 Server and for Exchange Server 2003. The Exchange Management Console is the management tool for Exchange Server 2007 and for Exchange Server 2010.

## Cause

This problem occurs because the accepted domain references an SMTP email address policy that still exists in the Exchange Organization.

For example, you create the `@alternativeDomain.com` SMTP email address policy in Exchange Server 2003. Then, you create the `alternativeDomain.com` accepted domain. However, you can't remove the `alternativeDomain.com` accepted domain until you remove the `@alternativeDomain` SMTP email policy.

## Resolution

To resolve this problem, follow these steps.

> [!NOTE]
> Before you follow these steps, you can first try to use the Exchange System Manager or the Exchange Management Console to remove the SMTP email address policy that is referenced by the accepted domain.

> [!WARNING]
> If you use the Active Directory Service Interfaces (ADSI) Edit snap-in, the LDP utility, or any other LDAP client to incorrectly change the attributes of Active Directory objects, you can cause serious problems. These problems may require you to reinstall Windows Server and Microsoft Exchange Server. Microsoft cannot guarantee that problems that occur if you incorrectly change Active Directory object attributes can be resolved. Change these attributes at your own risk.

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *Adsiedit.msc* and then click **Ok**.
3. Right-click **ADSI Edit**, and then click **Connect to**.
4. In the **Select a well know Naming Context** list, select **Default naming context**. In the **Select or type a domain or server** box, type the FQDN of a Domain Controller server, and then click **Ok**.
5. Expand **Configuration [dc.domain.com]**, expand **CN=Configuration,DC=domain,DC=com**, expand **CN=Services**, expand **CN=Microsoft Exchange**, expand **CN=\<Your Organization>**, and then click **CN=Recipient Policies**.
6. In the **Action** pane, right-click the **CN=Default Recipient** policy, and then select **Properties**.
7. In the **Attributes** list, double-click **gatewayProxy**, and then remove the SMTP email address that is referenced by the accepted domain from the **Values** box.
8. In the **Attributes** list, double-click **DisabledgatewayProxy**, and then remove the SMTP email address that is referenced by the accepted domain from the **Values** box.
9. If you have multiple recipient policies, check every recipient policy, and then remove the SMTP email address.

## More information

You may receive the following warning message when you use the Exchange Management Console to edit the recipient policy:

> Unable to edit the specified E-mail address policy. E-mail address policies created with legacy versions of Exchange must be upgraded using the 'Set-EmailAddressPolicy' task, with the **<Exchange 2007 or Exchange 2010>** Recipient Filter specified.

To resolve this problem, run the following cmdlet:

```powershell
Set-EmailAddressPolicy -Identity "Default Policy" -IncludedRecipients AllRecipients
```

For more information about this problem, see [Address List and EAP filter upgrades with Exchange Server 2007](https://techcommunity.microsoft.com/t5/exchange-team-blog/address-list-and-eap-filter-upgrades-with-exchange-server-2007/ba-p/598472).
