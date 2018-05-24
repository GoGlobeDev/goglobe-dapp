# Project Contracts #

## Core Asset Contracts ##

GOG核心资产合约，包括GOGToken ERC20， 资产登记 ERC721 和资产分割登记 三个合约。

### GOG ERC20 Token ###

**Name:** GOGToken

**Desc:** ERC20 Token for goglobe ecosystem

**Interface:** DetailedERC20, StandardToken, Ownable

[详细文档](contracts/GOGToken.md)

### GOG ERC721 Token ###

**Name:** GOGAsset

**Desc:** ERC721 Token for rentable rooms in goglobe ecosystem.

**Interface:** ERC721, Ownerable, safeMath

[详细文档](contracts/GOGAsset.md)

**Name:** GOGAssetShare

**Desc:** ERC721 Token for part of rentable rooms in goglobe ecosystem.

**Interface:** ERC721, Ownerable, safeMath

[详细文档](contracts/GOGAssetShare.md)

## GOG Identifier Contracts ##

GOG授权合约，包括GOGBoard 合约。

**Name:** GOGBoard

**Desc:** Decentralized Organization of goglobe ecosystem.

**Interface:**

[详细文档](contracts/GOGBoard.md)
