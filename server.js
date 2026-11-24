const express = require("express");
const os = require("os");

const app = express();

// El puerto y el nombre del servidor se reciben como variables de entorno
const PORT = process.env.PORT || 3000;
const NOMBRE = process.env.NOMBRE_SERVIDOR || "servidor-sin-nombre";

// Ruta principal de la API
app.get("/api", (req, res) => {
  res.json({
    mensaje: "Hola desde mi API desplegada en AWS",
    servidor: NOMBRE,
    contenedor: os.hostname(),
    fecha: new Date().toISOString(),
  });
});

// Ruta con parámetro
app.get("/api/saludo/:nombre", (req, res) => {
  res.json({
    saludo: `Hola, ${req.params.nombre}`,
    servidor: NOMBRE,
  });
});

// Ruta para comprobar que la aplicación está viva
app.get("/api/salud", (req, res) => {
  res.json({ estado: "ok" });
});

// Dentro de un contenedor debemos escuchar en 0.0.0.0, no en 127.0.0.1
app.listen(PORT, "0.0.0.0", () => {
  console.log(`${NOMBRE} escuchando en el puerto ${PORT}`);
});
