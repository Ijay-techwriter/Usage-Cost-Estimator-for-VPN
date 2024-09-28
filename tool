<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VPN Usage Cost Estimator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        select, input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button {
            background-color: #3498db;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #2980b9;
        }
        #results {
            margin-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .recommendation {
            background-color: #e8f8f5;
            border-left: 5px solid #2ecc71;
            padding: 10px;
            margin-top: 20px;
        }
    </style>
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

    <script>
        const vpnData = [
            {
                name: 'NordVPN',
                link: 'https://go.nordvpn.net/aff_c?offer_id=15&aff_id=90197',
                monthly: 11.99,
                yearly: 4.99,
                twoYear: 3.69,
                devices: 6,
                trial: false,
                moneyback: 30
            },
            {
                name: 'Surfshark',
                link: 'https://get.surfshark.net/aff_c?offer_id=926&aff_id=34209',
                monthly: 12.95,
                yearly: 3.99,
                twoYear: 2.49,
                devices: 'Unlimited',
                trial: true,
                moneyback: 30
            },
            {
                name: 'ProtonVPN',
                link: 'https://protonvpn.com/',
                monthly: 9.99,
                yearly: 5.99,
                twoYear: 4.99,
                devices: 10,
                trial: true,
                moneyback: 30
            },
            {
                name: 'ExpressVPN',
                link: 'https://www.expressvpn.com/',
                monthly: 12.95,
                yearly: 8.32,
                twoYear: 6.67,
                devices: 5,
                trial: false,
                moneyback: 30
            },
            {
                name: 'Private Internet Access',
                link: 'https://www.privateinternetaccess.com/',
                monthly: 11.95,
                yearly: 3.33,
                twoYear: 2.19,
                devices: 10,
                trial: false,
                moneyback: 30
            },
            {
                name: 'IPVanish',
                link: 'https://www.ipvanish.com/',
                monthly: 10.99,
                yearly: 3.99,
                twoYear: 3.33,
                devices: 'Unlimited',
                trial: false,
                moneyback: 30
            }
        ];

        document.getElementById('vpnForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const plan = document.getElementById('plan').value;
            const budget = parseFloat(document.getElementById('budget').value);
            const devices = parseInt(document.getElementById('devices').value);
            const trial = document.getElementById('trial').value;

            let results = vpnData.map(vpn => {
                let cost;
                switch(plan) {
                    case 'monthly':
                        cost = vpn.monthly;
                        break;
                    case 'yearly':
                        cost = vpn.yearly;
                        break;
                    case '2year':
                        cost = vpn.twoYear;
                        break;
                }
                return {
                    ...vpn,
                    cost: cost,
                    withinBudget: cost <= budget,
                    enoughDevices: vpn.devices === 'Unlimited' || vpn.devices >= devices,
                    hasTrial: (trial === 'any') || (trial === 'trial' && vpn.trial) || (trial === 'moneyback' && vpn.moneyback > 0)
                };
            }).filter(vpn => vpn.withinBudget && vpn.enoughDevices && vpn.hasTrial)
              .sort((a, b) => a.cost - b.cost);

            displayResults(results, plan);
        });

        function displayResults(results, plan) {
            const resultsDiv = document.getElementById('results');
            if (results.length === 0) {
                resultsDiv.innerHTML = '<p>No VPN services match your criteria. Please adjust your preferences.</p>';
                return;
            }

            let tableHTML = `
                <table>
                    <tr>
                        <th>VPN</th>
                        <th>Cost (USD/${plan})</th>
                        <th>Devices</th>
                        <th>Free Trial</th>
                        <th>Money-back (days)</th>
                    </tr>
            `;

            results.forEach(vpn => {
                tableHTML += `
                    <tr>
                        <td><a href="${vpn.link}" target="_blank">${vpn.name}</a></td>
                        <td>$${vpn.cost.toFixed(2)}</td>
                        <td>${vpn.devices}</td>
                        <td>${vpn.trial ? 'Yes' : 'No'}</td>
                        <td>${vpn.moneyback}</td>
                    </tr>
                `;
            });

            tableHTML += '</table>';

            const bestVPN = results[0];
            const recommendation = `
                <div class="recommendation">
                    <h3>Recommendation</h3>
                    <p>Based on your preferences, we recommend <strong>${bestVPN.name}</strong>.</p>
                    <p>It offers the best value at $${bestVPN.cost.toFixed(2)} per ${plan}, 
                    supports ${bestVPN.devices} devices, 
                    ${bestVPN.trial ? 'has a free trial, ' : ''}
                    and offers a ${bestVPN.moneyback}-day money-back guarantee.</p>
                    <p><a href="${bestVPN.link}" target="_blank">Learn more about ${bestVPN.name}</a></p>
                </div>
            `;

            resultsDiv.innerHTML = tableHTML + recommendation;
        }
    </script>
</body>
</html>
