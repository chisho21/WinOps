function Get-PrintQueue {
   param(
      $QueueName,
      [System.Management.Automation.PSCredential]
      $Credential,
      [string]
      $Server
   )
   
   $params = @{}
   if ($Server){
      $params['Server'] = $Server
   }
   if ($Credential){
         $params['Credential'] = $Credential
   }
   #Get Queue info from AD
   if ($QueueName){
   $queueobjects =  Get-AdObject -filter "objectCategory -eq 'printqueue'" -Prop * @params| Where-object {$_.printShareName -like $QueueName}
   }
   else {
   $queueobjects =  Get-AdObject -filter "objectCategory -eq 'printqueue'" -Prop * @params
   }
   $returnobject = @()
   foreach ($queueobject in $queueobjects){
      $object = [pscustomobject]@{
               QueueName = $queueobject.PrintShareName
               ComputerName = $queueobject.serverName
               Driver = $queueobject.driverName
               Description = $queueobject.Description
               Created = $queueobject.Created
               PortName = $queueobject.portName

      }
      $returnobject += $object
   }#end foreach
   return $returnobject
    
    
}
