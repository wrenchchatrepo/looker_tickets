const fs = require('fs');
const parse = require('csv-parse');

const inputFilePath = '/Users/dionedge/Documents/GitHub/scripts/tickets-all-cleaned.csv';

let nonAsciiRecordCount = 0; // Counter for records with non-ASCII characters

fs.createReadStream(inputFilePath)
  .pipe(parse.parse({ columns: true }))
  .on('data', (record) => {
    const recordString = JSON.stringify(record);
    if (!/^[\x00-\x7F]*$/.test(recordString)) { // Check for non-ASCII characters
      nonAsciiRecordCount++;
      // Uncomment the next line if you want to see the full content of problematic records
      // console.log('Potentially problematic record found:', record);
    }
  })
  .on('end', () => {
    console.log(`File processing complete. Found ${nonAsciiRecordCount} records with non-ASCII characters.`);
  });
