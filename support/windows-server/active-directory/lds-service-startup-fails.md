---
title: LDS service startup fails
description: Introduce the solution for LDS Service startup failure after you manually change msDS-Behavior-Version attribute.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, sagiv, wincicadsec
ms.custom: sap:active-directory-lightweight-directory-services-ad-lds-and-active-directory-application-mode-adam, csstroubleshoot
---
# LDS service startup fails after you manually change msDS-Behavior-Version in Windows Server 2019 and 2016

This article provides a solution to an error that LDS service startup fails after you manually change msDS-Behavior-Version.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4550446

## Symptom

In ADSI Edit, you change the **msDS-Behavior-Version** attribute of the Partitions container to **7** in order to raise the Active Directory (AD) Lightweight Directory Services (LDS) instance functional level to WIN2016.

:::image type="content" source="media/lds-service-startup-fails/attribute-editor.png" alt-text="Change the msDS-Behavior-Version attribute to 7.":::

After you restart the server or stop the LDS service, the LDS service cannot be started. When you try to manually start the service, the following event errors are logged:

> Log Name: ADAM (LDS)  
Source: ADAM [LDS] General  
Event ID: 1168  
Task Category: Internal Processing  
Level: Error  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: `LDS.CONTOSO.COM`  
Description:  
Internal error: An Active Directory Lightweight Directory Services error has occurred.
>
> Additional Data  
Error value (decimal):  
-1601  
Error value (hex):  
fffff9bf  
Internal ID:  
20801a4  

Additionally, you receive the following error message:

> Windows could not start the \<ServiceName> LDS service on Local Computer.  
> Error 0xc0000025: 0xc0000025

:::image type="content" source="media/lds-service-startup-fails/error-message.png" alt-text="Error 0xc0000025 Windows could not start the L D S service on Local Computer.":::

## Cause

Manually setting the **msDS-Behavior-Version** attribute value to **7** on LDS instances is not supported.

## Resolution

If the LDS instance contains only one server, you must restore the server from a backup to resolve the issue.

If there are multiple replica servers in that instance (for example, LDSServer1 and LDSServer2), and if one server has not yet been restarted, follow these steps:

1. If the LDS server on which the service that does not start (for example, LDSServer1) holds the LDS Roles (for example, Schema and Domain Naming FSMO), seize the roles by running ntdsutil:

    > C:\Windows\system32> **ntdsutil**  
    ntdsutil: **roles**  
    fsmo maintenance: **connections**  
    server connections: **connect to server LDSServer2:50000( 50000 is the port number in that example)**  
    Binding to LDSServer2:50000 ...  
    Connected to LDSServer2:50000 using credentials of locally logged on user.  
    server connections: **q**  
    fsmo maintenance: **seize schema master**

    :::image type="content" source="media/lds-service-startup-fails/role-seizure-confirmation-dialog.png" alt-text="A role seizure confirmation dialog displays.":::

2. Connect to the configuration partition of the server that still runs the LDS instance (for example, LDSServer2), and then roll back the functionality level version by reverting the **msDS-Behavior-Version** attribute value.

3. Run a metadata cleanup of the LDS server (LDSServer1) by using **dsmgmt**:

    > C:\Windows\system32> **dsmgmt**  
    dsmgmt: **metadata cleanup**  
    metadata cleanup: **connections**  
    server connections: **connect to server LDSServer2:50000 ( 50000 is the port number in that example)**  
    Binding to LDSServer2:50000 ...
    Connected to LDSServer2:50000 using credentials of locally logged on user.
    server connections: **q**  
    metadata cleanup: **select operation target**  
    select operation target: **list naming contexts**  
    Found 3 Naming Context(s)
    0 - CN=Configuration,CN={6B7FEBF4-017B-4366-A8B8-3E5467888DEF}
    1 - CN=Schema,CN=Configuration,CN={6B7FEBF4-017B-4366-A8B8-3E5467888DEF}
     2 - DC=LDS,DC=COM
    select operation target: **select naming context2 ( 2 stands for the domain naming context )**  
    No current site
    No current domain
    No current server
    Naming Context - DC=LDS,DC=COM
    select operation target: **list sites**  
    Found 4 site(s)
    0 - CN=Default-First-Site-Name,CN=Sites,CN=Configuration,CN={6B7FEBF4-017B-4366-A8B8-3E5467888DEF}
    1 - CN=Site1,CN=Sites,CN=Configuration,CN={6B7FEBF4-017B-4366-A8B8-3E5467888DEF}
    2 - CN=Site2,CN=Sites,CN=Configuration,CN={6B7FEBF4-017B-4366-A8B8-3E5467888DEF}
     3 - CN=Site3,CN=Sites,CN=Configuration,CN={6B7FEBF4-017B-4366-A8B8-3E5467888DEF}
    select operation target: **select site3 (where 3 is the number of the site in which the server is located,** **matching output from previous step)**  
    Site - CN=Site3,CN=Sites,CN=Configuration,CN={6B7FEBF4-017B-4366-A8B8-3E5467888DEF}
    No current domain
    No current server
    Naming Context - DC=LDS,DC=COM
    select operation target: **list servers in Site**  
    Found 1 server(s)
     0 - CN=LDSServer1,CN=Servers,CN=Site3,CN=Sites,CN=Configuration,CN={6B7FEBF4-017B-4366-A8B8-3E5467888DEF}
    select operation target: **select Server0 (where 0 is the number of the server you wish to remove, matching output from previous step)**  
    Site - CN=Site3,CN=Sites,CN=Configuration,CN={6B7FEBF4-017B-4366-A8B8-3E5467888DEF}
    No current domain
    Server - CN=LDSServer1,CN=Servers,CN=Site3,CN=Sites,CN=Configuration,CN={6B7FEBF4-017B-4366-A8B8-3E5467888DEF}
    DSA object - CN=NTDS Settings,CN=LDSServer1,CN=Servers,CN=Site3,CN=Sites,CN=Configuration,CN={6B7FEBF4-017B-4366-A8B8-3E5467888DEF}
    DNS host name - LDSServer1.CONTOSO.COM
    Naming Context - DC=LDS,DC=COM
    select operation target: **q**  
    metadata cleanup: **remove selected server**

    :::image type="content" source="media/lds-service-startup-fails/server-remove-confirmation-dialog.png" alt-text="Select Yes to remove the server object in the Server Remove Confirmation Dialog box.":::

4. Log on to LDSServer1, and uninstall the instance:

    :::image type="content" source="media/lds-service-startup-fails/uninstall-program.png" alt-text="Select the instance that you want to uninstall in Programs and features window.":::

    :::image type="content" source="media/lds-service-startup-fails/select-skip-all.png" alt-text="Select Skip All in the Active Directory Lightweight Directory Services Removal Wizard.":::

5. Run the Active Directory Lightweight Directory Services Setup (C:\Windows\ADAM\adaminstall.exe) on LDSServer1 to install a replica of the existing instance from LDSServer2.
