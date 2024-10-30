const express = require('express');
const { Pool } = require('pg');
const path = require('path'); 
const app = express();
require('dotenv').config(); 


app.use(express.static(path.join(__dirname, 'public'))); 


app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'inicio.html')); 
});


const pool = new Pool({
  user: process.env.DB_USER || 'postgres',      
  host: process.env.DB_HOST || 'localhost',
  database: process.env.DB_NAME || 'ia_db',     
  password: process.env.DB_PASSWORD || 'postgres',  
  port: process.env.DB_PORT || 5432,
});


app.get('/soluciones', async (req, res) => {
  const searchTerm = req.query.keyword ? req.query.keyword.trim() : ''; 

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


const PORT = process.env.PORT || 3000; 
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});
