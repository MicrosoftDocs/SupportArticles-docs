---
title: Troubleshooting the Intune Exchange Connector
description: Troubleshoot the configuration of and issues related to the Intune on-premises Exchange Connector.
ms.date: 12/13/2021
search.appverid: MET150
ms.reviewer: kaushika
---
# Troubleshooting the Intune Exchange Connector

This article gives troubleshooting guidance to help resolve common problems with the on-premises [Intune Exchange Connector](/mem/intune/protect/exchange-connector-install). To troubleshoot specific error messages, see [Resolve common errors for the Intune Exchange Connector](troubleshoot-exchange-connector-common-errors.md).

> [!IMPORTANT]
>
> As of July 2020, support for the Exchange Connector is deprecated, and replaced with Exchange [hybrid modern authentication](/office365/enterprise/hybrid-modern-auth-overview) (HMA).
>
> Existing customers with an active connector will be able to continue with the current functionality at this time. New customers and existing customers that do not have an active connector will no longer be able to create new connectors or manage Exchange ActiveSync (EAS) devices from Intune. For those tenants, Microsoft recommends the use of Exchange HMA to protect access to Exchange on-premises.

## Before you start

Before you start troubleshooting an Exchange Connector issue in Intune, collect some basic information so that you're working on a solid foundation. This approach can help you better understand the nature of the problem and resolve it more quickly.

- Verify that your process meets the installation requirements. See [Set up the on-premises Intune Exchange Connector](/mem/intune/protect/exchange-connector-install).
- Verify that your account has both Exchange and Intune administrator permissions.
- Note the complete and exact error message text, details, and where the message is displayed.
- Determine when the problem started:
  - Are you setting up the connector for the first time?
  - Did the connector work correctly and then fail?
  - If it was working, what changes occurred in the Intune environment, Exchange environment, or on the computer that runs the connector software?
- What is the MDM authority?
- What version of Exchange do you use?

### Use PowerShell to get more data on Exchange Connector issues

- To get a list of all mobile devices for a mailbox, use `Get-MobileDeviceStatistics -mailbox mbx`
- To get a list of SMTP addresses for a mailbox, use `Get-Mailbox -Identity user | select emailaddresses | fl`
- To get detailed information about a device's access state, use `Get-CASMailbox <upn> | fl`

## Review the connector configuration

Review the [on-premises Exchange connector requirements](/mem/intune/protect/exchange-connector-install#intune-exchange-connector-requirements) to make sure your environment and the connector is configured correctly.

### General considerations for the connector

- Make sure your firewall and proxy servers allow communication between the server that hosts the Intune Exchange Connector and the Intune service.

- The computer that hosts the Intune Exchange Connector and the Exchange Client Access Server (CAS) should be domain-joined and on same LAN. Make sure that the required permissions are added for the account that's used by the Intune Exchange connector.

- The notification account is used to retrieve *Autodiscover* settings. For more information about Autodiscover in Exchange, see [Autodiscover service in Exchange Server](/exchange/architecture/client-access/autodiscover).

- The Intune Exchange Connector sends a request to the EWS URL by using the notification account credentials to send notification email messages together with the *Get Started* link (to enroll in Intune). Use of the *Get Started* link to enroll is a requirement for Android non-Knox devices. Otherwise, these devices will be blocked by Conditional Access.

### Common issues with connector configurations

- **Account permissions**: In the Microsoft Intune Exchange Connector dialog box, make sure you've specified a user account that has the appropriate permissions to execute the [required Windows PowerShell Exchange cmdlets](/mem/intune/protect/exchange-connector-install#exchange-cmdlet-requirements).
- **Notification email messages**: Enable notifications and specify a notification account.
- **Client Access Server synchronization**: When configuring the Exchange Connector, specify a CAS that has the lowest network latency possible to the server hosting the Exchange connector. Communication latency between the CAS and the Exchange connector can delay device discovery, particularly when using Exchange Online Dedicated.
- **Synchronization schedule**: A user with a newly enrolled device could be delayed in getting access until the Exchange connector synchronizes with the Exchange CAS. A full sync takes place once a day, and a delta (quick) sync occurs several times a day. You can [manually force a quick sync or full sync](/mem/intune/protect/exchange-connector-install#manually-force-a-quick-sync-or-full-sync) to minimize delays.

## An Exchange ActiveSync device isn't discovered from Exchange

When an Exchange ActiveSync device isn't discovered from Exchange, [monitor the Exchange connector activity](/mem/intune/protect/exchange-connector-install#on-premises-intune-exchange-connector-high-availability-support) to see if the Exchange connector is syncing with the Exchange server. If no sync has happened since the device joined, collect the sync logs and attach them to a support request. If a full sync or quick sync has finished successfully since the device joined, check for the following issues:

- Make sure users have an Intune license. If not, the Exchange connector won't discover their devices.

- If the user's primary SMTP address is different from the user principal name (UPN) in Microsoft Entra ID, the Exchange connector won't discover any devices for that user. Fix the primary SMTP address to resolve the issue.

- If you have both Exchange 2010 and Exchange 2013 mailbox servers in your environment, we recommend pointing the Exchange connector to an Exchange 2013 Client Access server (CAS). If the Exchange connector is set up to communicate with an Exchange 2010 CAS, the Exchange connector won't discover any user devices on Exchange 2013.

- For Exchange Online Dedicated environments, you must point the Exchange connector to an Exchange 2013 CAS (not an Exchange 2010 CAS) in the dedicated environment during the initial setup. The connector will communicate only with an Exchange 2013 CAS when it executes PowerShell cmdlets.

## Users don't receive the notification email message

To support Conditional Access for on-premises mailboxes on devices that don't run Android Knox, make sure Intune enrollment starts from the "Get Started Now" email message that the Intune Exchange connector sends. Starting enrollment from the message ensures that the device receives a unique `ActiveSyncID` across all platforms (Exchange, Microsoft Entra ID, Intune).

A user might not receive the notification email message because:

- The notification account was set up incorrectly.
- `Autodiscover` failed for the notification account.
- The Exchange Web Services (EWS) request to send the email message failed.

Review the following sections to troubleshoot email notification issues.

### Check the notification account that retrieves Autodiscover settings

1. Make sure the `Autodiscover` service and EWS are configured on the Exchange Client Access services. For more information, see [Client Access services](/Exchange/architecture/client-access/client-access) and [Autodiscover service in Exchange Server](/Exchange/architecture/client-access/autodiscover).

2. Verify that your notification account meets the following requirements:

   - The account has an active mailbox that's hosted by your Exchange on-premises server.

   - The account UPN matches the SMTP address.

3. Autodiscover requires a DNS server that has a DNS record for **Autodiscover.SMTPdomain.com** (for example Autodiscover.contoso.com) that points to your Exchange Client Access server. To check for the record, specify your FQDN in place of *Autodiscover.SMTPdomain.com* and follow these steps:

   1. At a command prompt, enter *NSLOOKUP*.

   2. Enter *Autodiscover.SMTPdomain.com*. The output should be similar to the following image:

      :::image type="content" source="media/troubleshoot-exchange-connector-common-problems/nslookup-results.png" alt-text="Screenshot of the Nslookup output.":::

   You can also test the Autodiscover service from the internet at [https://testconnectivity.microsoft.com](https://testconnectivity.microsoft.com). Or test it from a local domain by using the Microsoft Connectivity Analyzer tool. For more information, see [Microsoft Connectivity Analyzer tool](/connectivity-analyzer/microsoft-connectivity-analyzer-tool).

### Check Autodiscover

If Autodiscover fails, try the following steps:

1. [Configure a valid Autodiscover DNS record](/previous-versions/exchange-server/exchange-150/mt473798(v=exchg.150)).

2. Hard-code the EWS URL in the Intune Exchange connector configuration file:

   1. Determine the EWS URL. The default EWS URL for Exchange is `https://<mailServerFQDN>/ews/exchange.asmx`, but your URL might differ. Contact the Exchange administrator to verify the correct URL for your environment.

   2. Edit the *OnPremisesExchangeConnectorServiceConfiguration.xml* file. By default, the file is located in *%ProgramData%\Microsoft\Windows Intune Exchange Connector* on the computer that runs the Exchange connector. Open the file in a text editor, and then change the following line to reflect the EWS URL for your environment: `<ExchangeWebServiceURL>https://<YourExchangeHOST>/EWS/Exchange.asmx</ExchangeWebServiceURL>`

3. Save the file, and then restart the computer or restart the Microsoft Intune Exchange connector service.

>[!NOTE]
> In this configuration, the Intune Exchange connector stops using Autodiscover and instead connects directly to the EWS URL.
