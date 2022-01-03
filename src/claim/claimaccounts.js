const { TonClient } = require("@tonclient/core");
const { libNode } = require("@tonclient/lib-node");

// node src\claim\claimaccounts.js
// tondev contract run FidosafeDAO.abi.json addClaimers --address 0:2540afc97408aec8e094eaf2695acd8fd4c301830590214be584e4b627e5bf90 -i '{"claimItems":[{"balance":0,"claimAddress":0}]}'

(async () => {
    try {
        // Link the platform-dependable TON-SDK binary with the target Application in Typescript
        // This is a Node.js project, so we link the application with `libNode` binary
        // from `@tonclient/lib-node` package
        // If you want to use this code on other platforms, such as Web or React-Native,
        // use  `@tonclient/lib-web` and `@tonclient/lib-react-native` packages accordingly
        // (see README in  https://github.com/tonlabs/ton-client-js )
        TonClient.useBinaryLibrary(libNode);
        const client = new TonClient({
            network: {
                // Local node URL here
                endpoints: ["main.ton.dev"]
            }
        });
        console.log("Hello localhost TON!");
        await main(client);
        process.exit(0);
        client.close();
    } catch (error) {
        if (error.code === 504) {
            console.error(`Network is inaccessible. You have to start TON OS SE using \`tondev se start\`.\n If you run SE on another port or ip, replace http://localhost endpoint with http://localhost:port or http://ip:port in index.js file.`);
        } else {
            console.error(error);
        }
    }
})();

async function main(client) {
    let continueLoop = true;
    let startAddress = "0";
    let addresses = [];
    let counter = 1;
    while (continueLoop) {
        let col = await client.net.query_collection({
            collection: "accounts",
            filter: {
                balance: {
                    gt:  "10000000000",
                    lt:  "10000000000000"
                },
                id: {
                    gt: `${startAddress}`
                }
            },
            order: [
                {
                    path: "id",
                    direction: "ASC"
                }
            ],
            limit: 50,
            result: 'id, balance'
        });
        if (col.result.length === 0) {
            break;
        }
        for (let item of col.result) {
            addresses.push({id: item.id, balance: item.balance, claimed: false});
            startAddress = item.id;
            console.log(`Added: ${counter}`);
            counter +=1;
        }


    }
    const fs = require('fs');
    fs.writeFileSync('./src/claim/claimers01012022.json', JSON.stringify(addresses));

}