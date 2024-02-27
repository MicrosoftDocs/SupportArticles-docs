---
title: Save message to MSG compound file
description: Describes how to save a message to a compound document, specifically an .msg file.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto: 
search.appverid: MET150
ms.reviewer: v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# INFO: Save message to MSG compound file

## Summary

This article contains code that demonstrates how to save a message to a compound document, specifically an .msg file that is readable by any client that supports the .msg file format.

## More information

The function below takes a valid message object as an in parameter and uses its properties to create a duplicate of the message and save it to a compound file using the .msg format. The subject line of the message is used as the file name of the new file.

> [!NOTE]
> Special characters in the subject line of the in parameter of this function can cause unexpected results. While code can be written to avoid special characters in the subject line, it is not germane to the topic and such code is intentionally left out.

```cpp
#define INITGUID
#include <objbase.h>

#define USES_IID_IMessage

#include <mapix.h>
#include <mapitags.h>
#include <mapidefs.h>
#include <mapiutil.h>
#include <mapiguid.h>
#include <imessage.h>

// {00020D0B-0000-0000-C000-000000000046}
DEFINE_GUID(CLSID_MailMessage,
0x00020D0B,
0x0000, 0x0000, 0xC0, 0x00, 0x0, 0x00, 0x0, 0x00, 0x00, 0x46);

HRESULT SaveToMSG ( LPMESSAGE pMessage )
{
 HRESULT hRes = S_OK;
 LPSPropValue pSubject = NULL;
 LPSTORAGE pStorage = NULL;
 LPMSGSESS pMsgSession = NULL;
 LPMESSAGE pIMsg = NULL;
 SizedSPropTagArray ( 7, excludeTags );
 char szPath[_MAX_PATH];
 char strAttachmentFile[_MAX_PATH];
 LPWSTR lpWideCharStr = NULL;
 ULONG cbStrSize = 0L;

// create the file name in the directory where "TMP" is defined
 // with subject as the filename and ".msg" extension.

// get temp file directory
 GetTempPath(_MAX_PATH, szPath);

// get subject line of message to copy. This will be used as the
 // new file name.
 HrGetOneProp( pMessage, PR_SUBJECT, &pSubject );

// fuse path, subject, and suffix into one string
 strcpy ( strAttachmentFile, szPath );
 strcat ( strAttachmentFile, pSubject->Value.lpszA );
 strcat ( strAttachmentFile, ".msg");

// get memory allocation function
 LPMALLOC pMalloc = MAPIGetDefaultMalloc();

// Convert new file name to WideChar
 cbStrSize = MultiByteToWideChar (CP_ACP,
 MB_PRECOMPOSED,
 strAttachmentFile,
 -1, lpWideCharStr, 0);

MAPIAllocateBuffer ( cbStrSize * sizeof(WCHAR),
 (LPVOID *)&lpWideCharStr );

MultiByteToWideChar (CP_ACP,
 MB_PRECOMPOSED,
 strAttachmentFile,
 -1, lpWideCharStr, cbStrSize );

// create compound file
 hRes = ::StgCreateDocfile(lpWideCharStr,
 STGM_READWRITE |
 STGM_TRANSACTED |
 STGM_CREATE, 0, &pStorage);

// Open an IMessage session.
 hRes = ::OpenIMsgSession(pMalloc, 0, &pMsgSession);

// Open an IMessage interface on an IStorage object
 hRes = ::OpenIMsgOnIStg(pMsgSession,
 MAPIAllocateBuffer,
 MAPIAllocateMore,
 MAPIFreeBuffer,
 pMalloc,
 NULL,
 pStorage,
 NULL, 0, 0, &pIMsg);

// write the CLSID to the IStorage instance - pStorage. This will
 // only work with clients that support this compound document type
 // as the storage medium. If the client does not support
 // CLSID_MailMessage as the compound document, you will have to use
 // the CLSID that it does support.
 hRes = WriteClassStg(pStorage, CLSID_MailMessage );

// Specify properties to exclude in the copy operation. These are
 // the properties that Exchange excludes to save bits and time.
 // Should not be necessary to exclude these, but speeds the process
 // when a lot of messages are being copied.
 excludeTags.cValues = 7;
 excludeTags.aulPropTag[0] = PR_ACCESS;
 excludeTags.aulPropTag[1] = PR_BODY;
 excludeTags.aulPropTag[2] = PR_RTF_SYNC_BODY_COUNT;
 excludeTags.aulPropTag[3] = PR_RTF_SYNC_BODY_CRC;
 excludeTags.aulPropTag[4] = PR_RTF_SYNC_BODY_TAG;
 excludeTags.aulPropTag[5] = PR_RTF_SYNC_PREFIX_COUNT;
 excludeTags.aulPropTag[6] = PR_RTF_SYNC_TRAILING_COUNT;

// copy message properties to IMessage object opened on top of
 // IStorage.
 hRes = pMessage->CopyTo(0, NULL,
 (LPSPropTagArray)&excludeTags,
 NULL, NULL,
 (LPIID)&IID_IMessage,
 pIMsg, 0, NULL );

// save changes to IMessage object.
 pIMsg -> SaveChanges ( KEEP_OPEN_READWRITE );

// save changes in storage of new doc file
 hRes = pStorage -> Commit(STGC_DEFAULT);

// free objects and clean up memory
 MAPIFreeBuffer ( lpWideCharStr );
 pStorage->Release();
 pIMsg->Release();
 CloseIMsgSession ( pMsgSession );

pStorage = NULL;
 pIMsg = NULL;
 pMsgSession = NULL;
 lpWideCharStr = NULL;

return hRes;
}
```

All versions of Outlook and the Exchange Client support CLSID_MailMessage as the compound document. The only reason to use a different CLSID is to support other clients that use a different CLISD when you write messages to structured storage.

When saving messages that have a large number of recipients or attachments, it's possible that the CopyTo operation will fail with MAPI_E_NOT_ENOUGH_MEMORY. This is due to a known problem with structured storage and streams. Every time that a new attachment or recipient is added to the message being saved in structured storage, a new Root Storage File is opened. These files are not closed until the transaction is completed. Because the operating system imposes a limit on the number of simultaneously open root storage files, there's no known workaround.
