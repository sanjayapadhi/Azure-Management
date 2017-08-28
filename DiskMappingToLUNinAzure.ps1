
Login-AzureRmAccount
$subscriptionname = Get-AzureRmSubscription | Out-GridView -Title "Select subscription for the activity..." -PassThru
Select-AzureRmSubscription -SubscriptionName $subscriptionname.SubscriptionName

# locally on the server run this to find the mapping to the Azure LUN number
$disksNumber = get-disk #| select Number 
foreach ($disk in $disksNumber.number)
{
    if ((get-disk -Number $disk | select FriendlyName) -match 'Microsoft Virtual Disk' )
    {
     $diskdetails = get-disk -Number $disk
     $DiskH = "0x"+((get-disk -Number $disk | select path) -split "#" )[2]
     $diskLUN = [convert]::ToInt64($DiskH, 16)
     Write-Host ("Mapping is - Disk= "+$disk +" -  LUN= "+$diskLUN)
    }   
}

