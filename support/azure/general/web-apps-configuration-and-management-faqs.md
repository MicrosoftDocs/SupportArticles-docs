---
title: Configuration and management FAQs for Web Apps
description: Answers frequently asked questions about configuration and management issues for Azure App Service.
author: genlin
ms.author: genli
ms.service: cloud-services
ms.date: 03/09/2022
ms.reviewer: msangapu, toan, shrahman
---
# Configuration and management FAQs for Web Apps in Azure

This article has answers to frequently asked questions (FAQs) about configuration and management issues for the [Web Apps feature of Azure App Service](https://azure.microsoft.com/services/app-service/web/).

[!INCLUDE [support-disclaimer](../../includes/support-disclaimer.md)]

## Are there limitations I should be aware of if I want to move App Service resources?

If you plan to move App Service resources to a new resource group or subscription, there are a few limitations to be aware of. For more information, see [App Service limitations](/azure/azure-resource-manager/management/move-limitations/app-service-move-limitations).

## How do I use a custom domain name for my web app?

About how to add a custom domain name, see the detailed walk-through: [how to map a custom domain name](/azure/app-service/app-service-web-tutorial-custom-domain).

## How do I purchase a new custom domain for my web app?

To learn how to purchase and set up a custom domain for your App Service web app, see [Buy and configure a custom domain name in App Service](/azure/app-service/manage-custom-dns-buy-domain).

## How do I upload and configure an existing TLS/SSL certificate for my web app?

To learn how to upload and set up an existing custom TLS/SSL certificate, see [Add a TLS/SSL certificate to your App Service app](/azure/app-service/configure-ssl-certificate).

## How do I purchase and configure a new TLS/SSL certificate in Azure for my web app?

To learn how to purchase and set up a TLS/SSL certificate for your App Service web app, see [Add a TLS/SSL certificate to your App Service app](/azure/app-service/configure-ssl-certificate).

## How do I move Application Insights resources?

Currently, Azure Application Insights doesn't support the move operation. If your original resource group includes an Application Insights resource, you can’t move that resource. If you include the Application Insights resource when you try to move an App Service app, the entire move operation fails. However, Application Insights and the App Service plan don't need to be in the same resource group as the app for the app to function correctly.

For more information, see [App Service limitations](/azure/azure-resource-manager/management/move-limitations/app-service-move-limitations).

## Where can I find a guidance checklist and learn more about resource move operations?

[App Service limitations](/azure/azure-resource-manager/management/move-limitations/app-service-move-limitations) shows you how to move resources to either a new subscription or to a new resource group in the same subscription. You can get information about the resource move checklist, learn which services support the move operation, and learn more about App Service limitations and other articles.

## How do I set the server time zone for my web app?

To set the server time zone for your web app, follow these steps:

1. In the Azure portal, in your App Service subscription, go to the **Application settings** menu.
2. Under **App settings**, add this setting:
    - Key = WEBSITE_TIME_ZONE
    - Value = *The time zone you want*
3. Select **Save**.

For the App services that run on Windows, see the output from the Windows `tzutil /L` command. Use the value from the second line of each entry. For example: "Tonga Standard Time". Some of these values are also listed in the **Timezone** column in [Default Time Zones](/windows-hardware/manufacture/desktop/default-time-zones).

For the App services that run on Linux, set a value from the [IANA TZ database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones). For example: "America/Adak".

## Why do my continuous WebJobs sometimes fail?

By default, web apps are unloaded if they're idle for a set period of time. This lets the system conserve resources. In Basic and Standard plans, you can turn on the **Always On** setting to keep the web app loaded all the time. If your web app runs continuous WebJobs, you should turn on **Always On**, or the WebJobs might not run reliably. For more information, see [Create a continuously running WebJob](/azure/app-service/webjobs-create#CreateContinuous).

## How do I get the outbound IP address for my web app?

To get the list of outbound IP addresses for your web app, follow these steps:

1. In the Azure portal, on your web app blade, go to the **Properties** menu.
2. Search for **outbound ip addresses**.

The list of outbound IP addresses appears.

To learn how to get the outbound IP address if your website is hosted in an App Service Environment, see [Outbound network addresses](/azure/app-service/environment/app-service-app-service-environment-network-architecture-overview#outbound-network-addresses).

## How do I get a reserved or dedicated inbound IP address for my web app?

To set up a dedicated or reserved IP address for inbound calls made to your Azure app website, install and configure an IP-based TLS/SSL certificate.

To use a dedicated or reserved IP address for inbound calls, your App Service plan must be in a Basic or higher service plan.

## Can I export my App Service certificate to use outside Azure, such as for a website hosted elsewhere?

Yes, you can export them to use outside Azure. For more information, see [FAQs for App Service certificates and custom domains](https://social.msdn.microsoft.com/Forums/azure/f3e6faeb-5ed4-435a-adaa-987d5db43b80/faq-on-app-service-certificates-and-custom-domains?forum=windowsazurewebsitespreview).

## Can I export my App Service certificate to use with other Azure cloud services?

The portal provides a first-class experience for deploying an App Service certificate through Azure Key Vault to App Service apps. However, we have been receiving requests from customers to use these certificates outside the App Service platform, for example, with Azure Virtual Machines. To learn how to create a local PFX copy of your App Service certificate so you can use the certificate with other Azure resources, see [Create a local PFX copy of an App Service certificate](https://azure.github.io/AppService/2017/02/24/Creating-a-local-PFX-copy-of-App-Service-Certificate.html).

For more information, see [FAQs for App Service certificates and custom domains](https://social.msdn.microsoft.com/Forums/azure/f3e6faeb-5ed4-435a-adaa-987d5db43b80/faq-on-app-service-certificates-and-custom-domains?forum=windowsazurewebsitespreview).

## Why do I see the message "Partially Succeeded" when I try to back up my web app?

A common cause of backup failure is that some files are in use by the application. Files that are in use are locked while you perform the backup. This prevents these files from being backed up and might result in a "Partially Succeeded" status. You can potentially prevent this from occurring by excluding files from the backup process. You can choose to back up only what is needed. For more information, see [Backup just the important parts of your site with Azure web apps](https://zainrizvi.io/blog/creating-partial-backups-of-your-site-with-azure-web-apps/).

## How do I remove a header from the HTTP response?

To remove the headers from the HTTP response, update your site's web.config file. For more information, see [Remove standard server headers on your Azure websites](https://azure.microsoft.com/blog/removing-standard-server-headers-on-windows-azure-web-sites/).

## Is App Service compliant with PCI Standard 3.0 and 3.1?

Currently, the Web Apps feature of Azure App Service is in compliance with PCI Data Security Standard (DSS) version 3.0 Level 1. PCI DSS version 3.1 is on our roadmap. Planning is already underway for how adoption of the latest standard will proceed.

PCI DSS version 3.1 certification requires disabling Transport Layer Security (TLS) 1.0. Currently, disabling TLS 1.0 isn't an option for most App Service plans. However, If you use App Service Environment or are willing to migrate your workload to App Service Environment, you can get greater control of your environment. This involves disabling TLS 1.0 by contacting Azure Support. In the near future, we plan to make these settings accessible to users.

For more information, see [Microsoft Azure App Service web app compliance with PCI Standard 3.0 and 3.1](https://support.microsoft.com/help/3124528).

## How do I use the staging environment and deployment slots?

In Standard and Premium App Service plans, when you deploy your web app to App Service, you can deploy to a separate deployment slot instead of to the default production slot. Deployment slots are live web apps that have their own host names. Web app content and configuration elements can be swapped between two deployment slots, including the production slot.

For more information about using deployment slots, see [Set up a staging environment in App Service](/azure/app-service/deploy-staging-slots).

## How do I access and review WebJob logs?

To review WebJob logs, follow these steps:

1. Sign in to your **Kudu website** (`https://*yourwebsitename*.scm.azurewebsites.net`).
2. Select the WebJob.
3. Select the **Toggle Output** button.
4. To download the output file, select the **Download** link.
5. For individual runs, select **Individual Invoke**.
6. Select the **Toggle Output** button.
7. Select the download link.

## I'm trying to use Hybrid Connections with SQL Server. Why do I see the message "System.OverflowException: Arithmetic operation resulted in an overflow"?

If you use Hybrid Connections to access SQL Server, a Microsoft .NET update on May 10, 2016, might cause connections to fail. You might see this message:

> Exception: System.Data.Entity.Core.EntityException: The underlying provider failed on Open. —> System.OverflowException: Arithmetic operation resulted in an overflow. or (64 bit Web app) System.OverflowException: Array dimensions exceeded supported range, at System.Data.SqlClient.TdsParser.ConsumePreLoginHandshake

### Resolution

The exception was caused by an issue with the Hybrid Connection Manager that has since been fixed. Be sure to [update your Hybrid Connection Manager](https://go.microsoft.com/fwlink/?LinkID=841308) to resolve this issue.

## How do I add a URL rewrite rule?

To add a URL rewrite rule, create a web.config file with the relevant config entries in the **wwwroot** folder. For more information, see [Azure App Services: Understanding URL rewrite](/archive/blogs/madhurabharadwaj/azure-app-services-understanding-url-re-write).

## How do I control inbound traffic to App Service?

At the site level, you have two options for controlling inbound traffic to App Service:

- Turn on dynamic IP restrictions. To learn how to turn on dynamic IP restrictions, see [IP and domain restrictions for Azure websites](https://azure.microsoft.com/blog/ip-and-domain-restrictions-for-windows-azure-web-sites/).
- Turn on Module Security. To learn how to turn on Module Security, see [ModSecurity web application firewall on Azure websites](https://azure.microsoft.com/blog/modsecurity-for-azure-websites/).

If you use App Service Environment, you can use [Barracuda firewall](https://azure.microsoft.com/blog/configuring-barracuda-web-application-firewall-for-azure-app-service-environment/).

## How do I block ports in an App Service web app?

In the App Service shared tenant environment, it isn't possible to block specific ports because of the nature of the infrastructure. TCP ports 4020, 4022, and 4024 also might be open for Visual Studio remote debugging.

In App Service Environment, you have full control over inbound  and outbound traffic. You can use Network Security Groups to restrict or block specific ports. For more information about App Service Environment, see [Introducing App Service Environment](https://azure.microsoft.com/blog/introducing-app-service-environment/).

## How do I capture an F12 trace?

You have two options for capturing an F12 trace:

- F12 HTTP trace
- F12 console output

### F12 HTTP trace

1. In Internet Explorer, go to your website. It's important to sign in before you do the next steps. Otherwise, the F12 trace captures sensitive sign-in data.
2. Press F12.
3. Verify that the **Network** tab is selected, and then select the green **Play** button.
4. Do the steps that reproduce the issue.
5. Select the red **Stop** button.
6. Select the **Save** button (disk icon), and save the HAR file (in Internet Explorer and Microsoft Edge) *or* right-click the HAR file, and then select **Save as HAR with content** (in Chrome).

### F12 console output

1. Select the **Console** tab.
2. For each tab that contains more than zero items, select the tab (**Error**, **Warning**, or **Information**). If the tab isn't selected, the tab icon is gray or black when you move the cursor away from it.
3. Right-click in the message area of the pane, and then select **Copy all**.
4. Paste the copied text in a file, and then save the file.

To view an HAR file, you can use the [HAR viewer](http://www.softwareishard.com/har/viewer/).

## Why do I get an error when I try to connect an App Service web app to a virtual network that is connected to ExpressRoute?

If you try to connect an Azure web app to a virtual network that's connected to Azure ExpressRoute, it fails. The following message appears:

> Gateway is not a VPN gateway.

Currently, you can’t have point-to-site VPN connections to a virtual network that is connected to ExpressRoute. A point-to-site VPN and ExpressRoute can’t coexist for the same virtual network. For more information, see [ExpressRoute and site-to-site VPN connections limits and limitations](/azure/expressroute/expressroute-howto-coexist-classic#limits-and-limitations).

## How do I connect an App Service web app to a virtual network that has a static routing (policy-based) gateway?

Currently, connecting an App Service web app to a virtual network that has a static routing (policy-based) gateway isn't supported. If your target virtual network already exists, it must have point-to-site VPN enabled, with a dynamic routing gateway, before it can be connected to an app. If your gateway is set to static routing, you can’t enable a point-to-site VPN.

For more information, see [Integrate an app with an Azure virtual network](/azure/app-service/overview-vnet-integration).

## Why do I see timeouts when I try to create an App Service Environment?

Sometimes, creating an App Service Environment fails. In that case, you see the following error in the Activity logs:

```output
ResourceID: /subscriptions/{SubscriptionID}/resourceGroups/Default-Networking/providers/Microsoft.Web/hostingEnvironments/{ASEname}
Error:{"error":{"code":"ResourceDeploymentFailure","message":"The resource provision operation did not complete within the allowed timeout period."}}
```

To resolve this issue, make sure that none of the following conditions are true:

- The subnet is too small.
- The subnet isn't empty.
- ExpressRoute prevents the network connectivity requirements of an App Service Environment.
- A bad Network Security Group prevents the network connectivity requirements of an App Service Environment.
- Forced tunneling is turned on.

For more information, see [Frequent issues when deploying (creating) a new Azure App Service Environment](/archive/blogs/waws/most-frequent-issues-when-deploying-creating-a-new-azure-app-service-environment-ase).

## Why can't I delete my App Service plan?

You can't delete an App Service plan if any App Service apps are associated with the App Service plan. Before you delete an App Service plan, remove all associated App Service apps from the App Service plan.

## How do I schedule a WebJob?

You can create a scheduled WebJob by using Cron expressions:

1. Create a settings.job file.
2. In this JSON file, include a schedule property by using a Cron expression:

    ```json
    { "schedule": "{second}
    {minute} {hour} {day}
    {month} {day of the week}" }
    ```

For more information about scheduled WebJobs, see [Create a scheduled WebJob by using a Cron expression](/azure/app-service/webjobs-create#CreateScheduledCRON).

## How do I perform penetration testing for my App Service app?

To perform penetration testing, [submit a request](https://portal.msrc.microsoft.com/engage/pentest).

## How do I configure a custom domain name for an App Service web app that uses Traffic Manager?

To learn how to use a custom domain name with an App Service app that uses Azure Traffic Manager for load balancing, see [Configure a custom domain name for an Azure web app with Traffic Manager](/azure/app-service/configure-domain-traffic-manager).

## My App Service certificate is flagged for fraud. How do I resolve this issue?

This article uses the Azure Az PowerShell module, which is the recommended PowerShell module for interacting with Azure. To get started with the Az PowerShell module, see [Install Azure PowerShell](/powershell/azure/install-az-ps). To learn how to migrate to the Az PowerShell module, see [Migrate Azure PowerShell from AzureRM to Az](/powershell/azure/migrate-from-azurerm-to-az).

During the domain verification of an App Service certificate purchase, you might see the following message:

> Your certificate has been flagged for possible fraud. The request is currently under review. If the certificate does not become usable within 24 hours, contact Azure Support.

As the message indicates, this fraud verification process might take up to 24 hours to complete. During this time, you'll continue to see the message.

If your App Service certificate continues to show this message after 24 hours, please run the following PowerShell script. The script contacts the [certificate provider](https://www.godaddy.com/) directly to resolve the issue.

```powershell
Connect-AzAccount
Set-AzContext -SubscriptionId <subId>
$actionProperties = @{
    "Name"= "<Customer Email Address>"
    };
Invoke-AzResourceAction -ResourceGroupName "<App Service Certificate Resource Group Name>" -ResourceType Microsoft.CertificateRegistration/certificateOrders -ResourceName "<App Service Certificate Resource Name>" -Action resendRequestEmails -Parameters $actionProperties -ApiVersion 2015-08-01 -Force   
```

## How do authentication and authorization work in App Service?

For detailed documentation for authentication and authorization in App Service, see docs for various identify provider sign-ins:

- [Azure Active Directory](/azure/app-service/configure-authentication-provider-aad)
- [Facebook](/azure/app-service/configure-authentication-provider-facebook)
- [Google](/azure/app-service/configure-authentication-provider-google)
- [Microsoft Account](/azure/app-service/configure-authentication-provider-microsoft)
- [Twitter](/azure/app-service/configure-authentication-provider-twitter)

## How do I redirect the default *.azurewebsites.net domain to my Azure web app's custom domain?

When you create a new website by using Web Apps in Azure, a default *sitename*.azurewebsites.net domain is assigned to your site. If you add a custom host name to your site and don't want users to be able to access your default *.azurewebsites.net domain, you can redirect the default URL. To learn how to redirect all traffic from your website's default domain to your custom domain, see [Redirect the default domain to your custom domain in Azure web apps](https://zainrizvi.io/blog/block-default-azure-websites-domain/).

## How do I determine which version of .NET version is installed in App Service?

The quickest way to find the version of Microsoft .NET that's installed in App Service is by using the Kudu console. You can access the Kudu console from the portal or by using the URL of your App Service app. For detailed instructions, see [Determine the installed .NET version in App Service](/archive/blogs/waws/how-to-determine-the-installed-net-version-in-azure-app-services).

## Why isn't Autoscale working as expected?

If Azure Autoscale hasn't scaled in or scaled out the web app instance as you expected, you might be running into a scenario in which we intentionally choose not to scale to avoid an infinite loop due to "flapping." This usually happens when there isn't an adequate margin between the scale-out and scale-in thresholds. To learn how to avoid "flapping" and to read about other Autoscale best practices, see [Autoscale best practices](/azure/azure-monitor/autoscale/autoscale-best-practices#autoscale-best-practices).

## Why does Autoscale sometimes scale only partially?

Autoscale is triggered when metrics exceed preconfigured boundaries. Sometimes, you might notice that the capacity is only partially filled compared to what you expected. This might occur when the number of instances you want aren't available. In that scenario, Autoscale partially fills in with the available number of instances. Autoscale then runs the rebalance logic to get more capacity. It allocates the remaining instances. This might take a few minutes.

If you don't see the expected number of instances after a few minutes, it might be because the partial refill was enough to bring the metrics within the boundaries. Or, Autoscale might have scaled down because it reached the lower metrics boundary.

If none of these conditions apply and the problem persists, submit a support request.

## How do I turn on HTTP compression for my content?

To turn on compression both for static and dynamic content types, add the following code to the application-level web.config file:

```xml
<system.webServer>
    <urlCompression doStaticCompression="true" doDynamicCompression="true" />
</system.webServer>
```

You also can specify the specific dynamic and static MIME types that you want to compress. For more information, see our response to a forum question in [httpCompression settings on a simple Azure website](https://social.msdn.microsoft.com/Forums/azure/890b6d25-f7dd-4272-8970-da7798bcf25d/httpcompression-settings-on-a-simple-azure-website?forum=windowsazurewebsitespreview).

## How do I migrate from an on-premises environment to App Service?

To migrate sites from Windows and Linux web servers to App Service, you can use Azure App Service Migration Assistant. The migration tool creates web apps and databases in Azure as needed, and then publishes the content. For more information, see [Azure App Service Migration Assistant](https://appmigration.microsoft.com/).

## Why is my certificate issued for 11 months and not for a full year?

For all certificates issued after 9/1/2020, the maximum duration is now 397 days. Certificates issued before 9/1/2020 have a maximum validity of 825 days until they're renewed, rekeyed etc. Any certificate renewed after 9/1/2020 will be affected by this change and users may notice a shorter validity on their renewed certificates. GoDaddy has implemented a subscription service that both meets the new requirements while honoring existing customer certificates. 30 days before the newly issued certificate expires, the service automatically issues a second certificate that extends the duration to the original expiration date. App Service is working with GoDaddy to address this change and make sure that our customers receive the full duration of their certificates.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
