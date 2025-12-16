---
title: Troubleshoot Custom Domain Issues in Azure App Service for Web Apps on Windows and Linux
description: This article helps developers and IT admins troubleshoot custom domain issues in Azure App Service for web apps on Windows and Linux. 
author: JarrettRenshaw
manager: dcscontentpm
ms.topic: troubleshooting-general
ms.date: 12/15/2025
ms.author: jarrettr
ms.reviewer: v-ryanberg, v-gsitser
ms.service: azure-app-service
ms.custom:  sap:Connection issues with SSL or TLS, SSL Certificates and Domains  
---
# Troubleshoot custom domain issues in Azure App Service for web apps on Windows and Linux

When you add a custom domain to an Azure App Service as a web app, misconfigurations can cause validation errors, domain name service (DNS) resolution failures, or SSL issues. This guide provides:

- A step-by-step troubleshooting flow, featuring a linear process to help you diagnose and fix custom domain problems

- Common issues and solutions, featuring a catalog of frequently reported issues together with their causes and resolutions

## Troubleshooting steps

Perform the following troubleshooting steps in the given order. This process helps clarify the issue and guides you to a solution.

### Step 1: Verify prerequisites and platform support

Make sure that the following items are established:

**App Service plan tier** - Verify that your web app isn't on the Free or Shared tier. Custom domains are supported on only Basic (B1) and higher tiers. If you're on a Free or Shared tier, scale up to at least B1 before you proceed. For more information, see [How to add custom domain for my API web app](/answers/questions/5618685/how-to-add-custom-domain-for-my-api-web-app).

**User permissions** - Make sure that you have the correct Azure role on your App Service. You have to be an Owner or Contributor on the web app subscription or resource. If you're not allowed to add a hostname (for example, the validation fails immediately or the option is greyed out), you might lack permission. Ask a subscription administrator to grant you access.

For more information, see [Troubleshoot domain and TLS/SSL certificate problems in Azure App Service](/troubleshoot/azure/app-service/connection-issues-with-ssl-or-tls/troubleshoot-domain-and-tls-ssl-certificates).

**Domain ownership** - You must own the domain name. Make sure you
have access to the DNS provider for that domain (for example, GoDaddy or
Namecheap) to create or modify DNS records. If you don't control the
DNS, you can't complete the mapping. For more information, see [Set up an existing custom domain in Azure App Service](/azure/app-service/app-service-web-tutorial-custom-domain).

**No conflicting use** - Check that the domain isn't already bound to another Azure resource. A domain can be linked to only one App Service (including Azure Static Web Apps and Azure Front Door) at a time. If you previously used this domain on another app (such as in a different subscription or a now-deleted app), remove it there first. If the old app is inaccessible, you might have to contact [Azure support](https://azure.microsoft.com/support) to release the domain from that previous association. Azure can manually unbind a *locked* domain that's still tied to a resource that you no longer control. For more information, see [Unable to Reuse My Custom Domain After Losing Access to Previous Azure Account](/answers/questions/2121811/unable-to-reuse-my-custom-domain-after-losing-acce).

**Resource locks** - Check whether a resource lock is applied to your App Service or related resources. A *ReadOnly* lock on the web app prevents you from adding new hostnames. Similarly, if you purchased the domain by having Azure as an App Service domain, make sure that no lock exists on the domain resource that might prevent updates. Remove any locks before you proceed. You can re-apply them after configuration, if it's necessary.

### Step 2: Verify DNS record configuration

Custom domain mapping requires correct DNS records. A misconfigured DNS is the primary cause of custom domain issues.

Verify the following items:

**Determine the record type** - Are you mapping a root or apex domain (such as *contoso.com*) or a subdomain (such as *www.contoso.com*)?

- For root domains, App Service requires an A record that points to the app's IP and a supporting TXT record for verification. Azure provides the IP address and a unique *asuid* (TXT verification ID) in the **Custom domains** blade when you initiate the domain addition. For more information, see [Troubleshoot domain and TLS/SSL certificate problems in Azure App Service](/troubleshoot/azure/app-service/connection-issues-with-ssl-or-tls/troubleshoot-domain-and-tls-ssl-certificates).

- For subdomains, use a Canonical Name (CNAME) record that points to the app's default Azure domain (for example, *yourapp.azurewebsites.net*). We recommend that you use a TXT record that has has the prefix "asuid" (for example, *asuid.www* as the record name). Azure also suggests this in the portal. For more information, see [Set up an existing custom domain in Azure App service](/azure/app-service/app-service-web-tutorial-custom-domain).

- Never configure both a CNAME and an A record for the same domain. This causes resolution conflicts. Choose one of the methods that are suggested here (for example, CNAME for subdomains and A record for root). For more information, see [Troubleshoot domain and TLS/SSL certificate problems in Azure App Service](/troubleshoot/azure/app-service/connection-issues-with-ssl-or-tls/troubleshoot-domain-and-tls-ssl-certificates).

**Add the Azure-provided records** - Through your domain registrar's DNS management, create the following required records:

- **A record** - Use `hostname @` for the root or the specific subdomain and `value` as the IP address of your web app. To find these values, either look in the [Azure portal](https://portal.azure.com) in **Custom domains** or run `az webapp config hostname list` in a command line interface (CLI)).

> [!NOTE]
> App Service IPs can change if you delete and re-create the site or change the region or tier. Azure prefers CNAME for subdomains. For more information, see [Set up an existing custom domain in Azure App Service](/azure/app-service/app-service-web-tutorial-custom-domain).

- **CNAME record** - Use `hostname` as the subdomain (for example, *www*) and `value` as the default domain of your app (for example, *yourapp.azurewebsites.net*). Make sure that it's the exact value that Azure provided (for exmaple, don't include ".net" in the value). For more information, see [Custom Domain on App Service not validating even after DNS entries confirmed by multiple tools](/answers/questions/2180777/custom-domain-on-app-service-not-validating-even-a).

- **TXT record** - Use `hostname` as the asuid (for the root) or *asuid.subdomain* (for subdomains) and the `value` as the *verification token* (a GUID-like string that Azure provides). This TXT record proves to Azure that you own the domain, and helps prevent others from hijacking your domain mapping. While Azure doesn't force the use
of the TXT record in every scenario, we strongly recommend that you use it for security. For more information, see [Set up an existing custom domain in Azure App Service](/azure/app-service/app-service-web-tutorial-custom-domain).

- **DNS propagation** - After you create or update DNS records, those changes can take time to propagate. if the previous Time-to-Live (TTL) was long or the DNS provider is slow, propagation can take up to 48 hours worldwide. You can monitor propagation by using such tools as Whats My DNS or DNS Checker. Make sure that all expected records appear correctly on these tools. If issues persist, make sure that you double-check for typos in the DNS entries. For more information, see [Troubleshoot domain and TLS/SSL certificate problems in Azure App Service](/troubleshoot/azure/app-service/connection-issues-with-ssl-or-tls/troubleshoot-domain-and-tls-ssl-certificates).

### Step 3: Add and verify the custom domain in Azure

After you make the DNS entries, configure the App Service to use the domain:

1.  In Azure portal, navigate to your **App Service > Custom domains** blade.

2.  Select **Add custom domain**.

3.  Enter your domain name (for example, *contoso.com* or *www.contoso.com*), and select **Validate**. Azure then checks for the DNS records.

- If validation succeeds, you'll see green checkmarks next to the hostname record and TXT record in the portal. Select **Add** to complete the mapping. Then, the domain appears in the list of custom hostnames for the app. For more information, see [Set up an existing custom domain in Azure App Service](/azure/app-service/app-service-web-tutorial-custom-domain).

- If validation fails or shows errors, it means that Azure couldn't find the required DNS records. Check the error message for common validation errors, including:
  
  - *DNS record could not be located* - The A or CNAME record isn't visible to Azure. This often means a propagation delay or a typo. Double-check the record name and value, correct any mistakes, wait a few minutes, and then try validating again. If possible, flush your local DNS cache (on Windows, run \`ipconfig /flushdns\`). You can also try a different network to make sure that you're not seeing cached results. In rare cases, the Azure validation service itself may be lagging. To resolve this issue, retry after a few minutes. For more information, see [Troubleshoot domain and TLS/SSL certificate problems in Azure App Service](/troubleshoot/azure/app-service/connection-issues-with-ssl-or-tls/troubleshoot-domain-and-tls-ssl-certificates) and [Custom Domain on App Service not validating even after DNS entries confirmed by multiple tools](/answers/questions/2180777/custom-domain-on-app-service-not-validating-even-a).

  - *Hostname not found/Invalid* - This message can indicate that no such domain in DNS exists, or there's no authoritative answer. Make sure that you typed the domain name correctly, and that the domain is active (not expired). Verify that your DNS provider is authoritative for the domain and is responding.

  - *Cannot verify domain ownership* - Azure can't verify that you own the domain. This usually means that the TXT record is missing or incorrect. Add the TXT verification record (or fix its name or value). For example, for root domains, make sure that the TXT record name is exactly *asuid.yourdomain* (often entered as `@` at registrars). For subdomains it should include the subdomain prefix (for example, *asuid.www*). After you add the value, wait a few minutes, and then select **Refresh/Validate** again. For more information, see [Set up an existing custom domain in Azure App Service](/azure/app-service/app-service-web-tutorial-custom-domain) and [Troubleshoot domain and TLS/SSL certificate problems in Azure App Service](/troubleshoot/azure/app-service/connection-issues-with-ssl-or-tls/troubleshoot-domain-and-tls-ssl-certificates).

  - *Already in use* or *Linked to another app* - This message indicates that the domain is currently assigned to a different App Service or Azure service. Azure prevents duplicate domain bindings for security. Remove the domain from the other resource first. If you don't have access to the other app (for example, if it's in another tenant or was owned by someone else), you have to open a support ticket to have Azure release the domain from that past association. (This usually involves proving domain ownership to a Microsoft Support agent, who can then free it for you to use.) For more information, see [Unable to Reuse My Custom Domain After Losing Access to Previous Azure Account](/answers/questions/2121811/unable-to-reuse-my-custom-domain-after-losing-acce).

- **Multiple attempts** - You might need to select **Validate** a few times as you correct issues. Azure portal reflects new DNS changes as they propagate. Make sure that you wait after each change to allow enough time to clear caches, as previously noted. After **Add custom domain** succeeds, the domain status in Azure usually shows as **Successfully added**.

> [!NOTE]
> If you're still stuck at validation after you check DNS and prerequisites, try the **App Service Diagnostics** tool (your App Service's **Diagnose and Solve Problems** blade > **SSL and Domains**. **Run All Certificates & Domains Checks**). Azure provides an interactive troubleshooter that can often detect common misconfigurations (such as missing records) and suggest fixes. For more information, see [Custom Domain on App Service not validating even after DNS entries confirmed by multiple tools](/answers/questions/2180777/custom-domain-on-app-service-not-validating-even-a).

:::image type="content" source="../media/troubleshoot-custom-domain-issues-azure-app-service/diagnose-and-solve-problems-view-azure-portal.png" alt-text="Diagnose and solve problems view in Azure portal." lightbox="../media/troubleshoot-custom-domain-issues-azure-app-service/diagnose-and-solve-problems-view-azure-portal.png":::

### Step 4: Test domain mapping and app response

After the custom domain is added, perform a quick test to make sure that it's correctly serving your app:

- Open a browser, and navigate to *http://*. You should see your web app content. It might initially redirect to *https* (if SSL is enforced or after the certificate is added).

  - An *Azure 404 (Web App not found)* error message suggests that the custom domain isn't recognized by Azure. The likely cause is that the domain wasn't added to the app or the DNS is misconfigured.
    Go back to [Step 2](#step-2-confirm-dns-record-configuration) and [Step 3](#step-3-add-and-validate-the-custom-domain-in-azure), and verify that the domain appears in the app's custom domains list and that DNS resolution is configured to the correct IP. For example, if you're using an A record without the required TXT record, a *404* error might occur because Azure didn't fully verify and map the domain. Make sure that the domain appears as **Active"** in Azure. If not, re-add it. Make sure to also verify that you haven't created conflicting records (CNAME versus A records) that can confuse resolution.
    For more information, see [Troubleshoot domain and TLS/SSL certificate problems in Azure App Service](/troubleshoot/azure/app-service/connection-issues-with-ssl-or-tls/troubleshoot-domain-and-tls-ssl-certificates).

  - A *DNS (domain not found)* error message indicates a DNS issue because the domain isn't resolving. Use `nslookup <yourdomain>` or an online DNS checker. If no A or CNAME record results are returned, the DNS records might not be available or propagated. Return to [Step 2](#step-2-confirm-dns-record-configuration) to fix the DNS settings (or wait longer if you recently added them).

  - A *403* or other permission error might indicate that access or IP restrictions are enabled on your app and are allowing only certain IPs or Azure Virtual Networks. If you set those restrictions intentionally, make sure that your current client IP is allowed. The Azure custom domain doesn't cause a *403* error. The error means that the app received the request but refused it because of a rule. Check the **Networking > Access Restriction** settings of the App Service. If your app is in an internal load balancer (ILB) App Service Environment (isolated) or behind a firewall, make sure that you're accessing it from a permitted network. External users won't reach an internal-only app, even if DNS is correctly configured. In these cases, consider using a VPN or Azure ExpressRoute that connects to that environment, or configure a public access point, if it's appropriate.

  - If the custom domain works over HTTP but not HTTPS, this is expected behavior until you configure SSL. By default, adding a custom domain enables it for HTTP. For HTTPS, you must bind an SSL certificate to that domain ([see Step 5](#step-5-configure-ssl-https-for-the-custom-domain)). In the meantime, an HTTPS attempt might display a browser security warning or a default *.azurewebsites.net* certificate. This certificate isn't trusted for your domain.

### Step 5: Configure SSL (HTTPS) for the custom domain

Serving your app over HTTPS is crucial. Azure App Service supports four
ways to get an SSL certificate for your custom domain using either App
Service Managed Certificates (ASMC) (free) or custom uploaded
certificates (bring your own).

**Option A: Use ASMC** - If your App Service Plan is B1 or higher,
  you can use a free managed certificate for custom domains. In the
  **Custom domains** blade, if your domain is added and shows **No binding**, select it, choose **Add binding**, and then choose **Azure Managed Certificate**. This provisions a standard certificate that covers that domain. It usually issues within a few minutes and automatically renews.

> [!NOTE]
> ASMC currently doesn't support wildcards.

**Option B: Import an App Service certificate** - To import an
  App Service certificate, [buy and configure an App Service certificate](/azure/app-service/configure-ssl-app-service-certificate?tabs=portal#buy-and-configure-an-app-service-certificate)
  and then add it to the web app. For more information, see [Import an App Service certificate](/azure/app-service/configure-ssl-certificate?tabs=apex%2Crbac%2Cazure-cli#import-an-app-service-certificate).

**Option C: Upload a certificate** - For more control (or if you need
  certificates like wildcard or Extended Validation (EV) certificates),
  you can upload a PFX certificate with its password. Go to **TLS/SSL Settings > Private Key Certificates (.pfx)** in your App Service and
  upload your certificate. Once uploaded, go to **Custom domains > Add binding** and then select the uploaded certificate and either Server
  Name Indication (SNI) or IP-based SSL. Most scenarios use SNI SSL
  which allows multiple certificates on one IP. IP-based SSL is rarely
  needed (only for older clients that don't support SNI). [IP SSL requires your app to be on Standard tier or above (Basic tier only supportsSNI)](/azure/app-service/app-service-web-tutorial-custom-domain). For more information, see [Upload a private certificate](/azure/app-service/configure-ssl-certificate?tabs=apex%2Crbac%2Cazure-cli#upload-a-private-certificate).

**Option D: Import a certificate from Key Vault** - If you use
  Key Vault to manage your certificates, you can import a PKCS12
  certificate into your App Service from Key Vault if you meet
  the [requirements](/azure/app-service/configure-ssl-certificate?tabs=apex%2Crbac%2Cazure-cli#private-certificate-requirements). For more information, see [Import a certificate from Key Vault](/azure/app-service/configure-ssl-certificate?tabs=apex%2Crbac%2Cazure-cli#import-a-certificate-from-key-vault).

After adding the SSL binding, test your site on *https://yourdomain*. It
should load without certificate warnings. In Azure portal, the custom
domain should now show a green lock icon or **Secure** status indicating
an SSL binding.

#### Troubleshoot SSL and certificate issues
Following SSL setup, you might encounter a few known issues.

**Issue**: Can't add SSL binding (conflict error). If you see an
  error like *Failed to add SSL binding. Cannot set certificate for existing VIP because another VIP already uses that certificate.*, it
  means you have another App Service using an IP-based SSL with the same
  certificate. One IP address can't be bound to two
  different certificates across apps.

**Solution**: Convert one of the apps to SNI SSL (if possible) or use
  the same certificate on both. If you're using IP-based out of
  necessity, you might need to remove the IP SSL binding from the other
  app first before binding it here. Azure generally recommends SNI SSL
  unless you absolutely require an IP-based solution. For more
  information, see \[How to add custom domain for my API web
  app\](/answers/questions/5618685/how-to-add-custom-domain-for-my-api-web-app).

**Issue**: The certificate uploaded but ins't visible or can't be selected.

**Solution**: Ensure the certificate meets the following requirements:

- It must contain a private key in PFX format.

- The password must be correct.

- The App Service and certificate must be in the same region if it's an
  App Service Certificate from Azure. After uploading, refresh the
  blade.

If it still doesn't show, there might be a permission issue with the Key Vault for App Service Certificates (covered in the next point).

**Issue**: ASMC won't create certificates.

**Solution**: Managed certificates have a prerequisite that the custom
  domain must be validated and mapped to the app first. You can't create
  the certificate before the domain is successfully added.

**Issue**: The SSL certificate renewed but the site still shows the old one. If you used an Azure App Service Certificate (a paid certificate
  stored in Azure Key Vault) and renewed it, sometimes the web app
  doesn't automatically switch to the new certificate.

**Solution**: Go to your App Service Certificate resource and select
  **Synchronize**. (You can also try rebinding the certificate in Key
  Vault). Azure also has a **Rekey and Sync** option for App Service
  Certificates that forces the renewal sync. After forcing a sync, the
  new certificate should be in use. For more information, see [How to add custom domain for my API web app](/answers/questions/5618685/how-to-add-custom-domain-for-my-api-web-app).

**Issue**: The wrong certificate is served for the custom domain. If you have
  multiple custom domains and certificates, a browser might show a
  certificate mismatch (seeing a certificate from a different domain).
  This can happen if you mixed SNI and IP-based SSL bindings on the same
  app and a client without SNI tries to access the site. 

**Solution**: Avoid using both SNI and IP bindings together. Ensure the IP binding's
  certificate is a wildcard or multi-domain certificate that covers all
  hostnames so non-SNI clients get a valid certificate. For more
  information, see [How to add custom domain for my API web app](/answers/questions/5618685/how-to-add-custom-domain-for-my-api-web-app).

### Step 6: Final checks
At this stage, your custom domain should be fully functional with HTTPS. Perform these final checks for a smooth deployment:

- Browse the site on multiple networks (to ensure DNS is globally
  available) and multiple devices. For example, mobile networks have
  their own DNS resolvers. You confirm propagation when you test this.

- If you implemented HTTPS redirect (in the app or using Azure's **HTTPS Only** setting), test that an HTTP URL correctly redirects to HTTPS.

- Use an SSL checker tool (like SSL Labs Server Test or DigiCert SSL
  Certificate Checker) on your domain to verify there are no certificate
  chain issues and that the certificate is trusted.

- In Azure portal, check the **Custom domains** blade. Each custom
  domain entry should show as **Validated** and SSL bindings should show
  the TLS/SSL type (SNI or IP) with no warning icons.

- Remove any temporary diagnostic settings. If you lowered DNS TTL for
  fast testing, you can raise it back to a normal value (to reduce DNS
  query load). If you opened any firewall temporarily for testing,
  resecure it appropriately.

## Common issues and solutions

This section lists frequently reported custom domain issues in Azure App
Service and how to resolve them.

**Issue**: Why am I unable to validate domain ownership?

**Solution**: Ensure asuid TXT or CNAME records are added on the DNS
server with the correct value and have no extra characters or space at
the end of the string.

The DNS records need to be publicly resolvable. Some DNS providers can
take up to 48 hours to propagate the changes across all servers on the
internet. You can use resources like [digwebinterface](https://digwebinterface.com) to verify DNS records are being returned
with correct values. For example, in digwebinterface:

1.  In **Hostnames or IP addresses**, add a custom domain (like
    *www.mydomain.com*) and then enter
    *asuid.www.mydomain.com*.

2.  In **Type**, select **TXT**.

3.  In **Nameservers**, select **All**.

4.  Select **Dig.**

5.  Check the value being returned and then match the value on the
    custom domains portal with **Custom Domain Verification ID**.

**Issue**: Can I add internal domains to App Service?

Internal domains that aren't resolvable over the internet can't be
validated. This means they can't be added to a multi-tenant public App
Service.

**Solution**: Add the domain to an internal App Service Environment
Azure App Service. Adding custom domains to an internal App Service
Environment App Service doesn't require validation.

**Issue**: I was able to successfully add a custom domain to one App
Service. Why can't I add the same domain to another App Service?

**Solution**: The same custom domain can't be added to
another App Service in the same stamp. A [stamp](/archive/msdn-magazine/2017/february/azure-inside-the-azure-app-service-architecture)
is a scale unit with a lot of servers running your App Services. If both
App Services are in the same stamp, Microsoft-based frontends don't know
how to route the traffic between the two apps.

To determine what stamp your App Service is in, go to Azure portal >
**Service** > **Overview** blade > **JSON View** and search for
**homeStamp**. As you have no control which App Service the stamp
deploys to, we recommend you deploy the second App Service in another
region to ensure the second App Service lands on a different stamp.

**Issue:** I previously added my domain to an App Service but it's
since been deleted. It's now resolving to a site with contents I don't
own. What should I do?

**Solution**: Delete your DNS record for your custom domain to mitigate
the problem. For more information, see [Prevent subdomain takeovers with Azure DNS alias records and Azure App Service's custom domain verification](/azure/security/fundamentals/subdomain-takeover).

**Issue**: After adding a custom domain to my App Service, Easy Auth is
no longer working. The following error appears: "Error: AADSTS50011 The
redirect URI specified in the request does not match the redirect URIs
configured for the application." What should I do?

**Solution**: This is due to the Reply URL in the Azure App Registration
being configured with the default *azurewebsites.net* uniform resource identifier (URI). To fix this, add your custom domain
as a valid redirect URI. Go to Azure portal > **App Registration** >
**Authentication** blade and update the URI to include your custom domain. For example,
[*https://www.mydomain.com/.auth/login/aad/callback*](https://www.mydomain.com/.auth/login/aad/callback).

**Issue**: When browsing to my custom domain URL site, the browser shows
"Not secure" and returns `net::ERR_CERT_COMMON_NAME_INVALID`. How do I
fix this?

This issue often arises when the intended App Service (where the correct
certificate is bound to the custom domain URL) isn't reached.

**Solution**: To verify this, use resources like [digwebinterface](https://digwebinterface.com).

For example, using digwebinterface:

1.  In **Hostnames or IP Addresses**, enter the default App Service URL
    and the custom domain URL (like *mywebapp.azurewebsites.net*
    and *www.mydomain.com*).

2.  Select **Dig** to see the returned IP address.

The returned IP address shows where the certificate needs to be updated
for the custom domain. Use Azure Front Door, Azure Application Gateway,
or Azure Content Delivery Network for this process.

**Issue**: What type of certificates can be used for custom domains on a web app?

**Solution**: You can use a free Microsoft [managed certificate](/azure/app-service/configure-ssl-certificate?tabs=apex%2crbac%2cazure-cli#create-a-free-managed-certificate)
issued by DigiCert, purchase an [App Service certificate](/azure/app-service/configure-ssl-app-service-certificate?tabs=portal) issued by GoDaddy, or upload or import a private certificate to App Service.

The certificate must meet the following requirements:

- Exportable as a password protected PFX file.

- Encrypted using triple DES format.

- Use a private key of at least 2,048 bits long that contains all
  intermediate certificates and the root certificate in the certificate
  chain.

**Issue**: I'm using a free managed certificate for my custom domain but
the certificate has expired. Why wasn't it renewed automatically?

This can be due to the existence of a DNS Certification Authority
Authorization [CAA record](https://en.wikipedia.org/wiki/DNS_Certification_Authority_Authorization) issued to your domain. The CAA record is used to control which
certificate authorities can issue certificates for your domain.

**Solution**: The CAA record can exist on root or subdomains. Use
[digwebinterface](https://digwebinterface.com/) to check.

1.  In **Hostname**, enter both the URIs.

2.  In **Type**, select **CAA**. then

3.  Select **Dig** to check the results.

4.  Ensure [digicert.com](http://digicert.com/) is allowed to issue the certificate.

The free managed certificate and apex domain certificate require the A
record to point to the web app's IP address and subdomain. Point the
CNAME to *your-app-name.azurewebsites.net* or your Azure Traffic Manager URL. If these conditions aren't met, certificate renewal is blocked.

**Issue**: I'm using an App Service certificate for my custom domain.
The certificate is about to expire. Why hasn't it been renewed yet?

Like the free managed certificate, the presence of CAA records can
prevent it from renewing.

**Solution**: Ensure that [godaddy.com](https://godaddy.com/) is
authorized to issue certificates for the domain. The App Service
certificate is stored in Key Vault, so make sure the key vault access
policies include the secret permissions for *Microsoft.Azure.WebSites*
(`GET`) and *Microsoft.Azure.CertificateRegistration* (`GET`,
`SET`, `DELETE`).

Additionally, domain ownership verification is required every 395 days
for renewal or rekeying. We recommend using a DNS TXT record for this
verification. The verification check is performed at the root of the
domain to which the certificate is issued. The domain verification token
value is generated when domain ownership needs to be verified. You can
obtain this value by going to Azure portal, > your App Service
certificate > **Certificate Configuration** and then performing [Step 2](#step-2-confirm-dns-record-configuration).
The determined value must be entered on the DNS server root domain for the TXT record.

**Issue**: The custom domain doesn't resolve (DNS not found errors).

Visiting the domain leads to "server not found" or similar DNS errors.
This happens when DNS records aren't configured or not propagated.
Either the A or CNAME record is missing or you're checking too soon.

**Solution**: Create the required DNS records (A for root with TXT, or
CNAME for subdomain) as described in [Step 3](#step-3-add-and-validate-the-custom-domain-in-azure) and wait for propagation.
Use global DNS check tools to confirm the records exist. If these
records are in place, ensure you used the correct Azure domain as target
(for example, *yourapp.azurewebsites.net*) and that the domain is
spelled correctly. Verify you didn't create conflicting records (like
having both an A and CNAME for the same name). Once the DNS is correct,
Azure validation and resolution will succeed. For more information, see [Troubleshoot domain and TLS/SSL certificate problems in Azure App Service](/troubleshoot/azure/app-service/connection-issues-with-ssl-or-tls/troubleshoot-domain-and-tls-ssl-certificates).

**Issue**: I'm getting the "Web app not found (HTTP 404 on custom
domain)" error.

DNS is behaving as expected (the domain resolves), but browsing to
*http://custom-domain* shows an Azure 404 page. This indicates the
custom hostname isn't linked to the App Service configuration and Azure
can't determine which app should answer that domain. The domain isn't
successfully added to the app or the DNS is pointing to Azure but the
app doesn't have that hostname in its bindings.

**Solution**: Go to Azure portal and add the custom domain to your app
if it's not already there ([Step 3](#step-3-add-and-validate-the-custom-domain-in-azure)). If it's listed but you still get
a 404 error, you might have added an A record without the TXT record or
vice versa. Ensure both required records are present. Be sure to clear
your browser cache and DNS cache. For more information, see [Troubleshoot domain and TLS/SSL certificate problems in Azure App Service](/troubleshoot/azure/app-service/connection-issues-with-ssl-or-tls/troubleshoot-domain-and-tls-ssl-certificates).

**Issue**: I can't add a custom domain (the portal says not authorized
or fails immediately).

You attempt to add the domain in Azure and get an error like "Failed
to add hostname", a message about not having permissions, or the
**Add custom domain** button is disabled. This usually indicates
insufficient permissions or plan limits. If you're on a Free or Shared
plan, custom domains are disabled entirely. If you're on different plan,
then it's likely your Azure account role doesn't permit this action.
Only certain roles (like Owner, Contributor, and Website Contributor)
can modify app hostnames.

**Solution**: Upgrade the App Service Plan as needed. If it's a
permission issue, have an admin assign you a Contributor role on the App
Service. You can verify this by trying it using Azure CLI or PowerShell
with your credentials. If that fails with an "Unauthorized" error, it's
a permission issue.

> [!NOTE]
> If you're using an ILB App Service Environment or restricted
> network, custom domains must be added using Azure Rights Management
> (Azure ARM) or Azure CLI For more information, see [How to add custom domain for my API web app](/answers/questions/5618685/how-to-add-custom-domain-for-my-api-web-app).

**Issue**: The domain is already in use by another resource.

Azure returns an error like "The custom domain is already assigned to
a different app" or it fails validation with a mention of duplication.
This happens when the domain was previously mapped to another App
Service or Azure service and that mapping wasn't removed. Azure prevents
reusing it to avoid domain takeover. For example, a colleague mapped the
domain to a test app, you had it in another subscription and forgot to
remove it, or (in the case of a migrated DNS) it's still lingering in an
orphaned resource.

**Solution**: Identify where it's in use. Check other apps in your
subscriptions first. If you find it, remove the custom domain from that
app. If you can't find it (for example, it's in a subscription you no
longer have access to, or is on a now-deleted app), you'll need to open
an Azure support ticket to release the domain. You'll need to provide
proof of domain ownership to support (like a screenshot of your domain
registrar settings) and they can then manually clear it. Once that's
done, you can add it to your app successfully. For more information, see [Unable to Reuse My Custom Domain After Losing Access to Previous Azure Account](/answers/questions/2121811/unable-to-reuse-my-custom-domain-after-losing-acce).

**Issue**: Encountering SSL certificate issues.

You experience various "Not secure" warnings in browser, can't upload or
bind a certificate, or have certificate mismatches. The following is a
list of issues and solutions.

- **Issue**: "Not secure" warning. This indicates there's no proper
  certificate installed for the domain.
  
  **Solution**: Ensure you completed Step 5 (specifically adding a
  binding with either a managed or custom SSL). If a certificate is
  bound but still not recognized, check that the binding was to the
  correct hostname (for example, *www* and root variant need separate
  certificates unless there's a wildcard used for both). You can also
  try using an incognito browser or another device to rule out caching.

- **Issue**: Upload errors.
  
  **Solution**: If uploading a PFX file, make sure it's
  password-protected and in `PKCS#12` format. Azure rejects
  certificates in other formats (like Privacy-Enhanced Mail (PEM)).
  Convert as needed using tools like OpenSSL before uploading.

- **Issue**: Binding errors.
  
  **Solution**: Resolve them by avoiding duplicate IP-based bindings. If
  you encounter "hostname conflicts with an existing binding" messages,
  it might mean you're trying to bind the same hostname twice (for
  example, it may already be bound with another certificate). Remove old
  bindings and then try again. For more information, see [How to add custom domain for my API web app](/answers/questions/5618685/how-to-add-custom-domain-for-my-api-web-app).

- **Issue**: Hostname isn't allowed. If you're using the free **ASMC**, it doesn't issue certificates for wildcards or certain domain types. 
  
  **Solution**: Use a custom certificate from a
  certificate authority. Azure doesn't allow certificates that aren't
  trusted (like self-signed certificates) to be bound to public apps. Be
  sure to use a trusted certificate authority.

- **Issue**: Old certificate is still showing.
  
  **Solution**: If you updated the certificate through renewal and the site
  hasn't recognized it, if it's an App Service Certificate use the Sync
  function. If it's a third-party certificate, try unbinding and
  rebinding the new certificate in Azure portal. Ensure that no client
  or browser caching is contributing. For more information, see [How to add custom domain for my API web app](/answers/questions/5618685/how-to-add-custom-domain-for-my-api-web-app).

**Issue**: The DNS record exists but Azure can't locate it (Time-to-Live
(TTL) issues).

You added the DNS records and can query them successfully, but Azure
validation still fails saying it can't find the record. This can be due
to DNS TTL and how the Azure validation service queries DNS. If the
authoritative name servers haven't updated or the Azure resolver
received a cached negative response, it might not locate the update.

**Solution**: Wait and retry later, especially if your previous DNS
entries had high TTL. You can also try toggling the record (removing and
re-adding it) to possibly trigger fresh propagation. In the interim,
verify from other global locations that the record is visible. This
usually clears up within 1-2 hours.

**Issue**: Too many hostnames or subdomain limit reached.

Attempting to add more custom hostnames to an app fails or you are
limit-capped. A multi-tenant n App Service might limit the number of
custom domains (hostnames) you can assign. This limit is usually around
100 hostnames for external DNS and higher (up to 500 with a hard
platform limit of 500 per app) when using Azure DNS zone integration.

**Solution**: If you need a large number of subdomains, consider
migrating your domain's DNS to Azure DNS which supports up to 500
hostnames on a single App Service. 500 is the maximum for hostnames. You
might need to architect a different solution (like using wildcard
certificates on a single wildcard binding or deploying another app).
Always remove any hostnames that you no longer use to free slots. In one
tenant, the sum of custom hostnames should also not exceed certain
thresholds (though 500 per app is usually the limit). For more
information, see [Troubleshoot domain and TLS/SSL certificate problems in Azure App Service](/troubleshoot/azure/app-service/connection-issues-with-ssl-or-tls/troubleshoot-domain-and-tls-ssl-certificates).

**Issue**: The custom domain works but the site isn't reachable
externally.

After setup, you find that only certain networks can reach the site. For
example, it works for internal networks, but external users can't reach
the site, or vice versa. This indicates a network configuration issue.
For example, if the App Service is in an Azure Virtual Network with a
private endpoint and you set up a custom domain, public DNS might
resolve to a private IP that isn't accessible outside your network.
Also, if you're using an App Service environment (like ILB ASE), the
domain might be intended for internal use only.

**Solution**: Verify the IP where your custom domain is resolving. If
it's a private address, then external users can't reach it by design. In
such cases, either expose it using a public IP or proxy or ensure
clients are within the network (like with a VPN). If this isn't
intentional, you might have configured a private endpoint. Consider
removing it for a purely public web app. If you expected internal-only
access and see external exposure, make sure you haven't used a public
DNS for an internal app. Internal apps should use DNS entries that only
resolve internally (like using Azure Private DNS). Be sure to match your
DNS configuration to your network setup.
