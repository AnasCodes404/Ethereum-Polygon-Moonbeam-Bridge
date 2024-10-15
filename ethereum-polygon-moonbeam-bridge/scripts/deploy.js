async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const Bridge = await ethers.getContractFactory("Bridge");
    const bridge = await Bridge.deploy();
    console.log("Bridge deployed to:", bridge.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
