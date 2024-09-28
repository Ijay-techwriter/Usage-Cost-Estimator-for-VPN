<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VPN Usage Cost Estimator</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>VPN Usage Cost Estimator</h1>
    <form id="vpnForm">
        <label for="plan">Subscription Plan:</label>
        <select id="plan" required>
            <option value="monthly">Monthly</option>
            <option value="yearly">Yearly</option>
            <option value="2year">2-Year</option>
        </select>

        <label for="budget">Monthly Budget (USD):</label>
        <input type="number" id="budget" min="1" step="0.01" required>

        <label for="devices">Number of Devices:</label>
        <input type="number" id="devices" min="1" required>

        <label for="trial">Free Trial or Money-back Guarantee:</label>
        <select id="trial" required>
            <option value="any">Any</option>
            <option value="trial">Free Trial</option>
            <option value="moneyback">Money-back Guarantee</option>
        </select>

        <button type="submit">Estimate Costs</button>
    </form>

    <div id="results"></div>

    <script src="script.js"></script>
</body>
</html>
