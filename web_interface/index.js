const express = require('express');
const path = require('path');
const axios = require('axios');

const app = express();
const port = process.env.PORT || 3000;
const apiUrl = process.env.API_URL || 'http://localhost:5000';

app.use(express.static('public'));

// Basic HTML template
const htmlTemplate = `
<!DOCTYPE html>
<html>
<head>
    <title>BrainCast - YouTube Prediction</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .prediction-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .thumbnail {
            width: 100%;
            max-width: 640px;
            height: auto;
            border-radius: 4px;
        }
        h1 {
            color: #FF0000;
        }
        h2 {
            margin-top: 10px;
        }
        p {
            color: #606060;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>BrainCast</h1>
        <p>YouTube Video Prediction Platform</p>
        
        <div class="prediction-card">
            <img class="thumbnail" src="https://placeholder.com/640x360" alt="Predicted Thumbnail">
            <h2>Why This New Technology Will Change Everything</h2>
            <p>In this video, we explore the revolutionary technology that's about to transform the industry.</p>
            <p><small>Confidence: 87%</small></p>
        </div>
    </div>
</body>
</html>
`;

app.get('/', (req, res) => {
    res.send(htmlTemplate);
});

app.get('/api/prediction/:channelId', async (req, res) => {
    try {
        const channelId = req.params.channelId;
        const response = await axios.get(`${apiUrl}/predict/${channelId}`);
        res.json(response.data);
    } catch (error) {
        console.error('Error fetching prediction:', error);
        res.status(500).json({ error: 'Failed to fetch prediction' });
    }
});

app.listen(port, () => {
    console.log(`Web interface running at http://localhost:${port}`);
});
