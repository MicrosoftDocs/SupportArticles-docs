---
title: Error when you use Oracle connection manager
description: This article provides a resolution for the problem that occurs when you use Oracle connection manager.
ms.date: 09/15/2020
ms.custom: sap:Integration Services
---
# DTS_E_CANNOTACQUIRECONNECTIONFROMCONNECTIONMANAGER when you use Oracle connection manager

This article helps you resolve the problem that occurs when you use Oracle connection manager.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2009312

## Symptoms

Consider the following scenario for either SQL Server:

- You design a SQL Server Integration Services (SSIS) package using Business Intelligence Development Studio (BIDS).
- In your package, you connect to an Oracle server using an OLEDB provider for Oracle and use either Oracle client 10G or 11G.
- You use package configuration file to set all the connection properties for the Oracle connection at runtime.

In this scenario, if you execute the package from BIDS, you get the following error message

> "Error: 0xC0202009 at Package, Connection manager "OLEDB Provider": SSIS Error Code DTS_E_OLEDBERROR. An OLE DB error has occurred. Error code: 0x80040E21.
>
> An OLE DB record is available. Source: "Microsoft OLE DB Service Components" Hresult: 0x80040E21 Description: "Multiple-step OLE DB operation generated errors. Check each OLE DB status value, if available. No work was done.".
>
> Error: 0xC020801C at Data Flow Task, Oracle OLEDB Source [1]: SSIS Error Code DTS_E_CANNOTACQUIRECONNECTIONFROMCONNECTIONMANAGER. The AcquireConnection method call to the connection manager "OLEDB Provider" failed with error code 0xC0202009. There may be error messages posted before this with more information on why the AcquireConnection method call failed.
>
> Error: 0xC0047017 at Data Flow Task, DTS.Pipeline: component "Oracle OLEDB Source" (1) failed validation and returned error code 0xC020801C."

## Cause

This is due to the fact that the **Initial Catalog** property in configuration file is not recognized by the Oracle provider. This is blank for the Oracle Connection manager in the configuration file.

For example, the following XML Configuration file is generated when you use BIDS to create an SSIS package that connects to an Oracle server:

```xml
<?xml version="1.0"?>
<DTSConfiguration>  
    <DTSConfigurationHeading>
        <DTSConfigurationFileInfo GeneratedBy="MyUserName" GeneratedFromPackageName="MyPackage" GeneratedFromPackageID="<guid>" GeneratedDate="2/22/2010 9:00:00 PM"/>
    </DTSConfigurationHeading>
    <Configuration ConfiguredType="Property" Path="\Package.Connections[MyConnectionManager].Properties[ConnectionString]" ValueType="String"> 
        <ConfiguredValue>Data Source=MyServerName;User ID=MyAccount;Password=MyPassword; **Initial Catalog=**; Provider=MSDAORA.1;Persist Security Info=True;</ConfiguredValue>
    </Configuration>
</DTSConfiguration>
```

## Resolution

Remove the check box for **Initial Catalog** when creating or editing the configuration file through the BIDS Designer.

For example, the fixed version of the example Configuration file shown in the Cause section will be as follows:

```xml
<?xml version="1.0"?>
<DTSConfiguration>  
    <DTSConfigurationHeading>
        <DTSConfigurationFileInfo GeneratedBy="MyUserName" GeneratedFromPackageName="MyPackage" GeneratedFromPackageID="<guid>" GeneratedDate="2/22/2010 9:00:00 PM"/>
    </DTSConfigurationHeading>
    <Configuration ConfiguredType="Property" Path="\Package.Connections[MyConnectionManager].Properties[ConnectionString]" ValueType="String">
        <ConfiguredValue>Data Source=MyServerName;User ID=MyAccount;Password=MyPassword;Provider=MSDAORA.1;Persist Security Info=True;</ConfiguredValue>
    </Configuration>
</DTSConfiguration>
```

## More information

[Known Limitations of the OLE DB Provider for ODBC](/previous-versions/windows/desktop/ms719628(v=vs.85))
