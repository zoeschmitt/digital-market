//
//  NFT.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation


struct NFT: Identifiable, Codable {
    var id: UUID
    var walletId: String
    var network: String
    var contract: String
    var tokenId: String
    var transactionHash: String
    var filename: String
    var ipfsHash: String
    var createdAt: String
    var openseaURL: String
    var royalties: [Royalties]
    var metadata: Metadata
    var isListed: Bool
    var listPrice: Double

    init(id: UUID = UUID(), walletId: String, network: String, contract: String, tokenId: String, transactionHash: String, filename: String, ipfsHash: String, createdAt: String, openseaURL: String, royalties: [Royalties], metadata: Metadata, isListed: Bool, listPrice: Double) {
        self.id = id
        self.walletId = walletId
        self.network = network
        self.contract = contract
        self.tokenId = tokenId
        self.transactionHash = transactionHash
        self.filename = filename
        self.ipfsHash = ipfsHash
        self.createdAt = createdAt
        self.openseaURL = openseaURL
        self.royalties = royalties
        self.metadata = metadata
        self.isListed = isListed
        self.listPrice = listPrice
    }

    private enum CodingKeys: String, CodingKey {
        case id = "nftId", walletId, network, contract, tokenId, transactionHash, filename, ipfsHash, createdAt, openseaURL, royalties, metadata, isListed, listPrice
    }
}

extension NFT {
    var mintedDate: String {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let formattedDate = isoDateFormatter.date(from: createdAt) ?? Date()
        return formattedDate.formatted(.dateTime.month(.abbreviated).day().year())
    }
}

extension NFT {
    struct Metadata: Codable {
        var name: String
        var description: String
        var image: String
        var nft: String
    }
}

extension NFT {
    struct Royalties: Codable {
        var recipient: String
        var percentage: Double

        init(recipient: String, percentage: Double) {
            self.recipient = recipient
            self.percentage = percentage
        }
    }
}

extension NFT {
    enum NFTError: Error {
        case tooLarge
        case insufficientFunds
    }
}

extension NFT {
    static let mockData: [NFT] =
    [
        NFT(id: UUID(uuidString: "2e7c2a7f-a121-48c2-bdd6-7d52d3fb474e") ?? UUID(), walletId: "BEA6CD7F-3457-47AC-B3A3-DCAB414F1F38", network: "maticmum", contract: "0x91dFa85B7795bdBcae325D3A73639b175CeC7175", tokenId: "1", transactionHash: "0xe4754bde02f1d98d28234c8e7988ab25fdfb45d74555f20d32c679ff9826e9b3", filename: "pug.png", ipfsHash: "bafyreig4wvcyy4dozouuunmajhxyakvaere24szdpdezezjbx7dl3ypmxi", createdAt: "2022-04-03T00:51:13.579Z", openseaURL: "https://testnets.opensea.io/assets/mumbai/0x91dFa85B7795bdBcae325D3A73639b175CeC7175/1", royalties: [Royalties(recipient: "", percentage: 2)], metadata: Metadata(name: "NFT", description: "NFT", image: "https://ipfs.io/ipfs/bafybeicq32kh4tfcx5ax2lp5htlosjfc3vwloturp4dg4sldq2eugtrlke/medhi-messrro.jpeg", nft: ""), isListed: true, listPrice: 12),
//        NFT(id: UUID(uuidString: "2e7c2a7f-a122-48c2-bdd6-7d52d3fb474e") ?? UUID(), walletId: "3940a896-a332-466b-93ca-8e28041613be", network: "maticmum", contract: "0x91dFa85B7795bdBcae325D3A73639b175CeC7175", tokenId: "1", transactionHash: "0xe4754bde02f1d98d28234c8e7988ab25fdfb45d74555f20d32c679ff9826e9b3", filename: "pug.png", ipfsHash: "bafyreig4wvcyy4dozouuunmajhxyakvaere24szdpdezezjbx7dl3ypmxi", createdAt: "2022-04-03T00:51:13.579Z", openseaURL: "https://testnets.opensea.io/assets/mumbai/0x91dFa85B7795bdBcae325D3A73639b175CeC7175/1", royalties: [Royalties(recipient: "", percentage: 2)], metadata: Metadata(name: "NFT", description: "NFT", image: "https://ipfs.io/ipfs/bafybeicq32kh4tfcx5ax2lp5htlosjfc3vwloturp4dg4sldq2eugtrlke/medhi-messrro.jpeg", nft: ""), isListed: false, listPrice: 0),
//        NFT(id: UUID(uuidString: "2e7c2b7f-a121-48c2-bdd6-7d52d3fb474e") ?? UUID(), walletId: "3940a896-a332-466b-93ca-8e28041613be", network: "maticmum", contract: "0x91dFa85B7795bdBcae325D3A73639b175CeC7175", tokenId: "1", transactionHash: "0xe4754bde02f1d98d28234c8e7988ab25fdfb45d74555f20d32c679ff9826e9b3", filename: "pug.png", ipfsHash: "bafyreig4wvcyy4dozouuunmajhxyakvaere24szdpdezezjbx7dl3ypmxi", createdAt: "2022-04-03T00:51:13.579Z", openseaURL: "https://testnets.opensea.io/assets/mumbai/0x91dFa85B7795bdBcae325D3A73639b175CeC7175/1", royalties: [Royalties(recipient: "", percentage: 2)], metadata: Metadata(name: "NFT", description: "NFT", image: "https://ipfs.io/ipfs/bafybeicq32kh4tfcx5ax2lp5htlosjfc3vwloturp4dg4sldq2eugtrlke/medhi-messrro.jpeg", nft: ""), isListed: false, listPrice: 0),
//        NFT(id: UUID(uuidString: "2e7c5a7f-a121-48c2-bdd6-7d52d3fb474e") ?? UUID(), walletId: "3940a896-a332-466b-93ca-8e28041613be", network: "maticmum", contract: "0x91dFa85B7795bdBcae325D3A73639b175CeC7175", tokenId: "1", transactionHash: "0xe4754bde02f1d98d28234c8e7988ab25fdfb45d74555f20d32c679ff9826e9b3", filename: "pug.png", ipfsHash: "bafyreig4wvcyy4dozouuunmajhxyakvaere24szdpdezezjbx7dl3ypmxi", createdAt: "2022-04-03T00:51:13.579Z", openseaURL: "https://testnets.opensea.io/assets/mumbai/0x91dFa85B7795bdBcae325D3A73639b175CeC7175/1", royalties: [Royalties(recipient: "", percentage: 2)], metadata: Metadata(name: "NFT", description: "NFT", image: "https://ipfs.io/ipfs/bafybeicq32kh4tfcx5ax2lp5htlosjfc3vwloturp4dg4sldq2eugtrlke/medhi-messrro.jpeg", nft: ""), isListed: false, listPrice: 0),
//        NFT(id: UUID(uuidString: "2e7c2a7f-a123-48c2-bdd6-7d52d3fb474e") ?? UUID(), walletId: "3940a896-a332-466b-93ca-8e28041613be", network: "maticmum", contract: "0x91dFa85B7795bdBcae325D3A73639b175CeC7175", tokenId: "1", transactionHash: "0xe4754bde02f1d98d28234c8e7988ab25fdfb45d74555f20d32c679ff9826e9b3", filename: "pug.png", ipfsHash: "bafyreig4wvcyy4dozouuunmajhxyakvaere24szdpdezezjbx7dl3ypmxi", createdAt: "2022-04-03T00:51:13.579Z", openseaURL: "https://testnets.opensea.io/assets/mumbai/0x91dFa85B7795bdBcae325D3A73639b175CeC7175/1", royalties: [Royalties(recipient: "", percentage: 2)], metadata: Metadata(name: "NFT", description: "NFT", image: "https://ipfs.io/ipfs/bafybeicq32kh4tfcx5ax2lp5htlosjfc3vwloturp4dg4sldq2eugtrlke/medhi-messrro.jpeg", nft: ""), isListed: false, listPrice: 0),
    ]
}
