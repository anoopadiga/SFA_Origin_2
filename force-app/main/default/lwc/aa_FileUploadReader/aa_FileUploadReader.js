import { LightningElement } from 'lwc';
import SHEETJS from '@salesforce/resourceUrl/SheetJS';
import { loadScript } from 'lightning/platformResourceLoader';

export default class FileReadWriteExcel extends LightningElement {
    sheetJsInitialized = false;
    processedData = [];

    connectedCallback() {
        loadScript(this, SHEETJS)
            .then(() => {
                console.log('SheetJS loaded');
                this.sheetJsInitialized = true;
            })
            .catch(error => {
                console.error('Error loading SheetJS', error);
            });
    }

    handleFileChange(event) {
        const file = event.target.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = (e) => {
            const data = new Uint8Array(e.target.result);
            const workbook = XLSX.read(data, { type: 'array' });

            const firstSheetName = workbook.SheetNames[0];
            const worksheet = workbook.Sheets[firstSheetName];

            const jsonData = XLSX.utils.sheet_to_json(worksheet, { header: 1 });

            console.log('Uploaded Data:', jsonData);

            // Simulate processing (e.g., add a new header or modify rows)
            this.processedData = jsonData.map((row, index) => {
                if (index === 0) {
                    return [...row, 'New Column'];
                } else {
                    return [...row, 'Processed'];
                }
            });

            console.log('Processed Data:', this.processedData);
        };
        reader.readAsArrayBuffer(file);
    }

    downloadExcel() {
        if (this.processedData.length === 0) {
            alert('Please upload and process a file first.');
            return;
        }

        const worksheet = XLSX.utils.aoa_to_sheet(this.processedData);
        const workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet, 'ProcessedSheet');

        // Create and trigger download
        XLSX.writeFile(workbook, 'ProcessedOutput.xlsx');
    }
}