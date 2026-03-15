#!/usr/bin/env bash

set -euo pipefail

IMAGE_NAME="lista-tareas-mvvm"
CONTAINER_NAME="lista-tareas-mvvm-container"
PORT="${PORT:-8080}"

echo "============================================"
echo "  Construyendo imagen Docker: ${IMAGE_NAME}"
echo "============================================"
echo

docker build -t "${IMAGE_NAME}" .

echo
echo "============================================"
echo "  Levantando contenedor: ${CONTAINER_NAME}"
echo "============================================"
echo

docker run --rm -d --name "${CONTAINER_NAME}" -p "${PORT}:80" "${IMAGE_NAME}"

echo "Esperando a que el contenedor inicie..."
sleep 5

URL="http://localhost:${PORT}"
echo "La aplicacion esta corriendo en: ${URL}"

# Intentar abrir navegador de forma portable
if command -v xdg-open >/dev/null 2>&1; then
  xdg-open "${URL}" >/dev/null 2>&1 || true
elif command -v open >/dev/null 2>&1; then
  open "${URL}" >/dev/null 2>&1 || true
fi

echo
echo "Para detener el contenedor, pulsa CTRL+C o ejecuta:"
echo "  docker stop ${CONTAINER_NAME}"

# Mantener el script en primer plano hasta interrupcion
trap 'echo; echo "Deteniendo contenedor..."; docker stop "${CONTAINER_NAME}" >/dev/null 2>&1 || true; exit 0' INT
while true; do
  sleep 1
done

