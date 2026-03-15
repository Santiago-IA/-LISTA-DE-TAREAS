@echo off
setlocal

set IMAGE_NAME=lista-tareas-mvvm
set CONTAINER_NAME=lista-tareas-mvvm-container
set PORT=8080

echo ============================================
echo  Construyendo imagen Docker: %IMAGE_NAME%
echo ============================================
echo.

docker build -t %IMAGE_NAME% . || (
  echo.
  echo Error al construir la imagen Docker.
  echo Asegurate de tener Docker Desktop encendido.
  pause
  exit /b 1
)

echo.
echo ============================================
echo  Levantando contenedor: %CONTAINER_NAME%
echo ============================================
echo.

docker run --rm -d --name %CONTAINER_NAME% -p %PORT%:80 %IMAGE_NAME% || (
  echo.
  echo Error al iniciar el contenedor.
  echo Asegurate de que el puerto %PORT% este libre.
  pause
  exit /b 1
)

echo Esperando a que el contenedor inicie...
timeout /t 5 >nul

echo Abriendo la aplicacion en el navegador...
start http://localhost:%PORT%

echo.
echo La aplicacion esta corriendo en: http://localhost:%PORT%
echo.
echo Pulsa cualquier tecla para detener el contenedor y cerrar...
pause >nul

echo Deteniendo contenedor...
docker stop %CONTAINER_NAME% >nul

echo Listo.
endlocal

