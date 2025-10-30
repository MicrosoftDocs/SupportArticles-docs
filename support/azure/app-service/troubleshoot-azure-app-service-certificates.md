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
ms.custom: sap:auto-renewal
---
# Troubleshoot Azure App Service certificates 

Azure App Service certificates provide a convenient way to purchase, provision, and manage SSL/TLS certificates for Azure App Services. This article helps developers and admins systematically diagnose and fix issues that affect App Service certificates. See the following sections:

- [Step-by-step troubleshooting flow](#step-by-step-troubleshooting-flow): A sequence of checks and actions to resolve certificate problems, including portal and command-line steps.

- [Common issues and solutions](#common-issues-and-solutions): A list of common customer-reported problems and their solutions that are grouped by root cause.

------------------------------------------------------------------------

## Step-by-step troubleshooting flow

This section addresses areas in which App Service certificate setups can fail, including:

- [Certificate status and renewal settings](#step-1-check-certificate-status-and-renewal)

- [Domain ownership verification](#step-2-verify-domain-ownership)

- [Azure Key Vault integration and access](#step-3-verify-azure-key-vault-integration-and-access)

- [App Service certificate binding configuration](#step-4-check-app-service-certificate-binding-configuration)

- [Certificate renewal and reissue settings](#step-5-renew-or-reissue-the-certificate)

- [Solution verfication](#step-6-verify-the-solution)

Azure portal instructions are provided for each step. Azure command-line interface (CLI) guidance is provided, if applicable.

> [!NOTE]
> Make sure that you follow these steps in the given order.

### Step 1: Check certificate status and renewal 

Check the status of your App Service certificate to determine whether it's valid, expired, denied, revoked, or pending issuance.

**For Azure portal**

- Navigate to **App Service Certificates**, and select your certificate. Check the **Status** field. The value should be **Issued**, not **Expired** or **Pending Issuance**. Also note the **Expiration Date** and whether **Auto Renew** is enabled. In the portal, you can find **Auto Renew** under **Certificate Configuration** > **Auto Renew Settings**. Make sure that it's set to **On** if you expect Azure to renew the certificate automatically when the last validation occurred within the previous 13 months (395 days). Otherwise a new validation that you still own the domain is needed.

**For Azure CLI**

- You can list and show certificate details by using Azure CLI. For example, to list certificates for a specific web app (where a certificate can be imported), run the following command:

```powershell
az webapp config ssl list --resource-group <ResourceGroupName> --name <AppName>
```

To check a specific App Service certificate resource by name (if known) in a resource group:

```powershell
az resource show -g <ResourceGroupName> -n <CertificateName>
--resource-type Microsoft.CertificateRegistration/certificateOrders
```

Look for fields such as `expirationDate` or `provisioningState` in the output.

You can also retrieve the certificate's expiration date:

```powershell
az webapp config ssl show --resource-group <ResourceGroupName>
--certificate-name <CertThumbprint or Name> --query "expirationDate"
```

**What to look for**

Make sure that the certificate isn't expired. Also, check whether the renewal status is healthy (no pending domain verification or errors).

If the certificate is marked **Expired** or you see a warning such as **Renewal Failed** in the portal, the certificate wasn't renewed in time and a new certificate should be purchased. If the status is **Pending Issuance**, the certificate isn't yet fully provisioned. This condition is often true when additional verification if needed.

If **Auto Renew** is set to **Off**, and the certificate is expired, a new certificate should be created. In this case, you can delete this certificate. If **Auto Renew** is set to **On** but the certificate is still expired, this situation means that a validation requirement wasn't met on time. In this case, a new certificate should be created.

### Step 2: Verify domain ownership

Domain **ownership verification** is important because Azure doesn't issue or renew an App Service certificate until you prove that you own the domain name that's on the certificate. If a certificate has a status of **Pending Issuance**, or if a renewal doesn't finish before the expiration date, the cause is often domain verification issues.

**For Azure portal**

1. On the App Service Certificate page, go to **Certificate Configuration** > **Step 2: Verify**. Check whether **Certificate is Domain Verified** is selected. If it's not, you must complete the verification.

    - If your custom domain is already mapped to an App Service in the same subscription, select **App Service Verification**, and then select
      **Verify**. Azure automatically verifies the certificate by using the existing custom domain binding.

    - If your custom domain isn't mapped to an App Service in the same subscription, use one of the other methods in **Domain Verification**:

      - **Email Verification:** Send a verification email to the domain's administrative contact.

      - **Manual Verification:** Either add a specific DNS TXT record to
        your root domain or host a provided HTML page at a given URL. A
        DNS TXT record is the only method that includes *www* on the
        Subject Alternative Name (SAN) of the certificate.

      > [!NOTE]
      > The HTML page method is available only for
        standard certificates. It doesn't work if **HTTPS Only** is enabled on
        your site.
       
      - **Domain Verification:** This method creates a DNS .txt file if you host
        your domain by using an App Service domain.

2.  After you initiate verification, select **Refresh** until you see
    confirmation that the certificate is domain verified.

**For Azure CLI**

There isn't a direct Azure CLI command to perform domain verification. However, you can check whether a certificate order is pending:

```powershell
az resource show -g <ResourceGroupName> -n <CertificateName>
--resource-type Microsoft.CertificateRegistration/certificateOrders
--query "properties.provisioningState"
```

If the `provisioningState` value is `Pendingissuance` or something similar, domain
verification likely isn't completed. You have to use the portal or
out-of-band method to verify.

**Troubleshoot domain verification failure**

- Make sure that you add the custom domain to your App Service app for App
  Service verification. Also make sure that the DNS records (Address (A) or CNAME
  records and the required TXT record for root domains) are correct.

- If you used the TXT record method, verify that the record is at the
  correct DNS zone. The TXT record should be created on the root domain and not a subdomain.
 Use the *@* record in the DNS zone).

- If you use App Service verification, your app might be blocking the
  verification HTTP request. This condition might occur if Azure tries an HTTP GET to
  *http://yourdomain/.well-known/pki-validation/godaddy.html*. For example, a customer has a custom module on their site that generates an "HTTP 500" error and causes verification to fail. In these cases, use an alternative verification method (DNS TXT or email) to complete the process. 

- For renewals, if more than 13 months (395 days) passed since the
  last verification, you must verify the domain again. Azure keeps a
  renewed certificate in a pending state until you reverify ownership.
  If your certificate wasn't renewed because of verification issues, the issuance and renewal process will proceed after 
  you verify the domain. (You might have to trigger a manual renew if this process already
  failed. For more information, see [Step 5: Renew or reissue the
  certificate](#step-5-renew-or-reissue-the-certificate).

### Step 3: Verify Azure Key Vault integration and access

An App Service certificate is stored [as a
secret](/azure/key-vault/general/basic-concepts) in an Azure Key Vault that Azure creates or uses during certificate purchase. Problems that affect the Key Vault can prevent certificate usage or renewal.

**Common verifications for Key Vault existence and status.** 

**For Azure portal**

In the certificate's Azure portal page, in **Certificate Configuration > Step 1: Store**, verify that the certificate is correctly stored in a Key Vault (indicated by using a green checkmark). If it's not, you might have to select or create a Key Vault to store the certificate in. The Key Vault must be in the *same subscription and resource group** as the certificate. 

**For Azure CLI**
   
Use role-based access control (RBAC) for Key Vault verification with the following:

```powershell
az role assignment create --role "Key Vault Certificate User" --assignee "f3c21649-0979-4721-ac85-b0216b2cf413" --scope /subscriptions/{subscriptionid}/resourcegroups/{resource-group-name}/providers/Microsoft.KeyVault/vaults/{key-vault-name}
```

```powershell
az role assignment create --role "Key Vault Certificate User" --assignee "abfa0a7c-a6b6-4736-8310-5855508787cd" --scope /subscriptions/{subscriptionid}/resourcegroups/{resource-group-name}/providers/Microsoft.KeyVault/vaults/{key-vault-name}
```

**Access policies.** The Key Vault must contain specific access
  policies in order for App Service to be able to use the certificate. By default, when the
  certificate is created and stored, Azure adds two service principles
  that have the required permissions:

  - `Microsoft Azure Web Service (Microsoft.Azure.WebSites) -- needs
    Secret: Get; Certificate: Get permissions`

  - `Azure Certificate Registration
    (Microsoft.Azure.CertificateRegistration) -- needs Secret: Get,
    List, Delete`

**Verify the Access policies**

- Go to your Key Vault in the Azure portal (**Key Vaults** > **[Your Vault]** > **Access policies**). Verify that two entries exist for
  the previously mentioned principles that have the stated permissions. If any are missing
  (for example, if someone removed them), restore them:

  1.  Select **Add Access Policy**, select the **Key Vault Certificate
      Manager** template or manually select the principal (search for
      *Microsoft.Azure.WebSites* and
      *Microsoft.Azure.CertificateRegistration*), and then assign the
      required permissions.

  2.  Save the changes.

**Key Vault sync issues**

Azure should automatically sync certificate updates (renewals) from the
Key Vault to your App Service app bindings. If the certificate was
renewed but your web app still shows the old certificate, this condition might be caused by a
sync issue. In the **App Service Certificate** blade, use **Rekey and
Sync** > **Sync** to force an immediate sync of the latest certificate to
all App Service app instances that use it. This action can resolve cases in which the
app service doesn't pick up the renewed certificate because of a delayed
job.

> [!NOTE]
> **Rekey** is used to change the certificate's key. **Sync**
updates bindings by adding the current certificate.

**For Azure CLI**

To check Key Vault policies with Azure CLI, use:

```powershell
az keyvault show --name <YourKeyVaultName> --query
properties.accessPolicies
```

Review the output for the required service principal entries. To fix
them by using Azure CLI, run az keyvault set-policy together with the appropriate
`--spn` and permissions. (This action requires the service principal's App ID.)

> [!NOTE]
> This task is typically easier to perform by using the Azure portal.

**What to look for**

If the certificate was renewed in Key Vault but your app is still
serving an expired certificate, the issue might be caused by missing Key Vault permissions, your network access is blocked, or a sync is pending. The Azure portal might show a warning about Key Vault permissions in some cases. Refer to the certificate's **Key Vault Status** or the documentation's guidance about required policies. A missing policy can cause the app to keep using the old certificate. After you correct access issues and then sync, the app should use the new certificate.

> [!IMPORTANT]
> Don't delete or replace the Key Vault that holds your
certificate, and don't remove the lock (`AppServiceCertificateLock`) that
Azure puts on it. This lock protects the vault from deletion while a
certificate is active.

### Step 4: Check App Service certificate binding configuration

Make sure that your web app is correctly bound to the certificate and that
the SSL/TLS settings are configured correctly.

**Custom domain binding**

Open your web app in the Azure portal, and then go to **TLS/SSL Settings**.
> **Private Key Certificates (.pfx)**. Verify that your certificate
appears in the list and is bound to the correct custom domain in
**TLS/SSL bindings**. If the certificate exists but isn't bound, add a
binding:

1.  Select **Add TLS/SSL Binding**.

2.  Select your custom domain hostname (for example, *www.contoso.com*), and then select the certificate from the menu.

3.  Select **SNI SSL**, unless you specifically require IP-based SSL. Server Name Indication (SNI) is suitable for most cases and allows
    multiple certificates on the same IP. (See the next section.)

4.  Save the binding.

> If a binding exists, make sure that it uses the intended certificate (the thumbprint and name should match your App Service certificate). 

**SNI versus IP SSL**

Azure supports two types of SSL bindings: SNI and IP-based. Avoid using
IP-based SSL bindings unless it's necessary, and never configure the same
certificate on both an SNI and IP binding for the same site. Mixing SNI
and IP for different certificates on the same app can cause clients to
receive the wrong certificate. For example, if you have one
certificate on an IP-based binding, an older non-SNI client might cache
that certificate and cause SNI clients to also see the wrong certificate.
Use SNI for most scenarios. Or, if you use IP-based bindings for older client
support, use one certificate that covers all required hostnames on that
IP. 

**Multiple apps and certificate reuse**

If you host the same certificate in multiple web apps, make sure that you
don't run into the following Azure limitations:

- You can't bind the exact same certificate to multiple apps by using
  IP-based SSL on the same IP*.* This condition triggers an error message:
  **Cannot set certificate for existing VIP because another VIP already
  uses that certificate**. The solution is to use SNI SSL for additional
  apps, use a different IP for the second app, or remove the old binding
  before you add it to another app.

- By default, you can't use the certificate across different subscriptions or
  cloud services, such as if you try to use an App Service certificate
  in a different subscription's app. App
  Service certificates are tied to a single subscription's Key Vault.
  Trying to use certificates in this manner can cause such errors as *The parameter KeyVaultId &
  KeyVaultSecretName has an invalid value*. The certificate, its Key
  Vault, and the App Service that use it should reside in the same
  subscription. (If you have to migrate an App Service certificate to
  another subscription, you must contact Azure support for
  assistance.)

**For Azure CLI**

To verify bindings by using Azure CLI, run the following command:

```powershell
az webapp config hostname list --resource-group <RG\> --name
<AppName>
```

This command makes sure that your custom domain is assigned to the app. Then, run the following command:

```powershell
az webapp config ssl list --resource-group <RG\> --name <AppName>
```

This command shows which certificates are available to that app (by thumbprint
and name). Finally, run the following command:

```powershell
az webapp config ssl bind --certificate-thumbprint <Thumbprint>
--ssl-type SNI --name <AppName> --resource-group <RG\>
```

This command binds the certificate to the hostname. You must perform this step
if you use Azure CLI for binding. For example, `--hostname
<customDomain>`. Use `--ssl-type IP` for an IP-based binding if it's required (and if your App Service plan supports it).

**What to look for**

After binding, browse to your app by using the custom domain URL (for
example, *https://yourdomain*). Make sure that the site loads without
generating any certificate warnings. You can use an SSL checker or browser developer
tools to verify that the certificate's subject matches your domain and that
it's not expired. If you still see a wrong certificate or a certificate
error:

- Verify that you accessed the correct domain. A "404" error or
  default Azure certificate might appear if you use the
  *\*.azurewebsites.net* domain that has a custom domain requirement.

- Because DNS caching can direct you to an old IP, clear the DNS cache if you recently changed a record (in Windows, you can clear the DNS cache by running `ipconfig/flushdns`).

- If a wrong certificate appears in the custom domain, it might
  indicate the mixed SNI and IP bindings scenario that was previously discussed.
  Make sure that only the intended certificate is used for that domain on
  that IP address.

### Step 5: Renew or reissue the certificate 

During your troubleshooting in steps 1–4, if you discover that the
certificate is about to expire and didn't automatically renew, you must take action to renew or reissue it.

**Auto renewal versus manual renewal**

If **Auto Renew** is set to **Off**, you can quickly turn it on
through **Auto Renew Settings** in the certificate blade. However, if
the certificate is already expired, you have to create a new certificate.
After autorenewal is turned on, Azure tries to renew starting 32 days
before the expiration date. If autorenew is on but the certificate is still
pending, something prevented the renewal from occurring. For example, domain
verification. After you resolve the verification or permission
issues, do a manual renewal to trigger a fresh issuance.

**For Azure portal (manual renew)**

1.  Go to **App Service Certificates**, select the certificate, and
    select **Manual Renew**. (The option is available when the certificate is
    within its renewal period or expired).

2.  Verify the renewal.

This action initiates a new certificate order to extend the certificate's
validity by one year.

> [!IMPORTANT]
> After the portal indicates that the certificate is renewed,
select **Sync** to push the new certificate to your app hostnames
immediately. (You're either prompted to sync, or you can use the **Rekey and Sync**
blade's **Sync** option.) The new certificate automatically syncs within
24–48 hours. However, we recommend that you sync right away to avoid any downtime.

**For Azure CLI**

There isn't a single Azure CLI command to renew an App Service
certificate because renewal is handled as a new order when **Auto
Renew** is **On**. However, you can delete the expired certificate's
binding and treat it as a new certificate purchase (not recommended). Instead, we recommend you use the portal for renewing.

**Rekey (if necessary)**

If you suspect the certificate's private key was compromised, or if you want to
force issuance of a new certificate that has a new key without waiting for
expiry, use **Rekey**. In the portal, **Rekey and Sync > Rekey**
generates a new certificate. You have to verify the domain again if
13 months (395 days) passed, similar to a renewal. After the rekey
operation finishes, select **Sync** to update the binding. Rekeying is
essentially the same as an on-demand renewal by using a new key.

After you renew or rekey the certificate, verify that the new certificate's
expiration date is updated (one year out) and that your app is serving
the new certificate. Clients should no longer see an expired
certificate. 

You can also export the certificate, if it's necessary, for use in
other services. Use the **Export Certificate** option in the portal or
use `az webapp config ssl export` in Azure CLI. This action provides a Key
Vault secret link to download the Private Key Certificate (PFX)).

> [!NOTE]
> Any exported PFX is a static copy. If the certificate is
renewed later, you must export the new version again for other services.

### Step 6: Verify the solution

After you work through the previous steps, perform a final verification.

**Test the web app**

Browse to your app's URL by using the HTTPS protocol (for example, *https://yourcustomdomain.com*). Make sure that:

- The site loads without SSL errors (no browser warnings).

- The certificate presented is issued to your domain and is current
  (check certificate details in the browser).

- Old issues are resolved. For example, if you had a "404" error on the
  custom domain or a certificate mismatch, those errors should be gone now. A
  "404" error can indicate the custom domain wasn't linked (see [Step 4: Check
  App Service Certificate Binding
  Configuration](#step-4-check-app-service-certificate-binding-configuration)).
  A security warning can indicate an expired or wrong-domain
  certificate. This problem can be resolved by renewal or rebinding.

**DNS and propagation**

You might have to make changes to DNS records for various reasons, such as for domain verification or if you
repointed a domain to the app. In this case, use WhatsMyDNS or any nslookup tool to
make sure that the domain correctly resolves to the IP of your app service. Also,
flush the local DNS cache, as noted in [Step 4: Check
  App Service Certificate Binding
  Configuration](#step-4-check-app-service-certificate-binding-configuration).

**Advanced checks (optional for developers)**

Use command-line tools to inspect SSL (for example, `openssl s_client
-connect yourdomain:443 -servername yourdomain`). You can then see the
certificate chain and verify the certificate's thumbprint and
expiration. Make sure that intermediate certificates are correctly provided
by the server. (Azure App Service handles this task automatically for App
Service certificates.)

If everything looks correct, your App Service certificate is correctly
installed and configured. If problems persist, revisit the earlier steps
or consult Azure documentation and support.

## Common issues and solutions

The following sections list common problem areas (grouped by root cause)
together with their symptoms and recommended solutions. This list is based on
common support cases to help you quickly identify and fix a
specific problem.

### 1. Certificate expired or not renewed

**Symptoms**

Your website shows an **expired certificate**, such as a browser warning that indicates *certificate expired on*. Or, an App Service certificate
resource in Azure appears as **Expired**. In some cases, you might receive
an Azure notification or email message that states that a certificate is expiring soon or didn't renew.

**Possible causes**

- **Auto renewal was disabled:** The certificate wasn't set to autorenew, and nobody renewed it manually.

- **Domain verification lapsed:** The domain wasn't reverified within
  the last 13 months. This situation caused the autorenewal process to stall pending
  verification. The renewal stayed in a *Pending issuance* state, and the old certificate eventually expired.

- **Key Vault permission issue:** Azure tried to renew but couldn't
  update the Key Vault secret because the required access permissions were missing.

- **Payment or subscription issue (for purchase renewals):** Renewal can fail if both the following conditions are true:
   - The certificate is a paid App Service certificate.
   - The credit card on the subscription is invalid or the subscription type no longer supports it, such as for a student or expired offer.

**Solutions**

- **Restore or renew the certificate:** If the certificate is expired,
  create a new certificate. For certificates that are close to their expiration date,
  enable **Auto Renew** in the certificate's settings (if it was set to
  **Off**), and initiate a manual renewal through the portal. The new
  certificate extends the expiration date by one year. Sync
  the certificate to your web app (by using the portal **Sync** feature or in Azure
  CLI by running `az webapp config ssl bind`) so that the app uses the new certificate
  immediately.

- **Verify domain ownership:** If the renewal is pending domain
  verification (check the certificate status for a **Pending** value or a message about domain validation), complete the verification
  ([Step 2: Verify Domain Ownership](#step-2-verify-domain-ownership)).
  After verification, resume or re-initiate the renewal.

- **Check Auto Renew Settings:** For long-term prevention, keep **Auto
  Renew** set to **On** unless you have a reason not to. Autorenewal
  usually renews the certificate about one month before expiration. You can
  also monitor upcoming expirations by using Azure Advisor recommendations.

- **Update Key Vault access policies:** You might suspect that the renewal
  didn't propagate because of Key Vault permission issues. For example, the
  certificate was renewed in Azure (possibly visible in **App Service
  Certificates** by having a new expiration date), but your web app still served
  the old one. In this case, verify the Key Vault policies ([Step 3: Verify Azure
  Key Vault integration and access](#step-3-verify-azure-key-vault-integration-and-access)). Add the missing policies, and then **Sync** the certificate.

- **Subscription issues:** Make sure that your Azure subscription is in good
  standing. If the certificate wasn't renewed because of a subscription
  problem (such as payment or other limits), it must be resolved as appropriate. For example, update the credit card information, upgrade the
  offer, or contact support if you reach a limit. After you correct the problem, you might have to try again to renew.

We suggest that you set up Azure Monitor or Azure Advisor alerts for
certificate expiration. Azure Advisor can alert you when a certificate
is nearing expiry or needs domain verification. This helps avoid
surprises.

### 2. SSL/TLS connection issues (HTTPS errors)

**Symptoms**

Users can't reach your web app over HTTPS or they get security warnings.
Common scenarios include:

- *SSL/TLS handshake error* or the connection resets when you try to load
  the site on HTTPS.

- Browser error messages such as *Your connection isn't private* that have details that indicate a certificate name mismatch or an untrusted issuer.

- The site works on HTTP but not on HTTPS.

**Possible causes**

- **Certificate isn't bound to the site or domain:** The web app's
  custom domain has no certificate binding. Therefore, Azure isn't serving your
  certificate.

- **Incorrect domain in certificate:** The certificate might be configured for an address such as, *www.yourdomain.com*, but you're accessing *api.yourdomain.com* (not covered by the certificate). In App Service, each custom domain needs its own certificate, unless you have a wildcard certificate that covers multiple subdomains.

- **Misconfigured SSL binding type:** Using an IP-based SSL binding on a
  Basic tier (which supports only SNI), or having multiple IP-based
  bindings conflict (See [Step 4: Check App Service certificate binding
  configuration](#step-4-check-app-service-certificate-binding-configuration)).
  This situation can cause Azure to serve a default or wrong certificate.

- **Intermediate certificate missing (uncommon on App Service):** If you
  uploaded a certificate manually, and the intermediate Certificate
  Authority (CA) wasn't included, some clients might reject the chain.
  (App Service certificates from Azure include the full chain, so this problem usually occurs only on custom uploaded certificates).

- **Old clients and SNI:** Old clients, like some older browsers and devices, don't connect if they don't support SNI and you configured only SNI SSL. Conversely, if you configured only an IP-based SSL for one domain and an SNI client arrives using another hostname, it might not get the expected certificate.

**Solutions**

- **Bind the certificate to the custom domain:** In the Azure portal, go
  to your web app's TLS/SSL settings to make sure that a binding exists for
  every custom hostname that needs HTTPS. If it's necessary, add the binding by using
  the correct certificate. This method is the most common fix for *SSL not
  working* issues because the certificate was likely uploaded or imported but
  not actually attached to the site.

- **Use the correct certificate for the domain:** Verify that the
  certificate's Subject Name or SAN matches the domain that you use. For
  example, if you purchased *www.contoso.com*, this name also covers the root,
  contoso.com (and vice-versa for a standard App Service certificate),
  but it doesn't cover sub.contoso.com. Use a wildcard certificate or
  separate certificate if you have to secure additional subdomains.

- **Avoid binding conflicts:** Use **SNI SSL** bindings for multiple
  certificates on the same app service plan. If you need an IP-based SSL
  (for legacy client support), use only one. Make sure that this certificate
  covers all relevant domains. Or, consider using Azure Front Door or
  Azure Application Gateway to handle multiple certificates that need
  legacy support. Azure throws an error if you try to attach a
  certificate to an IP that's already used by another certificate on the
  same IP address. Therefore, make sure to resolve these conflicts by removing the
  old binding first or by consolidating certificates.

- **Include intermediate certificates:** When you upload custom PFX
  certificates, make sure that the PFX file contains the full certificate chain
  (most CAs provide a PFX or a bundle with the intermediate
  certificate). All App Service certificates (purchased through Azure)
  automatically include the necessary intermediate CAs.

- **Support old clients (if it's necessary):** If a subset of users or devices (usually legacy) can't connect, you might need an IP-based SSL binding so that a certificate is served even without SNI. Notice that at least a Standard tier plan is required for an IP-based SSL binding. Another approach is to use Azure Front Door or Azure Traffic Manager for a certificate because they can better handle older clients. Having both SNI and IP bindings on the same app can show the wrong certificate (see [Step 4: Check App Service certificate binding configuration](#step-4-check-app-service-certificate-binding-configuration)). Therefore, it's better to use one approach. If you have to mix bindings, make sure that the IP-based certificate is a superset of SNI bindings.

**Note:** App Service internally uses SNI for most modern clients. On your site, you might see a different certificate, such as an Azure wildcard certificate or a certificate from another site. In this case, it's likely that the request didn't include SNI. This situation is rare. It might be caused an HTTP/2 negotiation issue or a very old client. Always test your site by using a modern browser and tools such as SSL Labs Server Test to verify the configuration.

### 3. Domain verification issues

**Symptoms**

Your App Service certificate is stuck in a *Pending Issuance* state and
never becomes ready. It displays a warning message that states that domain verification is
required in the portal. After a year, the message states that a renewal is pending but not
completing.

**Possible causes**

- **DNS records aren't configured:** For new certificates, the required
  TXT record or App Service domain linkage wasn't performed. Therefore, your
  domain registrar (su\ch as GoDaddy) can't verify you own the domain.

- **Verification step missed:** After you purchase the certificate, you
  didn't verify domain ownership in the portal ([Step 2: Verify domain
  ownership](#step-2-verify-domain-ownership)). The certificate remains unusable (Key Vault secret empty) until verification is done.

- **Email verification not acted on:** If you choose email verification, the email message might go to an administrative contact who didn't select the confirmation.

- **HTML verification failed:** If you try the HTML file method (for Standard certificates) but have, for example, **HTTPS Only** turned on, the HTTP retrieval might be blocked, or your web app's routing logic might prevent access to the HTML file. (Some frameworks might not serve unknown file paths.)

- **Reverification needed for renewal:** After more than 13 months (395 days), the CA requires a fresh domain
  verification for renewal. Until you reverify, the renewal remains pending.

**Solutions**

- **Complete the verification:** Go to the certificate's **Certificate
  Configuration** in Azure, and perform the necessary action (**App Service
  Verification** if possible, or **Manual/Email**). Azure indicates when
  the certificate is **Domain Verified**. For manual DNS verification,
  Azure provides a specific TXT record. Add the record to your DNS
  provider's zone, and then retry verification. For email, make sure that the email is
  received and the link is selected. After verification, the certificate's
  Key Vault secret gets populated (**Initialize** changes to **Ready**),
  and you can then import or bind it to apps.

- **App already mapped? Use App Services to verify:** If your domain was
  already mapped to your web app before you bought the certificate (a best practice), the easiest verification method is to use **App Services** in the portal.

- **Alternative verification methods:** If one method doesn't work, try
  another. For instance, if the automated **App Services** verification fails, switch to **Manual (DNS)** verification. Then, add the TXT
  record that's provided, and refresh. DNS is reliable if the record is
  correctly placed. Use an online DNS lookup tool to make sure that the TXT record is
  visible.

- **Post-verification sync:** After a successful domain verification in a renewal scenario, go back and select **Sync** on the
  certificate. If Azure didn't automatically finish the process, initiate the renewal again. The certificate status should change from
  **Pending** to **Issued**.

Domain verification issues are resolved by completing the required
verification steps. Always make sure that your domain's DNS is correctly
configured *before* you purchase a certificate. Azure suggests
that you map the domain first for this reason. If you follow the workflow of
mapping custom a domain, buying a certificate, verifying your domain, and
then importing the certificate to the app, you're less likely to
encounter trouble.

### 4. Permission and access issues

**Symptoms**

After you complete the setup, you find that your web app can't use the certificate or a renewal didn't propagate. You might encounter errors such as *Forbidden* when the app tries to access a certificate's private key, or you notice the certificate's secret in Key Vault isn't showing a value even after verification. In some cases, an error message appears in the portal that mentions that access to the Key Vault is missing. Or, trying to export the certificate by using PowerShell fails. Or, you receive a message that states that the certificate isn't found.

**Possible causes**

- **Missing Key Vault permissions for Azure services:** The most
  frequent cause is that the Key Vault access policies for the App Service
  certificate were removed or not set correctly. If Microsoft.Azure.WebSites and Microsoft.Azure.CertificateRegistration
  don't have the required rights, your web app can't read the certificate
  secret to be able to serve it. This situation can occur if someone sets the Key Vault to
  use Azure role-based access control (Azure RBAC), and they then remove the
  policies or delete and re-create the vault without reinitializing the
  certificate.

- **User access versus system access:** If your Microsoft Entra ID tenant has
  policies (such as Conditional Access) that interfere with the back-end
  service principals' ability to access the Key Vault, this issue might block
  the sync. Typically, the service principles operate outside of those
  constraints. Make sure that Key Vault isn't using only private endpoints or a
  firewall that can block Azure services. (Azure Key Vault should allow
  trusted Azure services, if you're using that feature.)

- **App configuration (local permissions):** If your code tries to load the certificate from the local computer certificate store, and you see an *Access denied* message or something similar, you might have to adjust the app's identity or permissions to match how you export the certificate. This situation is rare. By default, the certificate that's bound to your web app is made available to the worker process. A managed identity isn't necessary if you want only to use an App Service certificate in the web app. This is true because this task is usually handled by the platform. However, if you explicitly upload a certificate that has a password, you might have to add an app setting to grant access (**WEBSITE_LOAD_CERTIFICATES** setting).

**Solutions**

- **Restore Key Vault access policies:** Make sure that
  the two service principals exist and have the correct permissions. If
  they were removed, restore them by using the portal or Azure CLI. Then, use the **Sync** function on the certificate to update the app
  bindings. Usually, this action immediately resolves issues in which an app can't get the updated certificate.

- **Reimport certificate to app:** If the certificate resource is OK but your app doesn't have it, try to reimport the certificate to the app. In the TLS/SSL settings of your web app, select **Private Key Certificates (.pfx)**, and then select **Import App Service Certificate** to link the certificate from Key Vault to app. If a Key Vault access issue exists, it might trigger a warning or cause a failure. This action is a clue about how to fix the access issue. After the fix, the import should succeed. You can then bind the certificate.

- **Check Key Vault connectivity settings:** If you enabled a Key Vault
  firewall or service endpoint, make sure that the App Service
  infrastructure can still access it. Typically, leaving the Key Vault
  accessible to Azure services (the default selection) is required for App Service
  certificates because the back end uses it.

- **Use Azure Managed Identity (advanced scenario):** If you use your own
  Key Vault references, you have to grant your web app managed identity
  access. For the built-in certificate store approach, you can rely on
  the built-in service principle, as discussed earlier.
  
  > [!NOTE]
  > This step is usually not necessary for App Service certificates.

- **Export as a last resort:** If, for some reason, the app still can't
  get the certificate, but you can verify that the certificate is in the Key
  Vault and is domain verified, manually export the certificate from the Key
  Vault. Then install it as a personal certificate on the web app. This action isn't ideal because you lose automatic sync abilities, but it can be done.
  Go to the Key Vault, find the secret for the certificate, download the
  PFX, and then use **Upload Certificate** in the web app TLS/SSL settings
  together with the PFX and a password. (The password is likely blank for the
  Azure-downloaded PFX.) You then bind that certificate. This practice essentially bypasses the App Service certificate infrastructure and
  treats it like a custom certificate. However, we recommend that you fix the access
  issue instead, if possible in order to retain the
  auto-sync benefits.

**Key Vault access issues** are usually internal. However, Azure surfaces
them in documentation and sometimes in notifications. For example, if
you see that a renewed certificate isn't taking effect, you can probably resolve the issue by adding the
missing access policy for Microsoft.Azure.WebSites and syncing. Make sure that you keep these policies intact to avoid
this issue.

### 5. Configuration and setup errors

**Symptoms**

This section provides a broad category of "user error" or unsupported
scenarios that cause certificate errors. This category includes:

- Inability to purchase or create a certificate.

- Not seeing the certificate in the web app's certificate list.

- Experiencing an error when you bind a certificate.

- Custom domain isn't working (*HTTP 404* error message) even after adding
  the certificate. This situation indicates that the domain wasn't added correctly.

- Trying something and getting a generic error message because of a
  configuration mistake.

**Common mistakes and causes**

- **Using an unsupported App Service plan:** If your app is on either
  the Free or Shared tier, custom domains support is limited and SSL
  isn't supported. You can't purchase an App Service certificate by having one of those plans, and you can't add SSL bindings. The solution is to scale
  up to at least the Basic tier because it supports SNI SSL.

- **Not mapping the custom domain prior to certificate setup:** If you
  bought a certificate without ever configuring the domain on your app, you
  have to use manual verification. Some users assume that buying the
  certificate also maps it to the domain. It doesn't. You must map the
  domain in your web app settings and configure DNS separately. Otherwise, your web app still displays the Azure
  default certificates. This step avoids that confusion.

- **Certificate and app in different subscriptions:** An App
  Service certificate can be used only within the same subscription
  because the Key Vault is in that subscription. You can't use it across
  a boundary without migrating the certificate by having support
  help.

- **Trying to delete a still-bound certificate:** If you try to
  delete a certificate resource that's still in use, Azure blocks it.
  You'll receive an error message that states that the certificate in a TLS/SSL binding. Remove the
  binding from all apps first, then delete.

- **Forgetting to set HTTPS Only:** Although missing this setting isn't a root cause of
  certificate issues, users might still use HTTP and think that the certificate isn't working if you forget to enforce HTTPS. After your SSL is working, consider enabling **HTTPS Only** in the web app's TLS/SSL settings so that all traffic is
  redirected to HTTPS. This step makes sure that users benefit from your certificate.

- **Certificate not imported into app:** Buying the certificate is Step One. Step Two is importing it into the App Service to create a private certificate entry. Step Three is binding. If you skip the import (for example, you purchased in Azure, verified the domain, but never selected **Import App Service Certificate** in your web app), then the web app can't find the certificate. This setup step is often missed. Importing associates the Key Vault secret with your web app as a resource.

- **Using wildcard or certain certificates that have limitations:** App
  Service certificates can be standard or wildcard. Both should work if
  configured. Make sure that the certificate that you try to use is supported
  for your domain scenario.

**Solutions**

- **App Service plan tier:** Always use at least the Basic tier for custom
  domains and certificates. If you try to set up on Free and the attempt
  fails, scale up and try again. (You can scale back down after testing,
  but you won't have SSL on Free).

- **Follow all steps (Buy > Store > Verify > Import > Bind):**
  Make sure that you complete each stage of the certificate lifecycle:

  1.  **Purchase or generate** the certificate (or upload if using an
      external one).

  2.  **Store** it in Key Vault. Azure does this step automatically when you
      create an App Service certificate. However, you have to specify or
      create the vault.

  3.  **Verify** the domain.

  4.  **Import** the certificate into the **App Service**. (For App
      Service certificates, use the **Import App Service Certificate**
      option. For any certificate in Key Vault, you can also use the Key
      Vault import method or upload the PFX file for external
      certificates.

  5.  **Bind** the certificate to the custom domain in your app's
      TLS/SSL settings.

Skipping any of these steps prevents the certificate from working. For
example, if you see the certificate in Azure but not in your app, it's very
likely that the import step wasn't performed.

- **Correct DNS settings for your custom domain:** Make sure that you followed the domain mapping tutorial. If your custom domain isn't correctly configured, it might not resolve to your app. For example, you miss the TXT record for an A record mapping, or use both A and CNAME incorrectly). This situation can make it seem as though the certificate doesn't work when the domain isn't reaching your app. Use either a CNAME (for subdomains) or A record plus TXT (for root domains) as required, but not both for the same name.

- **Cross-subscription usage:** You can't do that directly use the certificate in another subscription's app. You have to first export the PFX file, and then upload it to the other subscription's Key Vault or App Service. Microsoft's documentation and support can help migrate an App Service certificate resource to another subscription, if it's necessary. To avoid this complication, plan your certificate purchase in the same subscription as your app.

- **Deleting or cleaning up:** To avoid confusion when you rotate certificates, unbind and
  delete old certificates. Never delete the Key Vault
  or certificate resource before you unbind. If
  you experience an error when you delete, remove the bindings, and then try
  again.

- **HTTPS Only:** After you verify that your site works on *https://*, enable
  **HTTPS Only** (in **TLS/SSL settings** in the portal) to
  automatically redirect users. This step isn't a fix for a certificate
  issue, but it's a best practice to finalize the setup.

By addressing these configuration issues, you make sure that the environment is
set up correctly for the certificate to function. Most "it doesn't work"
cases are the result of a missed step or a misconfiguration.

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]
