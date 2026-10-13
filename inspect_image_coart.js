const sql = require('mssql');

async function inspectDb() {
  const cfg = {
    server: '185.181.111.17',
    port: 1433,
    database: 'image_coart',
    user: 'ASA',
    password: 'Nazhad9999',
    connectionTimeout: 10000,
    options: {
      encrypt: false,
      trustServerCertificate: true
    }
  };

  try {
    const pool = await sql.connect(cfg);
    console.log('Connected to image_coart.');

    const tables = await pool.request().query(`
      SELECT TABLE_NAME 
      FROM INFORMATION_SCHEMA.TABLES 
      WHERE TABLE_TYPE = 'BASE TABLE'
    `);
    console.log('Tables in image_coart:', tables.recordset.map(t => t.TABLE_NAME));

    for (const t of tables.recordset) {
      const count = await pool.request().query(`SELECT COUNT(*) as c FROM dbo.[${t.TABLE_NAME}]`);
      console.log(`Table ${t.TABLE_NAME} row count:`, count.recordset[0].c);
    }

    await pool.close();
  } catch (err) {
    console.error('Error:', err.message);
  }
}

inspectDb();
