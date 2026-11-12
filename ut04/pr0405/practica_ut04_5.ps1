$logsWeb = @"
POST /api/v1/auth/login?session=a8f93j2&token=expired [IP: 192.168.10.45] [Agent: Mozilla/5.0] [ERR-0040-AUTH]
GET /api/v2/products/search?q=laptop&sort=asc [IP: 10.0.2.15] [Agent: Chrome/110.0] [ERR-0200-OK]
DELETE /api/v1/admin/drop_table?confirm=true&force=1 [IP: 172.16.254.88] [Agent: ScriptBot/1.2] [ERR-0500-FATAL]
GET /api/v1/user/profile?id=9921&token=xyz [IP: 192.168.10.102] [Agent: Firefox/109.0] [ERR-0403-FORBIDDEN]
"@

$resultado = foreach ($linea in $logsWeb.split("`n")) {

    $datos = $linea -split "\["
    
    $metodo = ($datos[0].split(" ")[0].Trim())
    $ruta = ($datos[0].split(" ")[1].Trim())
    $rutalimpia = $ruta.split("?")[0].Trim()
    
    $ip = ($datos[1].replace("IP:", "").replace("]", "").Trim())
    $partesip = $ip.split(".")
    $partesip[3] = "***"
    $ip = $partesip[0] + "." + $partesip[1] + "." + $partesip[2] + "." + $partesip[3]
    $agente = ($datos[2].replace("Agent:", "").replace("]", "").Trim())
    $codigo = ($datos[3].replace("ERR-", "").replace("]", "").split("-").Trim())
    if ($codigo[1] -eq "OK") {
        continue
    }
    $codigo = $codigo[0]

    [PSCustomObject]@{
        Method     = $metodo
        CleanPath  = $rutalimpia
        MaskedIP   = $ip
        ErrorCode  = $codigo
        Agent      = $agente
    }
}

$resultado | Export-Csv "auditoria_web.csv" -Encoding UTF8 -NoTypeInformation