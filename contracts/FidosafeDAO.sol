pragma ton-solidity >= 0.47.0;
pragma AbiHeader expire;
pragma AbiHeader pubkey;

import "./interfaces/IRootTokenContract.sol";
import "./interfaces/ITransferOwner.sol";
import "./interfaces/ISendSurplusGas.sol";
import "DAOConfig.sol";

contract FidosafeDAO is DAOConfig
{

    struct ClaimItem {
        uint128 balance;
        bool claimed;
        uint128 claimDate;
    }

    struct ClaimItemImport {
        uint128 balance;
        address claimAddress;
    }

    struct Details {
        uint128 maxTokens;
        uint128 totalSold;
        uint128 totalClaimed;
        uint128 startTime;
        uint128 endTime;
        uint128 floatProcent;
    }

    uint256 static _randomNonce;
    address public rootTokenAddress;
    uint128 maxTokens;
    uint128 totalSold;
    uint128 totalClaimed;
    uint128 startTime;
    uint128 endTime;
    uint32 currentAffiliateId;

    mapping(uint32 => address) public mAffiliates;
    mapping (address => ClaimItem) mClaimItems;

    constructor(
        uint128 maxTokensToSale, address tokenAddress
    ) public {
        require(msg.pubkey() != 0, INVALID_PARAMS);
        tvm.accept();
        maxTokens = maxTokensToSale;
        rootTokenAddress = tokenAddress;
        // start only after 7 days
        startTime = now + DAYS_BEFORE * DAY_SECONDS;
        endTime = startTime + DAY_SECONDS * SALE_DAYS;
        // startTime = now;
        totalSold = 0;
        currentAffiliateId = 1001;
    }

    modifier onlyOwner() {
        require(msg.pubkey() != 0 && msg.pubkey() == tvm.pubkey(), ERROR_NOT_AUTH, "Not authorized");
        _;
    }

    //
    //  Internal functions
    //

    function getAffiliateId(address afAddress) private view returns (uint32) {
        for ((uint32 afId, address af): mAffiliates) {
            if (af == afAddress)
                return afId;
        }
        return uint32(0);
    }

    function getFloatProcent() private view returns (uint128 floatProcent) {

        if ((now < startTime) || (now > endTime)) {
            floatProcent = 0;
        }
        else {
            floatProcent = SALE_DAYS - 1 * math.divc((now - startTime), DAY_SECONDS) + 1;
        }
    }

    function calculateTokens(uint128 tokens) private view returns (uint128) {
        // Initially we give 10 FIDO for 1 EVER
        tokens = tokens * 10;
        // Additionally, we add the bonus for urgency

        uint floatProcent = getFloatProcent();

        tvm.log(format("Current rate: {}, tokens: {:t}", floatProcent, tokens));
        return uint128(math.divr(tokens, 100) * (100 + floatProcent));
    }

    function sendToAffiliate(string message, uint128 value) private {

        if (message.byteLength() < 5) {

            (optional(uint256) affId, bool succeed)= stoi(message);
            tvm.log(format("Raw affiliate ID: {}", message));
            if (succeed) {
                uint32 affiliateId = uint32(affId.get());
                tvm.log(format("Affiliate ID: {}", affiliateId));
                if (mAffiliates.exists(affiliateId)) {
                    // Send to an affiliate
                    tvm.log(format("Affiliate exists: {}", affiliateId));
                    IRootTokenContract(rootTokenAddress).deployWallet{ value: DEPLOY_VALUE, flag: 0 }(
                        value,
                        DEPLOY_INT_VALUE,
                        0,
                        mAffiliates[affiliateId],
                        msg.sender
                    );
                    totalSold += msg.value;
                    TvmBuilder messageBody;
                    messageBody.store(uint32(0), format("Поздравляем! Вы получили {:t} FIDO по нашей реферальной программе!", value));
                    mAffiliates[affiliateId].transfer(10000, false, 1, messageBody.toCell());
                }
            }
        }
    }

    //
    //  On-chain functions
    //

    function drain(address receiver) onlyOwner public pure {
        tvm.accept();
        receiver.transfer({ value: 0, flag: 128 });
    }

    function sendSurplusGas(address receiver) onlyOwner public view {
        tvm.accept();
        ISendSurplusGas(rootTokenAddress).sendSurplusGas(receiver);
    }

    function addClaimers(ClaimItemImport[] claimItems) onlyOwner external {
        tvm.accept();
        for (ClaimItemImport cImport: claimItems) {

            mClaimItems[cImport.claimAddress] = ClaimItem(cImport.balance, false, 0);
        }
    }

    function transferOwner(
        uint256 rootPublicKey,
        address rootAddress
    ) onlyOwner external view {
        tvm.accept();
        ITransferOwner(rootTokenAddress).transferOwner(rootPublicKey, rootAddress);
    }

    receive() external {

        require(msg.value >= MINIMUM_SEND_VALUE, ERR_INSUFFICIENT_TOKENS);
        uint128 reserve = math.max(0, address(this).balance - msg.value);
        tvm.rawReserve(reserve, 2);

        require(totalSold + totalClaimed < maxTokens, ERR_SALE_LIMIT_REACHED);
        require(now > startTime, ERR_SALE_NOT_STARTED);
        require(now < endTime, ERR_SALE_CLOSED);

        TvmSlice msgDataSlice = msg.data;

        if (!msgDataSlice.empty()) {
            (, string message) = msgDataSlice.decode(uint32, string);

            if (message == CLAIM_MESSAGE || message == CLAIM_MESSAGE_CAP || message == CLAIM_MESSAGE_ALLCAPS) {
                require(totalClaimed < MAX_TOTAL_CLAIMED, ERR_CLAIMED_LIMIT_REACHED);
                ClaimItem ci = getClaimerByAddress(msg.sender);
                if ((ci.balance > 0) && (ci.claimed == false)) {
                    IRootTokenContract(rootTokenAddress).deployWallet{ value: DEPLOY_VALUE, flag: 0 }(
                        ci.balance,
                        DEPLOY_INT_VALUE,
                        0,
                        msg.sender,
                        msg.sender
                    );
                    totalClaimed += ci.balance;
                    tvm.log(format("Total claimed: {}", totalClaimed));
                    ci.claimed = true;
                    ci.claimDate = now;
                    mClaimItems[msg.sender] = ci;
                    TvmBuilder messageBody;
                    messageBody.store(uint32(0), format("Дорогой участник ДАО!\n\nМы отправили вам {:t} FIDO токенов. Получите еще больше токенов FIDO, захватывая их бесплатно или приглашая друзей по своей реферальной ссылке.\n\nПодробнее на http://dao.fidosafe.com\n\nCheers!", ci.balance));
                    msg.sender.transfer(10000, false, 1, messageBody.toCell());
                }
                else {
                    TvmBuilder messageBody;
                    messageBody.store(uint32(0), "Дорогой участник ДАО!\n\nДанный адрес либо уже получил FIDO токены, либо не участвовал в акции. Мы вернули отправленные средства назад.");
                    msg.sender.transfer(10000, false, 128, messageBody.toCell());
                }
                return;
            }
            sendToAffiliate(message, msg.value);
        }

        uint128 tokens;
        tokens = calculateTokens(msg.value);
        tvm.log(format("Tokens: {}", tokens));

        IRootTokenContract(rootTokenAddress).deployWallet{ value: DEPLOY_VALUE, flag: 0 }(
            tokens,
            DEPLOY_INT_VALUE,
            0,
            msg.sender,
            msg.sender
        );
        totalSold += tokens;
        tvm.log(format("Total sold: {}", totalSold));
        uint32 affId = getAffiliateId(msg.sender);

        if (affId == 0) {
            mAffiliates[currentAffiliateId] = msg.sender;
            affId = currentAffiliateId;
            currentAffiliateId += 1;
        }

        TvmBuilder messageBody;
        messageBody.store(uint32(0), format("Дорогой участник ДАО!\n\nМы отправили вам {:t} FIDO токенов (с учетом бонуса +{}%). Получите еще больше токенов FIDO, захватывая их бесплатно или приглашая друзей по своей реферальной ссылке.\n\nВаш реферальный код: {}\n\nПроверьте свой баланс токенов и прочитайте больше на\n\nhttps://dao.fidosafe.com\nCheers!", tokens, getFloatProcent(), affId));
        msg.sender.transfer(10000, false, 1, messageBody.toCell());

    }

    function getClaimerByAddress(address claimerAddress) public view returns (ClaimItem data) {
        if (mClaimItems.exists(claimerAddress))
            return mClaimItems[claimerAddress];
        ClaimItem ciEmpty;
        return ciEmpty;
    }

    function getDetails() public view returns (Details data) {
        return Details(maxTokens, totalSold, totalClaimed, startTime, endTime, getFloatProcent());
    }

}