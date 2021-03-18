$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "user","password")))
$uri = 'http://192.168.178.26:9000/api/views/search/sync'
$body = Get-Content "C:\Users\username\graylog=body-request.json"
$ipaddressrequest = Invoke-RestMethod -Uri $uri -Headers @{Authorization = "Basic $base64AuthInfo"; "X-Requested-By" = "cli"} -Method Post -ContentType "application/json" -Body $body
$uniqueipaddresses = $ipaddressrequest.results.qid.search_types.stid.rows | select @{Name='key'; Expression ={$_.key[0]}}, @{Name='count'; Expression ={$_.values.value}}, @{Name='country';Expression={ if ($_.key[0] -match "(^127\.)|(^192\.168\.)|(^10\.)|(^172\.1[6-9]\.)|(^172\.2[0-9]\.)|(^172\.3[0-1]\.)|(^::1$)|(^[fF][cCdD])") {""} else {Start-Sleep -s 4; $(Invoke-RestMethod -Method get -uri http://ip-api.com/json/$($_.key[0])).country}}}, @{Name='organization'; Expression={if ($_.key[0] -match "(^127\.)|(^192\.168\.)|(^10\.)|(^172\.1[6-9]\.)|(^172\.2[0-9]\.)|(^172\.3[0-1]\.)|(^::1$)|(^[fF][cCdD])") {""} else {$(Invoke-RestMethod -Method get -uri http://ip-api.com/json/$($_.key[0])).org}}} | sort country
$uniqueipaddresses
