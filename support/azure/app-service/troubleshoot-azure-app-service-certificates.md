---
title: Troubleshoot Azure App Service certificates 
description: Azure App Service certificates provide a convenient way to purchase, provision, and manage SSL/TLS certificates for Azure App Services. This article helps developers and IT admins systematically diagnose and fix issues with App Service certificates. 
author: JarrettRenshaw
manager: dcscontentpm
ms.topic: troubleshooting-general
ms.date: 10/10/2025
ms.author: jarrettr
ms.reviewer: v-ryanberg, v-gsitser
ms.service: azure-app-service
---
# Troubleshoot Azure App Service certificates 

Azure **App Service certificates** provide a convenient way to purchase,
provision, and manage SSL/TLS certificates for Azure App Services. This
article helps developers and IT admins systematically diagnose and fix
issues with App Service certificates. This includes:

- **A [step-by-step troubleshooting
  flow](#step-by-step-troubleshooting-flow)**: A sequence of checks and
  actions to resolve certificate problems, including portal and
  command-line steps.

- **[Common issues and solutions](#common-issues-and-solutions):** A
  list of frequent customer-reported problems grouped by root cause with
  actionable fixes.

------------------------------------------------------------------------

## Step-by-step troubleshooting flow

This addresses areas where App Service certificate setups can fail,
including:

- [**Certificate status and renewal
  settings**](#step-1-check-certificate-status-and-renewal)

- [**Domain ownership verification**](#step-2-verify-domain-ownership)

- [**Azure Key Vault integration and
  access**](#step-3-validate-azure-key-vault-integration-and-access)

- [**App Service certificate binding
  configuration**](#step-4-check-app-service-certificate-binding-configuration)

- [**Certificate renewal and reissue
  settings**](#step-5-renew-or-reissue-the-certificate)

- [**Solution validation**](#step-6-validate-the-solution)

Azure portal instructions are provided for each step. Azure Command-Line
Interface (CLI) guidance is provided when applicable.

> [!NOTE]
> Be sure to follow these steps in order.

### Step 1: Check certificate status and renewal 

Check the status of your App Service certificate and whether it's valid,
expired, denied, revoked, or pending issuance.

**For Azure portal**

- Navigate to **App Service Certificates** and select your certificate.
  Check the **Status** field. It should be **Issued**, not **Expired**
  or **Pending Issuance**. Also note the **Expiration Date** and whether
  **Auto Renew** is enabled. In the portal, you can find **Auto Renew**
  under **Certificate Configuration \> Auto Renew Settings**. Ensure
  it's set to **On** if you expect Azure to renew the certificate
  automatically if the last validation happened within 13 months (395
  days).

**For Azure CLI**

- You can list and show certificate details using Azure CLI. For
  example, to list certificates for a specific web app (where a
  certificate can be imported), use the following:

```powershell
az webapp config ssl list --resource-group <ResourceGroupName> --name <AppName>
```

To check a specific App Service certificate resource by name (if
known) in a resource group:

```powershell
az resource show -g <ResourceGroupName> -n <CertificateName>
--resource-type Microsoft.CertificateRegistration/certificateOrders
```

Look for fields like `expirationDate` or `provisioningState` in the
output.

You can also retrieve the certificate's expiration:

```powershell
az webapp config ssl show --resource-group <ResourceGroupName>
--certificate-name <CertThumbprint or Name> --query "expirationDate"
```

**What to look for**

Ensure the certificate isn't expired and check if the renewal status is
healthy (no pending domain verification or errors).

If the certificate is marked **Expired** or you see a warning (like
**Renewal Failed**) in the portal, the certificate wasn't renewed in
time and a new certificate should be purchased. If the status is
**Pending Issuance**, the certificate hasn't been fully provisioned yet
(often due to domain verification issues).

If **Auto Renew** is **Off** and the certificate is expired, a new
certificate should be created and you can delete this one. If **Auto
Renew** is **On** but the certificate is still expired, a validation
requirement wasn't met on time and a new certificate should be created.

### Step 2: Verify domain ownership

Domain **ownership verification** is important as Azure won't issue or
renew an App Service certificate until you prove you own the domain name
on the certificate. A certificate with status of **Pending Issuance** or
a renewal that fails to complete before expiration often stems from
domain verification issues.

**For Azure portal**

1. On the App Service certificate's page, go to **Certificate
    Configuration > Step 2: Verify**. Check if **Certificate is Domain
    Verified** is selected. If not, you must complete verification.

    - If your custom domain is already mapped to an App Service in the
      same subscription, choose **App Service Verification** and select
      **Verify**. Azure then automatically verifies the certificate
      using the existing custom domain binding.

    - If your custom domain isn't mapped to an App Service in the same
      subscription, use one of the other methods in **Domain
      Verification**:

      - **Email Verification:** Send a verification email to the
        domain's administrative contact.

      - **Manual Verification:** Either add a specific DNS TXT record to
        your root domain or host a provided HTML page at a given URL. A
        DNS TXT record is the only method that includes *www* on the
        Subject Alternative Name (SAN) of the certificate.
        
      > [!NOTE]
      > The HTML page method is only available only for
        standard certificates and won't work if HTTPS Only is enabled on
        your site.
       
      - **Domain Verification:** This creates a TXT file if you host
        your domain using an App Service domain.

2.  After initiating verification, select **Refresh** until you see
    confirmation that the certificate is domain verified.

**For Azure CLI**

There isn't a direct Azure CLI command to perform domain verification
but you can check if a certificate order is pending:

```powershell
az resource show -g <ResourceGroupName> -n <CertificateName>
--resource-type Microsoft.CertificateRegistration/certificateOrders
--query "properties.provisioningState"
```

If the `provisioningState` is `Pendingissuance` or something similar, domain
verification likely isn't completed. You'll need to use the portal or
out-of-band methods to verify.

**Troubleshoot domain verification failure**

- Ensure you added the custom domain to your App Service app for App
  Service verification and that the DNS records (Address (A) or CNAME
  records and the required TXT record for root domains) are correct.

- If you used the TXT record method, verify that the record is at the
  correct DNS zone (the TXT record should be created on the root domain,
  with the "@" record in the DNS zone).

- If you used App Service verification, your app might be blocking the
  verification HTTP request, like if Azure attempts an HTTP GET to
  *http://<yourdomain>/.well-known/pki-validation/godaddy.html*.For
  example, a customer has a custom module on their site that returns
  HTTP 500, causing verification to fail. In these cases, use an
  alternative verification method (DNS TXT or email) to complete the
  process.

- For renewals, if it's been more than 13 months (395 days) since the
  last verification, you must verify the domain again. Azure keeps a
  renewed certificate in a pending state until you re-verify ownership.
  If your certificate wasn't renewed due to verification issues, once
  you verify the domain, the issuance and renewal process will proceed
  (you might need to trigger a manual renew if this process has already
  failed. See [Step 5: Renew or reissue the
  certificate](#step-5-renew-or-reissue-the-certificate) for more
  details).

### Step 3: Validate Azure Key Vault integration and access

An App Service certificate is stored [as a
secret](/azure/key-vault/general/basic-concepts) in an Azure Key Vault that Azure creates or uses during certificatepurchase. Problems with the Key Vault can prevent certificate usage or
renewal.

**Common validations**

- **Key Vault existence and status.** In the certificate's Azure portal
  page, in **Certificate Configuration > Step 1: Store**, verify that
  the certificate is properly stored in a Key Vault (indicated with a
  green checkmark). If not, you may need to select or create a Key Vault
  and store the certificate. The Key Vault must be in the **same
  subscription and resource group** as the certificate.

- **Access policies.** The Key Vault must contain specific access
  policies for App Service to use the certificate. By default, when the
  certificate is created and stored, Azure adds two service principles
  with required permissions:

  - `Microsoft Azure Web Service (Microsoft.Azure.WebSites) -- needs
    Secret: Get; Certificate: Get permissions`

  - `Azure Certificate Registration
    (Microsoft.Azure.CertificateRegistration) -- needs Secret: Get,
    List, Delete`

**Verify the Access policies**

- Go to your Key Vault in the Azure portal (**Key Vaults > [Your
  Vault] > Access policies**). Confirm that two entries exist for
  the above principles with the stated permissions. If any are missing
  (for example, if someone removed them), add them back:

  1.  Select **Add Access Policy** select the **Key Vault Certificate
      Manager** template or manually choose the principal (search for
      *Microsoft.Azure.WebSites* and
      *Microsoft.Azure.CertificateRegistration*) and then assign the
      required permissions.

  2.  Save the changes.

**Key Vault sync issues**

Azure should automatically sync certificate updates (renewals) from the
Key Vault to your App Service app bindings. If the certificate was
renewed but your web app still shows the old certificate, it can be a
sync issue. In the **App Service Certificate** blade, use **Rekey and
Sync > Sync** to force an immediate sync of the latest certificate to
all App Service app instances using it. This can resolve cases where the
app service hasn't picked up the renewed certificate due to a delayed
job.

> [!NOTE]
> **Rekey** is used to change the certificate's key. **Sync**
updates bindings with the current certificate.

**For Azure CLI**

To check Key Vault policies with Azure CLI, use:

```powershell
az keyvault show --name <YourKeyVaultName> --query
properties.accessPolicies
```

Review the output for the required service principal entries. To fix
them using Azure CLI, use az keyvault set-policy with the appropriate
`--spn` and permissions (this requires the service principal's App ID).

> [!NOTE]
> Using Azure portal is usually easier for this task.

**What to look for**

If the certificate was renewed in Key Vault but your app is still
serving an expired certificate, either there are missing Key Vault
permissions or a pending sync. The Azure portal might show a warning
about Key Vault permissions in some cases. Refer to the certificate's
**Key Vault Status** or the documentation's guidance on required
policies as a missing policy can cause the app to keep using the old
certificate. Once you correct access issues and then sync, the new
certificate should be used by the app.

> [!IMPORTANT]
> Don't delete or replace the Key Vault that holds your
certificate, and don't remove the lock (`AppServiceCertificateLock`) that
Azure places on it. This lock protects the vault from deletion while a
certificate is active.

### Step 4: Check App Service certificate binding configuration

Ensure that your web app is correctly bound to the certificate and that
the SSL/TLS settings are configured properly.

**Custom domain binding**

Open your web app in the Azure portal and then go to **TLS/SSL Settings
> Private Key Certificates (.pfx)**. Verify that your certificate
appears in the list and is bound to the correct custom domain in
**TLS/SSL bindings**. If the certificate is present but not bound, add a
binding:

1.  Select **Add TLS/SSL Binding**.

2.  Select your custom domain hostname (for example, *www.contoso.com*)
    and then select the certificate from the dropdown menu.

3.  Choose **SNI SSL** unless you specifically require IP-based SSL
    (Server Name Indication (SNI) is suitable for most cases and allows
    multiple certificates on the same IP).

4.  Save the binding.

> If a binding exists, ensure it's using the intended certificate (the
> thumbprint and name should match your App Service certificate).

**SNI versus IP SSL**

Azure supports two types of SSL bindings: SNI and IP-based. Avoid using
IP-based SSL bindings unless necessary and never configure the same
certificate on both an SNI and IP binding for the same site. Mixing SNI
and IP for different certificates on the same app can lead to clients
receiving the wrong certificate. For example, if you have one
certificate on an IP-based binding, an older non-SNI client might cache
that certificate, causing SNI clients to also see the wrong certificate.
Use SNI for most scenarios, or if you use IP-based for older client
support, use one certificate that covers all required hostnames on that
IP.

**Multiple apps and certificate reuse**

If you host the same certificate in multiple web apps, ensure that you
aren't running into Azure's limitations:

- You can't bind the exact same certificate to multiple apps using
  IP-based SSL on the same IP*.* This triggers an error message:
  **Cannot set certificate for existing VIP because another VIP already
  uses that certificate**. The solution is to use SNI SSL for additional
  apps, use a different IP for the second app, or remove the old binding
  before adding it to another app.

- If you try to use the certificate across different subscriptions or
  across cloud services (like trying to use an App Service certificate
  in a different subscription's app), it won't work by default. App
  Service certificates are tied to a single subscription's Key Vault.
  Attempting this can result in errors like *The parameter KeyVaultId &
  KeyVaultSecretName has an invalid value*. The certificate, its Key
  Vault, and the App Service using it should reside in the same
  subscription. (If you need to migrate an App Service certificate to
  another subscription, you'll need to contact Azure support for
  assistance.)

**For Azure CLI**

To verify bindings with Azure CLI, use the following:

```powershell
az webapp config hostname list --resource-group <RG\> --name
<AppName>
```

This ensures your custom domain is assigned to the app. Then use:

```powershell
az webapp config ssl list --resource-group <RG\> --name <AppName>
```

This shows which certificates are available to that app (by thumbprint
and name). Finally, use:

```powershell
az webapp config ssl bind --certificate-thumbprint <Thumbprint>
--ssl-type SNI --name <AppName> --resource-group <RG\>
```

This binds the certificate to the hostname (you'll need to provide this
if you use Azure CLI for binding. For example, `--hostname
<customDomain>`). Use `--ssl-type IP` for an IP-based binding if
required (and if your App Service plan supports it).

**What to look for**

After binding, browse to your app using the custom domain URL (for
example, *https://yourdomain*). Ensure the site loads without
certificate warnings. You can use an SSL checker or browser developer
tools to confirm the certificate's subject matches your domain and that
it's not expired. If you still see a wrong certificate or a certificate
error:

- Validate that you accessed the correct domain (sometimes a 404 error or
  default Azure certificate might appear if you used the
  *\*.azurewebsites.net* domain with a custom domain requirement).

- Clear the DNS cache if you recently changed a record (on Windows, located at
  *ipconfig/flushdns*), as DNS caching can direct you to an old IP.

- If a wrong certificate shows up on the custom domain, it might
  indicate the mixed SNI/IP bindings scenario previously discussed.
  Ensure that only the intended certificate is used for that domain on
  that IP address.

### Step 5: Renew or reissue the certificate 

If during your troubleshooting in steps 1--4 you discovered that the
certificate was about to expire and not automatically renew, you need to
take action to renew or reissue it.

**Auto renewal versus manual renewal**

If **Auto Renew** is set to **Off**, you can quickly turn it on
through **Auto Renew Settings** in the certificate blade. However, if
the certificate is already expired you need to create a new certificate.
Once auto renew is turned on, Azure attempts renewal starting 32 days
before expiration. If auto renew was on but the certificate is still
pending, something prevented the renewal from happening (like domain
verification). Once you've resolved the verification or permission
issues, do a manual renewal to trigger a fresh issuance.

**For Azure portal (manual renew)**

1.  Go to **App Service Certificates**, select the certificate, and
    select **Manual Renew** (this is available when the certificate is
    within its renewal period or expired).

2.  Confirm the renewal.

This initiates a new certificate order to extend the certificate's
validity by one year.

> [!IMPORTANT]
> After the portal indicates the certificate is renewed,
select **Sync** to push the new certificate to your app hostnames
immediately. (You'll either be prompted or use the **Rekey and Sync**
blade's **Sync** option.) The new certificate automatically syncs within
24-48 hours, but we recommend you sync right away to avoid any downtime.

**For Azure CLI**

There isn't a single Azure CLI command to renew an App Service
certificate because renewal is handled as a new order when **Auto
Renew** is **On**. However, you can delete the expired certificate's
binding and treat it as a new certificate purchase (not recommended). Instead, we recommend you use the portal for renewing.

**Rekey (if needed)**

If you suspect the certificate's private key was compromised or want to
force issuance of a new certificate with a new key without waiting for
expiry, use **Rekey**. In the portal, **Rekey and Sync > Rekey**
generates a new certificate. (You'll need to verify the domain again if
13 months (395 days) have passed, similar to renewal). After the rekey
operation finishes, select **Sync** to update the binding. Rekeying is
essentially like an on-demand renewal with a new key.

After renewing (or rekeying), verify that the new certificate's
expiration date is updated (one year out) and that your app is serving
the new certificate. Clients should no longer see an expired
certificate. You can also export the certificate if needed (for use in
other services). Use the **Export Certificate** option in the portal or
use az webapp config ssl export with Azure CLI (which provides a Key
Vault secret link to download the Private Key Certificate (PFX)).

> [!NOTE]
> Any exported PFX is a static copy. If the certificate is
renewed later, you must export the new version again for other services.

### Step 6: Validate the solution

Once you've gone through the above steps, perform a final validation.

**Test the web app**

Browse to your app's URL using https (like
*https://yourcustomdomain.com*). Ensure that:

- The site loads without SSL errors (no browser warnings).

- The certificate presented is issued to your domain and is current
  (check certificate details in the browser).

- Old issues are resolved (for example, if you had a 404 error on the
  custom domain or a certificate mismatch, those should be gone now). A
  404 error can indicate the custom domain wasn't linked (see [Step 4: Check
  App Service Certificate Binding
  Configuration](#step-4-check-app-service-certificate-binding-configuration)).
  A security warning can indicate an expired or wrong-domain
  certificate, which is solved by renewal or rebinding.

**DNS and propagation**

If you made changes to DNS records (for domain verification or if you
re-pointed a domain to the app), use WhatsMyDNS or any nslookup tool to
ensure the domain properly resolves to your App Service's IP. Also,
flush the local DNS cache as noted earlier.

**Advanced checks (optional for developers)**

Use command-line tools to inspect SSL (for example, `openssl s_client
-connect yourdomain:443 -servername yourdomain`). You can then see the
certificate chain and verify the certificate's thumbprint and
expiration. Ensure that intermediate certificates are correctly provided
by the server (Azure App Service handles this automatically for App
Service certificates).

If everything looks good, your App Service certificate is correctly
installed and configured. If problems persist, revisit the earlier steps
or consult Azure documentation and support.

## Common issues and solutions

The following is a list of common problem areas (grouped by root cause)
along with their symptoms and recommended solutions. This is based on
common support cases and can help you quickly identify and fix a
specific problem.

### 1. Certificate expired or not renewed

**Symptoms**

Your website shows an **expired certificate** (like a browser warning
indicating *certificate expired on...*) or an App Service certificate
resource in Azure shows as **Expired**. In some cases, you might receive
an Azure notification or email that a certificate is expiring soon or
failed to renew.

**Possible causes**

- **Auto renewal was disabled:** The certificate wasn't set to auto
  renew, and nobody renewed it manually.

- **Domain verification lapsed:** The domain wasn't reverified within
  the last 13 months, causing the auto renewal to stall pending
  verification. The renewal stayed in a *Pending issuance* state and
  eventually the old certificate expired.

- **Key Vault permission issue:** Azure attempted to renew but couldn't
  update the Key Vault secret because required access was missing.

- **Payment or subscription issue (for purchase renewals):** If the
  certificate is a paid App Service certificate and the credit card on
  the subscription is invalid or the subscription type no longer
  supports it (like a student or expired offer), renewal can fail.

**Solutions**

- **Restore or renew the certificate:** If certificate is expired,
  create a new certificate. For certificates close to their expiration,
  enable **Auto Renew** in the certificate's settings (if it was set to
  **Off**) and initiate a manual renewal through the portal. The new
  certificate extends the expiration by one year. Don't forget to sync
  it to your web app (using the portal **Sync** feature or with Azure
  CLI: az webapp config ssl bind) so the app uses the new certificate
  immediately.

- **Verify domain ownership:** If the renewal is pending domain
  verification (check the certificate status. It might read **Pending**
  or show a message about domain validation), complete the verification
  ([Step 2: Verify Domain Ownership](#step-2-verify-domain-ownership)).
  Once verified, resume or re-initiate the renewal.

- **Check Auto Renew Settings:** For long-term prevention, keep **Auto
  Renew** turned **On** unless you have a reason not to. Auto renewal
  usually renews the certificate about a month before expiration. You can
  also monitor upcoming expirations with Azure Advisor recommendations.

- **Update Key Vault access policies:** If you suspect the renewal
  didn't propagate due to Key Vault permission issues (for example, the
  certificate was renewed in Azure (possibly visible in **App Service
  Certificates** with a new expiration) but your web app still served
  the old one), verify the Key Vault policies [(Step 3: Validate Azure
  Key Vault integration and
  access).](#step-3-validate-azure-key-vault-integration-and-access) Add
  the missing policies and then **Sync** the certificate.

- **Subscription issues:** Ensure your Azure subscription is in good
  standing. If the certificate wasn't renewed because of a subscription
  problem (like payment or other limits), it must be resolved
  accordingly (like updating the credit card information, upgrading the
  offer, or contacting support if you hit a limit). After correcting
  this, you might need to reattempt renewal.

We suggest you set up Azure Monitor or Azure Advisor alerts for
certificate expiration. Azure Advisor can alert you when a certificate
is nearing expiry or needs domain verification. This helps avoid
surprises.

### 2. SSL/TLS connection issues (HTTPS errors)

**Symptoms**

Users can't reach your web app over HTTPS or they get security warnings.
Common scenarios include:

- *SSL/TLS handshake error* or the connection resets when trying to load
  the site on HTTPS.

- Browser errors like *Your connection isn't private* with details
  indicating a certificate name mismatch or an untrusted issuer.

- The site works on HTTP but not on HTTPS.

**Possible causes**

- **Certificate isn't bound to the site or domain:** The web app's
  custom domain has no certificate binding, so Azure isn't serving your
  certificate.

- **Incorrect domain in certificate:** The certificate might be for
  something like *www.yourdomain.com* but you're accessing
  *api.yourdomain.com* (not covered by the certificate). In App Service,
  each custom domain needs its own certificate unless you have a
  wildcard certificate covering multiple subdomains.

- **Misconfigured SSL binding type:** Using an IP-based SSL binding on a
  Basic tier (which only supports SNI) or having multiple IP-based
  bindings conflict ([Step 4: Check App Service certificate binding
  configuration](#step-4-check-app-service-certificate-binding-configuration)).
  This can result in Azure serving a default or wrong certificate.

- **Intermediate certificate missing (uncommon on App Service):** If you
  uploaded a certificate manually and the intermediate Certificate
  Authority (CA) wasn't included, some clients might reject the chain.
  (App Service certificates from Azure include the full chain, so this
  usually only happens with custom uploaded certificates).

- **Old clients and SNI:** If you have clients (like some older browsers
  or devices) that don't support SNI and you only configured SNI SSL,
  these clients will fail to connect. Conversely, if you only configured
  an IP-based SSL for one domain and an SNI client comes in on another
  hostname, it might not get the expected certificate.

**Solutions**

- **Bind the certificate to the custom domain:** In the Azure portal, go
  to your web app's TLS/SSL settings and ensure a binding exists for
  every custom hostname that needs HTTPS. If not, add the binding with
  the correct certificate. This is the most common fix for *SSL not
  working* issues as the certificate was likely uploaded or imported but
  not actually attached to the site.

- **Use the correct certificate for the domain:** Verify that the
  certificate's Subject Name or SAN matches the domain you're using. For
  example, if you purchased *www.contoso.com*, it also covers the root
  contoso.com (and vice-versa for a standard App Service certificate),
  but it won't cover sub.contoso.com. Use a wildcard certificate or
  separate certificate if you need to secure additional subdomains.

- **Avoid binding conflicts:** Use **SNI SSL** bindings for multiple
  certificates on the same app service plan. If you need an IP-based SSL
  (for legacy client support), use only one and ensure that certificate
  covers all relevant domains (or consider using Azure Front Door or
  Azure Application Gateway which handles multiple certificates with
  legacy support). Azure throws an error if you try to attach a
  certificate to an IP that's already used by another certificate on the
  same IP address, so be sure to resolve these conflicts by removing the
  old binding first or consolidating certificates.

- **Include intermediate certificates:** When uploading custom PFX
  certificates, ensure the PFX file contains the full certificate chain
  (most CAs provide a PFX or a bundle with the intermediate
  certificate). All App Service certificates (purchased through Azure)
  automatically include the necessary intermediate Cas.

- **Support old clients (if needed):** If a subset of users or devices
  can't connect (usually legacy ones), you might need an IP-based SSL
  binding (which requires at least a Standard tier plan) so that a
  certificate is served even without SNI. Another approach is to use
  Azure Front Door or Azure Traffic Manager with a certificate as they
  better handle older clients. Be aware that having both SNI and IP
  bindings on the same app can show the wrong certificate ([Step 4:
  Check App Service certificate binding
  configuration](#step-4-check-app-service-certificate-binding-configuration)),
  so it's usually better to use one approach. If you have to mix, ensure
  the IP-based certificate is a superset of SNI ones.

**Note:** App Service internally uses SNI for most modern clients. If
you browse your site and see a different certificate (like an Azure
wildcard certificate or a certificate from another site), it's likely
the request didn't include SNI (for example, an HTTP/2 negotiation issue
or a very old client). This situation is usually rare. Always test your
site with a modern browser and tools like SSL Labs Server Test to
confirm configuration.

### 3. Domain verification issues

**Symptoms**

Your App Service certificate is stuck in a *Pending Issuance* state and
never becomes ready it shows a warning that domain verification is
required in the portal, or after a year, a renewal is pending but not
completing.

**Possible causes**

- **DNS records aren't configured:** For new certificates, the required
  TXT record or App Service domain linkage wasn't performed, so your
  domain registrar (like GoDaddy) can't verify you own the domain.

- **Verification step missed:** After purchasing the certificate, you
  didn't verify domain ownership in the portal ([Step 2: Verify domain
  ownership](#step-2-verify-domain-ownership)). The certificate will
  remain unusable (Key Vault secret empty) until verification is done.

- **Email verification not acted on:** If you chose email verification,
  the email might have gone to an admin contact who didn't select the
  confirmation.

- **HTML verification failed:** If you tried the HTML file method (for
  Standard certificates) but (for example)had **HTTPS Only** on, the
  HTTP retrieval might have been blocked, or your web app's routing
  logic prevented access to the HTML file (some frameworks might not
  serve unknown file paths).

- **Reverification needed for renewal:** As previously mentioned, if
  it's been over 13 months (395 days) the CA requires a fresh domain
  verification for renewal. Until you reverify, the renewal stays
  pending.

**Solutions**

- **Complete the verification:** Go to the certificate's **Certificate
  Configuration** in Azure and perform the needed action (**App Service
  Verification** if possible, or **Manual/Email**). Azure indicates when
  the certificate is **Domain Verified**. For manual DNS verification,
  Azure provides a specific TXT record to add. Add it to your DNS
  provider's zone and retry verification. For email, ensure the email is
  received and the link selected. After verification, the certificate's
  Key Vault secret gets populated (**Initialize** changes to **Ready**),
  and you can then import or bind it to apps.

- **App already mapped? Use App Services to verify:** If your domain was
  already mapped to your web app before buying the certificate (which is
  the best practice), using **App Services** in the portal for
  verification is easiest method.

- **Alternate verification methods:** If one method isn't working, try
  another. For instance, if the automated **App Services** verification
  fails switch to **Manual (DNS)** verification. You then add the TXT
  record provided and refresh. DNS is reliable if the record is
  correctly placed. Use an online DNS lookup tool to ensure the TXT is
  visible.

- **Post-verification sync:** After a successful domain verification, if
  this is a renewal scenario, go back and choose **Sync** on the
  certificate (or if Azure didn't automatically finish the process,
  initiate the renewal again). The certificate status should change from
  **Pending** to **Issued**.

Domain verification issues are resolved by completing the required
verification steps. Always ensure your domain's DNS is correctly
configured *before* purchasing a certificate (Azure usually suggests
mapping the domain first for this reason). If you follow the workflow of
mapping custom domain, buying a certificate, verifying your domain, and
then importing the certificate to the app, you're less likely to
encounter trouble.

### 4. Permission and access issues

**Symptoms**

After setting everything up, you find that your web app isn't able to
use the certificate or a renewal didn't propagate. You might encounter
errors like *Forbidden* when the app tries to access a certificate's
private key, or you notice the certificate's secret in Key Vault isn't
showing a value even after verification. In some cases, an error is
shown in the portal about not having access to the Key Vault, or an
attempt to export the certificate with PowerShell fails saying the
certificate isn't found.

**Possible causes**

- **Missing Key Vault permissions for Azure services:** The most
  frequent cause is the Key Vault access policies for the App Service
  certificate were removed or not set properly. Without
  Microsoft.Azure.WebSites and Microsoft.Azure.CertificateRegistration
  having the required rights, your web app can't read the certificate
  secret to serve it. This can happen if someone set the Key Vault to
  use Azure role-based access control (Azure RBAC) and removed the
  policies or deleted and recreated the vault without reinitializing the
  certificate.

- **User access versus system access:** If your Azure AD tenant has
  policies (like Conditional Access) that interfere with the backend
  service principals' ability to access the Key Vault, it might block
  the sync. Typically, the service principles operate outside of those
  constraints. Be sure Key Vault isn't using only private endpoints or a
  firewall that can block Azure services (Azure Key Vault should allow
  trusted Azure services if using that feature).

- **App configuration (local permissions):** In rare cases, if your code
  is trying to load the certificate from the store and you see an
  *Access denied* message or something similar, you might need to adjust
  the app's identity or permissions with how you export the certificate.
  By default, the certificate bound to your web app is made available to
  the worker process. A managed identity isn't needed only to use an App
  Service certificate in the web app (as it's usually handled by the
  platform). But if you explicitly uploaded a certificate with a
  password, you may need to add an app setting to grant access
  (**WEBSITE_LOAD_CERTIFICATES** setting).

**Solutions**

- **Restore Key Vault access policies:** As discussed earlier, ensure
  the two service principals are present with correct permissions. If
  they were removed, add them back using the portal or Azure CLI. Once
  added, use the **Sync** function on the certificate to update the app
  bindings. This often immediately resolves issues where an app couldn't
  get the updated certificate.

- **Reimport certificate to app:** If the certificate resource was fine
  but your app doesn't have it, try reimporting the certificate to the
  app. In the TLS/SSL settings of your web app, in **Private Key
  Certificates (.pfx)**, select **Import App Service Certificate** to
  link the certificate from Key Vault to the app. If a Key Vault access
  issue was present, it should warn or fail here which is a clue on how
  to fix access. After fixing this, the import should succeed. You can
  then bind the certificate.

- **Check Key Vault connectivity settings:** If you enabled a Key Vault
  firewall or service endpoint, ensure that the App Service
  infrastructure can still access it. Typically, leaving Key Vault
  accessible to Azure services (the default) is required for App Service
  certificates because the backend uses it.

- **Use Azure Managed Identity (advanced scenario):** If you use your own
  Key Vault references, you need to grant your web app managed identity
  access. For the built-in certificate store approach, you can rely on
  the built-in service principle as discussed earlier.
  
  > [!NOTE]
  > This is generally not needed for App Service certificates.

- **Export as a last resort:** If for some reason the app *still* can't
  get the certificate but you can confirm the certificate is in Key
  Vault and domain verified, manually export the certificate from Key
  Vault and install it as a personal certificate on the web app. This
  isn't ideal as you lose automatic sync abilities, but it can be done.
  Go to the Key Vault, find the secret for the certificate, download the
  PFX, then use **Upload Certificate** in the web app TLS/SSL settings
  with the PFX and a password (the password is likely blank for the
  Azure-downloaded PFX). You then bind that certificate. This
  essentially bypasses the App Service certificate infrastructure and
  treats it like a custom certificate. We recommend you fix the access
  issue instead of doing this if possible in order to retain the
  auto-sync benefits.

**Key Vault access issues** are usually internal, but Azure surfaces
them in documentation and sometimes in notifications. For example, if
you see that a renewed certificate isn't taking effect, adding the
missing access policy for Microsoft.Azure.WebSites and syncing will
likely solve the issue. Be sure to keep these policies intact to avoid
this issue.

### 5. Configuration and setup errors

**Symptoms**

This is a broad category and includes any "user error" or unsupported
scenario leading to certificate trouble. This includes:

- Inability to purchase or create a certificate.

- Not seeing the certificate in the web app's certificate list.

- Getting an error when binding a certificate.

- Custom domain not working (*HTTP 404* error message) even after adding
  the certificate (indicating the domain wasn't added correctly).

- Attempting something and getting a generic error due to a
  configuration mistake.

**Common mistakes and causes**

- **Using an unsupported App Service plan:** If your app is on either
  the Free or Shared tier, custom domains support is limited and SSL
  isn't supported. You can't purchase an App Service certificate with
  those plans and you can't add SSL bindings. The solution is to scale
  up to at least the Basic tier which supports SNI SSL.

- **Not mapping the custom domain prior to certificate setup:** If you
  bought a cert without ever configuring the domain on your app, you
  need to use manual verification. Some users assume buying the
  certificate also maps it to the domain. It doesn't. You must map the
  domain in your web app settings and configure DNS separately. Missing
  this step can cause confusion and your web app still showing Azure
  default certificates.

- **Certificate and app in different subscriptions:** As noted, an App
  Service certificate can only be used within the same subscription
  because the Key Vault is in that subscription. Trying to use it across
  a boundary won't work without migrating the certificate with support
  help.

- **Attempting to delete a still-bound certificate:** If you try to
  delete a certificate resource that's still in use, Azure blocks it.
  You'll see an error stating it's in a TLS/SSL binding. Remove the
  binding from all apps first, then delete.

- **Forgetting to set HTTPS Only:** While not a root cause of
  certificate issues per se, forgetting to enforce HTTPS means users
  might still use http:// and think the certificate isn't working. For
  completeness, after your SSL is working, consider enabling **HTTPS
  Only** in the web app's TLS/SSL settings so that all traffic is
  redirected to HTTPS. This ensures users benefit from your certificate.

- **Certificate not imported into app:** Buying the certificate is step
  one. Step two is importing it into the App Service (which creates a
  private certificate entry). Step three is binding. If you skip the
  import (for example, you purchased in Azure, verified domain, but
  never selected **Import App Service Certificate** in your web app),
  then the web app can't find the certificate. This setup step is often
  missed. Importing associates the Key Vault secret with your web app as
  a resource.

- **Using wildcard or certain certificates with limitations:** App
  Service certificates can be standard or wildcard. Both should work if
  configured. Ensure the certificate you are trying to use is supported
  for your domain scenario.

**Solutions**

- **App Service plan tier:** Always use at least Basic tier for custom
  domains and certificates. If you attempted to set up on Free and it
  failed, scale up and try again (you can scale back down after testing,
  but you won't have SSL on Free).

- **Follow all steps (Buy > Store > Verify > Import > Bind):**
  Ensure you completed each stage of the certificate lifecycle:

  1.  **Purchase or generate** the certificate (or upload if using an
      external one).

  2.  **Store** it in Key Vault (Azure does this automatically when you
      create an App Service certificate, but you have to specify or
      create the vault).

  3.  **Verify** the domain.

  4.  **Import** the certificate into the **App Service** (for App
      Service certificates, use the **Import App Service Certificate**
      option; for any certificate in Key Vault, you can also use the Key
      Vault import method or upload the PFX file for external
      certificates).

  5.  **Bind** the certificate to the custom domain in your app's
      TLS/SSL settings.

Skipping any of these results in the certificate not working. For
example, if you see the certificate in Azure but not in your app, very
likely the import step wasn't performed.

- **Correct DNS settings for your custom domain:** Ensure you followed
  the domain mapping tutorial. If your custom domain isn't properly
  configured (like missing the TXT record for an A record mapping, or
  using both A and CNAME incorrectly), the domain might not resolve to
  your app. That can make it seem like the certificate doesn't work when
  the domain isn't reaching your app. Use either a CNAME (for
  subdomains) or A record plus TXT (for root domains) as required, but
  not both for the same name.

- **Cross-subscription usage:** If you intended to use the certificate
  in another subscription's app, be aware that you can't directly do
  that. You need to export the PFX file and then upload it to the other
  subscription's Key Vault or App Service. Microsoft's documentation and
  support can assist in migrating an App Service certificate resource to
  another subscription if needed. Plan your certificate purchase in the
  same subscription as your app to avoid this complication.

- **Deleting or cleaning up:** When rotating certificates, unbind and
  delete old certificates to avoid confusion. Never delete the Key Vault
  or certificate resource before unbinding as previously mentioned. If
  you encounter an error when deleting, remove the bindings and try
  again.

- **HTTPS Only:** After confirming your site works on *https://*, enable
  **HTTPS Only** (in **TLS/SSL settings** in the portal) to
  automatically redirect users. This isn't a fix for a certificate
  issue, but it's a best practice to finalize the setup.

By addressing these configuration issues, you ensure the environment is
set up correctly for the certificate to function. Most "it doesn't work"
cases come down to a missed step or misconfiguration.
