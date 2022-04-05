
struct NFT {
    var nftId: String
    var walletId: String
    var network: String
    var contract: String
    var tokenId: String
    var transactionHash: String
    var filename: String
    var ipfsHash: String
    var createdAt: String
    var openseaURL: String
    var royalties: Royalties?
    var metadata: Metadata
    var isListed: Bool
    var listPrice: Double
}
