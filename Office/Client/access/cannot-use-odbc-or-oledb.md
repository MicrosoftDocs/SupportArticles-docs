---
title: Can't use the Access ODBC driver or OLEDB provider outside Office Click-to-Run
description: Fixes an issue in which you cannot create an ODBC DSN for drivers provided by Access in the Data Sources ODBC Administrator if you use an Office C2R installation.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto:
- Access 2016
- Access 2013
- Access for Office 365
- Access 2019
- Excel 2013
- Excel 2016
- Excel 2019
- Excel for Office 365
---

# Unable to use the Access ODBC, OLEDB or DAO interfaces outside Office Click-to-Run applications

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you try to create an ODBC DSN for drivers that are provided by Microsoft Access in the Data Sources ODBC Administrator, the attempt fails. This problem occurs if you're using a Click-to-Run (C2R) installation of Office. Depending on the version of Office, you may encounter any of the following issues when you try this operation:
 
- The ODBC drivers provided by ACEODBC.DLL are not listed in the **Select a driver** dialog box.    
- You receive a "The operating system is not presently configured to run this application" error message.    
- You receive an "Unable to load odbcji32.dll" error message.    
- You receive a "The driver of this User DSN does not exist. It can only be removed" error message together with the platform showing **N/A**.

    ![Error with ODBC](./media/cannot-use-odbc-or-oledb/error-with-odbc.png)

Affected drivers:

- Microsoft Access Driver (*.mdb, *.accdb)    
- Microsoft Access Text Driver (*.txt, *.csv)    
- Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)
 
Additionally, if you try to define an OLEDB connection from an external application (one that's running outside of Office) by using the Microsoft.ACE.OLEDB.12.0 or Microsoft.ACE.OLEDB.16.0 OLEDB provider, you encounter a "Provider cannot be found" error when you try to connect to the provider. 

## Cause

Click-to-Run installations of Office run in an isolated virtual environment on the local operating system. Some applications outside Office may not be aware of where to look for the installation in the isolated environment. 

[Overview of the Microsoft 365 Apps admin center](https://docs.microsoft.com/deployoffice/admincenter/overview) 

## Resolution

Beginning with Microsoft 365 Apps for Enterprise Version 2009, work has been completed to [break ACE out of the C2R virtualization bubble](https://techcommunity.microsoft.com/t5/access-blog/breaking-ace-out-of-the-bubble/ba-p/1167712) so that applications outside of Office are able to locate the ODBC, OLEDB and DAO interfaces provided by the Access Database Engine within the C2R installation.

Use the following table to understand if additional components are necessary to access these intefaces within your environment:

| Current Office Installation |	Additional components needed |	Recommended Additional Installation |
|:----------------------------|:----------------------------:|:-----------------------------------:|
| Microsoft 365 Apps for Enterprise, Office 2016/2019 Consumer Version 2009 or later |	No	| - |
| Microsoft 365 Apps for Enterprise, Office 2016/2019 Consumer Prior to Version 2009 | Yes |	[Microsoft Access 2013 Runtime](https://www.microsoft.com/download/details.aspx?id=39358) |
| Office 2016/2019 Pro Plus C2R (Volume License) |	Yes |	[Microsoft Access 2013 Runtime](https://www.microsoft.com/download/details.aspx?id=39358) |
| Office 2010/2013/2016 MSI |	No |	- |
| No Office installation |	Yes |	[Microsoft 365 Access Runtime](https://support.microsoft.com/en-us/office/download-and-install-microsoft-365-access-runtime-185c5a32-8ba9-491e-ac76-91cbe3ea09c9) |

> [!NOTE]
> - The [Microsoft Access Database Engine 2016 Redistributable](https://www.microsoft.com/download/details.aspx?id=54920) is not provided as a recommended solution for the indicated scenarios as both the Access Database Engine 2016 and M365 Apps use the same major version identifier (16.0) which may introduce unexpected behaviors. Office side-by-side detection will also prevent the installation from proceeding if this scenario is detected.
> - The [Microsoft Access Database Engine 2010 Redistributable](https://www.microsoft.com/download/details.aspx?id=13255) is no longer suggested as a recommended solution because Office 2010 has reached the end of the Microsoft Support Lifecycle.

### Additional information for creating ODBC connections 

All Click-to-Run instances of Office are unable to create Machine/System datasource names from within an Office application or from the Data Sources ODBC Administrator. 




 

 
