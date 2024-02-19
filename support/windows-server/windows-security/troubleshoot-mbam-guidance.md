---
title: Guidance for troubleshooting MBAM
description: Introduces general guidance for troubleshooting scenarios related to MBAM.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:bitlocker, csstroubleshoot
---
# MBAM troubleshooting guidance

This topic is intended to get you started on troubleshooting scenarios for Microsoft BitLocker Administration and Monitoring (MBAM).

## Event ID: 401

- Event symbol: ConfiguratorUnexpectedError
- Message:  
  > Unexpected Configurator error.

This event indicates that a terminating error occurred during an MBAM Configurator task. The message will contain more details about the error. Inspect other entries in the event log to further diagnose MBAM setup. Known errors include the following:

- Failure to retrieve or validate a certificate that was selected by the user
- Failure to parse the Reports URL
- Failure to open event logs for the user

## Event ID: 500

- Event symbol: WebProviderUnexpectedError
- Message:  
  > Web application provider unexpected error.

This event indicates that an error occurred while you enabled and configured an MBAM website or web service in IIS. Known errors include the following:

- Failure to find the IIS WWW root folder
- Failure to access IIS configuration in Web.config because of malformed files or missing settings
- Failure to create or remove a web application
- An IIS access violation

This event is also logged if MBAM cannot access Active Directory to validate user accounts. Verify that IIS is installed and correctly configured, and that the IIS service is running. Verify that all the MBAM software prerequisite checks are passed. Verify that the user has the correct permissions to create web applications on the IIS instance. Verify that the user has access to read user account objects in Active Directory.

## Event ID: 501

- Event symbol: WebProviderError
- Message:  
  > Web application provider unexpected error.

This event indicates that an error occurred while you enabled, disabled, or configured an MBAM website or web service in IIS. Known errors include the following:

- Failure to read basic or WSHttp binding information from IIS
- Missing identity section or DNS entry in an identity section in IIS config files
- Failure to open the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp` registry subkey
- Failure to read the **PathWWWRoot** value from `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp` registry subkey
- Attempt by user to specify a virtual directory name by using a name that's reserved for MBAM

Verify that IIS is installed and correctly configured. Verify that the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp:PathWWWRoot` registry subkey exists and accessible. Verify that the binding information in IIS is not corrupted.

## Event ID: 600

- Event symbol: SetupUnexpectedError
- Message:  
  > Unexpected setup error.

This event indicates that a terminating error occurred while you enabled, disabled, or configured an MBAM feature. Known errors include the following:

- Failure to roll back a task after an error
- Failure to read from the registry
- Failure to create or delete a folder in the file system
- Failure to read Microsoft SQL Server version information
- Failure to register VSS Writer in SQL Server

The event entry will contain more information about the specific error. Verify that all MBAM software prerequisite checks are passed. Verify the MBAM registry path. If it exists, verify the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MBAM Server` registry subkey and all its subkeys are readable. Verify that Active Directory is reachable from the server where the MBAM setup is running. Verify that the user who is running the MBAM setup has read permissions in Active Directory.

## Event ID: 601

- Event symbol: SetupError
- Message:  
  > Setup error.

This event entry indicates that a terminating error occurred while you enabled, disabled, or configured an MBAM feature. Known errors include the following:

- Failure to read MBAM configuration in IIS
- Corrupted "appSettings" section in IIS configuration, or misconfigured settings
- Failure to validate the host name
- Failure to read SQL Server version information
- Failure to register VSS Writer in SQL Server

The event entry will contain more information about the specific error. Verify that IIS is installed and configured correctly. Verify that all MBAM software prerequisite checks are passed. For a successful VSS Writer registration, verify that a supported version of SQL Server is installed, and an instance is accessible to the user who is running MBAM Setup.

## Event ID: 607

- Event symbol: SetupParameterValidationFailureWithError
- Message:  
  > Error encountered while trying to validate specified parameter that is needed to enable the server feature.

This event indicates that an error was encountered while you tried to validate a specified parameter that is required to enable the server feature.

### Common issues and solutions for events that can occur while MBAM is running

## Event ID: 104

- Event symbol: StatusServiceComplianceDbConfigError
- Message:  
  > The Compliance database connection string in the registry is empty.

This event is logged whenever the compliance db connection string is invalid. Verify the value in the  `HKEY_LOCAL_MACHINE\Software\Microsoft\MBAM Server\Web\ComplianceDBConnectionString` registry subkey.

## Event ID: 106

- Event symbol: HelpdeskError
- You receive one of the following error messages:

  - > The request to URL \{url\} caused an internal error.
  - > An error occurred while obtaining execution context information. Unable to verify Service Principal Name (SPN) registration.
  - > An error occurred while verifying Service Principal Name (SPN) registration.

Use the following information to troubleshoot this issue:

- This event entry indicates that an unhandled exception was raised in the Helpdesk application. Review the log entries in the MBAM Admin operational channel to find the specific exception.
- During the initial Helpdesk website load operation, an SPN check is run. To verify the SPN, the Helpdesk requires execution account information, IIS Sitename, and the ApplicationVirtualPath value that corresponds to the Helpdesk website. This error entry is logged when one or more of these items is invalid or missing.
- This entry indicates that a security exception is thrown while running SPN verification.

## Event ID: 107

- Event symbol: SelfServicePortalError
- You receive one of the following error messages:

  - > An error occurred while getting recovery key for a user. EventDetails:\{ExceptionMessage\}
  - > An error occurred while obtaining execution context information. Unable to verify Service Principal Name (SPN) registration. EventDetails: User: \{username Identity\} Application:\{SiteName\\ApplicationVirtualPath\}
  - > An error occurred while verifying Service Principal Name (SPN) registration. EventDetails:\{ExceptionMessage\}

Use the following information to troubleshoot this issue:

- This event indicates that an unexpected exception was thrown when a request was made to retrieve the recovery key. Refer to the exception message that's contained in event details section. If tracing is enabled on MBAM Helpdesk, refer to trace data to obtain detailed exception messages.
- During an initial load operation, the Self-Service Portal (SSP) retrieves execution account information, IIS Sitename, and the ApplicationVirtualPath value that corresponds to the Self-Service website to verify SPN. This event entry is logged when one or more of these items is invalid.
- This message indicates that a security exception was thrown while running SPN verification. Refer to the exception that's contained in event details section.

## Event ID: 108

- Event symbol: DomainControllerError
- You receive one of the following error messages:

  - > An error occurred while resolving domain name \{DomainName\}, A memory allocation failure occurred.
  - > Could not invoke DsGetDcName method. EventDetails:\{ExceptionMessage\}

Use the following information to troubleshoot this issue:

- To resolve Domain name, MBAM leverages "DsGetDcName" windows API. This entry is logged when "DsGetDcName" returns "ERROR_NOT_ENOUGH_MEMORY" to indicate a memory allocation failure.
- This message indicates that the `DsGetDcName` API method is unavailable on the hosting system.

## Event ID: 4

- Event symbol: PerformanceCounterError
- Message:  
  > An error occurred while retrieving a performance counter.

The message contained in the event entry will provide more details about the exception that was thrown. If a System.UnauthorizedAccessException was thrown, verify that the MBAM execution account (app pool) has access to performance counter APIs.

## Updates for MBAM Server

To determine the current version of MBAM Server side components, locate the following registry entries:

- **MBAM 2.5**  
  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MBAM Server`  
  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MBAM Server\Version`

- To determine the current version of the MBAM agent, locate the following registry entry:
  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MBAM`

- You can directly go to the filesystem to check the properties of the agent service file. By default, the file is in the following location:  
  *C:\\Program Files\\Microsoft\\MDOP MBAM*

Steps to update MBAM Server for the existing MBAM environment:

1. Remove the MBAM Server feature. To do this, open the MBAM Server Configuration Tool, and then select **Remove Features**.
2. Remove MDOP MBAM from the **Programs and Features** item in Control Panel.
3. Install the MBAM 2.5 SP1 RTM server components.
4. Install the latest MBAM 2.5 Service Pack 1 (SP1) hotfix rollup.
5. Configure MBAM features by using MBAM Server Configurator.

## Reference

- [Information about MBAM Server Configuration log events](/microsoft-desktop-optimization-pack/mbam-v25/server-event-logs#configuration)
- [Information about MBAM Server Operation log events](/microsoft-desktop-optimization-pack/mbam-v25/server-event-logs#operation)
- Deploying MBAM 2.5 in a standalone configuration:

  - [Preparation steps before installing MBAM 2.5 server](/microsoft-desktop-optimization-pack/mbam-v25/deploy-mbam#preparation-steps-before-installing-mbam-25-server-software)
  - [Installing and configuring MBAM 2.5 server](/microsoft-desktop-optimization-pack/mbam-v25/deploy-mbam#installing-and-configuring-mbam-25-server-software)
  - [Customizing and validating steps after installing MBAM 2.5 server](/microsoft-desktop-optimization-pack/mbam-v25/deploy-mbam#customizing-and-validating-steps-after-installing-mbam-25-server-software)

- Upgrade Microsoft BitLocker Administration and Monitoring (MBAM) 2.5 to MBAM 2.5 Service Pack 1 (SP1) in a standalone configuration.

  - [Prepare to upgrade MBAM 2.5 SP1](/microsoft-desktop-optimization-pack/mbam-v25/upgrade-mbam2.5-sp1#prepare-to-upgrade-mbam-25-sp1)
  - [Upgrade the MBAM infrastructure to the latest version available](/microsoft-desktop-optimization-pack/mbam-v25/upgrade-mbam2.5-sp1#upgrade-the-mbam-infrastructure-to-the-latest-version-available)

- Troubleshooting MBAM 2.x installation

  - [Encryption and reporting issues](/microsoft-desktop-optimization-pack/mbam-v25/troubleshooting-mbam-installation#troubleshooting-encryption-and-reporting-issues)
  - [MBAM Agent communication issues](/microsoft-desktop-optimization-pack/mbam-v25/troubleshooting-mbam-installation#troubleshooting-mbam-agent-communication-issues)
  - [Re-installation or reconfiguration of MBAM infrastructure](/microsoft-desktop-optimization-pack/mbam-v25/troubleshooting-mbam-installation#re-installation-or-reconfiguration-of-mbam-infrastructure)
  - [MBAM log files for troubleshooting](/microsoft-desktop-optimization-pack/mbam-v25/troubleshooting-mbam-installation#referring-mbam-log-files-for-troubleshooting)
