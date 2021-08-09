---
title: Microsoft Dynamics CRM Claims and IFD Collector
description: This article describes Microsoft Dynamics CRM Claims and IFD Collector.
ms.reviewer: 
ms.topic: article
ms.date: 3/31/2021
---
# Microsoft Dynamics CRM Claims and IFD Collector

This article describes Microsoft Dynamics CRM Claims and IFD Collector.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2764416

## Summary

The Microsoft Dynamics CRM Claims and IFD Collector was designed to collect information to be used to troubleshoot issues related to setup and configuration of Claims and Internet Facing Deployment for Microsoft Dynamics CRM.

## More information

This article offers an overview of the information that may be collected by the Microsoft Dynamics CRM Claims and IFD Collector.

> [!NOTE]
>
> - This collector is run on the server hosting the Active Directory Federation Service 2.0 service
>
> - This collector creates two report files. Both files are prefaced with the *ComputerName* on which the Microsoft Support Diagnostic Tool is run.
>
> - In the event that the ADFS service and CRM Server are on separate machines, the user will be prompted to enter the hostname of the CRM Server. This feature does not support connections to CRM servers in different domains.

Information Collected

- Operating System Information

    | Description| File Name |
    |---|---|
    |Operating System Version Information|{Computername}_ADFSReport_{DateRan}.htm</br>{Computername}_CRMClaimsReport_{DateRan}.htm|

- Application Logs

    | Description| File Name |
    |---|---|
    |Event Log - All ADFS 2.0 events in the last seven days</br>Event Log - All system events in the last seven days|{Computername}_ADFSReport_{DateRan}.htm|

- Federation Service Properties

    | Description| File Name |
    |---|---|
    |Details from the AD FS 2.0 service using the Microsoft.Adfs.Powershell snapin|{Computername}_ADFSReport_{DateRan}.htm|

- IIS URL ACL Information

    | Description| File Name |
    |---|---|
    |Provides the output from the Netsh Http Show UrlAcl command-line utility|{Computername}_ADFSReport_{DateRan}.htm|

- AD FS 2.0 Endpoint Information

    | Description| File Name |
    |---|---|
    |Listing of the configured endpoints in AD FS 2.0 using the Microsoft.Adfs.Powershell snapin|{Computername}_ADFSReport_{DateRan}.htm|

- AD FS 2.0 Relying Party Trust Information

    | Description| File Name |
    |---|---|
    |Details the relying party trusts that have been configured in AD FS 2.0 using the Microsoft.Adfs.Powershell snapin|{Computername}_ADFSReport_{DateRan}.htm|

- AD FS 2.0 Claims Provider Trust Information

    | Description| File Name |
    |---|---|
    |Details the Claims provider trusts that have been configured in AD FS 2.0 using the Microsoft.Adfs.Powershell snapin|{Computername}_ADFSReport_{DateRan}.htm|

- AD FS 2.0 Certificate Information

    | Description| File Name |
    |---|---|
    |Detailed listing of the certificates used for the AD FS Service Communication, Token Signing, and Token Decryption|{Computername}_ADFSReport_{DateRan}.htm|

- IIS Application Pool Settings

    | Description| File Name |
    |---|---|
    |Detailed list of all application pools that are present on the server that is running IIS and the AD FS 2.0 service|{Computername}_ADFSReport_{DateRan}.htm|

- IIS Applications Running Under AD FS Application Pool

    | Description| File Name |
    |---|---|
    |Listing of the applications that have configured to run under the context of the AD FS 2.0 Application Pool|{Computername}_ADFSReport_{DateRan}.htm|

- IIS Authentication Information

    | Description| File Name |
    |---|---|
    |Detailed listing of the authentication settings for the AD FS web site and its application. The sites include:</br>'Default Web Site'</br>'Default Web Site'/adfs</br>'Default Web Site'/adfs/|{Computername}_ADFSReport_{DateRan}.htm|

- IIS Application Pool Settings For CRM Server

    | Description| File Name |
    |---|---|
    |Detailed listing of all application pools that are present on the server that is running IIS and the CRM Server.|{Computername}_CRMClaimsReport_{DateRan}.htm|

- Microsoft Dynamics CRM Server Certificate Information

    | Description| File Name |
    |---|---|
    |Provides information related to the certificate that is assigned to the Microsoft CRM website|{Computername}_CRMClaimsReport_{DateRan}.htm|

- Microsoft Dynamics CRM Federation Provider Information

    | Description| File Name |
    |---|---|
    |Listing of the details for the configured Microsoft Dynamics CRM Federation Provider that is stored in the MSCRM_Config.FederationProvider table|{Computername}_CRMClaimsReport_{DateRan}.htm|

- Microsoft Dynamics CRM Web Address Information

    | Description| File Name |
    |---|---|
    |Detailed listing of the web addresses that have been used to configure Microsoft Dynamics CRM 2011 for Claims-based authentication.|{Computername}_CRMClaimsReport_{DateRan}.htm|

- Microsoft Dynamics CRM Internet Facing Deployment (IFD) Information

    | Description| File Name |
    |---|---|
    |Listing of properties from the MSCRM_Config.Deployment table that are used to configure Microsoft Dynamics CRM as an Internet Facing Deployment.|{Computername}_CRMClaimsReport_{DateRan}.htm|

- Microsoft Dynamics CRM IIS URL ACL Information

    | Description| File Name |
    |---|---|
    |Provides the output from the Netsh Http Show UrlAcl command-line utility| {Computername}_CRMClaimsReport_{DateRan}.htm|

## Additional information

This collector has a notifications area at the top of the diagnostic report detailing items that may be important to make note of. These are items that aren't at the root cause of an issue but are worth noting as they may affect the performance or usability of Microsoft Dynamics CRM. For this reason, they are called out at the top of the report to give them visibility.

1. Virtualization Check - This is notification that CRM is being run with a virtual server and may experience performance issues.

1. IsDisableLoopbackCheckEnabled - Warnings that this key from the `HKLM\SYSTEM\CurrentControlSet\Control\Lsa` registry hive is or is not set. This key does impact the performance of the Microsoft Dynamics CRM server.

1. IsBackConnectionHostNames - Similar warning to the IsDisableLoopbackCheckEnabled registry key check. This can have performance implications as well.

1. CustomPluginPresenceCheck - Just notifies the customer or engineer to the presence of custom CRM Plugins in the deployment.

1. Power Plan Settings Notification - Having the CRM server's power plan settings set to something other than High Performance may have performance implications to Microsoft CRM. This displays what the power plan is set to.
