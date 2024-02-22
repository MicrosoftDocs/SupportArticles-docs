---
title: Configure Excel Services in SharePoint Server 2010 for Kerberos authentication
description: Describe how to configure Excel Services in SharePoint Server 2010 for Kerberos authentication.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - Excel Services in SharePoint Server 2010
ms.date: 12/17/2023
---

# How to configure Excel Services in SharePoint Server 2010 for Kerberos authentication

## Introduction

This article describes how to configure Excel Services in Microsoft SharePoint Server 2010 for Kerberos authentication.

## More information

For more information about how to configure Kerberos constrained delegation to enable the service to update data in a worksheet from an external SQL Server data source, follow these steps:

1. Create Excel Services service account.

    As a best practice, Excel Services should run under its own domain identity. To configure the Excel Service Application, you must create an Active Directory account. For example, you create the following accounts:

    |SharePoint Server Service|IIS App Pool Identity|
    |-|-|
    |SharePoint Server Service|    IIS App Pool Identity|
    |Excel Services|    vmlab\svcExcel|

1. Configure a service principal name (SPN) on the Excel Services service account.

    You must configure Kerberos constrained delegation if Excel Services will delegate the client's identity to a back-end data source. For example, if Excel Services queries data from a SQL transactional database, you must have Kerberos delegation. 

    The Active Directory Users and Computers MMC snap-in is typically used to configure Kerberos delegation. To configure the delegation settings within the snap-in, the Active Directory object that is being configured must have an SPN applied. Otherwise, the delegation tab for the object will not be visible in the object's properties dialog box. Although Excel Services does not require an SPN to function, you must configure one for this purpose. 

    To do this, type the following command at the command line, and then press Enter:

    ```powershell
    SETSPN -S SP/ExcelServices
    ```

    > [!NOTE]
    > This SPN is not a valid SPN. It is applied to the specified service account to reveal the delegation options in the Active Directory Users and Computers add-in. There are other supported methods to specify the delegation settings (specifically, the msDS-AllowedToDelegateTo Active Directory attribute). However, this article does not describe these methods.

1. Configure Kerberos constrained delegation for Excel Services.

    To enable Excel Services to delegate the identity of the clients, you must configure Kerberos constrained delegation. You must configure constrained delegation with protocol transition in order to convert claims tokens to windows tokens by using the WIF C2WTS. 

    Each server that is running Excel Services must be trusted to delegate credentials to each back-end service that Excel authenticates to. In addition, you must configure the Excel Services service account to allow delegation to the same back-end services. 

    For example, you define the following delegation paths:

    |Principal Type    |Principal Name    |Delegates To Service|
    |-|-|-|
    |User    |svcExcel|    MSSQLSVC/MySqlCluster.vmlab.local:1433|
    |*User|    svcC2WTS    |MSSQLSVC/MySqlCluster.vmlab.local:1433|
    |**Computer|    VMSP10APP01    MSSQLSVC/|MySqlCluster.vmlab.local:1433|

    \* Configured later in this scenario
    
    ** Only required if the C2WTS is running as local system

    To configure constrained delegation, follow these steps:

    1. Open the Active Directory Object's properties in Active Directory Users and Computers.
    1. Browse to the Delegation tab.
    1. Select Trust this user for delegation to specified services only.
    1. Select Use any authentication protocol. This action enables protocol transition, and is required for the service account to use the C2WTS.
    1. Click the Add button to select the service principal allowed to delegate to.
    1. Select User and Computers.
    1. Select the service account that is running the service that you want to delegate to. In the earlier example, it is the service account for the SQL service. 
    
        > [!NOTE]
        > The selected service account must have an SPN applied to it. In the earlier example, the SPN for this account was configured in an earlier step.
    1. Click OK. You are asked to select the SPNs that you want to delegate to on the following screen.
    1. Select the services for the SQL cluster, and then click OK.
    1. You should now see the selected SPNS in the Services to which this account can presented delegated credentials list.
    1. Repeat these steps for each delegation path that is defined at the beginning of this section.

1. Start the Excel Services service instance on the Excel Services server.

    Before you create an Excel Services service application, start the Excel Services service on the designated Farm servers. To do this, follow these steps:
    1. Open Central Administration.
    1. Under services, select Manage services on server.
    1. In the server selection box in the upper-right corner, select the server(s) that are running Excel Services. In the earlier example, the server is VMSP10APP01.
    1. Start the Excel Calculation Services service.
1. Create the Excel Services service application and application proxy to enable web applications to process Excel Services. To do this, follow these steps:

    1. Open Central Administration.
    1. Select Manage Service Applications under Application Management.
    1. Select New, and then click Excel Services Application.
    1. Configure the new service application. Make sure that you select the correct service account (if the Excel Service account is not in the list, create a new managed account).
1. Configure the location of the Excel Services trusted file and the authentication settings. 

    After the Excel Services application is created, you must configure the properties on the new service application to specify a trusted host location and the authentication settings. To do this, follow these steps:

    1. Open Central Administration.
    1. Select Manage Service Applications under Application Management.
    1. Click the link for the new Service Application. In the earlier example, click Excel Services.
    1. In the Excel Services management page, click Trusted File Locations.
    1. Add a new trusted file location.
    1. Set the location of the trusted file to your test library.
    
       > [!NOTE]
       > In the earlier example, the root web application URL and all children are trusted. In a production environment, you may select to constrain the level of trust.
    1. In External Data, select Trusted data connection libraries and embedded.
    
       > [!NOTE]
       > The earlier example uses an embedded connection to connect to SQL Server. In your environment you may select to create a separate connection file and store it in a trusted data connection library. In this situation, select Trusted data connection libraries only.
    1. Change the external data cache lifetime. For testing, it is convenient to change the external data cache lifetime to make sure data updates are coming from the data source and not from the cache. Under External Data, change the following settings:

        Automatic refresh(periodic / on-open) = 0
    
        Manual refresh = 0
    
       > [!NOTE]
       > In a production environment you must configure a cache setting that is larger than 0. Setting the cache to 0 is for testing only.
1. Grant the Excel Services service account permissions on the web application content database.

    You must enable the web application's service account access to the content databases for a given web application in order to configure SharePoint Server 2010 Office Web Applications. For example, grant the Excel Services service account access to the "portal" web application's content database by using Windows PowerShell.

    To do this, run the following command from the SharePoint 2010 Management Shell:

    ```powershell
    $w = Get-SPWebApplication -Identity https://portal
    
    $w.GrantAccessToProcessIdentity("vmlab\svcExcel")
    ```
    
> [!NOTE]
> For more information about Identity delegation for Excel Services, go to the following Microsoft TechNet website:

[Identity delegation for Excel Services (SharePoint Server 2010)](/previous-versions/office/sharepoint-server-2010/gg502605(v=office.14))

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).