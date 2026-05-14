---
title: Troubleshooting Windows Server Secure Boot Certificate Update issues
description: Learn how to troubleshoot Secure Boot certificate update issues on Windows Server to maintain security before the 2026 expiration.
ms.date: 05/08/2026
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kaushika, anupamk
ms.custom:
- sap:system performance\startup configuration (general,secure boot,uefi)
- pcy:WinComm Performance
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshooting Windows Server Secure Boot certificate update issues

## Summary

Some Windows Server devices still use Secure Boot certificates issued in 2011, which will expire in June 2026. This article explains how to troubleshoot Secure Boot certificate update issues and ensure continued trust validation during startup.  
A similar guidance is published for Windows Client and Azure Local.

- For Windows Client related guidance, see [Update Secure Boot Certificates for Windows Devices](/troubleshoot/windows-client/windows-security/update-secure-boot-certificates).
- For Azure Local information, see [Security updates for Azure Local](/azure/azure-local/security-update/security-update?view=azloc-2601&tabs=os-build-25398-xxxx#windows-secure-boot-certificate-expiration&preserve-view=true).

## Impact

If affected servers aren’t updated:

- Systems may continue to boot normally  
- Secure Boot may not validate future updates to early boot components  
- Devices may operate with a degraded security posture  

Organizations must ensure servers transition to the **2023 Secure Boot certificate authorities** before expiration to maintain security alignment.  

## Identify devices affected by outdated Secure Boot certificates

### Common signs of affected servers

You may observe one or more of the following:

- Secure Boot certificate status is not updated  
- Registry value does not show expected state:
  - `UEFICA2023Status` is not set to **Updated**  
- System event logs include:
  - Event ID 1801  
  - Event ID 1795    


### Higher risk scenarios

Servers are more likely to encounter issues in the following cases:

- Older server hardware or firmware  
- Firmware that does not support updated Secure Boot certificates  
- Environments where certificate updates fail or are incomplete  

In these scenarios, you might experience:

- Secure Boot validation failures  
- Startup issues or failed boots  
- Certificate update failures during deployment  

## Resolve Secure Boot certificate issues

### Review your server estate

- Identify servers that still use 2011 Secure Boot certificates  
- Validate Secure Boot and certificate status using:
  - Registry keys  
  - Windows Event Viewer  

### Monitor Secure Boot certificate status

Check the following registry key:

`
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecureBoot
`
- `UEFICA2023Status = Updated` → Success  
- Otherwise → Action required  

Check:
`
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecureBoot\Servicing
`
- `UEFICA2023Error` exists → Error occurred  

---

### Review Event Viewer logs

Event Viewer > Windows Logs > System

| Event ID | Description |
|---------|-------------|
| 1808 | Success |
| 1801 | Incomplete |
| 1800 | Restart required |
| 1803 | Missing KEK |
| 1795 | Firmware error |

---

### Troubleshoot issues

**Event 1801 (incomplete)**
- Restart server  

**Event 1803 (missing KEK)**
- Check OEM firmware support  

**Event 1795 (firmware error)**
- Update firmware  

**UEFICA2023Error present**
- Review DB/DBX update logs  

**Deployment stuck**
- Validate firmware compatibility  

## Next steps

- Complete updates across servers  
- Ensure transition before June 2026  
- Monitor deployment status  

For further reference, refer [Windows Server Secure Boot playbook for certificates expiring in 2026](https://techcommunity.microsoft.com/blog/windowsservernewsandbestpractices/windows-server-secure-boot-playbook-for-certificates-expiring-in-2026/4495789).
