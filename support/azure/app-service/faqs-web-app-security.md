---
title: Azure App Service Security FAQs
description: Provides answers to common questions about Azure App Service security.
services: app-service
author: hepiet
ms.topic: faq
ms.date: 01/20/2025
ms.author: hepiet
ms.service: azure-app-service
---
# Frequently asked questions about App Service security

This article provides answers to common questions about Azure App Service security.

## FAQs

### How do I know whether a specific CVE (common vulnerability) or known security issue applies to my web app?

[Microsoft Security Response Center](https://msrc.microsoft.com/) (MSRC) investigates all reports of security vulnerabilities that affect Microsoft products and services. MSRC provides this information in the [Security Update Guide](https://msrc.microsoft.com/update-guide/vulnerability) as part of an ongoing effort to help you manage security risks and keep your systems protected.

If your question isn't answered and you still need help, submit a [support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot) that includes the number of the CVE. 

To report a vulnerability, see [Report an issue](https://msrc.microsoft.com/report/vulnerability/new).

### How do I know when a particular specific version of software or security patch will arrive at the Azure platform runtime?

App Service is a platform that has various underlying technologies, such as Windows, Linux, and web application frameworks. Updates are applied at a routine cadence for OS, host runtime, and Microsoft image repo.

- Check [this article](/azure/app-service/overview-patch-os-runtime) to understand OS and runtime updating in Azure App Service regarding the OS or software in App Service.
- Check [Guest OS update details](/azure/cloud-services/cloud-services-guestos-msrc-releases) to understand the updates that are applied to the Azure Guest OS.

If you still need help, gather the following information before you submit a request to [Azure support:

- Specify the security update that you're inquiring about.
- Verify the security update version of the software that's deployed on Azure.
- Determine whether the update is already applied in Azure.

### Is TLS 1.3 supported on Azure App Service?

For incoming requests to your web app, App Service supports TLS versions 1.0, 1.1, 1.2, and 1.3. See [Azure App Service TLS overview](/azure/app-service/overview-tls) for more information.

### How do I disable weak ciphers on Azure App Service?

A cipher suite is a set of instructions that contains algorithms and protocols to help secure network connections between clients and servers. A client makes a request to the server that includes a list of cipher suites that it supports, and the server (front-end of the web app) picks the most secure suite that's supported by both client and server. For a more comprehensive discussion of cipher suites, see [Demystifying Cipher Suites on Azure App Services](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/demystifying-cipher-suites-on-azure-app-services/ba-p/2656254).

For [Azure App Service Environment (ASE)](/azure/app-service/environment/overview), you can set your own ciphers through Azure Resource Explorer. For detailed steps, see [Change TLS cipher suite order](/azure/app-service/environment/app-service-app-service-environment-custom-settings#change-tls-cipher-suite-order).

To disable Weak TLS cipher suites for web apps on multitenant setups, see [Disabling weaker TLS ciphers suites for web apps on multitenant Premium App Service plans](https://azure.github.io/AppService/2022/10/11/Public-preview-min-tls-cipher-suite.html).

For more information, see [FAQ on App Service cipher suites](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/faq-on-app-service-cipher-suites/ba-p/3881922).

### How do I enable protection against DDoS attacks or suspicious activity for my app service?

By default, Distributed Denial of Service (DDoS) protection is not enabled for App Service plans and their app services.

You can use [Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview) to protect your Azure resources from attacks. Azure DDoS Protection, combined with application design best practices, provides enhanced DDoS mitigation features to defend against DDoS attacks.

Notice that [Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview) is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions while providing high availability and responsiveness. However, Traffic Manager does not provide protection against DDoS attacks.

### I suspect that my website is being hacked. What should I do?

Microsoft secures and [frequently updates the hosting environment and infrastructure](/azure/app-service/overview-patch-os-runtime). If a website was hacked or defaced, this usually indicates an exploited vulnerability that's caused by an outdated app package.

Azure App Service does not block insecure apps from running. If the website is vulnerable, you must fix the vulnerabilities in the website code, and then redeploy it to Azure App Service. 

Azure support can help you review the web app's HTTP logs and deployment history to identify when the unknown file was first accessed or whether suspicious patterns appear in the logs. We can also offer guidance about how to configure security services such as Web Application Firewall and Microsoft Defender for App Service. However, we can't take direct action because the permanent fix might involve implementing a Web Application Firewall or updating the existing codes.

You can [restore a backup](/azure/app-service/manage-backup?tabs=portal#restore-a-backup) or redeploy the site, but this is not a long-term fix if the security issue is not resolved.

### My site has been added to the blocklist. What should I do?

If the IP address is frequently blocklisted, it's important to investigate the root cause. The blockage might be caused by sending spam email messages, hosting malicious content, or other security vulnerabilities that should be resolved.

- **Inbound IP blocklisted**: To address an inbound IP blocklisting issue, request a [static inbound IP address](/azure/app-service/overview-inbound-outbound-ips#get-a-static-inbound-ip) by using an IP-based SSL to secure your domain. Alternatively, you can use Azure services such as [Azure Application Gateway](/azure/application-gateway/overview) or [App Service Environment](/azure/app-service/environment/networking) (ASE) to gain a dedicated inbound IP address.

- **Outbound IP blocklisted**: The only way to request dedicated outbound IP addresses is to use an App Service Environment. Apps that run in Azure share outbound addresses from a common pool.  
    - You can deploy your app in a different (resource group + location) to host the application in a new scale unit. [Scaling your app between pricing tiers](/azure/app-service/manage-scale-up#scale-up-your-pricing-tier) will also trigger a change in outbound IP addresses.  
    - Alternatively, use [Azure's NAT Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) to assign dedicated outbound IP addresses to your resources.  
    - For more information, see [How to fix outbound IPs for App Service using NAT Gateway](https://techcommunity.microsoft.com/blog/appsonazureblog/how-to-fix-outbound-ips-for-app-service/2320612).  

- **SMTP blocklisted**: Port 25 is mainly used for unauthenticated email delivery. Outbound connections from App Services to the public internet by using port 25 are not restricted. However, using this design could result in outbound IP addresses being flagged as spam and, therefore, blocklisted.  
    - We recommend that you use authenticated SMTP relay services to send email or implement App Service VNet Integration.  
    - Alternatively, host the App Service in an [App Service Environment (ASE)](/azure/app-service/environment/networking) to route outbound SMTP connections over a private network.  
    - For details, refer to [Troubleshoot outbound SMTP connectivity problems in Azure](/azure/virtual-network/troubleshoot-outbound-smtp-connectivity).  

### Why am I receiving warnings or alerts for my web app in security scan reports?

Security scans are typically run against a web app URL. Make sure that the tested URL resolves to the intended web app. If it resolves elsewhere, such as an application gateway, you can expect to receive inaccurate scan results.

Some scan results could be false positives even as others indicate a genuine security issue that might require a consultation with Azure support. Certain changes are within your control, such as networking or website configuration. Other changes at the platform level can be controlled only by Microsoft.

Azure support can assist you by reviewing the full scan results, confirming the results, and providing security feature options to you.
