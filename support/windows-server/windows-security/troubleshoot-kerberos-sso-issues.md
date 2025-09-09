---
title: Troubleshooting Kerberos Single Sign-on Issues
description: Provides guidance to troubleshoot Kerberos single sign-on authentication issues.
ms.date: 06/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom:
- sap:windows security technologies\kerberos authentication
- pcy:WinComm Directory Services
ms.reviewer: kaushika, raviks,
---

# Troubleshooting Kerberos single sign-on issues

> [!IMPORTANT]  
> Before you use the procedures in this article, follow the steps in the Kerberos [Troubleshooting checklist](kerberos-authentication-troubleshooting-guidance.md#troubleshooting-checklist). The most common causes of Kerberos problems are infrastructure issues or service principal name (SPN) issues. The checklist helps you identify such issues. Additionally, the procedures in this article use some of the information that you collect while you follow the checklist. In particular, you might have to know whether the client computer received a service ticket for the target service.

Kerberos authentication supports single sign-on (SSO) authentication in intranet environments. SSO issues usually indicate that the client application uses a protocol other than Kerberos to authenticate the user when it should use Kerberos. Such issues could be caused by a configuration problem in the service or in the client application.

> [!NOTE]  
> If the issue affects only a few users or computers, the issue is more likely caused by the client configuration than by the service configuration. In that case, you can skip to the [Check the configuration of an affected client application](#3-check-the-configuration-of-an-affected-client-application) procedure in this article.

## 1. Check the target service configuration

The configuration of your target service (typically a web server or other application server) depends, in part, on the kind of service that you use, and, in some cases, on the version of the service. The following guidelines apply:

- If your target service (or the front-end application) runs on Internet Information Server (IIS), follow the steps later in this section.
- If you use a different kind of service (such as Microsoft SQL Server or a third-party service), review the documentation for the service or contact the service support provider. Make sure that the service is configured correctly to support SSO authentication.

Use the IIS tool (available on the Server Manager **Tools** menu) to review web site settings:

1. In the IIS console, expand the IIS server, and then select the website. In the right pane, double-click **Authentication**.
2. Make sure that **Anonymous Authentication** is disabled and **Windows Authentication** is enabled.
3. Select **Windows Authentication**, open the **Actions** list, and then select **Providers**.
4. Make sure that the **Enabled Providers** list displays **Negotiate** at the top of the list and **NTLM** second in the list.
5. Select **OK**.
6. Make sure that any changes propagate to all servers, and then try again to authenticate.

If SSO still doesn't work correctly, go to the next procedure.

## 2. Check for a service ticket

When you collected trace data, did you find a service ticket?

If the client computer received a ticket to the target service when you authenticated, then the problem might relate to the manner in which credentials are delegated. For information about how to troubleshoot delegation issues, see [Kerberos authentication troubleshooting guidance: Troubleshoot delegation issues](kerberos-authentication-troubleshooting-guidance.md#delegation-issues).

If the client computer doesn't have a service ticket, go to the next procedure.

## 3. Check the configuration of an affected client application

Different kinds of clients use different criteria to identify intranet sites, and use different settings to implement single sign-on. The procedures in this article apply to Microsoft Edge, version 87 or a newer version (or browser-based applications that are based on Microsoft Edge). If you use a different kind of client, consider the following options:

- **Clients that aren't browser-based**. Review the documentation for the client application or contact the application's support provider. Make sure that the client is configured correctly to support SSO authentication.

- **Clients that are based on Internet Explorer (or similar older browser)**. Older browsers, including Internet Explorer (all versions) and Microsoft Edge versions older than version 87 use different default configurations than the newer browsers. For more information about how to troubleshoot Kerberos issues when using Internet Explorer, see [Troubleshoot Kerberos failures in Internet Explorer](../../developer/webapps/iis/www-authentication-authorization/troubleshoot-kerberos-failures-ie.md).

Unlike older browsers, Microsoft Edge, version 87 (and later versions) uses only two internet zones: **Internet** and **Local intranet**. Edge ignores other zone settings, such as **Restricted sites**. Additionally, Edge doesn't always use the client computer zone settings to identify intranet sites. Edge considers other factors, such as proxy configurations. For these reasons, Group Policy provides the most consistent method to manage Microsoft Edge configuration.

> [!NOTE]  
> If you have to check the configuration on a single computer, see [Check a single client computer's internet authentication settings](#check-a-single-client-computers-internet-authentication-settings).

The **AuthServerAllowlist** Group Policy setting (**Configure list of allowed authentication servers**) takes precedence over the zone settings on the client computer. To check this setting, use the Group Policy Management Console and the Group Policy Editor (available on the **Tools** menu in Server Manager). Make sure that this setting does the following actions:

- Lists the fully qualified domain names (FQDNs) of the target servers
- Applies to the clients and users that have to authenticate

For more information, see the following articles:

- [AuthServerAllowList](/deployedge/microsoft-edge-policies#authserverallowlist)
- [Per-site configuration by policy](/deployedge/per-site-configuration-by-policy#windows-security-zones)

For information about how to obtain and work with the Microsoft Edge Group Policy administrative templates, see [Configure Microsoft Edge policy settings on Windows devices](/deployedge/configure-microsoft-edge).

If you make any changes to the Group Policy settings, make sure that the changes propagate to the client computers and users. Restart the client browser that you're troubleshooting, clear the browser cache, and then try again to authenticate.

### Check a single client computer's internet authentication settings

To check the configuration of a single client computer independently of the Group Policy settings, follow these steps:

1. In the Search box on the client computer, enter **Internet options**. In the search results, select **Internet options**.
2. In **Internet Properties**, select **Advanced**.
3. In the **Security** category on the **Advanced** tab, make sure that **Enable Integrated Windows Authentication** is selected.
4. In **Internet Properties**, select **Security**, and then select **Local intranet** > **Sites**.
5. Make sure that the settings are correct for your environment, and then try again to authenticate.
