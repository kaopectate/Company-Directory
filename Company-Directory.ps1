function Get-PhoneNumbers
{
[CmdletBinding()]
        param(
            [Parameter(Mandatory=$false)]
            [string]$Name
        )

$foos = Get-AdUser -Filter 'EmployeeID -ne "$null"' -Properties Mobile,MobilePhone,telephoneNumber,CN,Department,Description,EmployeeID,manager
foreach($foo in $foos)
{
	if($foo.manager -eq $null)
{
$manager = ""
}
else
{
	$manager = (get-aduser $foo -Properties manager).manager.split('=').split(",") | Select-Object -skip 1 -First 1
}

$props = [ordered]@{
    '-----FullName------' = $foo.Name;
    '-----Department-----' = $foo.Department;
    '-----Description-----' = $foo.Description;
    'Telephone Number' = $foo.telephoneNumber;
    '--MobileNumber--' = $foo.MobilePhone;
    '-----Mobile-----' = $foo.Mobile;
    '-----Manager-----' = $manager
    }
    
    $obj = New-Object -TypeName psobject -Property $props
                       Write-Output $obj
}
}

 

Get-PhoneNumbers | Out-gridview -Title "Employee Directory"