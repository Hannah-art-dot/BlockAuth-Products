// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

/*
BlockAuth Products Smart Contract
Developed by Hannah, 2026
Purpose: Track authentic products and prevent counterfeits using blockchain
*/

contract BlockAuthProducts {

    uint256 sellerCount;
    uint256 productCount;

    struct Seller {
        uint256 id;
        bytes32 name;
        bytes32 brand;
        bytes32 code;
        uint256 phone;
        bytes32 manager;
        bytes32 location;
    }

    mapping(uint => Seller) public sellerList;

    struct Product {
        uint256 id;
        bytes32 serialNumber;
        bytes32 name;
        bytes32 brand;
        uint256 price;
        bytes32 status;
    }

    mapping(uint256 => Product) public products;
    mapping(bytes32 => uint256) public productMap;
    mapping(bytes32 => bytes32) public productsManufactured;
    mapping(bytes32 => bytes32) public productsForSale;
    mapping(bytes32 => bytes32) public productsSold;
    mapping(bytes32 => bytes32[]) public productsWithSeller;
    mapping(bytes32 => bytes32[]) public productsWithConsumer;
    mapping(bytes32 => bytes32[]) public sellersWithManufacturer;

    // SELLER SECTION
    function addSeller(
        bytes32 _manufacturerId,
        bytes32 _sellerName,
        bytes32 _sellerBrand,
        bytes32 _sellerCode,
        uint256 _sellerPhone,
        bytes32 _sellerManager,
        bytes32 _sellerLocation
    ) public {
        sellerList[sellerCount] = Seller(
            sellerCount,
            _sellerName,
            _sellerBrand,
            _sellerCode,
            _sellerPhone,
            _sellerManager,
            _sellerLocation
        );
        sellerCount++;

        sellersWithManufacturer[_manufacturerId].push(_sellerCode);
    }

    function viewSellers() public view returns (
        uint256[] memory, bytes32[] memory, bytes32[] memory, bytes32[] memory, uint256[] memory, bytes32[] memory, bytes32[] memory
    ) {
        uint256[] memory ids = new uint256[](sellerCount);
        bytes32[] memory names = new bytes32[](sellerCount);
        bytes32[] memory brands = new bytes32[](sellerCount);
        bytes32[] memory codes = new bytes32[](sellerCount);
        uint256[] memory phones = new uint256[](sellerCount);
        bytes32[] memory managers = new bytes32[](sellerCount);
        bytes32[] memory locations = new bytes32[](sellerCount);
        
        for(uint i = 0; i < sellerCount; i++){
            ids[i] = sellerList[i].id;
            names[i] = sellerList[i].name;
            brands[i] = sellerList[i].brand;
            codes[i] = sellerList[i].code;
            phones[i] = sellerList[i].phone;
            managers[i] = sellerList[i].manager;
            locations[i] = sellerList[i].location;
        }
        return(ids, names, brands, codes, phones, managers, locations);
    }

    // PRODUCT SECTION
    function addProduct(
        bytes32 _manufacturerID,
        bytes32 _productName,
        bytes32 _productSN,
        bytes32 _productBrand,
        uint256 _productPrice
    ) public {
        products[productCount] = Product(productCount, _productSN, _productName, _productBrand, _productPrice, "Available");
        productMap[_productSN] = productCount;
        productCount++;
        productsManufactured[_productSN] = _manufacturerID;
    }

    function viewProducts() public view returns (
        uint256[] memory, bytes32[] memory, bytes32[] memory, bytes32[] memory, uint256[] memory, bytes32[] memory
    ) {
        uint256[] memory ids = new uint256[](productCount);
        bytes32[] memory SNs = new bytes32[](productCount);
        bytes32[] memory names = new bytes32[](productCount);
        bytes32[] memory brands = new bytes32[](productCount);
        uint256[] memory prices = new uint256[](productCount);
        bytes32[] memory status = new bytes32[](productCount);
        
        for(uint i = 0; i < productCount; i++){
            ids[i] = products[i].id;
            SNs[i] = products[i].serialNumber;
            names[i] = products[i].name;
            brands[i] = products[i].brand;
            prices[i] = products[i].price;
            status[i] = products[i].status;
        }
        return(ids, SNs, names, brands, prices, status);
    }

    // NEW FEATURE: Get total products count
    function totalProducts() public view returns(uint256) {
        return productCount;
    }
}

