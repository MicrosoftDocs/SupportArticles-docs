---
title: Upgrade Available status in new SharePoint Server 2016 farm
description: Provides a solution for an Upgrade Available status issue in new SharePoint Server 2016 farm.
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
  - SharePoint Server 2016
ms.date: 12/17/2023
---

# "Upgrade Available" status in new SharePoint Server 2016 farm  

## Symptoms  

Consider this scenario. SharePoint Server 2016 is installed. The SharePoint 2016 Products Configuration Wizard  is run to create a new farm. After the farm is created, you may observe the following symptoms:  

- You browse to the SharePoint 2016 Central Administration website. In Central Administration, you follow the Manage Servers in this farm link. In the Status column, "Upgrade Available" is displayed.  

- In Central Administration, you select Upgrade and Migration, then select Review Database Status. The SharePoint_AdminContent_\<GUID>  database has the following status: "Database is in compatibility range and upgrade is recommended".  

- You browse to the Central Administration website. You browse to Manage Content Databases. In the Web Application:  menu on the page, select SharePoint Central Administration v4. Then follow the link for the SharePoint_AdminContent_\<GUID>  content database. The Database Schema Versions  area includes the following:  

  ```
  Microsoft.Office.Project.Server.Database.Extension.Upgrade.PDEUpgradeSequence Current Schema Version: 4.0.0.0, Maximum Schema Version: 16.1.273.0
  ```

- On the SharePoint 2016 server, running the command stsadm -o LocalUpgradeStatus  returns results including the following:  

   ```
   <object>
   <name>SharePoint_AdminContent_GUID</name>
   <type>Microsoft.SharePoint.Administration.SPContentDatabase</type>
   <level>5</level>
   <status>Needs Upgrade</status>
   </object>  
   ```

- On the SharePoint Server, you use the SharePoint 2016 Management Shell  to run:  

   ```
   Get-SPFarm | Get-SPPendingUpgradeActions -recursive
   ```   

   The results include:

   ```  
   UpgradeActions : {Microsoft.Office.Project.Server.Database.Extension.Upgrade.PD EUpgradeSequence,   Microsoft.Office.Project.Server.Database.Ext  ension.Upgrade.PDEUpgraderAction_16_0_1_0,_1_0, Microsoft.Office.Project.Server.Database.Extension.Upgrade.PDEUpgraderAction_16_1_2_0...}  
   ObjectName : SharePoint_AdminContent_<GUID>  
   ObjectType     : Microsoft.SharePoint.Administration.SPContentDatabase  
   ParentName     : SharePoint Central Administration v4  
   ParentType     : Microsoft.SharePoint.Administration.SPAdministrationWebApplication  
   Level          : 5  
   Status         : NeedsUpgradeBackwardsCompatible
   ObjectType     : Microsoft.SharePoint.Administration.SPContentDatabase  
   ParentName     : SharePoint Central Administration v4  
   ParentType     : Microsoft.SharePoint.Administration.SPAdministrationWebApplication
   Level          : 5  
   Status         : NeedsUpgradeBackwardsCompatible     
   ```

## Cause  

This can happen if some components in the database have not have been set to the expected version when the SharePoint 2016 Configuration Wizard created the Central Administration AdminContent database.  

## Resolution  

To resolve this issue, use one of the following methods:  

1. Run the following in the SharePoint 2016 Management Shell  to upgrade the components in the Central Administration database:

   ```  
   Get-SPWebApplication <Central Administration URL> | Get-SPContentDatabase | Upgrade-SPContentDatabase  
   ```

2. Run the SharePoint 2016 Products Configuration Wizard  from the command line:  

   ```
   PSConfig.exe -cmd upgrade -inplace b2b -wait -force -cmd applicationcontent -install -cmd installfeatures -cmd secureresources
   ```

## More information  

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
