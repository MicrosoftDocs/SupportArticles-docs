---
title: Diagnosing failures with remote administration
description: This article lists the failure messages you see while using RemoteMgr. 
ms.date: 02/14/2008
ms.reviewer: nitashv, sudixi, v-jayaramanp
---

# Diagnosing failures with remote administration

## Introduction

This article helps you check and fix failures found while using RemoteMgr. This is based on frequently asked questions on the iis.net forums.

## Can't connect to the remote server?

Make sure the client and the server are using the same build. For example, a Server Beta 3 RemoteMgr will not work with an RC1 server build.

There might be a problem related to the access control lists (ACLs).

Review the Event Viewer (*eventvwr.msc*) log. Events are logged with detailed error messages and a stack trace. Looking at the Event Viewer often tells you what the problem might be.

## Can't connect to the remote server after updating WMSvc bindings?

If this happens after updating the port on which Web Management Service (WMSvc) is configured to run, check if the firewall is turned ON for the server. If it's ON, add a new exception rule for the port on which WMSvc is running (default value: 8172). Then, try connecting to the server again.

If this doesn't solve the problem, run the following command:

```Console
netsh http show sslcert
```

Make sure that the port 8172 (the one on which WMSvc is running) has SSL certificate bindings. Also make sure the cert hash matches the one to which WMSvc is bound to (in the Management Service UI).

Here's a sample output:

```output
c:\>netsh http show sslcert 
SSL Certificate bindings:
-------------------------
IP:port                 : 0.0.0.0:8172
Certificate Hash        : f06ae62a5275a818338f05ecc80707335be1e204
Application ID          : {00000000-0000-0000-0000-000000000000}
Certificate Store Name: MY
Verify Client Certificate Revocation    : Enabled
Verify Revocation Using Cached Client Certificate Only: Disabled
Usage Check    : Enabled
Revocation Freshness Time: 0
URL Retrieval Timeout   : 0
Ctl Identifier          : (null)
Ctl Store Name          : (null)
DS Mapper Usage    : Disabled
Negotiate Client Certificate    : Disabled
```

Then run the following command:

```Console
netsh http show urlacl
```

Make sure that the URL `https://*:8172/` (the port on which WMSvc is configured to run) appears in the list of reserved URLs.  
  
Here's a sample output:

```output
c:\>netsh http show urlacl

URL Reservations:
-----------------
Reserved URL            : https://*:8172/
User: NT SERVICE\WMSvc
Listen: Yes
Delegate: No
SDDL: D:(A;;GX;;;S-1-5-80-257763619-1023834443-750927789-3464696139-1457670516)
```

Use `netsh` commands mentioned in the previous paragraph to determine if the bindings aren't correctly configured. The problem might be that the machine key doesn't have permissions for the administrator who is trying to adjust the WMSvc bindings. In that case, try the following steps:

1. Take ownership of the machine key:  

   ```Console
   takeown /F %ProgramData%\Microsoft\Crypto\RSA\MachineKeys\bedbf0b4da5f8061b6444baedf4c00b1* /R
   ```

1. Configure the ACLs of the machine key such that the administrator group has read permissions:  

    ```Console
    icacls %ProgramData%\Microsoft\Crypto\RSA\MachineKeys\bedbf0b4da5f8061b6444baedf4c00b1* /grant Administrators:(R)
    ```

1. Reserve the port 8172 for WMSvc.

    ```Console
    netsh http add urlacl url=https://*:8172/ User="NT SERVICE\wmsvc"
    ```

1. Associate the cert with the port:  

    ```Console
    netsh http add sslcert ipport=0.0.0.0:8172 certhash=<certHash> appid={d7d72267-fcf9-4424-9eec-7e1d8dcec9a9}
    ```

## Don't want to see the prompt on the client every time you connect to the remote server?

Make sure the server uses a trusted root certificate for WMSvc. Create a trusted root certificate (if you don't have it already) and on the Management Service feature page, assign this certificate to be used by the service. This ensures that the client doesn't receive a message prompting if the server can be trusted (since the certificate isn't trusted).

## Additional help

If the previous resolutions don't help, capture the exception and call stack using the following steps. Then post the issue on the [IIS.NET forums](https://forums.iis.net/) and include the *eventvwr.msc* log along with exception and call stack.

Here are steps on how to get the exception and call stack:

1. Attach `windbg` to *wmsvc.exe*.

    ```Console
    windbg -pn wmsvc.exe
    ```

1. Load the *sos.dll* and set a break point if a managed exception happens.

    ```Console
    .loadby sos mscorwks
    sxe clr
    ```

1. Type `g`.

    ```Console
    g
    ```

1. When the exception breaks, print the exception and the call stack and send it to iis.net forums.

    ```Console
    !pe
    !clrstack
    ```
