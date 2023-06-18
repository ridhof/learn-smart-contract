const { ethers } = require("hardhat");

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const unlockTime = currentTimestampInSeconds + 60;
  const lockedAmount = ethers.parseEther("0.001");
  const vending = await ethers.deployContract("VendingMachine", {
    value: lockedAmount,
  });

  await vending.waitForDeployment();

  console.log(
    `Lock with ${ethers.formatEther(
      lockedAmount
    )}ETH and unlock timestamp ${unlockTime} deployed to ${vending.target}`
  );
}

main()
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
