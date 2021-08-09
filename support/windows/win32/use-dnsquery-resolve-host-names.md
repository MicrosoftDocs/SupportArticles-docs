---
title: Use the DnsQuery to resolve host names
description: This article provides a Win32 console application sample that illustrates how to use the DnsQuery function to send a query to a DNS server.
ms.date: 01/29/2021
ms.prod-support-area-path: Networking Development
ms.topic: how-to
---
# Use the DnsQuery function to resolve host names and host addresses with Visual C++ .NET

This article provides a Win32 console application sample that illustrates how to use the `DnsQuery` function to resolve host names and host IP.

_Original product version:_ &nbsp; Winsock  
_Original KB number:_ &nbsp; 831226

## Create a sample Win32 console application that illustrates how to use the DnsQuery function

In Winsock, use the `getaddrinfo` function instead of the `getaddrbyname` function to host names in your application. The `getaddrbyname` function was replaced by the `getaddrinfo` function to handle IPv4 and IPv6 addressing.

Winsock never accounted for wide characters until recently in Windows Server 2003 where a new version of the `getaddrinfo` function is included. The new version is named *GetAddrInfo*. If you need a solution for all NT-based operating systems, use the DNS client DNSQuery function to resolve host names. The `DNSQuery` function has a wide version that should work on Microsoft Windows 2000 and later operating systems.

Use the following steps to create a sample Win32 console application that illustrates how to use the `DnsQuery` function. The `DnsQuery` function sends a query to a DNS server to resolve the host name to an IP address and vice-versa.

1. Start Microsoft Visual Studio .NET.
2. Under **Project Types**, click **Visual C++ Projects**, and then click **Win32 Project** under
 **Templates**.
3. Type Q831226 in the **Name** box.
4. In the Win32 Application wizard, click **Console Application**, click **Empty project**, and then click
 **Finish**.
5. In Solution Explorer, right-click **Source Files**, click **Add**, and then click **Add New Item**. Add a C++ file (.cpp) to the project. Name the file *Q831226.cpp*.
6. Paste the following code in the *Q831226.cpp* file:

    ```cpp
    #include <winsock2.h> //winsock
    #include <windns.h> //DNS api's
    #include <stdio.h> //standard i/o
    
    //Usage of the program
    void Usage(char *progname) {
        fprintf(stderr,"Usage\n%s -n [HostName|IP Address] -t [Type] -s [DnsServerIp]\n",progname);
        fprintf(stderr,"Where:\n\t\"HostName|IP Address\" is the name or IP address of the computer ");
        fprintf(stderr,"of the record set being queried\n");
        fprintf(stderr,"\t\"Type\" is the type of record set to be queried A or PTR\n");
        fprintf(stderr,"\t\"DnsServerIp\"is the IP address of DNS server (in dotted decimal notation)");
        fprintf(stderr,"to which the query should be sent\n");
        exit(1);
    }
    
    void ReverseIP(char* pIP)
    {
        char seps[] = ".";
        char *token;
        char pIPSec[4][4];
        int i=0;
        token = strtok( pIP, seps);
        while( token != NULL )
        {
            /* While there are "." characters in "string"*/
            sprintf(pIPSec[i],"%s", token);
            /* Get next "." character: */
            token = strtok( NULL, seps );
            i++;
        }
        sprintf(pIP,"%s.%s.%s.%s.%s", pIPSec[3],pIPSec[2],pIPSec[1],pIPSec[0],"IN-ADDR.ARPA");
    }
    
    // the main function 
    void __cdecl main(int argc, char* argv[])
    {
        DNS_STATUS status; //Return value of DnsQuery_A() function.
        PDNS_RECORD pDnsRecord; //Pointer to DNS_RECORD structure.
        PIP4_ARRAY pSrvList = NULL; //Pointer to IP4_ARRAY structure.
        WORD wType; //Type of the record to be queried.
        char* pOwnerName; //Owner name to be queried.
        char pReversedIP[255];//Reversed IP address.
        char DnsServIp[255]; //DNS server ip address.
        DNS_FREE_TYPE freetype;
        freetype = DnsFreeRecordListDeep;
        IN_ADDR ipaddr;
    
        if (argc > 4)
        {
            for (int i = 1; i < argc; i++)
            {
                if ((argv[i][0] == '-') || (argv[i][0] == '/'))
                {
                    switch (tolower(argv[i][1]))
                    {
                        case 'n':
                            pOwnerName = argv[++i];
                            break;
                        case 't':
                            if (!stricmp(argv[i + 1], "A"))
                                wType = DNS_TYPE_A; //Query host records to resolve a name.
                            else if (!stricmp(argv[i + 1], "PTR"))
                            {
                                //pOwnerName should be in "xxx.xxx.xxx.xxx" format
                                if (strlen(pOwnerName) <= 15)
                                {
                                    //You must reverse the IP address to request a Reverse Lookup 
                                    //of a host name.
                                    sprintf(pReversedIP, "%s", pOwnerName);
                                    ReverseIP(pReversedIP);
                                    pOwnerName = pReversedIP;
                                    wType = DNS_TYPE_PTR; //Query PTR records to resolve an IP address
                                }
                                else
                                {
                                    Usage(argv[0]);
                                }
                            }
                            else
                                Usage(argv[0]);
                            i++;
                            break;
    
                        case 's':
                            // Allocate memory for IP4_ARRAY structure.
                            pSrvList = (PIP4_ARRAY)LocalAlloc(LPTR, sizeof(IP4_ARRAY));
                            if (!pSrvList)
                            {
                                printf("Memory allocation failed \n");
                                exit(1);
                            }
                            if (argv[++i])
                            {
                                strcpy(DnsServIp, argv[i]);
                                pSrvList->AddrCount = 1;
                                pSrvList->AddrArray[0] = inet_addr(DnsServIp); //DNS server IP address
                                break;
                            }
    
                        default:
                            Usage(argv[0]);
                            break;
                    }
                }
                else
                    Usage(argv[0]);
            }
        }
        else
            Usage(argv[0]);
    
        // Calling function DnsQuery to query Host or PTR records 
        status = DnsQuery(pOwnerName, //Pointer to OwnerName. 
        wType, //Type of the record to be queried.
        DNS_QUERY_BYPASS_CACHE, // Bypasses the resolver cache on the lookup. 
        pSrvList, //Contains DNS server IP address.
        &pDnsRecord, //Resource record that contains the response.
        NULL); //Reserved for future use.
    
        if (status)
        {
            if (wType == DNS_TYPE_A)
                printf("Failed to query the host record for %s and the error is %d \n", pOwnerName, status);
            else
                printf("Failed to query the PTR record and the error is %d \n", status);
        }
        else
        {
            if (wType == DNS_TYPE_A)
            {
                //convert the Internet network address into a string
                //in Internet standard dotted format.
                ipaddr.S_un.S_addr = (pDnsRecord->Data.A.IpAddress);
                printf("The IP address of the host %s is %s \n", pOwnerName, inet_ntoa(ipaddr));
    
                // Free memory allocated for DNS records. 
                DnsRecordListFree(pDnsRecord, freetype);
            }
            else
            {
                printf("The host name is %s \n", (pDnsRecord->Data.PTR.pNameHost));
    
                // Free memory allocated for DNS records. 
                DnsRecordListFree(pDnsRecord, freetype);
            }
        }
        LocalFree(pSrvList);
    }
    ```

7. On the **Project** menu, click **Properties**.
8. In the **Project Properties** dialog box, expand **Linker** under **Configuration Properties**, click **Command Line**, and then add the following libraries to the **Additional Options** box:

   - Ws2_32.lib
   - Dnsapi.lib
9. Press Ctrl+Shift+B to build the solution.

## Test the sample

- Find the IP address that corresponds to the host name:
`Q831226.exe -n <hostname> -t A -s <IP address of DNS server>`  

    > [!NOTE]
    > **hostname** is the placeholder of the name of the computer that is being queried.

- Find the host name that corresponds to the IP address:
`Q831226.exe -n <xxx.xxx.xxx.xxx> -t PTR -s <IP address of DNS server>`

    > [!NOTE]
    > **xxx.xxx.xxx.xxx** is a placeholder of the IP address of the computer that is being queried.

## References

For more information about DNS lookup, see: [DnsQuery_A function](/windows/win32/api/windns/nf-windns-dnsquery_a).
