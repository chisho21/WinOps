function Get-NetStat {

    Param(
        $ComputerName,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
        function ns {

            return (netstat -ano).trim() | 
                select-object -Skip 4 | 
                ConvertFrom-String -PropertyNames Protocol,LocalAddress,RemoteAddress,State,Process | 
                select-object Protocol,LocalAddress,RemoteAddress,State,Process,`
                @{Name="ProcessName";Expression={(Get-Process -Id $_.Process).ProcessName}},`
                @{Name="ProcessOwner";Expression={if($_.Process){$process = (Get-CimInstance win32_process -filter "processid = $($_.Process)"); (Invoke-CimMethod -InputObject $process  -MethodName GetOwner).user}}}
            } 
        ns
             
    } # end scriptblock

    #Execute Scriptblock on Computername(s) with set parameters.
    $params = @{
        ScriptBlock = $scriptblock
    }
    if ($ComputerName){
        $params['ComputerName'] = $ComputerName
    }
    if ($Credential){
        $params['Credential'] = $Credential
    }
    Invoke-Command @params


}
