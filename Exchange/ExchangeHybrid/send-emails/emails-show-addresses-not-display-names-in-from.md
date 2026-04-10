---
title: Email shows addresses instead of names in From field
description: Describes an issue in which email messages that are sent from the on-premises environment to Microsoft 365 show email addresses instead of display names in the From field after you migrate mailboxes to Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: arindamt
appliesto: 
  - Exchange Online
  - Exchange Server 2019
search.appverid: MET150
ms.date: 04/10/2026
---
# Emails sent from on-premises to Microsoft 365 show email addresses in From field

_Original KB number:_ &nbsp; 2663556

## Summary

This article discusses an issue in which the **From** field in an email message that is sent from an on-premises Exchange Server mailbox to a Microsoft 365 mailbox in a hybrid deployment displays the sender’s email address instead of their display name. The article explains the cause of the issue and provides detailed steps to resolve it.

## Symptoms

After you migrate mailboxes from your on-premises environment to Microsoft 365 in a hybrid Exchange deployment, the **From** field of email messages that are sent from the on-premises environment to Microsoft 365 doesn't show the display names of the senders. Instead, the **From** field shows their email addresses.

When you check the email header of an email message that was sent from the on-premises user account, the value of the `X-MS-Exchange-Organization-AuthAs` header is listed as `anonymous` instead of `internal`.  

This issue occurs only in email messages that are sent from on-premises Exchange to Exchange Online.

## Cause

This issue occurs if the hybrid deployment is set up incorrectly.

## Resolution

The commands that are listed in this solution use "contoso.mail.onmicrosoft.com" as the domain for the affected mailboxes. In the commands, replace this address with the name of the domain in your environment.

To fix the issue, you need to ensure that the email message sent from on-premises Exchange is routed directly to Microsoft 365 by using the hybrid connectors created by the Hybrid Configuration wizard (HCW). There should be no network devices such as an anti-spam gateway device between the on-premises Bridgehead Exchange Server and Microsoft 365. These network devices can remove the header and certificate information that is necessary for mail flow. This type of routing is not supported in hybrid Exchange environments.

Check the following settings that are required for mail flow to work, and update the settings that aren’t configured correctly.

1. **Send connector**: Check whether the correct Send connector is used to deliver the sender’s email message. The Send connector that's used should be `Outbound to Office 365`. This connector is created by the Hybrid Configuration wizard (HCW).  

   To check the Send connector that's configured for email delivery, follow these steps:

    a. On your on-premises Exchange Server, open the Exchange Management Shell.
    b. Run the following PowerShell command:  

    ```powershell
    Get-MessageTrackingLog -MessageSubject "on-premises to exo 2" -EventId SENDEXTERNAL | fl sender, recipients,messagesubject,connector* 
    ```

    The output of this command will resemble the following example. The value of the \`ConnectorID\` attribute is the name of the Send connector.

    Sender         : user@contoso.com
    Recipients     : {EXO1@contoso.mail.onmicrosoft.com}
    MessageSubject : On-premises to EXO
    ConnectorId    : Outbound to Office 365 - b18e4be7-e70c-4fa1-8e8f-415bc7887abb

   If the name of the Send connector in the output isn't Outbound to Office 365, go to step 2. If the name of the Send connector is the expected one, go to step 3.

1. **Address space**: Check whether the contoso.mail.onmicrosoft.com domain is added as one of the address spaces in the Outbound to Office 365 Send connector. Follow these steps:

    a. On your on-premises Exchange Server, open the Exchange Management Shell.
    b. Run the Get-SendConnector command by using the AddressSpaces parameter:  

    ```powershell
    Get-SendConnector -Identity \*Outbound to Office 365\* \| fl name,AddressSpaces
    ```

    c. If the output doesn’t list contoso.mail.onmicrosoft.com as one of the configured address spaces, run the following Set-SendConnector command to add it:  

    ```powershell
    Set-SendConnector -Identity "Outbound to Office 365\*" -AddressSpaces "contoso.mail.onmicrosoft.com"
    ```  

1. **TLSCertificateName parameter**: Check the values that are set for the \`TLSCertificateName\` parameter in the Outbound to Office 365 Send connector. The \`Issuer\` and \`SubjectName\` attributes for the parameter must match the corresponding values in the trusted non-Microsoft certificate that’s used to configure mail flow for the hybrid Exchange environment. Follow these steps:

   a. To find the \`Issuer\` and \`SubjectName\` attributes of the trusted non-Microsoft certificate, run the following command:

   ```powershell
   Get-ExchangeCertificate -Thumbprint "YOUR_CERTIFICATE_THUMBPRINT" \| fl issuer, subject,services
   ```

   b. To check the values that are set for the \`TLSCertificateName\` parameter in the Send connector, run the following command:
  
   ```powershell
   Get-SendConnector -Identity "Outbound to Office 365\*" \| fl name, TLSCertificateName
   ```  

   The output displays the values in the following format:  
   \<I\>CN=\<value of the Issuer attribute\>  
   \<S\>CN=\<value of the SubjectName attribute\>

   c. If the values in the output from step 3b don’t match the values from step 3a, follow these steps to update them:

      i. On your on-premises Exchange Server, open the Exchange Management Shell.
     ii. Run the following commands:

   ```powershell
   Get-ExchangeCertificate -Thumbprint "YOUR_CERTIFICATE_THUMBPRINT"
   \$TLSCert = Get-ExchangeCertificate -Thumbprint "YOUR_CERTIFICATE_THUMBPRINT" \$TLSCertName = "\<I\>\$(\$TLSCert.Issuer)\<S\>\$(\$TLSCert.Subject)"
   Set-SendConnector -Identity "YourSendConnectorName" -TLSCertificateName \$TLSCertName
   ```

1. **CloudServicesMailEnabled parameter**: Check the value of the `CloudServicesMailEnabled` parameter in the inbound connector that HCW creates in Microsoft 365. It should be set to `true`. Follow these steps:

   a. To check the value that’s set for the CloudServicesMailEnabled parameter, run the following command:  

   ```powershell
   Get-InboundConnector -Identity "Inbound connector name" \| fl CloudServicesMailEnabled
   ```

   b.  If the output displays the value as `false`, run the following command:  

   ```powershell
   Set-InboundConnector -Identity "Inbound connector name" -CloudServicesMailEnabled \$true
   ```

1. **TLSSenderCertificateName parameter**: Check the value of the `TLSSenderCertificateName` parameter in the inbound connector. It should match the accepted domain of your organization’s tenant. Follow these steps:

   a. To check the value that's set for the \`TLSSenderCertificateName\` parameter, run the following command:  

   ```powershell
   Get-InboundConnector -Identity "Inbound connector name" \| fl "TLSSenderCertificateName"
   ```

   b. If the output doesn’t match the accepted domain of your tenant, run the following command to update the value of the parameter:  

   ```powershell
   Set-InboundConnector -Identity "Inbound connector name" -TLSSenderCertificateName \<\*.AcceptedDomain\>"
   ```
