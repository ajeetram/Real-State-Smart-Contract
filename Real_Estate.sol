// SPDX-License-Identifier: MIT

pragma solidity^0.8.18;

import "https://github.com/Openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract RealEstate
{
    using SafeMath for uint256;
    
    struct Property
    {
        uint256 Price;
        address owner;
        bool forSale;
        string Pro_name;
        string pro_description;
        string location;
    }

    mapping(uint256=>Property) public properties;

    uint256[] public property_Ids;

    event Property_Sold(uint256 property_Ids);

    function listPropertyForSale(uint256 _property_Ids, uint256 _price, string memory _name, string memory _description, string memory _location)
    public 
    {
        Property memory newProperty = Property({Price:_price, owner:msg.sender,forSale:true,name:_name, _description:_description});
    

    properties[_property_Ids] = newProperty;
    property_Ids.push(_property_Ids);
    }

    function buyProperty(uint256 _property_Ids) public payable
    {
        Property storage property = properties[_property_Ids];

        require(property.forSale,"Propery is no for sale");
        require(property.price<=msg.value,"Insuffiecient funds");

        property.owner = msg.sender;
        property.forSale = false;
         payable(Property.owner).transfer(property.price);

         emit Property_Sold(_property_Ids);
    } 

}
