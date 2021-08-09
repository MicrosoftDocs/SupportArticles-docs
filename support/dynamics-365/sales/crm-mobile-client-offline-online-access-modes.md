---
title: CRM Mobile client offline and online access modes
description: This article describes CRM Mobile client offline and online access modes in Microsoft Dynamics CRM 2011.
ms.reviewer: 
ms.topic: article
ms.date: 3/31/2021
---
# Understanding CRM Mobile client offline and online access modes in Microsoft Dynamics CRM 2011

This article describes CRM Mobile client offline and online access modes in Microsoft Dynamics CRM 2011.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2712453

## Introduction

The CRM Mobile client for iPhone, iPad, Android, and Blackberry devices are capable of operating in both Online and Offline modes. However, both of these modes offer different functionality when interacting with CRM records and may only be suitable in certain circumstances. The behavior of both of these modes will be explained further below.
Note: The Windows Phone 7 client operates exclusively in Online mode. For more information regarding this client, please see the section entitled **Windows Phone 7**.

- **Offline Mode**  

  Typically, offline mode is the most commonly used mode, as this allows users to edit records that have been synchronized to the local device. The data that is available for offline synchronization is dependent on the following factors:

  - A **synchronization filter** for the desired records created in Mobile Administration in Microsoft Dynamics CRM 2011.

  - A **view**, or set of views, to display the synchronized records created in Mobile Administration in Microsoft Dynamics CRM 2011.

  The synchronization filter determines which record types are synchronized to the local client based on filter criteria. Meanwhile, the view, or a set of views, determine how the records will be displayed in views in the user interface on the client. Even if a synchronization filter contains no restrictions (that is - All Contacts), no records will appear visible in the mobile client without a corresponding view to display the records.

  When working in Offline mode, any new records that are created are also maintained in the local client database, which is then processed for synchronization to CRM during the next synchronization cycle. This same logic applies to existing records that have been altered.

- **Online Mode**  

  Except for Windows Phone 7 clients, users who operate in Online mode are restricted to read-only access of data. However, while synchronization filters are not required for Online mode, views are still needed in order to render the records in the grid view. If a user wishes to create or edit a record, the user must first switch to Offline mode.

- **Windows Phone 7**  

  Windows Phone 7 clients are only capable of working in Online mode.  Yet, the read-only restriction does not apply to these clients, as users are able to create and edit records in real time. However, since the Windows Phone 7 client does not contain a local database for offline synchronization, synchronization filters do not apply, and only views are needed to render data.
