---
title: Email delivery to Microsoft 365 groups fails in hybrid configuration
description: Discusses an issue in which Microsoft 365 groups in a hybrid Exchange environment don't get email messages sent from On-Premises mailboxes, and provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 03/25/2026
---

# Email delivery to Microsoft 365 groups fails in hybrid configuration

## Summary

This article discusses the reasons why a Microsoft 365 group configured in a hybrid Exchange environment might not receive email messages that are sent from On-Premises mailboxes. Also, it provides a resolution to fix the issue.

## Symptoms

You configure a Microsoft 365 group in a hybrid Exchange environment. Email messages that are sent from On-Premises mailboxes to the group are not delivered to the recipients, and the senders receive an error message. For example, if the name of the Microsoft 365 group is MyGroup, and it's hosted in the tenant that’s named Contoso, then you receive the following error message:

>**Delivery has failed to these recipients or groups:**
>
>MyGroup (mygroup@groups.contoso.com)
>
>Your message couldn't be delivered because delivery to this group is restricted to authenticated senders. If the problem continues, please contact your email administrator.
>
>**Diagnostic information for administrators:**
>
>Generating server: Exch3.contoso.com
>
>mygroup@groups.contoso.com
>
>Remote Server returned '550 5.7.133 RESOLVER.RST.SenderNotAuthenticatedForGroup; authentication required; Delivery restriction check failed because the sender was not authenticated when sending to this group'

## Cause

The issue might occur in the following scenarios:

**Scenario 1**

None of the senders of email messages from On-Premises mailboxes to the group are recognized as authenticated users by the Exchange Online service.

**Scenario 2**

You use centralized mail transport. In this scenario, the email messages that are sent by external users are rejected, even if the group is configured to accept email messages from external users.

## Resolution

Determine whether the Exchange Online service recognizes the sender of an email message to the group as an authenticated user. If it does, then the value of the X-MS-Exchange-Organization-AuthAs header in a message from the sender is set to `internal`. If the service doesn’t recognize the sender as an authenticated user, then the value of the header is set to `anonymous`.

To check the value of the X-MS-Exchange-Organization-AuthAs header, follow these steps:

1. Send an email message from an On-Premises mailbox to a mailbox that’s hosted in your Exchange Online tenant.
2. Locate the [X-MS-Exchange-Organization-AuthAs header,](https://support.microsoft.com/office/view-internet-message-headers-in-outlook-cd039382-dc6e-4264-ac74-c048563d212c) and check its value:

- If the value is anonymous, see Solution for scenario 1.

- If the value is internal, see Solution for scenario 2.

### Solution for scenario 1

The commands that are listed in this solution use "groups.contoso.com" as the email address of the affected Microsoft 365 group. In the commands, replace this address with the email address that’s associated with your Microsoft 365 group.

If the value of the X-MS-Exchange-Organization-AuthAs header is `anonymous`, check the following settings that are required for mail flow to work, and update the settings that aren’t configured correctly:

1. **Send connector**: Check whether the correct Send connector is used to deliver the sender’s email message. The Send connector that's used should be `Outbound to Office 365`. This connector is created by the Hybrid Configuration wizard (HCW).  

    To check the Send connector that's configured for email delivery, use the protocol log for the Send connector. [Protocol logging](https://learn.microsoft.com/en-us/exchange/mail-flow/connectors/protocol-logging) is not enabled by default. If it's not enabled, follow these steps to enable protocol logging, and then check the protocol log.

    a.  On your Exchange On-Premises server, open the Exchange Management Shell.
    b.  To enable protocol logging for the Send connector, run the following command:  

        ```powershell               
        Set-SendConnector "outbound to office 365\*" -ProtocolLoggingLeve Verbose
        ```

    c.  Open the protocol log for the Send connector from the following location: %ExchangeInstallPath%TransportRoles\Logs\FrontEnd\ProtocolLog\SmtpSend.
    d.  Search the log file for the email address of your affected group. Then, scroll to the beginning of the row that displays your group’s email address to see the value of the \`connector-id\` attribute. This value is the name of the Send Connector.  

        :::image type="content" source="media/microsoft-365-group-email-delivery-fails/protocol-log-for-send-connector.png" alt-text="Screenshot of the protocol log for the Send connector with the name of the Send connector and the affected group's name highlighted.":::

   If the Send connector in the protocol log is not listed as Outbound to Office 365, go to step 2. If the listed Send connector is the expected one, go to step 3.

2. **Address space**: Check whether groups.contoso.com is added as one of the address spaces in the Outbound to Office 365 Send connector. Follow these steps:

    a. On your Exchange On-Premises server, open the Exchange Management Shell.
    b. Run the Get-SendConnector command by using the AddressSpaces parameter:  

        ```powershell          
        Get-SendConnector -Identity \*Outbound to Office 365\* \| fl name,AddressSpaces
        ```

    c. If the output doesn’t list groups.contoso.com as one of the configured address spaces, run the following Set-SendConnector command:  

        ```powershell    
        Set-SendConnector -Identity "Outbound to Office 365\*" -AddressSpaces "contoso.mail.onmicrosoft.com","groups.contoso.com"
        ```  
          
        **Note**: When you run the HCW the next time, the groups.contoso.com domain is removed from the address space. Therefore, you will need to add it again.

3. **TLSCertificateName parameter**: Check the values that are set for the TLSCertificateName parameter in the Outbound to Office 365 Send connector. The `Issuer` and `SubjectName` attributes for the parameter must match the corresponding values in the trusted third-party certificate that’s used to configure mail flow for the hybrid Exchange environment. Follow these steps:

    a. To find the Issuer and SubjectName attributes of the trusted third-party certificate, run the following command:

       ```powershell
       Get-ExchangeCertificate -Thumbprint "YOUR_CERTIFICATE_THUMBPRINT" \| fl issuer, subject,services
       ```

    b. To check the values that are set for the TLSCertificateName parameter in the Send connector, run the following command:
  
       ```powershell
       Get-SendConnector -Identity "Outbound to Office 365\*" \| fl name, TLSCertificateName
       ```  

    The output displays the values in the following format:  
    \<I\>CN=\<value of the Issuer attribute\>  
    \<S\>CN=\<value of the SubjectName attribute\>

    c. If the values in the output from step 3b don’t match the values from step 3a, follow these steps to update them:

       i. On your Exchange On-Premises server, open the Exchange Management Shell.
      ii. Run the following commands:

            1.  Get-ExchangeCertificate -Thumbprint "YOUR_CERTIFICATE_THUMBPRINT"

            2.  \$TLSCert = Get-ExchangeCertificate -Thumbprint "YOUR_CERTIFICATE_THUMBPRINT" \$TLSCertName = "\<I\>\$(\$TLSCert.Issuer)\<S\>\$(\$TLSCert.Subject)"

            3.  Set-SendConnector -Identity "YourSendConnectorName" -TLSCertificateName \$TLSCertName

4. **CloudServicesMailEnabled parameter**: Check the value of the CloudServicesMailEnabled parameter in the inbound connector that HCW creates in Microsoft 365. It should be set to `true`. Follow these steps:

    a. To check the value that’s set for the CloudServicesMailEnabled parameter, run the following command:  

        ```powershell
        Get-InboundConnector -Identity "Inbound connector name" \| fl CloudServicesMailEnabled
        ```

    b.  If the output displays the value as `false`, run the following command:  

        ```powershell     
        Set-InboundConnector -Identity "Inbound connector name" -CloudServicesMailEnabled \$true
        ```

5. **TLSSenderCertificateName parameter**: Check the value of the TLSSenderCertificateName parameter in the inbound connector. It should match the accepted domain of your organization’s tenant. Follow these steps:

    a. To check the value that's set for the TLSSenderCertificateName parameter, run the following command:  

       ```powershell
       Get-InboundConnector -Identity "Inbound connector name" \| fl "TLSSenderCertificateName"
       ```

    b. If the output doesn’t match the accepted domain of your tenant, run the following command to update the value of the parameter:  

        ```powershell
        Set-InboundConnector -Identity "Inbound connector name" -TLSSenderCertificateName \<\*.AcceptedDomain\>"
        ```

### Solution for scenario 2

If the value of the X-MS-Exchange-Organization-AuthAs header is `internal`, then it's likely that you implemented centralized mail transport. In this scenario, the value of the msExchRequireAuthToSendTo attribute of the Microsoft 365 Group object that’s synchronized to Exchange On-Premises is always set to `True`. This value is set to `True` even if the value of the msExchRequireAuthToSendTo attribute in the corresponding Microsoft 365 group in Exchange Online is set to `False`.  
  
Also, in centralized mail transport, email messages are routed from Exchange Online to On-Premises and then back to Exchange Online. Because the email messages from external users are unauthenticated, and the Microsoft 365 Group object is configured to accept email messages from authenticated users only, the email messages are rejected by the On-Premises server. For this reason, centralized mail transport is not supported for Microsoft 365 groups in a hybrid Exchange environment.
