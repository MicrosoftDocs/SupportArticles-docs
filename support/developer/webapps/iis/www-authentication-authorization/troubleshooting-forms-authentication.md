---
title: Troubleshooting Forms Authentication
description: This article helps you troubleshoot problems related to Forms Authentication.
ms.date: 11/22/2023
ms.reviewer: senyum, apurvajo, v-jayaramanp
ms.topic: troubleshooting
---

# Troubleshooting Forms Authentication

_Applies to:_ &nbsp; Internet Information Services

Often, while using Forms Authentication in an ASP.NET web application, there's a need to troubleshoot a problem that occurs when a new or an ongoing request is intermittently redirected to the application's login page. You can debug this problem on Visual Studio IDE by attaching a debugger in a development environment. In production environments, however, the task becomes hectic and problematic. To troubleshoot a random problem like this one, you need to log information related to the problem so that you can narrow down the root cause.

This article briefly discusses the concept of Forms Authentication. It also discusses about various scenarios about a user being redirected to the login page and how to capture data that's relevant to isolating the problem. Additionally, it also discusses about how to implement an `IHttpModule` interface to log the Forms Authentication information.

## Overview of ASP.NET Forms Authentication

Forms authentication lets you authenticate users by using your own code and then maintain an authentication token in a cookie or in the URL. Forms authentication participates in the ASP.NET page life cycle through the `FormsAuthenticationModule` class. You can access forms authentication information and capabilities using the `FormsAuthentication` class.

To use forms authentication, create a login page that collects credentials from the user and  includes code to authenticate the credentials. Typically, you configure the application to redirect requests to the login page when users try to access a protected resource, such as a page that requires authentication. If the user's credentials are valid, you can call methods of the `FormsAuthentication` class to redirect the request back to the originally requested resource with an appropriate authentication ticket (cookie). If you don't want the redirection, you can just get the forms authentication cookie or set it. On subsequent requests, your browser passes the authentication cookie with the request, which then bypasses the login page.

By default, the `FormsAuthenticationModule` class is added in the *Machine.config* file. The `FormsAuthenticationModule` class manages the Forms Authentication process.

The following is an entry from the *Machine.config* file:

```xml
<httpModule> 
  <add name="FormsAuthentication" type="System.Web.Security.FormsAuthenticationModule" />            
</httpModule>
```

You can configure forms authentication by using the authentication configuration element. For instance, you have a login page. In the configuration file, you specify a URL to redirect unauthenticated requests to the login page. Then define valid credentials, either in the *Web.config* file or in a separate file. The following example shows a section from a configuration file that specifies a login page and authentication credentials for the `Authenticate` method. The passwords have been encrypted by using the `HashPasswordForStoringInConfigFile` method.

```xml
<authentication mode="Forms"> 
     <forms name="MyAuthCookie" loginUrl="/Login.aspx">     
       <credentials passwordFormat="SHA1">        
         <user name="Kim" password="07B7F3EE06F278DB966BE960E7CBBD103DF30CA6" />         
         <user name="John" password="BA56E5E0366D003E98EA1C7F04ABF8FCB3753889"/>         
       </credentials>
     </forms>
</authentication>
```

After successful authentication, the `FormsAuthenticationModule` module sets the value of the User property to a reference to the authenticated user. The following code example shows how to programmatically read the identity of the forms-authenticated user.

```console
String authUser2 = User.Identity.Name;
```

A convenient way to work with forms authentication is to use ASP.NET membership and ASP.NET login controls. ASP.NET membership allows you to store and manage user information and includes methods to authenticate users. ASP.NET login controls work with ASP.NET membership. They encapsulate the logic to prompt users for credentials, validate users, recover or replace passwords, and so on. In effect, ASP.NET membership and ASP.NET login controls provide a layer of abstraction over forms authentication. These features replace most or all the work that you would ordinarily have to do to use forms authentication.

## Scenarios

Following are scenarios for a request to get redirected to the *login.aspx* page:

> The forms authentication cookie is lost.

### Scenario 1

You log on to the website. At some point, the client sends a request to the server, and the `FormsAuthenticationModule` class doesn't receive the cookie.

### Scenario 2

The forms authentication cookie can also be lost when the client's cookie limit is exceeded. In Microsoft Internet Explorer, there is a limit of 20 cookies. Once the counter reaches 20, the previous 19 cookies are removed from the client's collection. If the ASPXAUTH cookie is removed, you are redirected to the login page when the next request is processed.

### Scenario 3

After the request leaves the client, there are various layers that can affect the packets that are being sent. To determine if a network device is removing the cookie, you have to capture a network trace on the client and the server, and then look in the body of the request for the cookie. You want to look at the client request to make sure that the cookie was sent, and check the server trace to make sure that the server received the cookie.

**Forms authentication ticket timed out**

In ASP.NET 2.0 applications onwards, by default, the forms authentication timeout value has changed to be 30 minutes. This means that after 30 minutes of inactivity, you will be prompted to log in again.

> [!NOTE]
> When you access a website each time, the 30-minute window clock is reset. Only if it's idle there's a timeout.

If you want to change the timeout value to be longer, you can easily change the timeout value in your local *web.config* file (the timeout value is in minutes):

```xml
<system.web> 
 <authentication mode="Forms">     
   <forms timeout="50000000"/>                 
 </authentication>
</system.web>
```

### Scenario 4

Form authentication can expire prior to the value of the timeout attribute defined in the configuration file.

If the forms authentication ticket is manually generated, the timeout property of the ticket will override the value that's set in the configuration file. Therefore, if that value is less than the value in the configuration file, the forms authentication ticket will expire before the configuration file timeout attribute value and vice-versa. For example, let's assume that the `FORMS` timeout attribute is set to 30 in the *Web.config* file and the expiration value of the ticket is set to 20 minutes. In this case, the forms authentication ticket will expire after 20 minutes and then you have to log on again.

```output
Event code: 4005
Event message: Forms authentication failed for the request. Reason: The ticket 
supplied has expired.
```

### Scenario 5

In ASP.NET 4 web application using forms authentication, the event log message says:

```output
Event code: 4005 
Event message: Forms authentication failed for the request. Reason: The ticket supplied was invalid.
```

## Data collection and troubleshooting

### Troubleshooting scenario 1

You can determine if a request doesn't contain the cookie by enabling cookie logging in Microsoft Internet Information Services (IIS). To do so, follow these steps:

1. Open the IIS Microsoft Management Console (MMC).
1. Right-click the website and then select **Properties**.
1. Select the **Web Site** tab, and then select **Enable Logging**.
1. Make sure that the log format is W3C Extended Log file format.
1. Select **Properties**.
1. Select the **Advanced** tab, and then select **Extended Properties**.
1. Under **Extended Properties**, select the **Cookie(cs(Cookie))** and the **Referer (cs(Referer))** checkboxes.

After this problem occurs, determine which client had the problem and that client's IP address. Filter the IIS log on that client's IP address, and view the `<COOKIE>` column.

> [!NOTE]
> Use Log Parser to parse the IIS Logs. Download [Log Parser](https://www.microsoft.com/en-in/download/details.aspx?id=24659).

After you have the list of requests from a specific user, search for the requests to the login page. You would know they were redirected to this page, and you would want to see the requests before the redirection occurred. If you see something similar to the following, the client either didn't send the cookie or the cookie was removed on the network between the client and server.

> [!NOTE]
> The first request isn't likely to have a forms authentication cookie unless you are creating a persistent cookie. The IIS Log will only show the cookies that were received in the request. The first request to have the forms authentication cookie after a successful login attempt.

### Troubleshooting scenario 2

Microsoft Internet Explorer complies with the following RFC 2109 recommended minimum limitations:

- At least 300 cookies.
- At least 4096 bytes per cookie (as measured by the size of the characters that comprise the cookie non-terminal in the syntax description of the Set-Cookie header).
- At least 20 cookies per unique host or domain name.

The forms authentication cookie can also be lost when the client's cookie limit is exceeded. In Microsoft Internet Explorer, there is a limit of 20 cookies. Once the counter reaches 20, the previous 19 cookies are removed from the client's collection. If the ASPXAUTH cookie is removed, you are redirected to the login page when the next request is processed. You can use Fiddler to see the HTTP request or response headers to see if you are receiving the cookie from the client. Download [Fiddler](http://fiddler2.com/fiddler2/).

Launch Fiddler tool on the client machine, remove existing HTTP traces, access your application implementing forms authentication and try to login into the application and observe the HTTP traffic on Fiddler to see if there's an exchange of forms authentication cookie happening between the client and server. After you capture the traffic, double-click a request, and then select **Headers** to see the Set-Cookie header. If you trace a successful login, you will see the Set-Cookie header in the response of a successful login.

By default, IE can store a maximum of 20 cookies for each domain. If a server in the domain sends more than 20 cookies to a client computer, the browser on the client computer automatically discards some old cookies.

Each cookie consists of a single name-value pair. This pair may be followed by attribute-value pairs that are separated by semicolons. This limit has been increased to simplify the development and the hosting of Web applications on domains that must use many cookies. Installing update 937143 increases the number of cookies that Internet Explorer can store for each domain from 20 to 50. For more information, see [Internet Explorer and Microsoft Edge frequently asked questions (FAQ) for IT Pros](/internet-explorer/kb-support/ie-edge-faqs).

### Troubleshooting scenario 3

After the request leaves the client, there are various layers that can affect the packets that are being sent (firewalls, proxies, and load balancers). To determine if a network device is removing the cookie, you have to capture a network trace on the client and the server, and then search for the cookie in the body of the request. You might want to look at the client request to make sure that the cookie was sent, and then check the server trace to make sure that the server received that cookie.

**Client request**

This is a `GET` request after the user has been authenticated. The forms authentication ticket information is highlighted in grey. This confirms that the cookie information left the client. When you use a network capture tool, like [WireShark](https://www.wireshark.org/download.html), you see the traffic that actually went through the adapter.

```output
47 45 54 20 68 74 74 70-3a 2f 2f 6c 6f 63 61 6c   GET http://local
68 6f 73 74 2f 46 6f 72-6d 73 41 75 74 68 4c 6f   host/FormsAuthLo
67 54 65 73 74 2f 57 65-62 46 6f 72 6d 31 2e 61   gTest/WebForm1.a
73 70 78 20 48 54 54 50-2f 31 2e 31 0d 0a 41 63   spx HTTP/1.1..Ac
63 65 70 74 3a 20 69 6d-61 67 65 2f 67 69 66 2c   cept: image/gif,
…Other headers of the GET request…
63 68 65 0d 0a 43 6f 6f-6b 69 65 3a 20 2e 41 53   che..Cookie: .AS
50 58 41 55 54 48 3d 33-43 45 46 39 42 39 41 30   PXAUTH=3CEF9B9A0
43 33 37 41 44 46 36 33-45 36 42 44 33 37 42 36   C37ADF63E6BD37B6
39 43 44 41 32 35 30 30-30 46 38 30 37 32 38 46   9CDA25000F80728F
35 31 43 39 35 36 36 44-31 34 43 35 34 31 34 35   51C9566D14C54145
38 31 43 39 33 45 32 41-30 31 44 44 43 44 45 46   81C93E2A01DDCDEF
32 34 41 31 37 34 32 39-34 31 30 43 30 39 37 34   24A17429410C0974
42 33 45 43 42 30 36 34-32 32 38 45 33 35 33 39   B3ECB064228E3539
39 41 38 32 32 42 33 42-39 33 36 44 46 30 38 46   9A822B3B936DF08F
42 41 42 44 33 45 31 30-32 44 30 30 32 31 30 43   BABD3E102D00210C
32 45 31 33 39 38 30 37-39 42 32 33 35 32 39 46   2E1398079B23529F
34 46 35 44 37 34 41 3b-20 50 72 6f 66 69 6c 65   4F5D74A; Profile
3d 56 69 73 69 74 6f 72-49 64 3d 62 32 34 65 62   =VisitorId=b24eb
```

**Server-side request**

When you see the request that reached the server, make sure that the server received the same information that the client sent. If the server didn't receive the same information, you need to investigate other devices on the network to determine where the cookie was removed.

> [!NOTE]
> There have also been instances of ISAPI filters removing cookies. If you confirm that the Web server received the cookie, but the cookie isn't listed in the IIS logs, check the ISAPI filters. You may have to remove the filters to see if the problem is resolved.

### Troubleshooting scenario 5

- If the scenario involves a web farm, then the machineKeys should be same across everywhere. Use the following machineKey to maintain the consistency on all the servers on the farm:

    ```xml
    <machineKey validationKey="87AC8F432C8DB844A4EFD024301AC1AB5808BEE9D1870689B63794D33EE3B55CDB315BB480721A107187561F388C6BEF5B623BF31E2E725FC3F3F71A32BA5DFC" decryptionKey="E001A307CCC8B1ADEA2C55B1246CDCFE8579576997FF92E7" validation="SHA1" />
    ```

- Compare the timeout values for both forms that is authentication module and the session module on all of the web servers.
- Compare the *System.Web.dll* version under Framework folder for ASP.NET 4 between all of the web servers in the farm. Forms authentication failed for the request. The reason is that the ticket supplied was invalid. This happens due to missing Reliability Update 1 for MS .NET framework 4 on one of the web server.
- Install the Reliability Update 1 for the .NET Framework 4 kb2533523 on the server that was missing it and rebooted the server. The issue is fixed. For more information, see [Reliability Update 1 for the .NET Framework 4](https://support.microsoft.com/topic/reliability-update-1-for-the-net-framework-4-5a8de0be-f4a9-f89e-e40d-f59dd1e353e5).

### More information

- [Internet Explorer and Microsoft Edge per-domain cookie limit](/internet-explorer/kb-support/ie-edge-faqs)

[!INCLUDE [Third-party disclaimer](../../../../../includes/third-party-disclaimer.md)] 
