pragma solidity ^0.5.12;

contract NoahPriceOracleAnchoredView {

    mapping (address => uint256) public sTokens;

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


    function getUnderlyingPrice(address _sToken) external view returns (uint) {
        return sTokens[_sToken];
    }


    function addUnderlyingPrice(uint256 _underlyingPrice, address _sToken) public onlyReporter {
        sTokens[_sToken] = _underlyingPrice;
        emit PriceUpdated(_sToken, _underlyingPrice);
    }


    function setUnderlyingPrice(uint256 _underlyingPrice, address _sToken) public onlyReporter {
        sTokens[_sToken] = _underlyingPrice;
        emit PriceUpdated(_sToken, _underlyingPrice);
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