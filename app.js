const express = require('express');
const { Pool } = require('pg');
const path = require('path'); // Importa el módulo path
const app = express();
require('dotenv').config(); // Cargar variables de entorno (opcional, si usas dotenv)

// Middleware para servir archivos estáticos
app.use(express.static(path.join(__dirname, 'public'))); // Ruta absoluta para mayor seguridad

// Ruta para redirigir a la página principal
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'inicio.html')); // Usamos path.join para mayor compatibilidad
});

// Configuración de la conexión a PostgreSQL
const pool = new Pool({
  user: process.env.DB_USER || 'postgres',       // Cambia esto o usa variables de entorno
  host: process.env.DB_HOST || 'localhost',
  database: process.env.DB_NAME || 'ia_db',     // Cambia esto o usa variables de entorno
  password: process.env.DB_PASSWORD || 'postgres',  // Cambia esto o usa variables de entorno
  port: process.env.DB_PORT || 5432,
});

// Endpoint para buscar soluciones de IA
app.get('/soluciones', async (req, res) => {
  const searchTerm = req.query.keyword ? req.query.keyword.trim() : ''; // Eliminar espacios innecesarios

  if (!searchTerm) {
    return res.status(400).json({ error: 'Debe proporcionar un término de búsqueda.' });
  }

  try {
    const result = await pool.query(
      `SELECT * FROM solucion_ia WHERE nombre ILIKE $1 OR descripcion ILIKE $1`,
      [`%${searchTerm}%`]
    );
    res.json(result.rows);
  } catch (err) {
    console.error('Error en la consulta a la base de datos:', err);
    res.status(500).json({ error: 'Error al obtener las soluciones' });
  }
});

// Inicializa el servidor
const PORT = process.env.PORT || 3000; // Puerto configurable desde variables de entorno
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});
