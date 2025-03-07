const hrh = require('hardhat');
const {ethers} = hrh;

async function main() {
    const Selection = await ethers.getContractFactory('Selection');
    const selection = await Selection.deploy();
    await selection.waitForDeployment();

    console.log('Token address: ', await selection.getAddress());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });