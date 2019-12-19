---
title: Certain Microsoft SharePoint Server 2013 installation scenarios are not supported
description: Describes SharePoint Server 2013 installation scenarios that are not supported.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Server 2013
---

# Certain Microsoft SharePoint Server 2013 installation scenarios are not supported  

## Summary  

This article describes Microsoft SharePoint Server 2013 installation scenarios that are not supported.   

For information about best practices for using SharePoint 2013 in a virtual configuration, see [Use best practice configurations for the SharePoint 2013 virtual machines and Hyper-V environment](https://technet.microsoft.com/library/ff621103%28v=office.15%29.aspx?f=255&mspperror=-2147217396).  

## Symptoms  

Consider the following scenario:   

- You have SharePoint 2013 installed on a domain controller.   
- You can successfully start Microsoft SharePoint Foundation Sandboxed Code Service in the following folder: Central Administration > System Settings > Services on Server   
- When this service starts, the Services snap-in shows that SharePoint User Code Host is running, and Task Manager shows that SPUCHostService.exe is running.      

In this scenario, the following symptoms occur:   

- Instances of SPUCWorkerProcessProxy.exe are continuously created until server memory runs out or you stop SharePoint Foundation Sandboxed Code Service through SharePoint Central Administration.   
- For every instance of SPUCWorkerProcessProxy.exe, an instance of SPUCWorkerProcess.exe starts and then stops immediately. Therefore, SPUCWorkerProcess.exe never runs.     
Additionally, if you create a simple Visual Studio workflow solution, for example, and then you try to attach the workflow to the process, you receive the following error message:   

  **Unable to attach. Process 'SPUCWORKERPROCESS.exe' is not running on 'SPDEVSERVER'.**  

## More Information  

The following SharePoint Server 2013 installation scenarios are not supported:  

- You try to install SharePoint Server 2013 on a drive that is formatted by using Resilient File System (ReFS).  
  **Note** In this scenario, the installation fails, and the following error message is logged in the Setup log file:  

  ```
  datetime::[940] Catalyst file system check failed: The path root D:\ is not NTFS  
  datetime::[940] Showing message Title: 'Setup Warning', Message: 'The install location must be on a drive formatted with NTFS. Select another drive.'  
  datetime::[940] Message returned: 1
  ```

- You install SharePoint Server 2013 in a workgroup.
- You install SharePoint Server 2013 on a domain controller.   

  **Note** This scenario is supported only for development configurations and not for production configurations.  

- You install SharePoint Server 2013 on Windows Web Server.   
- You install SharePoint Server 2013 on a virtual machine (VM) that uses the Microsoft Hyper-V Dynamic Memory feature.   
- You disable Distributed Cache in a farm configuration.     
