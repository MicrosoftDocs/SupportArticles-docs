---
title: Unable to select DNS Server role when adding a domain controller into an existing Active Directory domain
description: Fixes an issue where the option to auto-install the DNS Server role is disabled or grayed out in the Active Directory Installation Wizard (DCPROMO) when promoting a Windows Server 2008 or Windows Server 2008 R2 replica domain controller.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: arrenc, kaushika
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# Unable to select DNS Server role when adding a domain controller into an existing Active Directory domain

This article helps fix an issue where the option to auto-install the DNS Server role is disabled or grayed out in the Active Directory Installation Wizard (DCPROMO) when promoting a Windows Server 2008 or Windows Server 2008 R2 replica domain controller.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2002584

## Symptoms

When promoting a Windows Server 2008 or Windows Server 2008 R2 replica domain controller, the option to auto-install the DNS Server role is disabled or grayed out in the Active Directory Installation Wizard (DCPROMO).

Text in the **Additional information** field states:

> DNS cannot be installed on this domain controller because this domain does not host DNS.

A screenshot of this condition is shown below:

:::image type="content" source="media/auto-install-dns-server-role-disabled-promte-domain-controller/dcpromo-dns-check-box-greyed.png" alt-text="Screenshot of the Active Directory Domain Services Installation Wizard window with the DNS server and Read-only domain controller checkbox greyed out.":::

The %windir%\debug\dcpromoui.log file on the replica domain controller being promoted shows the following:  

> Enter DoesDomainHostDns SLD  
dcpromoui A74.A78 046C *\<DateTime>*                 Dns_DoesDomainHostDns testing domain name SLD  
dcpromoui A74.A78 046D *\<DateTime>*                 SOA query returned 9003 so the domain does not host DNS  
dcpromoui A74.A78 046E *\<DateTime>*                 Dns_DoesDomainHostDns returning false  
dcpromoui A74.A78 046F *\<DateTime>*                 HRESULT = 0x00000000  
dcpromoui A74.A78 0470 *\<DateTime>*                 The domain does not host DNS.  

## Cause

1. A code defect prevents the DNS Server checkbox from being enabled when promoting replica domain controllers into existing domains with single-label DNS names like "contoso" instead of best-practice fully qualified DNS name like "`contoso.com`" or "`corp.contoso.com`". This condition exists even when Microsoft DNS is installed on a domain controller and hosts Active Directory-integrated forward lookup zones for the target domain.

    For more information about single label domains, visit the following Microsoft web site:  

     [Microsoft DNS Namespace Planning Solution Center](https://support.microsoft.com/gp/gp_namespace_master#tab4)  

    OR

2. DCPromo checks to see if the DNS zone for the target Active Directory forest is hosted in Active Directory. If the DNS zone for the target domain isn't hosted on an existing domain controller in the target forest, DCPROMO doesn't allow the user to install DNS during the replica promotion.

    The goal of this behavior is to prevent administrators from creating duplicate copies of DNS zones with different replication scopes (that is, file-based zones on Microsoft or third-party DNS Servers and Active Directory integrated DNS zones on domain controllers on the newly promoted domain controller).

## Resolution

For the first root cause, continue the promotion and install the DNS Server role after it's promoted.

For the second root cause, the DNS client and server configuration on the replica domain controller being promoted was sufficient to discover a helper domain controller in the target domain but DCPROMO has determined that the DNS zone for the domain wasn't Active Directory integrated.  

Determine which DNS servers are going to host the zone for your Active Directory domain and what replication scopes those zones will use (Microsoft DNS versus third-party DNS, forest-wide application partition, domain-wide application partition, file-based primary, and so on.)

Don't let the inability to auto-install the DNS Server role during DCPROMO block the promotion of Windows Server 2008 replica domain controllers in the domain. Server Manager can be used to install the Microsoft DNS Server role on existing domain controllers, as well as computers functioning as member or workgroup computers. DNS zones and their records can be replicated or copied between DNS servers.

 **Specific workarounds include:**  

1. If the DNS zones exist on DNS servers outside the domain, consider moving the zones to an existing domain controller in the domain that hosts the DNS Server role.

2. If zone data needs to be moved, configure the Microsoft DNS server to host a secondary copy of the zone, then convert that zone to be a file-based primary, then transition the zone to be Active Directory integrated as required. You can ignore this step if you have no interest in saving the DNS zone data.

3. Configure the new replica domain controller being promoted to point exclusively to DNS servers hosting Active Directory integrated copies of the zone.

4. Use the following command to force Windows 2000, Windows XP, Windows Server 2003, Windows Vista, and Windows Server 2008 computers to dynamically register Host A or AAAA records:

    ```console
    ipconfig /registerdns  
    ```

5. Use the following command to force Windows 2000, Windows Server 2003, and Windows Server 2008 domain controllers to dynamically register SRV records  

     ```console
    net stop netlogon & net start netlogon  
    ```

6. Restart DCPROMO on the replica domain controller.
