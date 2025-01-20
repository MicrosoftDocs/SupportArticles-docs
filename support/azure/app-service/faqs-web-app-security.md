---
title: Azure App Service Security FAQs
description: Provides answers to common questions about Azure App Service security.
services: app-service
author: hepiet
ms.topic: faq
ms.date: 01/20/2025
ms.author: genlin
ms.service: azure-app-service

# Frequently asked questions about App Service security

The Microsoft Security Response Center (MSRC) investigates all reports of security vulnerabilities that affect Microsoft products and services, and provides the information in the [Security Update Guide](https://msrc.microsoft.com/update-guide/vulnerability) as part of the ongoing effort to help you manage security risks and help keep your systems protected.

If your question isn't answered and you still need help, have the number of the CVE you would like to check and report a vulnerability on [Microsoft Security Response Center](https://msrc.microsoft.com/) or submit a support request at [Azure support](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot).

## FAQs

### How do I know whether a specific CVE (common vulnerability) or known security issue applies to my Web App?

App Service is a platform with various underlying technologies like Windows, Linux and web application frameworks. Updates are applied at a routine cadence for OS, host runtime and Microsoft image repo.
You can check OS and runtime patching in Azure App Service to know more when updates are applied and Guest OS patches to check the updates applied to the Azure Guest OS.
If your question wasn't answered and you still need help, gather the following information before submitting a request to Azure Support:

- Specify the security patch you are inquiring about.
- Confirm the security patch version deployed on Azure for the software.
- Determine whether the patch has already been applied in Azure.

### Is TLS 1.3 supported on Azure App Service?

For incoming requests to your web app, App Service supports TLS versions 1.0, 1.1, 1.2, and 1.3. See [Azure App Service TLS overview](/azure/app-service/overview-tls) for more information.

### How do I disable weak ciphers on Azure App Service?

A cipher suite is a set of instructions that contains algorithms and protocols to help secure network connections between clients and servers. By default, the front-end’s OS would pick the most secure cipher suite that is supported by both the front-end and the client. However, if the client only supports weak cipher suites, then the front-end’s OS would pick a weak cipher suite that they both support. To help you have a clearer understanding of Cipher suites, see [Demystifying Cipher Suites on Azure App Services](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/demystifying-cipher-suites-on-azure-app-services/ba-p/2656254).

For [Azure App Service Environment (ASE)](/azure/app-service/environment/overview), you can set your own ciphers through Azure Resource Explorer. For detail steps, see[Change TLS cipher suite order](/azure/app-service/environment/app-service-app-service-environment-custom-settings#change-tls-cipher-suite-order).

To disable Weak TLS cipher Suites for Web Apps on Multi-tenant, see [Disabling Weaker TLS Cipher Suites for Web Apps on Multi-tenant Premium App Service Plans](https://azure.github.io/AppService/2022/10/11/Public-preview-min-tls-cipher-suite.html).

For more information, see [FAQ on App Service cipher suites](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/faq-on-app-service-cipher-suites/ba-p/3881922).

### How do I enable protection against DDoS attacks or suspicious activity for my app service?

By default, Distributed Denial of Service (DDoS) protection is not enabled for App Service plans and their app services.

You can use [Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview) to protect your Azure resources from attacks. Azure DDoS Protection, combined with application design best practices, provides enhanced DDoS mitigation features to defend against DDoS attacks.

Note that [Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview) is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. However, Traffic Manager does not provide protection against DDoS attacks.

### I suspect my website is being hacked, what should I do?

Microsoft secures and [frequently updates the hosting environment and infrastructure](/azure/app-service/overview-patch-os-runtime). If the website has been hacked or defaced, it is usually due to an exploited vulnerability that is often caused by an outdated package.

Azure App Service does not block insecure apps from running. If the website is vulnerable, you must fix the vulnerabilities in the website code and redeploy it to Azure App Service. 

Azure support can assist with reviewing the web app's HTTP logs and deployment history to identify when the unknown file was first accessed or what suspicious patterns appear in the logs. We can also offer guidances for configuring security services like Web Application Firewall and Microsoft Defender for App Service. However, we cannot take direct action, as the permanent fix may involve implementing a Web Application Firewall or updating the existing codes.

You can [restore a backup](/azure/app-service/manage-backup?tabs=portal#restore-a-backup) or re-deploy the site, but this is not a long term fix if the security issue is not fixed.

### My site has been added to the block list, what should I do?

If the IP address is frequently blocklisted, it's important to investigate the root cause. This may result from sending spam emails, hosting malicious content, or other security vulnerabilities that should be resolved.

- **Inbound IP blacklisted**: To address an inbound IP blocklisting issue, request a [static inbound IP address](/azure/app-service/overview-inbound-outbound-ips#get-a-static-inbound-ip) by securing your domain with IP-based SSL. Alternatively, you can use Azure services such as [Azure Application Gateway](https://learn.microsoft.com/en-us/azure/application-gateway/overview) or [App Service Environment](https://learn.microsoft.com/en-us/azure/app-service/environment/networking) (ASE) to gain a dedicated inbound IP address.  

- **Outbound IP blacklisted**: The only way to request dedicated outbound IP addresses is to use an App Service Environment. Apps running in Azure share outbound addresses from a common pool.  
    - You can deploy your app in a different (resource group + location) to host the application in a new scale unit. [Scaling your app between pricing tiers](/azure/app-service/manage-scale-up#scale-up-your-pricing-tier) will also trigger a change in outbound IP addresses.  
    - Alternatively, use [Azure's NAT Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) to assign dedicated outbound IP addresses to your resources.  
    - For more information, see [How to fix outbound IPs for App Service using NAT Gateway](https://techcommunity.microsoft.com/blog/appsonazureblog/how-to-fix-outbound-ips-for-app-service/2320612).  

- **SMTP blacklisted**: The port 25 is mainly used for unauthenticated email delivery. Outbound connections from App Services to the public internet using port 25 are not restricted. However, using this design could result in outbound IP addresses being flagged as spam and blocklisted.  
    - We recommend using authenticated SMTP relay services to send email or implementing App Service VNet Integration.  
    - Alternatively, host the App Service in an [App Service Environment (ASE)](https://learn.microsoft.com/en-us/azure/app-service/environment/networking) to route outbound SMTP connections over a private network.  
    - For details, refer to [Troubleshoot outbound SMTP connectivity problems in Azure](/azure/virtual-network/troubleshoot-outbound-smtp-connectivity).  

### Why am I receiving warnings or alerts for my web app in security scan reports

Security scans are typically run against a web app URL. Make sure that the tested URL resolves to the intended web app. If it resolves elsewhere, such as an application gateway that leads the inaccurate scan result.

Some scan results could be a false positive, or others could be a genuine security issues that may require a consult with Azure support. Certain changes are within your control such as networking or website configuration, other changes are only within Microsoft's control at the platform level.

Azure support can assist by reviewing the full scan results, research to confirm if the result is true, and provide security feature options to you.
