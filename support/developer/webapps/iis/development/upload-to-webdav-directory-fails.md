---
title: Fail to upload files to WebDav directory
description: This article describes how programmatically to upload files to a WebDav directory hosted on Internet Information Services by using the WinINet API.
ms.date: 07/17/2020
ms.custom: sap:Development
ms.technology: development
---
# Upload files to an IIS WebDav directory by using the WinINet API

This article describes how programmatically to upload files to a WebDav directory hosted on Microsoft Internet Information Services (IIS) by using the WinINet API.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2001156

## Symptoms

Your application is programmatically uploading files to a WebDav directory hosted on IIS, by using the WinINet API to send a Hypertext Transfer Protocol (HTTP) `PUT` verb. You notice that your application works correctly on IIS and Windows Server, but may fail to upload files to the IIS WebDav directory, even though no code changes have been made to your WinINet application.

## Cause

The cause of this issue is because of a design change for WebDav running on IIS. WebDav running on IIS now requires authentication and won't work if only Anonymous Authentication is used. Because of this, your application that uses the WinINet API sequence of `HttpSendRequestEx`, `InternetWriteFile`, `HttpEndRequest` will experience that the call to `HttpEndRequest` returns **FALSE** and `GetLastError()` will indicate an error code of 12032 - `ERROR_INTERNET_FORCE_RETRY`.

## Resolution

The resolution to this issue is to retry the same sequence of operations, namely:

1. `HttpSendRequestEx`
1. `InternetWriteFile`
1. `HttpEndRequest`

Until `HttpEndRequest` doesn't return **FALSE** and `GetLastError()` doesn't report back 12032 (or there's some other error). If IIS is presented with wrong authentication information, then IIS will keep returning an HTTP error 401 for each retry. So, you'll need to keep track of how many times the `HttpEndRequest` function returns back error 12032 and prevent running into an infinite loop.

If there's Windows NTLM Authentication, `HttpEndRequest` will return back error 12032 for a maximum of two times to satisfy the three-way NTLM handshake. The first error 12032 will indicate an HTTP error 401 response from the server and the second error 12032 will indicate the Type-2 NTLM handshake message from the server, which, if valid authentication info is passed to IIS, the user will be authenticated correctly and the upload will be successful.

When you use a retry logic to call the above functions in a loop, notice that the call to `InternetWriteFile` is being made multiple times. What this means is that the call to `InternetWriteFile` will end up writing the data over the network and this will cause a waste of bandwidth. To prevent this from happening, you can send a dummy HTTP `HEAD` request to the server, which will pre-authenticate the request and cause the later call of `HttpSendRequest` not to send the HTTP Payload when `InternetWriteFile` is called. If you're familiar with Network Monitor or WinINet logging, you'll see that the first `PUT` request sent to the server will have a Content-Length of zero, which prevents the payload transfer and the payload won't be transferred until the NTLM handshake is complete.

The WebDav feature does not require you to use Windows Authentication; you can configure your WebDav server to use Basic Authentication over SSL, which will ensure the safety of the data upload. When Basic authentication is configured, you can directly inject a valid base-64 encoded username password string in the outgoing request, which will prevent IIS returning back an HTTP error 401 and that's why `HttpEndRequest` will not return back error 12032. You can add the Basic authentication information to the outgoing request by calling the WinINet API:

```cpp
HttpAddRequestHeaders(hRequest, "Authorization: Basic <<valid base-64 encoded username:password string>>\r\n", -1, HTTP_ADDREQ_FLAG_ADD);
```

Do this before calling `HttpSendRequestEx` to directly inject the Authorization header in the outgoing HTTP request.

The following code sample shows how you can use the retry logic to handle the error 12032 return response from `HttpEndRequest`. This sample doesn't cover the pre-authenticate request discussed above. To pre-authenticate, all you'll need to do is to call `HttpOpenRequest`, `HttpSendRequest` with the HTTP `HEAD` verb to the target server before you call the `HttpSendRequestEx` code below.

## Code sample

```cpp
BOOL UseHttpSendReqEx(HINTERNET hRequest, DWORD dwPostSize)
{
    INTERNET_BUFFERS BufferIn;
    DWORD dwBytesWritten;
    int iChunkCtr;
    BYTE pBuffer[1024];
    BOOL bRet;
    BufferIn.dwStructSize = sizeof( INTERNET_BUFFERS ); // Must be set or you will get an error
    BufferIn.Next = NULL;
    BufferIn.lpcszHeader = NULL;
    BufferIn.dwHeadersLength = 0;
    BufferIn.dwHeadersTotal = 0;
    BufferIn.lpvBuffer = NULL;
    BufferIn.dwBufferLength = 0;
    BufferIn.dwBufferTotal = dwPostSize; // This is the only member used other than dwStructSize
    BufferIn.dwOffsetLow = 0;
    BufferIn.dwOffsetHigh = 0;
    //  The following variable will keep track of the number of times HttpSendRequestEx is called
    int iNumTrials = 0;
    bool bRetVal = FALSE;
    //  The retry goto is to re-try the operation when HttpEndRequest returns error 12032.
    while(1)
    {
        if(!HttpSendRequestEx( hRequest, &BufferIn, NULL, 0, 0))
        {
            printf( "Error on HttpSendRequestEx %d\n",GetLastError());
            return FALSE;
        }
        FillMemory(pBuffer, 1024, 'D'); // Fill buffer with data
        bRet=TRUE;
        for(iChunkCtr=1; iChunkCtr<=(int)dwPostSize/1024 && bRet; iChunkCtr++)
        {
            dwBytesWritten = 0;
            if(bRet=InternetWriteFile( hRequest, pBuffer, 1024, &dwBytesWritten))
                printf( "\r%d bytes sent.", iChunkCtr*1024);
        }
        if(!bRet)
        {
            printf( "\nError on InternetWriteFile %lu\n",GetLastError());
            return FALSE;
        }
        if(!HttpEndRequest(hRequest, NULL, 0, 0))
        {
            int iLastError = GetLastError();
            printf( "Error on HttpEndRequest %lu \n", iLastError);
            //  Use the following logic to "retry" after receiving error 12032 from HttpEndRequest
            //
            //  Error 12032 = ERROR_INTERNET_FORCE_RETRY means that you just need to send the request again
            //
            //  Sending request again means that you simply need to call:
            //
            //  HttpSendRequest, InternetWriteFile, HttpEndRequest until HttpEndRequest does not return
            //  back error 12032.
            //
            //  Since NTLM is a 3-way handshake protocol, it will happen that HttpEndRequest will return
            //  error 12032 two times and hence the following check.
            //
            //  If error 12032 is returned 3 or more number of times, then there is some Other error.
            if(iLastError == 12032 && iNumTrials < 3) {
                iNumTrials++;
                continue;   // This will retry HttpSendRequestEx...
            }
            return FALSE;
        }
        return TRUE;
    }
}
```

## More information

- [Installing and Configuring WebDAV on IIS 7 and Later](/iis/install/installing-publishing-technologies/installing-and-configuring-webdav-on-iis)

- [HttpSendRequestExA function](/windows/win32/api/wininet/nf-wininet-httpsendrequestexa?redirectedfrom=MSDN)

- [HttpAddRequestHeadersA function](/windows/win32/api/wininet/nf-wininet-httpaddrequestheadersa?redirectedfrom=MSDN)

- [Microsoft Network Monitor 3.4](https://www.microsoft.com/download/details.aspx?id=4865)
