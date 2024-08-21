---
title: Outlook can't connect to a server by an RPC or HTTPS connection
description: Describes an issue where you receive a There is a problem with the proxy server's security certificate error when Outlook tries to connect to a server by using an RPC connection or an HTTPS connection. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Network disconnects, password or credentials prompt
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: ronnap, twalker
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Exchange Online
search.appverid: MET150
ms.date: 01/30/2024
---
# Error when Outlook tries to connect to a server by using an RPC connection or an HTTPS connection: There is a problem with the proxy server's security certificate

_Original KB number:_ &nbsp;923575

## Symptoms

When Microsoft Outlook tries to connect to a server by using a remote procedure call (RPC) connection or a secure HTTP (HTTPS) connection, you receive one of the following error messages:

- Error message 1

    > There is a problem with the proxy server's security certificate, %s. Outlook is unable to connect to this server. (%s)

- Error message 2

    > There is a problem with the proxy server's security certificate, %s. The name on the security certificate is invalid or does not match the name of the site. Outlook is unable to connect to this server. (%s)

- Error message 3

    > There is a problem with the proxy server's security certificate, %s. The security certificate is not from a trusted certifying authority. Outlook is unable to connect to this server.(%s)"

- Error message 4

    > There is a problem with the proxy server's security certificate. The name on the security certificate is invalid or does not match the name of the target site outlook.office365.com. Outlook is unable to connect to the proxy server (Error Code 0)

### Notes about the error messages

- The **%s** placeholder is the Outlook profile property 001f6622. This is the Microsoft Exchange Server RPC proxy server name.
- The **(%s)** placeholder is the error code.

    For error message 1 and error message 2, the error code that's returned is the sum of all the bitmask certificate problem codes. See the "More information" section for information about the bitmask certificate problem codes.

    For error message 3, the error code is expected to always be 0x00000008.

## Cause

This issue may occur if one or more of the following conditions are true:

- The connection to the server requires a certification authority (CA).
- You haven't trusted the certification authority at the root.
- The certificate may be invalid or revoked.
- The certificate doesn't match the name of the site.
- A third-party add-in or a third-party browser add-in is preventing access.

## Resolution 1: Examine the certificate for error message 1 or 2

Examine the certificate. Then, contact your system administrator to resolve this issue.

To examine the certificate, follow these steps:

1. In Microsoft Internet Explorer, connect to the RPC server or to the secure server. For example, type *https://www. **server_name**.com/rpc* in the **Address** bar of the Web browser, and then press Enter.

    > [!NOTE]
    > The **server_name** placeholder references the RPC server name or the secure server name.
1. Double-click the padlock icon that's located in the lower-right corner of the Web browser.
1. Click the **Details** tab.
1. Note the information in the following fields:
   - **Valid to**  
    The **Valid to** field indicates the date until which the certificate is valid.
   - **Subject**  
    The data in the **Subject** field should match the site name.

## Resolution 2: Install the trusted root certificate for error message 3

To install the trusted root certificate on the client, follow these steps:

1. Click **Install Certificate** when you're prompted with the **Certificate** dialog box.
1. Click **Next**.
1. Click to select the **Place all certificate in the following store** check box.
1. Click **Browse**.
1. Click **Trusted Root Certification Authorities** > **OK**.
1. Click **Next**.
1. Click **Finish**.
1. Click **OK**.

For references, see [Installing a trusted root certificate](/skype-sdk/sdn/articles/installing-the-trusted-root-certificate#installing-a-trusted-root-certificate).

## Resolution 3: Disable the third-party add-in or the third-party browser add-in for error message 4

### Disable third-party add-ins

1. Start Outlook in safe mode to help isolate the issue. To do this, click **Start** > **Run**, type *outlook.exe /safe*, and then click **OK**.

    If Outlook successfully starts in safe mode, the issue that you're experiencing may be caused by a third-party add-in.

1. Check for third-party COM add-ins and disable them. To do this, follow these steps:

    1. On the **File** menu, click **Options** > **Add-Ins**.
    1. In the **Manage** box, click **COM Add-ins** > **Go**.
    1. Click to clear the check box next to the third-party add-ins that you want to disable.
    1. Restart Outlook.

For more information, see the "Step 6: Start Outlook in safe mode" section of the following Microsoft Knowledge Base article:

[2632425](https://support.microsoft.com/help/2632425) How to troubleshoot crashes in Outlook 2010 and Outlook 2013

### Disable third-party browser add-ins

Outlook uses Internet Explorer settings for HTTP requests. If a third-party browser add-in is causing this issue, disable it in Internet Explorer. For steps on how to do this, see the "Disable add-ons in Internet Explorer" section of the following Microsoft Knowledge Base article:

[956196](https://support.microsoft.com/help/956196) "Internet Explorer cannot display the webpage" error

## More information

The bitmask certificate problem codes are listed in the following table.

|Description|Error code|
|---|---|
|FLAG_CERT_REV_FAILED|0x00000001|
|FLAG_INVALID_CERT|0x00000002|
|FLAG_CERT_REVOKED|0x00000004|
|FLAG_INVALID_CA|0x00000008|
|FLAG_CERT_CN_INVALID|0x00000010|
|FLAG_CERT_DATE_INVALID|0x00000020|
|FLAG_CERT_WRONG_USAGE|0x00000040|
|FLAG_SECURITY_CHANNEL_ERROR|0x80000000|
