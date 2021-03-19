# Graylog API get unique field value  
Graylog is a tool to collect and centrally store logs. It could be used from web dashboard to search through stored messages. It uses Elasticsearch and thus supports Lucenene query language. It's case sensitive. But for advanced queries it might miss some functionality. That's where Graylog API comes into place. Since Graylog version 4 its API was changed, this example uses this version. It provides first how to run search in API through web GUI. Second, how to run search in API through Powershell.  
We will be looking through collected Windows logs. For `An account was successfully logged on` event. For specific period of time. And then from `IpAddress` field we extract unique value and count how many times login was used for each IP address.  
For more advaced search let's store query body in a file. And run Powershell command `Invoke-RestMethod`.  
Notes to body file    
- `query_string` - this is query you normailly put in Search box in web dashboard. It needs backslash for escape double quotes. We filter internal IPs because we are not interested in them  
- `row_groups` - provides field name we group on. And how many results returned (100)  
Notes to command  
- Basic authentication sends credentials in cleartext  
- Replace `user` and `password` with your Graylog user  
- You could create access tokens which can be used for authentication instead. Navigate to the users configuration menu ``System /  Authentication`` for that  
- Change `192.168.178.26` to your Graylog IP address  
- Chnage `C:\Users\username\graylog=body-request.json` to your JSON body file  
- Script connects to `ip-api` service to get country and organization info. Free plan throttles requests. So workaround is `Start-Sleep -s 4` to pause on each IP address. Expect this command to run long time  
