---
title: Error message when view or edit in browser for Word or PowerPoint Online
description: When attempting to view a PowerPoint Presentation or a Word document in the Office Online, the user receives an error message indicating that the service is temporarily unavailable.  Multiple attempts from the same web application return similar results.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Files and Documents\Other
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Server 2010
  - SharePoint Foundation 2010
  - Word for the web
  - PowerPoint for the web
ms.date: 12/17/2023
---

# Error when view or edit in browser for Word or PowerPoint Online  

## Symptoms  

When attempting to view a PowerPoint Presentation or a Word document in the Office Online, the user receives an error message indicating that the service is temporarily unavailable.  Multiple attempts from the same web application return similar results.  

Possible Errors:

- Service is temporarily unavailable.  
- Word Online cannot open this document for viewing because of an unexpected error.  To view this document, open it in Microsoft Word.  
- PowerPoint Online encountered an error.  Try again.   

## Cause  

The Office Online relies on the SharePoint Shared Services Infrastructure to convert the document into a browser ready rendition.  If the front-end machines cannot find the shared services, or the shared services are not started on at least one machine, then viewing the document or presentation will fail with this error.  

Another possible cause for these errors is a potential problem with the Service Account running the Web Application, the Word Viewing Service, and the PowerPoint Service.   

## Resolution  

### Resolution 1: Check PowerPoint Service and Word Viewing service status

1. Click Start, point to All Programs, Microsoft SharePoint 2010 Products, and then SharePoint 2010 Central Administration.

2. On the SharePoint Central Administration home page, in Application Management, click Manage service on server.  Verify PowerPoint Service and Word Viewing Service is started.  

### Resolution 2: Verify if PowerPoint Service and Word Viewing Service are not listed

If it is listed, then proceed to another resolution in the list.  The service applications and proxies can be created by using the Central Administration or Windows PowerShell.    

To create the service applications and the service application proxies by using Central Administration:   

1. Click Start, point to All Programs, Microsoft SharePoint 2010 Products, and then SharePoint 2010 Central Administration.

2. On the SharePoint Central Administration home page, in Application Management, click Manage service applications.  

3. On the Service Applications page, click New, and then click Word Viewing Service.  

4. In the Word Viewing Service Application dialog box, in Name, type Word Viewing Service Application. In Application Pool, select Use existing application pool, and then in the listbox, select SharePoint Web Services Default. In Add to default proxy list, verify Add this service application's proxy to the farm's default proxy list is selected (default), and then click OK.

   **NOTE** You can choose to create a new application pool to be used with a service application. When creating a new application pool, you can specify the security account used by the application pool to be a predefined Network Service account, or you can specify a managed account. The account must have read\write privileges for the SPContent database and SPConfig database.  

5. On the Service Applications page, click New, and then click PowerPoint Service Application.  

6. In the PowerPoint Service Application dialog box, in Name, type PowerPoint Service Application. In Application Pool, select Use existing application pool, and then in the listbox, select SharePoint Web Services Default. In Add to default proxy list, verify Add this service application's proxy to the farm's default proxy list is selected (default), and then click OK.

   **NOTE** You can choose to create a new application pool to be used with a service application. When creating a new application pool, you can specify the security account used by the application pool to be a predefined Network Service account, or you can specify a managed account. The account must have read\write privileges for the SPContent database and SPConfig database.

   To create the service applications and the service application proxies by using Windows PowerShell1, open a new text file in Notepad, and then copy and paste the following script into the file:  

   ```  
   $appPool = Get-SPServiceApplicationPool -Name "SharePoint Web Services Default"  

   New-SPWordViewingServiceApplication -Name "WdView" -ApplicationPool $appPool | New-SPWordViewingServiceApplicationProxy -Name "WdProxy"  

   New-SPPowerPointServiceApplication -Name "PPT" -ApplicationPool $appPool | New-SPPowerPointServiceApplicationProxy -Name "PPTProxy"  

   New-SPExcelServiceApplication -Name "Excel" -ApplicationPool $appPool  
   ```

7. Save the file with a.ps1 file name extension to a folder where you run scripts (typically C:\scripts).  

8. From the Windows PowerShell command prompt (that is, PS C:\>), type the following command and press ENTER:  

   ```
   C:\<path>\<filename>.ps1
   ```   

### Resolution 3: Check Service Account Permissions   

The Service Applications get and retrieve content and settings from the SharePoint Content Databases and the Configuration Database. In order for the Service Applications to process documents, they must have appropriate permissions on both databases. For more information as to the recommended permissions, please see the "Account permissions and security settings (SharePoint Server 2010)" TechNet article found here:  

[Account permissions and security settings in SharePoint 2013](/SharePoint/install/account-permissions-and-security-settings-in-sharepoint-server-2016)  

### Resolution 4: Check the Farm Account   

In a Farm Setup, we suggest that the Farm Account be running under a different account for the Web Application, PowerPoint, and Word Viewing Application Pools.  To check these through the Central Administration:  

1. Click Start, point to All Programs, Microsoft SharePoint 2010 Products, and then SharePoint 2010 Central Administration.  

2. On the SharePoint Central Administration home page, in Security, click Configure service accounts.  

3. Verify they are running under a different account.  If they are the same as the Farm Account change them to a different Service Account or create a new service account in your domain to run these services.    

4. To create a different or new service account, the following link provides the detail steps:  

   [Service Accounts Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd548356(v=ws.10))  

   **Note** It is not a requirement to run the Farm account and Service accounts under different managed accounts. This resolution is provided as a possible troubleshooting technique.   

## More Information  

[Deploy Offices Online (Installed on SharePoint 2010 Products)](/previous-versions/office/sharepoint-server-2010/ff431687(v=office.14))

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
