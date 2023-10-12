---
title: Troubleshoot Configuration Management bootstrap with modern provisioning
description: Helps you understand and troubleshoot issues that you may encounter when you set up co-management by taking path 2 - Bootstrap the Configuration Manager client with modern provisioning.
ms.date: 04/16/2020
search.appverid: MET150
ms.custom: sap:Co-management with Configuration Manager
ms.reviewer: kaushika, luche
---
# Troubleshoot co-management: Bootstrap with modern provisioning

This article helps you understand and troubleshoot issues that you may encounter when you set up co-management by taking path 2: [Bootstrap the Configuration Manager client with modern provisioning](/mem/configmgr/comanage/quickstart-paths#bkmk_path2).

This scenario occurs when you have new Windows 10 devices that join Microsoft Entra ID and automatically enroll to Intune, and then you install the Configuration Manager client to reach a co-management state.

## Before you start

Before you start troubleshooting, it's important to collect some basic information about the issue and make sure that you follow all required configuration steps. This helps you better understand the problem and reduce the time to find a resolution. To do this, follow this checklist of pre-troubleshooting questions:

- Which [Microsoft Entra hybrid identity option](/azure/active-directory/hybrid/plan-connect-user-signin#choosing-the-user-sign-in-method-for-your-organization) did you select?
- What is your [current MDM authority](/mem/intune/fundamentals/mdm-authority-set)?
- Did you [set up enhanced HTTP](/mem/configmgr/core/plan-design/hierarchy/enhanced-http)?
- Did you [create the cloud services in Azure](/mem/configmgr/core/servers/deploy/configure/azure-services-wizard)?
- Did you [configure the cloud management gateway (CMG)](/mem/configmgr/core/clients/manage/cmg/setup-cloud-management-gateway)?
- Did you [configure client-facing roles for CMG traffic](/mem/configmgr/core/clients/manage/cmg/setup-cloud-management-gateway#configure-client-facing-roles-for-cmg-traffic)?
- Did you [install the Configuration Manager client in Intune](/mem/configmgr/comanage/how-to-prepare-Win10#install-the-configuration-manager-client)?

Most issues occur because one or more of these steps were not completed. If you find that a step was skipped or was not completed successfully, check the details of each step, or see the following tutorial:

[Tutorial: Enable co-management for modern provisioned clients](/mem/configmgr/comanage/tutorial-co-manage-new-devices)

<a name='troubleshooting-hybrid-azure-ad-configuration'></a>

## Troubleshooting hybrid Microsoft Entra configuration

If you are experiencing issues that affect either Microsoft Entra hybrid identity or Microsoft Entra Connect, refer to the following troubleshooting guides:

- [Troubleshoot Microsoft Entra Connect install issues](/azure/active-directory/hybrid/tshoot-connect-install-issues)
- [Troubleshoot errors during Microsoft Entra Connect synchronization](/azure/active-directory/hybrid/tshoot-connect-sync-errors)
- [Troubleshoot password hash synchronization with Microsoft Entra Connect Sync](/azure/active-directory/hybrid/tshoot-connect-password-hash-synchronization)
- [Troubleshoot Microsoft Entra seamless single sign-on](/azure/active-directory/hybrid/tshoot-connect-sso)
- [Troubleshoot Microsoft Entra pass-through authentication](/azure/active-directory/hybrid/tshoot-connect-pass-through-authentication)
- [Troubleshoot single sign-on issues with Active Directory Federation Services](https://support.microsoft.com/help/4034932)

If you are experiencing issues that affect Microsoft Entra hybrid join for managed domains or federated domains, refer to the following troubleshooting guides:

- [Troubleshooting Microsoft Entra hybrid joined devices](/azure/active-directory/devices/troubleshoot-hybrid-join-windows-current)
- [Troubleshooting devices using the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd)

## Frequently asked questions  

### What roles do I need to configure co-management?

Here are the required [permissions and roles](/mem/configmgr/comanage/overview#permissions-and-roles) to configure co-management.  

### What log can I use to validate workloads and determine where policies and apps come from in a co-management scenario?

You can use the following log file on Windows 10 devices:

`%WinDir%\CCM\logs\CoManagementHandler.log`

### How do I validate that my cloud service has a unique DNS name?

To do this, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com), go to **All Services** > **Cloud Services (Classic)**, and then click **Add**.
2. In the in **DNS name** field, enter a name that you want to use.
3. When you have a name that is available for you to use, note it without creating it in the **Cloud Service** pane.
4. Create a CNAME record that maps your domain to *\<name>.cloudapp.net* in both internal and external DNS servers.

### Where can I find the Configuration Manager client setup MSI?

You can find the **ccmsetup.msi** file in the following folder on the Configuration Manager site server:

`<ConfigMgr installation directory>\bin\i386`

### How do I verify the Configuration Manager client deployment from Intune to the managed Windows 10 devices?

To verify the deployment, follow these steps on the Windows 10 device:

1. Open File Explorer, and go to `%WinDir%\CCM\logs`.
2. Open the ADALOperationProvider.log file with [CMTrace](/mem/configmgr/core/support/cmtrace), and look for **Getting Microsoft Entra ID (User) token and Getting Microsoft Entra ID (device) token** to verify the tokens.
3. In CMTrace, open the CoManagementHandler.log file, look for **Device is already enrolled with MDM and Device Provisioned** to verify the enrollment.
4. Open Control Panel, type **Configuration Manager** in the search box, and then select it.
5. Select the **General** tab, and verify the **Assigned management point**.
6. Select the **Network** tab, and verify the **Internet-based management point**.

## Common issues

<a name='configuration-manager-allows-only-an-https-enabled-management-point-for-azure-ad-joined-clients'></a>

### Configuration Manager allows only an HTTPS-enabled management point for Microsoft Entra joined clients

This issue occurs if you use Configuration Manager current branch version 1802 or an earlier version. In these versions, management points that you enable for CMG must be HTTPS. Starting in version 1806, the management point can be HTTP.

To fix the issue, update to Configuration Manager current branch version 1806 or a later version.

### Whether PKI certificates are still a valid option instead of enhanced HTTP

PKI certificates are still a valid option for you, but they have the following requirements:

- All client communication is done over HTTPS.
- You must have advanced control of the signing infrastructure.

For more information, see [Enhanced HTTP](/mem/configmgr/core/plan-design/hierarchy/enhanced-http).

### I can't find the Client Computer Communication tab in Site Configuration

Starting in Configuration Manager current branch version 1906, this tab is renamed to **Communication Security**.

### The Use Configuration Manager-generated certificates for HTTP site systems option is enabled, but no certificate is received

This behavior is expected. It can take up to 30 minutes for the management point to receive and configure the new certificate from the site. You can use the following log to track, monitor, and verify this:

`<ConfigMgr installation directory>\Logs\CloudMgr.log`

<a name='records-for-the-resources-and-their-associated-information-from-azure-ad-arent-created-in-the-configuration-manager-database'></a>

### Records for the resources and their associated information from Microsoft Entra ID aren't created in the Configuration Manager database

When you onboard the Configuration Management site to Microsoft Entra ID, the Microsoft Entra user resources aren't discovered or populated into the Configuration Manager database. Usually, you receive the 0x87d00231 error in this scenario.

This issue occurs in one of the following situations:

- You didn't successfully configure the API permissions for the app registration in the Azure portal.
- Microsoft Entra user Discovery isn't enabled or configured.

To fix the issue, follow the steps in [Microsoft Entra user Discovery](/mem/configmgr/core/servers/deploy/configure/configure-discovery-methods#azureaadisc) to configure API permissions and Microsoft Entra user Discovery. You can use the following logs to check details:

- `<ConfigMgr installation directory>\Logs\SMS_AZUREAD_DISCOVERY_AGENT.log` on the site server
- `%WinDir%\CCM\logs\CcmMessaging.log` on the client
- `%WinDir%\CCM\logs\LocationServices.log` on the client

>[!NOTE]
> If the Configuration Manager site is new or recently rebuilt, you must also configure [Active Directory User Discovery](/mem/configmgr/core/servers/deploy/configure/configure-discovery-methods#BKMK_ConfigADDiscGeneral).

### CoManagementHandler.log shows **Queuing enrollment timer to fire at...**

The ADALOperationProvider.log file on the Windows devices shows **Getting Microsoft Entra ID (User) token and Getting Microsoft Entra ID (device) token**. However, the device isn't enrolled, and the last line in CoManagementHandler.log is **Queuing enrollment timer to fire at...**.

This behavior is expected in Configuration Manager current branch version 1806 and later versions. Starting in version 1806, automatic enrollment isn't immediate for all clients. This behavior helps enrollment scale better for large environments. Configuration Manager randomizes enrollment based on the number of clients. For example, if your environment has 100,000 clients, enrollment may occur over several days.

To monitor co-management, go to **Monitoring** > **Co-Management** in the Configuration Manager console.  

### I copied the customized client installation command from the Configuration Manager console, but the Configuration Manager client can't be installed

This issue occurs in one of the following situations:

- The installation parameters in the command don't conform to the [supported values](/mem/configmgr/core/clients/deploy/about-client-installation-properties).
- The length of the command line is greater than 1,024 characters.

To fix the issue, make sure that the command meets the requirement and the command line isn't more than 1,024 characters long.  

### Configuration Manager agent state is unhealthy in Intune

Intune evaluates the Configuration Manager agent state based on the `ClientHealthLastSyncTime` and `ClientHealthStatus` values in the following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\MDM`

The following are possible values of `ClientHealthStatus`:

- **1**: Client installed
- **2**: Client registered
- **5**: Client installed, but hasn't run Health Evaluation yet
- **7**: Client healthy
- **8**: Client install or upgrade error
- **16**: Communication error in management point

If the `ClientHealthStatus` value is **7** (healthy), Intune considers the Configuration Manager client as healthy if the `ClientHealthLastSyncTime` is not older than 30 days.

If the `ClientHealthStatus` value isn't **7** (unhealthy), Intune considers the Configuration Manager client as healthy if the `ClientHealthLastSyncTime` is not older than 48 hours.

The `ClientHealthLastSyncTime` value is updated by the **Client Notification** component of Configuration Manager client, and the log file is CcmNotificationAgent.log.

To troubleshoot this issue, check the CcmNotificationAgent.log file if the `ClientHealthLastSyncTime` is not up to date. Here is an example:

> Updating MDM_ConfigSetting.ClientHealthLastSyncTime with value 2019-04-01T21:42:51Z             BgbAgent                4/2/2019 8:42:51 AM     9476 (0x2504)

If the `ClientHealthLastSyncTime` value is up-to-date, but the last check-in time of the Configuration Manager agent is **2/1/1900** in Intune, this means that the device compliance policies workload is managed by Configuration Manager. In this case, [switch](/mem/configmgr/comanage/how-to-switch-workloads) the compliance policies workload to Intune or Pilot Intune.  

### The CMG connection point shows as disconnected

The issue occurs because of a permissions issue between the remote site system where the CMG connection point role is installed and the primary site.

The remote site system collects the `TrafficData` report from the CMG, then sends the data to the primary site through state messages. Here is a sample log snippet of SMS_Cloud_ProxyConnector.log:

> SMS_CLOUD_PROXYCONNECTOR    6124 (0x17ec)    ReportTrafficData - state message to send: \~~\<ProxyTrafficStateDetails ServerName="PS1DP.CONTOSO.COM" StartTime="Date1 Time1" EndTime="Date2 Time2" MaxConcurrentRequests="2">  \<EndPoints>~~    \<EndPoint Name="BGB" ProxyServer="DOMAINCMG.CLOUDAPP.NET" TargetHost="ps.contoso.com" TotalRequests="2" TotalRequestsWithBearerToken="0" MaxConcurrentRequests="2" TotalRequestBytes="2594" TotalResponseBytes="716" FailedRequests="0"/>~~  \</EndPoints>\~~\</ProxyTrafficStateDetails>~~~~

Because the remote site system is also a management point, these state messages are moved into an outbox that is accessed by MP File Dispatch Manager that sends the files to the primary site. Here is a sample log snippet of mpfdm.log:

> SMS_MP_FILE_DISPATCH_MANAGER    7044 (0x1b84)    ~Moving 1 *.SMX file(s) from C:\SMS\MP\OUTBOXES\statemsg.box\ to \\\PS.contoso.com\SMS_PS1\inboxes\auth\statesys.box\incoming\\.  
> SMS_MP_FILE_DISPATCH_MANAGER    6584 (0x19b8)    ~Moved file C:\SMS\MP\OUTBOXES\statemsg.box\\___CMUp5onztqe.SMX to \\\PS.contoso.com\SMS_PS1\inboxes\auth\statesys.box\incoming\\___CMUp5onztqe.SMX

When there is a permission issue, MP File Dispatch Manager can't access the inboxes on the primary site and logs the following error in mpfdm.log:

> SMS_MP_FILE_DISPATCH_MANAGER    3828 (0xef4)    ~**ERROR: Cannot connect to the inbox source, sleep 30 seconds and try again.

To fix the issue, add the machine account of the remote site system to the Local Administrators group on the primary site.  

### Clients can't locate the management point by using the CMG, and you receive error 403

When this issue occurs, the following error is logged in LocationServices.log on the client:

> [CCMHTTP] ERROR INFO: StatusCode= **403** StatusText=CMGConnector_Clientcertificaterequired LocationServices

Additionally, the following error is logged in SMS_Cloud_ProxyConnector.log on the CMG connection point server:

> MessageID: \<ID> RequestURI: https://\<FQDN>/SMS_MP/.sms_aut?SITESIGNCERT EndpointName: SMS_MP ResponseHeader: HTTP/1.1 **403** CMGConnector_Clientcertificaterequired~~ ResponseBodySize: 5274 ElapsedTime: 44 ms SMS_CLOUD_PROXYCONNECTOR

If the CMG connection point server has a valid client authentication certificate, the most possible cause is failure to validate the Certificate Revocation List (CRL) for the certificate. If this is the case, you receive the 0x87d0027e error, and the following error is logged in the CAPI2 event log:

> The revocation function was unable to check revocation because the revocation server was offline.  80092013

Additionally, if you enable verbose logging by setting the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\SMS_CLOUD_PROXYCONNECTOR\VerboseLogging` registry value to **1**, error entries that resemble the following are logged in SMS_Cloud_ProxyConnector.log:

> Chain build failed cert: C019CC17EEFA681D154BA9F24F8EAE9640D54C49  
> Chain 0 status: RevocationStatusUnknown  
> Chain 1 status: OfflineRevocation  
> Chain build failed cert: 54E09FEA31FE83F9A8AA5389B8D08B34D42FB3CF  
> Chain 0 status: RevocationStatusUnknown  
> Chain 1 status: OfflineRevocation  
> Not allowed cert: 52E140B1DD16A556AB77932B63DE87955BBC4616 52E140B1DD16A556AB77932B63DE87955BBC4616  
> Filtered cert count with allowed root CA and has private key: 0  
> Filtered cert count with client auth: 0

We recommend that, instead of automatically disabling CRL checking, you first make sure that it works. However, if you can't get CRL checking to work correctly, temporarily disable CRL checking for CMG connection points. This lets a client certificate be selected without performing CRL checking, and enables communication with the management point.

## More information

For more information about troubleshooting co-management issues, see the following articles:

- [Troubleshoot co-management: Auto-enroll existing Configuration Manager-managed devices into Intune](troubleshoot-co-management-auto-enrolling.md)
- [Troubleshoot co-management workloads](troubleshoot-co-management-workloads.md)

For more information about Intune and Configuration Manager co-management, see the following articles:

- [Overview of Windows 10 co-management](/mem/configmgr/comanage/overview)
- [Getting Started: Paths to co-management](/mem/configmgr/comanage/quickstart-paths)
- [Quickstarts for co-management](/mem/configmgr/comanage/quickstarts)
- [Tutorial: Enable co-management for existing Configuration Manager clients](/mem/configmgr/comanage/tutorial-co-manage-clients)
- [How to prepare internet-based devices for co-management](/mem/configmgr/comanage/how-to-prepare-Win10)
