# Imagen base con Node.js
FROM node:24-alpine

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos primero package.json para aprovechar la caché de capas
COPY package*.json ./
RUN npm install --omit=dev

# Copiamos el resto del código
COPY server.js ./

# Puerto en el que escucha la aplicación
EXPOSE 3000

# Comando que se ejecuta al iniciar el contenedor
CMD ["node", "server.js"]
