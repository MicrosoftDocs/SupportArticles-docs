---
title: How to list messages in the inbox with MAPI
description: Describes how to use MAPI to list the messages contained within the Inbox.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Microsoft Office Outlook 2007
search.appverid: MET150
ms.reviewer: SGRIFFIN, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# How to list messages in the inbox with MAPI

## Summary

Extended MAPI can be used to access a Mailbox and manipulate messages. This article demonstrates how to use MAPI to list the messages contained within the Inbox.

## More information

The following sample code demonstrates how to use MAPI to list the messages contained within the Inbox.

- Open Visual C++ and create a new Win32 Console Application.
- Name the project "GetInbox".
- Cut and paste the following code in the GetInbox.cpp file generated such that you replace the "main" procedure but leave the include files.
- Add MAPI32.lib to the Project settings under the Link tab.
- Compile and run the application.

```cpp
 #include <stdio.h>
 #include <conio.h>
 #include <mapix.h>
 #include <mapiutil.h>

STDMETHODIMP ListMessages(
 LPMDB lpMDB,
 LPMAPIFOLDER lpInboxFolder);

STDMETHODIMP OpenDefaultMessageStore(
 LPMAPISESSION lpMAPISession,
 LPMDB * lpMDB);

STDMETHODIMP OpenInbox(
 LPMDB lpMDB,
 LPMAPIFOLDER *lpInboxFolder);

void main() 
 {
 HRESULT hRes;
 LPMAPISESSION lpMAPISession = NULL;
 LPMDB lpMDB = NULL;
 LPMAPIFOLDER lpInboxFolder = NULL;
 LPSPropValue tmp = NULL;

hRes = MAPIInitialize(NULL);
 if (FAILED(hRes)) goto quit;

hRes = MAPILogonEx(0,
 NULL,//profile name
 NULL,//password - This parameter should ALWAYS be NULL
 MAPI_LOGON_UI, //Allow a profile picker box to show if not logged in
 &lpMAPISession);//handle of session
 if (FAILED(hRes)) goto quit;

hRes = OpenDefaultMessageStore(
 lpMAPISession,
 &lpMDB);
 if (FAILED(hRes)) goto quit;

hRes = OpenInbox(
 lpMDB,
 &lpInboxFolder);
 if (FAILED(hRes)) goto quit;

//Checking to see that we did get the Inbox
 hRes = HrGetOneProp(
 lpInboxFolder,
 PR_DISPLAY_NAME,
 &tmp);
 if (FAILED(hRes)) goto quit;
 printf("I managed to open the folder '%s'\n",tmp->Value.lpszA);

hRes = ListMessages(
 lpMDB,
 lpInboxFolder);
 if (FAILED(hRes)) goto quit;

quit:
 if (tmp) MAPIFreeBuffer(tmp);
 UlRelease(lpInboxFolder);
 UlRelease(lpMDB);
 UlRelease(lpMAPISession);
 MAPIUninitialize();
 if (FAILED(hRes))
 {
 printf("Failed with hRes of %x\n",hRes);
 }
 printf("Hit any key to continue\n");
 while(!_kbhit()){ Sleep(50);};

}

STDMETHODIMP ListMessages(
 LPMDB lpMDB,
 LPMAPIFOLDER lpInboxFolder)
 {
 HRESULT hRes = S_OK;
 LPMAPITABLE lpContentsTable = NULL;
 LPSRowSet pRows = NULL;
 LPSTREAM lpStream = NULL;
 ULONG i;

//You define a SPropTagArray array here using the SizedSPropTagArray Macro
 //This enum will allows you to access portions of the array by a name instead of a number.
 //If more tags are added to the array, appropriate constants need to be added to the enum.
 enum {
 ePR_SENT_REPRESENTING_NAME,
 ePR_SUBJECT,
 ePR_BODY,
 ePR_PRIORITY,
 ePR_ENTRYID,
 NUM_COLS};
 //These tags represent the message information we would like to pick up
 static SizedSPropTagArray(NUM_COLS,sptCols) = { NUM_COLS,
 PR_SENT_REPRESENTING_NAME,
 PR_SUBJECT,
 PR_BODY,
 PR_PRIORITY,
 PR_ENTRYID
 };

hRes = lpInboxFolder->GetContentsTable(
 0,
 &lpContentsTable);
 if (FAILED(hRes)) goto quit;

hRes = HrQueryAllRows(
 lpContentsTable,
 (LPSPropTagArray) &sptCols,
 NULL,//restriction...we're not using this parameter
 NULL,//sort order...we're not using this parameter
 0,
 &pRows);
 if (FAILED(hRes)) goto quit;

for (i = 0; i < pRows -> cRows; i++)
 {
 LPMESSAGE lpMessage = NULL;
 ULONG ulObjType = NULL;
 LPSPropValue lpProp = NULL;

printf("Message %d:\n",i);
 if (PR_SENT_REPRESENTING_NAME == pRows -> aRow[i].lpProps[ePR_SENT_REPRESENTING_NAME].ulPropTag)
 { 
 printf("From: %s\n",pRows->aRow[i].lpProps[ePR_SENT_REPRESENTING_NAME].Value.lpszA);
 } 
 if (PR_SUBJECT == pRows -> aRow[i].lpProps[ePR_SUBJECT].ulPropTag)
 { 
 printf("Subject: %s\n",pRows->aRow[i].lpProps[ePR_SUBJECT].Value.lpszA);
 } 
 if (PR_PRIORITY == pRows -> aRow[i].lpProps[ePR_PRIORITY].ulPropTag)
 { 
 printf("Priority: %d\n",pRows->aRow[i].lpProps[ePR_PRIORITY].Value.l);
 } 

//the following method of printing PR_BODY will not always get the whole body
/* if (PR_BODY == pRows -> aRow[i].lpProps[ePR_BODY].ulPropTag)
 { 
 printf("Body: %s\n",pRows->aRow[i].lpProps[ePR_BODY].Value.lpszA);
 }
*/ 

//PR_BODY needs some special processing...
 //The table will only return a portion of the PR_BODY...if you want it all, we should
 //open the message and retrieve the property. GetProps (which HrGetOneProp calls
 //underneath) will do for most messages. For some larger messages, we would need to 
 //trap for MAPI_E_NOT_ENOUGH_MEMORY and call OpenProperty to get a stream on the body.

if (MAPI_E_NOT_FOUND != pRows -> aRow[i].lpProps[ePR_BODY].Value.l)
 {
 hRes = lpMDB->OpenEntry(
 pRows->aRow[i].lpProps[ePR_ENTRYID].Value.bin.cb,
 (LPENTRYID) pRows->aRow[i].lpProps[ePR_ENTRYID].Value.bin.lpb,
 NULL,//default interface
 MAPI_BEST_ACCESS,
 &ulObjType,
 (LPUNKNOWN *) &lpMessage);
 if (!FAILED(hRes))
 {
 hRes = HrGetOneProp(
 lpMessage,
 PR_BODY,
 &lpProp);
 if (hRes == MAPI_E_NOT_ENOUGH_MEMORY)
 {
 char szBuf[255];
 ULONG ulNumChars;
 hRes = lpMessage->OpenProperty(
 PR_BODY,
 &IID_IStream,
 STGM_READ,
 NULL,
 (LPUNKNOWN *) &lpStream);

do
 {
 lpStream->Read(
 szBuf,
 255,
 &ulNumChars);
 if (ulNumChars >0) printf("%.*s",ulNumChars,szBuf);
 }
 while (ulNumChars >= 255);

printf("\n");

hRes = S_OK;
 }
 else if (hRes == MAPI_E_NOT_FOUND)
 {
 //This is not an error. Many messages do not have bodies.
 printf("Message has no body!\n");
 hRes = S_OK;
 }
 else
 {
 printf("Body: %s\n",lpProp->Value.lpszA);
 }
 }
 }

MAPIFreeBuffer(lpProp);
 UlRelease(lpMessage);
 hRes = S_OK;

}

quit:
 FreeProws(pRows);
 UlRelease(lpContentsTable);
 return hRes;
 }

STDMETHODIMP OpenInbox(
 LPMDB lpMDB,
 LPMAPIFOLDER *lpInboxFolder)
 {
 ULONG cbInbox;
 LPENTRYID lpbInbox;
 ULONG ulObjType;
 HRESULT hRes = S_OK;
 LPMAPIFOLDERlpTempFolder = NULL;

*lpInboxFolder = NULL;

//The Inbox is usually the default receive folder for the message store
 //You call this function as a shortcut to get it's Entry ID
 hRes = lpMDB->GetReceiveFolder(
 NULL, //Get default receive folder
 NULL, //Flags
 &cbInbox, //Size and ...
 &lpbInbox, //Value of the EntryID to be returned
 NULL); //You don't care to see the class returned
 if (FAILED(hRes)) goto quit;

hRes = lpMDB->OpenEntry(
 cbInbox, //Size and...
 lpbInbox, //Value of the Inbox's EntryID
 NULL, //We want the default interface (IMAPIFolder)
 MAPI_BEST_ACCESS, //Flags
 &ulObjType, //Object returned type
 (LPUNKNOWN *) &lpTempFolder); //Returned folder
 if (FAILED(hRes)) goto quit;

//Assign the out parameter
 *lpInboxFolder = lpTempFolder;

//Always clean up your memory here!
 quit:
 MAPIFreeBuffer(lpbInbox);
 return hRes;
 }

STDMETHODIMP OpenDefaultMessageStore(
 LPMAPISESSION lpMAPISession,
 LPMDB * lpMDB)
 {
 LPMAPITABLE pStoresTbl = NULL;
 LPSRowSet pRow = NULL;
 static SRestriction sres;
 SPropValue spv;
 HRESULT hRes;
 LPMDB lpTempMDB = NULL;

enum {EID, NAME, NUM_COLS};
 static SizedSPropTagArray(NUM_COLS,sptCols) = {NUM_COLS, PR_ENTRYID, PR_DISPLAY_NAME};

*lpMDB = NULL;

//Get the table of all the message stores available
 hRes = lpMAPISession -> GetMsgStoresTable(0, &pStoresTbl);
 if (FAILED(hRes)) goto quit;

//Set up restriction for the default store
 sres.rt = RES_PROPERTY; //Comparing a property
 sres.res.resProperty.relop = RELOP_EQ; //Testing equality
 sres.res.resProperty.ulPropTag = PR_DEFAULT_STORE; //Tag to compare
 sres.res.resProperty.lpProp = &spv; //Prop tag and value to compare against

spv.ulPropTag = PR_DEFAULT_STORE; //Tag type
 spv.Value.b = TRUE; //Tag value

//Convert the table to an array which can be stepped through
 //Only one message store should have PR_DEFAULT_STORE set to true, so only one will be returned
 hRes = HrQueryAllRows(
 pStoresTbl, //Table to query
 (LPSPropTagArray) &sptCols, //Which columns to get
 &sres, //Restriction to use
 NULL, //No sort order
 0, //Max number of rows (0 means no limit)
 &pRow); //Array to return
 if (FAILED(hRes)) goto quit;

//Open the first returned (default) message store
 hRes = lpMAPISession->OpenMsgStore(
 NULL,//Window handle for dialogs
 pRow->aRow[0].lpProps[EID].Value.bin.cb,//size and...
 (LPENTRYID)pRow->aRow[0].lpProps[EID].Value.bin.lpb,//value of entry to open
 NULL,//Use default interface (IMsgStore) to open store
 MAPI_BEST_ACCESS,//Flags
 &lpTempMDB);//Pointer to place the store in
 if (FAILED(hRes)) goto quit;

//Assign the out parameter
 *lpMDB = lpTempMDB;

//Always clean up your memory here!
quit:
 FreeProws(pRow);
 UlRelease(pStoresTbl);
 if (FAILED(hRes))
 {
 HRESULT hr;
 LPMAPIERROR lpError; 
 hr = lpMAPISession->GetLastError(hRes,0,&lpError);
 if (!hr)
 {
 printf("%s\n%s\n",lpError->lpszError,lpError->lpszComponent);
 MAPIFreeBuffer(lpError);
 }
 }
 return hRes;
 }

```
