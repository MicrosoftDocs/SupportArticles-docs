---
title: Azure AD Hybrid Sync Agent Installation Issues - Welcome page
description: This welcome page focuses on situations where you can't start or complete the installation of the Azure AD Hybrid Sync Agent.
ms.date: 09/15/2021
---

# Azure AD Hybrid Sync Agent Installation Issues

## Overview

The scenarios in this set of articles describe frequent issues when installing Azure AD Hybrid Sync Agent, and how to correct them.

This troubleshooting doc applies to configuring the agent for [Azure AD Connect Cloud Sync](/azure/active-directory/cloud-sync/how-to-install) or [Workday automatic user provisioning](/azure/active-directory/saas-apps/workday-inbound-tutorial).

- [No privileges to install MSI](azure-ad-hybrid-sync-no-privileges-install-msi.md)
- [Cannot start service AADConnectProvisioningAgent](azure-ad-hybrid-sync-cannot-start-aadconnect-provisioning-agent.md)
- [The gMSA is set to log on as Service](azure-ad-hybrid-sync-gmsa-set-logon-service.md)
- [There is no such object on the server](azure-ad-hybrid-sync-no-such-object-on-server.md)
- [Unable to create gMSA because KDS may not be running on domain controller](azure-ad-hybrid-sync-unable-create-gmsa-kds-domain-controller.md)

## Prerequisites

To install Cloud Provisioning Agent, it is required:

- To have Domain or Enterprise Administrator credentials to execute the installer.
- A Global Administrator Account at the Azure AD Tenant
- The server for the provisioning agent must be Windows Server 2016 or later, domain joined and following directives for tier 0 based on Active directory administrative model.
- At least one domain controller running Windows Server 2016, domain functional level and forest functional level at least 2012 R2.
- [Network prerequisites](/azure/active-directory/cloud-sync/how-to-prerequisites#in-your-on-premises-environment)
