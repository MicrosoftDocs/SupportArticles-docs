---
title: Supported file systems in BizTalk
description: Discusses the file systems that are supported when you use the BizTalk Server File Receive function and the BizTalk Server File Adapter.
ms.date: 03/16/2020
ms.custom: sap:Adapters
ms.reviewer: tracey
---
# Supported file systems when you use the BizTalk Server File Receive function and BizTalk Server File Adapter

_Original product version:_ &nbsp;  BizTalk Server  
_Original KB number:_ &nbsp; 815070

The BizTalk Server File Receive function and the BizTalk Server File Adapter have only been tested on, and are supported on, the New Technology File System (NTFS). However, file change notifications are also provided for connections that are made to file shares by using the Server Message Block (SMB) protocol.

> [!NOTE]
> When you try to use either the BizTalk Server File Receive function or the BizTalk Server File Adapter on a file system other than NTFS, the BizTalk Server File Receive function or the BizTalk Server File Adapter may stop responding and may become disabled.
