---
title: Constrained delegation for CIFS fails with ACCESS_DENIED error
description: Fixes an access denied error that occurs when you access a service that uses network shares on a middle-tier server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# Constrained delegation for CIFS fails with ACCESS_DENIED error

This article helps fix an **access denied** error that occurs when you access a service that uses network shares on a middle-tier server.

_Applies to:_ &nbsp; Window 10 – all editions, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 2602377

## Symptoms

While accessing a service that uses network shares on a middle-tier server, users are prompted for credentials, and they eventually encounter an **access denied**  error.

## Example scenarios

Scenario 1

The user is prompted for credentials, and access eventually fails with an access denied error if the following conditions are true:

- The IIS website is set up with the home directory pointing to the remote share using pass-through authentication and constrained delegation configured for CIFS.
- The IIS application pool accessing that share is running under the identity of service account.
- The domain account is trusted for delegation for the cifs service on the file server.
- The file server and web server are running an operating system that's listed in the Applies To section.

Scenario 2  

- The web app is trying to access a file server as a user.
- The IIS application pool that accesses that share is running under the identity of service account. The domain account is trusted for delegation for the cifs service on the file server.
- Constrained delegation configured for CIFS is configured on the service account for the file server.
- The file server and web server types are listed in the Applies To section.

Scenario 3:  

- Any server-side application that's being accessed from a client is accessing remote shares as user.
- The server-side application is running under the context of a service account.
- The Service account is trusted for delegation and configured for CIFS delegation for the file server.
- The file server and web server types are listed in the Applies To section.

## Cause

This has been identified as a problem between MrxSmb 2.0 and Kerberos when constrained delegation is involved.

## Workaround

### Workaround 1

Use a machine account instead of a service account as the identity for applications that will be performing constrained delegation for CIFS. Configure constrained delegation when the domain functional level is Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2.

To do this on the domain controller for your web servers domain, follow these steps:

1. Click Start, click Administrative Tools, and then click Active Directory Users and Computers.
2. Expand domain, and then expand the Computers folder.
3. In the right pane, right-click the computer name for the web server, select Properties, and then click the Delegation tab.
4. Select the Trust this computer for delegation to specified services only check box.
5. Make sure that Use Kerberos only is selected, and then click OK.
6. Click the Add button. In the Add Services dialog box, click Users or Computers, and then browse to or enter the name of the file server that will receive the user's credentials from IIS. Click OK.
7. In the Available Services list, select the CIFS service. Click OK.

### Workaround 2

If you must use the identity of applications as a service account and/or domain account, use the following workaround.

> [!Note]
> This workaround is not recommended because it requires Use any authentication protocol delegation on the computer account. If the **Use any authentication protocol** option is selected, the account is using constrained delegation with protocol transition.

1. Click Start, click Administrative Tools, and then click Active Directory Users and Computers.
2. Expand domain, and then expand the Computers folder.
3. In the right pane, right-click the computer name for the web server, select Properties, and then click the Delegation tab.
4. Select the Trust this computer for delegation to specified services only check box.
5. Make sure that Use any authentication protocol is selected, and then click OK.
6. Click the Add button. In the Add Services dialog box, click Users or Computers, and then browse to or enter the name of the file server that will receive the users' credentials from IIS. Click OK.
7. In the Available Services list, select the CIFS service. Click OK.
8. In the left pane, expand the Users folder.
9. In the right pane, right-click the service account that's the identity of the application pool, select Properties, and then click the Delegation tab.
10. Select the Trust this computer for delegation to specified services only check box.
11. Make sure that Use Kerberos only is selected, and then click OK.
12. Click the Add button. In the Add Services dialog box, click Users or Computers, and then browse to or enter the name of the file server that will receive the users' credentials from IIS. Click OK.
13. In the Available Services list, select the CIFS service. Click OK.  
