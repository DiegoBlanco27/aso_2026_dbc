$fechaActual = Get-Date

Write-Host "El ano actual es: $($fechaActual.Year)"

$fechaCaducidad = $fechaActual.AddDays(45)
Write-Host "La contrasena caducara el: $fechaCaducidad"


$inicio = Get-Date

Start-Sleep -Seconds 3

$fin = Get-Date

[TimeSpan]$tiempoTotal = $fin - $inicio

Write-Host "Tiempo total transcurrido: $($tiempoTotal.TotalSeconds) segundos"
