### An App Service certificate was renewed, but the app shows the old certificate 

The App Service certificate was renewed, but the app that uses the App Service certificate is still using the old certificate. Also, you may receive a warning that the HTTPS protocol is required.

#### Cause 1: Missing access policy permissions on the key vault

The Key Vault used to store the App Service Certificate is missing access policy permissions on the key vault for Microsoft.Azure.Websites and Microsoft.Azure.CertificateRegistation. The service principals and their required permissions for Key Vault access are:

|Service Principal|Secret Permissions|Certificate Permissions|
|------|------|-----|
|Microsoft Azure App Service|Get|Get|
|Microsoft Azure CertificateRegistration|Get, List, Delete|Get, List|

#### Solution 1: Modify the access policies for the key vault

You can modify the access policies for the key vault:

1. Sign in to the Azure portal. Select the Key Vault used by your App Service Certificate. Navigate to Access policies.</li>
2. If you do not see the two Service Principals listed you will need to add them. If they are available, verify the permissions include the recommended secret and certificate permissions.</li>
3. Add a Service Principal by selecting "Create". Then select the needed permissions for Secret and Certificate permissions.</li>   
4. For the Principal, enter the value(s) given above in the search box. Then select the principal.

#### Cause 2: App service has not yet synced with the new certificate

The App Service automatically syncs your certificate within 48 hours. When you rotate or update a certificate, sometimes the application is still retrieving the old certificate and not the newly updated certificate. The reason is that the job to sync the certificate resource hasn't run yet. To resolve this problem, sync the certificate manually, which automatically updates the hostname bindings for the certificate in App Service without causing any downtime to your apps.

#### Solution 2: Force a sync for the certificate

1. Sign in to the [Azure portal](https://portal.azure.com). Select **App Service Certificates**, and then select the certificate.<
2. Select **Rekey and Sync**, and then select **Sync**. The sync takes some time to finish.
3. When the sync completes, the following notification appears: "Successfully updated all the resources with the latest certificate."
