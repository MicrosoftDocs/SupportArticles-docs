---
title: Host Guardian Service Troubleshooting Guide
description: Resolves issues that occur when you configure HGS to use HTTPS for key protection and attestation in test environments.
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap: virtualization and hyper-v\shielded virtual machines
- pcy: Virtualization\shielded VMs
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Can't configure HGS for HTTPS key protection and attestation

## Summary

This article helps you to handle issues that occur when you configure the Host Guardian Service (HGS) to use HTTPS for key protection and attestation in test environments. By following these steps and guidelines, you can resolve configuration issues that affect the HGS, and ensure secure communication for your VMs.

## Symptoms

The following symptoms occur when you try to enable HTTPS on the HGS:

- Attestation and key unwrap operations for VMs fail.
- TLS (Transport Layer Security) and certificate trust errors appear in browsers and clients.
- The certificate’s Subject Alternative Name (SAN) includes only the DNS HGS service name and not individual node hostnames.
- You receive the following error message:

> TransientError Host Unreachable

When this issue occurs, the following conditions apply:

- Failures occur during attestation and key unwrap processes over HTTPS.
- The configuration functions correctly when HTTP is used instead of HTTPS.
- Network trace and Test-NetConnection confirm communication on required ports.
- The certificate’s Subject Alternative Name (SAN) includes only the DNS HGS service name and not individual node hostnames.
- The issue isn't reproducible in other test environments, such as the support engineer’s lab environment.

## Cause

The root cause of the problem is related to the HTTPS configuration and certificate requirements for HGS:

- Nonmandatory HTTPS: HTTPS is optional for HGS. HTTP communications are already encrypted at the message level as part of the Key Protection Service (KPS) protocol.
- Certificate issues: The certificate that's used for HTTPS doesn't meet the documented requirements, such as missing SAN entries for all HGS node hostnames.
- Environment-specific factors: The issue might be caused by configuration or compatibility challenges that are specific to the environment, or from deprecated features in the Windows Server version that's used.
- Feature design: Development confirms that HGS over HTTP provides adequate encryption, and HTTPS isn't required for security.

## Resolution

To resolve this issue, follow these steps:

1. Use HTTP for HGS communication:

Based on recommendations from the product and development teams, you should continue to use HTTP for HGS. HTTP provides message-level encryption, ensuring data security.

2. Validate encryption:

Collect network traces to verify that HTTP payloads are encrypted and not exposed in plain text.

3. Certificate reconfiguration (if HTTPS is required):

If HTTPS must be used, make sure that certificates meet all documented requirements, including SAN entries for all HGS node hostnames. Consult the HGS documentation for guidance to issue certificates correctly.

4. Use available tools for troubleshooting and validation:

Use the following tools and commands to troubleshoot and verify the configuration:

- Test-NetConnection to verify required port connectivity
- PowerShell cmdlets such as Set-HgsServer for configuring HGS
- Network tracing tools to verify encryption of HTTP payloads
- Browser-based validation to verify HTTPS endpoint and certificate trust

5. Plan for future deployments:

- Review feature deprecation notices for HGS and shielded VMs in newer Windows Server versions.
- Consider alternatives, such as Azure Confidential Computing, for future deployments.

6. Review documentation and guidelines:

- Share relevant public documentation and internal guidelines with your team to ensure proper configuration and understanding of HGS.

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- Network traces: Perform network tracing during key protection exchanges to verify encryption of communications.
- PowerShell diagnostic outputs: Collect outputs from HGS servers and guarded hosts by using HGS-related PowerShell commands.
- HTTP and HTTPS traffic logs: Analyze logs for TLS-related errors and communication issues.
- Configuration details: Record details about the environment, such as certificate attributes, HGS node hostnames, and DNS configuration.

## References

- [Host Guardian Service overview](/windows-server/security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms)
- [Configure HGS](/windows-server/security/guarded-fabric-shielded-vm/guarded-fabric-setting-up-the-host-guardian-service-hgs)
- [Certificate requirements for HGS](/windows-server/security/guarded-fabric-shielded-vm/guarded-fabric-obtain-certs)
- [How to configure HTTPS](/windows-server/security/guarded-fabric-shielded-vm/guarded-fabric-configure-hgs-https)
- [Frequently Asked Question About HGS Certificates](/archive/blogs/datacentersecurity/frequently-asked-questions-about-hgs-certificates)
 [Azure Confidential Computing](/azure/confidential-computing/overview)
