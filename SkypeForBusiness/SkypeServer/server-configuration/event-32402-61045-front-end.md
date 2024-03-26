---
title: Event IDs 32402, 61045 are logged in Lync Server 2013 Front End servers
description: Discusses that Event IDs 32402, 61045 are logged in Lync Server 2013 Front End servers that are installed in Windows Server 2012 R2. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2013
ms.date: 03/31/2022
---

# Event IDs 32402, 61045 are logged in Lync Server 2013 Front End servers that are installed in Windows Server 2012 R2

## Symptoms

Event IDs 32402, 61045 are logged in Microsoft Lync Server 2013 Front End servers that are installed on computers that are running Windows Server 2012 R2. 

Additionally, you experience the following symptoms:

- Microsoft Lync 2013, Microsoft Lync 2010, or Microsoft Office Communicator 2007 R2 clients cannot participate in conferences by using the Lync Server 2013 or Lync Server 2010 conference modalities.   
- Lync 2013, Lync 2010, or Office Communicator 2007 R2 clients that are not enabled for the Microsoft Exchange 2013 Unified Contact Store (UCS) do not display contact information.   
When this problem occurs, the following events are logged in the Lync Server 2013 event log:

### Event ID 32042

```AsciiDoc
Log Name: Lync Server
Source: LS User Services
Date: 10/15/2013 4:02:05 AM
Event ID: 32042
Task Category: (1006)
Level: Error
Keywords: Classic
User: N/A
Computer: LyncFE01.contoso.local
Description:
Invalid incoming HTTPS certificate.
Subject Name: LyncFE01.contoso.local Issuer: Contoso-CA

Cause: This can happen if the HTTPS certificate has expired, or is untrusted. The certificate serial number is attached for reference.

Resolution: Please check the remote server and ensure that the certificate is valid. Also ensure that the full certificate chain of the Issuer is present in the local machine.
```

### Event 61045

```AsciiDoc
Log Name: Lync Server
Source: LS MCU Infrastructure
Date: 10/15/2013 4:02:20 AM
Event ID: 61045
Task Category: (1022)
Level: Error
Keywords: Classic
User: N/A
Computer: LyncFE01.contoso.local
Description: The DATAMCU was not able to stay connected to the Front End over the C3P channel (HTTPS Connection).
The Web Conferencing Server failed to send C3P notifications to the focus at https:// LyncFE01.contoso.local:444/LiveServer/Focus. 

Cause: The Front End may not be running correctly or may be unreachable over the network (broken HTTPS connection) from the MCU. Unavailability of The C3P channel affects conference controls, and can also prevent users from joining, starting conferences.

Resolution: Verify that the Front End server is running correctly and that network connectivity and an HTTPS Connection can be established between the MCU and the Front End server.
```

## Cause

This problem may occur when Lync Server 2013 Front End servers are installed in Windows Server 2012 R2 because of changes that were made to how TLS sessions are cached in Windows Server 2012 R2. These changes cause some Lync Server 2013 servers that involve inter-server or intra-server communication over TCP port 444 to fail.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs.

To work around this problem, set the **Schannel** registry key to a value of 0x0002 on all computers that are hosting Lync Server 2013 Front End servers. This change disables Session Ticket TLS Optimization in the system.

> [!NOTE]
> - You can disable this value without compromising the security of the system. The system will revert to handling TLS sessions exactly like the sessions were negotiated in earlier Windows Server operating systems.    
> - Lync Server 2013 is supported by Windows Server 2012 R2 when this registry workaround is performed.   

1. Click Start, type regedit in the **Start** search box, and then click **regedit.exe** in the results list.   
2. Locate the following registry subkey: 

    **HKLM\System\CurrentControlSet\Control\SecurityProviders\Schannel**
1. Right-click **Schannel**, and then click **New DWORD (32-bit) value**.   
1. Type EnableSessionTicket, then press Enter.   
1. Right-click **EnableSessionTicket**, and then click **Modify**.   
1. Change the existing value to 2, and then press Enter.   
1. Exit Registry editor.   
1. Open the Lync Server Management Shell.   
1. Run the following Lync Server PowerShell commands in the given order: 

    ```powershell
    Stop-CsWindowsService
    
    Start-CsWindowsService    
    ```

## More Information

For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: 

[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows XP

For more information about how to disable TLS session ticket optimization in Server 2012 R2, see the following Microsoft TechNet topic:

[Release Notes: Important Issues in Windows Server 2012 R2 Preview](/previous-versions/orphan-topics/ws.11/dn303413(v=ws.11))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).