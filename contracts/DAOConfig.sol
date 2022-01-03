pragma ton-solidity >= 0.47.0;
pragma AbiHeader expire;
pragma AbiHeader pubkey;

contract DAOConfig {

    uint128 MINIMUM_SEND_VALUE = 1_950_000_000;
    uint128 MAX_TOTAL_CLAIMED = 200_000_000_000_000;
    uint128 DEPLOY_VALUE = 600_000_000;
    uint128 DEPLOY_INT_VALUE = 300_000_000;

    string CLAIM_MESSAGE = "claim";
    string CLAIM_MESSAGE_CAP = "Claim";
    string CLAIM_MESSAGE_ALLCAPS = "CLAIM";

    uint16 ERROR_NOT_AUTH = 403;
    uint16 INVALID_PARAMS = 400;
    uint16 ERR_INSUFFICIENT_TOKENS = 405;
    uint16 ERR_SALE_LIMIT_REACHED = 407;
    uint16 ERR_SALE_CLOSED = 408;
    uint16 ERR_SALE_NOT_STARTED = 410;
    uint16 ERR_CLAIMED_LIMIT_REACHED = 411;

    //uint128 DAY_SECONDS = 60 * 60 * 24;
    uint128 DAY_SECONDS = 60 * 60 * 24;
    uint8 SALE_DAYS = 25;
    uint8 DAYS_BEFORE = 7;

}
