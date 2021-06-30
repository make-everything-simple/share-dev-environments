# Utility commands for MongoDB Development

#==============================================#
# Install mongodb tools
#==============================================#
alias mongo_local="open 'https://docs.mongodb.com/manual/installation'"
alias mongo_cloud="open 'https://www.mongodb.com/cloud/atlas?tck=docs_vsce'"
alias mongo_shell="open 'https://docs.mongodb.com/mongodb-shell/'"
alias mongo_database_tools="open 'https://docs.mongodb.com/database-tools/'"
alias mongo_cli="open 'https://docs.mongodb.com/mongocli/stable/'"
alias mongo_compass="open 'https://docs.mongodb.com/compass/current/'"
alias mongo_kubernetes_operators="open 'https://docs.mongodb.com/kubernetes-operator/stable/#'"
alias mongo_cs="open 'https://docs.mongodb.com/manual/reference/connection-string/'"
alias mongo_conf="echo '...
sharding:
  clusterRole: configsvr
replication:
  replSetName: m103-csrs
security:
  keyFile: /var/mongodb/pki/m103-keyfile
net:
  bindIp: localhost,192.168.1.112
  port: 26001
systemLog:
  destination: file
  path: /var/mongodb/db/csrs1/csrs1.log
  logAppend: true
processManagement:
  fork: true
storage:
  dbPath: /var/mongodb/db/csrs1
...'"

mongo_tools() {
  beginf
  echo 'MongoDB is a document database designed for ease of development and scaling. Host on Local'
  echo '\u2460 MongoDB Standalone (Community | Enterprise) : is a hosted MongoDB service option in the local, On-premises whitch requires more operations from DevSecOps'
  echo '\u2461 MongoDB Atlas: is a hosted MongoDB service option in the cloud which requires no installation overhead and offers a free tier to get started.'
  echo '\u2462 MongoDB Shell: is a modern command-line, the quickest way to connect, configure, query, and work with your MongoDB database. It is fully functioning JavaScript interpreter.'
  echo '\u2463 MongoDB Database Tools: are a collection of command-line utilities for working with a MongoDB deployment.'
  echo '\u2464 MongoDB CLI: is a tool for managing your MongoDB cloud services, like Atlas, Cloud Manager, and Ops Manager, quickly interact with your MongoDB deployments from the command line for easier testing and scripting.'
  echo '\u2465 MongoDB Compass: is a GUI for MongoDB that allows you to make smarter decisions about document structure, querying, indexing, document validation, and more. Commercial subscriptions include technical support for MongoDB Compass.'
  echo '\u2466 MongoDB Kubernetes Operators: are application-specific controllers that extend the Kubernetes API to create, configure, and manage instances of stateful applications such as databases.'
  endf
}

mongo_setup() {
    beginf
    # Guide developers choose the desired tools
    readonly supported_tools='
    (1) MongoDB Standalone, (2) MongoDB Atlas, (3) MongoDB Shell,
    (4) MongoDB Database Tools, (5) MongoDB CLI, (6) MongoDB Compass, 
    (7) MongoDB Kubernetes Operators, (0) More Info tools'
    echo 'Which tools do you want install: $supported_tools?'
    read name
  
    # Process input from developer
    if [[ "${name}" = "1" ]]; then
        mongo_local
    elif [[ "${name}" = "2" ]]; then
        mongo_cloud
    elif [[ "${name}" = "3" ]]; then
        mongo_shell
    elif [[ "${name}" = "4" ]]; then
        mongo_database_tools
    elif [[ "${name}" = "5" ]]; then
        mongo_cli
    elif [[ "${name}" = "6" ]]; then
        mongo_compass
    elif [[ "${name}" = "7" ]]; then
        mongo_kubernetes_operators
    elif [[ "${name}" = "0" ]]; then
        mongo_tools
    else
        echo 'Your input must be $supported_tools'
    fi
    endf
}

mongo_terms() {
    beginf
    echo 'Daemon: is a computer program that runs as a background process, rather than an interactive user (ie: syslogd, sshd, mongod)'
    echo 'Mongod: is the main deamon process for MongoDB'
    echo 'SRV Record: is a specification of data in the DNS defining the location, i.e., the hostname and port number, of servers for specified services'
    echo 'Connection String: is the defining connections between applications and MongoDB type $ mongo_cs for more detail'
    echo 'Document Databases: are both natural and flexible for developers to work with, Built around JSON-like documents'
    echo 'BSON: a bridge between binary representation and JSON format optimize for speed, space, and flexibility. More data types: Number(Int, long, float...), Date, RawBinary'
    groupf
    echo 'Replica set: a set of server that each server has a complete copy of the database to provide High Availability and Data Durability'
    echo 'Sharding: is a database architecture pattern related to horizontal partitioning, a way to partition a database into many servers'
    echo 'Cluster: is a set of computers that work together so that they can be viewed as a single system'
    echo 'MQL: MongoDB Query Language'
    echo 'Aggregation: support complex queries across collections'
    groupf
    echo 'ACID: is a set of properties of database transactions intended to guarantee data validity despite errors, power failures, and other mishaps'
    echo 'CAP theorem: states that it is impossible for a distributed data store to simultaneously provide more than two out of the following three guarantees'
    echo 'Consistency: Every read receives the most recent write or an error'
    echo 'Availability: Every request receives a (non-error) response, without the guarantee that it contains the most recent write'
    echo 'Partition tolerance: The system continues to operate despite an arbitrary number of messages being dropped (or delayed) by the network between nodes'
    endf
}

mongo_repl() {
    beginf
    echo 'Core components|Terms of a Replica Set'
    groupf
    echo '\u2460 Primary node: is the only member in the replica set that receives write operations, then records the operations on the primary oplog'
    echo '\u2461 Secondary node: only replicate data from Primary node via asynchronous mechanism'
    echo '\u2462 ABITER node: vote only can not become a primary node in case of failover, and hold no data'
    echo '\u2463 Election: is the process of voting for a secondary node become primary node support failover bases on raft Algorithm'
    groupf
    echo 'Step by step to create a Replica Set'
    groupf
    echo '\u2460 Setup config file for each node and start: $ sudo mongo -f */node*.conf'
    echo '\u2461 Connect to primary node: $ mongo --port PRIMARY_NODE_PORT'
    echo '\u2462 Initiate Replica set: $ rs.initiate()'
    echo '\u2463 Create a user admin [Optional]: $ use admin & db.createUser({user: USER, pwd: PASS, roles: [{role: "root", db: "admin"}]})'
    echo '\u2464 Connect to the entire replica set as admin: $db.auth(USER,PASS)'
    echo '\u2465 Add nodes to Replica set: $rs.add(NODE2) & rs.add(NODE3) to remove just run rs.remove(NODEn)'
    echo '\u2466 Verify by checking status: $rs.isMaster() | $ rs.status()'
    echo '\u2467 Force an election [Optional]: simulate stop primary node to trigger an election for secondary become primary'
    endf
}

mongo_shard() {
    beginf
    echo 'Core components of a Shared Cluster'
    groupf
    echo '\u2460 Shard: contains a subset of the sharded data. Each shard can be deployed as a replica set.'
    echo '\u2461 Config Server: stores metadata and configuration settings for the cluster, and assign a primary shard for each database'
    echo '\u2462 mongos: acts as a query router, providing an interface between client applications and the sharded cluster'
    groupf
    echo 'Step by step to create a Shared Cluster'
    groupf
    echo "\u2460 Config Server -> Create a Replicate set: set 'sharding.clusterRole: configsvr' in config file"
    echo "\u2461 Shard: Create one or more Replicate set as you want: set 'sharding.clusterRole: shardsvr' in config file"
    echo "\u2462 mongos: Setup config file mongos.conf 'sharding.configDB: LIST_CONFIG_SERVER_ADDRESS' at #1"
    echo '\u2463 Start the mongos server: $ sudo mongos -f mongos.conf'
    echo '\u2464 Connect to mongos: $ mongo --port PORT -u USER -p PASS --authenticationDatabase admin'
    echo '\u2465 Add new shard (primary node at #2) to cluster from mongos: $ sh.addShard(PRIMARY_NODE_SHARD)'
    echo '\u2466 Check sharding status [Optional]: $ sh.status()'
    endf
}

mongo_help() {
    beginf
    echo 'mongo_tools: check essential tools for mongodb development'
    echo 'mongo_setup: show list tools with the guideline to install'
    echo 'mongo_terms: explains common terms in Database especially MongoDB'
    echo 'mongo_repl: show setting up for a replica set in mongodb'
    echo 'mongo_shard: show setting up a shared cluster in mongodb'
    echo 'mongo_conf: show example format for a node config'
    endf
}