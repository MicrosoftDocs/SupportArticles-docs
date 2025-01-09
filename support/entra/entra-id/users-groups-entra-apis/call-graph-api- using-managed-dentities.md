---
title: Use managed identities to call Microsoft Graph APIs in VB.Net and C#
description: Guides to use Managed Identities to call Microsoft Graph APIs in VB.Net and C#.
ms.author: raheld
ms.date: 01/09/2025
ms.service: entra-id
ms.custom: sap:Microsoft Graph Users, Groups, and Entra APIs
---

# Use managed identities to call Microsoft Graph APIs in VB.Net and C#

This article explains how to use managed identities to get access token and call Microsoft Graph APIs in both VB.Net and C#. 

## Configure permissions for managed identities

To begin with, a User Assigned Managed Identity will have a service principal in the Enterprise applications blade, however, no app registration, which is where you normally go to assign and consent to permissions. A System Assigned Managed Identity does not have a service principal that is viewable in the Enterprise applications blade. To get permissions consented for Microsoft Graph on those identities, you will need to make an OAuth Permission Grant. The following PowerShell script will do just that.

```powershell
# Your tenant id (in Azure Portal, under Azure Active Directory -> Overview )
$TenantID = "{your tenant id}"

# Name of the manage identity
$DisplayNameOfApp = "{your managed identity name}" 

# Check the Microsoft Graph documentation for the permission you need for the operation
$Permissions = @("User.Read.All")
 
# Main script

# Microsoft Graph App ID
$MSGraphAppId = "00000003-0000-0000-c000-000000000000"

# Uncomment the next line if you need to Install the module (You need admin on the machine)
# Install-Module Microsoft.Graph
Connect-MgGraph -TenantId $TenantID -scopes Application.ReadWrite.All

# Get the application we want to modify
$sp = (Get-MgServicePrincipal -Filter "displayName eq '$DisplayNameOfApp'")
  
# If assigning MS Graph Permissions
$GraphServicePrincipal = Get-MgServicePrincipal -Filter "appId eq '$MSGraphAppId'"
 
# Add permissions
foreach($permission in $Permissions)
{
 $AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $permission -and $_.AllowedMemberTypes -contains "Application"}

  New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $sp.Id -PrincipalId $sp.Id -ResourceId $GraphServicePrincipal.Id -AppRoleId $AppRole.Id
}


<# Remove permissions - this portion of the script show how to remove those same permissions
$AppRoleAssignments = Get-MgServiceAppRoleAssignedTo -ObjectId $sp.ObjectId

foreach($permission in $Permissions)
{

  $AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $permission -and $_.AllowedMemberTypes -contains "Application"}

 foreach($AppRoleAssignment in $AppRoleAssignments)
	{
		if($AppRole.Id -eq $AppRoleAssignment.Id) {
			Remove-MgServiceAppRoleAssignment -ObjectId $sp.ObjectId -AppRoleAssignmentId $AppRoleAssignment.objectid
		}
		
	}
}
#>
```
## Get access token

Once your permissions are on the service principal, you can then make a token request using that resource ( https://graph.microsoft.com ).

> [!NOTE]
> Once you make a token request for a resource, you will get the same token for the next 24 hours, even if you make permission changes. You will need to wait for the current token to expire in order to get a token with any new permissions.

Once you have your permissions, it is a matter of changing the resource parameter in the code for the access token request like this ( c# first, then vb.net ):

```vbnet
Dim at As AccessToken = credential.GetToken(New TokenRequestContext(New String() {"https://graph.microsoft.com"}))
```

```csharp
AccessToken at = credential.GetToken(new TokenRequestContext(new string[] { "https://graph.microsoft.com" }));
```

## Call Graph APIs
Now, this is just showing how to get an access token for a resource such as Microsoft Graph. However, when using the Graph service client in code, you do not need to specify the resource as the graph service client will be handling that for you. In the VB.Net code, you will need to add the Microsoft.Graph nuget package and then add the Imports Microsoft.Graph at the top of the code file.

```vbnet


    Sub Main()

        Do While True
            Get_AccessToken_With_UserAssigned_MSI()
            Make_GraphRequest_withUserMSI_Token()
            Get_Secret_With_UserAssigned_MSI()

            Get_AccessToken_With_SystemAssigned_MSI()
            Get_Secret_With_SystemAssigned_MSI()
            Make_GraphRequest_withSystemMSI_Token()

            Console.WriteLine("Press Enter to try again or any other key to exit")
            Dim key As ConsoleKeyInfo = Console.ReadKey()

            If Not key.Key = ConsoleKey.Enter Then
                Return
            End If
        Loop


    End Sub

    Sub Get_AccessToken_With_UserAssigned_MSI()
        Console.WriteLine($"Getting access token with user assigned msi:")

        Dim credential As New ManagedIdentityCredential(userAssignedClientId)

        Dim at As AccessToken = credential.GetToken(New TokenRequestContext(New String() {"https://graph.microsoft.com"}))
        Dim accessToken As String = at.Token.ToString()
        Console.WriteLine($"Access Token = {accessToken}")

    End Sub

    Sub Make_GraphRequest_withUserMSI_Token()
        Console.WriteLine($"Making graph request with User MSI Token:")

        Dim credential As New ManagedIdentityCredential(userAssignedClientId)

        Dim graphClient As New GraphServiceClient(credential)

        Dim users As IGraphServiceUsersCollectionPage
        Try
            users = graphClient.Users().Request.GetAsync().Result
            Console.WriteLine($"Number of users in tenant: {users.Count}{vbCrLf}")
        Catch ex As Exception
            Console.WriteLine($"Exception: {ex.Message}")
        End Try


    End Sub

    Sub Get_AccessToken_With_SystemAssigned_MSI()
        Console.WriteLine($"Getting access token with system assigned msi:")

        Dim credential As New ManagedIdentityCredential()
        Dim at As AccessToken = credential.GetToken(New TokenRequestContext(New String() {"https://graph.microsoft.com"}))

        Dim accessToken As String = at.Token.ToString()
        Console.WriteLine($"Access Token = {accessToken}")
    End Sub

    Sub Make_GraphRequest_withSystemMSI_Token()
        Console.WriteLine($"Making graph request with system MSI token:")

        Dim credential As New ManagedIdentityCredential()

        Dim graphClient As New GraphServiceClient(credential)

        Dim users As IGraphServiceUsersCollectionPage
        Try
            users = graphClient.Users().Request.GetAsync().Result
            Console.WriteLine($"Number of users in tenant: {users.Count}{vbCrLf}")
        Catch ex As Exception
            Console.WriteLine($"Exception: {ex.Message}")
        End Try


    End Sub
Similar, the missing code snippets for the C# project:

```csharp
        static void Main(string[] args)
        {
            while (true)
            {
                Console.Clear();

                Get_AccessToken_With_UserAssigned_MSI();
                Get_Secret_With_UserAssigned_MSI();
                Make_GraphRequest_With_UserMSI_Token();

                Get_AccessToken_With_SystemAssigned_MSI();
                Get_Secret_With_SystemAssigned_MSI();
                Make_GraphRequest_With_SystemMSI_Token();

                Console.WriteLine("Press Enter to try again or any other key to exit");
                ConsoleKeyInfo key = Console.ReadKey();
                if (key.Key != ConsoleKey.Enter)
                {
                    return;
                }
            }

        }

        static void Get_AccessToken_With_UserAssigned_MSI()
        {
            Console.WriteLine($"Getting access token with user assigned msi:");

            ManagedIdentityCredential credential = new ManagedIdentityCredential(userAssignedClientId);

            AccessToken at = credential.GetToken(new TokenRequestContext(new string[] { "https://database.windows.net" }));
            string accessToken = at.Token;

            Console.WriteLine($"Access Token = {accessToken}");

        }

        static void Get_AccessToken_With_SystemAssigned_MSI()
        {
            Console.WriteLine($"Getting access token with system assigned msi:");

            ManagedIdentityCredential credentail = new ManagedIdentityCredential();

            AccessToken at = credentail.GetToken(new TokenRequestContext(new string[] { "https://database.windows.net" }));
            string accessToken = at.Token;

            Console.WriteLine($"Access token = {accessToken}");

        }

        static void Make_GraphRequest_With_UserMSI_Token()
        {
            Console.WriteLine($"Making graph request with User MSI Token:");

            ManagedIdentityCredential credential = new ManagedIdentityCredential(userAssignedClientId);
            GraphServiceClient graphClient = new GraphServiceClient(credential);

            IGraphServiceUsersCollectionPage users;

            try
            {
                users = graphClient.Users.Request().GetAsync().Result;
                Console.WriteLine($"Number of users in tenant: {users.Count}\n");
            } catch(Exception ex)
            {
                Console.WriteLine($"\nException: {ex.InnerException.Message}");
            }

        }

        static void Make_GraphRequest_With_SystemMSI_Token()
        {
            Console.WriteLine($"Making graph request with system MSI Token:");

            ManagedIdentityCredential credential = new ManagedIdentityCredential();
            GraphServiceClient graphClient = new GraphServiceClient(credential);

            IGraphServiceUsersCollectionPage users;

            try
            {
                users = graphClient.Users.Request().GetAsync().Result;
                Console.WriteLine($"Number of users in tenant: {users.Count}\n");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"\nException: {ex.InnerException.Message}");
            }
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]