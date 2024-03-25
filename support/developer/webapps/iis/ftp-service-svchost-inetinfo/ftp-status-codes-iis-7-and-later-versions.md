---
title: The FTP status codes in IIS 7.0 and later versions
description: This article describes the FTP status codes in IIS 7.0.
ms.date: 12/11/2020
ms.custom: sap:FTP Service and Svchost or Inetinfo Process Operation
ms.reviewer: mlaing
ms.subservice: ftp-service-svchost-inetinfo
---
# The FTP status codes in IIS 7.0 and later versions

This article introduces the FTP status codes in IIS 7.0.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 969061

## Introduction

When you try to access content on a server that is running Internet Information Services (IIS) 7.0 or later versions by using FTP, IIS returns a numeric code that indicates the status of the response. The FTP status code and the FTP substatus code are recorded in the FTP log.

The FTP status and substatus code may indicate whether a request is successful or unsuccessful. The FTP status and substatus code may also reveal the exact reason that a request is unsuccessful.

> [!NOTE]
> This article applies to FTP on IIS 7.0 and later versions, but not for FTP 6 on IIS 7.0.

## Log file locations

By default, IIS puts log files in the following folder: `%SystemDrive%\Inetpub\Logs\Logfiles`
This folder contains separate directories for each FTP Site. By default, the log files are created in the directories daily, and the log files are named by using the date. For example, a log file may be named as: u_ex**YYMMDD**.log

## The FTP status codes

This section describes the FTP status codes that IIS uses.

> [!NOTE]
> This article does not list every possible FTP status code as dictated in the FTP specification. This article includes only the FTP status codes that IIS can send.

### 1**xx** - Positive preliminary reply

These status codes indicate that an action has started successfully, but the client expects another reply before it continues with a new command.

- 110 - Restart marker reply.
- 120 - Service ready in nnn minutes.
- 125 - Data connection already open; transfer starting.
- 150 - File status okay; about to open data connection.

### 2**xx** - Positive completion reply

An action has successfully completed. The client can execute a new command.

- 200 - Command okay.
- 202 - Command not implemented, superfluous at this site.
- 211 - System status, or system help reply.
- 212 - Directory status.
- 213 - File status.
- 214 - Help message.
- 215 - NAME system type, where NAME is an official system name from the list in the Assigned Numbers document.
- 220 - Service ready for new user.
- 221 - Service closing control connection. Logged out if appropriate.
- 225 - Data connection open; no transfer in progress.
- 226 - Closing data connection. Requested file action successful (for example, file transfer or file abort).
- 227 - Entering Passive Mode (h1,h2,h3,h4,p1,p2).
- 229 - Extended passive mode entered.
- 230 - User logged in, proceed.
- 232 - User logged in, authorized by security data exchange.
- 234 - Security data exchange complete.
- 235 - Security data exchange completed successfully.
- 250 - Requested file action okay, completed.
- 257 - "PATHNAME" created.

### 3**xx** - Positive intermediate reply

The command was successful, but the server needs additional information from the client to complete processing the request.

- 331 - User name okay, need password.
- 332 - Need account for login.
- 334 - Requested security mechanism ok.
- 335 - Security data is acceptable. More data is required to complete the security data exchange.
- 336 - Username okay, need password.
- 350 - Requested file action pending further information.

### 4**xx** - Transient negative completion reply

The command was not successful, but the error is temporary. If the client retries the command, it may succeed.

- 421 - Service not available, closing control connection. This may be a reply to any command if the service knows it must shut down.
- 425 - Cannot open data connection.
- 426 - Connection closed; transfer aborted.
- 431 - Need some unavailable resource to process security.
- 450 - Requested file action not taken. File unavailable (for example, file busy).
- 451 - Requested action aborted. Local error in processing.
- 452 - Requested action not taken. Insufficient storage space in system.

### 5**xx** - Permanent negative completion reply

The command was not successful, and the error is permanent. If the client retries the command, it receives the same error.

- 500 - Syntax error, command unrecognized. This may include errors such as command line too long.
- 501 - Syntax error in parameters or arguments.
- 502 - Command not implemented.
- 503 - Bad sequence of commands.
- 504 - Command not implemented for that parameter.
- 521 - Data connection cannot be opened with this PROT setting.
- 522 - Server does not support the requested network protocol.
- 530 - Not logged in.
- 532 - Need account for storing files.
- 533 - Command protection level denied for policy reasons.
- 534 - Request denied for policy reasons.
- 535 - Failed security check (hash, sequence, and so on).
- 536 - Requested PROT level not supported by mechanism.
- 537 - Command protection level not supported by security mechanism.
- 550 - Requested action not taken. File unavailable (for example, file not found, or no access).
- 551 - Requested action aborted: Page type unknown.
- 552 - Requested file action aborted. Exceeded storage allocation (for current directory or dataset).
- 553 - Requested action not taken. File name not allowed.

### 6**xx** - Protected reply

These status codes indicate a Protected Reply from FTP.

- 631 - Integrity protected reply.
- 632 - Confidentiality and integrity protected reply.
- 633 - Confidentiality protected reply.

## Common FTP status codes and their causes

- 150 - FTP uses two ports: 21 for sending commands, and 20 for sending data. A status code of 150 indicates that the server is about to open a new connection on port 20 to send some data.
- 226 - The command opens a data connection on port 20 to perform an action, such as transferring a file. This action has successfully completed, and the data connection is closed.
- 230 - This status code appears after the client sends the correct password. It indicates that the user has successfully logged on.
- 331 - You see this status code after the client sends a user name. This same status code appears regardless of whether the user name that is provided is a valid account on the system.
- 426 - The command opens a data connection to perform an action, but that action is canceled, and the data connection is closed.
- 530 - This status code indicates that the user cannot log on because the user name and password combination is not valid. If you use a user account to log on, you may have mistyped the user name or password, or you may have chosen to allow only Anonymous access. If you log on with the Anonymous account, you may have configured IIS to deny Anonymous access.
- 550 - The command is not executed because the specified file is not available. For example, this status code occurs when you try to GET a file that does not exist, or when you try to PUT a file in a directory for which you do not have Write access.

## The FTP substatus codes

This section describes the FTP substatus codes that IIS 7.0 uses:

- 0 - Successful operation.
- 1 - Authorization rules denied the access.
- 2 - File system denied the access.
- 3 - File system returned an error.
- 4 - IP restriction rules denied the access.
- 5 - Write access for the root of the virtual directory is forbidden.
- 6 - Short file name check has failed.
- 7 - Short file names are forbidden.
- 8 - Hidden segment was detected in the path based on request filtering rules.
- 9 - Denied Url sequence detected in the path based on request filtering rules.
- 10 - High bit characters detected in the path based on request filtering rules.
- 11 - File extension was denied based on request filtering rules.
- 12 - Path is too long based on request filtering rules.
- 13 - Attempt was made to open object that is not a file or directory.
- 14 - Control channel timed out.
- 15 - Data channel timed out.
- 16 - Control channel timed out based on new connection timeout.
- 17 - Invalid site configuration.
- 18 - Invalid configuration.
- 19 - Maximum connection limit was reached.
- 20 - Data channel was closed by ABOR command from client.
- 21 - Site is being stopped.
- 22 - Data channel was aborted by server due to an error.
- 23 - Data channel was aborted by client.
- 24 - SSL policy requires SSL for data channel.
- 25 - SSL policy requires SSL for control channel.
- 26 - SSL policy requires SSL for credentials.
- 27 - SSL policy denies SSL for data channel.
- 28 - SSL policy denies SSL for data channel.
- 29 - SSL policy denies SSL for credentials.
- 30 - SSL policy denies SSL for commands.
- 31 - SSL certificate was not configured.
- 32 - SSL initialization failed.
- 33 - Home directory lookup failed.
- 34 - Custom authentication call failed.
- 35 - User failed to authenticate.
- 36 - All authentication methods are disabled.
- 37 - Hostname didn't match any configured ftp site.
- 38 - Client IP on the control channel didn't match the client IP on the data channel.
- 39 - Maximum file size was exceeded. 40ActiveDirectory Isolation must be combined with basic authentication.
- 41 - An error occurred during the authentication process.
- 42 - Anonymous authentication is not allowed.
- 43 - Protection negotiation failed. PROT command with recognized parameter must precede this command.
- 44 - SSL certificate was not found.
- 45 - Private key was not found for the specified SSL certificate.
- 46 - SSL certificate hash has invalid length.
- 47 - SSL policy requires client certificate.
- 48 - User provided invalid client certificate.
- 49 - SSL policy requires matching client certificate for control and data channel.
- 50 - Data channel timed out due to not meeting the minimum bandwidth requirement.
- 51 - Command filtering rules denied the access.
- 52 - Session disconnected by administrator.
- 53 - Connection error.
- 54 - Session closed because of configuration change.
- 55 - 128-bit encryption is required for SSL connections.

## References

- For more information about the HTTP status codes in IIS 7.0 and later versions, see [The HTTP status code in IIS 7.0 and later versions](../www-administration-management/http-status-code.md).

- For more information about the FTP Publishing Service in IIS, see [FTP Publishing Service](https://www.iis.net/downloads/microsoft/ftp).

- For more information about Installing and Troubleshooting FTP7, see [Installing and Configuring FTP 7 on IIS 7](/iis/install/installing-publishing-technologies/installing-and-configuring-ftp-7-on-iis-7).

- For more information about using FTP over SSL, see [Using FTP Over SSL in IIS 7](/iis/publish/using-the-ftp-service/using-ftp-over-ssl-in-iis-7).
