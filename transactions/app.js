const express = require('express');
const app = express();

app.get('/api/transactions', (req, res) => {
  res.json({ status: "ok", service: "transactions", message: "Transactions service responding" });
});

app.listen(5001, () => console.log("Transactions service running on port 5001"));
