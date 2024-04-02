const fs = require('fs');
const csv = require('csv-parse');

const inputFilePath = '/Users/dionedge/Documents/GitHub/scripts/tickets-all.csv';

let recordCount = 0;

fs.createReadStream(inputFilePath)
  .pipe(csv.parse({ columns: true })) // Correct usage
  .on('data', () => {
    recordCount++;
  })
  .on('end', () => {
    console.log(`Total records in the file: ${recordCount}`);
  });
