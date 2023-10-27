---
title: Diagnostics pages for Windows Integrated Authentication troubleshooting
description: This article describes the diagnostics pages for Windows Integrated Authentication troubleshooting.
ms.date: 10/27/2023
ms.custom: sap:WWW authentication and authorization
ms.reviewer: paulboc, aartigoyle, v-sidong
ms.topic: 
ms.technology: iis-www-authentication-authorization
---
# Diagnostics pages for Windows Integrated Authentication troubleshooting

Troubleshooting Windows Integrated Authentication failure scenarios can be challenging, especially when you deal with Kerberos credential delegation. Although a detailed checklist on how to ensure you have the correct configuration for IIS to work with Windows Integrated Authentication and optionally use [credential delegation](../www-authentication-authorization/troubleshoot-kerberos-failures-ie.md), this article specifically targets the following scenarios:

- You can sign in to your target website from the client computer, but you're unsure whether you're using NTLM or Kerberos as an authentication mechanism.
- You can sign in to your target website, however, you're getting prompted that you'll only be allowed to sign in after you input a username and password combination.
- You can reach your target website on the front-end server, but it fails when you initiate an action that requires the front-end server to make calls to a backend HTTP endpoint using the authenticated user's credentials.

For the purposes of this article, use the following layout:

- *Client 1* is the workstation or laptop that's domain joined from which the hypothetical user will initiate all connection attempts.

- *Web-serv1* is the front-end IIS server hosting an ASP.NET (on .NET Framework) website that uses Windows Integrated Authentication and runs using the identity of a service account: *domain\serviceaccount*.

- *Web-serv2* is the backend web server that also hosts an ASP.NET (.NET Framework site) that will expose API endpoints for the front-end application. It's also configured to allow requests that make use of Windows Integrated Authentication and executes in an application pool that uses *domain\serviceapiaccount* as an application pool identity.

:::image type="content" source="media/diagnostics-pages-windows-integrated-authentication/workstation-web-serv1-web-serv2.png" alt-text="The screenshot shows the layout for workstation, Web-serv1, and Web-serv2.":::

To ease the collection of data for the above-mentioned scenarios and not to rely on external data gathering tools such as Fiddler or WireShark (since connections between the three computers may be using HTTPs and therefore all exchanges between them would be encrypted), two self-contained diagnostics pages are at your disposal in [ASP.NET Self Contained Pages for Troubleshooting Windows Integrated Authentication issues on IIS](https://github.com/aspnet/samples/tree/main/samples/aspnet/Identity/CurrentUserInfoRetrieval).

## Troubleshooting pages

These pages are coded in [ASP.NET Web Forms](/aspnet/web-forms/) and are intended to have the code as well as the markup for the page bundled in one file that can be copied to the root of the web-application you're trying to troubleshoot, without any need for compilation or deployment of any kind. These pages are:

- *WhoAmI.aspx* - This page allows the dumping of authentication related information such as:

  - The authentication method used to access the target site. If the method is based on the Negotiate provider for Windows Integrated Authentication, the page shows if Kerberos or NTLM was used to authenticate the user.
  - The identity of the account that is running the application pool which is hosting the site.
  - The [impersonation](../../aspnet/development/implement-impersonation.md) level for the authenticated user. If Kerberos is used for authentication and unconstrained credential delegation is allowed, the impersonation level will be marked as delegate. If not, it will be marked as impersonate in the case of constrained delegation or simple impersonation.
  - The identity of the authenticated user (and the groups the user belongs to).
  - The identity of the account executing the page's code (which can be the authenticated user or the application pool user depending on the [impersonation](../../aspnet/development/implement-impersonation.md) settings).
  - All the values of the request headers for the request that came into the *WhoAmI.aspx* page as recovered from the [IIS Server Variables](/previous-versions/iis/6.0-sdk/ms524602(v=vs.90)).

    :::image type="content" source="media/diagnostics-pages-windows-integrated-authentication/whoami-page.png" alt-text="The screenshot shows the "Who Am I Page" with authentication information and identity.":::

- *ScrapperTest.aspx* page is made to work with the *WhoAmI.aspx* page, allowing requests from a front-end server to be directed to arbitrary urls for the backend servers. The page presents a UI interface that allows a user to:

  - Enter the desired url of the backend server resource that the page should attempt to load.
  - Determine if they're authenticated when loading the *ScrapperTest.aspx* page and if authenticated, what users are they authenticated as.
  - In the scenario where the user is indeed authenticated, a checkbox allows for the attempted re-use of the user's credentials when attempting to load the backend resource indicated in the url textbox.

  :::image type="content" source="media/diagnostics-pages-windows-integrated-authentication/web-serv1-scrappertest.png" alt-text="The screenshot shows the ScrapperTest page.":::

## How to deploy

Since both pages are self-contained, the only thing needed is to:

1. Download the pages from the [GitHub repository](https://github.com/aspnet/samples/tree/main/samples/aspnet/Identity/CurrentUserInfoRetrieval) and extract the pages from the zip file archive.
1. Copy either the *WhoAmI.aspx* or both pages to the root of your target web-applications that are running inside of IIS.
1. Make a request to the url of your site appending either */WhoAmI.aspx* or */ScrapperTest.aspx* depending on which page you wish to reach.

## Usage

The first usage scenario is when attempting to determine what authentication method is used to access a given website or web-application hosted on IIS. For this one, you can make requests to the *WhoAmI.aspx* page that you have previously deployed to the site. On the first request, the page will:

- Display the authentication information, and if the Negotiate provider for Windows Integrated Authentication is used, it will also list the authentication protocol that is used: Kerberos or NTLM.

- Subsequent requests in a scenario where Negotiate is used as a provider for Windows Integrated Authentication will only display the **Session Based** label next to the authentication type. For more information, see **Session Based** vs **Request Based** authentication explained in [Request based versus Session based Kerberos Authentication (or the AuthPersistNonNTLM parameter)](https://techcommunity.microsoft.com/t5/iis-support-blog/request-based-versus-session-based-kerberos-authentication-or/ba-p/916043).

- All other authentication information, such as application pool user, authenticated user, and executing user details as well as the incoming request's headers will be displayed on each request.

The *WhoAmI.aspx* page also displays a small form at the bottom of the page allowing you to issue POST requests to the server, in order to test how the browser behaves when issuing these types of requests. If the page is idle for more than 60 seconds, the TCP connection that was used to download the page to the browser, and which was authenticated by the server will be severed due to inactivity. Hence, when you make a POST request, a new TCP connection will be opened and authentication will have to take place all over again. There's a subtlety with POST requests:

- The browser will first send the HTTP POST request headers.
- It then issues the body of the POST request, which contains the information captured from the various input fields on the HTTP form displayed on the page.

If the browser doesn't wait after sending the POST request's headers, and proceeds to send the body directly on an unauthenticated connection, the following issues may occur:

- The server receives the POST request headers, and since the connection isn't authenticated (assuming Windows Integrated Authentication or another challenge based authentication), it will issue a 401 response with the appropriate authentication response HTTP headers (WWW-Authenticate).
- During this time, the browser will have already sent over the POST request body, before receiving the 401 response from the server.
- The server will then receive an unauthenticated POST request body on a connection it had previously indicated to the client that authentication is required.
- This will result in the severing of the underlying TCP connection by the server, and the browser potentially displaying a "Web Page is not available" message.

The *ScrapperTest.aspx* page will be used to test delegation of credential scenarios from the front-end server to back-end server endpoints. Once the page is requested from the client browser, it will offer a UI that will allow for:

- Entering of the backend endpoint url that the front-end server should be connecting to.
- Verifying that the user is authenticated on the front-end and what username was used to connect to the front-end server.
- Deciding (in case authentication was used to access the *ScrapperTest.aspx* page) if the credentials of the authenticated user should be passed on with the request to the backend server (if impersonation and delegation is possible).

Once the **Scrap Page** button is selected, the code of the *ScrapperTest.aspx* page will issue a GET request for the indicated target url. If the use authentication checkbox is checked, the authenticated user's credentials will also be used to make the request, if authentication is needed to access the backend endpoint specified. If there's a successful request, the result is displayed in the form of raw HTTP output of the received response in the text area control of the page.

We envisaged the usage of the *ScrapperTest.aspx* page in conjunction with the *WhoAmI.aspx* page that should be placed inside the ASP.NET application that would be contacted on the backend server. Thus, the HTTP response that is recovered by the *ScrapperTest.aspx* page will be the HTML output of the *WhoAmI.aspx* page when executed on the backend. This output can then be evaluated to understand how the request was authenticated on the backend and which accounts were used.

## More information

To further understand Windows Integrated Authentication setup with Kerberos, see:

- [Troubleshoot Kerberos failures in Internet Explorer](troubleshoot-kerberos-failures-ie.md)
- [Kerberos unconstrained double-hop authentication with Microsoft Edge (Chromium)](kerberos-double-hop-authentication-edge-chromium.md)
- [Request based versus Session based Kerberos Authentication (or the AuthPersistNonNTLM parameter)](https://techcommunity.microsoft.com/t5/iis-support-blog/request-based-versus-session-based-kerberos-authentication-or/ba-p/916043)
