const sql = require('mssql');

async function getFullSchema() {
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

  const pool = await sql.connect(cfg);
  const tables = [ 'PIC', 'CAR_', 'image_user', 'Tbl_User', 'BB', 'XXX' ];

  for (const table of tables) {
    console.log(`\n=================== TABLE: ${table} ===================`);
    const cols = await pool.request().query(`
      SELECT 
        c.COLUMN_NAME, 
        c.DATA_TYPE, 
        c.CHARACTER_MAXIMUM_LENGTH, 
        c.IS_NULLABLE,
        COLUMNPROPERTY(OBJECT_ID(c.TABLE_SCHEMA + '.' + c.TABLE_NAME), c.COLUMN_NAME, 'IsIdentity') as IsIdentity
      FROM INFORMATION_SCHEMA.COLUMNS c
      WHERE c.TABLE_NAME = '${table}'
      ORDER BY c.ORDINAL_POSITION
    `);
    console.log(JSON.stringify(cols.recordset, null, 2));

    const pks = await pool.request().query(`
      SELECT kcu.COLUMN_NAME
      FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
      JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
        ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
      WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY' AND tc.TABLE_NAME = '${table}'
    `);
    console.log('Primary Key:', pks.recordset.map(p => p.COLUMN_NAME));
  }

  // Also check some lookup data from XXX or PIC if relevant
  const xxxData = await pool.request().query(`SELECT * FROM dbo.XXX`);
  console.log('\nLookup data in XXX:', xxxData.recordset);

  const picData = await pool.request().query(`SELECT TOP 1 * FROM dbo.PIC`);
  console.log('\nSample columns in PIC:', Object.keys(picData.recordset[0] || {}));

  const tblUserData = await pool.request().query(`SELECT TOP 2 * FROM dbo.Tbl_User`);
  console.log('\nSample columns in Tbl_User:', Object.keys(tblUserData.recordset[0] || {}));

  await pool.close();
}

getFullSchema().catch(console.error);
