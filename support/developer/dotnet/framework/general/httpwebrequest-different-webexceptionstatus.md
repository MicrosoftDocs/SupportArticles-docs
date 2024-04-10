---
title: HttpWebRequest throws different WebExceptionStatus
description: This article provides a resolution to resolve the problem that different WebExceptionStatus will be shown for SSL and non-SSL requests.
ms.date: 05/06/2020
ms.reviewer: pphadke
---
# System.Net.HttpWebRequest throws different WebExceptionStatus for SSL and non-SSL requests under special conditions

This article helps you resolve the problem where different `WebExceptionStatus` is thrown when you use the `System.Net.HttpWebRequest` class.

_Original product version:_ &nbsp; .Net Framework  
_Original KB number:_ &nbsp; 2007873

## Symptoms

You are using the `System.Net.HttpWebRequest` class of the Microsoft .Net Framework to send a Hypertext Transfer Protocol (HTTP) or Hypertext Transfer Protocol Secure (HTTPS) request to a server. This request takes some time to receive a response from the server. During this wait time, if the system clock time is increased manually or if the system clock lags behind and then the Windows Time service adjusts to the actual local time, you experience one of the following scenarios:

For a request, which was sent over plaintext HTTP, the `System.Net.HttpWebRequest` class will throw the following exception:

> The request was aborted: The operation has timed out.

Additionally, the `Status` property on the thrown `WebException` will indicate the value `WebExceptionStatus.Timeout`.

For a request, which was sent over HTTPS, the `System.Net.HttpWebRequest` class will throw one of the following exceptions:

> The underlying connection was closed: An unexpected error occurred on a receive.

Additionally, the `Status` property on the thrown `WebException` will indicate the value `WebExceptionStatus.ReceiveFailure`.

Or

> The underlying connection was closed: A connection that was expected to be kept alive was closed by the server.

Additionally, the `Status` property on the thrown `WebException` will indicate the value `WebExceptionStatus.KeepAliveFailure`.

In all of the above scenarios the, which is caught has the `InnerException` property. If you catch the `WebException` and reference the `WebException.InnerException.InnerException` property, you will notice that for all the above cases, the `Message` string will indicate:

> A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.

This message is the verbose interpretation of the Winsock error code 10060 = WSAETIMEDOUT.

Therefore, when the system time is manually increased, Winsock correctly throws the timeout error 10060, but it gets wrapped around as different exception types for Secure Sockets Layer (SSL) and non-SSL requests.

Under normal timeout circumstances where the system time is not tampered with, the SSL and non-SSL scenarios will correctly reflect the `WebExceptionStatus.Timeout` status and throw the common exception: **The operation has timed out**.

## Cause

When you make the request over either SSL or non-SSL, then the `System.Net.ServicePointManager` class will assign the request to an internal connection, which is eventually going to make the Winsock connection. In the case of SSL requests, this request or connection goes through another internal SSL/TLS class, which is responsible for the encryption or decryption of the data. For non-SSL connections, this internal SSL/TLS class is not involved at all.

When the time is modified and the exception is encountered at the Winsock layer, this error now needs to travel upwards from Winsock to the application layer. For non-SSL connections, this exception is caught directly by the internal connection class, but for SSL requests, this error is handled by the internal SSL/TLS class. This class considers this non-SSL error as a `ReceiveFailure` or `KeepAliveFailure` and hence has a different exception status, whereas for non-SSL connection the error gets cast correctly since it is handled by a different class.

## Status

This behavior is by design.

## Resolution

In order to resolve this discrepancy of the thrown exception types under this special condition where the system time is tampered with, the application needs to catch the `WebException` and then reference the `WebException.InnerException.InnerException.Message` property.

If the `Message` string equals the winsock verbose error equivalent of 10060 = WSAETIMEDOUT, then you can consider the `ReceiveFailure` or `KeepAliveFailure` as a regular Timeout and not consider it as a `ReceiveFailure` or `KeepAliveFailure`.

The application can use the below workaround upon performing the `catch()` of the `WebException` for an English version of the framework. For a localized version of the framework, the below workaround needs to be adjusted depending on the language localization.

> [!IMPORTANT]
> This sample code is provided as-is and is intended for sample purposes only. It's provided without warranties and confers no rights.

```csharp
try
{
    ......
}
catch (WebException oWEx)
{
    WebExceptionStatus oStatus = oWEx.Status;
    String strTimeoutErrorMessage = "A connection attempt failed because the connected party did not properly respond "
                                  + "after a period of time, or established connection failed because connected host has failed to respond";
    switch (oStatus)
    {
        case WebExceptionStatus.KeepAliveFailure:
            if ((oWEx.InnerException != null) && (oWEx.InnerException.InnerException != null)
                && oWEx.InnerException.InnerException.Message.ToString().Equals(strTimeoutErrorMessage, StringComparison.CurrentCultureIgnoreCase))
            {   //----------------------------------------------------------------------
                // This is Timeout Error which is wrongly thrown as a ReceiveFailure for
                // SSL requests under this special condition.
                //
                // Handle this as a Timeout Error
                //----------------------------------------------------------------------
            }
            else
            {
                //----------------------------------------------------------------------
                // This is truly a KeepAliveFailure.
                //----------------------------------------------------------------------
            }
            break;
        case WebExceptionStatus.Timeout:
             //----------------------------------------------------------------------
             // This is a Timeout.
             //----------------------------------------------------------------------
             break;
        case WebExceptionStatus.ReceiveFailure:
            if ((oWEx.InnerException != null)
                && (oWEx.InnerException.InnerException != null)
                && oWEx.InnerException.InnerException.Message.ToString ().Equals (strTimeoutErrorMessage, StringComparison.CurrentCultureIgnoreCase))
            {    //----------------------------------------------------------------------
                 // This is Timeout Error which is wrongly thrown as a ReceiveFailure for
                 // SSL requests under this special condition.
                 //
                 // Handle this as a Timeout Error
                 //----------------------------------------------------------------------
            }
            else
            {    //----------------------------------------------------------------------
                 // This is truly a ReceiveFailure.
                 //----------------------------------------------------------------------
            }
            break;
        default:
               //----------------------------------------------------------------------
               //  This is some other Exception
               //----------------------------------------------------------------------
            break;
    }
}
```
