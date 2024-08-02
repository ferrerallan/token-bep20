# protocoin-bep20-hardhat

Project of Module 2: Lesson 07 (2.0).
A new BEP-20 token.

## How to Test

1. Install dependencies with npm install.
2. copy .env.example as .env
3. fill .env variables
4. Run tests with npm test.

## How to Deploy

1. npm install
2. copy .env.example as .env
3. fill .env variables
4. npx hardhat run scripts/deploy.ts --network <network>
5. npx hardhat verify --network <network> <contract>

## Important Notes

After deploy, take note of the contract address to import the token in your MetaMask.