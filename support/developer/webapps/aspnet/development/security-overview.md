---
title: ASP.NET security overview
description: This article provides information about the ASP.NET security.
ms.date: 04/07/2020
ms.custom: sap:General Development
ms.reviewer: VENKATC, EARLB
ms.topic: concept-article
---
# ASP.NET security overview

This article provides an introduction to ASP.NET security, it refers to the following Microsoft .NET Framework Class Library namespaces:

- `System.Web.Security`
- `System.Web.Principal`

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 306590

## Summary

ASP.NET gives you more control to implement security for your application. ASP.NET security works in conjunction with Internet Information Services (IIS) security and includes authentication and authorization services to implement the ASP.NET security model. ASP.NET also includes a role-based security feature that you can implement for both Windows and non-Windows user accounts.

This article is divided into the following sections:

- [Flow of Security with a Request](#flow-of-security-with-a-request)
- [Related Configuration Settings](#related-configuration-settings)
- [Authentication](#authentication)  
  - [Forms Authentication](#forms-authentication)  
  - [Windows Authentication](#windows-authentication)  
  - [Passport Authentication](#passport-authentication)  
  - [Default Authentication](#default-authentication)
- [Authorization](#authorization)  
  - [FileAuthorization](#file-authorization)  
  - [UrlAuthorization](#url-authorization)
- [Role-Based Security](#role-based-security)

## Flow of security with a request

The following steps outline the sequence of events when a client makes a request:

1. A client requests an .aspx page that resides on an IIS server.
2. The client's credentials are passed to IIS.
3. IIS authenticates the client and forwards the authenticated token along with the client's request to the ASP.NET worker process.
4. Based on the authenticated token from IIS and the configuration settings for the web application, ASP.NET decides whether to impersonate a user on the thread that is processing the request. In a distinct difference between Active Server Pages (ASP) and ASP.NET, ASP.NET no longer impersonates the authenticated user by default. To enable impersonation, you must set the impersonate attribute of the identity section in the *Web.config* file to true.

For more information about the security flow, see [ASP.NET Data Flow](/previous-versions/dotnet/netframework-1.1/xa68twcb(v=vs.71)).

For more information about impersonating in ASP.NET, see [How to implement impersonation in an ASP.NET application](https://support.microsoft.com/help/306158/how-to-implement-impersonation-in-an-asp-net-application).

## Related configuration settings

IIS maintains security-related configuration settings in the IIS metabase. However, ASP.NET maintains security (and other) configuration settings in Extensible Markup Language (XML) configuration files. Although this generally simplifies the deployment of your application from a security standpoint, the security model that your application adopts necessitates the correct configuration of both the IIS metabase and your ASP.NET application through its configuration file (*Web.config*).

The following configuration sections are related to ASP.NET security:

- [\<authentication> Element](/previous-versions/dotnet/netframework-1.1/532aee0e(v=vs.71))
- [\<authorization> Element](/previous-versions/dotnet/netframework-1.1/8d82143t(v=vs.71))
- [\<identity> Element](/previous-versions/dotnet/netframework-1.1/72wdk8cc(v=vs.71))
- [\<machineKey> Element](/previous-versions/dotnet/netframework-1.1/w8h3skw9(v=vs.71))

## Authentication

Authentication is the process by which you obtain identification credentials such as the user's name and password and validate those credentials against some authority.

ASP.NET provides four authentication providers:

- [Forms authentication](#forms-authentication)
- [Windows authentication](#windows-authentication)
- [Passport authentication](#passport-authentication)
- [Default authentication](#default-authentication)

### Forms authentication

Forms authentication refers to a system in which unauthenticated requests are redirected to a Hypertext Markup Language (HTML) form in which users type their credentials. After the user provides credentials and submits the form, the application authenticates the request, and the system issues an authorization ticket in the form of a cookie. This cookie contains the credentials or a key to reacquire the identity. Subsequent requests from the browser automatically include the cookie.

For more information about Forms authentication, see [The Forms Authentication Provider](/previous-versions/dotnet/netframework-1.1/907hb5w9(v=vs.71)).

For more information Forms authentication in ASP.NET, see [How To Implement Forms-Based Authentication in Your ASP.NET Application by Using C#.NET](https://support.microsoft.com/help/301240/how-to-implement-forms-based-authentication-in-your-asp-net-applicatio).  

### Windows authentication

In Windows authentication, IIS performs the authentication, and the authenticated token is forwarded to the ASP.NET worker process. The advantage of using Windows authentication is that it requires minimal coding. You may want to use Windows authentication to impersonate the Windows user account that IIS authenticates before you hand off the request to ASP.NET.

For more information about Windows authentication, see [The WindowsAuthenticationModule Provider](/previous-versions/dotnet/netframework-1.1/907hb5w9(v=vs.71)).

### Passport authentication

Passport authentication is a centralized authentication service, which Microsoft provides, that offers a single sign-in and core profile services for member sites. Typically, Passport authentication is used when you need single sign-in capability across multiple domains.

For more information about Passport authentication, see [The Passport Authentication Provider](/previous-versions/dotnet/netframework-1.1/f8e50t0f(v=vs.71)).

### Default authentication

Default authentication is used when you do not want any security on your Web application; anonymous access is required for this security provider. Among all authentication providers, the Default authentication provides maximum performance for your application. This authentication provider is also used when you use your own custom security module.

## Authorization

Authorization is the process that verifies if the authenticated user has access to the requested resources.

ASP.NET offers the following authorization providers:

- [File authorization](#file-authorization)
- [Url authorization](#url-authorization)

### File authorization

The `FileAuthorizationModule` class performs file authorization and is active when you use Windows authentication. `FileAuthorizationModule` is responsible for performing checks on Windows Access Control Lists (ACLs) to determine whether a user should have access.

### Url authorization

The `UrlAuthorizationModule` class performs Uniform Resource Locator (URL) authorization, which controls authorization based on the uniform resource identifier (URI) namespace. URI namespaces can be different from the physical folder and file paths that NTFS permissions use.

`UrlAuthorizationModule` implements both positive and negative authorization assertions; that is, you can use the module to selectively allow or deny access to arbitrary parts of the URI namespace for users, roles (such as manager, testers, and administrators), and verbs (such as `GET` and `POST`).

For more information about authorization in ASP.NET, see [ASP.NET Authorization](/previous-versions/dotnet/netframework-1.1/wce3kxhd(v=vs.71)).

## Role-based security

Role-based security in ASP.NET is similar to the role-based security that Microsoft COM+ and Microsoft Transaction Server (MTS) use, although there are important differences. Role-based security in ASP.NET is not limited to Windows accounts and groups. For example, if Windows authentication and impersonation are enabled, the identity of the user is a Windows identity (`User.Identity.Name = "Domain\username"`). You can check identities for membership in specific roles and restrict access accordingly. For example:

Visual Basic .NET code

```aspx-vb
If User.IsInRole("BUILTIN\Administrators") Then
    Response.Write("You are an Admin")
Else If User.IsInRole("BUILTIN\Users") then
    Response.Write("You are a User")
Else
    Response.Write("Invalid user")
End if
```

Visual C# .NET code

```aspx-csharp
if ( User.IsInRole("BUILTIN\\Administrators"))
    Response.Write("You are an Admin");
else if (User.IsInRole("BUILTIN\\Users"))
    Response.Write("You are a User");
else
    Response.Write("Invalid user");
```

If you are using Forms authentication, roles are not assigned to the authenticated user; you must do this programmatically. To assign roles to the authenticated user, use the `OnAuthenticate` event of the authentication module (which is the Forms authentication module in this example) to create a new `GenericPrincipal` object and assign it to the User property of the `HttpContext`. The following code illustrates this:

Visual Basic .NET code

```aspx-vb
Public Sub Application_AuthenticateRequest(s As Object, e As EventArgs)
    If (Not(HttpContext.Current.User Is Nothing)) Then
        If HttpContext.Current.User.Identity.AuthenticationType = "Forms" Then
            Dim id as System.Web.Security.FormsIdentity = HttpContext.Current.User.Identity
            Dim myRoles(3) As String
            myRoles(0)= "managers"
            myRoles(1)= "testers"
            myRoles(2)= "developers"
            HttpContext.Current.User = new System.Security.Principal.GenericPrincipal(id,myRoles)
        End If
    End If
End Sub
```

Visual C# .NET code

```aspx-csharp
public void Application_AuthenticateRequest(Object s, EventArgs e)
{
    if (HttpContext.Current.User != null)
     {
         if (HttpContext.Current.User.Identity.AuthenticationType == "Forms" )
         {
             System.Web.Security.FormsIdentity id = HttpContext.Current.User.Identity;
             String[] myRoles = new String[3];
             myRoles[0]= "managers";
             myRoles[1]= "testers";
             myRoles[2]= "developers";
             HttpContext.Current.User = new System.Security.Principal.GenericPrincipal(id,myRoles);
         }
    }
}
```

To check if the user is in a specific role and restrict access accordingly, use the following code (or similar) in your .aspx pages:

Visual Basic .NET code

```aspx-vb
If User.IsInRole("managers") Then
    Response.Write("You are a Manager")
Else If User.IsInRole("testers") Then
    Response.Write("You are a Tester")
Else If User.IsInRole("developers") Then
    Response.Write("You are a Developer")
End if
```

Visual C# .NET code

```aspx-csharp
if (User.IsInRole("managers"))
    Response.Write("You are a Manager");
else if (User.IsInRole("testers"))
    Response.Write("You are a Tester");
else if (User.IsInRole("developers"))
    Response.Write("You are a Developer");
```

For more information on role-based security, see [Role-Based Security](/previous-versions/dotnet/netframework-1.1/52kd59t0(v=vs.71)).

## References

For more general information about ASP.NET, refer to the following newsgroup:

[ASP.NET newsgroup](/previous-versions/dotnet/articles/aa286485(v=msdn.10))

For more information, see the following article or books:

- [PRB: Request.ServerVariables("LOGON_USER") Returns Empty String in ASP.NET](https://support.microsoft.com/help/306359/prb-request-servervariables-logon-user-returns-empty-string-in-asp-net)

- Reilly, Douglas J. Designing Microsoft ASP.NET Applications. Microsoft Press, 2001.

- Esposito, Dino. Building Web Solutions with ASP.NET and ADO.NET. Microsoft Press, 2001.
