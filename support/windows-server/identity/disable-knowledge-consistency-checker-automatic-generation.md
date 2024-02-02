---
title: Disable KCC from creating replication topology
description: Describes how to disable the Knowledge Consistency Checker from automatically creating replication topology.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
ms.subservice: active-directory
---
# How to disable the Knowledge Consistency Checker from automatically creating replication topology

This article describes how to disable the Knowledge Consistency Checker from automatically creating replication topology.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 242780

## Summary

The Knowledge Consistency Checker (KCC) is a Microsoft Windows 2000 and Microsoft Windows Server 2003 component that automatically generates and maintains the intra-site and inter-site replication topology. You can disable the KCC's automatic generation of intra-site or inter-site topology management, or both.

## More information

In some situations you may want to manually create replication connections to tailor the replication topology, but this increases the workload for monitoring for changes in the network topology described in Active Directory or replication failures occurring on domain controllers.

The KCC runs at regular intervals to adjust the replication topology for changes that occur in Active Directory, such as adding new domain controllers and new sites that are created. At the same time, the KCC reviews the replication status of existing connections to determine if any connections are not working. If a connection is not working, after a threshold is reached, KCC automatically builds temporary connections to other replication partners (if available) to insure that replication is not blocked.

> [!NOTE]
> When automatic replication topology management is disabled, the failover detection mentioned above is also disabled.

You can use the Ldp.exe tool that is included in the Windows 2000 or Windows Server 2003 Resource Kit to perform Lightweight Directory Access Protocol (LDAP) searches against Active Directory for specific information given search criteria. This also lets you query data that is otherwise not visible using the administrative tools included in Windows 2000. However, all information that is returned in LDP queries is subject to security permissions.

### How to Modify Active Directory to Disable KCC for a Site

1. Run Setup.exe (if it is not already installed) from the Support\\Tools folder of the Windows 2000 or Windows Server 2003 CD-ROM. This installs the Support Tools Kit.
2. Run Ldp.exe
3. On the Connection menu, click Connect.
4. Type the server name of a domain controller in the enterprise, verify that the port setting is 389, click to clear the **connectionless** check box, and then click OK. After the connection is complete, server-specific data is displayed in the right pane.
5. On the Connection menu, click Bind. Type the user name, password, and domain name (in DNS format) in the appropriate boxes (you may need to click to select the Domain check box), and then click OK. If the binding is successful, you should receive a message in the right pane that is similar to the following example:  
    Authenticated as dn: **YourUserID**  
6. On the View menu, click Tree.
7. In the BaseDN box, type the distinguished name of the site object in the configuration container of the forest. For example, for the Default-First-Site-Name site in the `Mydomain.com` forest, the domain name would look like the following example:  
CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=MYDOMAIN,DC=COM

    If this object is located, LDP should display the object in the left pane.
8. Expand the view. One of the child objects should begin with CN=NTDS Site Settings. Double-click this object. In the right pane, LDP should output the current settings for the attributes for this object. Each attribute is preceded by a number and then an angle bracket (>). The number represents the number of values the attribute contains.
9. Look for the "options" attribute. If it is not present, this is normal and makes modifying the value easier.

    > [!NOTE]
    > If the "options" attribute is present and the value is not 0, you need to determine the current flags that are set and use the values below to construct the new value before continuing to the next step.
10. In the right-hand pane, locate the beginning of the output for the NTDS Site Settings object. It looks similar to the following example:

    > Expanding base 'CN=NTDS Site Settings,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=MYDOMAIN,DC=COM'...  
    Result <0>: (null)  
    Matched DNs:  
    Getting 1 entry:  
    \>> Dn: CN=NTDS Site Settings,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=MYDOMAIN,DC=COM

11. Copy the string of data from the ">> Dn" portion of the LDP output.
12. On the Browse menu, click Modify. In the Dn box, paste the string you copied in the previous step.
13. In the Attribute box, type options.
14. In the Values box, type the appropriate value:

    - To disable automatic intra-site topology generation, use value 1 (decimal).
    - To disable automatic inter-site topology generation, use value 16 (decimal).
    - To disable both intra-site and inter-site topology generation, use value 17 (decimal).

15. In the Operation box, click Replace, click Enter, and then click Run.
16. In the right pane, the output should look similar to the following example if the operation is successful:
    > ***Call Modify...
    ldap_modify_s(ld,'CN=NTDS Site Settings,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=MYDOMAIN,DC=COM',[1] attrs);  
    Modified "CN=NTDS Site Settings,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=MYDOMAIN,DC=COM".

> [!NOTE]
> To re-enable KCC generation, delete the value that you entered in step 14 in this section.

To determine if these values are set correctly, you can use Active Directory Replication Monitor (also included with the Support Tools installation) to generate a report on the site configuration. Included in this information is output similar to the following example:

> Site Name: Default-First-Site-Name  
\---------------------------------------  
Site Options: NTDSSETTINGS_OPT_IS_AUTO_TOPOLOGY_DISABLED   NTDSSETTINGS_OPT_IS_INTER_SITE_AUTO_TOPOLOGY_DISABLED  
Site Topology Generator: CN=NTDS Settings,CN=ESTAD-CESSNA,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=ifr,DC=com  
Site Topology Renewal:  
Site Topology Failover:  

> [!NOTE]
> NTDSSETTINGS_OPT_IS_AUTO_TOPOLOGY_DISABLED means that intra-site topology management is disabled, and NTDSSETTINGS_OPT_IS_INTER_SITE_AUTO_TOPOLOGY_DISABLED means that inter-site topology management is disabled.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
