$inventarioCrudo = @"
DEV-01 | MAC:00-1A-2B-3C-4D-5E | RAM:512MB | SN:a1b2 | STATUS:ACTIVE
switch_core_02 | MAC:001a.2b3c.4d5f | RAM:2GB | SN:X9Y8Z | STATUS:MAINTENANCE
router-edge-03 | MAC:00-1A-2B-3C-4D-60 | RAM:1024MB | SN:f4e3d2 | STATUS:ACTIVE
core_switch_04 | MAC:00:1a:2b:3c:4d:61 | RAM:4GB | SN:7m8n | STATUS:RETIRED
"@

$resultado = foreach ($linea in $inventarioCrudo.split("`n")) {

    $datos = $linea -split "\|"
    $dispositivo = ($datos[0].ToLower().replace("_", "-").Trim())
    $mac = ($datos[1].replace("MAC:", "").replace(".", "").replace("-","").replace(":","").ToUpper().Trim())
    $mac = $mac.Substring(0,2) + ":" + $mac.Substring(2,2) + ":" + $mac.Substring(4,2) + ":" + $mac.Substring(6,2) + ":" + $mac.Substring(8,2) + ":" + $mac.Substring(10,2)
    $ram = ($datos[2].replace("RAM:", "").Trim())
    $sn = ($datos[3].replace("SN:", "").ToUpper().Trim())
    if ($sn.Length -lt 5) {
        $sn = "00" + $sn
    }
    elseif ($sn.Length -lt 6) {
        $sn = "0" + $sn
    }
    $status = ($datos[4].replace("STATUS:", "").Trim())
    if ($status -eq "RETIRED") {
        continue
    }

    [PSCustomObject]@{
        Dispositivo  = $dispositivo
        MAC          = $mac
        RAM          = $ram
        SerialNumber = $sn
        Status       = $status
    }
}

$resultado | Export-Csv "inventario_red.csv" -Encoding UTF8 -NoTypeInformation