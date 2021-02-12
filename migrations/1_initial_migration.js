const Controller = artifacts.require("NLTController")
const Token = artifacts.require("NoahLendToken")
const PriceOracle = artifacts.require("NoahPriceOracleAnchoredView")

module.exports = async function (deployer, network) {
  try {
    await deployer.deploy(Token)
    await deployer.deploy(Controller)
    await deployer.deploy(PriceOracle, Token.address)
  } catch (err) {
    console.error(err)
  }
}