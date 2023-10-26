---
title: Diagnostics pages for Windows Integrated Authentication troubleshooting
description: This article 
ms.date: 03/24/2020
ms.custom: sap:WWW authentication and authorization
ms.reviewer: paulboc, aartigoyle, v-sidong
ms.topic: how-to
ms.technology: iis-www-authentication-authorization
---
# Diagnostics pages for Windows Integrated Authentication troubleshooting

Troubleshooting Windows Integrated Authentication failure scenarios, especially when you deal with Kerberos credential delegation can be challenging. Although a detailed checklist on how to ensure you have the correct configuration for IIS to work with Windows Integrated Authentication and optionally use Credential Delegation here, this article specifically targets scenarios where:

- You're able to login to your target website from the client computer but unsure if you're using NTLM or Kerberos as an authentication mechanism.
- You're able to login to your target website, however, you're getting prompted and only after you input a username and password combination are you allowed to login.
- You're able to reach your target website on the front-end server, but when you initiate an action that requires the front-end server to make calls to a backend Http endpoint using the authenticated user's credentials, this fails.

For the purposes of this article, we will use the following layout, where client1 is the workstation or laptop that's domain joined from which the hypothetical user will initiate all connection attempts. *Web-serv1* is the front-end IIS server hosting an ASP.NET (on .NET Framework) website that uses Windows Integrated Authentication and runs using the identity of a service account: *domain\serviceaccount*. *Web-serv2* is the backend webserver that also hosts an ASP.NET (.Net Framework site) that will expose API endpoints for the front-end application. It's also configured to allow requests that make use of Windows Integrated Authentication and executes in an application pool that uses *domain\serviceapiaccount* as an application pool identity.

To ease the collection of data for the above-mentioned scenarios and not to rely on external data gathering tools such as Fiddler or WireShark (since connections between the three computers may be using https and therefore all exchanges between them would be encrypted), two self-contained diagnostics pages are at your disposal on the Microsoft samples repository and can be downloaded from here.

## Troubleshooting pages

These pages are coded in ASP.NET WebForms and are intended to have the code as well as the markup for the page bundled in one file that can simply be copied to the root of the web-application you're trying to troubleshoot, without any need for compilation or deployment of any kind. The pages are:

- Whomai.aspx - This page allows the dumping of authentication related information such as:

  - The authentication method that used to access the target site. If this is based on the Negotiate provider for Windows Integrated, the page will show if Kerberos or NTLM was used to authenticate the user.
  - The identity of the account that is running the application pool which is hosting the site.
  - The impersonation level for the authenticated user. If Kerberos is used for authentication, and unconstrained credential delegation is allowed, the impersonation level will be marked as 'delegate', if not it will be marked as impersonate in the case of constrained delegation or simple impersonation.
  - The identity of the authenticated user (as well as the groups the user belongs to).
  - The identity of the account executing the page’s code (which can be the authenticated user or the application pool user depending on the impersonation settings)
  - All the values of the request headers for the request that came into the whoami.aspx page as recovered from the HTTP Server variables

- ScrapperTest.aspx page is made to work in conjunction with the Whoami.aspx page, allowing requests from a front-end server to be directed to arbitrary urls for the backend servers. The page presents a UI interface that allows a user to:

  - Enter the desired url of the backend server resource that the page should attempt to load
  - Determine if they are authenticated when loading the ScrapperTest.aspx page and if authenticated, what user are they authenticated as.
  - In the scenario where the user is indeed authenticated, a checkbox allows for the attempted re-use of the user’s credentials when attempting to load the backend resource indicated in the url textbox

## How to deploy

Since both pages are self-contained, the only thing needed is to:

- Download the pages from the GitHub repository and extract the pages from the zip file archive
- Copy either the whoami.aspx or both pages to the root of your target web-applications that are running inside of IIS.
- Make a request to the url of your site appending either /whoami.aspx or /scrappertest.aspx depending on which page you wish to reach.

## Usage

The first usage scenario is when attempting to determine what authentication method is used to access a given website or web-application hosted on IIS. For this, you can make requests to the whoami.aspx page that you have previously deployed to the site. On the first request, the page will:

- Display the authentication information, and if the Negotiate provider for Windows Integrated Authentication is used, it will also list the authentication protocol that is used: Kerberos or NTLM
- Subsequent requests in a scenario where Negotiate is used as a provider for Windows Integrated Authentication will only display the ‘Session Based’ label next to the authentication type. You may look at Session Based vs Request Based authentication explained in this article to learn more.
- All other authentication information, such as application pool user, authenticated user and executing user details as well as the incoming request’s headers will be displayed on each request.

The whoami.aspx page also displays a small form at the bottom of the page allowing you to issue POST requests to the server, in order to test how the browser behaves when issuing these types of requests. If the page has been idle for more the 60 seconds, the TCP connection that was used to download the page to the browser, and which was authenticated by the server will be severed due to inactivity. Hence when making a POST request, a new TCP connection will be opened and authentication will have to take place all over again. With POST requests there is a subtlety:

- The browser will first send the HTTP POST request headers
- It will then issue the body of the POST request, which contains the information captured from the various input fields on the HTTP form displayed on the page.

If the browser does not wait after sending the POST request’s headers, and proceeds to send the body directly on an unauthenticated connection, the following may occur:

- The server receives the POST request headers, and since the connection is not authenticated (assuming Windows Integrated Authentication or another challenge based authentication), it will issue a 401 response with the appropriate authentication response HTTP headers (WWW-Authenticate)
- During this time, the browser will have already sent over the POST request body, before receiving the 401 response from the server
- The server will then receive an unauthenticated POST request body on a connection it had previously indicated to the client that authentication is required.
- This will result in the severing of the underlying TCP connection by the server, and the browser potentially displaying a ‘Web Page is not available message’

The ScrapperTest.aspx page will be used to test delegation of credential scenarios from the front-end server to back-end server endpoints. Once the page is requested from the client browser, it will offer a UI that will allow for:

- Entering of the backend endpoint url that the front-end server should be connecting to.
- Verifying that the user is authenticated on the front-end and what username was used to connect to the front-end server.
- Deciding (in case authentication was used to access the scrappertest.aspx page) if the credentials of the authenticated user should be passed on with the request to the backend server (if impersonation and delegation is possible).

Once the 'Scrap Page' button is selected, the code of the scrappertest.aspx page will issue a GET request for the indicated target url. If the use authentication checkbox is checked, the authenticated user's credentials will also be used to make the request, if authentication is needed to access the backend endpoint specified. If there is a successful request, the result will be displayed in the form of raw HTTP output of the received response in the text area control of the page.

We envisaged the usage of the scrappertest.aspx page in conjunction with the whoami.aspx page that should be placed inside the ASP.NET application that would be contacted on the backend server. Thus, the HTTP response that is recovered by the scrappertest.aspx page will be the HTML output of the whoami.aspx page when executed on the backend. This output can then be evaluated to understand how the request was authenticated on the backend and which accounts were used.

## More information

If you wish to further your understanding of Windows Integrated Authentication setup with Kerberos, you can check:

- [Troubleshoot Kerberos failures in Internet Explorer](troubleshoot-kerberos-failures-ie.md)
- [Kerberos unconstrained double-hop authentication with Microsoft Edge (Chromium)](kerberos-double-hop-authentication-edge-chromium.md)
- [Request based versus Session based Kerberos Authentication (or the AuthPersistNonNTLM parameter)](https://techcommunity.microsoft.com/t5/iis-support-blog/request-based-versus-session-based-kerberos-authentication-or/ba-p/916043)
