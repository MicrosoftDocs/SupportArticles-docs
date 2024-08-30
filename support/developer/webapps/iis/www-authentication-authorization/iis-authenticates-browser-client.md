---
title: IIS authenticates browser clients
description: This article describes how IIS authenticates browser clients.
ms.date: 12/11/2020
ms.custom: sap:WWW Authentication and Authorization\Windows Authentication
ms.topic: how-to
---
# IIS authenticates browser clients

This article introduces how IIS authenticates browser clients.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 264921

## Summary

This article describes the different authentication methods that are available in IIS for Windows NT 4.0, Windows 2000 and later Windows versions. For a more complete description of the information that is discussed in this article, see the Windows NT 4.0 and Windows 2000 Resource Guides.

## Authentication methods that are available for Windows NT 4.0

Anonymous - No logon is required and anyone is allowed to gain access to data that is protected with this method. The server uses a built-in account (IUSR_[machine name] by default) to control the permissions on the files. The browser does not send any credentials or user info with this type of request.

- Browsers Supported: Any
- Limitations: None
- User Rights Required: The anonymous user account defined on the server must have **log on Locally** permissions.
- Encryption Type: None

Basic (Clear Text) - The server requests the user to log on and a dialog box appears in the browser that allows the user to enter the credentials that are needed. These credentials must match the user credentials defined on the files that the user is attempting to access.

- Browsers Supported: Any
- Limitations: Not secure. Passwords are easily deciphered.
- User Rights Required: The user account must have **log on Locally** permissions.
- Encryption Type: Base 64 Encoding (not true encryption)

Windows NT Challenge/Response - The server requests the user to log on. If the browser supports Windows NT Challenge/Response, it automatically sends the user's credentials if the user is logged on. If the domain that the user is on is different than the server's domain, or if the user is not logged on, a dialog box appears to request the credentials to send. Windows NT Challenge/Response uses an algorithm to generate a hash based on the user's credentials and the computer that the user is using. It then sends this hash to the server. The browser does not send the user's password across to the server.

- Browsers Supported: Internet Explorer versions 3.01 and later
- Limitations: Requires point-to-point connection. Usually, a circuit is closed after a "401 unauthorized " error message; however, when negotiating a Windows NT Challenge/Response authentication sequence (which requires multiple round trips), the server keeps the circuit open for the duration of the sequence after the client has indicated that it will use Windows NT Challenge/Response. CERN proxies and certain other Internet devices prevent this from working. Also, Windows NT Challenge/Response does not support double-hop impersonations (in that once passed to the IIS server, the same credentials cannot be passed to a back-end server for authentication).

- User Rights Required: The user account that is accessing the server must have "Access this computer from the network" permissions.
- Encryption Type: NTLM Hash algorithm that is also unencoded.

*Orders of precedence:* When the browser makes a request, it always considers the first request to be Anonymous. Therefore, it does not send any credentials. If the server does not accept Anonymous OR if the Anonymous user account set on the server does not have permissions to the file being requested, the IIS server responds with an **Access Denied** error message and sends a list of the authentication types that are supported by using one of the following scenarios:

- If Windows NT Challenge/Response is the only supported method (or if Anonymous fails), then the browser must support this method to communicate with the server. Otherwise, it cannot negotiate with the server and the user receives an **Access Denied** error message.
- If Basic is the only supported method (or if Anonymous fails), then a dialog box appears in the browser to get the credentials, and then passes these credentials to the server. It attempts to send these credentials up to three times. If these all fail, the browser is not connected to the server.
- If both Basic and Windows NT Challenge/Response are supported, the browser determines which method is used. If the browser supports Windows NT Challenge/Response, it uses this method and does not fall back to Basic. If Windows NT Challenge/Response is not supported, the browser uses Basic.

> [!NOTE]
> - When your browser establishes a connection with a Web site by using `Basic` or `NTLM` authentication, it does not fall back to Anonymous during the rest of that session with the server. If you try to connect to a Web page that is marked for Anonymous only after authenticating, you will be denied. (This may or may not hold true for Netscape).
> - When Internet Explorer has established a connection with the server by using `Basic` or `NTLM` authentication, it passes the credentials for every new request for the duration of the session.

## Authentication methods that are available for Windows 2000 and above

Anonymous - No logon is required and anyone is allowed to gain access to data protected with this method. The server uses a built-in account (IUSR_[machine name] by default) to control the permissions on the files. The browser does not send any credentials or user info with this type of request.

- Browsers Supported: Any
- Limitations: None
- User Rights Required: The Anonymous user account defined on the server must have "logon Locally" permissions.
- Encryption Type: None

Basic (Clear Text) - The server requests the user to log on and a dialog box appears in the browser that allows the user to enter the credentials that are needed. These credentials must match the user credentials defined on the files that the user is attempting to access.

- Browsers Supported: Any
- Limitations: Not secure. Passwords are easily deciphered.
- User Rights Required: The user account must have **log on Locally** rights
- Encryption Type: Base 64 Encoding (not true encryption)

Digest - The server requests the user to log on and also sends a NONCE used to encrypt the password. The browser uses the NONCE to encrypt the password and sends this to the server. The server then encrypts its own copy of the user's password and compares the two. If they match and the user has permissions, access is granted.

- Browsers Supported: Internet Explorer 5 and later versions
- Limitations: Not as secure as Integrated. Requires the server to have access to an Active Directory Server that is set up for Digest Authentication.
- User Rights Required: Requires passwords to have "Save password as encrypted Clear Text"
- Encryption Type: Based on NONCE sent by server.

Windows Integrated (split into two sub categories)

Kerberos - The server requests a user to log on. If the browser supports Kerberos, the following takes place:

- IIS requests authentication.
- If the client has not logged on to a domain, a dialog box appears in Internet Explorer requesting credentials, and then contacts the KDC to request and receive a Ticket Granting Ticket. It then sends the Ticket Granting Ticket along with information about the IIS server to the KDC.
- If the IE Client has already successfully logged into the domain and received a Ticket Granting Ticket, it sends this ticket along with info about the IIS server to the KDC
- The KDC issues the client a Resource Ticket.
- The Client passes this ticket to the IIS server.

Kerberos uses tickets generated at a Ticket Granting Server (KDC) to authenticate. It sends this ticket to the IIS server. The browser does NOT send the user's password across to the server.

- Browsers Supported: Internet Explorer versions 5.0 and above
- Limitations: the server must have access to an Active Directory server. Both the server and the client must have a trusted connection to a KDC.
- User Rights Required: The Anonymous user account defined on the server must have **log on Locally** permissions.
- Encryption type: Encrypted ticket.

Windows NT Challenge/Response - The server requests the user to log on. If the browser supports Windows NT Challenge/Response, it automatically sends the user's credentials if the user is logged on. If the domain that the user is on is different than the server's domain, or if the user is not logged on, a dialog box appears in Internet Explorer requesting the credentials to send. Windows NT Challenge/Response uses an algorithm to generate a hash based on the user's credentials and the computer that the user is using. It then sends this hash to the server. The browser does not send the user's password across to the server.

- Browsers Supported: Internet Explorer versions 3.01 and later.
- Limitations: Requires point-to-point connection. Typically, a circuit is closed after a "401 unauthorized " error message; however, when negotiating a Windows NT Challenge/Response authentication sequence (which requires multiple round trips), the server keeps the circuit open for the duration of the sequence after the client has indicated that it will use Windows NT Challenge/Response. CERN proxies and certain other Internet devices prevent this from working. Also, Windows NT Challenge/Response does not support double-hop impersonations (meaning that once passed to the IIS server, the same credentials cannot be passed to a back-end server for authentication, for example, when IIS uses Windows NT Challenge/Response, it cannot then authenticate the user against a SQL Server database on another computer by using SQL Integrated security).
- User Rights Required: The user account accessing the server must have "Access this computer from the network" permissions.
- Encryption Type: NTLM Hash algorithm that is also unencoded.

*Orders of precedence:* When the browser makes a request, it always considers the first request to be Anonymous. Therefore, it does not send any credentials. If the server does not accept Anonymous or if the Anonymous user account set on the server does not have permissions to the file being requested, the IIS server responds with an **Access Denied** error message and sends a list of the authentication types that are supported by using one of the following scenarios:

- If Windows Integrated is the only supported method (or if Anonymous fails), then the browser must support this method to communicate with the server. If this fails, the server does not try any of the other methods.
- If Basic is the only supported method (or if Anonymous fails), then a dialog box appears in the to get the credentials, and then passes these to the server. It attempts to send the credentials up to three times. If these all fail, the browser does not connect to the server.
- If both Basic and Windows Integrated are supported, the browser determines which method is used. If the browser supports Kerberos or Windows NT Challenge/Response, it uses this method. It does not fall back to Basic. If Windows NT Challenge/Response and Kerberos are not supported, the browser uses Basic, Digest, or Fortezza if it supports these. The order of precedence here is Basic, Digest, and then Fortezza.

> [!NOTE]
> - When your browser establishes a connection with a Web site by using Basic or Windows Integrated authentication, it does not fall back to Anonymous during the rest of that session with the server. If you try to connect to a Web page that is marked for Anonymous only after authenticating, you are denied. (This may or may not hold true for Netscape).
> - When Internet Explorer has established a connection with the server by using an authentication method other than Anonymous, it automatically passes the credentials for every new request during the duration of the session.

## References

For more information about how to configure IIS Web site authentication in Windows Server 2003, see [How to configure IIS Web site authentication in Windows Server 2003](https://support.microsoft.com/help/324274).  
