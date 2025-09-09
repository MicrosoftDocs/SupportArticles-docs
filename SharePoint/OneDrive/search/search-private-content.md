---
title: Searching private content in Microsoft 365 OneDrive for Business
description: Describes changes to how OneDrive and SharePoint return search results of content that hasn't been shared with the user.
author: Cloud-Writer
ms.reviewer: knutb
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
  - CI-156789
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - OneDrive
ms.date: 12/17/2023
---

# Searching private content in Microsoft 365 OneDrive for Business

In Microsoft 365 enterprise search experiences, the search results include:

- All SharePoint site collection content you have read access (or stronger) to, including site collections associated with groups and teams.
- Your own OneDrive for Business content, including content that you haven't shared with anyone (private).
- OneDrive for Business content that has been shared with you.

This applies to all search experiences for SharePoint and OneDrive, including native OneDrive for Business web and mobile search experiences.

Your privacy is important to us, and while we work to earn your trust every day, we discover areas of improvement where we can align our services with your expectations of privacy. We are rolling out a change in Microsoft 365 Search to make sure search results are consistent with what users perceive as private content. We will do so by adapting the definition of "private" that is already in use by OneDrive, resulting in a consistent search experience with your privacy at the center.

## How will I see this change?

This change will only be visible in the search results for users who have been granted *site collection admin privileges* (directly or through a security group) to a OneDrive for Business site collection that *they are not the owner of*, through governance policies or other changes in ownership.

Prior to this change, OneDrive content that was not explicitly shared with you, but where access was granted through governance policies or changes in ownership, would be returned in search results. With this change, OneDrive content won’t be returned in search results unless it has been shared with you through any Microsoft 365 sharing mechanism.

## Scenarios associated with this change

An important aspect of this change is to guarantee a consistent definition of “Private OneDrive content” that is in line with the user’s expectation of privacy. In the OneDrive for Business Web experience today, the **Sharing** column reflects the definition of *private* OneDrive content, which we'll adapt in search.

“Sharing” in this context means explicit sharing of items or folders within OneDrive, or other low-level means to change the access rights for sites, folders, or items within OneDrive. We know customers might be concerned about perceived over-sharing through search, so we want to make sure that the content returned in search results is consistent with what users perceive as private vs. shared.

A scenario that is *not* defined as “sharing” in this context is when someone other than the OneDrive owner is defined as Site Collection Administrator for the OneDrive site collection in addition to the OneDrive owner. This could be another user within the Microsoft 365 subscription or a security group. In SharePoint, a site collection admin will always have full access to the content of the associated site collection. With this change, if a user has read access to content in another user’s OneDrive by being Site Collection Administrator only, then the content is still not surfaced in search experiences.

Prior to this change, search results did reflect any content you had read access to - you would be able to see other user’s private OneDrive content even if the user hadn’t shared the content with you, if you had been assigned the site collection admin role on the site collection.

These are the most relevant scenarios where this change *might* affect search results:
1. Some customers may have a governance policy where they add a security group (for example, some special security group for privileged tenant admin roles) as an additional site collection admin on all site collections, including OneDrive for Business site collections.
    - This is normally not a search scenario, but for other reasons, it must be possible for some privileged tenant admins to access specific content regardless of access rights.
    - This isn't a recommended pattern, but some customers have deployed this pattern using SharePoint scripting.
    - If a privileged admin who is a member of such a security group expects to be able to search in all content, this has previously worked in SharePoint Online search, but will no longer return private content based on the new definition.

1. A user has left the company, and the OneDrive for Business contains content that may be relevant for the organization. In this case, a manager or some other appointed peer may be added as site collection admin to the OneDrive site to have access to the content of the OneDrive.
1. A user changes employee identity (for example, from vendor to full-time employee) where the user’s email address changes, and the user might get a new OneDrive for Business site associated with the new identity. In this case, the user (with the new identity) might want full access to the old OneDrive site, potentially by being assigned as additional site collection administrator.

## Mitigation

In all the scenarios listed above, there might be legitimate reasons for a supplementary site collection admin to be able to search for private content within the OneDrive.
- For scenario 1, we recommend using eDiscovery if there's a specific need for search across all content including private content. This will also make sure that proper governance policies are followed, and privacy concerns are respected.

- For scenarios 2 and 3, if a user has legitimate reasons to search for private content in such a OneDrive site, the user (which have full access via being Site Collection Admin) can share the relevant content of the OneDrive with themselves, using normal sharing mechanisms on files or folders.
