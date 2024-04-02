const fs = require('fs');
const csv = require('csv');
const readline = require('readline');

const inputFilePath = '/Users/dionedge/Documents/GitHub/scripts/clean-tickets-all.csv';
const outputFilePath = '/Users/dionedge/Documents/GitHub/scripts/random-200000-records.csv';

// Step 1: Determine the total number of records
async function countRecords(filePath) {
    let lineCount = 0;
    const fileStream = fs.createReadStream(filePath);

    const rl = readline.createInterface({
        input: fileStream,
        crlfDelay: Infinity,
    });

    for await (const line of rl) {
        lineCount++;
    }

    // Subtract 1 for the header row
    return lineCount - 1;
}

// Step 2: Generate 200000 unique random indices
function generateRandomIndices(totalCount) {
    let indices = new Set();
    while(indices.size < 200000) {
        const randomIndex = Math.floor(Math.random() * totalCount) + 1; // +1 to skip header
        indices.add(randomIndex);
    }
    return [...indices];
}

// Step 3: Extract and write selected records
async function extractRandomRecords(indices, inputPath, outputPath) {
    const inputStream = fs.createReadStream(inputPath);
    const outputStream = fs.createWriteStream(outputPath);
    let currentIndex = 0;

    const parser = csv.parse({ columns: true });
    const stringifier = csv.stringify({ header: true });

    parser.on('readable', function() {
        let record;
        while ((record = parser.read()) !== null) {
            currentIndex++;
            // Check if current record's index is in the selected random indices
            if (indices.includes(currentIndex)) {
                stringifier.write(record);
            }
        }
    });

    parser.on('end', () => stringifier.end());

    stringifier.on('finish', () => {
        console.log('Random extraction complete.');
    });

    inputStream.pipe(parser);
    stringifier.pipe(outputStream);
}

// Main function to coordinate the steps
async function main() {
    const totalRecords = await countRecords(inputFilePath);
    const randomIndices = generateRandomIndices(totalRecords);
    await extractRandomRecords(randomIndices, inputFilePath, outputFilePath);
}

main();