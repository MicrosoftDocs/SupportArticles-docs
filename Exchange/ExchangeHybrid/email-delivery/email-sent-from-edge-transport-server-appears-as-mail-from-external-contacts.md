---
title: Email appears as mail from external contacts
description: Describes an issue in which email messages that are sent from on-premises Exchange 2013 Edge server to Exchange Online are displayed as external email messages instead of internal email messages. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: rrajan, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Email from Exchange 2013 Edge Transport server to Exchange Online appears as mail from external contacts

_Original KB number:_ &nbsp; 3212872

## Symptoms

In your Microsoft Exchange hybrid deployment, email messages that are sent from an on-premises Microsoft Exchange Server 2013 Edge Transport server to Exchange Online are displayed as email messages from external contacts instead of an email messages from within your organization. When you view the senders in the email messages, their organizational information isn't displayed. Instead, they appear as contacts who are outside your organization.

If you check the message header of an email message that was sent from the on-premises environment to Exchange Online, you see the following header, which indicates the Edge Transport server on which the cross-premises headers are filtered:

X-CrossPremisesHeadersFilteredBySendConnector

## Cause

The problem occurs if the `CloudServicesMailEnabled` parameter on the Send connector is set to **False**.

## Resolution

To resolve this problem, follow these steps:

1. Make sure that edge synchronization is set up between Edge Transport servers and internal transport servers.
2. Make sure that a third-party certificate is installed on Edge Transport servers, and that the SMTP service is enabled on the certificate.

    To view certificates on the server, run the following command:

    ```powershell
    Get-ExchangeCertificate | where {$_.rootcatype -eq "ThirdParty"} | ft ft thumbprint,services
    ```

3. If the SMTP service is enabled, enable the SMTP service on the third-party certificate. To do this, run the following command.

    > [!NOTE]
    > If you're prompted to replace the existing certificate with the new certificate, select **No**.

    ```powershell
    Get-ExchangeCertificate | where {$_.rootcatype -eq "ThirdParty"} |Enable-ExchangeCertificate -Services SMTP
    ```

4. Verify that the following parameters are set correctly on the Send connector that's used for sending email messages to Exchange Online.

    ```console
    FQDN : Mail.<domain>.com
    TlsDomain : mail.protection.outlook.com
    TlsAuthLevel : DomainValidation
    RequireTLS : True
    ```

5. If the parameters in step 4 are not present, run the following command on an internal transport server to set these parameters:

    ```powershell
    Set-SendConnector "<name of the sender connector used for sending email messages to Exchange Online>" -FQDN "<One of the domains present in the Subject Name or Subject alternative name of the third-party certificate>" -RequiredTLS $true -TlsDomain mail.protection.outlook.com -TlsAutheLevel DomainValidation
    ```

    Then, run the following command to synchronize the changes to Edge Transport servers:

    ```powershell
    start-edgesynchronization
    ```

6. Set the value of the `CloudServicesMailEnabled` parameter to **True** on the Send connector that's used for sending email messages to Exchange Online. This parameter is available for use if there are internal Exchange 2013 servers. To do this, run the following command:

    ```powershell
    Set-SendConnector "<name of the sender connector used for sending email messages to Exchange Online>" -CloudServicesMailEnabled:$true
    ```

7. If the internal transport servers are running Microsoft Exchange 2010, change the value of the `msExchSmtpSendFlags` parameter from **64** to **131136** on the Send connector that's used for sending email messages from the on-premises environment to Exchange Online. To do this, follow these steps.

    > [!WARNING]
    > This procedure requires Active Directory Service Interfaces Editor (ADSI Edit). Using ADSI Edit incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems that result from the incorrect use of ADSI Edit can be resolved. Use ADSI Edit at your own risk.

    1. Obtain the distinguished name of the Send connector. To do this, run the following command

        ```powershell
        Get-SendConnector "<Name of Send connector used for sending email messages from on-premises to Exchange Online>" | fl DistinguishedName
        ```

    2. Open ADSI Edit.
    3. Right-click **ADSI Edit**, select **Connect to** in the **Select a Well-Known Naming Context** box, select **Configuration**, and then select **OK**.
    4. Expand the Configuration container, and then locate the following entry:

       > CN=Services,CN=Microsoft Exchage,CN=\<Your Exchange Organization>, CN=Exchange Administrative Group (FYDIBOHF23SPDLT),CN=Routing Groups,CN= Exchange Routing Group (DWBGZMFD01QNBJR),CN=Connections

    5. On the right-hand side, select the Send connector that's used for sending email messages from the on-premises environment to Exchange Online, and then double-click it.
    6. On the **Attribute Editor** tab, locate the `msExchSmtpSendFlags` attribute, and then double-click it. In the **Value** box, change the value to **131136**.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
