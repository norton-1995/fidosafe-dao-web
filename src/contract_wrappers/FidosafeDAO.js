const FidosafeDAOContract = {
    abi: {
        "ABI version": 2,
        "header": [
            "pubkey",
            "time",
            "expire"
        ],
        "functions": [
            {
                "name": "constructor",
                "inputs": [
                    {
                        "name": "maxTokensToSale",
                        "type": "uint128"
                    },
                    {
                        "name": "tokenAddress",
                        "type": "address"
                    }
                ],
                "outputs": []
            },
            {
                "name": "drain",
                "inputs": [
                    {
                        "name": "receiver",
                        "type": "address"
                    }
                ],
                "outputs": []
            },
            {
                "name": "sendSurplusGas",
                "inputs": [
                    {
                        "name": "receiver",
                        "type": "address"
                    }
                ],
                "outputs": []
            },
            {
                "name": "addClaimers",
                "inputs": [
                    {
                        "components": [
                            {
                                "name": "balance",
                                "type": "uint128"
                            },
                            {
                                "name": "claimAddress",
                                "type": "address"
                            }
                        ],
                        "name": "claimItems",
                        "type": "tuple[]"
                    }
                ],
                "outputs": []
            },
            {
                "name": "transferOwner",
                "inputs": [
                    {
                        "name": "rootPublicKey",
                        "type": "uint256"
                    },
                    {
                        "name": "rootAddress",
                        "type": "address"
                    }
                ],
                "outputs": []
            },
            {
                "name": "getClaimerByAddress",
                "inputs": [
                    {
                        "name": "claimerAddress",
                        "type": "address"
                    }
                ],
                "outputs": [
                    {
                        "components": [
                            {
                                "name": "balance",
                                "type": "uint128"
                            },
                            {
                                "name": "claimed",
                                "type": "bool"
                            },
                            {
                                "name": "claimDate",
                                "type": "uint128"
                            }
                        ],
                        "name": "data",
                        "type": "tuple"
                    }
                ]
            },
            {
                "name": "getDetails",
                "inputs": [],
                "outputs": [
                    {
                        "components": [
                            {
                                "name": "maxTokens",
                                "type": "uint128"
                            },
                            {
                                "name": "totalSold",
                                "type": "uint128"
                            },
                            {
                                "name": "totalClaimed",
                                "type": "uint128"
                            },
                            {
                                "name": "startTime",
                                "type": "uint128"
                            },
                            {
                                "name": "endTime",
                                "type": "uint128"
                            },
                            {
                                "name": "floatProcent",
                                "type": "uint128"
                            }
                        ],
                        "name": "data",
                        "type": "tuple"
                    }
                ]
            },
            {
                "name": "rootTokenAddress",
                "inputs": [],
                "outputs": [
                    {
                        "name": "rootTokenAddress",
                        "type": "address"
                    }
                ]
            },
            {
                "name": "mAffiliates",
                "inputs": [],
                "outputs": [
                    {
                        "name": "mAffiliates",
                        "type": "map(uint32,address)"
                    }
                ]
            }
        ],
        "data": [
            {
                "key": 1,
                "name": "_randomNonce",
                "type": "uint256"
            }
        ],
        "events": []
    },
    tvc: "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",
    code: "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",
    codeHash: "48d985a52e5338c3d6267a1bb8411699855d5a3bd5dd28d487e0760412da334d",
};
module.exports = { FidosafeDAOContract };