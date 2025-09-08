---
title: External or app created emails not delivered
description: Email messages received from external organizations or application-generated email messages are not delivered to users. Provides a resolution.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Not Able to Send or Receive Emails from Internet
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server
search.appverid: MET150
---
# Emails sent from Internet or application created emails are not delivered to users

_Original KB number:_ &nbsp; 2519912

## Symptoms

Some email messages received from external organizations or application-generated email messages are not delivered to users.

You receive the following NDR:

> #554 5.6.0 STOREDRV.Deliver; Corrupt message content ##

## Cause

If you check the message headers for the format of the message:

Content-Type: application/mac-binhex40  
Content-Transfer-Encoding: base64

You notice the qualifying line: **Content-Transfer-Encoding: base64** for mac-binhex type of document.

This indicates that the actual data is base64 encoded.

Since Exchange Server only accepts the RFC standard mac-binhex encoding, these messages are rejected.

## Resolution

The sender should be sending the attachment in correctly formatted mac-binhex40 format.

The correctly formatted mac-binhex40 message header should have the following Content lines:

Content-Type: application/mac-binhex40  
Content-Disposition: attachment; filename="example.doc"

Indicating that the document is encoded using the RFC standard mac-binhex40 format.

## More information

As per the **Appendix A. The BinHex format** part in [RFC 1741 - MIME Content Type for BinHex Encoded Files](http://www.packetizer.com/rfc/rfc1741/):

```console
Here is a description of the Hqx7 (7 bit format as implemented in BinHex 4.0) formats for Macintosh Application and File transfers.

The main features of the format are:

1. Error checking even using ASCII download
2. Compression of repetitive characters
3. 7 bit encoding for ASCII download

The format is processed at three different levels:

1. 8 bit encoding of the file:

   Byte:    Length of FileName (1->63)
   Bytes:   FileName ("Length" bytes)
   Byte:    Version
   Long:    Type
   Long:    Creator
   Word:    Flags (And $F800)
   Long:    Length of Data Fork
   Long:    Length of Resource Fork
   Word:    CRC
   Bytes:   Data Fork ("Data Length" bytes)
   Word:    CRC
   Bytes:   Resource Fork ("Rsrc Length" bytes)
   Word:    CRC

2. Compression of repetitive characters.

   ($90 is the marker, encoding is made for 3->255 characters)
   00 11 22 33 44 55 66 77   -> 00 11 22 33 44 55 66 77
   11 22 22 22 22 22 22 33   -> 11 22 90 06 33
   11 22 90 33 44            -> 11 22 90 00 33 44

   The whole file is considered as a stream of bits. This stream will
   be divided in blocks of 6 bits and then converted to one of 64
   characters contained in a table. The characters in this table have
   been chosen for maximum noise protection. The format will start
   with a ":" (first character on a line) and end with a ":".
   There will be a maximum of 64 characters on a line. It must be
   preceded, by this comment, starting in column 1 (it does not start
   in column 1 in this document):
```

For more information, you can also reference [2.2.4.2.3 Application/Mac-binhex40](/openspecs/exchange_server_protocols/ms-oxcmail/2e37bc8f-013f-4bf3-b267-2d650253e432).
