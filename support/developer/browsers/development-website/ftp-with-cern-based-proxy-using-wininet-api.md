---
title: How to use FTP with CERN-based proxy using WinInet API
description: This article discusses using Wininet APIs with CERN-based Web proxy to retrieve data via FTP.
ms.date: 03/03/2020
ms.reviewer: weihua
---
# How to use FTP with a CERN-based proxy using WinInet APIs

[!INCLUDE [](../../../includes/browsers-important.md)]

A CERN-based Web proxy server uses HTTP for all communications with its clients. Therefore the FTP set of Wininet functions cannot be used to download resources on an FTP server if the FTP server is accessed through a CERN-based proxy on the client behalf. Instead, the client has to use general Wininet functions such as `InternetOpenUrl` and `InternetReadFile` to properly retrieve the data from the HTTP stream sent from the CERN-based proxy server.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 166961

## More Information

CERN-compatible proxy services support HTTP (WWW), FTP, and Gopher requests. But the communication between the CERN-based proxy server and its clients uses HTTP only. The following diagram show how an FTP request is forwarded using a CERN-compatible proxy service:

```console
Get ftp://host.com/root/test.doc HTTP 1.0        FTP Request
   |=========|                 |=============|          |=============|
   |         |---------------->| Cern-based  |--------->|             |
   | Client  |    HTTP         | Proxy Server|   FTP    |  Ftp Server |
   |         |<----------------|             |<---------|             |
   |=========|                 |=============|          |=============|
         HTTP/1.0 200 <document>                  FTP Response
```

Since a CERN-based proxy server communicates with its clients in HTTP, you cannot use the FTP set of Wininet functions if the client accesses the FTP server through the proxy server. Instead, you should use `InternetOpenUrl` and `InternetReadFile` to retrieve the requested data from the HTTP stream sent by the proxy server.

If the FTP URL passed in `InternetOpenUrl` is a URL to a file on the FTP server, you can use `InternetReadFile` to read the entire file content. If the FTP URL passed in `InternetOpenUrl` is a URL to a directory on the FTP server, `InternetReadFile` retrieves a directory listing of the FTP URL as an HTML document. In both cases, you may have to loop calling `InternetReadFile` until all data in the HTTP stream are read.

If the client intends to retrieve anything further below the FTP directory URL, it has to parse the HTML document to get URLs to subdirectories or files and issue more `InternetOpenUrl` and `InternetReadFile` calls. Also when a CERN-based proxy is used, the `INTERNET_FLAG_RAW_DATA` flag should not be specified in the `InternetOpenUrl` call.

The following pseudo code demonstrates how to call `InternetOpenUrl` and `InternetReadFile` when a CERN-based proxy server is used to access an FTP server:

```cpp
CHAR strURL[] = "ftp://host.com/root/test.doc";
HANDLE f; //local file handle
HINTERNET hInternetFile;
DWORD dwRead, dwWritten;
CHAR szTemp[1024];
hInternetFile = InternetOpenUrl(hInternetSession, (LPCTSTR)strURL, NULL,
                                0, INTERNET_FLAG_RELOAD | INTERNET_FLAG_DONT_CACHE, 0);
if (hInternetFile == NULL)
{
    do
        some error processing;
    quit;
}
//download the file to c:\deleteme
f = CreateFile("c:\\deleteme", GENERIC_WRITE, 0, NULL,
               CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
if (f == INVALID_HANDLE_VALUE)
{
    do
        some error processing;
    quit;
}

while (InternetReadFile(hInternetFile, (LPVOID)szTemp, 1024, &dwRead))
{
    if (!dwRead)
        break;
    WriteFile(f, (LPVOID)szTemp, dwRead, &dwWritten, NULL);
}
CloseHandle(f);
//if the strURL is a URL to a file on the ftp server, we get the file
//and store it in c:\deleteme.
//if the strURL is a URL to a directory on the ftp server, c:\deleteme
//will be a HTML page of the directory listing. You will have to parse
//the html page, and construct new URLs, and call the above code again.
```

When the client has direct connection to an FTP server, or is connected to the FTP server via a TIS FTP proxy server, the communication to and from the client is in FTP. The client can specify the `INTERNET_FLAG_RAW_DATA` flag in `InternetOpenUrl` and then use `InternetFindNextFile` to get a WIN32_FIND_DATA structure and enumerate all subdirectories and files of the URL. The client can also use the FTP set of Wininet functions in such situations.

The following pseudo code demonstrates how to call `InternetOpenUrl` and `InternetReadFile` when the `INTERNET_FLAG_RAW_DATA` flag is specified in the `InternetOpenUrl` call:

```cpp
CHAR strURL[] = "ftp://host.com/root/test.doc";
HANDLE f; //local file handle
HINTERNET hInternetFile;
DWORD dwRead, dwWritten;
CHAR szTemp[1024];
hInternetFile = InternetOpenUrl(hInternetSession, (LPCTSTR)strURL, NULL,
                                0, INTERNET_FLAG_RELOAD | INTERNET_FLAG_DONT_CACHE, 0);
if (hInternetFile == NULL)
{
    do
        some error processing;
    quit;
}
//download the file to c:\deleteme
f = CreateFile("c:\\deleteme", GENERIC_WRITE, 0, NULL,
               CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
if (f == INVALID_HANDLE_VALUE)
{
    do
        some error processing;
    quit;
}

while (InternetReadFile(hInternetFile, (LPVOID)szTemp, 1024, &dwRead))
{
    if (!dwRead)
        break;
    WriteFile(f, (LPVOID)szTemp, dwRead, &dwWritten, NULL);
}
CloseHandle(f);
//if the strURL is a URL to a file on the ftp server, we get the file
//and store it in c:\deleteme.
//if the strURL is a URL to a directory on the ftp server, c:\deleteme
//will be a HTML page of the directory listing. You will have to parse
//the html page, and construct new URLs, and call the above code again.
```

When the connection between the client and the FTP server is direct or via a TIS FTP proxy, `InternetOpenUrl` and `InternetReadFile` are actually generating FTP traffic rather than HTTP traffic.

The above discussion regarding using Wininet APIs with CERN-based proxy applies to GOPHER as well. Also it is important to note that Wininet APIs support HTTP, HTTPS, FTP, and GOPHER URLs only. For FILE URLs such as file://server/share/file or file://\\\server\share\file, you need to use Win32 APIs such as FileCopy to download the file to the client machine, or FindFirstFile, FindNextFile, and FindClose to enumerate a directory.
