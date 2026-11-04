$fichaServidor = @{
    Hostname = "SRV-AD01"
    IP       = "192.168.1.10"
    RAM_GB   = 32
    Critico  = $true
}

$fichaServidor.RAM_GB = 64
$fichaServidor.SO = "Windows Server 2022"
$fichaServidor.Remove("Critico")

foreach ($clave in $fichaServidor.Keys) {
    $valor = $fichaServidor[$clave]
    Write-Host "$clave : $valor"
}


$objetoServidor = [PSCustomObject]$fichaServidor
$objetoServidor | Export-Csv -Path "servidor.csv" -NoTypeInformation -Encoding utf8

Write-Host "Objeto exportado a 'servidor.csv' correctamente."
Write-Host "----------------------------------------"

$parametrosCarpeta = @{
    Path     = "."            
    Name     = "Logs_ASO"
    ItemType = "Directory"
}

New-Item @parametrosCarpeta
