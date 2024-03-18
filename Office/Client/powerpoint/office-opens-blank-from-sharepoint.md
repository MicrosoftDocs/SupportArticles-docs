---
title: Office application opens blank from SharePoint WebDAV or site when it is  HTTP
description: Describes a problem in which you open up Office files and applications open up blank when authentication is  over a non-SSL connection.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Office Professional 2013
  - Office Standard 2013
  - Office Home and Business 2013
  - Office Home and Student 2013
  - Office Standard 2010
  - Office Professional 2010
  - Office Professional Plus 2010
  - SharePoint Foundation 2010
  - SharePoint Server 2010
ms.date: 03/31/2022
---

# Office applications open blank from SharePoint WebDAV or sites

When this problem occurs, you may also experience the following additional symptoms: 
 
- You do not receive a Basic authentication password prompt when you try to open or download the file.
- You do not receive an error message when you try to open the file. The associated Office application starts, but the selected file does not open.

This problem occurs when the following conditions are true: 
 
- The server is configured for Basic authentication.    
- The connection between your computer and the web server does not use Secure Sockets Layer (SSL).

By default, file operations that use Basic authentication over a non-SSL HTTP connection are disabled in Office 2010 and Office 2013 applications.

When Basic authentication is disabled, one of the following events occurs: 
 
- The client application uses a different authentication method. This occurs if the server supports a different authentication method.
- The request fails (for details about what happens when a request fails, see the list in the "Additional symptom details" section).

If the workaround of using HTTPS instead of HTTP does not work, the resolution is to enable SSL encryption on the web server to allow for client access over HTTPS.

> [!NOTE]
> By default, Office 2010 applications can access and download files from a web server that uses Basic authentication only over an SSL connection.

To work around this problem, let Office 2013 and Office 2010 applications connect to a web server by using Basic authentication over a non-SSL connection.

> [!WARNING]
> When you enable Basic authentication without SSL, you are subject to a significant security risk.

## About Basic authentication and its security risk

Basic authentication requires users to a valid user name and password to access content. This authentication method does not require a specific browser, and all major browsers support it. Basic authentication also works across firewalls and proxy servers. For these reasons, it is a good choice when you want to restrict access to some, but not all, content on a server.

However, the disadvantage of Basic authentication is that it transmits unencrypted base64-encoded passwords over the network. If the password is intercepted over the network by a network sniffer, an unauthorized user can determine the user name and password, and can then reuse these credentials. It is because of this security risk that Office 2010 applications disable Basic authentication over a non-SSL connection in the default configuration.

You should use Basic authentication only when you know that the connection between the client and the server is secure. The connection should be established either over a dedicated line or by using SSL encryption and Transport Layer Security (TLS). For example, to use Basic authentication with WebDAV, you should configure SSL encryption.

For more information about Basic authentication, see [Basic authentication](https://technet.microsoft.com/library/cc784037%28v=ws.10%29.aspx) and [Configure Basic authentication (IIS 7)](https://technet.microsoft.com/library/cc772009%28v=ws.10%29.aspx).

For more information about SSL and certificates, see [SSL and certificates](https://technet.microsoft.com/library/cc785150%28v=ws.10%29.aspx).

## Enable Basic authentication over a non-SSL connection

The following two steps describe how to enable Office 2013 and Office 2010 applications to open Office file types directly from a server that supports only Basic authentication over a non-SSL connection. You should follow these steps only if you are confident that the connection between the user and the web server is secure. A direct cable connection or a dedicated line would be considered optimal for secure connections.

> [!NOTE]
> For Office 2013 and Office 2010 applications, both steps are required. For other Office applications, only step 1 is required.

### Step 1: Configure WebDAV Redirector on the client

> [!NOTE]
> This step is required for applications in the 2007 Office suite and in Office 2013 and Office 2010.

On the client computer, configure the WebDAV Redirector to enable Basic authentication over non-SSL connections.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

**Windows XP and Windows Server 2003**

To enable Basic authentication on the client computer, follow these steps: 
 
1. Click **Start**, click **Run**, type regedit, and then click **OK**.    
2. Locate and then click the following registry subkey:
 **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters**    
3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.    
4. Type UseBasicAuth, and then press Enter.    
5. Right-click **UseBasicAuth**, and then click **Modify**.    
6. In the **Value data** box, type 1, and then click **OK**.

   > [!NOTE]
   > Basic authentication is enabled if the UseBasicAuth registry entry is set to a nonzero value. Basic authentication is disabled if the UseBasicAuth registry entry is not present, or if the UseBasicAuth registry entry is set to 0 (zero).

   The mapping is as follows:
    - 0 - Basic authentication disabled
    - 1 - Basic authentication enabled for SSL connections only
    - 2 - Basic authentication enabled for SSL and non-SSL connections    
7. Exit Registry Editor, and then restart the computer.    
 
**Windows Vista, Windows 7, and Windows 8**

To enable Basic authentication on the client computer, follow these steps: 
 
1. In Windows Vista or Windows 7, click **Start**, type regedit in the **Start Search **box, and then press Enter.

   In Windows 8, hold the Windows key (WINKEY) + F, highlight **Apps** in the **Menu** bar, type regedit in the **Search** box, and then press Enter.    
2. Locate and then click the following registry subkey:

   **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters**    
1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.    
1. Type BasicAuthLevel, and then press Enter.    
1. Right-click **BasicAuthLevel**, and then click **Modify**.    
1. In the **Value data** box, type 2, and then click **OK**.

   The mapping is as follows:
    - 0 - Basic authentication disabled
    - 1 - Basic authentication enabled for SSL connections only
    - 2 - Basic authentication enabled for SSL and non-SSL connections    
7. Exit Registry Editor, and then restart the computer.    
 
### Step 2: Update the Registry on the client

> [!NOTE]
> This step is required for Office 2013 and Office 2010 applications.

On the client computer, add the BasicAuthLevel registry key and an appropriate value. To do this, follow these steps.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur. 

1. Start Registry Editor.  
   - In Windows 8, hold the Windows key (WINKEY) + F, highlight **Apps** in the **Menu** bar, type regedit in the **Search** box, and then press Enter. If you are prompted for an administrator password or for confirmation, type the password, or provide confirmation.    
   - In Windows 7 or in Windows Vista, click **Start**, type regedit in the **Start Search** box, then press Enter. If you are prompted for an administrator password or for confirmation, type the password, or provide confirmation.    
   - In Windows XP, click **Start**, click **Run**, type regedit, and then click **OK.**    
     
2. Locate and then click one of the following registry subkeys:

   For Office 2010:
   
   **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Internet**
   
   For Office 2013:
   
   **HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\Internet**    
3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.    
4. Type BasicAuthLevel, and then press Enter.    
5. Right-click **BasicAuthLevel**, and then click **Modify**.    
6. In the **Value data** box, type 2, and then click **OK**.

   The mapping is as follows:
    - 0 - Basic authentication disabled
    - 1 - Basic authentication enabled for SSL connections only
    - 2 - Basic authentication enabled for SSL and for non-SSL connections    
7. Exit Registry Editor, and then restart the computer.    
