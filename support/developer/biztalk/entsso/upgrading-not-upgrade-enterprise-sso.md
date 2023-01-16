---
title: Upgrading does not upgrade Enterprise SSO
description: This article provides a resolution for the problem where performing an in-place upgrade from BizTalk 2009 or 2010 to BizTalk 2013 does not upgrade Enterprise Single Sign On on the same machine.
ms.date: 09/28/2020
ms.custom: sap:ENTSSO
---
# Upgrading to BizTalk Server 2013 does not upgrade Enterprise SSO

This article helps you resolve the problem where performing an in-place upgrade from BizTalk 2009 or 2010 to BizTalk 2013 does not upgrade Enterprise Single Sign On (SSO) on the same machine.

_Original product version:_ &nbsp; BizTalk Server 2013 Branch, BizTalk Server 2013 Developer, BizTalk Server 2013 Enterprise, BizTalk Server 2013 Standard  
_Original KB number:_ &nbsp; 2908466

## Symptoms

When you perform an in-place upgrade from Microsoft BizTalk Server 2009 or BizTalk Server 2010 to BizTalk Server 2013, Enterprise SSO is not upgraded on the same computer.

If this issue results in the SSO Master Secret Server not being upgraded, attempts to upgrade other BizTalk servers in the group will fail, and you will receive the following error:

> Please upgrade your master secret server

Also, any component of BizTalk Server that references Microsoft.BizTalk.Interop.SSOClient.dll can fail with the following error:

> Could not load file or assembly 'Microsoft.BizTalk.Interop.SSOClient, Version=7.0.2300.0

## Cause

An in-place upgrade to Biztalk Server 2013 does not upgrade Enterprise SSO on the same computer.

## Resolution

To resolve this issue, manually upgrade Enterprise SSO. To do this, follow these steps:

1. Verify that the current master secret key is backed up to a secure location.
2. Verify that a current version of the SSO database is backed up to a secure location.
3. Run the Enterprise SSO Setup.exe file from the BizTalk Server 2013 installation media:

   - For 32-bit computers, use the Setup.exe file at `\Platform\SSO`.
   - For 64-bit computers, use the Setup.exe file at `\Platform\SSO64`.

4. In the **Autorun** dialog box, select **Microsoft Enterprise Single Sign-On**.
5. In the **Summary** dialog box, select **Upgrade**.

## More information

To determine the version of SSO on the computer, check the **Server** and **Administration** values at the following registry location. The correct value for a BizTalk Server 2013 environment is **9.0.1865.0**.

`HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\ENTSSO`

The assembly Microsoft.BizTalk.Interop.SSOClient.dll file can also be used to verify the version of SSO. The default location for this assembly is `C:\Program Files\Common Files\Enterprise Single Sign-On`. In a correctly upgraded BizTalk 2013 environment, the file version will be 9.0.1865.0 and the .NET version will be 7.0.2300.0.
