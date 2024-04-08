// Use this code snippet in your app.
// If you need more information about configurations or implementing the sample code, visit the AWS docs:
// https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started.html

import {
    SecretsManagerClient,
    GetSecretValueCommand,
  } from "@aws-sdk/client-secrets-manager";
  
  const secret_name = "rds_credentials";
  
  const client = new SecretsManagerClient({
    region: "us-east-2",
  });
  
  let response;
  
  try {
    response = await client.send(
      new GetSecretValueCommand({
        SecretId: secret_name,
        VersionStage: "AWSCURRENT", // VersionStage defaults to AWSCURRENT if unspecified
      })
    );
  } catch (error) {
    // For a list of exceptions thrown, see
    // https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_GetSecretValue.html
    throw error;
  }
  
  const secretValue = response.SecretString;
  
  
  // Your code goes here

import express from 'express';
import bodyParser from 'body-parser';
import mysql from 'mysql';
import path from 'path';
const __dirname = path.resolve();

const app = express();
const port = 3000;

// Configure body parser middleware
app.use(bodyParser.urlencoded({ extended: false }));

// Error handling middleware (example)
app.use((err, req, res, next) => {
  console.error(err.stack);  // Log error details
  res.status(500).send('Internal Server Error');
  next();
});

// Database connection (separate file - db.js)
const connection = mysql.createConnection({
  host: 'zeus-db-instance.cpo2sm6moz1z.us-east-2.rds.amazonaws.com',
  user: 'foo',
  password: secretValue,
  database: 'webappdb'
});

connection.connect((err) => {
  if (err) {
    console.error('Error connecting to database:', err);
    process.exit(1);
  }
  console.log('Connected to database');
});

// Function to execute a query with error handling (db.js)
function executeQuery(sql, params, callback) {
  connection.query(sql, params, (err, result) => {
    if (err) {
      console.error('Error executing query:', err);
      return callback(err);
    }
    callback(null, result);
  });
}

// Serve the HTML form at the root path
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/index.html');
});

// Route to handle form submission
app.post('/submit', (req, res) => {
  const name = req.body.name;
  const email = req.body.email;

  // Prepare SQL query with placeholders
  const sql = `INSERT INTO trynode (name, email) VALUES (?, ?)`;

  // Execute query using separate function (db.js)
  executeQuery(sql, [name, email], (err, result) => {
    if (err) {
      // Handle specific errors (e.g., duplicate email)
      if (err.code === 'ER_DUP_ENTRY') {
        return res.status(400).send('Duplicate email address');
      }
      // Handle other errors
      return res.status(500).send('Error submitting data');
    }
    res.send('Data submitted successfully!');
  });
});

// Route to retrieve all data
app.get('/data', (req, res) => {
    const sql = `SELECT * FROM trynode`;  // Adjust query to select specific data
  
    executeQuery(sql, [], (err, data) => {
      if (err) {
        return res.status(500).send('Error retrieving data');
      }
      res.json(data);  // Send data as JSON
    });
  });

app.listen(port, () => {
  console.log(`Server listening on port ${port}`)
})
