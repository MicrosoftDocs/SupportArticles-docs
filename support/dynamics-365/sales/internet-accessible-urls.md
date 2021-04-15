---
title: Internet accessible URLs
description: A connectivity issue while accessing the CRM application and as a result the application may fail to load.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Internet accessible URLs required for connectivity to Microsoft Dynamics CRM Online

This article provides a solution to an issue when you can't access Microsoft Dynamics CRM Online, or specific URLs fail to load.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2655102

## Symptoms

You can't access Microsoft Dynamics CRM Online, or specific URLs fail to load when you use Microsoft Dynamics CRM. When you try to configure Microsoft Dynamics CRM for Outlook, you receive the following error message:

> The server address (URL) is not valid

Additionally, a network error message is displayed if you monitor network traffic or web requests. The error is logged as an HTTP 502 error.

## Cause

A proxy or firewall may be configured to prevent Microsoft Dynamics CRM URLs from accessing server resources.

## Resolution

To resolve the issue, add the following URLs to the allow list to access traffic to these URLs.

**North America-based organizations**:

- `https://login.microsoftonline-p.com`
- `https://login.live.com`
- `https://secure.aadcdn.microsoftonline-p.com`
- `https://crl.microsoft.com/pki/crl/products/microsoftrootcert.crl`
- `https://mbs.microsoft.com`
- `https://go.microsoft.com`
- `https://urs.microsoft.com`
- `https://auth.gfx.ms`
- `https://sc.imp.live.com`
- `https://dynamicscrmna.accesscontrol.windows.net`
- `https://*.windows.net`
- `https://*.microsoftonline.com`
- `https://*.passport.net`
- `https://*.crm.dynamics.com`
- `https://*.crm.dynamics.com`
- `https://home.dynamics.com`
- `https://cloudredirectornam.cloudapp.net`
- `https://mem.gfx.ms`
- `https://cloudredirectornamsec.cloudapp.net`
- `https://*.azureedge.net`
- `https://www.crmdynint.com`
- `https://www.d365ccafpi.com/`

**South America-based organizations:**  

- `https://crl.microsoft.com/pki/crl/products/microsoftrootcert.crl`
- `https://mbs.microsoft.com`
- `https://go.microsoft.com`
- `https://login.microsoftonline-p.com`
- `https://secure.aadcdn.microsoftonline-p.com`
- `https://urs.microsoft.com`
- `https://auth.gfx.ms`
- `https://dynamicscrmsam.accesscontrol.windows.net`
- `https://*.windows.net`
- `https://*.microsoftonline.com`
- `https://*.passport.net`
- `https://*.crm2.dynamics.com`
- `https://*.crm2.dynamics.com`
- `https://home.dynamics.com`
- `https://cloudredirectorsam.cloudapp.net`
- `https://mem.gfx.ms`
- `https://cloudredirectorsamsec.cloudapp.net`
- `https://*.azureedge.net`
- `https://www.crmdynint.com`
- `https://www.d365ccafpi.com/`

**Europe, Africa, and Middle East-based organizations:**  

- `https://login.live.com`
- `https://crl.microsoft.com/pki/crl/products/microsoftrootcert.crl`
- `https://mbs.microsoft.com`
- `https://go.microsoft.com`
- `https://login.microsoftonline-p.com`
- `https://secure.aadcdn.microsoftonline-p.com`
- `https://urs.microsoft.com`
- `https://auth.gfx.ms`
- `https://dynamicscrmemea.accesscontrol.windows.net`
- `https://sc.imp.live.com`
- `https://*.windows.net`
- `https://*.microsoftonline.com`
- `https://*.passport.net`
- `https://*.crm4.dynamics.com`
- `https://*.crm4.dynamics.com`
- `https://home.dynamics.com`
- `https://cloudredirectoreur.cloudapp.net`
- `https://mem.gfx.ms`
- `https://cloudredirectoreursec.cloudapp.net`
- `https://*.azureedge.net`
- `https://www.crmdynint.com`
- `https://www.d365ccafpi.com/`

**Asia/Pacific area-based organizations:**  

- `https://login.live.com`
- `https://crl.microsoft.com/pki/crl/products/microsoftrootcert.crl`
- `https://mbs.microsoft.com`
- `https://go.microsoft.com`
- `https://login.microsoftonline-p.com`
- `https://secure.aadcdn.microsoftonline-p.com`
- `https://urs.microsoft.com`
- `https://auth.gfx.ms`
- `https://dynamicscrmapac.accesscontrol.windows.net`
- `https://sc.imp.live.com`
- `https://*.windows.net`
- `https://*.microsoftonline.com`
- `https://*.passport.net`
- `https://*.crm5.dynamics.com`
- `https://*.crm5.dynamics.com`
- `https://home.dynamics.com`
- `https://cloudredirectorapj.cloudapp.net`
- `https://mem.gfx.ms`
- `https://cloudredirectorapjsec.cloudapp.net`
- `https://*.azureedge.net`
- `https://www.crmdynint.com`
- `https://www.d365ccafpi.com/`

**Japan area-based organizations:**  

- `https://login.live.com`
- `https://crl.microsoft.com/pki/crl/products/microsoftrootcert.crl`
- `https://mbs.microsoft.com`
- `https://go.microsoft.com`
- `https://login.microsoftonline-p.com`
- `https://secure.aadcdn.microsoftonline-p.com`
- `https://urs.microsoft.com`
- `https://auth.gfx.ms`
- `https://dynamicscrmjpn.accesscontrol.windows.net`
- `https://sc.imp.live.com`
- `https://*.windows.net`
- `https://*.microsoftonline.com`
- `https://*.passport.net`
- `https://*.crm7.dynamics.com`
- `https://*.crm7.dynamics.com`
- `https://home.dynamics.com`
- `https://cloudredirectorjpn.cloudapp.net`
- `https://mem.gfx.ms`
- `https://cloudredirectorjpnsec.cloudapp.net`
- `https://*.azureedge.net`
- `https://www.crmdynint.com`
- `https://www.d365ccafpi.com/`

**India area-based organizations:**  

- `https://login.live.com`
- `https://crl.microsoft.com/pki/crl/products/microsoftrootcert.crl`
- `https://mbs.microsoft.com`
- `https://go.microsoft.com`
- `https://login.microsoftonline-p.com`
- `https://secure.aadcdn.microsoftonline-p.com`
- `https://urs.microsoft.com`
- `https://auth.gfx.ms`
- `https://dynamicscrmind.accesscontrol.windows.net`
- `https://sc.imp.live.com`
- `https://*.windows.net`
- `https://*.microsoftonline.com`
- `https://*.passport.net`
- `https://*.crm8.dynamics.com`
- `https://*.crm8.dynamics.com`
- `https://home.dynamics.com`
- `https://cloudredirectorind.cloudapp.net`
- `https://mem.gfx.ms`
- `https://cloudredirectorindsec.cloudapp.net`
- `https://*.azureedge.net`
- `https://www.crmdynint.com`
- `https://www.d365ccafpi.com/`

**Canada area-based organizations:**  

- `https://login.live.com`
- `https://crl.microsoft.com/pki/crl/products/microsoftrootcert.crl`
- `https://mbs.microsoft.com`
- `https://go.microsoft.com`
- `https://login.microsoftonline-p.com`
- `https://secure.aadcdn.microsoftonline-p.com`
- `https://urs.microsoft.com`
- `https://auth.gfx.ms`
- `https://dynamicscrmjpn.accesscontrol.windows.net`
- `https://sc.imp.live.com`
- `https://*.windows.net`
- `https://*.microsoftonline.com`
- `https://*.passport.net`
- `https://*.crm7.dynamics.com`
- `https://*.crm7.dynamics.com`
- `https://home.dynamics.com`
- `https://cloudredirectorjpn.cloudapp.net`
- `https://mem.gfx.ms`
- `https://cloudredirectorjpnsec.cloudapp.net`
- `https://*.azureedge.net`
- `https://www.crmdynint.com`
- `https://www.d365ccafpi.com/`

**Oceania area-based organizations:**  

- `https://login.live.com`
- `https://crl.microsoft.com/pki/crl/products/microsoftrootcert.crl`
- `https://mbs.microsoft.com`
- `https://go.microsoft.com`
- `https://login.microsoftonline-p.com`
- `https://secure.aadcdn.microsoftonline-p.com`
- `https://urs.microsoft.com`
- `https://auth.gfx.ms`
- `https://dynamicscrmjpn.accesscontrol.windows.net`
- `https://sc.imp.live.com`
- `https://*.windows.net`
- `https://*.microsoftonline.com`
- `https://*.passport.net`
- `https://*.crm7.dynamics.com`
- `https://*.crm7.dynamics.com`
- `https://home.dynamics.com`
- `https://cloudredirectorjpn.cloudapp.net`
- `https://mem.gfx.ms`
- `https://cloudredirectorjpnsec.cloudapp.net`
- `https://*.azureedge.net`
- `https://www.crmdynint.com`
- `https://www.d365ccafpi.com/`

**CRM US Government environments:******  

- `https://login.live.com`
- `https://crl.microsoft.com/pki/crl/products/microsoftrootcert.crl`
- `https://mbs.microsoft.com`
- `https://go.microsoft.com`
- `https://login.microsoftonline-p.com`
- `https://secure.aadcdn.microsoftonline-p.com`
- `https://urs.microsoft.com`
- `https://auth.gfx.ms`
- `https://dynamicscrmgcc.accesscontrol.usgovcloudapi.net`
- `https://sc.imp.live.com`
- `https://*.windows.net`
- `https://*.microsoftonline.com`
- `https://*.passport.net`
- `https://*.crm9.dynamics.com`
- `https://*.crm9.dynamics.com`
- `https://mem.gfx.ms`
- `https://home.dynamics.com`
- `https://*.azureedge.net`
- `https://www.crmdynint.com`
- `https://www.www.crmdynint-gcc.com`

**United Kingdom area-based organizations:**

- `https://login.live.com`
- `https://crl.microsoft.com/pki/crl/products/microsoftrootcert.crl`
- `https://mbs.microsoft.com`
- `https://go.microsoft.com`
- `https://login.microsoftonline-p.com`
- `https://secure.aadcdn.microsoftonline-p.com`
- `https://urs.microsoft.com`
- `https://auth.gfx.ms`
- `https://dynamicscrmgbr.accesscontrol.windows.net`
- `https://sc.imp.live.com`
- `https://*.windows.net`
- `https://*.microsoftonline.com`
- `https://*.passport.net`
- `https://*.crm11.dynamics.com`
- `https://*.crm11.dynamics.com`
- `https://home.dynamics.com`
- `https://cloudredirectoroce.cloudapp.net`
- `https://mem.gfx.ms`
- `https://cloudredirectorapjsec.cloudapp.net`
- `https://*.azureedge.net`
- `https://www.crmdynint.com`
- `https://www.d365ccafpi.com/`

If you still experience issues when you try to connect to your CRM Online organization, [About the Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant) is available to help diagnose connection issues that affect the CRM Online web application and also CRM for Outlook.

## More information

For a list of Required Accessible IP Address Ranges, visit [Microsoft Dynamics CRM Online IP Address Ranges](https://support.microsoft.com/help/2728473).

To view the Required URLs for Microsoft Dynamics CRM with Office 365, visit [Office 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges).
