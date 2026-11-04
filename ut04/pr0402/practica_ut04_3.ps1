$euDate = "31-12-2023"
$parte = $euDate.Split('-')
$iso = "$($parte[2])$($parte[1])$($parte[0])"
Write-Host $iso
