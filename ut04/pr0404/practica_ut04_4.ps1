$logCrudo = @"
[INFO] ID:8842 :: 2023/11/01_10:00 :: User:admin_01 :: Action:Login_Success
[ERROR] ID:9921 :: 2023/11/01_10:05 :: User:guest_user :: Action:Auth_Fail (Pass)
[WARN] ID:8843 :: 2023-11-01 10:15 :: User:dev_team :: Action:Upload_Limit_Exceeded
[CRITICAL] ID:1001 :: 01-11-2023_10:20 :: User:ROOT :: Action:Service_Stop
"@

$resultados = foreach ($linea in $logCrudo.split("`n")) {

    $datos = $linea -split "::"
    
    $fecha = $datos[1].Replace("_", " ").replace("/", "-").trim()
    if ($fecha -match '^\d{2}-\d{2}-\d{4}') {
    $fecha = $fecha.Substring(6,4) + "-" + $fecha.Substring(3,2) + "-" + $fecha.Substring(0,2) + $fecha.Substring(10)
    }

    $usuario = ($datos[2].split(":")[1].ToLower().replace(" ", "").trim())

    if ($usuario -eq "root") {
        $usuario = "administrator"
    }

    $gravedad = ($datos[0].split(":")[0].replace("[", "").replace("]", "").replace(" ", "").replace("ID", "").trim())

    if ($gravedad -eq "INFO") {
        continue
    }

    $id = ($datos[0].split(":")[1].replace(" ", "").trim())

    $accion = ($datos[3].replace("Action:", "").Trim())

    [PSCustomObject]@{
        TimeStamp = $fecha
        Severity  = $gravedad
        User      = $usuario
        EventID   = $id
        Action    = $accion
    }
}

$resultados | Export-Csv "reporte_seguridad.csv" -Encoding UTF8 -NoTypeInformation
