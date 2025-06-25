---
title: Access edge services can't negotiate TLS connection
description: The America Online (AOL) Public Internet Connectivity (PIC) provider clients are unable establish connections with an on premise Lync Server network that is configured to federate with AOL as a public provider. The AOL PIC provider does not support the use of AES cypher suites for the TLS connections with their federated partners and expects to use the legacy TLS_RSA_WITH_RC4_128_MD5 cipher suite for its secure TLS connectivity across the Internet.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: premgan
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2010 Enterprise Edition
  - Lync Server 2010 Standard Edition
  - Lync Server 2013
ms.date: 03/31/2022
---

# Lync Server access edge services cannot negotiate a TLS connection with the AOL federated client

## Symptoms

The America Online (AOL) Public Internet Connectivity (PIC) provider clients are unable establish connections with an on premise Lync Server network that is configured to federate with AOL as a public provider. This issue can occur under the following circumstances:

- The remote federated client is located on the America Online (AOL) network   
- The Lync Server Access Edge service is hosted on the Windows Server 2008 operating system   

## Cause

The Windows Server 2008 operating system (OS) provides an enhanced list of Advanced Encryption Standard (AES) cypher suites for using HTTPS and TLS client connections. These connections are for network services that require secure connectivity. The new AES cypher suites are used by the Windows Server 2008 OS with priority compared to the legacy cypher suites as per our commitment to better security standards for the Internet. The AOL PIC provider does not support the use of AES cypher suites for the TLS connections with their federated partners and expects the use of the legacy TLS_RSA_WITH_RC4_128_MD5 cipher suite for its secure TLS connectivity across the Internet.

For more information about Windows Server 2008 and its implementation of AES, review the following Microsoft TechNet documentation:

[TLS/SSL Cryptographic Enhancements](/previous-versions/windows/it-pro/windows-vista/cc766285(v=ws.10))

## Workaround

The following steps provide a workaround for the issue that is described in the Symptoms section of this KB article.

> [!NOTE]
> The workaround that is listed here is to address just the issue that is described in the Symptoms and Cause sections. Other connectivity issues with the AOL PIC can display symptoms that resemble the one this KB article contains.

Follow these steps to configure the Windows Server 2008 server that is hosting the Lync Server Edge Server Access Edge service to prioritize the use of the TLS_RSA_WITH_RC4_128_MD5 cypher suite by using the server computer's local Group Policy. These steps will make sure that the correct cypher suite is used for TLS connections with remote AOL PIC provider's access edge service.

From the console of the Windows Server 2008 server that is hosting the Lync Server Edge Server Access Edge service:

1. Click **Start**.   
2. Type gpedit.msc into the **Search** window.   
3. Right-click the gpedit icon in the **Search** details pane, and then select **Run as administrator**, to open an instance of the **Local Group Policy Editor** with local administrative permissions.   
4. Expand the **Computer Configuration** node that is listed under the **Local Computer Policy.**   
5. Expand the **Administrative Templates** node, and then expand the **Network** node.   
6. Locate and select the **SSL Configuration Settings** node.   
7. Right-click the **SSL Cypher Suite** **Order** policy in the details pane of the **Local Group Policy Editor**, and then chose **Edit** from the pop-up menu.   
8. Select the **Enabled** option on the **SSL Cipher Suite Order** dialog box.   
9. In the window that is labeled **SSL Cypher Suites:**, right-click, and then select **Select all** from the pop-up menu.   
10. Right-click the selected text in the **SSL Cypher Suites:** window, and then select **copy** from the pop-up menu.   
11. Paste the list of SSL cypher suites into an open text document. For example, the notepad.exe Text Editor

    > [!NOTE]
    > The SSL cypher suite information is in a comma delimited format. Each cypher suite entry will end with a comma (,) to the right side of it. You must make sure that the SSL cypher suite list remains in a strict comma delimited format.

12. Locate the TLS_RSA_WITH_RC4_128_MD5 entry within the text document and use the cut and paste features of the Text Editor to move the TLS_RSA_WITH_RC4_128_MD5 entry to the beginning of the SSL cypher suites list. Make sure that the TLS_RSA_WITH_RC4_128_MD5 entry is followed with a comma, and that any additional commas are removed from the list.

    > [!NOTE]
    > If the TLS_RSA_WITH_RC4_128_MD5 cypher suite is listed within the first five cypher suite(s) descriptors in the list then this is not the cause of your TLS connectivity issue with the AOL PIC.

13. Use the Text Editor to select the edited SSL cypher suite list, and then copy it to the **Windows clipboard**.   
14. Paste the contents of the Windows clipboard (the edited SSL cypher suite list) completely over the existing information that is in the **SSL Cypher Suites:** window. This replaces the pre-existing SSL cypher suite information by using the updated SSL cypher suite list that will begin with TLS_RSA_WITH_RC4_128_MD5.   
15. Make sure that the **Enabled** option is selected for the SSL Cypher Suite policy, and then click the **OK** button.   
16. This policy update requires a restart of the Windows Server 2008 server that is hosting the Lync Server Edge Server Access Edge service.   

## More Information

For more information about the certificate configuration that is required for the AOL PIC, review documentations listed here:

[Set up certificates for the external edge interface for Lync Server 2013](/previous-versions/office/lync-server-2013/lync-server-2013-set-up-certificates-for-the-external-edge-interface)

For more information about how Windows Server 2012 manages SSL and TLS cypher suite negotiation, review the Microsoft TechNet documentation listed here:

[What's New in TLS/SSL (Schannel SSP) in Windows Server and Windows](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831771(v=ws.11))

For more information about how Windows Server computers and Windows client computers manage SSL and TLS cypher suites, review the Microsoft TechNet documentation listed here:

[245030](https://support.microsoft.com/help/245030) How to restrict the use of certain cryptographic algorithms and protocols in Schannel.dll

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
