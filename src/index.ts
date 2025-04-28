import express from "express";

const app = express();
const port = 3000;

// Ping API
app.get("/test", (req, res) => {
	res.send("test");
});

app.listen(port, () => {
	console.log(`Server is running on http://localhost:${port}`);
});
