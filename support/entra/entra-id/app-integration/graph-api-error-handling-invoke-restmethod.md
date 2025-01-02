---
title: Handling errors in Microsoft Graph API requests with invoke-restmethod
description: This article provides a code sample to simulate a handling error that occurs when you make requests to the Microsoft Graph API by using the Invoke-RestMethod cmdlet in PowerShell.
ms.date: 02/18/2024
author: genlin
ms.author: raheld
ms.service: entra-id
ms.topic: overview
content_well_notification: AI-contribution
ai-usage: ai-assisted
ms.custom: sap:Microsoft Graph Users, Groups, and Entra APIs
---
# Handling errors in Microsoft Graph API Requests with Invoke-RestMethod

This article provides a code sample that demonstrates how to handle errors and implement retry logic when you make requests to the Microsoft Graph API by using the `Invoke-RestMethod` cmdlet in PowerShell.

## Prerequisites

- An Azure app registration with a client secret
- The `user.read.all` permission for Microsoft.Graph for the Azure app. For more information, see [List users](/graph/api/user-get?view=graph-rest-1.0&tabs=http&preserve-view=true).

## Code sample

To demonstrate the retry logic, this sample tries to query the `signInActivity` data for guest users. When you run this code, you can expect to receive a "403" error.

- **Get-AccessTokenCC** This function requests an access token from Microsoft Entra ID (formerly Azure Active Directory). The token will be used to authenticate API requests to Microsoft Graph. You have to provide values for the `$clientSecret`, `$clientId`, and `$tenantId` variables of your Azure registration app.
- **Get-GraphQueryOutput ($Uri)**  This function makes a request to the Microsoft Graph API to retrieve data. It also handles paging. The function retries the request if a "403" error is generated.

``` powershell
Function Get-AccessTokenCC
 
{
    $clientSecret = ''
    $clientId = ''
    $tenantId = ''
    # Construct URI
    $uri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
    # Construct Body
    $body = @{
        client_id = $clientId
        client_secret = $clientSecret
        scope = 'https://graph.microsoft.com/.default'
        grant_type = 'client_credentials'
    }
    # Get OAuth 2.0 Token
    $tokenRequest = Invoke-WebRequest -Method Post -Uri $uri -ContentType 'application/x-www-form-urlencoded' -Body $body -UseBasicParsing
    # Access Token
    $token = ($tokenRequest.Content | ConvertFrom-Json).access_token
    #$token = "Junk"  #uncomment this line to cause a 401 error -- you can set that status in the error handler to test the pause and retry
    #Write-Host "access_token = $token"
    return $token
}
 
Function Get-GraphQueryOutput ($Uri)
{
    write-host "uri = $Uri"
    write-host "token = $token"

    $retryCount = 0
    $maxRetries = 3
    $pauseDuration = 2
 
    $allRecords = @()
    while ($Uri -ne $null){
        Write-Host $Uri
        try {
            # todo: verify that the bearer token is still good -- hasn't expired yet -- if it has, then get a new token before making the request
            $result=Invoke-RestMethod -Method Get -Uri $Uri -ContentType 'application/json' -Headers @{Authorization = "Bearer $token"}
           
            Write-Host $result
         
            if($query.'@odata.nextLink'){
                # set the url to get the next page of records. For more information about paging, see https://docs.microsoft.com/graph/paging
                $Uri = $query.'@odata.nextLink'
            } else {
                $Uri = $null
            }
 
        } catch {
            Write-Host "StatusCode: " $_.Exception.Response.StatusCode.value__
            Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
 
            if($_.ErrorDetails.Message){
                Write-Host "Inner Error: $_.ErrorDetails.Message"
            }
 
            # check for a specific error so that we can retry the request otherwise, set the url to null so that we fall out of the loop
            if($_.Exception.Response.StatusCode.value__ -eq 403 ){
                # just ignore, leave the url the same to retry but pause first
                if($retryCount -ge $maxRetries){
                    # not going to retry again
                    $Uri = $null
                    Write-Host 'Not going to retry...'
                } else {
                    $retryCount += 1
                    Write-Host "Retry attempt $retryCount after a $pauseDuration second pause..."
                    Start-Sleep -Seconds $pauseDuration
                }
 
            } else {
                # not going to retry -- set the url to null to fall back out of the while loop
                $Uri = $null
            }
        }
    }
 
    $output = $allRecords | ConvertTo-Json

if ($result.PSObject.Properties.Name -contains "value") {
    return $result.value
} else {
    return $result
}
}
 
# Graph API URIs
$uri = 'https://graph.microsoft.com/v1.0/users?$filter=userType eq ''Guest''&$select=displayName,UserprincipalName,userType,identities,signInActivity'

# Pull Data
$token = Get-AccessTokenCC
Get-GraphQueryOutput -Uri $uri|out-file c:\\temp\\output.json

```

## Capturing a specific header

For advanced scenarios, such as capturing specific header values such as `Retry-After` during throttling responses (HTTP 429), use:

```powershell
$retryAfterValue = $_.Exception.Response.Headers["Retry-After"]
```
To handle the "429 - too many requests" error, see [Microsoft Graph throttling guidance](/graph/throttling).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

