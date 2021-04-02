---
title: Configuration tool creates duplicate configuration file
description: This article provides a resolution for the problem that occurs when you run the Microsoft Dynamics CRM 2011 Adapter Configuration tool to allow other types of records to be integrated in CRM.
ms.reviewer: clintwa
ms.topic: troubleshooting
ms.date: 
---
# Dynamics Connector for Microsoft Dynamics CRM 2011 Configuration Tool Creates Duplicate Configuration File

This article helps you resolve the problem that occurs when you run the Microsoft Dynamics CRM 2011 Adapter Configuration tool to allow other types of records to be integrated in CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2670535

## Symptoms

When running the Microsoft Dynamics CRM 2011 Adapter Configuration tool to allow other types of records to be integrated in CRM, such as Quote Product, Opportunity Product, or a custom entity, the tool will create duplicate configuration files for these entities.

## Cause

This occurs if the configuration tool is run twice.

The first time a configuration file will be created with the format like QuoteProductObjectProvider, if quote product is the name of the CRM entity. The second time the configuration tool is ran the configuration file will look like quotedetailObjectProvider.

## Resolution

In order to work around this problem follow the steps below:

1. Close the Connector Client and stop the Connector Service. This is important to close the client and stop the service.

2. For an x64 install of Windows, go to path:

   `%PROGRAMFILES%\Microsoft Dynamics\Microsoft Dynamics Adapter\Adapters\Microsoft.Dynamics.Integration.Adapters.Crm2011\ObjectConfig`

   For a i386 install of Windows, go to path:

   `%PROGRAMFILES(x86)%\Microsoft Dynamics\Microsoft Dynamics Adapter\Adapters\Microsoft.Dynamics.Integration.Adapters.Crm2011\ObjectConfig`

3. Go into the folder that matches the name of the CRM organization.

4. Delete the XML Configuration files.

5. Then, run the application Microsoft.Dynamics.Integration.Adapters.Crm2011.Configuration.exe.

6. At the tree view page where CRM entities are selected, check the boxes for the other entities that need configuration files created. Make sure that the boxes are checked for any entities that may have existing maps.
