---
title: Access denied when you call Web Service
description: This article provides resolutions for Access Denied errors that occur when you call a Web service application and Anonymous access authentication is turned off.
ms.date: 02/27/2020
ms.custom: sap:WWW authentication and authorization
ms.subservice: www-authentication-authorization
---
# Access Denied When you call a Web Service while Anonymous Authentication is turned Off

This article helps you resolve errors (Access Denied) that occur when you call a Web service application and Anonymous access authentication is turned off.

_Original product version:_ &nbsp; Web Services Enhancements  
_Original KB number:_ &nbsp; 811318

## Symptoms

When you try to call a Web service application and Anonymous access authentication is turned off, you may receive the following error message:

> The request failed with HTTP status 401: Access Denied.  
> Description: An unhandled exception occurred during the execution of the current Web request. Please review the stack trace for more information about the error and where it originated in the code.  
> Exception Details: System.Net.WebException: The request failed with HTTP status 401: Access Denied.

## Cause

When Anonymous access authentication is turned off for the Web service application, all the caller applications must provide the credentials before making any request. By default, the Web service client proxy does not inherit the credentials of the security context where the Web service client application is running.

To resolve this problem, you must use the Credentials property of the Web service client proxy to set the security credentials for Web service client authentication.

To set the Credentials property, use one of the following resolutions:

## Resolution 1: Assign DefaultCredentials to Credentials property

Assign the DefaultCredentials to the Credentials property of the Web Service Proxy class to call the Web service while Anonymous access authentication is turned off. The DefaultCredentials property of the CredentialCache class provides system credentials of the security context where the application is running. To do this, use the following code:

Visual C# .NET Sample

```csharp
//Assigning DefaultCredentials to the Credentials property
//of the Web service client proxy (myProxy).
myProxy.Credentials= System.Net.CredentialCache.DefaultCredentials;
```

Visual Basic .NET Sample

```vb
'Assigning DefaultCredentials to the Credentials property
'of the Web service client proxy (myProxy).
myProxy.Credentials= System.Net.CredentialCache.DefaultCredentials
```

## Resolution 2: Use the CredentialCache class

You may use the CredentialCache class to provide credentials for Web service client authentication. Create an instance of the CredentialCache class. Create an instance of NetworkCredential that uses the specified user name, password, and domain. Add the NetworkCredential to the CredentialCache class with the authentication type. To do this, use the following code:

Visual C# .NET Sample

```csharp
//Create an instance of the CredentialCache class.
CredentialCache cache = new CredentialCache();

// Add a NetworkCredential instance to CredentialCache.
// Negotiate for NTLM or Kerberos authentication.
cache.Add( new Uri(myProxy.Url), "Negotiate", new NetworkCredential("UserName", "Password", "Domain")); 

//Assign CredentialCache to the Web service Client Proxy(myProxy) Credetials property.
myProxy.Credentials = cache;
```

Visual Basic .NET Sample

```vb
'Create an instance of the CredentialCache class.
Dim cache As CredentialCache = New CredentialCache()

'Add a NetworkCredential instance to CredentialCache.
'Negotiate for NTLM or Kerberos authentication.
cache.Add(New Uri(myProxy.Url), "Negotiate", New NetworkCredential("UserName", "Password", "Domain"))

'Assign CredentialCache to the Web service Client Proxy(myProxy) Credetials property.
myProxy.Credentials = cache
```

> [!NOTE]
> The CredentialCache class and the NetworkCredential class belong to the System.Net namespace.

For more information about how to set the Credentials property, see the **Steps to reproduce the behavior** section in this article.

## Status

This behavior is by design.

## Steps to reproduce the behavior

DefaultCredentials represents the system credentials for the current security context where the application is running. For a client-side application, the default credentials are typically the Windows credentials such as user name, password, and domain of the user who is running the program. For ASP.NET programs, the default credentials are the user credentials of the identity for the ASP.NET worker process, or the user who is being impersonated. In the following sample ASP.NET program,
DefaultCredentials represents the ASPNET user account (or NetworkService user account for applications run on Microsoft Internet Information Services [IIS] 6.0) because no impersonation is set to the caller.

1. Create a new **ASP.NET Web Service** by using Visual C# .NET or Visual Basic .NET.
2. Name the project **WebServiceTest**.
3. By default, **Service1.asmx** is created.
4. Uncomment the default WebMethod "HelloWorld()".
5. On **Build** menu, select **Build Solution**.
6. Turn off Anonymous access to WebServiceTest. To do this, follow these steps:

     1. In Control Panel, double-click **Administrative Tools**.
     2. Double-click **Internet Information Services**.
     3. Expand **Internet Information Services**, and then locate the **WebServiceTest** virtual directory.
     4. Right-click **WebServiceTest**, and then select **Properties**.
     5. Select the **Directory Security** tab.
     6. Under **Anonymous access and authentication control**, select **Edit**.
     7. In the **Authentication Methods** dialog box, select to clear the **Anonymous access** check box.
     8. Select to select the **Integrated Windows authentication** check box.

        > [!NOTE]
        > Verify that only **Integrated Windows authentication** is selected.
     9. Select **OK** to close the **Authentication Methods** dialog box.
     10. Select**OK**to close **Properties**.
7. On the **Build** menu, select **Build Solution**.
8. Type the following address in the browser to view the **Service1** Web service description:

    http://localhost/WebServiceTest/Service1.asmx

9. Test the HelloWorld WebMethod. The WebMethod works as expected.
10. Add a Web Reference to a test **ASP.NET Web Application**. To do this, follow these steps:

    1. Create a new **ASP.NET Web Application** by using Visual C# .NET or Visual Basic .NET. Name the project **WebServiceCaller**.
    1. By default, **WebForm1.aspx** is created.
    2. In Solution Explorer, right-click **References**, and then select **Add Web Reference**.
    4. In the **Address** text box, type the URL for WebServiceTest as follows:
    
       http://localhost/WebServiceTest/Service1.asmx
       
    5. Select **Go** or press ENTER, and then select **Add Reference**.
11. In Solution Explorer, right-click **WebForm1.aspx**, and then select **View Code**.
12. Append the following code to thePage_Loadevent:

    Visual C# .NET Sample:

    ```csharp
    // Start an instance of the Web service client-side proxy.
    localhost.Service1 myProxy = new localhost.Service1();
    Response.Write( myProxy.HelloWorld());
    ```

    Visual Basic .NET Sample:

    ```vb
    'Start an instance of the Web service client-side proxy.
    Dim myProxy As localhost.Service1 = New localhost.Service1()
    Response.Write(myProxy.HelloWorld())
    ```

13. On the **Debug** menu, select **Start**, and then view the application in the browser.
14. The error message that is discussed in the "Symptoms" section appears in the browser.
15. To resolve this problem, assign DefaultCredentials to the Credentials property of the Web service client-side proxy. To do this, insert the following code before the line "Response.Write( myProxy.HelloWorld())":

    Visual C# .NET Sample:

    ```csharp
    myProxy.Credentials= System.Net.CredentialCache.DefaultCredentials;
    ```

    Visual Basic .NET Sample:

    ```vb
    myProxy.Credentials = System.Net.CredentialCache.DefaultCredentials
    ```

16. Repeat step 13.

## References

- [HOW TO: Write a Simple Web Service by Using Visual C# .NET](https://support.microsoft.com/help/308359)

- [Building Secure ASP.NET Applications: Authentication, Authorization, and Secure Communication](/previous-versions/msp-n-p/ff649100(v=pandp.10))

- [Securing XML Web Services Created Using ASP.NET](/previous-versions/dotnet/netframework-1.1/w67h0dw7(v=vs.71))

- [CredentialCache Class](/dotnet/api/system.net.credentialcache?view=netcore-3.1&preserve-view=true)

- [CredentialCache.DefaultCredentials Property](/dotnet/api/system.net.credentialcache.defaultcredentials?view=netcore-3.1&preserve-view=true)
