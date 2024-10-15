const { ApiPromise, WsProvider } = require('@polkadot/api');

async function main() {
  try {
    console.log("Connecting to Moonbeam...");

    // Moonbeam's WebSocket endpoint with a 10-second timeout
    const provider = new WsProvider('wss://wss.api.moonbeam.network', 10000);
    
    // Create the API instance
    console.log("Attempting connection...");
    const api = await ApiPromise.create({ provider });
    console.log("Connected to Moonbeam!");

    // Optionally, you can log the current block number as a test
    const blockNumber = await api.rpc.chain.getBlock();
    console.log("Current Block Number:", blockNumber.toString());

  } catch (error) {
    console.error("Error connecting to Moonbeam:", error);
  }
}

main().catch((error) => {
  console.error("Failed to connect:", error);
});
