pragma solidity ^0.5.12;

contract NoahPriceOracleAnchoredView {

    mapping (address => uint256) public cTokens;

    address public reporter;
    address public pendingReporter;

    modifier onlyReporter() {
        require(msg.sender == reporter, "NoahPriceOracle: sender isn't reporter");
        _;
    }

    event PriceUpdated(address token, uint price);
    event ReporterUpdated(address previousReporter, address newReporter);

    constructor(address _reporter) public {
        reporter = _reporter;
        emit ReporterUpdated(address(0x0), reporter);
    }


    function getUnderlyingPrice(address _cToken) external view returns (uint) {
        return cTokens[_cToken];
    }


    function addUnderlyingPrice(uint256 _underlyingPrice, address _cToken) public onlyReporter {
        cTokens[_cToken] = _underlyingPrice;
        emit PriceUpdated(_cToken, _underlyingPrice);
    }


    function setUnderlyingPrice(uint256 _underlyingPrice, address _cToken) public onlyReporter {
        cTokens[_cToken] = _underlyingPrice;
        emit PriceUpdated(_cToken, _underlyingPrice);
    }


    function pendingReporterAddress(address _newReporter) public onlyReporter {
        pendingReporter = _newReporter;
    }


    function acceptPendingReporter() public onlyReporter {
        emit ReporterUpdated(reporter, pendingReporter);
        reporter = pendingReporter;
        pendingReporter = address(0x0);
    }

}