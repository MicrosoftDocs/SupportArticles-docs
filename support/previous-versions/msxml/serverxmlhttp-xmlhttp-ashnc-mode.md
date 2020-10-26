---
title: ServerXMLHTTP or XMLHTTP in async mode
description: This article describes you must use a message pump to receive and dispatch messages.
ms.date: 10/20/2020
ms.prod-support-area-path: 
ms.prod: visual-cpp
---
# Visual C++ application uses ServerXMLHTTP or XMLHTTP in async mode must pump messages

This article describes you  must use a message pump to receive and dispatch messages.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 303326

## Summary

Starting with MSXML version 3.0, the XMLHTTP request object uses Urlmon.dll. If you set the async parameter to **VARIANT_TRUE** when you call the `open` method, URLMON uses the message queue mechanism to notify the application when data becomes available, and the `readyState` property of the XMLHTTP request object is changed, as in the following example:

```cpp
hr=pXMLHTTPReq->open("POST", "http://www.server1.com/test.asp", VARIANT_TRUE);
```

In a Visual C++ application, you must use a message pump to receive and dispatch messages. If the application does not handle the incoming messages properly, the application may stop responding (hang) because the `readystate` property of the XMLHTTP request object is not changed.

> [!NOTE]
> This issue is specific to Visual C++ developers.

> [!NOTE]
> This information is specific to Windows XP. By default, Windows XP ships with MSXML3.0 Service Pack 2 (SP2).

## More information

With the MSXML 2.5 parser that ships with Microsoft Windows 2000, no such message pump is needed. With Windows XP, MSXML 3.0 SP2 is installed in Replace mode, so you may encounter this problem.

The following is a sample implementation of the message pump with the XMLHTTP request object. To test it, paste the code into a .cpp file, then compile and run the file as a Win32 Console application project.

```cpp
#import "msxml3.dll"
using namespace MSXML2; // For Msxml3.dll.

#include "stdio.h"

void dump_com_error(_com_error &e)
{
    printf("Error\n");
    printf("\a\tCode = %08lx\n", e.Error());
    printf("\a\tCode meaning = %s", e.ErrorMessage());
    _bstr_t bstrSource(e.Source());
    _bstr_t bstrDescription(e.Description());
    printf("\a\tSource = %s\n", (LPCSTR) bstrSource);
    printf("\a\tDescription = %s\n", (LPCSTR) bstrDescription);
}

int main()
{
    HRESULT hr = CoInitialize(NULL);

    try{
        IXMLHTTPRequestPtr pXMLHTTPReq = NULL;
        hr=pXMLHTTPReq.CreateInstance(__uuidof(XMLHTTP30));

        //Uncomment the following lines if you are using ServerXMLHTTPRequest.
        //IServerXMLHTTPRequestPtr pXMLHTTPReq = NULL;
        //hr=pXMLHTTPReq.CreateInstance(__uuidof(ServerXMLHTTP30));

        hr=pXMLHTTPReq->open("POST", "http://www.server1.com/test1.asp", VARIANT_TRUE);

        hr = pXMLHTTPReq->setRequestHeader("charset", "UTF-8");
        hr=pXMLHTTPReq->send("<?xml version=\"1.0\" encoding=\"UTF-8\"?><REQUEST>request1</REQUEST>");

        long readyState = READYSTATE_UNINITIALIZED;
        MSG msg;
        while (readyState != READYSTATE_COMPLETE)
        {
            //Without this message pump, readyState does not change.
            if (PeekMessage(&msg, 0, 0 ,0, PM_REMOVE))
            {
                TranslateMessage (&msg);
                DispatchMessage (&msg);
            }

            readyState = pXMLHTTPReq->GetreadyState();

        }
        MessageBox(NULL, "readyState is COMPLETE ", "readystate", MB_OK);

        long status= pXMLHTTPReq->Getstatus();
    }
    catch(_com_error &e)
    {
        dump_com_error(e);
    }
    return 0;
}
```

> [!NOTE]
> Asynchronous processing in practice is more complicated. You should test your application in synchronous mode before you try to use asynchronous mode.

When you use the `SeverXMLHTTPRequest` object, you must run the Proxycfg utility to set the proxy information. For more information, see [Frequently asked questions about ServerXMLHTTP](https://support.microsoft.com/help/290761).

ServerXMLHTTP does not use Urlmon.dll. However, when you use ServerXMLHTTP in asynchronous mode, you also need this message pump because the parser fires the event by posting messages back to the thread.

ServerXMLHTTP also includes a method called `waitForResponse` that is not available with XMLHTTP. The `waitForResponse` waits while an asynchronous request is processed. The `waitForResponse` method pumps window messages automatically, so the client's application code does not need to do this. This allows the application code to be simplified, as follows:

```cpp
hr=pXMLHTTPReq.CreateInstance(__uuidof(ServerXMLHTTP30));

hr=pXMLHTTPReq->open("POST", "http://www.server1.com/test1.asp", VARIANT_TRUE);

hr = pXMLHTTPReq->setRequestHeader("charset", "UTF-8");
hr=pXMLHTTPReq->send("<?xml version=\"1.0\" encoding=\"UTF-8\"?><REQUEST>request1</REQUEST>");

VARIANT Timeout;
VariantInit(&Timeout);
Timeout.vt = VT_I4;
Timeout.lVal = 60; // Timeout value of 60 seconds.

VARIANT_BOOL bSucceeded;
//Passing vtMissing as the first parameter sets the timeout value to infinite.
hr = pXMLHTTPReq->waitForResponse(Timeout, &bSucceeded);

long status= pXMLHTTPReq->Getstatus();
```
