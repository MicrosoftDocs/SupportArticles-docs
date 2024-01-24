---
title: Use Visual C# to make a GET request
description: This article describes how to make a GET request to retrieve a web page from the Internet by using Visual C#.
ms.date: 07/17/2020
ms.custom: sap:Development
ms.reviewer: duncanma
ms.technology: development
---
# Using Visual C# to make a GET request

This article describes how to make a `GET` request to retrieve a Web page from the Internet by using Visual C#.

_Original product version:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 307023

## Summary

The Microsoft .NET Framework includes many useful classes for networking, including the ability to make web requests.

This article refers to the following .NET Framework Class Library namespaces:

- `System.Net`
- `System.IO`

## Requirements

The following list outlines the recommended hardware and software that you need:

- Windows
- Visual Studio

> [!NOTE]
> If you are behind a proxy server, you must have either an internal Web address or static proxy values (see steps 5 and 6 of the [Request a web page](#request-a-web-page) section) to test the code in this article.

## Request a web page

The ability to retrieve a Web page programmatically has a many uses. This ability was provided to Visual Basic programmers through the Internet Transfer Control or through direct coding against the Windows Internet (WinINet) APIs.

In .NET, the `System.Net` namespaces provide the `WebRequest` class to encapsulate a request for an Internet resource, and the `WebResponse` class to represent the data that is returned.

By using these objects, you can obtain a stream that represents the response for a particular request. When you have a stream, you can read the response just as you read from a local text file or from any other source.

To make a `GET` request, follow these steps:

1. Start Visual Studio.
2. Create a new console application in Visual C#. Visual Studio automatically creates a public class and an empty `Main` method.
3. Verify that the project references at least *System.dll*.
4. Use the using directive on the `System` namespace, the `System.NET` namespace, and the `System.IO` namespace (for the stream objects) so that you will not have to qualify declarations from these namespaces later in your code. These statements must be used before any other declarations.

    ```csharp
    using System;
    using System.Net;
    using System.IO;
    ```

5. For this example, hard-code the URL as a variable. In a real system, you would probably receive this value as a parameter to a function, or as a command-line argument to a console application.

    ```csharp
    string sURL;
    sURL = "http://www.contoso.com";
    ```

6. Create a new `WebRequest` object. You can do this only through the static `Create` method of the `WebRequest` class (*new* a `WebRequest` object is not valid). Supply the target URL as part of the call to `Create` to initialize the object that has this value.

    ```csharp
    WebRequest wrGETURL;
    wrGETURL = WebRequest.Create(sURL);
    ```

7. If you want to request URLs outside the local network, and you are behind a proxy, you must create a `WebProxy` object, and then provide this object to your `WebRequest` object. The `WebProxy` object has a variety of properties, which are not set in the sample code below, that let you specify the same basic information that you can set through the proxy settings in Internet Explorer.

    ```csharp
    WebProxy myProxy = new WebProxy("myproxy",80);
    myProxy.BypassProxyOnLocal = true;

    wrGETURL.Proxy = myProxy;
    ```

8. If you want to use the settings that were already configured in Internet Explorer, you can use the `GetDefaultProxy` static method of the `WebProxy` class.

    ```csharp
    wrGETURL.Proxy = WebProxy.GetDefaultProxy();
    ```

    > [!NOTE]
    > In Visual Studio 2005 or Visual Studio 2008, the `GetDefaultProxy` method works. However, this method has been deprecated. For more information about the `GetDefaultProxy` method in the .NET Framework 2.0, see [.NET Framework V2.0 Obsolete Type/Member List (By Assembly)](/previous-versions/aa497287(v=msdn.10)).

9. When you have completed the set-up of your request by setting the target URL and by giving any applicable proxy information, you can use your request to obtain a `Stream` object that corresponds to the response for your request.

    ```csharp
    Stream objStream;
    objStream = wrGETURL.GetResponse().GetResponseStream();
    ```

10. When you have the response stream, you can use the stream as you would use any other stream and you can read through the contents of the stream line by line, or even all at the same time. The following sample code loop reads the stream one line at a time until the `ReadLine` method returns null, by outputting each line to the console.

    ```csharp
    StreamReader objReader = new StreamReader(objStream);

    string sLine = "";
    int i = 0;

    while (sLine != null)
    {
        i++;
        sLine = objReader.ReadLine();
        if (sLine != null)
            Console.WriteLine("{0}:{1}", i, sLine);
    }
    Console.ReadLine();
    ```

11. Save and then run your program. Verify that you have configured the proxy information correctly for your environment (see steps 7 and 8). You should see lines of HTML content numbered and outputted to the console.

## Complete code listing

```csharp
using System;
using System.Net;
using System.IO;

namespace MakeAGETRequest_charp
{
    /// <summary>
    /// Summary description for Class1.
    /// </summary>
    class Class1
    {
        static void Main(string[] args)
        {
            string sURL;
            sURL = "http://www.contoso.com";

            WebRequest wrGETURL;
            wrGETURL = WebRequest.Create(sURL);

            WebProxy myProxy = new WebProxy("myproxy", 80);
            myProxy.BypassProxyOnLocal = true;

            wrGETURL.Proxy = WebProxy.GetDefaultProxy();

            Stream objStream;
            objStream = wrGETURL.GetResponse().GetResponseStream();

            StreamReader objReader = new StreamReader(objStream);

            string sLine = "";
            int i = 0;

            while (sLine != null)
            {
                i++;
                sLine = objReader.ReadLine();
                if (sLine != null)
                    Console.WriteLine("{0}:{1}", i, sLine);
            }
            Console.ReadLine();
        }
    }
}
```
