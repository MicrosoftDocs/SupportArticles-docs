---
title: This page can't be displayed
description: Discusses that you receive a "This page cannot be displayed" error message when you try to access an application on a website that uses AD FS 2.0. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, fszita, maweeras, timccu, abizerh
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot
---
# ADFS 2.0 error: This page cannot be displayed

This article provides a solution to an error when you try to access an application on a website that uses AD FS 2.0.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3044971

## Summary

Most Active Directory Federated Services (AD FS) 2.0 problems belong to one of the following main categories. This article contains step-by-step instructions to troubleshoot connectivity problems.

- [ADFS 2.0 service fails to start (KB 3044971)](https://support.microsoft.com/help/3044971)
- [ADFS service problems (KB 3044973)](https://support.microsoft.com/help/3044973)
- [Certificate problems (KB 3044974)](https://support.microsoft.com/help/3044974)
- [Authentication problems (KB 3044976)](https://support.microsoft.com/help/3044976)
- [Claim rules problems (KB 3044977)](https://support.microsoft.com/help/3044977)

## Symptoms

- Symptom 1

    When you try to access a web application on a website that uses Active Directory Federation Services (AD FS) 2.0, you receive the following error message:

    > This page cannot be displayed.

- Symptom 2  

    You can't access the following IDP-initiated sign-on page and AD FS metadata:

    `https://ADFSServiceName/federationmetadata/2007-06/federationmetadata.xml`

    `https://ADFSServiceName/adfs/ls/idpinitiatedsignon.aspx`

## Resolution

To resolve this problem, follow these steps in the order. These steps will help you to determine the cause of the problem. Make sure that you check whether the problem is resolved after every step.

### Step 1: Check whether the client is redirected to the correct AD FS URL

- How to check

    1. Start Internet Explorer.
    2. Press F12 to open the developer tools window.
    3. On the **Network** tab, select the **start** button or press **Start capturing** to enable network traffic capturing.
    4. Browse to the URL of the web application.
    5. Examine the network traces to see that the client is redirected to the URL of the AD FS service for authentication. Make sure that the AD FS service URL is correct.

    In the following screenshot, the first URL is for the web application, and the second URL is for the AD FS service.

    :::image type="content" source="./media/this-page-cant-displayed/error-displays-ie-developer-tool.png" alt-text="The web application url and the A D F S service url listed in the developer tools." border="false":::

- How to fix

    If you're redirected to an incorrect address, you likely have incorrect AD FS federation settings in your web application. Check these settings to make sure that the AD FS federation service (SAML service provider) URL is correct.

### Step 2: Check whether the AD FS Service name can be resolved to the correct IP address

- How to check

  On a client computer and AD FS proxy server (if you've this), use a ping or nslookup command to determine whether the AD FS service name is resolved to the correct IP address. Use the following guidelines:

  - Intranet: The name should resolve to the Internal AD FS server IP or the load balanced IP of the AD FS server (Internal).
  - External: The name should resolve to the External/Public IP of the AD FS service. In this situation, the Public DNS is used to resolve the name. If you notice that different public IPs are returned from different computers for the same AD FS service name, the recent change in the Public DNS may not yet be propagated across all public DNS servers worldwide. Such a change may require up to 24 hours to be replicated.

    > [!IMPORTANT]
    > On all AD FS servers, make sure that the AD FS proxy servers can resolve the name of the AD FS service to the internal AD FS server IP or to the internal AD FS server's load-balanced IP. The best way to do this is to add an entry in the HOST file on the AD FS proxy server or to use a split DNS configuration in a perimeter network (also known as "DMZ," "demilitarized zone," and "screened subnet").

    Example of the nslookup command:

    ```console
    Nslookup sts.contoso.com
    ```  

    :::image type="content" source="./media/this-page-cant-displayed/nslookup-command-prompt.png" alt-text="The output returned after running the nslookup command." border="false":::

- How to fix

    Check the record for AD FS service name through the DNS server or Internet service provider (ISP). Make sure that the IP address is correct.

### Step 3: Check whether TCP port 443 on the AD FS server can be accessed

- How to check

    Use Telnet or [PortQryUI - User Interface for the PortQry Command Line Port Scanner](https://www.microsoft.com/download/details.aspx?id=24009) to query the connectivity of port 443 on the AD FS server. Make sure that 443 port is listening.

    :::image type="content" source="./media/this-page-cant-displayed/port-443-query-result.png" alt-text="The Port query result of checking the connectivity of port 443 on the A D F S server." border="false":::

- How to fix

    If the AD FS server isn't listening on 443 port, follow these steps:

    1. Make sure that the AD FS 2.0 Windows Service is started.
    2. Check the Windows firewall setting on the AD FS server to make sure that the TCP 433 port is allowed to make connections.
    3. If a load balancer is used ahead of the AD FS services, try to bypass the load-balancing process to verify that this isn't the cause of the issue. (Load balancing is a common cause.)

### Step 4: Check whether you can use an IdP-initiated sign-on page to authenticate to ADFS

- How to check

    Start Internet Explorer, and then browse to the following web address. If you receive a certificate warning when you try to open this page, select **Continue**.

    http://\<YourADFSServiceName>/adfs/ls/idpinitiatedsignon.aspx

    > [!NOTE]
    > In this URL, *\<YourADFSServiceName>* represents the actual AD FS service name.

    Typically, you access a sign-in screen, and then you can sign in by using your credentials.

    :::image type="content" source="./media/this-page-cant-displayed/sign-in-page.png" alt-text="Screenshot of the A D F S sign-in page." border="false":::

- How to fix

    If you can successfully do Step 1 through Step 3 but you still can't access the web application, follow these steps:

    1. Use another client computer and browser to do the tests. There may an issue that affects the client.
    2. Do the following advanced troubleshooting steps:
      1. Collect Fiddler Web Debugger trace and network capture information while you're accessing the `IDPInitiatedsignon` page. For more information, see [AD FS 2.0: How to Use Fiddler Web Debugger to Analyze a WS-Federation Passive Sign-In](https://social.technet.microsoft.com/wiki/contents/articles/3286.ad-fs-2-0-how-to-use-fiddler-web-debugger-to-analyze-a-ws-federation-passive-sign-in.aspx).
      2. Collect network traces from the client computer to check whether the SSL handshake completed successfully, whether there's an encrypted message, whether you're accessing the correct IP address, and so on. For more information, see [How to enable Schannel event logging in Windows and Windows Server](https://support.microsoft.com/help/260729).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
