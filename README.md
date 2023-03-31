# quorun-7-node-devlopment
Step 1: 
    Clone the github repo https://github.com/jpmorganchase/quorum-examples.git
    Go to quorum-example folder using cd quorum-examples
    By default Quorum Network is  created using Istanbul BFT consensus. In order to change consensus configuration to Raft, we need to run the command QUORUM_CONSENSUS=raft
    If we have low system configuration then we can even reduce the number of nodes . Just we need to go to the file examples/7nodes/permissioned-nodes.json and delete the nodes encodes address.
    Now to start the docker container run command sudo docker-compose up -d  with 7nodes running.
    Run command docker ps to check the status of each of the 7 nodes. Wait until all your nodes and tx managers are healthy(This may take several minutes)
    