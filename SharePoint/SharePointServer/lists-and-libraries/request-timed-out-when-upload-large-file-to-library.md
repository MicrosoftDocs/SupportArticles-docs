---
title: Error Request timed out when you try to upload a large file to a document library on a Windows SharePoint Services 3.0 site
description: Describes an issue that occurs when you try to upload a large file to a document library on a Windows SharePoint Services 3.0 site.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Windows SharePoint Services 3.0
ms.date: 12/17/2023
---

# "Request timed out" when you try to upload a large file to a SharePoint Services 3.0 document library

## Symptoms  

Consider the following scenario:  

- You install Microsoft Windows SharePoint Services 3.0.

- You configure a Windows SharePoint Services 3.0 website to support large files.

- You connect to the Windows SharePoint Services 3.0 website.

- You try to upload a large file to a document library.

In this scenario, you receive an error message that resembles the following:  

**Request timed out.**

## Cause  

This issue can occur if the file that you try to upload is over 50 megabytes (MB).  

## Resolution  

To resolve this issue, use one or more of the following methods.

### Method 1: Increase the maximum upload size  

To increase the maximum upload size, follow these steps:  

1. Click **Start**, point to **All Programs**, point to **Administrative Tools**, and then click **SharePoint Central Administration**.

2. Click **Application Management**.

3. Under **SharePoint Web Application Management**, click **Web application general settings**.

4. On the **Web Application General Settings** page, click the web application that you want to change.  

5. Under **Maximum upload size**, type the maximum file size in megabytes that you want, and then click **OK**. You can specify a maximum file size up to 2,047 megabytes.

### Method 2: Increase the connection time-out setting  

To increase the connection time-out setting, follow these steps:  

> [!NOTE]
> By default, the IIS connection time-out setting is 120 seconds.

1. Click **Start**, point to **All Programs**, point to **Administrative Tools**, and then click **Internet Information Services (IIS) Manager**.

2. Right-click the virtual server that you want to configure, and then click **Properties**.

3. Click the **Web Site** tab.

4. Under **Connections**, type the number of seconds that you want in the **Connection time-out** box, and then click **OK**.

### Method 3: Add the executionTimeout value  

1. Open the Web.config file in Notepad.

   **NOTE** By default, this file is in the following location:Program Files\Common Files\Microsoft Shared\Web server extensions\12\TEMPLATE\LAYOUTS

2. Add the executionTimeout value that you want. For example, replace the value as follows.  

   **Existing code**

   ```xml  
   <location path="upload.aspx">   
    <system.web>   
      <httpRuntime maxRequestLength="2097151" />   
    </system.web>   
   </location>  
   ```  

   **Replacement code**  

   ```xml  
   <location path="upload.aspx">   
    <system.web>   
      <httpRuntime executionTimeout="999999" maxRequestLength="2097151" />   
    </system.web>   
   </location>  
   ```  

3. Click **File**, and then click **Save**.

4. Open the web application Web.config file in Notepad.

   **Note** By default, this file is in the `Inetpub\wwwroot\wss\VirtualDirectories\VirtualDirectoryFolder` folder.
5. Change the following line in the file.  

   **Existing line**  

   ```xml  
   <httpRuntime maxRequestLength="51200" />  
   ```  

   **Replacement line**

   ```xml  
   <httpRuntime executionTimeout="999999" maxRequestLength="51200" />  
   ```  

6. Click **File**, and then click **Save**.

7. Exit Notepad.

## More Information  

On a Windows Server 2008 computer that has only IIS 7.0 installations, you can add the maxAllowedContentLength value to resolve the issue that is described in the "Symptoms" section. However, you cannot upload files that are larger than 28 MB, even though you have configured the large file upload setting when you are running Windows SharePoint Services on a Windows Server 2008 based computer that has IIS 7.0 installed. Typically, you receive an error message that resembles one of the following:  

**The page cannot be displayed.**  
**HTTP 404**  

To work around this problem, edit the \<configuration\> section in the Web.config file for the web application. To do this, follow these steps:  

1. Open the web application Web.config file in Notepad.

   **Note** By default, this file is in the `Inetpub\wwwroot\wss\VirtualDirectories\VirtualDirectoryFolder` folder.

2. Increase the value of maxAllowedContentLength in the **requestLimits** node. For example, edit the file as follows to set this value to its maximum size:

   ```xml
   <requestLimits maxAllowedContentLength="52428800"/>
   ```

   **Note** If your Web.config file does not already have the \<requestLimits\> node, you must add it in the correct position in the section hierarchy:  

   ```xml
   <configuration>  
   <system.webServer>  
   <security>  
   <requestFiltering>  
   <requestLimits maxAllowedContentLength="52428800"/>  
   </requestFiltering>  
   </security>  
   </system.webServer>  
   </configuration>
   ```

   **Note** We recommend that you set the maxAllowedContentLength value slightly larger than the maximum file upload size that you have configured in SharePoint. If the maxAllowedContentLength value is equal to or smaller than maximum file upload size that is configured in SharePoint, users will not receive the error message that they are exceeding the size limit if they try to upload a file size larger than that specified by the administrator.

## References  

For more information about the maxAllowedContentLength setting, see the following article in the Microsoft Knowledge Base:  

[942074](https://support.microsoft.com/help/942074) Error message when you visit a Web site that is hosted on a server that is running Internet Information Services 7.0: "HTTP Error 404.13 - CONTENT_LENGTH_TOO_LARGE"

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
