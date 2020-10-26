---
title: Persist or load ADO Recordset
description: This article describes how to persist/load ADO Recordset to/from an external xml file, ADO IStream Object and XML DOM object.
ms.date: 10/19/2020
ms.prod-support-area-path: 
ms.topic: how-to
---
# A C++ Sample of ADO Recordset XML Persistence

This article describes how to persist/load ADO Recordset to/from an external xml file, ADO IStream Object and XML DOM object.

_Original product version:_ &nbsp; ADO Recordset  
_Original KB number:_ &nbsp; 262450

## Summary

With ADO 2.5 and later, Recordset objects can be persisted into any object that implements the IStream interface. The sample code in this article shows how to persist/load ADO Recordset to/from an external xml file, ADO IStream Object and XML DOM object.

## More information

1. The sample uses authors table in the pubs database of SQL Server Database.

2. Modify the connection string to supply the right datasource name and user credentials.

3. Since there are two #import dll, for simplicity of programing, I rename the ADO(ADODB)namespace as MSXML, and use MSXML for the interfaces defined in both dlls. Alternatively, you can always prefix the interface with appropriate namespace without doing this.

> [!NOTE]
> You must change `User ID=<username>` and `Password=<strong password>` to the correct values before you run this code. Make sure that `User ID` has the appropriate permissions to perform this operation on the database.

```cpp
// 1. ADO Recordset <-> external xml file
// 2. ADO Recordset <-> ADO IStream Object
// 3. ADO Recordset <-> DOM Document

#import "C:\Program files\Common Files\System\Ado\msado15.dll" rename_namespace("MSXML") rename("EOF", "ADOEOF")

#import "c:\winnt\system32\msxml.dll"
using namespace MSXML;

#include "stdio.h"
#include "io.h"
void dump_error(_com_error &e); //exception handling

void main()
{
    HRESULT hr;
    CoInitialize(NULL);

    try
    {
            //open the connection, get the reocrdset ready
            _ConnectionPtr pConn;
            _RecordsetPtr pRs;

            hr = pConn.CreateInstance(__uuidof(Connection));
            hr = pRs.CreateInstance(__uuidof(Recordset));

            pConn->CursorLocation = adUseClient;
            _bstr_t strConn("Provider=sqloledb;Data Source=juliaj01;Initial Catalog=pubs;User Id=<username>;Password=<strong password>;");
            hr = pConn->Open(strConn, "<username>", "<strong password>", adConnectUnspecified);
            hr = pRs->Open("SELECT * from authors", pConn.GetInterfacePtr(), adOpenForwardOnly, adLockReadOnly, adCmdText);

            //preparation to save RS as xml file,
            struct _finddata_t xml_file;
            long hFile;
            if( (hFile = _findfirst("authors.xml", &xml_file ))!= -1L)
            {
                DeleteFile("authors.xml"); //if the file exists, delete it
            }

            // 1. Persist it to an external xml file by calling Save with file name and adPersistXML
            hr = pRs->Save("authors.xml", adPersistXML);

            // 2. Persist it to ADO IStream Object
            _StreamPtrpStream ; //declare one first
            pStream.CreateInstance(__uuidof(Stream)); //create it after
            hr = pRs->Save(pStream.GetInterfacePtr(), adPersistXML); //old trick, call Save 

            // 3. Persist it to DOM Document
            IXMLDOMDocumentPtr pXMLDOMDoc;
            pXMLDOMDoc.CreateInstance(__uuidof(DOMDocument));
            hr = pRs->Save(pXMLDOMDoc.GetInterfacePtr(), adPersistXML);
            // if you want to check out the content call printf(pXMLDOMDoc->Getxml());

            //Recycle the Recordset object
            hr = pRs->Close();

            // 4. load the recordset back from the file by calling Open with MSPersist provider and adCmdFile.
            // the Recordset will be a ReadOnly, Forwardly only
            hr = pRs->Open("authors.xml","Provider=MSPersist;",adOpenForwardOnly,adLockReadOnly,adCmdFile);
            hr = pRs->Close();

            // 5. Load from IStream object, call Open, first param is pStream.GetInterfacePtr()

            // Set the steam object position to the beginning of the stream:
            pStream->Position = 0;

            // call Open, passing in vtMissing for connection string, see Q245485 for details
            hr = pRs->Open(pStream.GetInterfacePtr(),vtMissing, adOpenForwardOnly,adLockReadOnly,adCmdFile);

            hr = pRs->Close();

            // 6 .Load from DOM Document, call Open, first param is pXMLDOMDoc.GetInterfacePtr() and
            // pass in vtMissing for connection string, see Q245485

            hr = pRs->Open(pXMLDOMDoc.GetInterfacePtr(), vtMissing, adOpenForwardOnly, adLockReadOnly, adCmdFile);

            hr = pRs->Close();

            //Don't forget to clean up the stream object
            hr = pStream->Close();

            }
            catch(_com_error &e)
            {
                dump_error(e);
            }
}

void dump_error(_com_error &e)
{
    _bstr_t bstrSource(e.Source());
    _bstr_t bstrDescription(e.Description());

    // Print Com errors.
    printf("Error\n");
    printf("\tCode = %08lx\n", e.Error());
    printf("\tCode meaning = %s", e.ErrorMessage());
    printf("\tSource = %s\n", (LPCSTR) bstrSource);
    printf("\tDescription = %s\n", (LPCSTR) bstrDescription);
}

```

> [!NOTE]
> The sample code provided in this article contains a reference to MSXML 2.5 or earlier. If a newer version of MSXML has been installed in replace mode on your machine, the sample code will automatically use this new version. If a newer version of MSXML has been installed in side-by-side mode on your machine, the code may use the older version.

To run the code with MSXML 6.0, the following lines of code have to be changed:

- Replace:

    ```cpp
    #import "C:\Program files\Common Files\System\Ado\msado15.dll" rename_namespace("MSXML") rename("EOF", "ADOEOF")

    #import "c:\winnt\system32\msxml.dll" by using namespace MSXML;
    ```

    With:

    ```cpp
    #import "C:\Program files\Common Files\System\Ado\msado15.dll" rename_namespace("MSXML2") rename("EOF", "ADOEOF")

    #import "c:\winnt\system32\msxml6.dll" using namespace MSXML2;
    ```

- Replace:

    ```cpp
    pXMLDOMDoc.CreateInstance(__uuidof(DOMDocument));
    ```

    With:

    ```cpp
    pXMLDOMDoc.CreateInstance(__uuidof(DOMDocument60));
    To run the code with MSXML 6.0, the following lines of code have to be changed:
    ```

- Replace:

    ```cpp
    #import "C:\Program files\Common Files\System\Ado\msado15.dll" rename_namespace("MSXML") rename("EOF", "ADOEOF")

    #import "c:\winnt\system32\msxml.dll" by using namespace MSXML;
    ```

    With:

    ```cpp
    #import "C:\Program files\Common Files\System\Ado\msado15.dll" rename_namespace("MSXML2") rename("EOF", "ADOEOF")

    #import "c:\winnt\system32\msxml6.dll" using namespace MSXML2;
    ```

- Replace:

    ```cpp
    pXMLDOMDoc.CreateInstance(__uuidof(DOMDocument));
    ```

    With:

    ```cpp
    pXMLDOMDoc.CreateInstance(__uuidof(DOMDocument60));
    ```
