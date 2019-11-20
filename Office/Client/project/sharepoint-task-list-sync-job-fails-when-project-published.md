---
title: SharePoint task list sync job fails when Project is published
ms.author: v-todmc
author: krishnp
manager: dcscontentpm
ms.date: 11/20/2019
audience: ITPro
ms.topic: article
ms.prod: 
- project-server-2019
- project-server-2016
- project-server-2013
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Server
ms.custom: 
- CI 109543
- CSSTroubleshoot 
ms.reviewer: krishnp 
description: Desribes how to resolve an issue where the SharePoint task list sync job fails when published from Project Professional or PWA. 
---

# SharePoint task list sync job fails when Project is published

## Symptoms
A SharePoint task list sync job fails in the Project queue when published from Project Professional or from Project Web App (PWA). 

## Cause
This issue occurs if a user who was added to an item in the “AssignedTo” field in a task list has been removed from the site collection.

## Resolution
The PowerShell script below can be used to find the list items in a task list which still contain user accounts in the “AssignedTo” field that are missing from site collection:
 
```
asnp *share*
$site = get-spsite http://Server/PWA
 
function new-row
{
    $Fields = ('SiteUrl', 'WebUrl', 'ListUrl', 'ItemID','ItemName', 'MissingUser' )
    $Row = new-object PSCustomObject
    foreach ( $field in $Fields)
    {
        $row | Add-Member -NotePropertyName $Field -NotePropertyValue $null
    }
    return $Row
}
 
$result = New-Object System.Collections.arraylist
 
foreach ( $web in $site.AllWebs )
{
    
    Write-host "Processing Web : $($web.Url).." -NoNewline
    $list = $null
    $list = $web.Lists['Tasks']
    if ( $list -ne $null )
    {
        foreach ( $item in $list.Items)
        {
            $assignedTo = $item['AssignedTo']
 
            if ( $assignedTo -ne $null -and  $assignedTo.user -eq $null)
            {
                $Row = new-row
                $row.SiteUrl = $web.site.Url
                $row.WebUrl = $web.Url
                $row.ListUrl = $web.site.MakeFullUrl($list.DefaultViewUrl)
                $row.ItemID = $item.ID
                $row.ItemName = $item.Name
                $row.MissingUser = $assignedTo.lookupvalue
                $result.add($row) | Out-Null
            }
 
        }
    }
    Write-host "Done" -ForegroundColor Green
}
 
$result | Out-GridView
 
$result | Export-Csv -Encoding UTF8 -NoTypeInformation -Path C:\Logs\Report1.csv 
```
> [!NOTE]
> Change the PWA URL and task list name before running the PowerShell.
 
Once the list items are found:
1.	Go to **Site Settings** and then **Content and Structure**. 
2.	Access the task list of the workspace associated with the Project. 
3.	Remove the user from assignment in task list.

Alternative workaround options include the following:
 
1.	Disable the task list sync by running the following command:
```
Disable-SPProjectEnterpriseProjectTaskSync –Url http://servername/PWA/NameOfProject
```
 
2.	Delete and recreate the task list.

## More information
The ULS logs that show the error when updating the “AssignedTo” field in the task list will appear similar to the following:

``` 
PWA:https://Server/PWA, ServiceApp:PWA_APP_SVC, User:i:0#.w|mydomain\krishnp, PSI: [QUEUE] SynchronizeTaskListInManagedModeMessage failed on project e7e90257-d10e-e911-89a6-ace2d39a7fa8. Exception: System.NullReferenceException: Object reference not set to an instance of an object.    
 at Microsoft.Office.Project.Server.BusinessLayer.ProjectModeManaged.UpdateAssignedToField(SPWeb workspaceWeb, DataSet taskDS, Guid taskUID, SPListItem listItem)    
 at Microsoft.Office.Project.Server.BusinessLayer.ProjectModeManaged.SynchronizeTask(SPList list, DataSet taskDS, Dictionary`2 taskMapping, DataRow row, DataView secondaryView, Dictionary`2 redoEntries)    
 at Microsoft.Office.Project.Server.BusinessLayer.ProjectModeManaged.<>c__DisplayClass1.<SynchronizeTaskListInManagedMode>b__0(SPWeb workspaceWeb)    
 at Microsoft.Office.Project.Server.BusinessLayer.Project.<>c__DisplayClass58.<TryRunActionWithProjectWorkspaceWebInternal>b__57()    
 at Microsoft.SharePoint.Utilities.SecurityContext.RunAsProcess(CodeToRunElevated secureCode)    
 at Microsoft.SharePoint.SPSecurity.RunWithElevatedPrivileges(WaitCallback secureCode, Object param)
```
