---
title: Access to remote resources fails
description: This article provides resolutions for the problem that when you request access to remote resources through IIS, it may fail.
ms.date: 12/11/2020
ms.custom: sap:WWW Administration and Management
ms.reviewer: jamesche, mlaing
ms.technology: iis-www-administration-management
---
# Access to remote resources fails when requested through IIS

This article helps you resolve the problem that when you request access to remote resources through Internet Information Services (IIS) 7.5, 8, or 8.5, it may fail.

_Original product version:_ &nbsp; Internet Information Services 7.5, 8, 8.5  
_Original KB number:_ &nbsp; 2672809

## Symptoms

In IIS 7.5, one of the following problems occurs:

### Problem 1

Application code that accesses resources on another server fails. For example, code similar to the following that uses HttpWebRequest fails:

```aspx-csharp
WebRequest req = WebRequest.Create("http://contoso.com/somepage.aspx");
req.UseDefaultCredentials = true;
req.PreAuthenticate = true;
req.Credentials = CredentialCache.DefaultCredentials;
```

When this code is run, an exception error similar to the following may occur:

> Exception type: WebException  
Exception message: The remote server returned an error: (401) Unauthorized.  
at System.Net.HttpWebRequest.GetResponse()  
at ASP.somepage_aspx.Page_Load(Object sender, EventArgs e)  
at System.Web.Util.CalliHelper.EventArgFunctionCaller(IntPtr fp, Object o, Object t, EventArgs e)  
at System.Web.UI.Control.LoadRecursive()  
at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)

> [!NOTE]
> The above code sample is just one example of how the problem may occur. It can also occur other ways, such as using `System.IO` to access remote resources.

### Problem 2

After restarting IIS services and sending a request to the web application, an error message similar to the following will occur:

> HTTP Error 500.19 - Internal Server Error  
The requested page cannot be accessed because the related configuration data for the page is invalid.  
Detailed Error Information  
Module : IIS Web Core  
>
>Error Code: 0x80070005  
Config Error : Cannot read configuration file due to insufficient permissions  
Config File : \\\\?\UNC\path\wwwroot\web.config  
Requested URL : http://localhost:80/Mysite

> [!NOTE]
> These problems may appear to start occurring without any reason and can be temporarily resolved by rebooting the IIS server.

## Cause

Microsoft has confirmed this is a problem in the *Original product version* section of this article.

## Resolution

To resolve these problems, see [Users cannot access an IIS-hosted website after the computer password for the server is changed in Windows 7 or in Windows Server 2008 R2](https://support.microsoft.com/help/2545850).

This problem can be reproduced using the following steps:

1. From an administrative command prompt, run the following command where `<domainname>` is the domain name of the IIS server in netbios or FQDN format:

    `nltest.exe /sc_change_pwd:<domainname>`

2. Run `IISRESET` to restart the IIS services.

3. Browse to a page in the IIS website.

[MaximumPasswordAge](/previous-versions/windows/it-pro/windows-2000-server/cc937922(v=technet.10))

## What to try

Some further details that will assist in the identification and troubleshooting of these issues:

- Either IIS is configured to access content on a UNC share, or code is accessing content on a UNC share.
- Everything works fine but then stops working at a seemingly random time.
- A netmon trace will show that NTLM is being used to access the UNC content instead of Kerberos.
- Mapping a drive or using `net view`, `new use`, etc. will still work.
- Only a reboot of the server will resolve, but it will start happening again at some later time. (Customers typically believe it starts at a random time.)
