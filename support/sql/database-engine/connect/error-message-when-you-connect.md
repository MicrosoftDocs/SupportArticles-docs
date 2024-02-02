---
title: Error message when you connect to SQL Server 
description: This article provides resolutions for the problem that occurs when you connect to SQL Server using SSL.
ms.date: 06/20/2022
ms.custom: sap:Connection issues
ms.reviewer: kayokon, masank
---
# "The certificate received from the remote server was issued by an untrusted certificate authority" error when you connect to SQL Server

This article helps you resolve the problem that occurs when you try to make an encrypted connection to SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2007728

## Symptoms

When connecting to SQL Server, you may receive the following error message:

> A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - The certificate chain was issued by an authority that is not trusted.) (.Net SqlClient Data Provider)

Additionally, the following error message is logged in the Windows System event log.

```output
Log Name:      System  
Source:        Schannel  
Date:          10/13/2020 3:03:31 PM  
Event ID:      36882  
Task Category: None  
Level:         Error  
Keywords:  
User:        USERNAME  
Computer:     COMPUTERNAME  
Description:  
The certificate received from the remote server was issued by an untrusted certificate authority. Because of this, none of the data contained in the certificate can be validated. The TLS connection request has failed. The attached data contains the server certificate.
```

## Cause

This error occurs when you try to make an encrypted connection to SQL Server using a non-verifiable certificate. This could happen in the following scenarios:

|Scenario|Server-side encryption|Client-side encryption  |Certificate type |Certificate issuing authority present in Trusted Root Certification Authorities store |
|---|---|---|---|---|
|1|Yes|No|You provision a certificate from a non-trusted source (the certificate issuing authority isn't listed as a trusted authority in Trusted Root Certification Authorities on the client machine) |No|
|2|Off|Yes|SQL Server self-generated certificate |Self-signed certificates don't show up in this store. |
  
When establishing encrypted connections to SQL Server, Secure Channel (Schannel) creates the list of trusted certificate authorities by searching the Trusted Root Certification Authorities store on the local computer. During the TLS handshake, the server sends its public key certificate to the client. The issuer of a public key certificate is known as a Certificate Authority (CA). The client has to ensure that the certificate authority is one that the client trusts. This is achieved by knowing the public key of trusted CAs in advance. When Schannel detects a certificate that was issued by an untrusted certification authority, such as in the previous two cases, you get the error message listed in the [Symptoms](#symptoms) section.

## Resolution

If you intentionally use either a certificate from a non-trusted authority or a self-signed certificate to encrypt connections to SQL Server, you can use one of the following options:

For scenario 1, add the certificate authority to the Trusted Root Certification Authorities store on the client computer initiating encrypted connection. To do this, complete the [Export the server certificate](#export-the-server-certificate) and [Install the root certificate authority (CA) on the client machine](#install-the-root-certificate-authority-ca-on-the-client-machine) procedures listed in the next few sections in that sequence.

### Export the server certificate

The example uses a file named _caCert.cer_ as a certificate file. You must obtain this certificate file from the server. The following steps explain how to export the server certificate to a file:

1. Click **Start** and then **Run**, and type _MMC_. (MMC is an acronym for the Microsoft Management Console.)

1. In MMC, open the **Certificates**.

1. Expand **Personal** and then **Certificates**.

1. Right-click the server certificate, and then select **All Tasks->Export**.

1. Click **Next** to move past the **welcome dialog** box of the **Certificate Export** Wizard.

1. Confirm that **No, do not export the private key** is selected, and then select **Next**.

1. Make sure that either **DER encoded binary X.509 (.CER)** or **Base-64 encoded X.509 (.CER)** is selected, and then click **Next**.

1. Enter an export file name.

1. Click **Next**, and then click **Finish** to export the certificate.

#### Install the root certificate authority (CA) on the client machine

1. Start the Certificates snap-in for MMC on the client computer and then add the Certificates snap-in.

1. In the **Certificates snap-in** dialog box, select **Computer** account, and then select **Next**.

1. In the **Select Computer** pane, select **Local computer: (the computer this console is running on)**, and then select **Finish**.

1. Choose **OK** to close the **Add or Remove Snap-ins** dialog box.

1. In the left pane of MMC, expand the **Certificates (Local Computer)** node.

1. Expand the **Trusted Root Certification Authorities** node, right-click the **Certificates** subfolder, select **All Tasks**, and then select **Import**.

1. In the **Certificate Import Wizard**, on the **Welcome page**, select **Next**.

1. On the **File to Import** page, select **Browse**.

1. Browse to the location of the *caCert.cer* certificate file, select the file, and then select **Open**.

1. On the **File to Import** page, select **Next**.

1. On the **Certificate Store** page, accept the default selection, and then select **Next**.

1. On the **Completing the Certificate Import Wizard** page, select **Finish**.

For scenarios 1 and 2, set **Trust Server Certificate** setting to _true_ in your client application.

For more information on how to do this, see the following topics:

- [Using Encryption Without Validation in SQL Server Native Client](/sql/relational-databases/native-client/features/using-encryption-without-validation)

- [Connecting with encryption using Microsoft JDBC driver for SQL Server](/sql/connect/jdbc/connecting-with-ssl-encryption)

- [Using Encryption with Sqlclient](/sql/connect/ado-net/sql/sqlclient-support-always-encrypted)

> [!NOTE]
> If you are using SQL Server Management Studio, select the **Options** tab, and select the **Trust Server certificate** option in the **Connection Properties** tab.

**Caution:** SSL connections that are encrypted by using a self-signed certificate don't provide strong security. They are susceptible to `man-in-the-middle` attacks. You shouldn't rely on SSL using self-signed certificates in a production environment or on servers that are connected to the Internet.

If the configuration discussed in the previous sections of this article is unintended, you can use one of the following options to resolve this problem:

- Configure database engine to use encryption as per the procedure in Enable encrypted connections to the Database Engine.

- If encryption isn't required:

  - Disable encryption settings (if any) in your client application.

  - Disable server-side encryption using SQL Server Configuration manager. For more information on how to do this, see [Configure Server](/sql/relational-databases/sql-server-configuration-manager#manage-server--client-network-protocols).
