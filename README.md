# quorun-7-node-devlopment
### Step 1: Quorum nodes setup
- Clone the github repo [quorum 7 nodes](https://github.com/jpmorganchase/quorum-examples.git)
- Go to quorum-example folder using `cd quorum-examples`
- By default Quorum Network is  created using Istanbul BFT consensus. In order to change consensus configuration to Raft, we need to run the command `QUORUM_CONSENSUS=raft`
- If we have low system configuration then we can even reduce the number of nodes. Just we need to go to the file `examples/7nodes/permissioned-nodes.json` and delete the nodes encodes address.
- Now to start the docker container run command `sudo docker-compose up -d`  with 7nodes running.
- Run command `docker ps` to check the status of each of the 7 nodes. Wait until all your nodes and tx managers are healthy(This may take several minutes)
 ### Step 2: Deploying Smart Contract 
 - For Deploying smart contract on any node, we need to enter into geth javascript console of particular node. run below command to enter into console.
 - `docker exec -it quorum-examples_node1_1 geth attach /qdata/dd/geth.ipc` Here `quorum-examples_node1_1` is the container id of node1. above command opens up node1 geth console. now we can do operations from this console alone
 - - In case of Mac run the following command `docker exec -it quorum-examples-node1-1 geth attach /qdata/dd/geth.ipc` 
 - Run `private-contract.js` that deploys our Smart Contract on node1. It contains abi and bytecode of our smart contract.
 - Run command `loadScript('/examples/private-contract.js')`
 - This will return the transaction hash and the Contract address of the deployed contract, which is used to call the functions of the contract just deployed.
