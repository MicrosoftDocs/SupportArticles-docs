---
title: HTTP 500 or Response buffer limit exceeded
description: This article describes a problem where the client receives an 'HTTP 500' or 'Response buffer limit exceeded' error occurs when you send a file by using a web server that has IIS 7 or a later version installed.
ms.date: 04/15/2020
ms.custom: sap:Site behavior and performance
ms.subservice: site-behavior-performance
ms.reviewer: mlaing, v-jayc
---
# HTTP 500 or Response buffer limit exceeded error when using Response.BinaryWrite in IIS

This article helps you resolve the error (HTTP 500 or Response buffer limit exceeded) that occurs when you use the `Response.BinaryWrite` method to send a file.

_Original product version:_ &nbsp; Internet Information Services 7 and later versions  
_Original KB number:_ &nbsp; 944886

## Symptoms

When you send a file to a client computer from a Web server on which Internet Information Services (IIS) 7 or a later version is installed, you may receive an error message on the client computer that resembles one the following:

- Error message 1

    > HTTP 500 - Internal Server Error

- Error message 2

    > Response object error 'ASP 0251 : 80004005'  
    > Response Buffer Limit Exceeded  
    > Execution of the ASP page caused the Response Buffer to exceed its configured limit.

- Error message 3

    Additionally, you may receive a message in the IIS log file that resembles the following:

    > ASP_0251_:_80004005|Response_Buffer_Limit_Exceeded

This problem occurs when you use the `Response.BinaryWrite` method to send the file to the client computer and the `AspBufferingOn` property is set to **False**.

## Cause

This problem occurs because IIS enforces a default Active Server Pages (ASP) response buffer value of 4 MB when ASP response buffering is disabled.

In most scenarios, the 4-MB buffer limit is sufficient for ASP responses that are sent to Web clients. If this limit is insufficient, use one of the following methods.

## Resolution 1: Decrease the response size

To resolve this issue when you use the `Response.BinaryWrite` method and ASP buffering is turned off, verify that the data that is returned to the client is not larger than 4 MB.

If the response is larger than the 4-MB default value, this size frequently causes a poor user experience. The Web browser must receive the large response over the network. Then, the Web browser must parse and display a large HTML response.

## Resolution 2: Enable ASP response buffering and increase the buffer limit

You can use the `AspBufferingOn` IIS metabase property to enable or disable buffering at the application level.

> [!NOTE]
> In IIS 7 and later versions, you can enable or disable ASP response buffering at the application level by using the `bufferingOn` value in the ASP section of `<System.webserver>` in the `ApplicationHost.config` file or in the `Web.config` file.

To enable or disable buffering at the page level, you can use the `Response.Buffer` property.

If you must increase the buffer limit, select a buffer limit that allows for the largest known response size. If you do not know the largest response size in advance, you can increase the buffer limit to a large value during testing. After you finish testing, use the largest value that appears in the *sc-bytes* field in the IIS log file for the response that is generated for the page.

To increase the buffering limit in IIS 7 and later versions, follow these steps:

1. Select **Start**, select **Run**, type *cmd*, and then select **OK**.
2. Type the `cd /d %systemdrive%\inetpub\adminscripts` command, and then press Enter.
3. Type the `cscript.exe adsutil.vbs SET w3svc/aspbufferinglimit LimitSize` command, and then press Enter.

   > [!NOTE]
   > `LimitSize` represents the buffering limit size in bytes. For example, the number 67108864 sets the buffering limit size to 64 MB.

To confirm that the buffer limit is set correctly, follow these steps:

1. Select **Start**, select **Run**, type *cmd*, and then select **OK**.
2. Type the `cd /d %systemdrive%\inetpub\adminscripts` command, and then press Enter.
3. Type the `cscript.exe adsutil.vbs GET w3svc/aspbufferinglimit` command, and then press Enter.

## More information

When you use the `Response.BinaryWrite` method and ASP response buffering is disabled, you can only send 4 MB of data to the client unless the buffering limit property for the page is explicitly set. By default, the value for the `bufferLimit` property in IIS 7 or a later version is 4,194,304 bytes.

Additionally, the `BinaryWrite()` API fails if the response to the client is larger than the buffer limit value even though ASP response buffering is turned off.

> [!NOTE]
> We recommend that you enable ASP response buffering. ASP response buffering increases the performance of a Web application.
