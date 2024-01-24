---
title: Diagnostic pages for Windows Integrated Authentication troubleshooting
description: This article describes the diagnostic pages for troubleshooting Windows Integrated Authentication failures.
ms.date: 11/03/2023
ms.custom: sap:WWW authentication and authorization
ms.reviewer: paulboc, aartigoyle, v-sidong
ms.subservice: www-authentication-authorization
---

# Diagnostic pages for Windows Integrated Authentication troubleshooting

Troubleshooting Windows Integrated Authentication failure scenarios can be challenging, especially when you deal with Kerberos credential delegation. Although there's a detailed [checklist](../www-authentication-authorization/troubleshoot-kerberos-failures-ie.md) on how to ensure you have the correct configuration for Internet Information Services (IIS) to work with Windows Integrated Authentication and optionally use credential delegation, this article specifically targets the following scenarios:

- You can sign in to your target website from the client computer, but you're unsure whether you're using [NTLM](/windows-server/security/kerberos/ntlm-overview) or Kerberos as the authentication mechanism.
- You can sign in to your target website, but you're prompted to sign in only after entering a username and password combination.
- You can access your target website on the front-end server, but it fails when you initiate an action that requires the front-end server to call a back-end HTTP endpoint using the authenticated user's credentials.

For the purposes of this article, consider the following layout:

- *Client 1* is the domain-joined workstation or laptop from which the hypothetical user will initiate all connection attempts.

- *Web-serv1* is the front-end IIS server hosting an ASP.NET (on .NET Framework) website that uses Windows Integrated Authentication and runs using the identity of a service account: *domain\serviceaccount*.

- *Web-serv2* is the back-end web server that also hosts an ASP.NET (on .NET Framework) site that will expose API endpoints for the front-end application. It's also configured to allow requests that use Windows Integrated Authentication and execute in an application pool that uses *domain\serviceapiaccount* as an application pool identity.

:::image type="content" source="media/diagnostics-pages-windows-integrated-authentication/workstation-web-serv1-web-serv2.png" alt-text="Screenshot shows the layout of workstation, Web-serv1, and Web-serv2.":::

To ease the data collection for these scenarios and not to rely on external data-gathering tools such as Fiddler or WireShark (since connections between the three computers might use HTTPS and therefore all exchanges between them will be encrypted), use the two self-contained diagnostic pages in [ASP.NET Self Contained Pages for Troubleshooting Windows Integrated Authentication issues on IIS](https://github.com/aspnet/samples/tree/main/samples/aspnet/Identity/CurrentUserInfoRetrieval).

## Troubleshooting pages

The two pages are coded in [ASP.NET Web Forms](/aspnet/web-forms/). They're intended to bundle the code and the markup for the page in one file that can be copied to the root of the web application you're trying to troubleshoot, without any need for compilation or deployment. The pages are:

- *[WhoAmI.aspx](https://github.com/aspnet/samples/blob/main/samples/aspnet/Identity/CurrentUserInfoRetrieval/WhoAmI.aspx)* - This page allows the dumping of authentication-related information such as:

  - The authentication method used to access the target site. If the method is based on the Negotiate provider for Windows Integrated Authentication, the page shows if Kerberos or NTLM is used to authenticate the user.
  - The identity of the account that runs the application pool hosting the site.
  - The [impersonation](../../aspnet/development/implement-impersonation.md) level for the authenticated user. If Kerberos is used for authentication and unconstrained credential delegation is allowed, the impersonation level is marked as delegate. If not, it will be marked as impersonate in the case of constrained delegation or simple impersonation.
  - The identity of the authenticated user and the groups the user belongs to.
  - The identity of the account executing the page's code (it can be an authenticated user or an application pool user, depending on the [impersonation](../../aspnet/development/implement-impersonation.md) settings).
  - All the values of the request headers for requests that come into the *WhoAmI.aspx* page as recovered from the [IIS Server Variables](/previous-versions/iis/6.0-sdk/ms524602(v=vs.90)).

    :::image type="content" source="media/diagnostics-pages-windows-integrated-authentication/whoami-page.png" alt-text="Screenshot shows the Who Am I Page with authentication information and identity.":::

- *[ScrapperTest.aspx](https://github.com/aspnet/samples/blob/main/samples/aspnet/Identity/CurrentUserInfoRetrieval/ScrapperTest.aspx)* - This page is made to work with the *WhoAmI.aspx* page, allowing requests from the front-end server to be directed to any URLs on the back-end server. The page presents a UI interface that allows a user to:

  - Enter the desired URL of the back-end server resource that the page should attempt to load.
  - Determine if they're authenticated when loading the *ScrapperTest.aspx* page, and if authenticated, which users they're authenticated as.
  - In the scenario where the user is indeed authenticated, a checkbox allows the attempt to reuse the user's credentials when trying to load the back-end resource indicated in the URL textbox.

    :::image type="content" source="media/diagnostics-pages-windows-integrated-authentication/web-serv1-scrappertest.png" alt-text="Screenshot shows the ScrapperTest page.":::

## How to deploy

Since both pages are self-contained, the only thing needed is to:

1. Download the pages from the [GitHub repository](https://github.com/aspnet/samples/tree/main/samples/aspnet/Identity/CurrentUserInfoRetrieval).
1. Copy the *WhoAmI.aspx* page or both pages to the root of your target web applications that are running inside of IIS.
1. Make a request to the URL of your site appending */WhoAmI.aspx* or */ScrapperTest.aspx*, depending on which page you wish to access.

## Usage

The first usage scenario is attempting to determine what authentication method is used to access a given website or web application hosted on IIS. For this one, you can make requests to the *WhoAmI.aspx* page that you have previously deployed to the site.

- On the first request, the page will display the authentication information. If the Negotiate provider for Windows Integrated Authentication is used, it will also list the authentication protocol that's used: Kerberos or NTLM.

- Subsequent requests in a scenario where Negotiate is used as the provider for Windows Integrated Authentication will only display the **Session Based** label next to the authentication type. For more information, see [Request-based versus Session-based Kerberos Authentication (or the AuthPersistNonNTLM parameter)](https://techcommunity.microsoft.com/t5/iis-support-blog/request-based-versus-session-based-kerberos-authentication-or/ba-p/916043).

- All other authentication information, such as the application pool user, authenticated user, execution user details, and the incoming request's headers, will be displayed on each request.

The *WhoAmI.aspx* page also displays a small form at the bottom. This form allows you to issue `POST` requests to the server to test how the browser behaves when issuing these types of requests. If the page is idle for more than 60 seconds, the Transmission Control Protocol (TCP) connection used to download the page to the browser and authenticated by the server will be severed due to inactivity. Hence, when you make a `POST` request, a new TCP connection is opened, and you must re-authenticate. There's a subtlety with `POST` requests:

1. The browser first sends the HTTP `POST` request headers.
1. It then issues the body of the `POST` request, which contains the information captured from the various input fields on the HTTP form displayed on the page.

If the browser doesn't wait after sending the `POST` request's headers, but instead sends the body directly on an unauthenticated connection, the following issues might occur:

- The server receives the `POST` request headers, and since the connection isn't authenticated (assuming Windows Integrated Authentication or another challenge-based authentication is used), it issues a 401 response with the appropriate authentication response HTTP header (`WWW-Authenticate`).
- During this time, the browser has already sent the `POST` request body before receiving the 401 response from the server.
- The server then receives an unauthenticated `POST` request body on a connection it has previously indicated to the client that authentication is required.
- This results in the severing of the underlying TCP connection by the server, and the browser potentially displaying a "Web Page is not available" message.

The *ScrapperTest.aspx* page is used to test the delegation of credential scenarios from the front-end server to the back-end server endpoint. Once the page is requested from the client browser, it will offer a UI that allows:

- Entering the back-end endpoint URL to which the front-end server should connect.
- Verifying that the user is authenticated on the front-end and what username is used to connect to the front-end server.
- Deciding (in case authentication is used to access the *ScrapperTest.aspx* page) if the credentials of the authenticated user should be passed on with the request to the back-end server (if impersonation and delegation are possible).

Once the **Scrap Page** button is selected, the code of the *ScrapperTest.aspx* page will issue a `GET` request for the indicated target URL. If the **Use Credentials** checkbox is checked, and authentication is needed to access the back-end endpoint specified, the authenticated user's credentials are also used to make the request. If a request is successful, the result is displayed in the text area control of the page as the raw HTTP output of the received response.

A usage scenario that we envision is to place the *ScrapperTest.aspx* page and the *WhoAmI.aspx* page inside the ASP.NET application that would be contacted on the back-end server. Thus, the HTTP response recovered by the *ScrapperTest.aspx* page will be the HTML output of the *WhoAmI.aspx* page when executed on the back end. This output can then be evaluated to understand how the request was authenticated on the back end and which accounts were used.

## More information

To further understand Windows Integrated Authentication setup using Kerberos, see:

- [Troubleshoot Kerberos failures in Internet Explorer](troubleshoot-kerberos-failures-ie.md)
- [Kerberos unconstrained double-hop authentication with Microsoft Edge (Chromium)](kerberos-double-hop-authentication-edge-chromium.md)
- [Request based versus Session based Kerberos Authentication (or the AuthPersistNonNTLM parameter)](https://techcommunity.microsoft.com/t5/iis-support-blog/request-based-versus-session-based-kerberos-authentication-or/ba-p/916043)
