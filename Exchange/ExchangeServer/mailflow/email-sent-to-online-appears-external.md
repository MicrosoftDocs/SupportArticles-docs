---
title: Emails sent to Exchange Online appear external
description: After you run the Hybrid Configuration Wizard against Exchange Server 2013 or 2016, emails sent from on-premises to Exchange Online appears to be external.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Emails sent from on-premises to Exchange Online appears to be external after running HCW

_Original KB number:_ &nbsp; 4052493

## Symptoms

Consider the following scenario:

- You run the Hybrid Configuration Wizard against an Exchange Server 2016 or Exchange Server 2013 environment that includes an Edge server.
- A user sends an email message from Exchange on-premises to the Exchange Online account of another user. Both users are in your organization.

In this scenario, you notice the following issues on the receiver side:

- The message appears to be external.
- The sender doesn't resolve to a recipient in the global address list (GAL).

Additional symptoms when the issue occurs:

- There is an *Outbound to Office 365* **TLSCertificateName** attribute on the Send connector that sends messages to Microsoft 365. When the issue occurs, the attribute value isn't replicated to the Edge servers.

- When you run the `start-edgesynchronization` command from the mailbox server, the output shows the **Configuration** type as **Incomplete**. The following is a sample excerpt:

    ```console
    RunspaceId: RunspaceId
    Result: Incomplete
    Type: Configuration
    Name: userwap
    ```

- The following error is logged in the EdgeSync logs that are located in the `<ExchangeInstallation>\TransportRoles\Logs\EdgeSync` folder.

    > Date/Time.082Z,c76158dc155c4e2eab69305612c58890,689,,EdgeServerName.contoso.com,50636,SyncEngine,Low,A value in the request is invalid. [ExDirectoryException]; Inner Exception: A value in the request is invalid.
    > [DirectoryOperationException],"Failed to synchronize entry CN=Outbound to Office 365,CN=Connections,CN=Exchange Routing Group (DWBGZMFD01QNBJR),CN=Routing Groups,CN=Exchange Administrative Group (FYDIBOHF23SPDLT),CN=Administrative Groups,CN=ExchangeOrgName,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=domain,DC=com",,,

    To enable the EdgeSync logs, run the following command:

    ```powershell
    Get-EdgeSyncServiceConfig | Set-EdgeSyncServiceConfig -LogLevel high -LogEnabled $true
    ```

## Cause

This issue occurs for the following reasons:

- The cap is set to 256 for the **ms-Exch-Smtp-TLS-Certificate** attribute that is stored in the schema for ADAM on the Edge servers.
- The length of the following string from the third-party certificate is more than 256 characters:

  \<I>*Issuer*\<S>*Subject name*

    To determine the length of the string, run the following command:

    ```powershell
    ("<I>$((Get-SendConnector 'outbound to Office 365').tlscertificatename.certificateissuer)<S>$((Get-SendConnector 'outbound to Office 365').tlscertificatename.certificatesubject)").length
    ```

To resolve this issue, use one of the following methods.

## Resolution 1: Increase the cap to 1024 on the Edge server

1. Open a Windows PowerShell window by using the **Run as administrator** option.
2. Install the remote server administration toolkit by running the following command:

    ```powershell
    Add-WindowsFeature RSAT-ADDS
    ```

3. Import the Active Directory module by running the following command:

    ```powershell
    Import-Module ActiveDirectory
    ```

4. Verify the cap value for the attribute TLSCertificateName by running the following command:

    ```powershell
    Get-ADObject -Filter {name -eq "ms-Exch-Smtp-TLS-Certificate"} -SearchBase ((get-ADRootDSE -Server localhost:50389).schemaNamingContext) -Server localhost:50389 -Properties * | Select-Object rangeupper
    ```

5. Set the 1024 cap by running the following command:

    ```powershell
    Get-ADObject -Filter {name -eq "ms-Exch-Smtp-TLS-Certificate"} -SearchBase ((get-ADRootDSE -Server localhost:50389).schemaNamingContext) -Server localhost:50389 -Properties * | Set-ADObject -Replace @{rangeupper=1024}
    ```

6. On the HUB Transport or Mailbox servers, run the following command to sync the changes to the Edge server:

    ```powershell
    start-EdgeSynchronization
    ```

## Resolution 2: Configure Send connector use FQDN

Configure the Send connector not to use the **TLSCertificateName** attribute for specifying the certificate to be used during TLS negotiation. Instead, use an FQDN to select the appropriate third-party certificate based on the certificate selection procedure that is described in [Selection of Outbound Anonymous TLS Certificates](/previous-versions/office/exchange-server-2010/bb430773(v=exchg.141)).

To configure the Send connector to use the FQDN, follow these steps:

1. Make sure that the domain name that will be set as the FQDN is set as the Subject Name or Subject Alternative Name of the third-party certificate.

1. Set the Send connector to use the FQDN by running the following command. This command also clears the **TLSCertificateName** attribute.

    ```powershell
    Set-SendConnector "outbound to Office 365" -Fqdn "Domain Note in step 1 of option 2" -TlsCertificateName:$null
    ```

1. On the HUB Transport or Mailbox servers, run the following command to sync the changes to the Edge server:

    ```powershell
    start-EdgeSynchronization
    ```

## Resolution 3: Use certificate that doesn't cause the cap to be exceeded

Use a certificate that doesn't cause the cap to be exceeded. To do this, follow these steps:

1. Create a certificate in which the following string from the certificate is less than 256 characters:

   \<I>*Issuer*\<S>*SubjectName*

2. Import the certificate.
3. Associate the certificate with the respective services.
4. Run the Hybrid Configuration Wizard again to use the new certificate.
