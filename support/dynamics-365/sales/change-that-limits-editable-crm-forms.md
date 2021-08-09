---
title: A change that limits editable CRM forms
description: Describes a change that limits the number of open editable CRM forms to five in Microsoft Dynamics CRM Update Rollup 12.
ms.reviewer: 
ms.topic: article
ms.date: 3/31/2021
---
# Microsoft Dynamics CRM Update Rollup 12 introduces a change that limits the number of open editable CRM forms to five

This article describes a change that limits the number of open editable CRM forms to five in Microsoft Dynamics CRM Update Rollup 12.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2856713

## Introduction

Microsoft Dynamics CRM Update Rollup 12 introduces a change that limits the number of open editable Microsoft Dynamics CRM forms to five.

## More information

Microsoft Dynamics CRM has a unified user interface experience between its Web Client and CRM Outlook Client. Web Forms can sometimes contain quite a bit of content, data, and code. To ensure you, as the user, have a great experience in our CRM Outlook Client, we've designed a feature that will optimize how you open Microsoft Dynamics CRM forms. When you open more than five Microsoft Dynamics CRM forms, we'll begin to mark as read-only, the oldest forms that have no changes. The form will be designated as read-only by making it gray. If you decide to focus on a read-only form, it will reload into its edit mode. At any time, you can have five forms in Edit mode.

It was introduced to reduce the stress on virtual memory that has caused performance and Out Of Memory issues.
