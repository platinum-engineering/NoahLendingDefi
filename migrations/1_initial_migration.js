const Controller = artifacts.require("NLTController")
const Token = artifacts.require("NoahLendToken")
const PriceOracle = artifacts.require("NoahPriceOracleAnchoredView")

const CONTRACT_ADMIN_ACCOUNT = "0x81Cfe8eFdb6c7B7218DDd5F6bda3AA4cd1554Fd2";

module.exports = async function (deployer, network) {
  try {
    await deployer.deploy(Controller)
    await deployer.deploy(Token, CONTRACT_ADMIN_ACCOUNT)
    await deployer.deploy(PriceOracle, CONTRACT_ADMIN_ACCOUNT)
  } catch (err) {
    console.error(err)
  }
}