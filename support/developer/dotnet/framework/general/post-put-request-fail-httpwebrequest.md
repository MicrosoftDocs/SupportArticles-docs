---
title: HttpWebRequest fails to send lots of data
description: This article discusses a problem where a POST or PUT request fails when you use the HttpWebRequest class to send lots of data on a computer on which the .NET Framework is installed.
ms.date: 05/06/2020
---
# A POST or PUT request fails when you use the HttpWebRequest class to send lots of data

This article helps you resolve a problem where an error may be thrown when you use the `HttpWebRequest` class to send lots of data on a computer that is running the Microsoft .NET Framework.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 908573

## Symptoms

When you use the `HttpWebRequest` class to send lots of data by using a `POST` or `PUT` request, the request might fail on a computer that is running the .NET Framework. Additionally, you may receive an out-of-memory or time-out error message.

If you don't receive an out-of-memory or time-out error message, you may notice that the application that uses the `HttpWebRequest` class uses lots of memories. When you use Performance Monitor to monitor the application that uses the `HttpWebRequest` class, the Private Bytes count will continue to increase as data is sent. So you may also experience slow performance on the computer and in other applications because increased memory and resource utilization occurs.

> [!NOTE]
> The amount of data that can be uploaded by default will vary according to the memory and the resources that are available on the computer.

## Cause

This issue occurs because the .NET Framework buffers the outgoing data by default when you use the `HttpWebRequest` class.

## Workaround

To work around this issue, set the `HttpWebRequest.AllowWriteStreamBuffering` property to false.

## Error caused by the workaround

You may receive an error message like the following example when you set the `HttpWebRequest.AllowWriteStreamBuffering` property to false:

> This request requires buffering of data for authentication of redirection to be successful.

To successfully send lots of data by using a `POST` or `PUT` request when the `HttpWebRequest.AllowWriteStreamBuffering` property is set to false, use one of the following methods, depending on the authentication method that you want to use.

### Anonymous authentication

If the Web server is configured to use anonymous authentication, set the `HttpWebRequest.AllowWriteStreamBuffering` property to false. No other changes are needed.

### Basic authentication

If the Internet Information Services (IIS) Web server is configured to use basic authentication, and you can set the `HttpWebRequest.AllowWriteStreamBuffering` property to false, you must send a `HEAD` request to pre-authenticate the connection before you send the `POST` or `PUT` request. You should also set the
`HttpWebRequest.PreAuthenticate` property to true. Then, send the `POST` or `PUT` request, and then receive the response. To do it, use code like the following code example.

```csharp
public void test(Uri URL)
{
    HttpWebRequest WRequest;
    HttpWebResponse WResponse;
    //preAuth the request
    // You can add logic so that you only pre-authenticate the very first request.
    // You should not have to pre-authenticate each request.
    WRequest = (HttpWebRequest)HttpWebRequest.Create(URL);
    // Set the username and the password.
    WRequest.Credentials = new NetworkCredential(user, password);
    WRequest.PreAuthenticate = true;
    WRequest.UserAgent = "Upload Test";
    WRequest.Method = "HEAD";
    WRequest.Timeout = 10000;
    WResponse = (HttpWebResponse)WRequest.GetResponse();
    WResponse.Close();
    // Make the real request.
    WRequest = (HttpWebRequest)HttpWebRequest.Create(URL);
    // Set the username and the password.
    WRequest.Credentials = new NetworkCredential(user, password);
    WRequest.PreAuthenticate = true;
    WRequest.UserAgent = "Upload Test";
    WRequest.Method = "POST";
    WRequest.AllowWriteStreamBuffering = false;
    WRequest.Timeout = 10000;
    FileStream ReadIn = new FileStream("c:\\testuploadfile.txt", FileMode.Open, FileAccess.Read);
    ReadIn.Seek(0, SeekOrigin.Begin); // Move to the start of the file.
    WRequest.ContentLength = ReadIn.Length; // Set the content length header to the size of the file.
    Byte[] FileData = new Byte[ReadIn.Length]; // Read the file in 2 KB segments.
    int DataRead = 0;
    Stream tempStream = WRequest.GetRequestStream();
    do
    {
        DataRead = ReadIn.Read(FileData,0,2048);
        if (DataRead > 0) //we have data
        {
            tempStream.Write(FileData,0,DataRead);
            Array.Clear(FileData,0, 2048); // Clear the array.
        }
    } while (DataRead > 0);

    WResponse = (HttpWebResponse)WRequest.GetResponse();
    // Read your response data here.
    // Close all streams.
    ReadIn.Close();
    tempStream.Close();
    WResponse.Close();
}
```

> [!NOTE]
> Depending on how the application is designed, you may not have to pre-authenticate each request by sending a `HEAD` request.

### Integrated Windows authentication

You can configure a computer on which IIS is installed to respond by using Negotiate or Windows Challenge/Response (NTLM) Windows authentication. If IIS is configured to use Negotiate for Windows authentication, the client can use either Kerberos or NTLM to authenticate. If IIS is configured to use NTLM authentication, only NTLM authentication can be used, and Kerberos authentication isn't supported.

If Negotiate with Kerberos authentication is used, use the following workaround. The workaround will fail if NTLM is used.

#### Negotiate with Kerberos authentication

If the IIS Web server is configured to use Negotiate authentication and you must set the `HttpWebRequest.AllowWriteStreamBuffering` property to false, you must send a HEAD request to pre-authenticate the connection before you send the POST or PUT request. You can also set the `HttpWebRequest.PreAuthenticate` property to true. Additionally, you may have to set the `HttpWebRequest.UnsafeAuthenticatedConnectionSharing` property to true. Then, send the POST or PUT request, and then receive the response. To do it, you can use code that is similar to the following code example.

> [!NOTE]
> This workaround will fail if the client can't use Kerberos with Negotiate authentication. You also must make sure that the `HttpWebRequest.KeepAlive` property is set to true. By default, the setting for the `HttpWebRequest.KeepAlive` property is true. The logic for Kerberos and Basic authentication is almost the same.

```csharp
public void test(Uri URL)
{
    HttpWebRequest WRequest;
    HttpWebResponse WResponse;
    CredentialCache myCredCache = new CredentialCache();
    myCredCache.Add(URL,"Negotiate",(NetworkCredential) CredentialCache.DefaultCredentials);
    // Pre-authenticate the request.
    WRequest = (HttpWebRequest)HttpWebRequest.Create(URL);
    // Set the username and the password.
    WRequest.Credentials = myCredCache;
    // This property must be set to true for Kerberos authentication.
    WRequest.PreAuthenticate = true;
    // Keep the connection alive.
    WRequest.UnsafeAuthenticatedConnectionSharing = true;
    WRequest.UserAgent = "Upload Test";
    WRequest.Method = "HEAD";
    WRequest.Timeout = 10000;
    WResponse = (HttpWebResponse)WRequest.GetResponse(); 
    WResponse.Close();
    // Make the real request.
    WRequest = (HttpWebRequest)HttpWebRequest.Create(URL);
    // Set the username and the password.
    WRequest.Credentials = myCredCache;
    // This property must be set to true for Kerberos authentication.
    WRequest.PreAuthenticate = true;
    // Keep the connection alive.
    WRequest.UnsafeAuthenticatedConnectionSharing = true;
    WRequest.UserAgent = "Upload Test";
    WRequest.Method = "POST";
    WRequest.AllowWriteStreamBuffering = false;
    WRequest.Timeout = 10000;
    FileStream ReadIn = new FileStream("c:\\testuploadfile.txt ", FileMode.Open, FileAccess.Read);
    ReadIn.Seek(0, SeekOrigin.Begin); // Move to the start of the file.
    WRequest.ContentLength = ReadIn.Length; // Set the content length header to the size of the file.
    Byte[] FileData = new Byte[ReadIn.Length]; // Read the file in 2 KB segments.
    int DataRead = 0;
    Stream tempStream = WRequest.GetRequestStream();
    do
    {
        DataRead = ReadIn.Read(FileData,0,2048);
        if (DataRead > 0) // We have data.
        {
            tempStream.Write(FileData,0,DataRead);
            Array.Clear(FileData,0, 2048); // Clear the array.
        }
    }while(DataRead > 0);

    WResponse = (HttpWebResponse)WRequest.GetResponse(); 
    // Read your response data here.
    // Close all streams
    ReadIn.Close();
    tempStream.Close();
    WResponse.Close();
}
```

> [!NOTE]
> Depending on how the application is designed, you may not have to pre-authenticate each request by sending a HEAD request.

#### NTLM authentication

If the IIS Web server is also configured to use NTLM authentication with Windows-Integrated authentication, and you must set the `HttpWebRequest.AllowWriteStreamBuffering` property to false, you can set the authentication type to NTLM in the client code. After you configure IIS to use both Negotiate and NTLM authentication and you set the authentication type to NTLM in the client code, you can configure how IIS handles authentication requests by setting the `AuthPersistSingleRequest` property in the IIS metabase to false.

> [!NOTE]
> For more information about how to configure IIS to support both Negotiate and NTLM authentication, see the [References](#references) section.

You must also send a `HEAD` request to pre-authenticate the connection before you send the `POST` request and set the `HttpWebrequest.UnsafeAuthenticatedConnectionSharing` property to
true. Then, set the `HttpWebRequest.PreAuthenticate` property to false. Finally, send the `POST` or `PUT` request, and then receive the response. To do it, use code that is similar to the following code example.

```csharp
public void test(Uri URL)
{
    HttpWebRequest WRequest;
    HttpWebResponse WResponse;
    CredentialCache myCredCache = new CredentialCache();
    myCredCache.Add(URL,"NTLM",(NetworkCredential) CredentialCache.DefaultCredentials);
    // Pre-authenticate the request.
    WRequest = (HttpWebRequest)HttpWebRequest.Create(URL);
    // Set the username and the password.
    WRequest.Credentials = myCredCache;
    // For NTLM authentication, you must set the following property to true
    // so the connection does not close.
    WRequest.UnsafeAuthenticatedConnectionSharing = true;
    WRequest.UserAgent = "Upload Test";
    WRequest.Method = "HEAD";
    WRequest.Timeout = 10000;
    WResponse = (HttpWebResponse)WRequest.GetResponse(); 
    WResponse.Close();
    // Make the real request.
    WRequest = (HttpWebRequest)HttpWebRequest.Create(URL);
    // Set the username and the password.
    WRequest.Credentials = myCredCache;
    // For NTLM authentication, you must set the following property to true
    // so the connection does not close.
    WRequest.UnsafeAuthenticatedConnectionSharing = true;
    WRequest.UserAgent = "Upload Test";
    WRequest.Method = "POST";
    WRequest.AllowWriteStreamBuffering = false;
    WRequest.Timeout = 10000;
    FileStream ReadIn = new FileStream("c:\\ testuploadfile.txt", FileMode.Open, FileAccess.Read);
    ReadIn.Seek(0, SeekOrigin.Begin); // Move to the start of the file.
    WRequest.ContentLength = ReadIn.Length; // Set the content length header to the size of the file.
    Byte[] FileData = new Byte[ReadIn.Length]; // Read the file in 2 KB segments.
    int DataRead = 0;
    Stream tempStream = WRequest.GetRequestStream();
    do
    {
        DataRead = ReadIn.Read(FileData,0,2048);
        if (DataRead > 0) // We have data.
        {
            tempStream.Write(FileData,0,DataRead);
            Array.Clear(FileData,0, 2048); // Clear the array.
        }
    }while(DataRead > 0);

    WResponse = (HttpWebResponse)WRequest.GetResponse();
    // Read your response data here.
    // Close all streams.
    ReadIn.Close();
    tempStream.Close();
    WResponse.Close();
}
```

> [!NOTE]
> Depending on how the application is designed, you might not have to pre-authenticate each request by sending a `HEAD` request.

## References

- [HttpWebRequest.AllowWriteStreamBuffering Property](/dotnet/api/system.net.httpwebrequest.allowwritestreambuffering)

- [HttpWebRequest.PreAuthenticate Property](/dotnet/api/system.net.httpwebrequest.preauthenticate)

- [HttpWebRequest.UnsafeAuthenticatedConnectionSharing Property](/dotnet/api/system.net.httpwebrequest.unsafeauthenticatedconnectionsharing)

- [Microsoft Negotiate](/windows/win32/secauthn/microsoft-negotiate)

- [Microsoft NTLM](/windows/win32/secauthn/microsoft-ntlm)
