---
title: Data collection for troubleshooting secure channel issues
description: Describes the data you need to collect to troubleshoot secure channel issues.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm
ms.custom: sap:Windows Security\Netlogon, secure channel, DC locator, csstroubleshoot
---
# Data collection for troubleshooting secure channel issues

The information in this article works as a reference and helps you troubleshoot when the secure channel is broken.

To determine the cause of secure channel issues, collect the following information. 

## Obtain the client device information

On the affected device, check for successful password change events in the System Event Viewer log (Event ID 5823 - Source: NETLOGON). This will help to find out the last time the password was changed by the system and use it as a reference value (if present - consider it might be overwritten by newer events):

:::image type="content" source="media/data-collection-for-troubleshooting-secure-channel-issues/event-id-5823.png" alt-text="Screenshot of event ID 5823.":::

```output
Log name: System  
Source: NETLOGON  
Description: The system successfully changed its password on the domain controller \\DCName.domain.com. This event is logged when the password for the computer account is changed by the system. It is logged on the computer that changed the password.
```

If Netlogon logging is enabled, you should also see a behavior with evidence of the password change from the preceding Event ID 5823:

```output
08/22 07:32:23 [SESSION] [4128] CONTOSO: NlChangePassword: Doing it.
08/22 07:32:23 [SESSION] [4128] CONTOSO: NlChangePassword: Successful response from DC \\DC1-CONT.contoso.com
08/22 07:32:24 [SESSION] [4128] CONTOSO: NlChangePassword: Flag password changed in LsaSecret
08/22 07:32:24 [SESSION] [4128] CONTOSO: NlChangePassword: Flag password updated on DC
08/22 07:32:24 [MISC] [4128] Eventlog: 5823 (4) "\\DC1-CONT.contoso.com" 
08/22 07:32:24 [MISC] [4128] NlWksScavenger: Can be called again in # days (0x5265c00) --> The number of days here will match the "Maximum machine account password age" value defined on the computer changing the password. 
```

Compare the computer account `pwdLastSet` (the last time the password was changed by the computer known by Active Directory) attribute value in Active Directory with the Local Security Authority (LSA) secret value `cupdtime` (the last time the password was changed as per the client computer or server's knowledge) on the local machine:

## Obtain the LSA secret value on the affected computer or server

Follow these steps to look for the `cupdtime` value from the registry.

> [!NOTE]
> By default, only the "System" account has access to the registry key `HKLM\SECURITY`, so you have two options:
> - Use the PsExec tool to run the following steps in the System context.
> - Give the desired user full permissions to the registry key `HKLM\SECURITY` (remember to remove them when no longer needed):

1. Run `reg query "HKLM\SECURITY\Policy\Secrets\$MACHINE.ACC\CupdTime"`.  

   :::image type="content" source="media/data-collection-for-troubleshooting-secure-channel-issues/command-to-retrieve-the-cupdtime-value.png" alt-text="Screenshot of running the command to retrieve the cupdtime value.":::

   In this example, you receive the value `26A38C1AA0F4DA01`. The value needs to be converted by using w32tm before it can be understood. The hexadecimal value needs to be converted to decimal, but you need to revert the order for each pair of bits starting from the last one.

   - The original value `26A38C1AA0F4DA01` turns into `01DAF4A01A8CA326`.
   - Convert the hexadecimal value into decimal (you can use the Calculator in Programmer mode). The result is `133688107438220070`.

2. Run the following command:

   ```console
   w32tm /ntte 133688107438220070
   ```

   You receive the following output:

   :::image type="content" source="media/data-collection-for-troubleshooting-secure-channel-issues/w32tm-command-to-get-date-time.png" alt-text="Screenshot of the w32tm command output.":::

   The value is `154731 14:32:23.8220070 - 8/22/2024 7:32:23 AM`.

## Obtain the Active Directory pwdLastSet value

1. Open the Active Directory Users and Computers console, navigate to the **Organizational Unit** where the computer object belongs, and look for the `pwdLastSet` attribute to see the value:

   :::image type="content" source="media/data-collection-for-troubleshooting-secure-channel-issues/pwdlastset-attribute-in-organizational-unit-properties.png" alt-text="Screenshot of the pwdLastSet attribute in the Organizational Unit properties.":::

2. Run the following command from a Windows Command prompt. Replace the Distinguished Name of the actual affected computer you're troubleshooting and export it to a file (it's easier to check the information if you have a considerable number of domain controllers (DCs)):

   ```console
   repadmin /showobjmeta * "CN=ComputerName,OU=Computers,DC=domain,DC=com" > c:\temp\ComputerName_Metadata.txt
   ```

   Alternatively, run the following command from a Windows PowerShell prompt (Active Directory module is required):

   ```powershell
   Get-ADComputer '<ComputerName>' -properties PasswordLastSet | Format-List
   ```

   :::image type="content" source="media/data-collection-for-troubleshooting-secure-channel-issues/get-passwordlastset-value-powershell-command.png" alt-text="Screenshot of the Get-ADComputer PasswordLastSet PowerShell command.":::

3. Open the file and look for the values of the `pwdLastSet` attribute (you'll get the metadata for the object from all DCs available in the environment) and compare them. In a good scenario, the data in the attribute should be consistent across all DCs. You'll see information for other attributes in the output. Focus only on the required attribute. Here's an example of the output:

   :::image type="content" source="media/data-collection-for-troubleshooting-secure-channel-issues/sample-computer-name-metadata.png" alt-text="Screenshot of a sample of the computer name metadata.":::

4. The preceding information gives you the value for a single DC (the one you're connected to through the console or when running the commands). Consider gathering the metadata for the affected computer object from Active Directory so you can confirm that the value is consistent across all DCs in the environment.
