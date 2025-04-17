---
title: Troubleshoot permission and security issues
description: This article describes how to troubleshoot common permissions and security-related issues in ASP.NET.
ms.date: 04/17/2025
ms.custom: sap:Security
ms.topic: how-to
---
# Troubleshooting common permissions and security-related issues in ASP.NET

This article introduces how to troubleshoot common permissions and security-related issues in ASP.NET.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 910449

## Useful tools

Before you attempt to fix anything that is broken, you need to familiarize yourself with a few tools, which will help you narrow down the issue. In our case, we would be interested in tools like FileMon, RegMon, and Security Auditing. For more information about FileMon, see [FileMon for Windows v7.04](/sysinternals/downloads/filemon).

For more information about RegMon, see [Windows Sysinternals](/sysinternals/).

## Drill down to isolate the problem

- Has the application ever worked? If yes, then what changed that could have made the application break? It's possible that software updates or security updates were applied on the server. A code rollout also could have caused the issue.
- Do simple .html and .asp pages serve from IIS?
- Was the application migrated to a different version of IIS?
- Do other ASP.NET applications on the server fail with the same error? Is this the only application that fails?
- Does the issue occur for all users or for only specific users?
- Is the issue reproducible while browsing locally on the Web server, or is it reproducible for only a few clients?
- If you are using impersonation, then does the impersonated user have the necessary access to the resource?

The above questions are useful in order to diagnose a problem. If you are posting your issue on any of the ASP.NET forums, and if you already have the answers to most of these questions, then it's likely that you will get a quick pointer or solution to your problem. The key is to post the whole ASP.NET stack trace error, if applicable, instead of saying "I am getting an Access Denied error while trying to run my ASP.NET application. Can anyone help?" It's much easier for someone to look at the stack trace and give you pointers when they can see a complete error message. So you need to ask yourself...

## What is the exact error message?

The first question we ask customers is, "What is the exact error message?" If you have a clear description of the error message thrown by the Microsoft .NET Framework, you can skip this section. If your application masks the actual error message and gives you a friendly error message instead, such as, "An unexpected error has occurred. Contact the website administrator for details," it's not of much use to anyone. Here are a few steps, which will help you get the actual error message.

- Locate and open the Web.config file in the application directory and change **customErrors** to mode="Off". Save the file, and reproduce the problem.
- It still might not be possible to see the actual error message after following the above step because of custom event/error handling done by the application developer. You can try to locate the Application_Error event in the Global.asax file and comment out any code that uses the `Server.Transfer("Errors.aspx")` function to go to a custom error page.

    ```aspx-csharp
    //Global.asax 
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs 
        //Server.Transfer("Errors.aspx"); 
    }
    ```

Once you get the actual error message, read it to determine if the error is caused by missing permissions on a local resource or on a remote resource that your ASP.NET application is trying to access.

> [!TIP]
> You can contact your developer to find out how to see the actual error message. It's possible that your developer may be logging it to a file or getting e-mail notifications. Always remember to make a backup of any file that you are going to change. With a backup available, you can always roll back any changes.

## Issue occurs because of missing permissions on a local resource that the ASP.NET application tries to access

If you are unable to get a clear description of the problem because of a custom error message, run FileMon and reproduce the problem. Stop and save the capture as FileMon.xls and open the file in Microsoft Excel. On the **Data** menu, click **Filter**, and then click **AutoFilter** to use the filtering capabilities of Excel. Now select the drop-down list in column `F` and look for "ACCESS DENIED" errors.

A sample FileMon output is shown below.

```console
10381 1:01:11 PM w3wp.exe:2320 OPEN C:\winnt\microsoft.net\framework\v1.1.4322\Temporary ASP.NET Files\sessiontest\8832e585\275ec327\global.asax.xml 
ACCESS DENIED NT 
AUTHORITY\NETWORK SERVICE
```

As you can see from the filtered results, we have narrowed down the cause of the problem. FileMon shows that the NT AUTHORITY\NETWORK SERVICE account is missing NTFS permissions on the `C:\Winnt\Microsoft.net\Framework\v1.1.4322\Temporary ASP.NET Files` folder. This should be straight forward to fix.

> [!TIP]
> A good step would be to change the ASP.NET process account to an Admin account to see if it fixes the problem. In IIS 6.0 and later versions you would change the IIS AppPool identity to "Local System" to see if the application works.

> [!NOTE]
> This should not be used as a solution, but only as a troubleshooting step.

Most people would tend to reinstall the Microsoft .NET Framework or even go to the extent of reinstalling the operating system. This is not a recommended troubleshooting step and does not guarantee that the issue will not reoccur. I will provide one such example. Intermittent issues are often hard to isolate and troubleshoot. In this scenario the customer's application would work fine for a few hours, and then all of a sudden it would fail with the error below. The customer had already tried reinstalling the .NET Framework as well as the operating system. This seemed to fix the problem for a few days, but then it reappeared.

Running FileMon did not show any **ACCESS DENIED** errors. All the necessary permissions for the ASPNET account were in place. The only way to recover from the problem is to reboot the box. Even an IIS reset would not help. You are thinking "Ah, Microsoft Software always needs a reboot to recover?" Well, you are wrong!

The key here is to look closely at the error message. The error clearly says "cannot open a file for writing," and not the usual **ACCESS DENIED** error, so I am thinking that it's some other process that is holding a lock on a file or folder and not allowing ASP.NET to write to it. It makes sense that a reboot was killing the other process and the ASP.NET application starts working again until the rogue process locks the file again. The logical thing to do would be to turn off all antivirus programs, third-party spyware, or any other file monitoring software that runs on the server. I do not want to point out any specific third-party software. But, in general, antivirus software is known to cause much grief for IIS and ASP.NET applications. Another known issue caused by antivirus software is session loss due to AppDomain recycles when the Bin folder or the .config files are touched.

> [!TIP]
> The easiest way to turn off third-party services is to:
> 1. Click **Start**, click **Run**, and then type *msconfig*.
> 2. Select **Services** and check **Hide All Microsoft Services**.
> 3. Click **Disable All** to stop the third-party services.
> 4. Click **Start**, click **Run**, and then type iisreset to reload the CLR into the worker process.

Monitor your application to see if the issue reoccurs. If you run multiple antivirus programs, use the trial-and-error method to determine which particular program is causing the issue.

> [!NOTE]
> If the same error is reproducible 100 percent of the time, your antivirus software may not be the cause. There can be other causes for this error. Try creating a simple ASP.NET test application to isolate whether the same error occurs for a Test.aspx page. If it does, then verify that the required Access Control Lists (ACLs) are all in place for ASP.NET.

See [ASP.NET Required Access Control Lists (ACLs)](/previous-versions/kwzs111e(v=vs.140)).

> [!TIP]
> The `%SystemRoot%\Assembly` folder is the global assembly cache. You cannot directly use Windows Explorer to edit ACLs for this folder.

Instead, use a command prompt and run the following command:

`cacls %windir%\assembly /e /t /p domain\useraccount:r`

Alternatively, prior to using Windows Explorer, unregister Shfusion.dll with the following command to give permissions via the GUI:

`C:\WINDOWS\Microsoft.NET\Framework\VersionNumber>regsvr32-u shfusion.dll`

After setting permissions with Windows Explorer, re-register Shfusion.dll with the following command:

`C:\WINDOWS\Microsoft.NET\Framework\VersionNumber>regsvr32 shfusion.dll`

## Issue occurs because of missing permissions on a remote resource that the ASP.NET application is trying to access

When your ASP.NET application is accessing a remote resource like Microsoft SQL Server or a Universal Naming Convention (UNC) share, there are many things that can go wrong. Also, many things may be incorrectly set up on the remote resource. You'll need to troubleshoot those issues in order to get the resource working.

Your first step would be to see if you can connect to the remote server through Windows Explorer.

1. On the remote server, create a folder called Test. On the **Sharing** and **Security** tabs of the Test folder, add your domain/account, and also the process account that is used by your ASP.NET application, and give them both Full Control.

2. On the IIS server, log in with your domain/account, click **Start**, click **Run**, and then type the UNC share path of the remote server: `\\RemoteServerName*\Test`.

    If you are unable to get to this folder, then contact your Network Administrator to fix this issue. Only then can your ASP.NET application access the share.

3. Create a file called *CreateUNCFile.aspx* with the code below and save the file in your application directory.

    ```aspx-vb
    <%@ Page Language="vb" %>
    <%@ Import Namespace="System.IO" %>
    <html>
    <head>
    <title>Writing to a Text File</title>
    <script runat="server">
        Sub WriteToFile(ByVal sender As System.Object, ByVal e As System.EventArgs)
            Dim fp As StreamWriter
                fp = File.CreateText("\\<RemoteServerName>\Test\" & "test.txt")
                fp.WriteLine(txtMyFile.Text)
                lblStatus.Text = "The File Successfully created! Your ASP.NET process is able to access this remote share"
                fp.Close()
        End Sub
    </script>
    
    </head>
    <body style="font: 10pt verdana">
                <h3 align="center">Creating a Text File in ASP.NET</h3>
        <form id="Form1" method="post" runat="server">
                            Type your text:
                            <asp:TextBox ID="txtMyFile" TextMode="MultiLine" Rows="10" Columns="60" Runat="server" /><br>
                            <asp:button ID="btnSubmit" Text="Create File" OnClick="WriteToFile" Runat="server" />
                            <asp:Label ID="lblStatus" Font-Bold="True" ForeColor="#ff0000" Runat="server" />
        </form>
    </body>
    </html> 
    ```

4. Make sure that you modify **\<RemoteServerName>** in the following line of code

    ```vbnet
    fp = File.CreateText("\\<RemoteServerName>\Test\" &"test.txt")
    ```

    So that it reflects the name of your remote server.
5. Open Windows Internet Explorer and browse to `http://**IISServerName**/**AppName**/CreateUNCFile.aspx` from a client computer other than the IIS server.
6. If the Test.txt file creates successfully, then your ASP.NET application can authenticate to the remote resource.
7. If file creation fails from an Internet Explorer client browser but works if you browse to the same page from the IIS server itself, then it's likely that you are running into a "Double Hop" scenario. If you are using custom built Web Parts to access remote resources that require user authentication and authorization, you will probably run into the "Double Hop" problem. In order to access your remote resource, you may need to supply the end user's credentials to the resource so that the output from the resource is limited to the data that the end user has permission to access.

The above steps assume that you have NTLM Authentication turned on in IIS. Basic Authentication does not use Kerberos.

For more information, see [Troubleshoot Kerberos failures in Internet Explorer](../../iis/www-authentication-authorization/troubleshoot-kerberos-failures-ie.md).

For more information on IIS authentication methods, see [Visual Studio 2003 Retired Technical documentation](https://www.microsoft.com/download/details.aspx?id=55979).

> [!TIP]
> If you can connect to the remote UNC share but you can not connect to the remote server that is running SQL Server from the ASP.NET application, then you might have to check or set the Service Principal Names (SPNs) for SQL Server. Try enabling only Basic Authentication for your application in IIS and see if you are able to connect to the remote server that is running SQL Server.

There are numerous other causes for the "Server Application Unavailable" error message. The event log is your best bet to get more details on the cause of your issue.

## IIS-related errors

The IIS logs are useful in cases of IIS authentication-related errors.

What you need to look for is the status and sub status codes for this particular error.

```output
2006-10-12 22:47:28 W3SVC1 65.52.18.230 GET /MyAPP/login.aspx - 80  
MyDomain\UserID_91 65.52.22.58 Mozilla/4.0+  
(compatible;+MSIE+6.0;+Windows+NT+5.2;+SV1;+.NET+CLR+1.1.4322;+.NET+CLR+2.0.50727;+InfoPath.1) 401 3 5
```

We see a 401 with the substatus 3, which indicates "Unauthorized due to ACL on resource."

This indicates missing NTFS permissions on a file or folder. This error may occur even if the permissions are correct for the file that you are trying to access, but the default permissions and user rights may be missing on other SYSTEM and IIS folders. For example, you may see this error if the IUSR_ComputerName account does not have access to the C:\Winnt\System32\Inetsrv directory.

> [!TIP]
> Click **Start**, click **Run**, and then type logfiles to open the folder that contains the IIS logs. Alternatively, on the properties page for your Website in IIS, click the **WebSiteName** tab, and under **Active log format**, click **Properties** to see the Log file directory and name.

The other thing of interest here is the status code 5. You can use the net helpmsg command to get more info on this status code:

`C:\Documents and Settings\User> net helpmsg 5`

> Access is denied.

Let's try another common status code, code 50:

`C:\Documents and Settings\User> net helpmsg 50`

> The request is not supported.

> [!TIP]
> Whenever you get another generic infamous "500 Internal Server Error" message, then it's a good idea to disable friendly HTTP error messages, so that you receive a detailed description of the error. Don't forget to look in the event viewer as it may also contain more information.

The idea is to use all the logged information available to get maximum details on the problem at hand.

## Resources

For more information, see:

- [Introduction to ASP.NET Identity](/aspnet/identity/overview/getting-started/introduction-to-aspnet-identity)

- [How to create a service account for an ASP.NET 2.0 application](/previous-versions/msp-n-p/ff649309(v=pandp.10))

- [Building Secure ASP.NET Applications: Authentication, Authorization, and Secure Communication](/previous-versions/msp-n-p/ff649264(v=pandp.10))
