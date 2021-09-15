# Azure AD Hybrid Sync Agent Installation Issues

## Overview

The scenarios in this set of articles describes frequent issues when installing Azure AD Hybrid Synch Agent, and how correct them.

- [No privileges to install MSI](azure-ad-hybrid-synch-no-privilages-install-msi.md)
- [Cannot start service AADConnectProvisioningAgent](azure-ad-hybrid-synch-cannot-start-aadconnect-provisioning-agent.md)
- [The gMSA is set to log on as Service](azure-ad-hybrid-synch-gMSA-set-logon-service.md)
- [There is no such object on the server](azure-ad-hybrid-synch-no-such-object-on-server.md)
- [Unable to create gMSA because KDS may not be running on domain controller](azure-ad-hybrid-synch-unable-create-gmsa-kds-domain-controller.md)

## Prerequisites

To install Cloud Provisioning Agent, it is required:

- To have Domain or Enterprise Administrator credentials to execute the installer.
- A Global Administrator Account at the Azure AD Tenant
- The server for the provisioning agent must be Windows Server 2016 or later, domain joined and following directives for tier 0 based on Active directory administrative model.
- At least one domain controller running Windows Server 2016, domain functional level and forest functional level at least 2012 R2.
- [Network prerequisites](/azure/active-directory/cloud-sync/how-to-prerequisites#in-your-on-premises-environment)
