import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("StreamingToken", function () {
    async function deployFixture() {
        const [owner, addr1, addr2] = await ethers.getSigners();
    
        const ExampleBEP20 = await ethers.getContractFactory("StreamingToken");
        const exampleBEP20 = await ExampleBEP20.deploy();
    
        return { exampleBEP20, owner, addr1, addr2 };
      }
    
      it("Should have correct name and symbol", async function () {
        const { exampleBEP20 } = await loadFixture(deployFixture);
        const name = await exampleBEP20.name();
        expect(name).to.equal("StreamingToken");
        const symbol = await exampleBEP20.symbol();
        expect(symbol).to.equal("STK");
      });
    
      it("Should assign the total supply of tokens to the owner", async function () {
        const { exampleBEP20, owner } = await loadFixture(deployFixture);
        const ownerBalance = await exampleBEP20.balanceOf(owner.address);
        const totalSupply = ethers.parseEther("1000000");
        expect(await exampleBEP20.totalSupply()).to.equal(totalSupply);
        expect(ownerBalance).to.equal(totalSupply);
      });


    
});
