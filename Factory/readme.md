# CREATE opcode is used by default when deploying smart contracts. The deployed contract address is calculated like this. 

keccak256(senderAddress, nonce) 
 

# CREATE2 opcode is introduced later and allows you to predetermine the contract address. Contract address is computed like this. 

keccak256(0xFF, senderAddress, salt, bytecode) 
 

0xFF parameter is a constant to prevent collision with CREATE opcode. 

salt parameter is a value sender sends when deploying contract. 

bytecode parameter is, you probably guessed it, the bytecode of the smart contract you want to deploy. 

If you want to predetermine the contract address before deploying, you can simply loop through different salt values and select the one you like (or want). 

A great example of using CREATE2 can be seen here. Application of CREATE2 opcode

This also uses CREATE opcode behind to create the contract. 

(Link of the above: https://ethereum.stackexchange.com/questions/101336/what-is-the-benefit-of-using-create2-to-create-a-smart-contract ) 

 

 

 

# Difference between create and create2: 

Say you have a website that generates new wallets for new users and these new users don't know anything about Metamask or how wallets work. You want users to use that new wallet address to receive and transfer funds (similar to coinbase). Right now you'd generate a new private/public key pair and store it on your server's database. When someone finally receives funds and then they want to transfer it out means you'll have to sign the transaction on their behalf. This is a risk because you have custody of all the users private keys. Instead of storing all these keys on your server, what if you only stored one key pair that belonged to you (the site owner) and can transact on user's behalf to bootstrap them? Well this is possible. The way this work is: you create a smart contract for each user which they'll use as their wallet (people send funds to the smart contract and the smart contracts can send funds out) and then the smart contract whitelists your [site owner] key in to be able to transact on behalf of the user (similar to a multsig wallet). Now when someones sends funds to the users smart contract wallet, you [the site owner] can transfer funds out by invoking a transfer function of the smart contract. Now if you notice the problem is that the site owner will have to deploy a new smart contract for every new user that signs up. That means the site owner will have to pay gas for each deploy and it's going to get expensive really quick. What if you can get the smart contracts address without actually deploying it and only deploy it once there's already funds in it? Well right now (before create2) you can't do that because you'll only know that what the smart contract address is till after you've deployed it. BUT with CREATE2 you can predetermine what that smart contract address will be without actually deploying the smart contract. This means that on the website you can display a new smart contract address as the user's wallet for each new user and it won't cost the site owner anything. Many users won't ever receive funds in their wallet and that's fine because you never deployed the contract so gas costs were never wasted. For the users that do end up receiving funds sent to their new address, they can send the funds out to a different account or exchange by calling the transfer function of the smart contract. The smart contract is not deployed yet though, so anyone can deploy it. I say anyone because the smart contract already has funds in it which means in the contract constructor you can calculate the gas used and refund msg.sender, so the site owner can deploy it on the users behalf and not pay for gas because the user is essentially paying for their own gas with the funds someone had sent them. Now that the contract is deployed the user can transfer the funds by having the whitelisted account in the smart contract (the site owner) do it and get refunded for gas for doing that too. At any point the user can generate a new key pair outside of the website and whitelist this new key pair and remove the site owner whitelisted key from the smart contract. This means the user now has full control of their own smart contract wallet and the site owner can no longer transact on the users behalf which is a great thing because the user that didn't know anything about wallets when they first signed up now has custody of their own wallet. It solves a big usability problem. 

[From_Open_Zeppelin] https://docs.openzeppelin.com/cli/2.8/deploying-with-create2 

[From_Open_Zeppelin] https://docs.openzeppelin.com/cli/2.8/deploying-with-create2 



# Another Explanation of Clone Factory from other resources:
1. soliditydevelopers.com: https://soliditydeveloper.com/clonefactory
2. Github Repository: https://github.com/optionality/clone-factory
3. [must_read] https://blockchain-academy.hs-mittweida.de/courses/solidity-coding-beginners-to-intermediate/lessons/solidity-11-coding-patterns/topic/factory-clone/
4. https://blog.logrocket.com/cloning-solidity-smart-contracts-factory-pattern/


 
