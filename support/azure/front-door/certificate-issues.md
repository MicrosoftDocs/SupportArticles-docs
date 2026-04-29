---
title: Troubleshoot Azure Front Door Certificate Issues
description: Troubleshoot Azure Front Door certificate common issues quickly. Discover solutions for intermittent *.azureedge.net certificates and expired custom domain certificates.
author: halkazwini
ms.author: halkazwini
ms.reviewer: halkazwini
ms.date: 04/29/2026
ms.topic: 
ms.service: azure-frontdoor
---

This article describes how to troubleshoot some common issues you might encounter with certificates on Azure Front Door.

# \*.azureedge.net certificate returned from Azure Front Door intermittently

Symptom

- Requests sent to your origin through Azure Front Door sometimes get a certificate error, with a \*.azureedge.net certificate instead of the expected one.

- The failures happen in a specific geographic area.

Cause

The cause of this issue can be one of these two possibilities:

- The custom domain was just deployed, and the certificate is still propagating to all the Azure Front Door edge servers.

- One of the Azure Front Door edge servers does not have the expected certificate loaded.

Troubleshooting Steps

- The custom domain was just deployed, and the certificate is still propagating to all the Azure Front Door edge servers.

  - If you created this in the last few minutes, then please allow up to an hour for the new certificate to fully propagate.

- One of the Azure Front Door edge servers does not have the expected certificate loaded.

  - Check the deployment status for the custom domain in the Azure portal to ensure it says “Certificate state: Deployed”

  - :::image type="content" source="media/certificate-issues/image1.png" alt-text="":::

  - In a browser from an impacted user, access the site. View the certificate and confirm it’s \*.azureedge.net.

  - :::image type="content" source="media/certificate-issues/image2.png" alt-text="":::

  - Continue to load the site while capturing the traffic in the browser using your browser’s [developer tools](https://learn.microsoft.com/en-us/microsoft-edge/devtools/overview). You might have to temporarily bypass any certificate errors to load the site for troubleshooting purposes.

  - Ensure the response headers contain an x-azure-ref header to show that the request went to Azure Front Door.

  - :::image type="content" source="media/certificate-issues/image3.png" alt-text="":::

  - At this point, create a support request if the following conditions are met:

    - The custom domain has been deployed successfully for at least an hour

    - The impacted users are intermittently getting a \*.azureedge.net certificate instead of the expected custom domain certificate

    - The response from the site contains x-azure-ref headers showing that the traffic was handled by Azure Front Door.

  - Be sure to include all your gathered data in the support request, including the geographic area where users are impacted.

# The certificate returned by Azure Front Door for a custom domain is expired

Symptom

- Requests sent to your origin through Azure Front Door get an expired certificate and fail.

- The certificate on the origin is not expired.

Cause

The cause of this issue can be one of the following:

- The custom domain uses a managed certificate, but there is no CNAME delegating the custom domain to the Azure Front Door endpoint hostname.

- The custom domain uses a certificate deployed from an Azure Key Vault, but the certificate has not been rotated in the Key Vault.

Troubleshooting Steps

- The custom domain uses a managed certificate, but there is no CNAME delegating the custom domain to the Azure Front Door endpoint hostname.

  - Test DNS resolution of the custom domain using a DNS lookup tool like dig and confirm that your custom domain has no direct CNAME to the Azure Front Door endpoint:

dig contoso.fabrikam.com CNAME

; \<\<\>\> DiG 9.18.39-0ubuntu0.22.04.2-Ubuntu \<\<\>\> contoso.fabrikam.com CNAME

;; global options: +cmd

;; Got answer:

;; -\>\>HEADER\<\<- opcode: QUERY, status: NXDOMAIN, id: 55070

;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:

; EDNS: version: 0, flags:; udp: 4096

;; QUESTION SECTION:

;contoso.fabrikam.com. IN CNAME

;; AUTHORITY SECTION:

fabrikam.com. 300 IN SOA ns1-03.azure-dns.com. azuredns-hostmaster.microsoft.com. 1 3600 300 2419200 300

;; Query time: 123 msec

;; SERVER: 0.0.0.0#53(0.0.0.0) (UDP)

;; WHEN: Fri Mar 06 16:18:53 CST 2026

;; MSG SIZE rcvd: 132

- If the CNAME is missing, go to the custom domains blade in your Azure Front Door profile and select the link under DNS state:

- :::image type="content" source="media/certificate-issues/image4.png" alt-text="Screenshot that shows the DNS state link.":::

- In the pane that appears, either add the record to the linked Azure DNS zone or make a note of the required values so you can add this record manually with your DNS provider.

- To expedite creation of a new certificate, you can refresh the validation token using PowerShell:

- Update-AzFrontDoorCdnCustomDomainValidationToken -ResourceGroupName contosorg -ProfileName myAzureFrontDoor CustomDomainName contoso-fabrikam-com

- Once this command completes, update your DNS zone with the new TXT record value to validate the new certificate.

<!-- -->

- The custom domain uses a certificate deployed from an Azure Key Vault, but the certificate has not been rotated in the Key Vault.

  - One reason the certificate might not have rotated is that the version is not latest when creating the secret in the Azure Front Door profile. [See this documentation for reference.](o%09https:/learn.microsoft.com/en-us/azure/frontdoor/end-to-end-tls?pivots=front-door-standard-premium#certificate-autorotation)

    - In the portal, check the Secret for your custom domain using the Security \> Secrets blade. Then check the Version listed for the certificate:

    - :::image type="content" source="media/certificate-issues/image5.png" alt-text="":::

    - If this is not “Latest”, then create a new secret in the Azure Front Door profile using the same Key Vault certificate and select either “Latest” or the most recent specific version.

    - Then, associate the custom domain with the new secret and your certificate will be deployed within 24 hours.

  - Another reason that a certificate updated in Key Vault might not have rotated yet in Azure Front Door would be changes in Key Vault access permissions.  
      
    There are two models for Key Vault permissions. Choose the one applicable to your scenario and validate that the permissions are still present on Key Vault.

    - The legacy way to grant Azure Front Door access to your Key Vault is using the Service principal.  
        
      If you used this to initially create your custom domain and deploy the certificate, [follow this documentation](https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-configure-https-custom-domain?tabs=powershell#grant-azure-front-door-access-to-your-key-vault) to ensure that the permissions are still granted.

    - The recommended way to grant Azure Front Door access to your Key Vault is with a Managed identity.  
        
      If you initially created your custom domain using a managed identity model to grant Azure Front Door permissions to get your certificate from your Key Vault, [follow this documentation](https://learn.microsoft.com/en-us/azure/frontdoor/managed-identity#configure-key-vault-access) to ensure the Managed Identity still has access.

  - A reason why a renewed certificate that is updated in Key Vault might not have rotated yet in Azure Front Door would be mismatches between the CN (Common Name) or SAN (Subject Alternate Name) and the custom domain.

    - Just like any system that uses certificates Azure Front Door requires that the CN (or SAN, if present) matches the custom domain hostname. It’s important to understand how certificates determine which domains they are valid for. An X.509 certificate binds a public key to one or more domain names using two fields: the Common Name (CN) and the Subject Alternative Name (SAN). Historically, the CN specified the primary domain, but modern TLS clients and browsers rely on the SAN field instead.  
        
      Today, if a certificate includes a SAN extension, it becomes the authoritative source for domain validation. AFD will check whether the hostname (for example, api.contoso.com) matches any entry listed in the SAN. Only if the SAN field is absent will AFD fall back to evaluating the CN. This means that even if the CN matches the hostname, the rotation will fail if a SAN exists and does not include that hostname.  
        
      Wildcard certificates can simplify domain coverage, but they follow strict rules. A wildcard like \*.contoso.com will match api.contoso.com or www.contoso.com, but it does not match deeper subdomains such as sub.api.contoso.com, nor does it match the root domain contoso.com. Wildcards only apply to a single subdomain level, which is a common source of confusion.  
        
      Most hostname mismatch issues come down to a few common problems: the required domain is not listed in the SAN, a wildcard is being used incorrectly, or the root domain is expected to match a wildcard.

  - Another reason why a certificate updated in Key Vault would not have rotated in Azure Front Door would be the new certificate uses a different root, which is not accepted by AFD.

    - Validate that the issuing CA is not an internal CA, nor is a self-signed certificate. Further, validate that the root for the certificate is from the list of Allowed CAs <https://ccadb.my.salesforce-sites.com/microsoft/IncludedCACertificateReportForMSFT>
