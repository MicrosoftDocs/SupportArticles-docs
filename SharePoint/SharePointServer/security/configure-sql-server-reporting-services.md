---
title: Configure SQL Server Reporting Services in SharePoint
description: Describes how to configure SQL Server Reporting Services in Microsoft SharePoint Server for Kerberos authentication
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
ms.reviewer: kelvinlo
appliesto: 
  - Microsoft SharePoint Foundation 2010
  - SharePoint Server 2010
  - SharePoint Foundation 2013
  - SharePoint Server 2013
  - SQL Server 2014 Developer
  - SQL Server 2014 Developer
  - SQL Server 2014 Enterprise
  - SQL Server 2014 Enterprise
  - SQL Server 2014 Express
  - SQL Server 2014 Express
  - SQL Server 2014 Standard
  - SQL Server 2014 Standard
  - SQL Server 2014 Web
  - SQL Server 2014 Web
  - SQL Server 2012 Developer
  - SQL Server 2012 Enterprise
  - SQL Server 2012 Express
  - SQL Server 2012 Standard
  - SQL Server 2012 Web
  - SQL Server 2014 Reporting Services
  - SQL Server 2012 Reporting Services
search.appverid: MET150
ms.date: 12/17/2023
---
# Configure SQL Server Reporting Services in SharePoint Server for Kerberos authentication

_Original KB number:_ &nbsp; 2723587

This article describes how to configure SQL Server Reporting Services in Microsoft SharePoint Server for Kerberos authentication.

## Create Reporting Services service account

As a best practice Reporting Services should run under its own domain identity. To configure the Reporting Services Service Application, an Active Directory account must be created and registered as a managed account in SharePoint Server. In this example, the following account is created and registered.

|Name|Identity|
|---|---|
|SharePoint Server Service| IIS App Pool Identity |
|SQL Server Reporting Services|vmlab\svcRS2012|

> [!NOTE]
> You can optionally reuse a single domain account for multiple services. This configuration is not covered in the following sections.

## Create an SPN for the service account that's running Reporting Service on the Application Server

The Active Directory Users and Computers MMC snap-in is typically used to configure Kerberos delegation. To configure the delegation settings within the snap-in, the Active Directory object being configured must have a service principal name applied. Otherwise, the delegation tab for the object will not be visible in the object's properties dialog. Although Reporting Services doesn't require an SPN to function, we will configure one for this purpose. If the service account already has an SPN applied (in the case of sharing accounts across services), this step isn't required.

On the command line, run the following command:

```console
SETSPN -S SP/PPS vmlab\svcRS2012
```

> [!NOTE]
> The SPN isn't a valid SPN. It's applied to the specified service account to reveal the delegation options in the AD users and computers add-in. There are other supported ways of specifying the delegation settings (specifically the `msDS-AllowedToDelegateTo` AD attribute) but this topic will not be covered in this document.

## Configure Kerberos constrained delegation from the Reporting Services service account to the SSAS Service and optionally for SQL Server service

To allow Reporting Services to delegate the client's identity, Kerberos constrained delegation must be configured. You must also configure constrained delegation with protocol transition for the conversion of claims token to Windows token via the WIF C2WTS.

Each server running Reporting Services must be trusted to delegate credentials to each back-end service with which Reporting Services will authenticate. In addition, the Reporting Services service account must also be configured to allow delegation to the same back-end services. Notice also that HTTP/Portal and HTTP/Portal.vmlab.local are configured to delegate in order to include a SharePoint list as an optional data source for your Reporting Services reports.

In our example, the following delegation paths are defined:

| Principal type| Principal name |
|---|---|
|User|Vmlab\svcC2WTS|
|User|vmlab\svcRS2012|

To configure constrained delegation, follow these steps:

1. Open the Active Directory Object's properties in Active Directory Users and Computers.

2. Navigate to the **Delegation** tab.

    :::image type="content" source="media/configure-sql-server-reporting-services/delegation-tab.png" alt-text="Screenshot of the Delegation tab with Use any authentication protocol option selected.":::

3. Select **Trust this computer for delegation to specified services only**.

4. Select **Use any authentication protocol**.

5. Click the **Add** button to select the service principal.

6. Select Users and Computers.

    :::image type="content" source="media/configure-sql-server-reporting-services/select-users-and-computers.png" alt-text="Screenshot of the Select Users and Computers dialog with a service account entered." border="false":::

7. Select the service account running the service you wish to delegate to (SQL Server, SQL Server Analysis Services, or both).

    > [!NOTE]
    > The service account selected must have an SPN applied to it. In our example, the SPN for this account was configured in a previous scenario.

8. Click **OK**.

9. Select the SPNs you would like to delegate to, and then click **OK**.

    :::image type="content" source="media/configure-sql-server-reporting-services/select-spns.png" alt-text="Screenshot of selecting SPNs in the Add Service dialog." border="false":::

10. You should now see the selected SPNS in the services to which this account can presented delegated credentials list.

    :::image type="content" source="media/configure-sql-server-reporting-services/selected-spns-in-services.png" alt-text="Screenshot of the selected SPNS in the services." border="false":::

11. Repeat these steps for each delegation path defined in the beginning of this section.

## Start the Reporting Services service instance on the Reporting Services server

Before creating a Reporting Services service application, start the Reporting Services service on the designated Farm servers. To learn more about Reporting Services configuration, see [Install Reporting Services 2016 in SharePoint mode](/sql/reporting-services/install-windows/install-reporting-services-sharepoint-mode).

1. Open Central Administration.

2. Under services, select **Manage services on server**.

    :::image type="content" source="media/configure-sql-server-reporting-services/manage-services-on-server.png" alt-text="Screenshot of selecting Manage services on server.":::

3. In the server selection box in the upper right hand corner, select the server(s) running Reporting Services.

4. Start the **SQL Server Reporting Services** service.

## Create the Reporting Services service application and proxy

Next configure a new Reporting Services service application and application proxy to allow web applications to consume Reporting Services:

1. Open Central Administration.

2. Select **Manage Service Applications** under **Application Management**.

    :::image type="content" source="media/configure-sql-server-reporting-services/manage-service-applications.png" alt-text="Screenshot of selecting Manage Service Applications.":::

3. Select **New**, and then click **SQL Server Reporting Services Service Application**.

    :::image type="content" source="media/configure-sql-server-reporting-services/selecting-application.png" alt-text="Screenshot of selecting SQL Server Reporting Services Service Application.":::

4. Configure the new service application. Be sure to select the correct service account or create a new managed account if you didn't perform this step previously.

    :::image type="content" source="media/configure-sql-server-reporting-services/configure-applications.png" alt-text="Screenshot of configuring the new service application.":::

You can create and register a new service account for an existing application pool dedicated for Reporting Services before this step or when you create the new Reporting Services service. To associate the service account with an existing application pool dedicated to Reporting Services or verify an existing account, do the following.

1. Navigate to SharePoint Central Administration. Find **Configure managed accounts** in the **Security** section.

2. Select the drop-down box and select the application pool.

3. Select the Active Directory account.

    :::image type="content" source="media/configure-sql-server-reporting-services/select-account.png" alt-text="Screenshot of selecting Active Directory account.":::

## Grant the Reporting Services service account permissions on the web application content database

A required step in configuring SharePoint Server 2010, Office Web Applications is allowing the web application's service account access to the content databases for a given web application. In this example, we will grant the Reporting Services account access to the *portal* web application's content database by using Windows PowerShell.

Run the following command from the SharePoint 2010 Management Shell:

```powershell
$w = Get-SPWebApplication -Identity http://portal

$w.GrantAccessToProcessIdentity("vmlab\svcRS2012")
```
