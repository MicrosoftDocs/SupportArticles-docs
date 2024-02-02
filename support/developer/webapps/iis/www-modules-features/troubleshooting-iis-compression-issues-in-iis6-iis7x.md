---
title: Troubleshooting IIS Compression issues in IIS 6 or IIS 7.x
description: This article explains how to configure compression and lists frequent reasons why IIS compression in IIS 6 and IIS 7.x might not function.
ms.date: 04/09/2012
ms.reviewer: riande, johnhart, sudixi, v-jayaramanp
ms.topic: troubleshooting
---

# Troubleshooting IIS Compression issues in IIS 6 or IIS 7.x

_Applies to:_ &nbsp; Internet Information Services 6.0, Internet Information Services 7.0 and later versions

## Overview

Enabling HTTP Compression for your IIS 6 or 7 web applications is one way of increasing site performance.

Many of the compression properties required to completely manage IIS are not exposed by the admin GUI. It merely offers an on or off switch. So, to completely enable HTTP compression, you must use a tool other than the IIS Manager to update the *metabase.xml* file. The most common tool used is *adsutil.vbs*, which is included in the IIS installation directory.

This article helps you to configure compression and identifies common reasons of why IIS compression may not work in IIS 6 and IIS 7.x.

## Tools used in this troubleshooter

- Fiddler
- Process Monitor
- Metabase ACL
- IIS 7 FREB trace

## Verification

### Determine if compression is working

The only way to determine whether the IIS server sent a compressed response is by analyzing a network trace of the client request and server response. The request from the client must contain the following HTTP Request Header:

```output
HTTP: Accept-Encoding =gzip, deflate
```

This lets the server know that the client is willing to receive a compressed response and supports compression. In return, a compressed response from the server will contain the following HTTP Response header and a value:

```output
HTTP: Content-Encoding = gzip
```

The following screenshots show output from the Fiddler tool when compression isn't working:

:::image type="content" source="media/troubleshooting-iis-compression-issues-in-iis6-iis7x/fiddler-tool-compression-not-working1.png" alt-text="Screenshot of HTTP Compression set to No Compression in the Transformer tab.":::

:::image type="content" source="media/troubleshooting-iis-compression-issues-in-iis6-iis7x/disabled-http-compression-section.png" alt-text="Screenshot of a disabled HTTP Compression section in the Transformer tab.":::

## Troubleshooting compression issues

Perform the following steps to troubleshoot compression issues:

1. Enable Compression in IIS 6 or IIS 7.

   From the IIS Manager, right-click on the **Web Sites** node, select **Properties**, and then select **Services**.

    :::image type="content" source="media/troubleshooting-iis-compression-issues-in-iis6-iis7x/compress-static-files-selected-maxtemp-size-unlimited.png" alt-text="Screenshot of HTTP compression with Compress static files selected and the Maximum temporary directory size set to unlimited.":::

    :::image type="content" source="media/troubleshooting-iis-compression-issues-in-iis6-iis7x/enabled-compression-default-values.png" alt-text="Screenshot of the enabled Compression options with the default values.":::

1. Specify compression folder and permissions.

    IIS stores compressed files in a folder, which can be configured. By default, it's `%windir%\IIS Temporary Compressed Files` for IIS 6, and `%SystemDrive%\inetpub\temp\IIS Temporary Compressed Files` for IIS 7.

    IIS\_WPG(IIS\_IURS for IIS 7) must have full control permission for this folder. Use [Process Monitor](/sysinternals/downloads/procmon) to troubleshoot this type of a permission issue.

1. Check if compression is enabled in *Metabase.xml*.

    Compression isn't turned on in the metabase at the right nodes. There are three metabase nodes for the Compression configuration:

    - `w3svc/filters/compression/parameters`
    - `w3svc/filters/compression/gzip`
    - `w3svc/filters/compression/deflate`

    Configuring the `/parameters` node is mandatory. Then, you can configure either `/gzip` or `/deflate` node, or both. This means that configuring just the gzip, deflate, or parameters nodes will not work. If you configure the `/parameters` and `/gzip` nodes, the Gzip compression scheme will be enabled. If you configure the `/parameters` and `/deflate` nodes, the Deflate compression scheme will be enabled. Finally, if you configure all three nodes, both GZip compression and Deflate compression will be enabled.

1. Check the metabase permission for IIS 6.

    By default, `IIS_WPG` has Read, Unsecure Read, Enumerate Keys, and Write permissions to the `/LM/W3SVC/Filters`.

    IIS will be unable to initialize the compression if the permissions were removed due to unexpected change or if security hardens.

    Use *metaacl.vbs* to verify and modify IIS 6 metabase ACL. For more information, see 
    [Default Metabase ACL](https://msdn.microsoft.com/library/ms524775(v=VS.90).aspx).

    If the application pool identity (or the `IIS_WPG` group in general) doesn't have Read and Write access to the metabase key W3SVC or Filters, a failure condition of `COMPRESSION_DISABLED` will be logged in an Enterprise Tracing for Windows (ETW) trace.

    **ETW Trace**

    ```output
    IISCompression: STATIC_COMPRESSION_NOT_SUCCESS - IIS has been unsuccessful doing static compression
    Reason: COMPRESSION_DISABLED
    ```

1. Check if dynamic or static compression is turned off in *Metabase.xml*.

    At each of the three configuration nodes (`/parameters`, `/gzip`, and `/deflate`), you have the option of enabling static and/or dynamic compression. To enable static compression for file types such as .txt and .html, you must set the `HcDoStaticCompression` key to `1` (or `TRUE`). To enable dynamic compression for file types such as .asp, .aspx, .asmx, or .exe, you must set the `HcDoDynamicCompression` key to `1` (or `TRUE`).

    For example, to set dynamic compression at the `/parameters` node, run the following command by using *adsutil.vbs*:

    ```Console
    cscript.exe adsutil.vbs SET w3svc/filters/compression/parameters/HcDoDynamicCompression TRUE
    ```

    The output of the previous command looks like this:

    ```output
    HcDoDynamicCompression          : (BOOLEAN) True
    ```

    **In IIS7**

    ```xml
    <system.webServer>
    <urlCompression doStaticCompression="true" doDynamicCompression="true" />
    </system.webServer>
    ```

1. Check if the file type you want to compress is listed in the appropriate File Extensions sections at the `/gzip` and `/deflate` nodes.
    
    After you turn on compression with the `HcDoDynamicCompression` and/or `HcDoStaticCompression` keys, specify which file types must be actually compressed. By default, STATIC compression uses file types such as .htm, .html, and .txt and DYNAMIC compression uses .asp, .dll, and .exe. If you want to compress different file types, for example .aspx, add it to the appropriate file extension section in the `/gzip` and-or `/deflate` nodes, depending on the type of compression you're using. For static file compression (like .html, txt, and xml), add the file extensions to the `HcFileExtensions` property. For dynamic compression (like .asp, .aspx, and .asmx) add it to the `HcScriptFileExtension` property.

    **For static files**

    ```console
    adsutil.vbs SET w3svc/filters/compression/gzip/HcFileExtensions "htm" "html" "txt"
    ```

    ```console
    adsutil.vbs GET w3svc/filters/compression/gzip/HcFileExtensions
    ```

    The previous command shows the following output:

    ```output
    HcFileExtensions : (LIST)  (3 Items)
    "htm"
    "html"
    "txt"
    ```

    **For dynamic files**

    ```console
    adsutil.vbs SET w3svc/filters/compression/gzip/HcScriptFileExtensions "asp" "dll" "exe" "aspx"
    adsutil.vbs get w3svc/filters/compression/gzip/HcScriptFileExtensions
    ```

    The previous command shows the following output:

    ```output
    HcFileExtensions : (LIST)  (4 Items)
    "asp"
    "dll"
    "exe"
    "aspx"
    ```

    **In IIS7**

    ```xml
    <httpCompression directory="%SystemDrive%\inetpub\temp\IIS Temporary Compressed Files" minFileSizeForComp="1000">
    <scheme name="gzip" dll="%Windir%\system32\inetsrv\gzip.dll" />
    <staticTypes>
        <add mimeType="text/*" enabled="true" />
        <add mimeType="message/*" enabled="true" />
        <add mimeType="application/x-javascript" enabled="true" />
        <add mimeType="application/atom+xml" enabled="true" />
        <add mimeType="application/xaml+xml" enabled="true" />
        <add mimeType="*/*" enabled="false" />
    </staticTypes>
    <dynamicTypes>
        <add mimeType="text/*" enabled="true" />
        <add mimeType="message/*" enabled="true" />
        <add mimeType="application/x-javascript" enabled="true" />
        <add mimeType="*/*" enabled="false" />
    </dynamicTypes>
    </httpCompression>
    <system.web.extensions>
    <scripting>
        <scriptResourceHandler enableCompression="false" />
    </scripting>
    </system.web.extensions>
    ```

    > [!NOTE]
    > You must configure the `HcFileExtensions` or `HcScriptFileExtensions` properties with the correct syntax. Any trailing spaces or unnecessary quotes or carriage returns will cause the property to be misconfigured. Unfortunately, *adsutil.vbs* doesn't show an error if you add an extra space, so you need to be very careful. Also, you can't copy or paste the values into a command prompt or into the *metabase.xml* file (metabase direct-edit) and must type it manually.

1. Check if compression is set at the master level, but is getting overridden by a setting at a child level.

    Compression would be enabled at the `w3svc/filters/compression` level. However, it might be that it's getting overridden by a setting at the website or application level.

    For example, if you have `HcDoDynamicCompression` set to `TRUE` at the `w3svc/filters/compression` level, and for the default website have `DoDynamicCompression` set to `FALSE`, dynamic compression will not occur for responses to requests for the default website.

1. Check if an anti-virus program has scanned the directory where the compressed files are saved.

    When compression is enabled on a server running IIS and an HTTP request is served from the IIS compression directory, a 0-byte file might be returned instead of the expected file.

    > [!NOTE]
    > You may only see these symptoms if HTTP Static Compression is enabled.

    This happens because an antivirus software running on the IIS server is scanning the IIS compression directory.

    So, you would need to exclude the IIS compression directory from the antivirus software's scan list.

1. Check if the URL being requested contains a slash as part of the parameters passed to the executing DLL file.

1. Check if the ISAPI filters modify the request or response headers.

    An ISAPI is doing the send operation and isn't sending the complete set of HTTP headers along with the entity to `HTTP_COMPRESSION::DoDynamicCompression`. Since `DoDynamicCompression` doesn't receive all the data from the ISAPI, we can't compress the response. Third party and/or non-Microsoft ISAPIs have been seen to do this by putting the headers in the function meant for the entity body or the entity body in the function meant for the HTTP headers, or by not providing any headers. When this happens, things like the ISAPI filter SF\_NOTIFY\_SEND\_RESPONSE, or AddResponseHeaders, or dynamic compression will fail. The ISAPI needs to put the headers and the entity in the right locations, respectively.

1. Check if the response status code is something other than 200. In IIS 6 or 7, only responses with an HTTP 200 status will get compressed.

   Response with status codes other than 200 will not be compressed. You have to write an `HTTPModule` to achieve the same.

1. Check if the request contains a `Via: header`, the `Via headers` indicates that the request is coming to IIS through a proxy.

    Many proxies don't handle the compression header correctly and provide compressed data to clients when they aren't supposed to. So, by default, the compressed responses aren't allowed when the request has a Via header. You can override this by setting the `HcNoCompressionForProxies` metabase key to `True`.

1. Check if the request is for a static page, and the response contains document footer. Document footers will cause static compression to fail.

1. Check if the static compression isn't working. This may happen if you have a wildcard application mapping installed at the root level in IIS. For example, we have application mappings for the .html or .txt extensions on the server and this will make IIS consider your requests to .txt as dynamic requests instead of static and since .txt isn't an extension in the dynamic compression list, it doesn't get compressed.

1. Check if the IIS Compression and `Accept-Encoding: identity` field is present.

    Per RFC2616, if an `Accept-Encoding` field is present in a request and if the server can't send a response, which is acceptable according to the `Accept-Encoding` header, then the server should send an error response with the 406 (Not Acceptable) status code. If no `Accept-Encoding` field is present in a request, the server might assume that the client will accept any content coding. In this case, if "identity" is one of the available content codes, then the server should use the "identity" content code, unless it has additional information that a different content-code is meaningful to the client.

1. Check if you are using ETW trace to troubleshoot IIS compression issue.

    Event Tracing for Windows (ETW) is a feature of the Windows OS that allows you to troubleshoot issues with HTTP requests.

    Here are the steps to troubleshooting IIS compression issue.

    1. Create a text file named *IISProviders.txt* and put follow content into the file."IIS: WWW Server" is the provider name, 0xFFFFFFFE means trace for all events, and 5 means verbose level.

    1. Open a command prompt, and run the following command.

       ```console
       logman start trace compressionTrace -pf IISProviders.txt -ets
       ```

    1. Reproduce the problem.
    1. Run the following command to stop the trace.

       ```console
        logman stop trace compressionTrace -ets
       ```

    1. Convert the trace to text file.

       Trace report converts the binary trace data into text and produces two files in the directory where you executed the `tracerpt` command:

       ```console
       tracerpt compressionTrace.etl
       ```

       - *Summary.txt* contains general details about the trace session, including which providers were used.

       - *DumpFile.csv* contains the actual trace data in a text format.

    1. Read the trace file to find useful information. Open the *dumpfile.csv*, and find keyword like COMPRESSION_NOT_SUCCESS. Here's an example:

       ```output
       IISCompression, STATIC_COMPRESSION_NOT_SUCCESS, 0x000008B0, 129744354075770195, 0, 0, {00000000-0000-0000-0700-0060000000bd}, "NO_MATCHING_SCHEME", 0, 0
       ```

      This error NO_MATCHING_SCHEME means that there weren't compression scheme matches for this extension or Accept-Encoding. For a detailed list of compression errors, see the [List of compression errors](#list-of-compression-errors).

1. Check if the FREB trace to troubleshooting IIS compression issue is used.

    For detailed steps, see [Troubleshooting Failed Requests Using Tracing in IIS 7](https://www.iis.net/learn/troubleshoot/using-failed-request-tracing/troubleshooting-failed-requests-using-tracing-in-iis).

    Here's an example of using IIS 7 FREB trace to troubleshoot compression issues.

    :::image type="content" source="media/troubleshooting-iis-compression-issues-in-iis6-iis7x/trace-compression-issues-by-error-messages.png" alt-text="Screenshot of tracing compression issues using the error messages.":::

## List of compression errors

   For a detailed list of compression errors, see the following table.

   > [!NOTE]
   > The following reasons apply to both IIS 6 and IIS 7.

   | Reason | Description |
   |--|--|
   | NO\_ACCEPT\_ENCODING | No Accept-Encoding sent by client. |
   | COMPRESSION\_DISABLED | compression is disabled because no suitable configuration was found. |
   | NO\_COMPRESSION\_10 | Server not configured to compress 1.0 requests. |
   | NO\_COMPRESSION\_PROXY | Server not configured to compress proxy requests. |
   | NO\_MATCHING\_SCHEME | No compression scheme matches for this extension/Accept-Encoding. |
   | UNKNOWN\_ERROR | Unknown error. |
   | NO\_COMPRESSION\_RANGE | Server not configured to compress range requests |
   | FILE\_TOO\_SMALL | File smaller than compression threshold. |
   | FILE\_ENCRYPTED | File encrypted. |
   | COMPRESS\_FILE\_NOT\_FOUND | Compressed copy does not exist. |
   | COMPRESS\_FILE\_STALE | Compressed copy out of date. |
   | NO\_MATCHING\_CONTENT\_TYPE | Server not configured to compress content-Type for this extension. |
   | HEADERS\_SENT\_TWICE | Headers being sent twice for the same response. |
   | NO\_HEADER\_SENT | No Headers sent before entity body send. |
   | NOT\_SUCCESS\_STATUS | The response status code is not successful (200). |
   | ALREADY\_CONTENT\_ENCODING | There is a content-encoding already present in the response. |

   > [!NOTE]
   > The following reasons apply to IIS 7 only.

   | Reason | Description |
   |--|--|
   | FOOTER\_ENABLED | Document footer enabled for static files. |
   | NOT\_FREQUENTLY\_HIT | URL hasn't been requested frequently enough to justify compression. |
   | FAIL\_TO\_COMPRESS | Compressed copy couldn't be created. |

## More information

- [HTTP Compression &lt;httpCompression&gt; in IIS 7](/iis/configuration/system.webServer/httpCompression/)
- [Configure Compression (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730629(v=ws.10))
