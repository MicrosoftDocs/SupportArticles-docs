---
title: AD Replication error 1908
description: Provides a resolution for troubleshooting AD Replication error 1908, which is Could not find the domain controller for this domain.
ms.date: 09/01/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:domain-join-issues, csstroubleshoot
ms.subservice: active-directory
---
# Troubleshooting AD Replication error 1908: Could not find the domain controller for this domain

This article provides a resolution for troubleshooting AD Replication error 1908: Could not find the domain controller for this domain.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2712026

>[!NOTE]
**Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, please [ask the Microsoft Community](https://answers.microsoft.com).

## Symptoms

1. REPADMIN.exe reports that replication attempt has failed with status 1908.  

    REPADMIN commands that commonly cite the 1908 status include but are not limited to:

    - `REPADMIN /ADD`
    - `REPADMIN /REPLSUM *`
    - `REPADMIN /REHOST`
    - `REPADMIN /SHOWVECTOR /LATENCY`
    - `REPADMIN /SHOWREPS`
    - `REPADMIN /SHOWREPL`

    Sample output from `repadmin /syncall` command:

    ```console  
    Syncing all NC's held on CONTOSO-DC02.  
    Syncing partition: DC=ForestDnsZones,DC=Contoso,DC=com  
    CALLBACK MESSAGE: Error contacting server 1b136427-14f0-448a-965c-  
    9cbb61400fcd._msdcs.Contoso.com (network error): 1908 (0x774):  
     Could not find the domain controller for this domain.  
    ```  

    Sample output from `repadmin /showreps` command:

    ```console
    DC=ForestDnsZones,DC=Contoso,DC=com  
    HQ\Contoso-DC02 via RPC  
    DC object GUID:1b136427-14f0-448a-965c-9cbb61400fcd._msdcs.Contoso.com/  
    Last attempt @ <DATE> <TIME> failed, result 1908 (0x774):  
    Could not find the domain controller for this domain.  
    <# consecutive failure>  
    <Last Success>  
    ```

2. NTDS KCC, NTDS Replication events with the 1908 status are logged in the directory service event log.  

    Active Directory events that commonly cite the 1908 status include but are not limited to:

    |Event Source|Event Category|Event ID|Event Type|Event String|
    |---|---|---|---|---|
    |NTDS KCC|Knowledge Consistency Checker|1926|Warning|The attempt to establish a replication link to a read-only directory partition with the following parameters failed.|
    |NTDS KCC|Knowledge Consistency Checker|1925|Warning|The attempt to establish a replication link for the following writable directory partition failed.|
    |NTDS Replication|Replication|1943|Error|Active Directory was unable to remove all of the lingering objects on the local domain controller. However, some lingering objects might have been deleted on this domain controller before this operation stopped. All objects had their existence verified on the following source domain controller.|
    |NTDS Replication|Setup|1125|Error|The Active Directory Domain Services Installation Wizard (Dcpromo) was unable to establish connection with the following domain controller.|

    These events will contain the following sub Error Value:  

    Additional Data  
    Error Value:  
    Could not find the domain controller for this domain. 1908

3. When trying to force replication in Active Directory Sites and Services console (dssite.msc) via the "Replicate now" option, we may receive below error:  

    >Dialog title text: Replicate Now
    >
    >Dialog message text: The following error occurred during the attempt to synchronize naming context \<Naming Context> from Domain Controller \<Source-DC-Name> to Domain Controller \<Destination-DC-Name>: Could not find the domain controller for this domain.
    >
    >Failure Message: Could not find the domain controller for this domain.
    >
    >Buttons in Dialog: OK  

4. Domain Controller Promotion/Demotion  

    Dialog Box on Dcpromo.exe Failure:  

    Dialog title text: Active Directory Installation Wizard  

    Dialog message text: Active Directory could not create the NTDS Settings object for this Domain Controller CN=NTDS Settings,CN=\<DC_Name>,CN=Servers,CN=\<SiteName>,CN=Sites,CN=Configuration,\<DomainDN> on the remove domain controller \<Remote_DC_FQDN>. Ensure the provided network credentials have sufficient permissions.  

    Failure Message: Could not find the Domain Controller for this domain.  

    Buttons in Dialog: OK  

    DCPromo.log file reports(%windir%\debug\DCPromo.log):  

    [INFO] Error - Active Directory Domain Services could not create the NTDS Settings object for this Active Directory Domain Controller CN=NTDS Settings,CN=CONTOSO-DC02,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=Contoso,DC=com on the remote AD DC `contoso-dc01.Contoso.com`. Ensure the provided network credentials have sufficient permissions. (1908)  
    [INFO] NtdsInstall for `Contoso.com` returned 1908  
    [INFO] DsRolepInstallDs returned 1908  
    [ERROR] Failed to install to Directory Service (1908)  

## Cause

Error Code 1908 represents the error  that displays as "Could not find the domain controller for this domain." This error has two primary causes:

1. The destination DC is unable to contact a Key Distribution Center(KDC)

2. The computer is experiencing Kerberos related errors

An important concept to understand for this scenario is that the KDC used for replication operations may be:

a. The destination DC  
b. The source DC  
c. An entirely different DC (not the source or destination DC).  

## Resolution

1. Verify the Key Distribution Service is running on the Target Domain Controller  

    Discover the Kerberos Key Distribution Center you are contacting. It can be discovered by using a packet capture program like [Network Monitor 3.4](https://www.microsoft.com/download/details.aspx?id=4865).

    1. Use Network Monitor to capture the reproduced error message. (You may need to stop the DNS client service first so that you see the DNS query traffic)

    2. Review the packet capture for the DNS query for a KDC:
    Sample Address Queries:

        _kerberos._tcp._\<SiteName>._sites.dc._msdcs.\<Domain>.com  
        _kerberos._tcp.dc._msdcs.\<Domain>.com

    3. Review for any `DCLocator` Traffic:  
    Sample Network Monitor 3.4 capture of DcLocator Traffic. In this example, 10.0.1.11 is the KDC we discovered and 10.0.1.10 is the client requesting a ticket. It uses the default Network Monitor Column layout.

        |Frame #|Time and Date|Time Offset|Source IP|Destination IP|Details|
        |---|---|---|---|---|---|
        |42|3/7/2012|3.6455760|10.0.1.10|10.0.1.11|LDAPMessage: Search Request, MessageID: 371 \*** This packet is a UDP LDAP call for DC Locator looking for Netlogon***|
        |43|3/7/2012|3.6455760|10.0.1.11|10.0.1.10| NetLogon:LogonSAMPauseResponseEX (SAM Response when Netlogon is paused): 24 (0x18)|

    4. Verify that 10.10.1.11's KDC and `Netlogon` services are running.
    On discovered Domain Controller(10.0.1.11), verify the KDC and `Netlogon` service status with SC Query

        Example - Query the KDC service with: "SC Query KDC" and the `Netlogon` Service with: "SC Query Netlogon"
        These commands should return "State: Running"

2. Verify that the destination Domain Controller is Advertising as a Key Distribution Center  
Use DCDIAG.exe to verify that the destination Domain Controller is advertising. From a CMD.exe prompt, run the following command:

    ```console
    C:\DCDiag.exe /v /test:Advertising /test:SysVolCheck
    ```

    Verify that the Domain Controller passes the Advertising and SYSVOLCHeck tests and is advertising as a Key Distribution Center and `SysVol` is ready. If `SysVol` is not ready, the server will not be able to advertise as a Domain Controller.  

    >Testing server:\<SiteName>\<DC Name>  
    Starting test: Advertising  
    The DC \<DC Name> is advertising itself as a DC and having a DS  
    The DC \<DC Name> is advertising as an LDAP server  
    The DC \<DC Name> is advertising as having a writeable directory  
    The DC \<DC Name> is advertising as a Key Distribution Center  
    The DC \<DC Name> is advertising as a time server  
    The DS \<DC Name> is advertising as a GC.  

    >Starting Test: SysVolCheck
     \* The File Replication Service SYSVOL ready test  
     File Replication Service's SYSVOL is ready  
     ..\<DC Name> passed test SysVolCheck  

3. Verify that source computer and target computer are within 5 minutes of each other.

4. Check for any Kerberos failures  

    1. Enable Kerberos Event Logging on Client Machine and Domain Controllers in site.  
    2. [KB: 262177 How to enable Kerberos event logging](https://support.microsoft.com/help/262177)  
    3. [Troubleshooting Kerberos](https://technet.microsoft.com/library/cc728430%28v=ws.10%29.aspx)  

## More information

This error is one of the featured exercises in the following TechNet hands-on lab:
 TechNet hands-on lab: Troubleshooting Active Directory replication errors  
In this lab, you will walk through the troubleshooting, analysis, and implementation phases of commonly encountered Active Directory replication errors. You will use a combination of ADREPLSTATUS, repadmin.exe, and other tools to troubleshoot a five DC, three-domain environment. AD replication errors encountered in the lab include -2146893022, 1256, 1908, 8453 and 8606.
